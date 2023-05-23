import { HttpStatus, Injectable } from '@nestjs/common';
import { ForbiddenException, HttpException } from '@nestjs/common/exceptions';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';
import { PrismaService } from '../prisma/prisma.service';
import {
  CreateCommentDto,
  CreateLikeDto,
  CreatePostDto,
} from './dto/create-post.dto';

@Injectable()
export class PostService {
  constructor(private prisma: PrismaService) {}

  async create(createPostDto: CreatePostDto) {
    //upload postImg to Cloudinary

    //recieve ImageUrl

    //save post to database
    try {
      const post = await this.prisma.post.create({
        data: {
          caption: createPostDto.caption,
          postImg: createPostDto.postImg,
          visibility: createPostDto.visibility,

          groupId: createPostDto.groupId,
        },
      });
      return post;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        throw new ForbiddenException('Publishing Stopped');
      }
      throw error;
    }
  }

  // async findAll() {
  //   const posts = await this.prisma.post.findMany({
  //     include: { group: true },
  //   });
  //   return posts;
  // }

  // async findAll(userId: string) {
  //   const posts = await this.prisma.post.findMany({
  //     include: { group: true },
  //   });

  //   // Get the count of postLikes and comments for each post
  //   const postsWithCounts = await Promise.all(
  //     posts.map(async (post) => {
  //       const postLikesCount = await this.prisma.like.count({
  //         where: { postId: post.id },
  //       });

  //       const commentsCount = await this.prisma.comment.count({
  //         where: { postId: post.id },
  //       });

  //       const liked = await this.prisma.like.findFirst({
  //         where: {postId: post.id, creatorId: userId}
  //       })

  //       return { ...post, postLikesCount, commentsCount };
  //     }),
  //   );

  //   return postsWithCounts;
  // }

  async findAll(userId: string) {
    const posts = await this.prisma.post.findMany({
      include: { group: true },
      orderBy: {
        createdAt: 'desc',
      },
    });

    // Get the count of postLikes and comments for each post
    const postsWithCounts = await Promise.all(
      posts.map(async (post) => {
        const postLikesCount = await this.prisma.like.count({
          where: { postId: post.id },
        });

        const commentsCount = await this.prisma.comment.count({
          where: { postId: post.id },
        });

        const liked = await this.prisma.like.findFirst({
          where: { postId: post.id, creatorId: userId },
        });

        // Check if liked is null or not and set isLiked accordingly
        const isLiked = !!liked;

        // Add the isLiked property to the post object
        return { ...post, postLikesCount, commentsCount, isLiked };
      }),
    );

    return postsWithCounts;
  }

  //has error
  async findPostsByVisibility(userId: string) {
    const posts = await this.prisma.post.findMany({
      select: {},
      where: {},
    });
    return posts;
  }

  async createComment(createCommentDto: CreateCommentDto, userId: string) {
    const comment = await this.prisma.comment.create({
      data: {
        creatorId: userId,
        postId: createCommentDto.postId,
        comment: createCommentDto.comment,
      },
    });
    return comment;
  }

  async findComments(postId: string) {
    const comments = await this.prisma.comment.findMany({
      where: {
        postId: postId,
      },
      include: { creator: true },
    });
    return comments;
  }

  async likePost(createLikeDto: CreateLikeDto, userId: string) {
    const check = await this.prisma.like.findUnique({
      where: {
        creatorId_postId: {
          creatorId: userId,
          postId: createLikeDto.postId,
        },
      },
    });
    if (check == null) {
      const like = await this.prisma.like.create({
        data: {
          creatorId: userId,
          postId: createLikeDto.postId,
        },
      });
      return like;
    } else {
      await this.prisma.like.delete({
        where: {
          creatorId_postId: {
            creatorId: check.creatorId,
            postId: check.postId,
          },
        },
      });
      throw new HttpException('Like deleted', HttpStatus.NO_CONTENT);
    }
  }

  async getLikesForPost(postId: string) {
    const numOfLikes = await this.prisma.like.findMany({
      where: {
        postId,
      },
    });
    return numOfLikes;
  }
  async findAllLikes(postId: string) {
    const likes = await this.prisma.like.findMany({
      where: {
        postId,
      },
      include: { creator: true },
    });
    return likes;
  }

  // findOne(id: number) {
  //   return `This action returns a #${id} post`;
  // }

  // update(id: number, updatePostDto: UpdatePostDto) {
  //   return `This action updates a #${id} post`;
  // }

  // remove(id: number) {
  //   return `This action removes a #${id} post`;
  // }
}

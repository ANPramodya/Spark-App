import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';
import { PrismaService } from '../prisma/prisma.service';
import { domainToASCII } from 'url';
import { CreateGroupDto, GroupAddMembers } from './dto/create-group.dto';
import { UpdateGroupDto } from './dto/update-group.dto';

@Injectable()
export class GroupService {
  constructor(private prisma: PrismaService) {}

  async create(
    createGroupDto: CreateGroupDto,
    groupAddMembers: GroupAddMembers,
    userId: string,
  ) {
    try {
      const group = await this.prisma.group.create({
        data: {
          groupName: createGroupDto.groupName,
          creatorId: userId,
          groupImage: createGroupDto.groupImage,
          groupDescription: createGroupDto.groupDescription,
        },
      });
      await this.prisma.usersOnGroups.create({
        data: {
          userId: userId,
          groupId: group.id,
          userRole: 'member',
        },
      });

      return group;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code == 'P2002') {
          throw new ForbiddenException('Something went wrong');
        }
      }
      throw error;
    }
  }

  async findAll() {
    const groups = await this.prisma.group.findMany();
    return groups;
  }

  async findGroupById(id: string) {
    const group = await this.prisma.usersOnGroups.findMany({
      where: {
        groupId: id,
      },
      include: {
        user: true,
      },
    });

    return group;
  }

  async findGroupPosts(id: string) {
    const posts = await this.prisma.post.findMany({
      where: {
        groupId: id,
      },
    });

    // Iterate through the array and add 'isLiked' key with value 'false' to each object
    const postsWithIsLiked = posts.map((post) => ({ ...post, isLiked: false }));

    return postsWithIsLiked;
  }

  // async findGroupPosts(id: string) {
  //   //return { msg: id };
  //   const posts = await this.prisma.post.findMany({
  //     where: {
  //       groupId: id,
  //     },
  //   });
  //   return posts;

  // }

  //has error
  async findGroupByName(name: string) {
    const group = await this.prisma.group.findUnique({
      where: {},
    });
    return group;
  }

  async update(groupId: string, updateGroupDto: UpdateGroupDto) {
    const updateGroup = await this.prisma.group.update({
      where: {
        id: groupId,
      },
      data: {
        groupName: updateGroupDto.groupName,
        groupDescription: updateGroupDto.groupDescription,
      },
    });
    return { updateGroup };
  }
  async addMembers(groupAddMembers: GroupAddMembers) {
    const addGroupMembers = await this.prisma.usersOnGroups.create({
      data: {
        userId: groupAddMembers.userId,
        groupId: groupAddMembers.groupId,
        userRole: 'member',
      },
    });

    return { groupAddMembers };
  }

  //9280ac16-00cb-499f-81cb-0b1282aca108
}

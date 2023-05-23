import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseInterceptors,
  BadRequestException,
} from '@nestjs/common';
import { PostService } from './post.service';
import {
  CreatePostDto,
  CreateCommentDto,
  CreateLikeDto,
} from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import { GetUser } from '../auth/decorator';
import { FileInterceptor } from '@nestjs/platform-express';
import { Req, UploadedFile, UseGuards } from '@nestjs/common/decorators';
import { UploadService } from './upload.service';
import { JwtGuard } from '../auth/guard';
import { User } from '@prisma/client';
//const getStream = require('into-stream');

@Controller('post')
export class PostController {
  constructor(
    private readonly postService: PostService,
    private uploadService: UploadService,
  ) {}

  @Post('create')
  @UseInterceptors(FileInterceptor('filename'))
  async create(@Body() createPostDto: CreatePostDto) {
    return this.postService.create(createPostDto);
  }

  @Post('image')
  //@uploadFile('filename')
  //@UseInterceptors(FileInterceptor('filename', { fileFilter: imageFileFilter }))
  @UseInterceptors(FileInterceptor('filename'))
  async uploadFile(@Req() req: any, @UploadedFile() file: Express.Multer.File) {
    if (!file || req.fileValidationError) {
      throw new BadRequestException(
        'Invalid file provided, [image files allowed]',
      );
    }
    //const buffer = file.buffer;
    // const stream = getStream(file.buffer);
    return await this.uploadService.addFile(file);
    //return file.originalname;
  }

  @UseGuards(JwtGuard)
  @Post('comment')
  createComment(
    @Body() createCommentDto: CreateCommentDto,
    @GetUser() user: User,
  ) {
    const userId = user.id;
    return this.postService.createComment(createCommentDto, userId);
  }

  @Get(':id')
  findAll(@Param('id') userId: string) {
    return this.postService.findAll(userId);
  }

  @Get('comment/:id')
  findComments(@Param('id') postId: string) {
    return this.postService.findComments(postId);
  }

  //show posts according to visible levels has error
  @Get('home/:id')
  findPostsByVisibility(@Param('id') userId: string) {
    return this.postService.findPostsByVisibility(userId);
  }

  @UseGuards(JwtGuard)
  @Post('like')
  likePost(@Body() createLikeDto: CreateLikeDto, @GetUser() user: User) {
    const userId = user.id;
    return this.postService.likePost(createLikeDto, userId);
  }
  @Get('likes/:id')
  findAllLikes(@Param('id') postId: string) {
    return this.postService.findAllLikes(postId);
  }
  // @Get(':id')
  // findOne(@Param('id') id: string) {
  //   return this.postService.findOne(+id);
  // }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updatePostDto: UpdatePostDto) {
  //   return this.postService.update(+id, updatePostDto);
  // }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.postService.remove(+id);
  // }
}

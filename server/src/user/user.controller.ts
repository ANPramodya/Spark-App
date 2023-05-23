import {
  BadRequestException,
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Post,
  Put,
  Query,
  Req,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { User } from '@prisma/client';
import { Request } from 'express';
import { GetUser } from '../auth/decorator';
import { JwtGuard } from '../auth/guard';
import { UserService } from './user.service';
import { FileInterceptor } from '@nestjs/platform-express';
import { UploadService } from '../post/upload.service';
import {
  UpdateCoverPhotoDto,
  UpdateProfilePicDto,
} from './dto/update-user.dto';

@UseGuards(JwtGuard)
@Controller('users')
export class UserController {
  constructor(
    private readonly userService: UserService,
    private readonly uploadService: UploadService,
  ) {}

  @Get('me')
  getMe(@GetUser() user: User) {
    return user;
  }

  @Get()
  findAll() {
    return this.userService.findAll();
  }

  @Get('search')
  searchUsers(@Query('q') searchTerm: string) {
    return this.userService.searchUsers(searchTerm);
  }

  @Patch('updateProfilePic/:id')
  editProfilePic(
    @Param('id') id: string,
    @Body() updateProfilePicDto: UpdateProfilePicDto,
  ) {
    return this.userService.editProfilePic(id, updateProfilePicDto);
  }
  @Patch('updateCoverPhoto/:id')
  editCoverPhoto(
    @Param('id') id: string,
    @Body() UpdateCoverPhotoDto: UpdateCoverPhotoDto,
  ) {
    return this.userService.editCoverPhoto(id, UpdateCoverPhotoDto);
  }

  @Post('profilePic')
  @UseInterceptors(FileInterceptor('filename'))
  async uploadFile(@Req() req: any, @UploadedFile() file: Express.Multer.File) {
    if (!file || req.fileValidationError) {
      throw new BadRequestException(
        'Invalid file provided, [image files allowed]',
      );
    }

    return await this.uploadService.addFile(file);
  }
}

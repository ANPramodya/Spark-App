import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { UploadService } from '../post/upload.service';
import { S3Service } from '../s3/s3.service';
import { FileService } from '../post/file.service';

@Module({
  controllers: [UserController],
  providers: [UserService, UploadService, FileService, S3Service],
  imports: [],
})
export class UserModule {}

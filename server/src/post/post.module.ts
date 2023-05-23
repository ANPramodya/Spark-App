import { Module } from '@nestjs/common';
import { PostService } from './post.service';
import { PostController } from './post.controller';
import { MulterModule } from '@nestjs/platform-express';
import { UploadService } from './upload.service';
import { FileService } from './file.service';
import { S3Module } from '../s3/s3.module';
import { S3Service } from '../s3/s3.service';

@Module({
  imports: [S3Module],
  controllers: [PostController],
  providers: [PostService, UploadService, FileService, S3Service],
})
export class PostModule {}

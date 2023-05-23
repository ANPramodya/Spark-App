import { Injectable } from '@nestjs/common';
import { S3Service } from '../s3/s3.service';
import { FileService } from './file.service';

@Injectable()
export class UploadService {
  constructor(
    private readonly fileService: FileService,
    private s3Service: S3Service,
  ) {}

  async addAvatar(imageBuffer: Buffer, fileName: string) {
    return await this.fileService.uploadFile(imageBuffer, fileName);
  }

  async addFile(file: Express.Multer.File) {
    const key = `${file.fieldname}${Date.now()}`;
    const imageUrl = await this.s3Service.uploadFile(file, key);
    return imageUrl;
  }
}

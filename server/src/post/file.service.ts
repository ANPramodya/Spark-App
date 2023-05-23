import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { S3 } from 'aws-sdk';

@Injectable()
export class FileService {
  constructor(private config: ConfigService) {}

  public async uploadFile(imageBuffer: Buffer, fileName: string) {
    const s3 = new S3();
    return await s3
      .upload({
        Bucket: this.config.get('AWS_BUCKET')!,
        Body: imageBuffer,
        Key: fileName,
      })
      .promise();
  }

  public async deleteFile(key: string) {
    const s3 = new S3();
    return await s3
      .deleteObject({
        Bucket: this.config.get('AWS_BUCKET'),
        Key: key,
      })
      .promise();
  }
}

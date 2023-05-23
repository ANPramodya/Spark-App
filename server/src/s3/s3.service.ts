import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Express } from 'express';
import {
  PutObjectCommandInput,
  PutObjectCommandOutput,
  PutObjectCommand,
  S3Client,
} from '@aws-sdk/client-s3';

@Injectable()
export class S3Service {
  private logger = new Logger(S3Service.name);
  private region: string;
  private s3: S3Client;

  constructor(private config: ConfigService) {
    this.region = this.config.get('S3_REGION');
    this.s3 = new S3Client({
      region: this.region,
      credentials: {
        secretAccessKey: config.get('AWS_SECRET_ACCESS_KEY'),
        accessKeyId: config.get('AWS_ACCESS_KEY_ID'),
      },
    });
  }

  async listBucket() {}

  async uploadFile(file: Express.Multer.File, key: string) {
    const bucket = this.config.get('S3_BUCKET');
    const input: PutObjectCommandInput = {
      Body: file.buffer,
      Bucket: bucket,
      Key: key,
      ContentType: file.mimetype,
      ACL: 'public-read',
    };
    try {
      const response: PutObjectCommandOutput = await this.s3.send(
        new PutObjectCommand(input),
      );
      if (response.$metadata.httpStatusCode == 200) {
        return `https://${bucket}.s3.${this.region}.amazonaws.com/${key}`;
      }
      throw new Error('Image not Saved to s3');
    } catch (error) {
      this.logger.error(`Cannot save file inside s3`, error);
      throw error;
    }
  }
}

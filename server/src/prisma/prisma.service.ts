import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaClient } from '@prisma/client';
import { config } from 'process';

@Injectable()
export class PrismaService extends PrismaClient {
  constructor(config: ConfigService) {
    super({
      datasources: {
        db: {
          url: config.get('DATABASE_URL'),
        },
      },
    });
  }

  cleanDb() {
    return this.$transaction([
      this.like.deleteMany(),
      this.comment.deleteMany(),
      this.message.deleteMany(),
      this.post.deleteMany(),
      this.usersOnGroups.deleteMany(),
      this.group.deleteMany(),
      this.user.deleteMany(),
    ]);
  }
}

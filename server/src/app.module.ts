import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { PrismaModule } from './prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { GroupModule } from './group/group.module';
import { PostModule } from './post/post.module';
import { ChatGateway } from './chat/chat.gateway';
import { AlertGateway } from './alert/alert.gateway';
import { AlertController } from './alert/alert.controller';
import { S3Module } from './s3/s3.module';
import { MessagesModule } from './messages/messages.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    UserModule,
    PrismaModule,
    GroupModule,
    PostModule,

    S3Module,

    MessagesModule,
  ],
  providers: [ChatGateway, AlertGateway],
  controllers: [AlertController],
})
export class AppModule {}

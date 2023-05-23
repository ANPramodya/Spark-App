import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { SignupDto, SigninDto } from './dto';
import * as argon from 'argon2';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwt: JwtService,
    private config: ConfigService,
  ) {}

  async signup(dto: SignupDto) {
    //generqte the hashed password
    const hash = await argon.hash(dto.password);

    try {
      //save the new user in the db
      const user = await this.prisma.user.create({
        data: {
          hash,
          isOnline: dto.isOnline,
          firstName: dto.firstName,
          lastName: dto.lastName,
          university: dto.university,
          faculty: dto.faculty,

          uniEmail: dto.uniEmail,
          username: dto.username,
        },
        // select: {
        //   id: true,
        //   email: true,
        //   createdAt: true,
        // },
      });

      //return the token instead of saved user
      return this.signToken(user.id, user.email);
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code == 'P2002') {
          throw new ForbiddenException('Credentials Taken');
        }
      }
      throw error;
    }
  }

  async signin(dto: SigninDto) {
    //find user by email
    const user = await this.prisma.user.findUnique({
      where: {
        uniEmail: dto.uniEmail,
      },
    });
    //if user does not exsis throw exception
    if (!user) {
      throw new ForbiddenException('Credentials Incorrect');
    }

    //compare passwords
    const pwMatches = await argon.verify(user.hash, dto.password);
    //if password incorrect throw exception
    if (!pwMatches) {
      throw new ForbiddenException('Credentails Incorrect');
    }

    await this.prisma.user.update({
      where: {
        uniEmail: dto.uniEmail,
      },
      data: {
        isOnline: 'true',
      },
    });
    //return token instead of user
    return this.signToken(user.id, user.email);
  }

  async signToken(
    userId: string,
    email: string,
  ): Promise<{ access_token: string }> {
    const payload = {
      sub: userId,
      email,
    };
    const secret = this.config.get('JWT_SECRET');

    const token = await this.jwt.signAsync(payload, {
      expiresIn: '12h',
      secret: secret,
    });

    return {
      access_token: token,
    };
  }

  async signout(userId: string) {
    const user = await this.prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        isOnline: 'false',
      },
    });
    return { msg: 'user signed out' };
  }
}

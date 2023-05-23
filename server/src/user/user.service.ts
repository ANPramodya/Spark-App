import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import {
  UpdateCoverPhotoDto,
  UpdateProfilePicDto,
} from './dto/update-user.dto';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async findAll() {
    const users = await this.prisma.user.findMany({
      where: {
        isOnline: 'true',
      },
    });
    return users;
  }

  async searchUsers(searchTerm: string) {
    const users = await this.prisma.user.findMany({
      where: {
        OR: [
          {
            firstName: {
              mode: 'insensitive',
              contains: searchTerm,
            },
          },
          {
            lastName: {
              mode: 'insensitive',
              contains: searchTerm,
            },
          },
        ],
      },
    });
    return users;

    // const users = await this.prisma.$queryRaw`SELECT *
    //   FROM "User"
    //   WHERE ("firstName") LIKE ('%${searchTerm.replace(/'/g, "''")}%')
    //     OR ("lastName") LIKE lower('%${searchTerm.replace(/'/g, "''")}%')
    //     OR email LIKE lower('%${searchTerm.replace(/'/g, "''")}%')
    // `;
    // return users;
  }

  async editProfilePic(
    userId: string,
    updateProfilePicDto: UpdateProfilePicDto,
  ) {
    const profilePic = await this.prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        profilePic: updateProfilePicDto.imageUrl,
      },
    });
    return profilePic;
  }

  async editCoverPhoto(
    userId: string,
    updateCoverPhotoDto: UpdateCoverPhotoDto,
  ) {
    const profilePic = await this.prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        coverImg: updateCoverPhotoDto.imageUrl,
      },
    });
    return profilePic;
  }
}

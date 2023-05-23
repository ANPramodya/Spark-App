import { IsString, IsNotEmpty } from 'class-validator';

export class UpdateProfilePicDto {
  @IsNotEmpty()
  @IsString()
  imageUrl: string;
}

export class UpdateCoverPhotoDto {
  @IsNotEmpty()
  @IsString()
  imageUrl: string;
}

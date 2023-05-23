import { IsNotEmpty, IsNumber, IsString, IsOptional } from 'class-validator';

export class CreateGroupDto {
  @IsString()
  @IsNotEmpty()
  groupName: string;

  @IsString()
  groupDescription: string;

  // @IsString()
  // creatorId: string;

  @IsOptional()
  groupImage: string;
}

export class GroupAddMembers {
  @IsString()
  groupId: string;

  @IsString()
  userId: string;

  @IsString()
  userRole: string;
}

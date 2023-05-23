import { PartialType } from '@nestjs/mapped-types';
import { IsNotEmpty, IsNumber, IsString } from 'class-validator';
import { CreateGroupDto } from './create-group.dto';

export class UpdateGroupDto extends PartialType(CreateGroupDto) {
  @IsString()
  @IsNotEmpty()
  groupName?: string;

  @IsString()
  groupDescription?: string;
}

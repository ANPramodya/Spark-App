import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  ParseIntPipe,
  UseGuards,
} from '@nestjs/common';
import { GroupService } from './group.service';
import { CreateGroupDto, GroupAddMembers } from './dto/create-group.dto';
import { UpdateGroupDto } from './dto/update-group.dto';
import { GetUser } from '../auth/decorator';
import { JwtGuard } from '../auth/guard';
import { User } from '@prisma/client';

@Controller('group')
export class GroupController {
  constructor(private readonly groupService: GroupService) {}

  @UseGuards(JwtGuard)
  @Post('create')
  create(
    @Body() createGroupDto: CreateGroupDto,
    groupAddMembers: GroupAddMembers,
    @GetUser() user: User,
  ) {
    const userId = user.id;
    return this.groupService.create(createGroupDto, groupAddMembers, userId);
  }

  @Get()
  findAll() {
    return this.groupService.findAll();
  }

  @Get(':id')
  findGroupById(@Param('id') id: string) {
    return this.groupService.findGroupById(id);
  }
  @Get('/posts/:id')
  findGroupPosts(@Param('id') id: string) {
    return this.groupService.findGroupPosts(id);
  }

  //has error
  @Get(':name')
  findGroupByName(@Param('name') name: string) {
    return this.groupService.findGroupByName(name);
  }

  @Patch(':id')
  update(
    @GetUser('id') userId: string,
    @Param('id', ParseIntPipe) groupId: string,
    @Body() updateGroupDto: UpdateGroupDto,
  ) {
    return this.groupService.update(groupId, updateGroupDto);
  }

  @Post('addMembers')
  addMembers(@Body() groupAddMembers: GroupAddMembers) {
    return this.groupService.addMembers(groupAddMembers);
  }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.groupService.remove(+id);
  // }
}

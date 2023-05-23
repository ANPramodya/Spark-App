import { Controller, Post } from '@nestjs/common';
import { HttpCode } from '@nestjs/common/decorators/http/http-code.decorator';
import { Body } from '@nestjs/common/decorators/http/route-params.decorator';
import { AlertGateway } from './alert.gateway';

@Controller('alert')
export class AlertController {
  constructor(private alertGateway: AlertGateway) {}

  @Post()
  @HttpCode(200)
  sendToAll(@Body() dto: { message: string }) {
    this.alertGateway.sendToAll(dto.message);
    return dto;
  }
}

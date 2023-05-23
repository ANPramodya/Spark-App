import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { ApiBody } from '@nestjs/swagger/dist';

export const GetGroup = createParamDecorator(
  (data: string | undefined, ctx: ExecutionContext) => {
    const request: Express.Request = ctx.switchToHttp().getRequest();
    if (data) {
      return request.user[data];
    }
    return request.user;
  },
);

export const uploadFile =
  (filename: string = 'file'): MethodDecorator =>
  (target: any, propertyKey, descriptor: PropertyDescriptor) => {
    ApiBody({
      schema: {
        type: 'object',
        properties: {
          [filename]: {
            type: 'string',
            format: 'binary',
          },
        },
      },
    })(target, propertyKey, descriptor);
  };

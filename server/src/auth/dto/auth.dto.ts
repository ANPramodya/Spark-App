import { IsEmail, IsNotEmpty, IsString, IsBoolean } from 'class-validator';

export class SignupDto {
  @IsNotEmpty()
  @IsString()
  password: string;

  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsString()
  university: string;

  @IsString()
  faculty: string;

  @IsString()
  isOnline: string;

  @IsEmail()
  uniEmail: string;

  @IsString()
  username: string;
}

export class SigninDto {
  @IsEmail()
  @IsNotEmpty()
  uniEmail: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}

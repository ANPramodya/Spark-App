import {
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  IsUrl,
} from 'class-validator';

export class CreatePostDto {
  @IsNotEmpty()
  @IsString()
  caption: string;

  @IsOptional()
  postImg: string;

  @IsString()
  groupId: string;

  @IsString()
  visibility: string;
}

export class CreateCommentDto {
  @IsString()
  @IsNotEmpty()
  postId: string;

  @IsString()
  @IsNotEmpty()
  comment: string;
}

export class CreateLikeDto {
  @IsString()
  @IsNotEmpty()
  postId: string;
}

// {
// 	"caption": "Jingle Bells",
// 	"postImg": "https://images.unsplash.com/photo-1671282102737-b1fe779a6a05?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
// 	"visibility": "public",
// 	"groupId": "bb9d93ec-415a-4a95-8b06-126e2376787f"
// }

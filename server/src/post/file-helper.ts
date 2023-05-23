import { extname } from 'path';

export const imageFileFilter = (
  req: any,
  file: Express.Multer.File,
  callback: any,
) => {
  if (!file.originalname.match(/\.(jpg|jpeg|png|gif)$/)) {
    req.fileValidationError = 'only image Files Allowed';
    return callback(null, false);
  }
  callback(null, true);
};

export const editFileName = (req, file, callback) => {
  const name = file.originalName.split('.')[0];
  const fileExtName = extname(file.originalName);
  const randomName = Array(4)
    .fill(null)
    .map(() => Math.round(Math.random() * 16).toString(16))
    .join('');
  callback(null, `${name}-${randomName}${fileExtName}`);
};

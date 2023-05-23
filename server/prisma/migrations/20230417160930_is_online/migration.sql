/*
  Warnings:

  - Added the required column `isOnline` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "isOnline" BOOLEAN NOT NULL,
ALTER COLUMN "email" DROP NOT NULL,
ALTER COLUMN "department" DROP NOT NULL;

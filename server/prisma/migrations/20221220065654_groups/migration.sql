/*
  Warnings:

  - Added the required column `postLikes` to the `Post` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Post" ADD COLUMN     "postComments" TEXT[],
ADD COLUMN     "postLikes" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Group" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" INTEGER NOT NULL,
    "groupName" TEXT NOT NULL,
    "groupDescription" TEXT,
    "members" TEXT[],

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

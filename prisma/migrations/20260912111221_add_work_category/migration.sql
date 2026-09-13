-- CreateTable
CREATE TABLE `WorkCategory` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `sortOrder` INTEGER NOT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AlterTable
-- Reconciles pre-existing out-of-band drift on `content.type` (WORK value) and
-- replaces the untracked `workCategory` enum column with a proper FK.
ALTER TABLE `content`
    MODIFY `type` ENUM('ABOUT', 'SERVICE', 'CAREER', 'NOTICE_PUBLIC', 'NOTICE_INTERNAL', 'WORK') NOT NULL,
    DROP COLUMN `workCategory`,
    ADD COLUMN `workCategoryId` VARCHAR(191) NULL;

-- CreateIndex
CREATE INDEX `Content_workCategoryId_idx` ON `content`(`workCategoryId`);

-- AddForeignKey
ALTER TABLE `content` ADD CONSTRAINT `Content_workCategoryId_fkey` FOREIGN KEY (`workCategoryId`) REFERENCES `WorkCategory`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

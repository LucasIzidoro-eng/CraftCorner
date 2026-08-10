-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           12.0.2-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para shortz_db
CREATE DATABASE IF NOT EXISTS `shortz_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `shortz_db`;

-- Copiando estrutura para tabela shortz_db.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `comments_ibfk_411` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_412` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.comments: ~4 rows (aproximadamente)
INSERT INTO `comments` (`id`, `content`, `user_id`, `video_id`, `created_at`, `updated_at`) VALUES
	(1, 'comentário de teste pra ver se tudo está fucnionando', 1, 1, '2026-04-29 16:24:59', '2026-04-29 16:24:59'),
	(2, 'Aaarrr!!! Hoist the colours!', 2, 1, '2026-04-29 16:26:57', '2026-04-29 16:26:57'),
	(3, 'eita ferro!', 3, 1, '2026-05-14 18:39:08', '2026-05-14 18:39:08'),
	(4, 'poxa que legal!', 3, 1, '2026-05-14 23:26:36', '2026-05-14 23:26:36');

-- Copiando estrutura para tabela shortz_db.follows
CREATE TABLE IF NOT EXISTS `follows` (
  `follower_id` int(11) NOT NULL,
  `following_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`follower_id`,`following_id`),
  UNIQUE KEY `follows_followingId_followerId_unique` (`follower_id`,`following_id`),
  UNIQUE KEY `idx_unique_follow` (`follower_id`,`following_id`),
  KEY `following_id` (`following_id`),
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`following_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.follows: ~1 rows (aproximadamente)
INSERT INTO `follows` (`follower_id`, `following_id`, `created_at`, `updated_at`) VALUES
	(2, 1, '2026-06-15 15:27:38', '2026-06-15 15:27:38');

-- Copiando estrutura para tabela shortz_db.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_like` (`user_id`,`video_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `likes_ibfk_413` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_414` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.likes: ~3 rows (aproximadamente)
INSERT INTO `likes` (`id`, `user_id`, `video_id`, `created_at`, `updated_at`) VALUES
	(3, 2, 1, '2026-04-29 16:27:02', '2026-04-29 16:27:02'),
	(4, 1, 1, '2026-05-05 00:12:53', '2026-05-05 00:12:53'),
	(6, 3, 1, '2026-05-14 18:39:13', '2026-05-14 18:39:13');

-- Copiando estrutura para tabela shortz_db.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient_id` int(11) NOT NULL,
  `actor_id` int(11) DEFAULT NULL,
  `type` enum('like','comment','follow','new_video','report_status') NOT NULL,
  `message` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_notifications_recipientId` (`recipient_id`),
  KEY `actor_id` (`actor_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.notifications: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela shortz_db.playlists
CREATE TABLE IF NOT EXISTS `playlists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 0,
  `videos_count` int(11) DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.playlists: ~2 rows (aproximadamente)
INSERT INTO `playlists` (`id`, `title`, `description`, `is_public`, `videos_count`, `user_id`, `created_at`, `updated_at`) VALUES
	(3, 'Videos mais curtidos', 'isso é um teste', 1, 1, 2, '2026-06-15 13:03:18', '2026-06-15 18:22:37'),
	(4, 'Lista 2', 'Coisas não tão legais, mas ainda assim legais', 1, 1, 2, '2026-06-15 18:21:47', '2026-06-15 18:25:05');

-- Copiando estrutura para tabela shortz_db.playlist_videos
CREATE TABLE IF NOT EXISTS `playlist_videos` (
  `playlist_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  PRIMARY KEY (`playlist_id`,`video_id`),
  UNIQUE KEY `playlist_videos_videoId_playlistId_unique` (`playlist_id`,`video_id`),
  UNIQUE KEY `idx_unique_playlist_video` (`playlist_id`,`video_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `playlist_videos_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playlist_videos_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.playlist_videos: ~2 rows (aproximadamente)
INSERT INTO `playlist_videos` (`playlist_id`, `video_id`) VALUES
	(3, 1),
	(4, 1);

-- Copiando estrutura para tabela shortz_db.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `status` enum('pending','reviewed','resolved') DEFAULT 'pending',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_report` (`user_id`,`video_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `reports_ibfk_29` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reports_ibfk_30` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.reports: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela shortz_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT 'default-profile.png',
  `is_blocked` tinyint(1) DEFAULT 0,
  `is_admin` tinyint(1) DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `followers_count` int(11) DEFAULT 0,
  `following_count` int(11) DEFAULT 0,
  `videos_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_username` (`username`),
  UNIQUE KEY `idx_unique_email` (`email`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.users: ~3 rows (aproximadamente)
INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `bio`, `profile_picture`, `is_blocked`, `is_admin`, `created_at`, `updated_at`, `followers_count`, `following_count`, `videos_count`) VALUES
	(1, 'jacksparrow', 'jacksparrow@gmail.com', '$2b$10$xEmBnncjm9YYiffno.LC2usvbIzzY6tLd2dQt04.TED9SUwUkzPcK', 'Jack Sparrow', 'Arrr!', 'profile-1-1781524519243-134549970.jpg', 0, 1, '2026-04-08 20:21:38', '2026-06-15 15:27:38', 1, 0, 0),
	(2, 'davyjones', 'davyjones@gmail.com', '$2b$10$6QMW3mEVTc6VIWdxM0j6weRb3FxOcQmpFzBJK.F2Js1ChjZ8sX3Dm', 'Davy Jones', 'Gosto de rum quente', 'profile-2-1780531277334-505778599.png', 1, 0, '2026-04-29 16:26:11', '2026-07-15 15:38:35', 0, 1, 0),
	(3, 'barbanegra', 'barbanegra@gmail.com', '$2b$10$GUVlWlM3G.knj7PbFP0lBek9gGJYVsXYUOq7y9xNImxaiLNLY1UIe', 'Barba Negra', NULL, 'default-profile.png', 0, 0, '2026-05-14 18:34:51', '2026-05-14 18:34:51', 0, 0, 0);

-- Copiando estrutura para tabela shortz_db.videos
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `video_path` varchar(255) NOT NULL,
  `thumbnail_path` varchar(255) NOT NULL,
  `views` int(11) DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `likes_count` int(11) DEFAULT 0,
  `comments_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_videos_user_id` (`user_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Copiando dados para a tabela shortz_db.videos: ~1 rows (aproximadamente)
INSERT INTO `videos` (`id`, `title`, `description`, `video_path`, `thumbnail_path`, `views`, `user_id`, `created_at`, `updated_at`, `likes_count`, `comments_count`) VALUES
	(1, 'Veja só que coisa!', 'Isso é uma descrição sobre o vídeo. Parece ser um vídeo legalzinho.', 'video-1775679773796-489201207.mp4', 'thumbnail-1775679773863-339024383.png', 113, 1, '2026-04-08 20:22:53', '2026-06-15 18:24:58', 3, 4);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- ============================================================
-- filipomor.com — schema do banco de dados
-- Charset utf8mb4 (suporte completo a acentos e emojis)
-- Engine InnoDB (suporte a foreign keys)
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- admin_users — login do painel administrativo
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admin_users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login_at DATETIME NULL,
    UNIQUE KEY uniq_username (username),
    UNIQUE KEY uniq_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- media — todos os uploads (imagens, PDFs de anexos, etc.)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS media (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    path VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255) NULL,
    mime_type VARCHAR(100) NOT NULL,
    uploaded_by INT UNSIGNED NULL,
    uploaded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uploaded_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- pages — Home / Sobre / Contato (bilíngue: pt-BR e en-CA)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pages (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(100) NOT NULL,
    locale VARCHAR(5) NOT NULL COMMENT 'pt-BR ou en-CA',
    title VARCHAR(255) NOT NULL,
    content MEDIUMTEXT NOT NULL COMMENT 'Markdown',
    meta_description VARCHAR(320) NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_slug_locale (slug, locale)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- research_projects — pesquisa atual (bilíngue)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS research_projects (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(150) NOT NULL,
    locale VARCHAR(5) NOT NULL,
    title VARCHAR(255) NOT NULL,
    summary VARCHAR(500) NULL,
    content MEDIUMTEXT NOT NULL COMMENT 'Markdown',
    display_order INT NOT NULL DEFAULT 0,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_slug_locale (slug, locale)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- experience — atuação na indústria (bilíngue)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS experience (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(150) NOT NULL,
    locale VARCHAR(5) NOT NULL,
    organization VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NULL COMMENT 'NULL = posição atual',
    description MEDIUMTEXT NOT NULL COMMENT 'Markdown',
    display_order INT NOT NULL DEFAULT 0,
    UNIQUE KEY uniq_slug_locale (slug, locale)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- courses — ensino (somente português)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS courses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    institution VARCHAR(255) NOT NULL,
    term VARCHAR(20) NOT NULL COMMENT 'ex: 2026/1',
    description MEDIUMTEXT NULL COMMENT 'Markdown',
    is_current TINYINT(1) NOT NULL DEFAULT 0,
    display_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- blog_posts — blog nativo (idioma livre por post)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS blog_posts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(200) NOT NULL,
    locale VARCHAR(5) NOT NULL COMMENT 'idioma deste post especifico',
    title VARCHAR(255) NOT NULL,
    excerpt VARCHAR(500) NULL,
    content MEDIUMTEXT NOT NULL COMMENT 'Markdown + shortcodes de video',
    cover_image_id INT UNSIGNED NULL,
    status ENUM('draft','published') NOT NULL DEFAULT 'draft',
    published_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_slug_locale (slug, locale),
    FOREIGN KEY (cover_image_id) REFERENCES media(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- tags + blog_post_tags — tags do blog (relacional)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tags (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    UNIQUE KEY uniq_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS blog_post_tags (
    post_id INT UNSIGNED NOT NULL,
    tag_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (post_id, tag_id),
    FOREIGN KEY (post_id) REFERENCES blog_posts(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- post_attachments — PDFs/slides anexados a um post
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS post_attachments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    post_id INT UNSIGNED NOT NULL,
    media_id INT UNSIGNED NOT NULL,
    label VARCHAR(255) NOT NULL,
    display_order INT NOT NULL DEFAULT 0,
    FOREIGN KEY (post_id) REFERENCES blog_posts(id) ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- settings — configurações gerais (chave/valor)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS settings (
    `key` VARCHAR(100) NOT NULL PRIMARY KEY,
    `value` TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------
-- Seed inicial de settings (ajuste os valores depois)
-- ------------------------------------------------------------
INSERT INTO settings (`key`, `value`) VALUES
    ('site_title', 'Filipo Novo Mór'),
    ('contact_email', ''),
    ('linkedin_url', ''),
    ('lattes_url', '')
ON DUPLICATE KEY UPDATE `value` = VALUES(`value`);

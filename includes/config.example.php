<?php
/**
 * config.example.php
 * ------------------------------------------------------------
 * Copie este arquivo para "config.php" (que fica no .gitignore)
 * e preencha com as credenciais reais. NUNCA commite config.php.
 * ------------------------------------------------------------
 */

// --- Banco de dados ---
define('DB_HOST', 'localhost');       // na Kinghost costuma ser 'localhost'
define('DB_NAME', 'nome_do_banco');
define('DB_USER', 'usuario_do_banco');
define('DB_PASS', 'senha_do_banco');
define('DB_CHARSET', 'utf8mb4');

// --- Ambiente ---
define('APP_ENV', 'local'); // 'local' ou 'production'
define('APP_DEBUG', true);  // false em produção — nunca exibir erros pro publico

// --- Idiomas ---
define('DEFAULT_LOCALE', 'pt-BR');
define('AVAILABLE_LOCALES', ['pt-BR', 'en-CA']);

// --- Uploads ---
define('UPLOAD_MAX_BYTES', 10 * 1024 * 1024); // 10MB
define('UPLOAD_DIR', __DIR__ . '/../public/assets/uploads/');

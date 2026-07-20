# filipomor.com — CMS sob medida

Site pessoal dinâmico, PHP 8.2 + MySQL, hospedado na Kinghost (Windows/IIS).

## Stack

- PHP 8.2 (server-rendered, sem framework)
- MySQL (PDO)
- Tailwind CSS (build local) + Alpine.js
- Markdown para conteúdo (posts, páginas, projetos) + highlight.js (código) + KaTeX (matemática)

## Estrutura

```
admin/        painel administrativo (login + CRUD)
includes/     código compartilhado (config, db, models, helpers)
templates/    views do site público
public/       document root (aponta pro domínio) — único ponto acessível pelo navegador
database/     schema.sql
```

## Setup local

1. Suba um MySQL local (Docker, Homebrew, ou DBngin).
2. Copie `includes/config.example.php` para `includes/config.php` e preencha com as
   credenciais locais.
3. Rode `database/schema.sql` no seu MySQL local (via PhpStorm Database tool).
4. Aponte o PHP embutido ou seu servidor local pra pasta `public/`.

## Deploy na Kinghost

1. Confirme se o plano permite acesso remoto ao MySQL (painel Kinghost).
   - Se sim: conecte o PhpStorm direto na Kinghost e rode `schema.sql` de lá.
   - Se não: use o phpMyAdmin do painel, ou um script PHP de migração descartável.
2. Suba os arquivos via FTP/SFTP (ou configure Deployment no PhpStorm pra sincronizar
   automaticamente).
3. `includes/config.php` na Kinghost tem suas PRÓPRIAS credenciais de produção —
   nunca é o mesmo arquivo do ambiente local, e nunca vai pro Git.

## Segurança

- `config.php` está no `.gitignore` — nunca commitar credenciais.
- Todas as queries usam prepared statements (PDO).
- Display de erros desligado em produção (`APP_DEBUG = false`).

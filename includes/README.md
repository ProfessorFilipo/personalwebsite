# /includes

Código compartilhado entre o site público e o admin.

- `config.php` — credenciais reais (NÃO versionado, veja config.example.php)
- `db.php` — conexão PDO única, reaproveitada em toda a aplicação
- `Router.php` — roteamento simples do front controller
- `models/` — uma classe por tabela (Page, Course, ResearchProject, Experience, BlogPost, Media)
- `helpers/` — markdown.php (parser + shortcodes de video), i18n.php (troca de idioma)

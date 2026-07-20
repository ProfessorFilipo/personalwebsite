# /public

Este é o document root que aponta pro domínio (pasta www da Kinghost).
Tudo fora desta pasta não é acessível diretamente pelo navegador.

- index.php — front controller (todas as rotas passam por aqui)
- assets/css — CSS gerado pelo Tailwind (build local, upload do arquivo final)
- assets/js — Alpine.js, highlight.js, KaTeX
- assets/uploads — imagens/anexos enviados pelo admin (precisa ser writable)
- web.config — regras de URL rewrite do IIS (equivalente ao .htaccess do Apache)

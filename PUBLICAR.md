# Como colocar no ar — 5 minutos

## Se você já criou o repositório privado

Faça nesta ordem, para não expor nada nem por um minuto:

1. **Renomeie o repositório**, se o nome atual disser algo pessoal.
   **Settings → General → Repository name → Rename.** Sugestão: `trilha-de-estudos`.
2. **Substitua os arquivos** pelos desta pasta (todos os anteriores podem ser sobrescritos).
   Página principal do repositório → **Add file → Upload files** → arraste → **Commit changes**.
3. Só então **torne público**: **Settings → Danger Zone → Change visibility → Make public**,
   digite o nome do repositório, marque *"I have read and understand these effects"* e
   confirme em **Make this repository public**.
4. Ligue o Pages: **Settings → Pages → Source: Deploy from a branch → Branch `main` ·
   `/ (root)` → Save**.

O repositório precisa ser público: no plano gratuito o GitHub Pages não publica a partir de
repositório privado.

---

## Se estiver começando do zero

1. `github.com/new` → nome `trilha-de-estudos` → **Public** → **não marque nada** em
   "Initialize this repository" → **Create repository**.
2. Clique em **uploading an existing file** e arraste **os arquivos de dentro desta pasta** —
   não a pasta: `index.html`, `manifest.webmanifest`, `sw.js`, os quatro `icon-*.png`,
   `README.md`, `PUBLICAR.md`, `.nojekyll`.
3. **Commit changes**.
4. **Settings → Pages → Deploy from a branch → `main` · `/ (root)` → Save**.
5. Espere 1 a 2 minutos e recarregue. O endereço aparece nessa tela.

> O `.nojekyll` não aparece no Finder porque o macOS esconde arquivos que começam com ponto.
> Aperte **⌘ + Shift + .** para mostrá-los. Sem ele o site funciona igual.

---

## Alternativa pelo terminal

Esta pasta já é um repositório git com um commit feito. Dê dois cliques em
`PUBLICAR-AUTOMATICO.command`, cole o endereço do repositório e siga. Depois faça o passo do
Pages acima.

Ou, manualmente, dentro desta pasta:

```bash
git remote add origin https://github.com/SEU-USUARIO/trilha-de-estudos.git
git branch -M main
git push -u origin main
```

---

## Instalar no iPhone / iPad

1. Abra o endereço **no Safari** — precisa ser o Safari.
2. Toque em **Compartilhar** (quadrado com seta para cima).
3. Role e toque em **Adicionar à Tela de Início**.

Da segunda abertura em diante funciona **sem internet**.

---

## Quando você mexer no conteúdo depois

1. Edite o `index.html`.
2. **Aumente a versão do cache no `sw.js`** — troque `trilha-estudos-v8` por `v9`.
   Sem isso o celular continua mostrando a versão antiga.
3. Suba a alteração.
4. No celular, feche e abra o app duas vezes para ele pegar a versão nova.

---

## Se der errado

**Página em branco ou aparece o README** — o `index.html` foi parar dentro de uma subpasta.
Reenvie com os arquivos na raiz.

**"There isn't a GitHub Pages site here"** — ou não passaram os 2 minutos, ou o **Save** do
Pages não foi clicado.

**A opção de branch não aparece** — nenhum arquivo foi enviado ainda.

**O push falha com erro de histórico** — o repositório foi criado com README. Ou use a rota do
navegador, ou rode `git pull --rebase origin main` antes do push.

#!/bin/bash
# Publica a Trilha de Estudos no GitHub Pages, do começo ao fim.
# Feito para quem nunca usou terminal. Basta dar dois cliques.

cd "$(dirname "$0")" || exit 1
set -o pipefail

VERDE=$'\033[0;32m'; VERM=$'\033[0;31m'; AMAR=$'\033[0;33m'; NEG=$'\033[1m'; FIM=$'\033[0m'
ok(){   echo "${VERDE}✔${FIM} $1"; }
erro(){ echo "${VERM}✖${FIM} $1"; }
info(){ echo "${AMAR}→${FIM} $1"; }
titulo(){ echo; echo "${NEG}$1${FIM}"; echo "────────────────────────────────────────────────"; }
fim(){ echo; read -r -p "Aperte Enter para fechar esta janela."; exit "${1:-0}"; }

clear
cat <<'CABECALHO'
════════════════════════════════════════════════
     PUBLICAR A TRILHA DE ESTUDOS NA INTERNET
════════════════════════════════════════════════

Este programa vai, sozinho:

  1. conferir se as ferramentas necessárias existem
  2. conectar sua conta do GitHub (abre o navegador)
  3. criar o repositório e enviar os arquivos
  4. deixar o repositório público
  5. ligar a publicação do site
  6. esperar o site subir e abrir o endereço

Você só precisa responder algumas perguntas simples.
Nada é apagado do seu computador.

CABECALHO
read -r -p "Pode começar? [s/n] " R
case "$R" in s|S|sim|SIM|y|Y|"") ;; *) echo "Cancelado."; fim 0 ;; esac

# ─────────────────────────────────────────────
titulo "PASSO 1 de 6 — Ferramentas"
# ─────────────────────────────────────────────
if [ ! -f index.html ]; then
  erro "Não achei o arquivo index.html nesta pasta."
  echo "  Coloque este programa DENTRO da pasta descompactada e tente de novo."
  fim 1
fi
ok "Arquivos do app encontrados."

if ! command -v git >/dev/null 2>&1; then
  erro "O 'git' não está instalado."
  info "Vai aparecer uma janela do sistema pedindo para instalar. Clique em Instalar,"
  info "espere terminar (alguns minutos) e rode este programa de novo."
  xcode-select --install >/dev/null 2>&1
  fim 1
fi
ok "git instalado."

if ! command -v gh >/dev/null 2>&1; then
  info "Falta o 'gh', o programa oficial do GitHub. Ele automatiza o resto."
  if command -v brew >/dev/null 2>&1; then
    read -r -p "Instalar agora? Leva 1 a 3 minutos. [s/n] " R
    case "$R" in
      s|S|sim|SIM|y|Y|"") echo; brew install gh || { erro "A instalação falhou."; fim 1; } ;;
      *) erro "Sem o 'gh' eu não consigo seguir automaticamente."
         info "Use o arquivo PUBLICAR.md — ele ensina o caminho pelo site, sem terminal."
         fim 1 ;;
    esac
  else
    erro "Não achei o Homebrew, que é quem instala o 'gh'."
    info "Duas opções:"
    info "  A) instale o Homebrew em https://brew.sh e rode este programa de novo"
    info "  B) siga o arquivo PUBLICAR.md, que faz tudo pelo site, sem terminal"
    fim 1
  fi
fi
ok "gh instalado."

# ─────────────────────────────────────────────
titulo "PASSO 2 de 6 — Conectar sua conta do GitHub"
# ─────────────────────────────────────────────
if gh auth status >/dev/null 2>&1; then
  USUARIO=$(gh api user --jq .login 2>/dev/null)
  ok "Já conectado como: ${NEG}${USUARIO}${FIM}"
else
  info "Vou abrir o navegador para você autorizar. Escolha, nas perguntas:"
  info "   GitHub.com  →  HTTPS  →  Yes  →  Login with a web browser"
  echo
  gh auth login || { erro "Não deu para conectar."; fim 1; }
  USUARIO=$(gh api user --jq .login 2>/dev/null)
  [ -z "$USUARIO" ] && { erro "Conectou, mas não consegui ler seu usuário."; fim 1; }
  ok "Conectado como: ${NEG}${USUARIO}${FIM}"
fi

# ─────────────────────────────────────────────
titulo "PASSO 3 de 6 — O repositório"
# ─────────────────────────────────────────────
echo "  1) Criar um repositório NOVO   (recomendado — histórico limpo)"
echo "  2) Usar um que eu já criei"
echo
read -r -p "Escolha 1 ou 2: " ESCOLHA

read -r -p "Nome do repositório [trilha-de-estudos]: " REPO
REPO=${REPO:-trilha-de-estudos}
REPO=$(echo "$REPO" | tr ' ' '-' | tr -cd 'A-Za-z0-9._-')
[ -z "$REPO" ] && { erro "Nome inválido."; fim 1; }

if [ ! -d .git ]; then
  git init -q
  git add -A
  git -c commit.gpgsign=false commit -qm "Trilha de Estudos — app offline para semana de provas"
fi
git branch -M main >/dev/null 2>&1
ok "Pasta pronta para envio."

if [ "$ESCOLHA" = "2" ]; then
  info "Enviando para o repositório existente ${NEG}${USUARIO}/${REPO}${FIM}"
  info "O conteúdo antigo será substituído pelo novo."
  read -r -p "Confirma? [s/n] " R
  case "$R" in s|S|sim|SIM|y|Y|"") ;; *) echo "Cancelado."; fim 0 ;; esac
  git remote remove origin >/dev/null 2>&1
  git remote add origin "https://github.com/${USUARIO}/${REPO}.git"
  if ! git push --force -u origin main; then
    erro "O envio falhou."
    info "Causa mais comum: o repositório tem outro nome. Confira em github.com."
    fim 1
  fi
else
  if gh repo view "${USUARIO}/${REPO}" >/dev/null 2>&1; then
    erro "Já existe um repositório chamado '${REPO}' na sua conta."
    info "Rode de novo escolhendo a opção 2, ou use outro nome."
    fim 1
  fi
  git remote remove origin >/dev/null 2>&1
  if ! gh repo create "$REPO" --public --source=. --remote=origin --push \
        --description "Trilha de estudos para a semana de provas"; then
    erro "Não consegui criar o repositório."
    fim 1
  fi
fi
ok "Arquivos enviados."

# ─────────────────────────────────────────────
titulo "PASSO 4 de 6 — Deixar público"
# ─────────────────────────────────────────────
VIS=$(gh api "repos/${USUARIO}/${REPO}" --jq .visibility 2>/dev/null)
if [ "$VIS" = "public" ]; then
  ok "Já está público."
else
  info "O site só funciona no plano gratuito se o repositório for público."
  read -r -p "Tornar público agora? [s/n] " R
  case "$R" in
    s|S|sim|SIM|y|Y|"")
      gh repo edit "${USUARIO}/${REPO}" --visibility public --accept-visibility-change-consequences >/dev/null 2>&1 \
        || gh repo edit "${USUARIO}/${REPO}" --visibility public >/dev/null 2>&1
      VIS=$(gh api "repos/${USUARIO}/${REPO}" --jq .visibility 2>/dev/null)
      if [ "$VIS" = "public" ]; then ok "Agora está público."
      else
        erro "Não consegui mudar automaticamente."
        info "Faça no site: Settings → Danger Zone → Change visibility → Make public"
        fim 1
      fi ;;
    *) info "Sem tornar público, o site não vai funcionar. Parando aqui."; fim 0 ;;
  esac
fi

# ─────────────────────────────────────────────
titulo "PASSO 5 de 6 — Ligar a publicação"
# ─────────────────────────────────────────────
CORPO='{"source":{"branch":"main","path":"/"}}'
if gh api -X POST "repos/${USUARIO}/${REPO}/pages" --input - <<<"$CORPO" >/dev/null 2>&1; then
  ok "Publicação ligada."
elif gh api -X PUT "repos/${USUARIO}/${REPO}/pages" --input - <<<"$CORPO" >/dev/null 2>&1; then
  ok "Publicação atualizada."
else
  erro "Não consegui ligar automaticamente."
  info "Faça no site: Settings → Pages → Source: Deploy from a branch"
  info "               Branch: main · pasta: / (root) → Save"
fi

SITE="https://${USUARIO}.github.io/${REPO}/"

# ─────────────────────────────────────────────
titulo "PASSO 6 de 6 — Esperando o site subir"
# ─────────────────────────────────────────────
info "Isso costuma levar de 1 a 3 minutos. Pode deixar a janela aberta."
CODIGO=""
for i in $(seq 1 40); do
  CODIGO=$(curl -s -o /dev/null -w "%{http_code}" --max-time 8 "$SITE" 2>/dev/null)
  [ "$CODIGO" = "200" ] && break
  printf "."
  sleep 6
done
echo

if [ "$CODIGO" = "200" ]; then
  ok "No ar."
  echo
  echo "════════════════════════════════════════════════"
  echo "  ${NEG}${SITE}${FIM}"
  echo "════════════════════════════════════════════════"
  echo
  echo "  ${NEG}Agora, no iPhone:${FIM}"
  echo "   1. abra esse endereço no ${NEG}Safari${FIM} (tem que ser o Safari)"
  echo "   2. toque no botão Compartilhar (quadrado com seta para cima)"
  echo "   3. role e toque em ${NEG}Adicionar à Tela de Início${FIM}"
  echo
  echo "  Da segunda abertura em diante funciona sem internet."
  echo
  open "$SITE" >/dev/null 2>&1
else
  info "Ainda não respondeu (código ${CODIGO:-sem resposta})."
  info "Não é erro: às vezes o GitHub demora mais na primeira vez."
  echo
  echo "  Tente abrir daqui a alguns minutos:"
  echo "  ${NEG}${SITE}${FIM}"
  echo
  echo "  Se continuar fora do ar, confira em:"
  echo "  https://github.com/${USUARIO}/${REPO}/settings/pages"
fi

fim 0

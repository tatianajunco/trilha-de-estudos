#!/bin/bash
cd "$(dirname "$0")" || exit 1
clear
echo "==============================================="
echo "  Publicar a Trilha de Estudos no GitHub"
echo "==============================================="
echo
if [ ! -d .git ]; then echo "Erro: esta pasta nao e um repositorio git."; read -r; exit 1; fi
echo "Antes de continuar, crie um repositorio VAZIO em github.com/new"
echo "(sem README, sem .gitignore, sem licenca) e copie o endereco dele."
echo
read -r -p "Cole o endereco aqui: " URL
[ -z "$URL" ] && { echo "Nada colado. Saindo."; read -r; exit 1; }

echo
read -r -p "Seu nome para os commits (Enter para manter): " NOME
read -r -p "Seu e-mail do GitHub (Enter para manter): " EMAIL
[ -n "$NOME" ]  && git config user.name  "$NOME"
[ -n "$EMAIL" ] && git config user.email "$EMAIL"
git config commit.gpgsign false

git remote remove origin 2>/dev/null
git remote add origin "$URL" || { echo "Endereco invalido."; read -r; exit 1; }
git branch -M main

echo
echo "Enviando... o GitHub pode pedir seu login numa janela do navegador."
echo
if git push -u origin main; then
  echo
  echo "-----------------------------------------------"
  echo "  PRONTO. Agora falta ligar o GitHub Pages:"
  echo "  Settings -> Pages -> Deploy from a branch"
  echo "  Branch: main   Pasta: / (root)   -> Save"
  echo "-----------------------------------------------"
else
  echo
  echo "O envio falhou. Causas comuns:"
  echo "  - o repositorio nao esta vazio (recrie sem README)"
  echo "  - login do GitHub nao autorizado nesta maquina"
  echo "  - o endereco colado esta errado"
  echo
  echo "Se preferir, use a Rota A do arquivo PUBLICAR.md: arrastar os"
  echo "arquivos direto no site do GitHub, sem terminal."
fi
echo
read -r -p "Aperte Enter para fechar."

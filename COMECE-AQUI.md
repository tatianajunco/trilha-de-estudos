# Comece por aqui

## O caminho automático

**1.** Descompacte esta pasta (dois cliques no arquivo `.zip`) e deixe-a na Área de Trabalho
ou em Downloads. Todos os arquivos precisam ficar juntos.

**2.** Clique com o **botão direito** no arquivo **`PUBLICAR-AUTOMATICO.command`** e escolha
**Abrir**.

> ⚠️ **Não dê dois cliques na primeira vez.** O macOS bloqueia programas baixados da internet
> e mostra "não pode ser aberto porque é de um desenvolvedor não identificado". Abrindo pelo
> botão direito, aparece um aviso com o botão **Abrir** — clique nele. Só precisa fazer assim
> uma vez.

**3.** Uma janela preta abre e vai te fazer perguntas simples. Responda e espere.

Ele conecta sua conta do GitHub, cria o repositório, envia os arquivos, deixa público, liga a
publicação, espera o site subir e abre o endereço no navegador. São 6 passos e ele avisa em
qual está.

**4.** No fim, ele mostra o endereço do site. Guarde esse endereço.

**5.** No iPhone: abra o endereço **no Safari** → botão **Compartilhar** → **Adicionar à Tela
de Início**. Vira um ícone na tela inicial e passa a funcionar sem internet.

---

## O que ele vai te perguntar

**"Pode começar?"** → digite `s` e Enter.

**"Instalar agora?"** (só aparece se faltar o programa `gh`) → digite `s`. Leva 1 a 3 minutos.

**Login do GitHub** → o navegador abre sozinho. Nas perguntas do terminal, escolha sempre a
primeira opção: `GitHub.com`, depois `HTTPS`, depois `Yes`, depois `Login with a web browser`.
Ele mostra um código de 8 caracteres — copie, cole no navegador e autorize.

**"Criar um repositório NOVO ou usar um que já criei?"** → digite `1`. É o mais limpo: o
repositório antigo, com o nome dela nos registros, fica de lado e você apaga depois.

**"Nome do repositório"** → só apertar Enter aceita `trilha-de-estudos`.

**"Tornar público agora?"** → digite `s`. Sem isso o site não funciona no plano gratuito.

---

## Se algo travar

Não tem problema, e nada quebra. O programa sempre diz o que fazer e para sozinho.

Se ele não conseguir seguir, abra o arquivo **`PUBLICAR.md`** — lá está o mesmo processo feito
**pelo site do GitHub, sem terminal nenhum**, clique por clique.

---

## Depois, apague o repositório antigo

Se você já tinha criado um repositório com o nome antigo, entre nele em github.com e vá em
**Settings → Danger Zone → Delete this repository**. Ele pede que você digite o nome para
confirmar. Isso apaga também os registros antigos que continham o nome.

---

## Quando quiser mudar o conteúdo

1. Edite o `index.html`.
2. Abra o `sw.js` e troque `trilha-estudos-v7` por `trilha-estudos-v8`. **Esse passo é
   obrigatório** — sem ele o celular continua mostrando a versão antiga.
3. Rode o `PUBLICAR-AUTOMATICO.command` de novo, escolhendo a opção `2` desta vez.

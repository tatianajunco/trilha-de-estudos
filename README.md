# Trilha de Estudos

Aplicativo de estudo para uma semana de provas do ensino fundamental. Página única, sem
dependências externas, sem servidor e sem coleta de dados — tudo roda no navegador.

Instalável na tela de início do celular e funcional sem internet depois da primeira abertura.

---

## O que tem dentro

- **Menu lateral** agrupado por Provas, Calendário e Acompanhamento — fixo no computador,
  em gaveta no celular
- **Aulas** — grade do trimestre por dia e semana, com atalho para treinar a matéria do horário
- **Tarefas** — calendário mensal com marcação de provas, lista do dia e aviso do que ficou para trás
- **Plano diário** com prática distribuída até a última prova
- **Quizzes** com explicação obrigatória do erro e tentativas ilimitadas
- **Jogo da memória** com figuras desenhadas, **cruzadinha** com charadas e **associação de imagens**
- **No papel** (Matemática): problemas para resolver escrevendo, com conferência automática
  da resposta, resolução passo a passo e folha para imprimir
- **Listening e Speaking** em inglês, com voz do próprio aparelho e reconhecimento de fala
- **Três níveis** por atividade, liberados por desempenho, e frases de incentivo ao terminar
- **Central de dúvidas** por assunto: glossário, passo a passo, mapa mental e busca de vídeo
- **Tradução no toque**: qualquer palavra sublinhada mostra o significado, offline
- **Painel de acompanhamento** para o adulto, com registro de onde o estudo travou
- Dois temas, claro e escuro

Nenhum dado sai do aparelho. O nome de quem estuda é digitado nos Ajustes e fica salvo apenas
no navegador local — ele não existe dentro dos arquivos publicados.

---

## Publicar no GitHub Pages

1. Suba todos os arquivos desta pasta na **raiz** do repositório.
2. **Settings → Pages**.
3. Em *Build and deployment → Source*, escolha **Deploy from a branch**.
4. Branch: `main` · pasta: `/ (root)` · **Save**.
5. Em 1 a 2 minutos o endereço aparece nessa mesma tela.

O repositório precisa ser **público** — no plano gratuito o Pages não publica a partir de
repositório privado.

### Instalar no iPhone / iPad

O iOS não abre arquivo HTML salvo no aparelho, por isso a publicação é necessária.
Com o endereço no ar: abra no **Safari** → Compartilhar → **Adicionar à Tela de Início**.

---

## Estrutura

| Arquivo | Função |
|---|---|
| `index.html` | O app inteiro: HTML, CSS, JavaScript, conteúdo e ilustrações SVG |
| `manifest.webmanifest` | Faz o iOS/Android tratarem como aplicativo |
| `sw.js` | Service worker — cache para funcionar offline |
| `icon-*.png` | Ícones da tela de início |
| `.nojekyll` | Impede o Jekyll do GitHub Pages de processar os arquivos |

**Ao alterar o conteúdo, incremente a versão do cache em `sw.js`** (`trilha-estudos-v8` → `v9`).
Sem isso o service worker continua servindo a versão antiga.

---

## Onde mexer no conteúdo

Tudo fica em constantes JavaScript dentro de `index.html`, na seção `DADOS`:

| Constante | O que guarda |
|---|---|
| `PROVAS` | Datas e matérias das provas |
| `MATERIAS` | Cor e resumo do conteúdo cobrado |
| `QUIZ` | `{p:"pergunta", a:["alt A","alt B","alt C"], c:índiceDaCerta, e:"explicação"}` — `c` começa em 0 |
| `MEMORIA2` | `{a:"fig:nurse", b:"nurse", ex:"explicação"}` — `a` aceita `fig:<ícone>` ou `frac:3/4` |
| `CRUZADA2` | Pares `[PALAVRA, charada]`. **Sem acento** — a grade é montada sozinha |
| `ASSOC2` | `{f:"ícone", t:"resposta", ex:"explicação"}` |
| `AULAS` / `HORARIOS` | Grade de aulas: `1` = segunda … `5` = sexta, na ordem dos horários |
| `PROBLEMAS` | Problemas de “No papel”: enunciado, resposta, dica, passos e sugestão de desenho |
| `OUVIR` / `FALAR` | Itens de listening e speaking, com nível `n` de 1 a 3 |
| `ICONES` | Desenhos SVG usados nas atividades |
| `NIVEIS` / `FRASES` | Quantidade de itens por nível e frases de incentivo |
| `PLANO` | `"AAAA-MM-DD": [["Matéria","tipo"]]`, com tipo `ap`, `rec`, `rev` ou `folga` |
| `AJUDA` | Central de dúvidas: glossário, passo a passo, mapa mental, busca de vídeo |
| `DIC` / `DIC_EXTRA` | Dicionário da tradução no toque |
| `ROTAS` | Regex que liga cada pergunta ao tópico de ajuda |
| `SELOS` | Conquistas e quantos dias de treino cada uma exige |

Depois de mexer, abra o arquivo no navegador e confira o console — um erro de vírgula derruba
o app inteiro, e o aviso amarelo no topo da página mostra a mensagem.

---

## Regras de desenho — leia antes de "melhorar"

Cada decisão abaixo responde a um dado, não a uma preferência. Mudá-las provavelmente piora o
resultado.

**Não adicionar ranking, pontuação por velocidade, moeda virtual ou prêmio prometido.**
Recompensa tangível, prometida e condicionada a desempenho reduz motivação intrínseca em
crianças (d = −0,52), e o pior caso é a criança receber menos que o prêmio máximo (d = −0,88)
— Deci, Koestner & Ryan (1999). Em estudo longitudinal de 16 semanas, a turma com leaderboard
e badges terminou com **menos** motivação e **notas menores** que a turma sem
(Hanus & Fox, 2015).

**Manter a explicação do erro em toda questão.** Quiz com feedback corretivo rende g = 0,54;
sem explicação, g = 0,37 — Yang et al. (2021), 222 estudos, 48.478 estudantes.

**Manter tentativas ilimitadas.** O efeito cresce com repetições: 1× g = 0,44 · 2× g = 0,60 ·
≥3× g = 0,64 · ilimitadas g = 0,76 (mesma meta-análise).

**Manter blocos de "primeiro contato" antes dos blocos de quiz.** Quiz depois da exposição ao
conteúdo rende g = 0,54; antes, g = 0,19.

**Manter cada matéria espalhada em vários dias.** Prática distribuída é a técnica com o efeito
mais alto medido, d = 0,85 — Donoghue & Hattie (2021). Espaçamento uniforme basta: cronograma
expansivo não supera o uniforme (g = 0,03 — Latimier et al., 2021).

**Manter as ilustrações fora da área da pergunta.** Elemento decorativo irrelevante dentro do
material didático piora a aprendizagem por aumento de carga cognitiva estranha — efeito
*seductive details*, g = −0,33 (Sundararajan & Adesope, 2020) e g = −0,16 na meta-análise
multinível de 2025 (50 estudos, 177 efeitos).

**Manter o "SE… ENTÃO…" como está.** O formato contingente supera o simples agendamento
(d = 0,43 contra 0,29); em crianças o efeito é d = 0,43 — Sheeran, Listrom & Gollwitzer (2025).

**Não prometer que o app melhora atenção ou memória.** Treino cognitivo digital não transfere
para desempenho escolar: leitura SMD 0,09 e aritmética SMD 0,01, ambos não significativos —
Cortese et al. (2015). O app treina o conteúdo das provas, nada além disso.

**Não prometer correção automática de foto.** O app guarda a foto da folha só no aparelho, para
um adulto ler. Nenhuma imagem é analisada: isso exigiria servidor e chave de API, o que num
repositório público significa chave exposta e custo aberto. Além disso, o que corrige a
resolução manuscrita com segurança é uma pessoa — a conferência automática cobre a resposta
final, não o caminho.

**Progressão de nível deve depender de completar, não de acertar rápido.** O critério é 60% de
acerto para abrir o próximo nível, sem cronômetro e com repetição ilimitada — é aumento de
dificuldade, não competição.

**Manter a ajuda de significado imediata e o passo a passo com aviso.** Dúvida de vocabulário
é bloqueio de compreensão e deve ser resolvida na hora; a resolução pronta antes da tentativa
derruba o efeito da recuperação ativa.

---

## Limites conhecidos

- **Não é diagnóstico.** Nada aqui identifica qualquer condição de aprendizagem.
- **Não substitui livro e caderno.** Frações, em especial, se aprendem resolvendo exercício com
  correção na hora — a evidência de recuperação ativa em matemática é inconclusiva
  (g = 0,18 com intervalo de confiança cruzando zero — Murray, Horner & Göbel, 2025).
- **Progresso é local.** Fica no navegador do aparelho e não sincroniza. Use
  *Ajustes → Baixar backup* antes de trocar de dispositivo. O iOS pode apagar dados de apps que
  passam semanas sem uso.
- **A busca de vídeo abre o YouTube** e precisa de internet. Os resultados não são curados — a
  intenção é que seja usada com um adulto por perto.

---

## Licença

Uso pessoal e educacional livre.

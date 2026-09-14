# ============================================================
#  MAGUEZI - Gerador dos Livros IV, V e VI  (versao 2)
# ------------------------------------------------------------
#  Cria em biblioteca/ a pagina-mae e o leitor de cada livro.
#
#  ONDE CORRER: na RAIZ do projecto (a pasta com biblioteca/)
#  COMO CORRER: powershell -ExecutionPolicy Bypass -File .\gerar-livros.ps1
#
#  SEGURANCA: ficheiros existentes sao SALTADOS (nada se apaga).
# ============================================================

 $utf8 = New-Object System.Text.UTF8Encoding($false)

# ------------------------------------------------------------
# DADOS DOS LIVROS
# ------------------------------------------------------------
 $livros = @(

  # ================ LIVRO IV ================
  @{
    numero = "Livro IV"
    slug = "livro-4-casa-de-palha-verde"
    titulo = "A Casa de Palha Verde"
    simbolo = "🌿"
    linha = ("Não é a casa que é extraordinária — " +
             "mas quem a habita.")
    tempo = "≈ EDITA minutos de leitura"

    tema = ("Uma história sobre <strong>humildade</strong>, " +
            "<strong>simplicidade</strong> e " +
            "<strong>memória escondida</strong>.")

    sinopse = @(
      ("Nas terras abençoadas de Inhambane vivia um régulo, " +
       "outrora um guerreiro temido e respeitado, cuja " +
       "bravura atravessara fronteiras. Agora, dedicado à " +
       "família, governava com a mesma firmeza com que " +
       "antes brandira a lança. Tinha três filhos, e " +
       "ensinara-lhes a buscar sempre o elevado."),
      ("Na grande festa que organizou, tribos, mercadores e " +
       "guerreiros acorreram de toda a parte. Nobres e " +
       "herdeiros desfilaram as suas virtudes diante das " +
       "donzelas. Mas, como dizem os mais velhos, ninguém " +
       "conhece os trilhos do coração."),
      ("Anos depois, numa tempestade, a filha mais nova " +
       "descobre uma casa de palha verde — toda verde, " +
       "sem uma palha seca — onde os pássaros pousam sem " +
       "medo. E descobre, nela, um servo cuja serenidade " +
       "esconde uma grandeza que os olhos comuns não " +
       "conseguem ver."),
      ("Uma porta para um mundo escondido — e para a " +
       "memória de Maguezi, que continua viva em quem " +
       "sabe escutar.")
    )

    personagens = @(
      @{ s = "🌾"; n = "A Donzela";
         t = "A filha do régulo que ouvia o canto da Mãe-Terra." },
      @{ s = "🏡"; n = "O Jovem Servo";
         t = ("O guardião da casa de palha verde. " +
              "Não é o que muitos veem.") },
      @{ s = "👑"; n = "O Régulo de Inhambane";
         t = ("O pai atento, que sabia distinguir o capricho " +
              "passageiro da verdade profunda.") },
      @{ s = "👦"; n = "O Irmão Mais Novo";
         t = "O que duvidou — até ver." }
    )

    lugares = @(
      @{ s = "🌿"; n = "A Casa de Palha Verde";
         t = ("Renovada todos os dias: nenhuma palha seca, " +
              "nenhum sinal da tempestade.") },
      @{ s = "🌊"; n = "As Terras de Inhambane";
         t = ("Onde a história começa — e onde a memória de " +
              "Maguezi se esconde.") }
    )

    folha = '“Não é a casa que é extraordinária, mas quem a habita.”'
    folhaCite = "Desta crónica — Livro IV"

    camada1 = ("Uma jovem curiosa, uma casa misteriosa e uma " +
               "visita que muda o destino de uma família. " +
               "Lê como uma história de descoberta.")
    camada2 = ("EDITA — o que o leitor atento percebe " +
               "(sugestão: o que protege a casa não é " +
               "feitiço, é o cuidado de cada dia).")
    camada3 = ('<li>Que casa cuidas tu todos os dias?</li>' +
               '<li>O que é que os teus olhos ainda não ' +
               'conseguem ver?</li>' +
               '<li>Onde está a Maguezi que os teus avós ' +
               'conheceram?</li>')

    nota = ("EDITA — como nasceu esta história " +
            "(trabalho de campo, Inhambane, memórias recolhidas).")

    prev = ('<a href="livro-3-yehlisa.html">' +
            '← Livro III — Yehlisa e a Mbira Mágica</a>')
    next = ('<span class="em-breve">Livro V — O Conto de ' +
            'Tsembissa · abre em breve</span>')
  },

  # ================ LIVRO V ================
  @{
    numero = "Livro V"
    slug = "livro-5-tsembissa"
    titulo = "O Conto de Tsembissa"
    simbolo = "🌟"
    linha = "EDITA — uma linha-símbolo para o portador da verdade."
    tempo = "≈ EDITA minutos de leitura"

    tema = ("Uma história sobre <strong>verdade</strong> e a " +
            "luz que se carrega por dentro.")

    sinopse = @(
      "EDITA — parágrafo 1 da sinopse.",
      "EDITA — parágrafo 2.",
      "EDITA — parágrafo 3 (sem revelar o desfecho)."
    )

    personagens = @(
      @{ s = "🌟"; n = "Tsembissa";
         t = "O portador da verdade — a luz moral das Crónicas." },
      @{ s = "✍️"; n = "EDITA"; t = "EDITA" }
    )

    lugares = @(
      @{ s = "🗺️"; n = "EDITA"; t = "EDITA" }
    )

    folha = '“EDITA — a citação mais partilhável do conto.”'
    folhaCite = "Desta crónica — Livro V"

    camada1 = "EDITA — a porta da aventura."
    camada2 = "EDITA — a porta do símbolo."
    camada3 = "<li>EDITA — pergunta à volta da fogueira?</li>"

    nota = "EDITA — como nasceu esta história."

    prev = ('<a href="livro-4-casa-de-palha-verde.html">' +
            '← Livro IV — A Casa de Palha Verde</a>')
    next = ('<span class="em-breve">Livro VI — O Conto da ' +
            'Árvore Sagrada · abre em breve</span>')
  },

  # ================ LIVRO VI ================
  @{
    numero = "Livro VI"
    slug = "livro-6-arvore-sagrada"
    titulo = "O Conto da Árvore Sagrada"
    simbolo = "🌳"
    linha = ("A jornada de Magna, a jovem que ouve o sussurro " +
             "das antiguidades.")
    tempo = "≈ EDITA minutos de leitura"

    tema = ("Uma história sobre <strong>memória</strong>, " +
            "<strong>ancestralidade</strong> e o " +
            "<strong>Som Original</strong>.")

    sinopse = @(
      ("Magna é a jovem que ouve o sussurro das antiguidades: " +
       "memórias nos objectos, vozes no vento, histórias " +
       "guardadas nas coisas."),
      ("A sua jornada leva-a à Árvore Sagrada — a ponte entre " +
       "a terra e o firmamento, num universo onde o Som " +
       "Original da criação ainda pode ser ouvido."),
      "EDITA — fecha a sinopse sem revelar o desfecho."
    )

    personagens = @(
      @{ s = "👂"; n = "Magna";
         t = "A jovem que ouve o sussurro das antiguidades." },
      @{ s = "🌳"; n = "A Árvore Sagrada";
         t = "A ponte entre a terra e o firmamento." },
      @{ s = "✍️"; n = "EDITA"; t = "EDITA" }
    )

    lugares = @(
      @{ s = "🌳"; n = "A Árvore Sagrada";
         t = "EDITA — onde ela se ergue." }
    )

    folha = '“A árvore não respondeu. Apenas deixou cair uma folha.”'
    folhaCite = "Desta crónica — Livro VI"

    camada1 = "EDITA — a aventura de Magna."
    camada2 = ("EDITA — o símbolo da árvore: ancestralidade, " +
               "memória, ponte.")
    camada3 = ('<li>Que memórias vivem na árvore da tua rua?</li>' +
               '<li>O que te foi confiado — e ainda não ' +
               'partilhaste?</li>')

    nota = "EDITA — como nasceu esta história."

    prev = ('<a href="livro-5-tsembissa.html">' +
            '← Livro V — O Conto de Tsembissa</a>')
    next = ('<span class="em-breve">Fim do Volume 1 — o Volume 2 ' +
            'está a germinar 🌱</span>')
  }
)

# ------------------------------------------------------------
# AUXILIAR - construir as fichas (personagens / lugares)
# ------------------------------------------------------------
function Fichas($lista, $comLink) {
  $s = ""
  foreach ($f in $lista) {
    if ($comLink) {
      $s = $s + '<a class="ficha" href="../universo/index.html">'
    } else {
      $s = $s + '<article class="ficha">'
    }
    $s = $s + '<span class="ficha-simbolo">' + $f.s + '</span>'
    $s = $s + '<h3>' + $f.n + '</h3>'
    $s = $s + '<p>' + $f.t + '</p>'
    if ($comLink) {
      $s = $s + '</a>'
    } else {
      $s = $s + '</article>'
    }
  }
  return $s
}

# ------------------------------------------------------------
# TEMPLATE - pagina-mae
# ------------------------------------------------------------
 $TPL_MAE = @'
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>@@TITULO@@ — @@NUMERO@@ | Maguezi</title>
  <meta name="description" content="@@NUMERO@@ das Crónicas da Cidade de Luz. Ler online e apoiar a edição impressa." />
  <link rel="icon" href="../img/favicon.svg" type="image/svg+xml" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;1,400&family=EB+Garamond:ital@0;1&family=Source+Sans+3:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="../css/estilos.css" />
  <link rel="stylesheet" href="../css/livro.css" />
</head>
<body class="pagina-interna">

  <header class="cabecalho cabecalho--solido">
    <div class="conteudo">
      <a class="marca" href="../index.html">✦ Maguezi</a>
      <nav aria-label="Navegação principal">
        <ul class="menu">
          <li><a href="../universo/index.html">O Universo</a></li>
          <li><a href="index.html">Biblioteca</a></li>
          <li><a href="../saberes/index.html">Saberes</a></li>
          <li><a href="../edicao/index.html">A Caminho do Papel</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <section class="livro-hero">
    <div class="nyeleti" aria-hidden="true"></div>
    <div class="conteudo">
      <p class="livro-numero">@@NUMERO@@ · Volume 1</p>
      <h1>@@TITULO@@</h1>
      <p class="livro-hero__linha">@@LINHA@@</p>
      <div class="livro-acoes">
        <a class="botao" href="@@SLUG@@-ler.html">📖 Ler a Crónica</a>
        <a class="botao botao--fantasma" href="#ouvir">🎧 Ouvir <small>(em breve)</small></a>
      </div>
      <p class="livro-meta">@@TEMPO@@</p>
    </div>
  </section>

  <section class="seccao livro-seccao" id="sinopse">
    <div class="conteudo">
      <h2 class="livro-seccao-titulo"><span>✨</span> Sinopse</h2>
      <div class="sinopse">
        @@SINOPSE@@
        <p class="sinopse-temas">@@TEMA@@</p>
      </div>
    </div>
  </section>

  <section class="seccao seccao--palha livro-seccao" id="camadas">
    <div class="conteudo">
      <h2 class="livro-seccao-titulo"><span>🔥</span> As Camadas</h2>
      <p class="livro-seccao-intro">
        Cada crónica de Maguezi funciona em três níveis, ao mesmo tempo.
        Escolhe a tua porta — ou atravessa as três.
      </p>
      <details class="camada" open>
        <summary><strong>📖 A História</strong><em>para simplesmente desfrutar</em></summary>
        <div class="camada-corpo"><p>@@CAMADA1@@</p></div>
      </details>
      <details class="camada">
        <summary><strong>🌿 O Símbolo</strong><em>para quem quer ver mais fundo</em></summary>
        <div class="camada-corpo"><p>@@CAMADA2@@</p></div>
      </details>
      <details class="camada">
        <summary><strong>🌙 A Sabedoria</strong><em>para quem quiser aprofundar</em></summary>
        <div class="camada-corpo">
          <p>Perguntas para levar contigo, à volta da fogueira:</p>
          <ul class="perguntas">@@CAMADA3@@</ul>
        </div>
      </details>
    </div>
  </section>

  <section class="seccao livro-seccao" id="personagens">
    <div class="conteudo">
      <h2 class="livro-seccao-titulo"><span>🌿</span> Personagens</h2>
      <div class="fichas">@@PERSONAGENS@@</div>
    </div>
  </section>

  <section class="seccao seccao--palha livro-seccao" id="lugares">
    <div class="conteudo">
      <h2 class="livro-seccao-titulo"><span>🗺️</span> Lugares de Maguezi</h2>
      <div class="fichas">@@LUGARES@@</div>
    </div>
  </section>

  <section class="seccao livro-seccao" id="ouvir">
    <div class="conteudo">
      <h2 class="livro-seccao-titulo"><span>🎧</span> Ouvir a Crónica</h2>
      <div class="player-placeholder">
        <span class="simbolo">🎙️</span>
        <p><strong>As gravações estão a nascer.</strong></p>
        <p>Em breve, cada crónica poderá ser ouvida — narrada, à maneira antiga, como se conta junto à fogueira.</p>
        <p>Queres ser dos primeiros a ouvir? <a href="mailto:associacaomaguezi@gmail.com">associacaomaguezi@gmail.com</a></p>
      </div>
    </div>
  </section>

  <section class="seccao seccao--palha livro-seccao" id="nota">
    <div class="conteudo">
      <h2 class="livro-seccao-titulo"><span>📜</span> Nota dos Autores</h2>
      <div class="nota-autores">
        <p>@@NOTA@@</p>
        <p class="assinatura">— Osvaldo Chamba &amp; Dória Macie · Maputo</p>
      </div>
    </div>
  </section>

  <section class="seccao seccao--noite livro-seccao" id="edicao">
    <div class="conteudo" style="text-align:center">
      <h2 class="livro-seccao-titulo" style="justify-content:center"><span>🖨️</span> Estado da Edição Impressa</h2>
      <span class="estado-selo">A caminho do papel</span>
      <div class="estado-texto">
        <p>Esta crónica existe em versão digital — para ler e, em breve, para ouvir. A edição impressa do Volume 1 aguarda a sua campanha.</p>
        <p>Se queres segurar este livro nas mãos — e oferecê-lo — <a href="../edicao/index.html">vê como apoiar a edição →</a></p>
      </div>
    </div>
  </section>

  <section class="seccao seccao--palha livro-seccao">
    <div class="conteudo">
      <h2 class="livro-seccao-titulo"><span>🍂</span> A Folha que Caiu</h2>
      <div class="folha-semana">
        <blockquote>@@FOLHA@@</blockquote>
        <cite>@@FOLHACITE@@</cite>
      </div>
      <nav class="nav-livros" aria-label="Navegação entre livros">
        @@PREV@@
        @@NEXT@@
      </nav>
    </div>
  </section>

  <footer class="rodape">
    <div class="conteudo">
      <span class="marca">✦ Maguezi</span>
      <p>Crónicas da Cidade de Luz · Osvaldo Chamba &amp; Dória Macie</p>
    </div>
  </footer>

</body>
</html>
'@

# ------------------------------------------------------------
# TEMPLATE - leitor
# ------------------------------------------------------------
 $TPL_LER = @'
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>@@TITULO@@ — Ler | Maguezi</title>
  <meta name="description" content="Lê online @@NUMERO@@ das Crónicas da Cidade de Luz: @@TITULO@@." />
  <link rel="icon" href="../img/favicon.svg" type="image/svg+xml" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;1,400&family=EB+Garamond:ital@0;1&family=Source+Sans+3:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="../css/estilos.css" />
  <link rel="stylesheet" href="../css/livro.css" />
  <script defer src="../js/leitor.js"></script>
</head>
<body class="leitor" data-tema="madrugada">

  <div class="progresso" aria-hidden="true">
    <div class="progresso__barra" id="barra-progresso"></div>
  </div>

  <div class="leitor-barra">
    <div class="conteudo">
      <a class="leitor-volta" href="@@SLUG@@.html">← @@NUMERO@@</a>
      <div class="leitor-controlos" role="group" aria-label="Ajustes de leitura">
        <button type="button" data-tema="madrugada" title="Tema Madrugada (claro)">☀️ Madrugada</button>
        <button type="button" data-tema="palha" title="Tema Palha (sépia)">🌿 Palha</button>
        <button type="button" data-tema="noite" title="Tema Noite de Nyeleti (escuro)">🌙 Noite</button>
        <span class="separador" aria-hidden="true"></span>
        <button type="button" id="diminuir" title="Letra mais pequena">A−</button>
        <button type="button" id="aumentar" title="Letra maior">A+</button>
      </div>
    </div>
  </div>

  <header class="leitor-cabeca">
    <p class="livro-numero">@@NUMERO@@ · Volume 1</p>
    <h1>@@TITULO@@</h1>
    <p class="meta">Crónicas da Cidade de Luz · @@TEMPO@@</p>
  </header>

  <p class="leitor-ornamento" aria-hidden="true">✦ ✦ ✦</p>

  <main>
    <article class="texto">

      <!-- EDITA AQUI - A CRONICA COMPLETA
           Convencoes literarias do Leitor de Maguezi:
           1o paragrafo:      <p class="abertura"> ... </p>
           falas (dialogo):   <p class="fala">— ...</p>
           separador de cena: <p class="divisor">✦ ✦ ✦</p>
           titulo de seccao:  <h2>O Titulo da Seccao</h2>
           epigrafe:          <p class="epigrafe">“...”<cite>— Quem disse</cite></p>
           versos/oraculo:    <p class="versos">linha<br />linha</p>
           Apaga este comentario quando terminares. -->

      <p class="abertura">
        [COLA AQUI o primeiro parágrafo da crónica…]
      </p>
      <p>
        [ …os restantes parágrafos, um p por parágrafo… ]
      </p>
      <p class="fala">
        — [exemplo de fala: cada linha de diálogo num parágrafo assim]
      </p>
      <p class="divisor" aria-hidden="true">✦ ✦ ✦</p>

    </article>
  </main>

  <footer class="leitor-fim">
    <div class="conteudo">
      <p class="leitor-ornamento" aria-hidden="true">✦ ✦ ✦</p>
      <div class="folha-semana">
        <blockquote>@@FOLHA@@</blockquote>
        <cite>Fim da crónica — @@NUMERO@@</cite>
      </div>
      <nav class="nav-livros" aria-label="Fim da leitura">
        <a href="@@SLUG@@.html">← A página do Livro</a>
        <a href="index.html">A Biblioteca da Cidade de Luz</a>
      </nav>
      <p class="nota-partilha">
        Partilha o caminho, não o texto.<br />
        Os contos de Maguezi vivem de boca em boca — e o livro impresso nascerá
        das mãos de quem os amar.
      </p>
    </div>
  </footer>

</body>
</html>
'@

# ------------------------------------------------------------
# GERAR
# ------------------------------------------------------------
Write-Host ""
Write-Host "MAGUEZI - Gerador de livros" -ForegroundColor Yellow
Write-Host ""

foreach ($l in $livros) {
  $sinopseHtml = "<p>" + ($l.sinopse -join "</p><p>") + "</p>"

  $mae = $TPL_MAE
  $mae = $mae.Replace("@@NUMERO@@", $l.numero)
  $mae = $mae.Replace("@@TITULO@@", $l.titulo)
  $mae = $mae.Replace("@@SLUG@@", $l.slug)
  $mae = $mae.Replace("@@LINHA@@", $l.linha)
  $mae = $mae.Replace("@@TEMPO@@", $l.tempo)
  $mae = $mae.Replace("@@TEMA@@", $l.tema)
  $mae = $mae.Replace("@@SINOPSE@@", $sinopseHtml)
  $mae = $mae.Replace("@@PERSONAGENS@@", (Fichas $l.personagens $false))
  $mae = $mae.Replace("@@LUGARES@@", (Fichas $l.lugares $true))
  $mae = $mae.Replace("@@FOLHA@@", $l.folha)
  $mae = $mae.Replace("@@FOLHACITE@@", $l.folhaCite)
  $mae = $mae.Replace("@@CAMADA1@@", $l.camada1)
  $mae = $mae.Replace("@@CAMADA2@@", $l.camada2)
  $mae = $mae.Replace("@@CAMADA3@@", $l.camada3)
  $mae = $mae.Replace("@@NOTA@@", $l.nota)
  $mae = $mae.Replace("@@PREV@@", $l.prev)
  $mae = $mae.Replace("@@NEXT@@", $l.next)

  $ler = $TPL_LER
  $ler = $ler.Replace("@@NUMERO@@", $l.numero)
  $ler = $ler.Replace("@@TITULO@@", $l.titulo)
  $ler = $ler.Replace("@@SLUG@@", $l.slug)
  $ler = $ler.Replace("@@TEMPO@@", $l.tempo)
  $ler = $ler.Replace("@@FOLHA@@", $l.folha)

  $cMae = "biblioteca/" + $l.slug + ".html"
  $cLer = "biblioteca/" + $l.slug + "-ler.html"

  if (Test-Path $cMae) {
    Write-Host "saltado (ja existe): $cMae" -ForegroundColor DarkGray
  } else {
    [IO.File]::WriteAllText($cMae, $mae, $utf8)
    Write-Host "criado: $cMae" -ForegroundColor Green
  }

  if (Test-Path $cLer) {
    Write-Host "saltado (ja existe): $cLer" -ForegroundColor DarkGray
  } else {
    [IO.File]::WriteAllText($cLer, $ler, $utf8)
    Write-Host "criado: $cLer" -ForegroundColor Green
  }
}

 $total = (Get-ChildItem -Path "biblioteca" -Filter "livro-*" -File).Count
Write-Host ""
Write-Host ("Ficheiros de livros em biblioteca/: " + $total)
Write-Host ""
Write-Host "Proximos passos (procura EDITA nos ficheiros gerados):" -ForegroundColor Yellow
Write-Host "  1. Cola a cronica em cada ficheiro -ler.html"
Write-Host "  2. Ajusta o tempo de leitura de cada livro"
Write-Host "  3. Desbloqueia cada livro na prateleira"
Write-Host "     (biblioteca/index.html):"
Write-Host '     - troca <div class="porta livro porta--em-breve">'
Write-Host '       por <a class="porta livro" href="SLUG-DO-LIVRO.html">'
Write-Host "     - e troca 'Abre em breve' por 'Ler agora'"
Write-Host ""
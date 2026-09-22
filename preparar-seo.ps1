# ============================================================
#  MAGUEZI - Preparar SEO (Sessao 7)
#  Gera: sitemap.xml + robots.txt
#  Insere: tags Open Graph em todas as paginas
#
#  ONDE CORRER: raiz do projecto
#  COMO CORRER: powershell -ExecutionPolicy Bypass -File .\preparar-seo.ps1
#
#  Reutilizavel: podes correr quantas vezes quiseres.
#  Quando comprares o dominio, muda a variavel $Dominio
#  e corre de novo - tudo se regenera.
# ============================================================

 $Dominio = "https://xambinha.github.io/maguezi"

 $utf8 = New-Object System.Text.UTF8Encoding($false)
 $marcaIni = '<!-- MAGUEZI-SEO-INICIO -->'
 $marcaFim = '<!-- MAGUEZI-SEO-FIM -->'

 $ficheiros = Get-ChildItem -Recurse -Filter *.html
 $alterados = 0

foreach ($f in $ficheiros) {
  $html = [IO.File]::ReadAllText($f.FullName)

  # caminho relativo (ex.: biblioteca/livro-1.html)
  $rel = $f.FullName.Substring($PWD.Path.Length + 1).Replace('\','/')
  if ($rel -eq 'index.html') {
    $urlPagina = $Dominio + '/'
  } else {
    $rel = $rel -replace 'index\.html$',''
    $urlPagina = $Dominio + '/' + $rel
  }

  # extrair o titulo da pagina
  $titulo = 'Maguezi - Cronicas da Cidade de Luz'
  if ($html -match '(?s)<title>(.*?)</title>') { $titulo = $Matches[1] }

  # extrair a descricao
  $descricao = 'Cronicas da Cidade de Luz: fantasia africana para ler e ouvir.'
  if ($html -match 'name="description"\s+content="([^"]*)"') { $descricao = $Matches[1] }

  # construir o bloco OG
  $nl = [Environment]::NewLine
  $bloco = '  ' + $marcaIni + $nl
  $bloco = $bloco + '  <meta property="og:title" content="' + $titulo + '" />' + $nl
  $bloco = $bloco + '  <meta property="og:description" content="' + $descricao + '" />' + $nl
  $bloco = $bloco + '  <meta property="og:type" content="website" />' + $nl
  $bloco = $bloco + '  <meta property="og:url" content="' + $urlPagina + '" />' + $nl
  $bloco = $bloco + '  <meta property="og:image" content="' + $Dominio + '/img/capa-social.jpg" />' + $nl
  $bloco = $bloco + '  <meta name="twitter:card" content="summary_large_image" />' + $nl
  $bloco = $bloco + '  ' + $marcaFim + $nl

  # remover bloco antigo (se existir) e inserir o novo antes de </head>
  $padrao = '(?s)<!-- MAGUEZI-SEO-INICIO -->.*?<!-- MAGUEZI-SEO-FIM -->\r?\n?'
  $novo = [regex]::Replace($html, $padrao, '')
  $novo = $novo.Replace('</head>', $bloco + '</head>')

  if ($novo -ne $html) {
    [IO.File]::WriteAllText($f.FullName, $novo, $utf8)
    Write-Host ('OG: ' + $rel) -ForegroundColor Green
    $alterados++
  }
}

# ---------- sitemap.xml ----------
 $linhas = New-Object System.Collections.Generic.List[string]
foreach ($f in $ficheiros) {
  $rel = $f.FullName.Substring($PWD.Path.Length + 1).Replace('\','/')
  if ($rel -eq 'index.html') {
    $u = $Dominio + '/'
  } else {
    $rel = $rel -replace 'index\.html$',''
    $u = $Dominio + '/' + $rel
  }
  $data = $f.LastWriteTime.ToString('yyyy-MM-dd')
  $linhas.Add('  <url><loc>' + $u + '</loc><lastmod>' + $data + '</lastmod></url>')
}

 $sitemap = '<?xml version="1.0" encoding="UTF-8"?>'
 $sitemap = $sitemap + '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
 $sitemap = $sitemap + ($linhas -join '')
 $sitemap = $sitemap + '</urlset>'
[IO.File]::WriteAllText("$PWD\sitemap.xml", $sitemap, $utf8)
Write-Host ('sitemap.xml: ' + $linhas.Count + ' paginas') -ForegroundColor Green

# ---------- robots.txt ----------
 $robots = 'User-agent: *' + [Environment]::NewLine
 $robots = $robots + 'Allow: /' + [Environment]::NewLine
 $robots = $robots + 'Sitemap: ' + $Dominio + '/sitemap.xml' + [Environment]::NewLine
[IO.File]::WriteAllText("$PWD\robots.txt", $robots, $utf8)
Write-Host 'robots.txt' -ForegroundColor Green

Write-Host ''
Write-Host ('Total de paginas com OG: ' + $alterados)
Write-Host 'Agora: git add . / commit / push - o site actualiza sozinho.'
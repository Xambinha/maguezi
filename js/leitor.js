/* ============================================================
   MAGUEZI — O Leitor da Cidade de Luz
   ------------------------------------------------------------
   1. Tema de leitura (Madrugada · Palha · Noite) — memorizado
   2. Tamanho da letra (A− / A+) — memorizado
   3. Barra de progresso de leitura
   4. Marcador: retoma a leitura onde ficaste
   ============================================================ */

(function () {
  "use strict";

  /* ---------- Chaves de memória (localStorage do navegador) ---------- */
  const CHAVE_TEMA  = "maguezi.tema";
  const CHAVE_TAM   = "maguezi.tamanho";
  const CHAVE_MARCA = "maguezi.marca." + location.pathname;

  /* ---------- Elementos ---------- */
  const corpo  = document.body;
  const texto  = document.querySelector(".texto");
  const botoes = Array.from(document.querySelectorAll("[data-tema]"));
  const btnAum = document.getElementById("aumentar");
  const btnDim = document.getElementById("diminuir");
  const barra  = document.getElementById("barra-progresso");

  /* ---------- 1. Tema ---------- */
  function aplicarTema(nome) {
    corpo.dataset.tema = nome;
    localStorage.setItem(CHAVE_TEMA, nome);
    botoes.forEach((b) =>
      b.classList.toggle("activo", b.dataset.tema === nome)
    );
  }
  botoes.forEach((b) =>
    b.addEventListener("click", () => aplicarTema(b.dataset.tema))
  );
  aplicarTema(localStorage.getItem(CHAVE_TEMA) || "madrugada");

  /* ---------- 2. Tamanho da letra ---------- */
  const MIN = 0.95, MAX = 1.6, PASSO = 0.1;
  let tamanho = parseFloat(localStorage.getItem(CHAVE_TAM)) || 1.15;

  function aplicarTamanho() {
    texto.style.fontSize = tamanho.toFixed(2) + "rem";
    localStorage.setItem(CHAVE_TAM, String(tamanho));
    if (btnAum) btnAum.disabled = tamanho >= MAX;
    if (btnDim) btnDim.disabled = tamanho <= MIN;
  }
  if (btnAum) btnAum.addEventListener("click", () => {
    tamanho = Math.min(MAX, tamanho + PASSO);
    aplicarTamanho();
  });
  if (btnDim) btnDim.addEventListener("click", () => {
    tamanho = Math.max(MIN, tamanho - PASSO);
    aplicarTamanho();
  });
  if (texto) aplicarTamanho();

  /* ---------- 3. Barra de progresso ---------- */
  function actualizarProgresso() {
    const alturaUtil =
      document.documentElement.scrollHeight - window.innerHeight;
    const pct = alturaUtil > 0 ? (window.scrollY / alturaUtil) * 100 : 100;
    if (barra) barra.style.width = Math.min(100, pct) + "%";
  }
  window.addEventListener("scroll", actualizarProgresso, { passive: true });
  actualizarProgresso();

  /* ---------- 4. Marcador (retomar onde ficaste) ---------- */
  if ("scrollRestoration" in history) history.scrollRestoration = "manual";

  let espera;
  window.addEventListener("scroll", () => {
    clearTimeout(espera);
    espera = setTimeout(() => {
      localStorage.setItem(CHAVE_MARCA, String(window.scrollY));
    }, 250);
  }, { passive: true });

  const marca = parseInt(localStorage.getItem(CHAVE_MARCA) || "0", 10);
  if (marca > 150) {
    /* salto imediato: ignoramos o scroll suave do CSS só por um instante */
    const html = document.documentElement;
    html.style.scrollBehavior = "auto";
    window.scrollTo(0, marca);
    html.style.scrollBehavior = "";
  }
})();
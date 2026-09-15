/* ============================================================
   MAGUEZI — O Portador de Vozes
   ------------------------------------------------------------
   Como funciona:
   1. Cada página de livro tem um <div class="player-maguezi">
      com o nome da crónica (data-livro).
   2. Este script procura o ficheiro em audio/ (experimenta
      .mp3, .m4a, .ogg, .wav — conforme o teu gravador).
   3. Se encontrar: constrói o player. Se não: constrói o
      cartão "as vozes estão a nascer".
   4. Guarda a posição de escuta, como o Leitor faz com a
      leitura: quem para a meio, retoma a meio.
   ============================================================ */

(function () {
  "use strict";

  var EXTENSOES = ["mp3", "m4a", "ogg", "wav"];
  var VELOCIDADES = [0.75, 1, 1.25];

  /* ---------- utilitários ---------- */
  function tempo(s) {
    if (!isFinite(s) || s < 0) s = 0;
    var m = Math.floor(s / 60);
    var r = Math.floor(s % 60);
    return m + ":" + (r < 10 ? "0" : "") + r;
  }

  function existe(url) {
    return fetch(url, { method: "HEAD" })
      .then(function (r) { return r.ok; })
      .catch(function () { return false; });
  }

  /* procura audio/{slug}.{ext} por ordem; devolve o URL ou null */
  function procurar(base, slug, i) {
    if (i >= EXTENSOES.length) return Promise.resolve(null);
    var url = base + slug + "." + EXTENSOES[i];
    return existe(url).then(function (ok) {
      return ok ? url : procurar(base, slug, i + 1);
    });
  }

  /* ---------- o player ---------- */
  function construirPlayer(caixa, dados, url) {
    var chave = "maguezi.audio." + dados.slug;

    var audio = document.createElement("audio");
    audio.preload = "metadata";
    audio.src = url;
    audio.style.display = "none";

    caixa.innerHTML =
      '<div class="pm-caixa">' +
        '<button type="button" class="pm-botao" aria-label="Ouvir a crónica">▶</button>' +
        '<div class="pm-info">' +
          '<span class="pm-numero">' + dados.numero + ' · Narrada</span>' +
          '<strong class="pm-titulo">' + dados.titulo + '</strong>' +
          '<div class="pm-barra" role="slider" aria-label="Posição da escuta" tabindex="0">' +
            '<div class="pm-progresso"></div>' +
          '</div>' +
          '<div class="pm-tempos">' +
            '<span class="pm-atual">0:00</span>' +
            '<button type="button" class="pm-velocidade" title="Velocidade de escuta">1×</button>' +
            '<span class="pm-total">–:––</span>' +
          '</div>' +
        '</div>' +
      '</div>';
    caixa.appendChild(audio);

    var botao = caixa.querySelector(".pm-botao");
    var barra = caixa.querySelector(".pm-barra");
    var progresso = caixa.querySelector(".pm-progresso");
    var atual = caixa.querySelector(".pm-atual");
    var total = caixa.querySelector(".pm-total");
    var botaoVel = caixa.querySelector(".pm-velocidade");

    function guardar() {
      try {
        if (audio.currentTime > 5 && !audio.ended) {
          localStorage.setItem(chave, String(Math.floor(audio.currentTime)));
        }
      } catch (e) { /* memória cheia: ignoramos */ }
    }

    botao.addEventListener("click", function () {
      if (audio.paused) { audio.play(); } else { audio.pause(); }
    });

    audio.addEventListener("play", function () {
      botao.textContent = "⏸";
      botao.setAttribute("aria-label", "Pausar");
    });
    audio.addEventListener("pause", function () {
      botao.textContent = "▶";
      botao.setAttribute("aria-label", "Ouvir");
      guardar();
    });
    audio.addEventListener("ended", function () {
      botao.textContent = "▶";
      try { localStorage.removeItem(chave); } catch (e) {}
    });
    audio.addEventListener("loadedmetadata", function () {
      total.textContent = tempo(audio.duration);
      /* retomar a escuta onde ficou */
      var marca = parseInt(localStorage.getItem(chave) || "0", 10);
      if (marca > 5 && marca < audio.duration - 5) {
        audio.currentTime = marca;
        atual.textContent = tempo(marca);
        progresso.style.width = (marca / audio.duration * 100) + "%";
      }
    });
    audio.addEventListener("timeupdate", function () {
      if (!isFinite(audio.duration)) return;
      atual.textContent = tempo(audio.currentTime);
      progresso.style.width = (audio.currentTime / audio.duration * 100) + "%";
    });

    /* clicar na barra = saltar */
    function saltarPara(evento) {
      if (!isFinite(audio.duration)) return;
      var rect = barra.getBoundingClientRect();
      var x = (evento.touches ? evento.touches[0].clientX : evento.clientX) - rect.left;
      var pct = Math.max(0, Math.min(1, x / rect.width));
      audio.currentTime = pct * audio.duration;
      progresso.style.width = (pct * 100) + "%";
    }
    barra.addEventListener("click", saltarPara);

    /* velocidade: 0.75× → 1× → 1.25× */
    var vel = 1;
    botaoVel.addEventListener("click", function () {
      vel = (vel + 1) % VELOCIDADES.length;
      audio.playbackRate = VELOCIDADES[vel];
      botaoVel.textContent = VELOCIDADES[vel] + "×";
    });

    window.addEventListener("beforeunload", guardar);
  }

  /* ---------- ainda sem voz ---------- */
  function construirEmBreve(caixa) {
    caixa.innerHTML =
      '<div class="pm-caixa pm-caixa--em-breve">' +
        '<span class="pm-simbolo">🎙️</span>' +
        '<div class="pm-info">' +
          '<strong class="pm-titulo">As vozes ainda estão a nascer</strong>' +
          '<p class="pm-texto">Em breve, cada crónica poderá ser ouvida — narrada, ' +
          'à maneira antiga, como se conta junto à fogueira.</p>' +
          '<p class="pm-texto">Queres ser dos primeiros a ouvir? ' +
          '<a href="mailto:associacaomaguezi@gmail.com">associacaomaguezi@gmail.com</a></p>' +
        '</div>' +
      '</div>';
  }

  /* ---------- arranque ---------- */
  document.addEventListener("DOMContentLoaded", function () {
    var caixas = document.querySelectorAll(".player-maguezi");
    Array.prototype.forEach.call(caixas, function (caixa) {
      var dados = {
        slug: caixa.getAttribute("data-livro"),
        numero: caixa.getAttribute("data-numero") || "Crónica",
        titulo: caixa.getAttribute("data-titulo") || ""
      };
      var base = caixa.getAttribute("data-base") || "audio/";
      if (!dados.slug) { construirEmBreve(caixa); return; }
      procurar(base, dados.slug, 0).then(function (url) {
        if (url) { construirPlayer(caixa, dados, url); }
        else { construirEmBreve(caixa); }
      });
    });
  });
})();
/* ============================================================
   MAGUEZI — A Campanha do Papel
   ------------------------------------------------------------
   OS NÚMEROS VIVEM AQUI. É o único sítio a actualizar:
   depois de cada apoio recebido, muda as três linhas abaixo.
   Todas as páginas com a barra (Portal + A Caminho do Papel)
   actualizam-se sozinhas.
   ============================================================ */

var ALVO       = 150000;  // EDITA: meta da campanha, em meticais
var ANGARIADO = 2500;    // era 0 — o valor de teste
var GUARDIOES  = 0;       // EDITA: número de apoiantes

(function () {
  "use strict";

  function mt(n) { return n.toLocaleString("pt-PT") + " MT"; }

  var pct = ALVO > 0 ? Math.min(100, Math.round((ANGARIADO / ALVO) * 100)) : 0;

  var barra = document.getElementById("barra-campanha");
  if (barra) barra.style.width = pct + "%";

  var valores = {
    "campanha-angariado": mt(ANGARIADO),
    "campanha-alvo":      mt(ALVO),
    "campanha-pct":       pct + "%",
    "campanha-guardioes": String(GUARDIOES)
  };

  for (var id in valores) {
    var el = document.getElementById(id);
    if (el) el.textContent = valores[id];
  }
})();
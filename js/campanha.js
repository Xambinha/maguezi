/* ============================================================
   MAGUEZI — A Campanha do Papel
   ------------------------------------------------------------
   OS NÚMEROS VIVEM AQUI. É o único sítio a actualizar:
   depois de cada apoio recebido, muda as três linhas abaixo.
   Todas as páginas com a barra (Portal + A Caminho do Papel)
   actualizam-se sozinhas.
   ============================================================ */

var ALVO       = 100;   // EDITA: quantas pessoas justificam a edicao piloto
var ANGARIADO = 5000;     // EDITA: quantas pessoas já responderam
var GUARDIOES  = 1;     // (mantém para a home usar o mesmo campo)

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
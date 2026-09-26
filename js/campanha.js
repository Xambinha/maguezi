/* ============================================================
   MAGUEZI — O Estado da Luz
   ------------------------------------------------------------
   OS NÚMEROS VIVEM AQUI. É o único sítio a actualizar.

   A barra conta guardiões — pessoas, escolas, instituições.
   Cada luz é uma luz, seja qual for a sua fonte.
   ============================================================ */

var ALVO       = 200;   // EDITA: quantos guardiões justificam a Edição Piloto
var GUARDIOES  = 0;     // EDITA: total (pessoas + escolas + instituições)
var ANGARIADO = 0;      // EDITA: total em MT (transparência)

(function () {
  "use strict";

  function mt(n) { return n.toLocaleString("pt-PT") + " MT"; }

  var pct = ALVO > 0 ? Math.min(100, Math.round((GUARDIOES / ALVO) * 100)) : 0;

  var barra = document.getElementById("barra-campanha");
  if (barra) barra.style.width = pct + "%";

  var slots = {
    "campanha-guardioes": String(GUARDIOES),
    "campanha-alvo":      String(ALVO),
    "campanha-pct":       pct + "%",
    "campanha-angariado": mt(ANGARIADO)
  };

  for (var id in slots) {
    var el = document.getElementById(id);
    if (el) el.textContent = slots[id];
  }
})();
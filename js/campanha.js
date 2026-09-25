/* ============================================================
   MAGUEZI — O Estado da Luz
   ------------------------------------------------------------
   OS NÚMEROS VIVEM AQUI. É o único sítio a actualizar.
   A cada apoio recebido, muda as duas linhas abaixo.

   Sem meta, sem percentagem — apenas o que arde:
   quantas pessoas, e quanto a comunidade escolheu dar.
   ============================================================ */

var GUARDIOES  = 0;     // EDITA: número de pessoas que já apoiaram
var ANGARIADO = 0;      // EDITA: total angariado, em meticais

(function () {
  "use strict";

  function mt(n) { return n.toLocaleString("pt-PT") + " MT"; }

  var slots = {
    "campanha-guardioes": String(GUARDIOES),
    "campanha-angariado": mt(ANGARIADO)
  };

  for (var id in slots) {
    var el = document.getElementById(id);
    if (el) el.textContent = slots[id];
  }
})();
/* ============================================================
   MAGUEZI — As Construções da Cidade de Luz
   ------------------------------------------------------------
   A barra conta MARCOS do projecto, não meticais.
   Cada construção alcançada acende a sua luz.

   OS NÚMEROS VIVEM AQUI. A cada marco alcançado,
   muda CONSTRUCOES. A cada apoio, muda os outros.
   ============================================================ */

// ---------- AS CONSTRUÇÕES ----------
var CONSTRUCOES = 1;    // EDITA: quantos marcos já erguidos
var TOTAL       = 4;   // Total de marcos na linha (fixo)

// ---------- A COMUNIDADE ----------
var GUARDIOES   = 0;   // EDITA: pessoas que apoiam
var INSTITUICOES = 0;  // EDITA: escolas, associações, empresas
var ANGARIADO   = 0;   // EDITA: total em apoios (MT)

// ---------- OS MARCOS (texto que aparece na linha) ----------
// A ordem é a da linha; o array diz quais já brilham
var MARCOS = [
  { simbolo: "📖", nome: "Portal Digital",       aceso: true  },
  { simbolo: "🎙️", nome: "Voz Narrada",          aceso: false },
  { simbolo: "📄", nome: "Edição Piloto",        aceso: false },
  { simbolo: "📚", nome: "Primeira Edição",      aceso: false }
];

(function () {
  "use strict";

  function mt(n) { return n.toLocaleString("pt-PT") + " MT"; }

  /* ---------- a barra ---------- */
  var pct = TOTAL > 0 ? Math.round((CONSTRUCOES / TOTAL) * 100) : 0;
  var barra = document.getElementById("barra-construcoes");
  if (barra) barra.style.width = pct + "%";

  /* ---------- a linha de marcos ---------- */
  var linha = document.getElementById("linha-construcoes");
  if (linha) {
    linha.innerHTML = "";
    for (var i = 0; i < MARCOS.length; i++) {
      var m = MARCOS[i];
      var div = document.createElement("div");
      div.className = "construcao" + (m.aceso ? " construcao--acesa" : "");
      div.innerHTML =
        '<span class="construcao__luz">' + (m.aceso ? m.simbolo : "·") + '</span>' +
        '<span class="construcao__nome">' + m.nome + '</span>';
      linha.appendChild(div);

      /* o traço entre marcos */
      if (i < MARCOS.length - 1) {
        var traco = document.createElement("div");
        traco.className = "construcao-traco" +
          (i < CONSTRUCOES - (MARCOS[0].aceso ? 1 : 0) ? " construcao-traco--aceso" : "");
        linha.appendChild(traco);
      }
    }
  }

  /* ---------- os números ---------- */
  var slots = {
    "campanha-construcoes": CONSTRUCOES + " de " + TOTAL,
    "campanha-guardioes":   String(GUARDIOES),
    "campanha-instituicoes": String(INSTITUICOES),
    "campanha-angariado":   mt(ANGARIADO)
  };
  for (var id in slots) {
    var el = document.getElementById(id);
    if (el) el.textContent = slots[id];
  }
})();
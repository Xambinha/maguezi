/* ============================================================
   MAGUEZI - A Chave Viva
   Em todas as paginas: a chave do menu sauda quem entrou.
   (So apresentacao - a seguranca continua no Supabase.)
   ============================================================ */
(function () {
  "use strict";
  var nome = null;
  try { nome = localStorage.getItem("maguezi.nome"); } catch (e) {}
  if (!nome) return;

  var links = document.querySelectorAll(
    'a[href="entrar.html"], a[href="../entrar.html"]'
  );
  for (var i = 0; i < links.length; i++) {
    links[i].textContent = "\u2726 " + nome;
    links[i].title = "A cidade reconhece-te";
  }
})();
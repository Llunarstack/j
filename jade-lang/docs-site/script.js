(function () {
  var path = window.location.pathname.replace(/\/$/, '') || '/index.html';
  document.querySelectorAll('.docs-sidebar a, .nav a').forEach(function (a) {
    var href = a.getAttribute('href') || '';
    if (path.indexOf(href.replace('.html', '')) !== -1 && href !== '/') a.classList.add('active');
  });
})();

(function () {
  function initRunButtons() {
    document.querySelectorAll('.runnable-example').forEach(function (block) {
      var btn = block.querySelector('.run-btn');
      var output = block.querySelector('.run-output');
      if (!btn || !output) return;
      output.classList.remove('is-visible');
      btn.addEventListener('click', function (e) {
        e.preventDefault();
        var visible = output.classList.toggle('is-visible');
        btn.setAttribute('aria-pressed', visible ? 'true' : 'false');
      });
      btn.setAttribute('aria-pressed', 'false');
    });
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initRunButtons);
  } else {
    initRunButtons();
  }
})();

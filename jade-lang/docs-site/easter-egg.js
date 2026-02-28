(function () {
  var konami = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];
  var index = 0;

  function showEgg() {
    var toast = document.createElement('div');
    toast.setAttribute('role', 'status');
    toast.setAttribute('aria-live', 'polite');
    toast.className = 'easter-egg-toast';
    toast.innerHTML = '🦆 You found the duck! Quack quack. 🦆';
    document.body.appendChild(toast);
    requestAnimationFrame(function () {
      toast.classList.add('easter-egg-show');
    });
    setTimeout(function () {
      toast.classList.remove('easter-egg-show');
      setTimeout(function () {
        if (toast.parentNode) toast.parentNode.removeChild(toast);
      }, 300);
    }, 4000);
  }

  document.addEventListener('keydown', function (e) {
    if (e.keyCode === konami[index]) {
      index++;
      if (index === konami.length) {
        index = 0;
        showEgg();
      }
    } else {
      index = 0;
    }
  });
})();

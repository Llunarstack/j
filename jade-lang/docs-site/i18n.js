(function () {
  var STORAGE_KEY = 'jade-docs-lang';

  var translations = {
    en: {
      'nav.docs': 'Documentation',
      'nav.installers': 'Installers',
      'lang.en': 'English',
      'lang.es': 'Español',
      'lang.fr': 'Français',
      'lang.de': 'Deutsch',
      'hero.tagline': 'Memory. Algorithms. Data structures. Code and tools for engineers who create.',
      'hero.get-started': 'Get started',
      'hero.browse-code': 'Browse code',
      'hero.run': 'Run',
      'run.output': 'Output',
      'features.why': 'Why Jade?',
      'features.subtitle': 'One language for scripts, tools, and small binaries. Built-in algorithms and data structures. No runtime to install—just one binary. Pipe-first syntax and optional types keep code short and clear.',
      'features.syntax-title': 'Syntax that scales',
      'features.syntax-desc': 'Pipe-style <code>fn | name (params) > body</code> and optional types: <code>(x, y)</code> or <code>(int | a, str | b)</code>. Less boilerplate, same clarity when you need it.',
      'features.batteries-title': 'Batteries included',
      'features.batteries-desc': 'DSA and algorithms built in: <code>kadane</code>, <code>fibonacci</code>, graphs, Union-Find, trie, crypto, regex. Plus <code>out</code>, <code>range</code>, <code>map</code>, <code>filter</code>, and 100+ more. No hunting for libs.',
      'features.binary-title': 'One binary, every platform',
      'features.binary-desc': 'Run files, REPL, or build a native executable. <code>jade file.jdl</code>, <code>jade repl</code>, <code>jade build file.jdl -o app</code>. No separate runtime or interpreter install.',
      'showcase.title': 'Cool features in one place',
      'showcase.subtitle': 'Match expressions, comprehensions, pipelines, graphs, crypto, and 100+ built-ins. One reference page.',
      'showcase.cta': 'Language reference',
      'install.title': 'Install',
      'install.subtitle': 'Windows, macOS, or from source.',
      'install.link': 'Download installers →',
      'footer.text': 'Jade 1.0.0 · Documentation from the interpreter'
    },
    es: {
      'nav.docs': 'Documentación',
      'nav.installers': 'Instaladores',
      'lang.en': 'English',
      'lang.es': 'Español',
      'lang.fr': 'Français',
      'lang.de': 'Deutsch',
      'hero.tagline': 'Memoria. Algoritmos. Estructuras de datos. Código y herramientas para quien construye.',
      'hero.get-started': 'Comenzar',
      'hero.browse-code': 'Ver código',
      'hero.run': 'Ejecutar',
      'run.output': 'Salida',
      'features.why': '¿Por qué Jade?',
      'features.subtitle': 'Un lenguaje para scripts, herramientas y binarios pequeños. Algoritmos y estructuras de datos incluidos. Sin runtime que instalar: un solo binario. Sintaxis con pipes y tipos opcionales.',
      'features.syntax-title': 'Sintaxis que escala',
      'features.syntax-desc': 'Estilo pipe <code>fn | name (params) > body</code> y tipos opcionales: <code>(x, y)</code> o <code>(int | a, str | b)</code>. Menos relleno, la misma claridad.',
      'features.batteries-title': 'Baterías incluidas',
      'features.batteries-desc': 'DSA y algoritmos incluidos: <code>kadane</code>, <code>fibonacci</code>, grafos, Union-Find, trie, crypto, regex. Más <code>out</code>, <code>range</code>, <code>map</code>, <code>filter</code> y 100+ más. Sin buscar librerías.',
      'features.binary-title': 'Un binario, toda plataforma',
      'features.binary-desc': 'Ejecuta archivos, REPL o compila a ejecutable nativo. <code>jade file.jdl</code>, <code>jade repl</code>, <code>jade build file.jdl -o app</code>. Sin runtime ni intérprete aparte.',
      'showcase.title': 'Funciones en un solo lugar',
      'showcase.subtitle': 'Expresiones match, comprehensions, pipelines, grafos, crypto y 100+ built-ins. Una sola página de referencia.',
      'showcase.cta': 'Referencia del lenguaje',
      'install.title': 'Instalar',
      'install.subtitle': 'Windows, macOS o desde fuentes.',
      'install.link': 'Descargar instaladores →',
      'footer.text': 'Jade 1.0.0 · Documentación del intérprete'
    },
    fr: {
      'nav.docs': 'Documentation',
      'nav.installers': 'Installation',
      'lang.en': 'English',
      'lang.es': 'Español',
      'lang.fr': 'Français',
      'lang.de': 'Deutsch',
      'hero.tagline': 'Mémoire. Algorithmes. Structures de données. Code et outils pour qui crée.',
      'hero.get-started': 'Commencer',
      'hero.browse-code': 'Parcourir le code',
      'hero.run': 'Exécuter',
      'run.output': 'Sortie',
      'features.why': 'Pourquoi Jade ?',
      'features.subtitle': 'Un langage pour scripts, outils et petits binaires. Algorithmes et structures de données intégrés. Aucun runtime à installer—un seul binaire. Syntaxe pipe et types optionnels.',
      'features.syntax-title': 'Une syntaxe qui scale',
      'features.syntax-desc': 'Style pipe <code>fn | name (params) > body</code> et types optionnels : <code>(x, y)</code> ou <code>(int | a, str | b)</code>. Moins de boilerplate, même clarté.',
      'features.batteries-title': 'Batteries incluses',
      'features.batteries-desc': 'DSA et algorithmes intégrés : <code>kadane</code>, <code>fibonacci</code>, graphes, Union-Find, trie, crypto, regex. Plus <code>out</code>, <code>range</code>, <code>map</code>, <code>filter</code> et 100+ autres. Pas de chasse aux libs.',
      'features.binary-title': 'Un binaire, toute plateforme',
      'features.binary-desc': 'Exécuter des fichiers, REPL ou compiler en natif. <code>jade file.jdl</code>, <code>jade repl</code>, <code>jade build file.jdl -o app</code>. Pas de runtime ni interpréteur séparé.',
      'showcase.title': 'Fonctionnalités en un lieu',
      'showcase.subtitle': 'Expressions match, comprehensions, pipelines, graphes, crypto et 100+ built-ins. Une page de référence.',
      'showcase.cta': 'Référence du langage',
      'install.title': 'Installation',
      'install.subtitle': 'Windows, macOS ou depuis les sources.',
      'install.link': 'Télécharger les installateurs →',
      'footer.text': 'Jade 1.0.0 · Documentation de l\'interpréteur'
    },
    de: {
      'nav.docs': 'Dokumentation',
      'nav.installers': 'Installation',
      'lang.en': 'English',
      'lang.es': 'Español',
      'lang.fr': 'Français',
      'lang.de': 'Deutsch',
      'hero.tagline': 'Speicher. Algorithmen. Datenstrukturen. Code und Werkzeuge für alle, die bauen.',
      'hero.get-started': 'Loslegen',
      'hero.browse-code': 'Code durchsuchen',
      'hero.run': 'Ausführen',
      'run.output': 'Ausgabe',
      'features.why': 'Warum Jade?',
      'features.subtitle': 'Eine Sprache für Skripte, Tools und kleine Binärdateien. Eingebaute Algorithmen und Datenstrukturen. Kein Runtime-Install—nur eine Binärdatei. Pipe-Syntax und optionale Typen.',
      'features.syntax-title': 'Syntax die skaliert',
      'features.syntax-desc': 'Pipe-Style <code>fn | name (params) > body</code> und optionale Typen: <code>(x, y)</code> oder <code>(int | a, str | b)</code>. Weniger Boilerplate, gleiche Klarheit.',
      'features.batteries-title': 'Batterien inklusive',
      'features.batteries-desc': 'DSA und Algorithmen eingebaut: <code>kadane</code>, <code>fibonacci</code>, Graphen, Union-Find, Trie, Crypto, Regex. Plus <code>out</code>, <code>range</code>, <code>map</code>, <code>filter</code> und 100+ mehr. Keine Lib-Suche.',
      'features.binary-title': 'Eine Binärdatei, jede Plattform',
      'features.binary-desc': 'Dateien ausführen, REPL oder natives Binary bauen. <code>jade file.jdl</code>, <code>jade repl</code>, <code>jade build file.jdl -o app</code>. Kein separates Runtime-Install.',
      'showcase.title': 'Features an einem Ort',
      'showcase.subtitle': 'Match-Ausdrücke, Comprehensions, Pipelines, Graphen, Crypto und 100+ Built-ins. Eine Referenzseite.',
      'showcase.cta': 'Sprachreferenz',
      'install.title': 'Installation',
      'install.subtitle': 'Windows, macOS oder aus den Quellen.',
      'install.link': 'Installer herunterladen →',
      'footer.text': 'Jade 1.0.0 · Dokumentation des Interpreters'
    }
  };

  var langCodes = { en: 'EN', es: 'ES', fr: 'FR', de: 'DE' };

  function getStoredLang() {
    try {
      var s = localStorage.getItem(STORAGE_KEY);
      return s && translations[s] ? s : 'en';
    } catch (e) {
      return 'en';
    }
  }

  function setStoredLang(lang) {
    try {
      localStorage.setItem(STORAGE_KEY, lang);
    } catch (e) {}
  }

  function applyLang(lang) {
    var t = translations[lang] || translations.en;
    document.documentElement.lang = lang === 'en' ? 'en' : lang;

    document.querySelectorAll('[data-i18n]').forEach(function (el) {
      var key = el.getAttribute('data-i18n');
      if (t[key] == null) return;
      if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
        el.placeholder = t[key];
        return;
      }
      var val = t[key];
      if (typeof val === 'string' && val.indexOf('<') !== -1) {
        el.innerHTML = val;
      } else {
        el.textContent = val;
      }
    });

    var label = document.getElementById('lang-label');
    if (label) label.textContent = langCodes[lang] || lang.toUpperCase();

    document.querySelectorAll('.lang-option').forEach(function (opt) {
      opt.classList.toggle('active', opt.getAttribute('data-lang') === lang);
    });

    setStoredLang(lang);
  }

  function initLangSwitcher() {
    var btn = document.getElementById('lang-btn');
    var dropdown = document.getElementById('lang-dropdown');
    if (!btn || !dropdown) return;

    var lang = getStoredLang();
    applyLang(lang);

    btn.addEventListener('click', function (e) {
      e.stopPropagation();
      var open = dropdown.classList.toggle('open');
      btn.setAttribute('aria-expanded', open);
    });

    dropdown.querySelectorAll('.lang-option').forEach(function (opt) {
      opt.addEventListener('click', function (e) {
        e.stopPropagation();
        var l = opt.getAttribute('data-lang');
        if (translations[l]) {
          applyLang(l);
          dropdown.classList.remove('open');
          btn.setAttribute('aria-expanded', 'false');
        }
      });
    });

    document.addEventListener('click', function () {
      dropdown.classList.remove('open');
      btn.setAttribute('aria-expanded', 'false');
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initLangSwitcher);
  } else {
    initLangSwitcher();
  }
})();

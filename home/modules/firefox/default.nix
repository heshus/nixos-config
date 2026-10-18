{ pkgs, inputs, ... }:

let
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};

  pinned = [
    { url = "https://www.youtube.com/"; title = "YouTube"; }
    { url = "https://mail.google.com/mail/u/0/#inbox"; title = "Gmail"; }
    { url = "https://chatgpt.com/"; title = "ChatGPT"; }
    { url = "https://chat.deepseek.com/"; title = "DeepSeek"; }
    { url = "https://gemini.google.com/app?hl=ru"; title = "Gemini"; }
    { url = "https://claude.ai/new"; title = "Claude"; }
    { url = "https://ru.dotabuff.com/"; title = "Dotabuff"; }
    { url = "https://dota2protracker.com/"; title = "Dota2ProTracker"; }
    { url = "https://github.com/"; title = "GitHub"; }
    { url = "https://rutracker.org/forum/index.php"; title = "RuTracker"; }
    { url = "https://wiki.archlinux.org/title/Main_page"; title = "ArchWiki"; }
    { url = "https://www.chess.com/home"; title = "Chess.com"; }
    { url = "https://lichess.org/"; title = "Lichess"; }
    { url = "https://open.spotify.com/"; title = "Spotify"; }
  ];
in
{
  programs.firefox = {
    enable = true;

    # Установка русского интерфейса
    languagePacks = [ "ru" ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      NoDefaultBookmarks = true;

      # Из example_user.js (раньше это делал policies.json). Мягкий DoH: VPN у тебя то вкл., то выкл.
      DisableFormHistory = true;
      DontCheckDefaultBrowser = true;
      HttpsOnlyMode = "enabled";

      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://dns.adguard-dns.com/dns-query";
        Locked = false; # можно менять в настройках Firefox
        Fallback = true; # если DoH недоступен (например, при смене VPN), откат на обычный DNS
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # userChrome/userContent НЕ задаём здесь: вся папка chrome/ кладётся
      # через home.file ниже (тема Malevich подключает модули через @import).

      settings = {
        # ───────── Язык и интерфейс ─────────
        "intl.locale.requested" = "ru,en-US";
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "general.autoScroll" = true;
        "findbar.highlightAll" = true;

        # ───────── Шрифты сайтов ─────────
        "font.name.sans-serif.x-cyrillic" = "Roboto";
        "font.name.sans-serif.x-western" = "Roboto";

        # ───────── Запуск и новая вкладка ─────────
        "browser.aboutConfig.showWarning" = false;
        # При запуске: пустая страница. Новая вкладка (Ctrl+T): твои закреплённые сайты.
        "browser.startup.page" = 0;
        "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
        "browser.newtabpage.activity-stream.topSitesRows" = 3;
        "browser.newtabpage.pinned" = builtins.toJSON pinned;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtab.preload" = false;
        "browser.shell.checkDefaultBrowser" = false;

        # ───────── Геолокация ─────────
        "geo.provider.ms-windows-location" = false;
        "geo.provider.use_corelocation" = false;
        "geo.provider.use_geoclue" = false;

        # ───────── Тишина: отчёты, рекомендации, фоновые запросы ─────────
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";

        # ───────── Нативные вертикальные вкладки и сайдбар (для Malevich) ─────────
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "sidebar.revamp" = true;
        "sidebar.revamp.defaultLauncherVisible" = false;
        "sidebar.verticalTabs" = true;
        "sidebar.position_start" = true;
        "sidebar.visibility" = "expand-on-hover";
        "sidebar.animation.expand-on-hover.duration-ms" = 130;
        "sidebar.animation.expand-on-hover.delay-duration-ms" = 65;
        "sidebar.main.tools" = "history,bookmarks";
        "browser.sidebar.useCurrentTab" = true;
        "browser.sidebar.moveOnResize" = false;
        "browser.sidebar.width" = 280;
        "browser.sidebar.panels.animations" = false;
        "browser.tabs.allowAnimationPreference" = false;
        "browser.tabs.animate" = false;
        "browser.bookmarks.showMobileBookmarks" = false;
        "browser.bookmarks.showDesktopBookmarks" = false;

        # ───────── Без неявных исходящих соединений ─────────
        "network.prefetch-next" = false;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.speculative-parallel-limit" = 0;
        "browser.places.speculativeConnect.enabled" = false;

        # ───────── DNS / прокси (DoH в мягком режиме задан в policies) ─────────
        "network.proxy.socks_remote_dns" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";
        "network.dnsCacheEntries" = 10000;
        "network.dnsCacheExpiration" = 3600;

        # ───────── Адресная строка и поиск ─────────
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.amp.featureGate" = false;
        "browser.urlbar.importantDates.featureGate" = false;
        "browser.urlbar.market.featureGate" = false;
        "browser.urlbar.mdn.featureGate" = false;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.wikipedia.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.urlbar.yelpRealtime.featureGate" = false;
        "browser.urlbar.clipboard.featureGate" = false;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        # Подсказки поисковика (Google) включены
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.suggest.engines" = true;
        "browser.urlbar.showSearchTerms.enabled" = false;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.maxRichResults" = 12;
        "browser.search.separatePrivateDefault" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;

        # ───────── Пароли и формы (встроенный менеджер Firefox работает как обычно) ─────────
        "signon.autologin.proxy" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "browser.formfill.enable" = false;

        # ───────── Кэш: диск выключен, всё в RAM ─────────
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.capacity" = 262144;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "media.memory_cache_max_size" = 65536;
        "browser.sessionstore.privacy_level" = 2;
        "browser.sessionhistory.max_total_viewers" = 4;
        "browser.sessionstore.max_tabs_undo" = 10;
        "browser.shell.shortcutFavicons" = false;

        # ───────── Производительность ─────────
        "browser.sessionstore.interval" = 60000;
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.tabs.min_inactive_duration_before_unload" = 300000;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.pacing.requests.enabled" = false;
        "network.ssl_tokens_cache_capacity" = 10240;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.download.manager.addToRecentDocs" = false;

        # ───────── HTTPS / TLS / сертификаты (HTTPS-Only задан в policies) ─────────
        "security.ssl.enable_ocsp_stapling" = true;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "security.ssl.require_safe_negotiation" = true;
        "security.OCSP.enabled" = 0;
        "security.tls.version.min" = 3;
        "security.tls.enable_0rtt_data" = false;
        "security.tls.version.enable-deprecated" = false;
        "security.cert_pinning.enforcement_level" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;
        "dom.security.https_only_mode_error_page_user_suggestions" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;

        # ───────── Загрузки ─────────
        "browser.download.open_pdf_attachments_inline" = true;
        "pdfjs.enableScripting" = false;
        "browser.download.useDownloadDir" = true; # сразу в «Загрузки», без вопросов
        "browser.download.alwaysOpenPanel" = false;
        "browser.download.always_ask_before_handling_new_types" = false;

        # ───────── Расширения ─────────
        # Нужен, чтобы расширения из Nix включались автоматически
        "extensions.autoDisableScopes" = 0;
        "extensions.postDownloadThirdPartyPrompt" = false;

        # ───────── DOM / прочее ─────────
        "dom.disable_window_move_resize" = true;
        "permissions.manager.defaultsUrl" = "";
        "network.IDN_show_punycode" = true;
        "browser.tabs.searchclipboardfor.middleclick" = false;
        "browser.contentanalysis.enabled" = false;
        "browser.contentanalysis.default_result" = 0;
        "security.csp.reporting.enabled" = false;
        "privacy.antitracking.isolateContentScriptResources" = true;
        "browser.link.open_newwindow.restriction" = 0;
        "browser.privateWindowSeparation.enabled" = false;
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "layout.word_select.eat_space_to_next_word" = false;

        # ───────── Referer ─────────
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.referer.defaultPolicy" = 2;
        "network.http.referer.defaultPolicy.pbmode" = 2;
        "network.http.referer.disallowCrossSiteRelaxingDefault" = true;
        "network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = true;

        # ───────── Контейнеры / изоляция ─────────
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;

        # ───────── Разрешения сайтов ─────────
        # Камера и микрофон: обычный запрос разрешения (нужны для Discord/Meet).
        # Уведомления и геолокация заблокированы; разрешать вручную через замочек.
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;

        # ───────── Поведение интерфейса ─────────
        "browser.fullscreen.animateUp" = 0;
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "apz.overscroll.enabled" = false;
        "browser.compactmode.show" = true;
        "browser.profiles.enabled" = true;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.tabs.drawInTitlebar" = false;
        "browser.tabs.tabClipWidth" = 110;
        "browser.tabs.tabMaxWidth" = 160;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.download.autohideButton" = false;
        "browser.chrome.site_icons" = false;

        # ───────── Тёмная тема ─────────
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "browser.theme.dark-private-windows" = false;
        "browser.display.background_color" = "#000000";
        "browser.display.background_color.dark" = "#000000";
        "layout.css.prefers-color-scheme.content-override" = 0;
        "ui.systemUsesDarkTheme" = 1;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        # ───────── WebRTC / медиа ─────────
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.getusermedia.screensharing.allowed_domains" = "";
        # Автовоспроизведение: настройки Firefox по умолчанию (специально не трогаем).
        # ВАЖНО: "media.volume_scale" = "0.0" из оригинального файла убран,
        # он выставляет громкость всех медиа в ноль.

        # ───────── Защита от отслеживания ─────────
        "browser.contentblocking.category" = "strict";
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.sanitize.timeSpan" = 0;

        # ───────── Базовое (не трогать) ─────────
        "extensions.blocklist.enabled" = true;
        "network.http.referer.spoofSource" = false;
        "security.dialog_enable_delay" = 1000;
        "privacy.firstparty.isolate" = false;
        "extensions.webcompat.enable_shims" = true;
        "extensions.webcompat-reporter.enabled" = false;
        "extensions.quarantinedDomains.enabled" = true;

        # ───────── Телеметрия: полностью выключена ─────────
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.usage.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.telemetry.dap_enabled" = false;
        "dom.private-attribution.submission.enabled" = false;

        # ───────── Мусор: онбординг, Pocket, перевод, ИИ + настройки Sync ─────────
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.uitour.enabled" = false;
        "browser.uitour.url" = "";
        "browser.firefox-view.feature-tour" = false;

        # Sync включён, но синхронизируются только пароли и история
        "services.sync.engine.passwords" = true;
        "services.sync.engine.history" = true;
        "services.sync.engine.tabs" = false;
        "services.sync.engine.bookmarks" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.addons" = false;
        "services.sync.engine.addresses" = false;
        "services.sync.engine.creditcards" = false;

        "browser.translations.enable" = false;
        "browser.translations.autoTranslate" = false;
        "browser.translations.ui.enabled" = false;

        "extensions.pocket.enabled" = false;
        "extensions.pocket.oAuthConsumerKey" = "";
        "extensions.pocket.api" = "";
        "extensions.pocket.site" = "";
        "extensions.pocket.showHome" = false;

        "browser.ai.control.default" = "blocked";
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;

        # ───────── Интеграция с Wayland / видео ─────────
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
      };

      search = {
        force = true;
        default = "google";
        privateDefault = "google";

        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "bing".metaData.hidden = true;
        };
      };

      extensions = {
        force = true;

        packages = with addons; [
          ublock-origin
          darkreader
          sponsorblock
          addons."return-youtube-dislikes"
          protondb-for-steam
          to-google-translate
          vimium
          # adaptive-tab-bar-colour  # с Malevich не нужен: вкладки скрыты, тема тёмная
          search-by-image
        ];
      };
    };
  };

  # Тема Malevich: локальная копия папки chrome/ лежит рядом с этим файлом.
  # Путь профиля: ~/.mozilla/firefox/default/. Если у тебя профили лежат в
  # ~/.config/mozilla/firefox/, поправь путь.
  home.file.".mozilla/firefox/default/chrome" = {
    source = ./chrome;
    recursive = true;
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  home.sessionVariables.BROWSER = "firefox";
}

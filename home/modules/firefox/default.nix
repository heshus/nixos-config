{ pkgs, inputs, ... }:

let
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};

  # Sites pinned on the new tab page
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

    languagePacks = [ "ru" ];

    # ════════════════════════════════════════════════════════════════
    #  POLICIES (enterprise policies, applied to the whole browser)
    # ════════════════════════════════════════════════════════════════
    policies = {
      # --- Telemetry and junk ---
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      NoDefaultBookmarks = true;
      DisableFormHistory = true;
      DontCheckDefaultBrowser = true;

      # --- Security ---
      HttpsOnlyMode = "enabled";

      # Soft DoH: your VPN is sometimes on and sometimes off,
      # so Firefox falls back to normal DNS if DoH is not reachable.
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://dns.adguard-dns.com/dns-query";
        Locked = false; # you can still change it in Firefox settings
        Fallback = true;
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # --- Home page and messages ---
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

    # ════════════════════════════════════════════════════════════════
    #  PROFILE
    # ════════════════════════════════════════════════════════════════
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # ──────────────────────────────────────────────────────────────
      #  SETTINGS (about:config)
      # ──────────────────────────────────────────────────────────────
      settings = {

        # ───────── General: language and basic behavior ─────────
        "intl.locale.requested" = "ru,en-US";
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "general.autoScroll" = true;
        "findbar.highlightAll" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.shell.checkDefaultBrowser" = false;

        # ───────── Fonts ─────────
        "font.name.sans-serif.x-cyrillic" = "Roboto";
        "font.name.sans-serif.x-western" = "Roboto";

        # ───────── Startup and new tab ─────────
        "browser.startup.page" = 1;
        "browser.newtabpage.pinned" = builtins.toJSON pinned;
        "browser.newtabpage.activity-stream.topSitesRows" = 2;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtab.preload" = false;

        # ───────── Sidebar and vertical tabs ─────────
        "sidebar.revamp" = true;
        "sidebar.revamp.defaultLauncherVisible" = false;
        "sidebar.verticalTabs" = true;
        "sidebar.position_start" = true;
        "sidebar.visibility" = "expand-on-hover";
        "sidebar.main.tools" = "history,bookmarks";
        "browser.sidebar.useCurrentTab" = true;
        "browser.sidebar.moveOnResize" = false;
        "browser.sidebar.width" = 280;

        # ───────── Interface behavior ─────────
        "browser.compactmode.show" = true;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.chrome.site_icons" = true;
        "browser.link.open_newwindow.restriction" = 0;
        "browser.menu.showViewImageInfo" = true;
        "browser.tabs.searchclipboardfor.middleclick" = false;
        "layout.word_select.eat_space_to_next_word" = false;
        "dom.disable_window_move_resize" = true;

        # ───────── Bookmarks ─────────
        "browser.bookmarks.showMobileBookmarks" = false;
        "browser.bookmarks.showDesktopBookmarks" = false;
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.toolbars.bookmarks.visibility" = "never";

        # ───────── Address bar and search ─────────
        # Turn off sponsored and extra suggestions
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

        # Search engine suggestions (Google) stay on
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.suggest.engines" = true;
        "browser.urlbar.showSearchTerms.enabled" = false;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.maxRichResults" = 12;
        "browser.search.separatePrivateDefault" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;

        # ───────── Passwords and forms ─────────
        # The built-in Firefox password manager works as usual
        "signon.autologin.proxy" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "browser.formfill.enable" = false;

        # ───────── Downloads ─────────
        "browser.download.open_pdf_attachments_inline" = true;
        "pdfjs.enableScripting" = false;
        "browser.download.useDownloadDir" = true; # save to Downloads, don't ask
        "browser.download.alwaysOpenPanel" = false;
        "browser.download.always_ask_before_handling_new_types" = false;
        "browser.download.autohideButton" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.helperApps.deleteTempFileOnExit" = true;

        # ───────── Extensions ─────────
        # Needed so extensions from Nix are enabled automatically
        "extensions.autoDisableScopes" = 0;
        "extensions.postDownloadThirdPartyPrompt" = false;
        "extensions.blocklist.enabled" = true;
        "extensions.webcompat.enable_shims" = true;
        "extensions.webcompat-reporter.enabled" = false;
        "extensions.quarantinedDomains.enabled" = true;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # ───────── Network: no hidden connections ─────────
        "network.prefetch-next" = false;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.speculative-parallel-limit" = 0;
        "browser.places.speculativeConnect.enabled" = false;
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";

        # ───────── Network: DNS and proxy ─────────
        # Soft DoH is set in policies above
        "network.proxy.socks_remote_dns" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";
        "network.dnsCacheEntries" = 10000;
        "network.dnsCacheExpiration" = 3600;

        # ───────── Cache: no disk cache, everything in RAM ─────────
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.capacity" = 262144;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "media.memory_cache_max_size" = 65536;
        "browser.sessionstore.privacy_level" = 2;
        "browser.sessionhistory.max_total_viewers" = 4;
        "browser.sessionstore.max_tabs_undo" = 10;
        "browser.shell.shortcutFavicons" = false;

        # ───────── Performance ─────────
        "browser.sessionstore.interval" = 60000;
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.tabs.min_inactive_duration_before_unload" = 300000;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.pacing.requests.enabled" = false;
        "network.ssl_tokens_cache_capacity" = 10240;

        # ───────── HTTPS, TLS and certificates ─────────
        # HTTPS-Only mode is set in policies above
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
        "security.dialog_enable_delay" = 1000;
        "network.IDN_show_punycode" = true;
        "dom.security.https_only_mode_error_page_user_suggestions" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;

        # ───────── Privacy: tracking protection ─────────
        "browser.contentblocking.category" = "strict";
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.sanitize.timeSpan" = 0;
        "privacy.firstparty.isolate" = false;
        "privacy.antitracking.isolateContentScriptResources" = true;
        "browser.privateWindowSeparation.enabled" = false;

        # ───────── Privacy: containers ─────────
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;

        # ───────── Privacy: referer ─────────
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.referer.defaultPolicy" = 2;
        "network.http.referer.defaultPolicy.pbmode" = 2;
        "network.http.referer.disallowCrossSiteRelaxingDefault" = true;
        "network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = true;
        "network.http.referer.spoofSource" = false;

        # ───────── Site permissions ─────────
        # Camera and microphone: normal permission prompt (needed for Discord/Meet).
        # Notifications and location are blocked; allow them by hand via the lock icon.
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "permissions.manager.defaultsUrl" = "";
        "geo.provider.ms-windows-location" = false;
        "geo.provider.use_corelocation" = false;
        "geo.provider.use_geoclue" = false;

        # ───────── WebRTC and media ─────────
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.getusermedia.screensharing.allowed_domains" = "";
        # Autoplay: Firefox defaults (left untouched on purpose).
        # NOTE: "media.volume_scale" = "0.0" from the old file was removed,
        # because it sets the volume of all media to zero.

        # ───────── Telemetry and reports: fully off ─────────
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
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "security.csp.reporting.enabled" = false;
        "browser.contentanalysis.enabled" = false;
        "browser.contentanalysis.default_result" = 0;

        # ───────── Junk: onboarding, recommendations, Pocket ─────────
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.uitour.enabled" = false;
        "browser.uitour.url" = "";
        "browser.firefox-view.feature-tour" = false;

        "extensions.pocket.enabled" = false;
        "extensions.pocket.oAuthConsumerKey" = "";
        "extensions.pocket.api" = "";
        "extensions.pocket.site" = "";
        "extensions.pocket.showHome" = false;

        # ───────── Sync: only passwords and history ─────────
        "services.sync.engine.passwords" = true;
        "services.sync.engine.history" = true;
        "services.sync.engine.tabs" = false;
        "services.sync.engine.bookmarks" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.addons" = false;
        "services.sync.engine.addresses" = false;
        "services.sync.engine.creditcards" = false;

        # ───────── AI features ─────────
        # Block everything by default, then allow only the translator.
        "browser.ai.control.default" = "blocked";

        # Built-in translator (the only AI feature we want)
        "browser.translations.enable" = true;
        "browser.ml.enable" = true;
        "browser.ai.control.translations" = "default";

        # Everything else stays off
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;

        # ───────── Wayland and video ─────────
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
      };

      # ──────────────────────────────────────────────────────────────
      #  SEARCH ENGINES
      # ──────────────────────────────────────────────────────────────
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

      # ──────────────────────────────────────────────────────────────
      #  EXTENSIONS
      # ──────────────────────────────────────────────────────────────
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
        ];
      };
    };
  };

  # ══════════════════════════════════════════════════════════════════
  #  DEFAULT BROWSER
  # ══════════════════════════════════════════════════════════════════
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

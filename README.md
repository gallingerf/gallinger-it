# gallinger.it – Website

Statische Website der Gallinger IT GmbH.

**Live-Hosting: Tecspace (securehost), Auslieferung per nginx unter https://gallinger.it (gallinger-it.de leitet dorthin um).**
GitHub Pages (gallingerf.github.io/gallinger-it) ist nur ein Spiegel dieses Repos, ein `git push` ändert die Live-Seite NICHT.

## Deploy (Live-Seite aktualisieren)

```
cd c:\projects\gallinger-tools
.venv\Scripts\python.exe tools\webseite\deploy_ftp.py --seit HEAD~1   # nur geänderte Dateien
.venv\Scripts\python.exe tools\webseite\deploy_ftp.py               # alles
```

Zugangsdaten liegen in 1Password (Tresor `betrieb`, Item „FTP Tecspace gallinger-it.de"), das Skript holt sie über das op-Relay.
`versand/` (interner Briefkopf) und `v1/` (Altversion) werden nie hochgeladen.

## Struktur

```
gallinger-it/
├── index.html          # Startseite
├── impressum.html      # Impressum
├── datenschutz.html    # Datenschutzerklärung
├── css/
│   └── style.css       # Gemeinsames Stylesheet
└── README.md
```

## GitHub Pages (nur Spiegel, historisch)

1. Repository anlegen: `gallinger-it` (oder beliebiger Name)
2. Code pushen
3. In den Repository-Einstellungen unter **Pages** → Source: `main` Branch, Root `/`
4. Custom Domain: `gallinger.it` eintragen
5. **Enforce HTTPS** aktivieren

Danach in Cloudflare DNS:
- `CNAME www → dein-username.github.io`
- Vier `A`-Records für `@` auf GitHub Pages IPs (185.199.108-111.153)

## Google Fonts lokal hosten (DSGVO-konform)

Aktuell werden Fonts von Google-Servern geladen. Für den produktiven Betrieb
empfiehlt sich die lokale Einbindung:

1. Fonts herunterladen über https://google-webfonts-helper.herokuapp.com
   - DM Serif Display (regular, italic)
   - DM Sans (300, 400, 500)

2. Dateien in `/fonts/` ablegen

3. In `css/style.css` den `@import`-Block ersetzen durch lokale `@font-face`-Regeln

4. In allen HTML-Dateien den Google Fonts `<link>`-Tag entfernen

5. In `datenschutz.html` Abschnitt 3 (Google Fonts) entsprechend anpassen
   oder entfernen, da dann keine Verbindung zu Google mehr stattfindet.

## Pflege

Inhalte ändern sich selten. Bei Bedarf direkt in den HTML-Dateien bearbeiten, committen, pushen (Spiegel) und **per FTP-Skript deployen** (siehe oben), sonst bleibt die Live-Seite alt.

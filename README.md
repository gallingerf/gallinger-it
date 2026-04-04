# gallinger.it – Website

Statische Website für Gallinger IT, gehostet auf GitHub Pages.

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

## GitHub Pages einrichten

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

Inhalte ändern sich selten – bei Bedarf direkt in den HTML-Dateien bearbeiten
und pushen. GitHub Pages deployed automatisch innerhalb weniger Minuten.

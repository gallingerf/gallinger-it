# gallinger.it – Website

Statische Website der Gallinger IT GmbH.

**Live-Hosting: Tecspace (securehost), Auslieferung per nginx unter https://gallinger.it (gallinger-it.de leitet dorthin um).**
GitHub ist nur die Sicherung dieses Repos. GitHub Pages ist seit dem 10.11.2026 abgeschaltet, ein `git push` ändert die Live-Seite NICHT.

## Deploy (Live-Seite aktualisieren)

```
cd c:\projects\gallinger-tools
.venv\Scripts\python.exe tools\webseite\deploy_ftp.py --seit HEAD~1   # nur geänderte Dateien
.venv\Scripts\python.exe tools\webseite\deploy_ftp.py               # alles
.venv\Scripts\python.exe tools\webseite\deploy_ftp.py --loeschen <datei>   # aus dem Repo entfernte Datei auch live löschen
```

Zugangsdaten liegen in 1Password (Tresor `betrieb`, Item „FTP Tecspace gallinger-it.de"), das Skript holt sie über das op-Relay.
`versand/` (interner Briefkopf) und `v1/` (Altversion) werden nie hochgeladen.
Ein Upload entfernt nichts: Wer eine Datei aus dem Repo löscht, nimmt sie mit `--loeschen` auch vom Server.

## Struktur

```
gallinger-it/
├── index.html          # Startseite
├── impressum.html      # Impressum
├── datenschutz.html    # Datenschutzerklärung
├── 404.html            # Fehlerseite
├── .htaccess           # HTTPS, Weiterleitungen, saubere URLs, Security-Header, PHP-Sperre
├── robots.txt, sitemap.xml
├── css/style.css       # Gemeinsames Stylesheet
├── fonts/              # Plus Jakarta Sans, Inter (lokal gehostet)
├── img/                # Hero, DURIA-Hintergrund, Vorschaubild des Films
├── video/              # Imagefilm (selbst gehostet)
├── versand/            # interner Briefkopf, wird nicht hochgeladen
└── v1/                 # Altversion, wird nicht hochgeladen
```

## Keine Verbindungen zu Dritten

Schriftarten liegen lokal in `fonts/`, die Icons sind als SVG direkt in die Seiten eingebettet, der Imagefilm kommt vom eigenen Webserver. Beim Laden der Seite geht keine Anfrage an fremde Server. So steht es auch in der Datenschutzerklärung (Abschnitt 3). Wer etwas Externes einbindet (Schrift, Skript, Video, Karte), muss die Datenschutzerklärung im selben Zug anpassen.

## Pflege

Inhalte ändern sich selten. Bei Bedarf direkt in den HTML-Dateien bearbeiten, committen und **per FTP-Skript deployen** (siehe oben), sonst bleibt die Live-Seite alt. Bei Änderungen an einer Seite das `lastmod`-Datum in `sitemap.xml` nachziehen.

# SwissHostedSolutions Website

Repo for the website of **Swiss Hosted Solutions** — a non-profit association ("Verein")
under Swiss law promoting pure open-source software hosted exclusively on Swiss soil.

Static HTML + CSS, mobile first, bilingual (German primary, English secondary).
No frameworks, no build step, no CDNs, no cookies, no tracking.

## Structure

| Path | Content |
|---|---|
| `index.html` | Fallback language redirect to `/de/` (production redirect is done by Caddy) |
| `de/` | German pages: `index.html`, `ueber-uns.html`, `projekte.html`, `kontakt.html` |
| `en/` | English pages: `index.html`, `about.html`, `projects.html`, `contact.html` |
| `css/styles.css` | Single stylesheet (design tokens, light/dark themes) |
| `assets/` | Logo, favicon, self-hosted fonts (Inter + Space Grotesk, OFL) |
| `404.html` | Bilingual not-found page |
| `Caddyfile.example` | Caddy config: Accept-Language redirect, 404 handling, security headers |
| `mockup/` | Design mockup the site was built from (not deployed) |

## Conventions

- **JavaScript**: forbidden, with one deliberate exception — a tiny inline script per page
  that applies the persisted light/dark choice (`localStorage` key `shs-theme`) and wires
  the theme toggle. Without JS the site fully works and follows the OS color scheme.
- **Language switch**: plain links between the DE/EN version of each page; the server
  (Caddy) redirects `/` by `Accept-Language`, defaulting to German.
- All asset paths are absolute to the server root (`/css/…`, `/assets/…`).

## Local preview

Serve the repo root with any static server, e.g.:

```sh
python3 -m http.server 8000
# → http://localhost:8000/
```

---

### Repo für die Website von SwissHostedSolutions

Statisches HTML + CSS, mobile first, zweisprachig (Deutsch primär, Englisch sekundär).
Keine Frameworks, keine CDNs, keine Cookies, kein Tracking.

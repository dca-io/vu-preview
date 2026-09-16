# iomust

Static demo site for the Wolff VU meter (the `vumeter-openGL` WebAssembly
build), served straight from the `main` branch by GitHub Pages.

The repo root *is* the site. It holds only the built bundle and the
plumbing to publish it:

| File | What |
| --- | --- |
| `index.html` | Page shell: a 1920x720 canvas scaled to fit the window |
| `dbmr-analyzer-web.js` | Emscripten loader |
| `dbmr-analyzer-web.wasm` | The renderer |
| `dbmr-analyzer-web.data` | Preloaded assets (VU faces, bargraph statics, font atlas) |
| `BUNDLE_SOURCE` | Short commit of `vumeter-openGL` the bundle was built from |
| `.nojekyll` | Tells Pages to serve files as-is, skipping Jekyll |

No build step runs on GitHub. The bundle is built locally in
`vumeter-openGL` and committed here, so a deploy is just a push.

## Deploy

One-time setup, in the GitHub repo: **Settings → Pages → Build and
deployment → Source: Deploy from a branch → `main` / `/ (root)`**. After
that every push to `main` publishes the root to
`https://<owner>.github.io/<repo>/`.

The bundle uses only relative URLs, no threads and no custom headers, so it
works from a project subpath without any base-URL configuration.

## Update the bundle

```sh
# in vumeter-openGL
./tools/build-web.sh

# in iomust (defaults to ../vumeter-openGL)
./tools/sync-bundle.sh
git add -A && git commit -m "Bundle from vumeter-openGL <rev>" && git push
```

## Preview locally

```sh
./tools/serve.sh          # http://localhost:8972/
```

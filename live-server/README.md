# Build my own liver-server with hot watch

What is the point with liver-server, we have 3 main points:

- Http-server: to serve my files: Html, Css, Js
- Fs for our system to monitors my directorys, for changes

```bash

              my-live-server
                     │
         ┌───────────┴────────────┐
         │                        │
         ▼                        ▼
     HTTP Server           WebSocket Server
         │                        ▲
         ▼                        │
   Sirve index.html         Envía "reload"
         │                        ▲
         ▼                        │
      Browser          File Watcher (chokidar)

```

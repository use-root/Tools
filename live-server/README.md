**This project is still evolving. There are some improvements and bugs to fix, but it already provides the core functionality of serving files and automatically reloading the browser when changes are detected.**

# Build My Own Live Server with Hot Reload

The goal of this project is to build my own lightweight live development server.
The main purpose is learning: understanding how file watching, HTTP servers, WebSockets, and browser synchronization work together.

## Demo

You can see the demo here:

[Video Demo ](https://www.linkedin.com/embed/feed/update/urn:li:ugcPost:7480776347200622592?compact=1)

## What is the purpose of a live server?

A live server mainly has three important parts:

- **HTTP Server**: Serves project files such as HTML, CSS, and JavaScript.
- **File Watcher**: Monitors project directories and detects when files are modified.
- **WebSocket Server**: Creates a real-time connection between the server and the browser to trigger automatic reloads.

## How does an HTTP server work?

An HTTP server is responsible for receiving requests from the browser and returning the requested resources.

Example flow:

1. The browser requests a file like `index.html`.
2. The HTTP server receives the request.
3. The server finds the requested file.
4. The server sends the file back to the browser.

#### Structure of my live-server

```bash

              my-live-server
                     │
         ┌───────────┴────────────┐
         │                        │
         ▼                        ▼
     HTTP Server           WebSocket Server
         │                        ▲
         ▼                        │
   Serves index.html         Send "reload"
         │                        ▲
         ▼                        │
      Browser          File Watcher (chokidar)

```

## How it works

1. The HTTP server serves the website files.
2. The file watcher monitors changes inside the project directory.
3. When a file changes, the watcher notifies the WebSocket server.
4. The WebSocket server sends a reload message to the connected browser.
5. The browser refreshes automatically.

# Tools

The goal of this repository is not to replace existing tools, but to learn by building them. Creating my own solutions helps me understand the problems they solve, how they work internally, and how I can adapt them to my workflow.

## Why build my own tools?

Modern development depends on many powerful tools and libraries. They are great, but sometimes it is easy to use them without understanding what is happening behind the scenes.

By building my own tools, I can explore concepts such as:

- Networking
- File systems
- Developer workflows
- Automation
- Real-time communication
- System design
- Software architecture

Some projects may start as experiments, but each one is an opportunity to learn something new and create something useful for my daily workflow.

## Projects

### Live Server with Hot Reload

A lightweight live development server built for my personal Neovim workflow.

The goal was to understand how live reload tools work internally by building the main components:

- HTTP server for serving files
- File watcher for detecting changes
- WebSocket communication for browser synchronization

Technologies:

- Node.js
- HTTP
- WebSockets
- Chokidar
- JavaScript

Repository:
[my-live-server](./my-live-server)

---

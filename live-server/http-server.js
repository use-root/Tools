const http = require("http");
const fs = require("fs");
const path = require("path");
const prc = require("process");
const ws = require("ws");

const clients = new Set();
const root = prc.cwd();

const PORT = prc.argv[2];
const FILE = prc.argv[3];

const injectedScript = `
<script>
  (function () {
    const ws = new WebSocket("ws://" + location.host);

    ws.onmessage = (event) => {
      if (event.data === "reload") {
        location.reload();
      }
    };

   ws.onopen = () => console.log("WS OPEN");
   ws.onerror = (e) => console.log("WS ERROR", e);
  })();
</script>
`;

const server = http.createServer((req, res) => {
  let filePath = req.url === "/" ? "/" + FILE : req.url;

  const fullPath = path.join(root, filePath);
  const relativePath = path.relative(root, filePath);

  fs.readFile(fullPath, (err, data) => {
    if (err) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.end("404 Not Found");
      return;
    }

    const ext = path.extname(fullPath).toLowerCase();

    const mimeTypes = {
      ".html": "text/html",
      ".css": "text/css",
      ".js": "application/javascript",
      ".png": "image/png",
      ".jpg": "image/jpeg",
      ".jpeg": "image/jpeg",
      ".gif": "image/gif",
      ".webp": "image/webp",
      ".svg": "image/svg+xml",
    };
    const contentType = mimeTypes[ext] || "application/octet-stream";

    if (ext === ".html") {
      let content = data.toString();

      if (content.includes("</body>")) {
        content = content.replace("</body>", `${injectedScript}</body>`);
      } else {
        content += injectedScript;
      }

      res.writeHead(200, { "Content-Type": contentType });
      res.end(content);
      return;
    }

    res.writeHead(200, { "Content-Type": contentType });
    res.end(data);
  });
});

const wss = new ws.Server({ server });

wss.on("connection", (socket) => {
  console.log("WebSocket conectado");
  clients.add(socket);

  socket.on("close", () => {
    clients.delete(socket);
  });

  socket.send("connected");
});

function broadcastReload() {
  for (const cli of clients) {
    if (cli.readyState === 1) {
      cli.send("reload");
    }
  }
}

const chokidar = require("chokidar");

chokidar
  .watch(root, {
    ignored: /node_modules/,
    ignoreInitial: true,
  })
  .on("all", (event, filePath) => {
    console.log("CHANGE:", event, filePath);
    broadcastReload();
  });

server.listen(PORT, () => {
  console.log(`Server running: http://localhost:${PORT}`);
});

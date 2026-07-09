// librerias
const http = require("http");
const fs = require("fs");
const path = require("path");
const prc = require("process");
const ws = require("ws");

const clients = new Set();
const root = prc.cwd();

const PORT = prc.argv[2] || 5001;
const FILE = prc.argv[3] || "index.html";

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
  console.log("Request:", req.url);

  let filePath = req.url === "/" ? "/" + FILE : req.url;

  const fullPath = path.join(root, filePath);

  fs.readFile(fullPath, (err, data) => {
    if (err) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.end("404 Not Found");
      return;
    }

    const ext = path.extname(fullPath);

    let contentType = "text/plain";
    let content = data.toString();

    if (ext === ".html") {
      contentType = "text/html";

      if (content.includes("</body>")) {
        content = content.replace("</body>", `${injectedScript}</body>`);
      } else {
        content += injectedScript;
      }
    }
    if (ext === ".css") contentType = "text/css";
    if (ext === ".js") contentType = "application/javascript";

    res.writeHead(200, { "Content-Type": contentType });
    res.end(content);
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


const path = require('path');
const fs = require('fs');
const express = require('express');

const PORT = process.env.PORT || 3000;

const r = path.resolve.bind(null, __dirname);

function main() {
    express()
    .all("/", serveIndex)
    .use(express.static(r("public")))
    .all("/*", serveIndex)
    
    .listen(PORT, () => {
        console.log(`Listening on port: ${PORT}`);
        console.log('Press Ctrl+C to quit.');
    })
}

function serveIndex(res, req) {
    fs.readFile(r("public/index.html"), "utf-8", (error, content) => {
        if (error) throw error;
        req.send(content);
    });
}

if (require.main === module) main();

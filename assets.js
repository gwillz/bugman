
const path = require('path');
const fs = require('fs');

const r = path.resolve.bind(null, __dirname);

const INCLUDE = [
    ".css",
    ".html",
    ".webmanifest",
    ".png",
    ".ico",
    ".svg",
]

function filter(file) {
    const m = /(\.\w+)$/.exec(file);
    if (!m) return false;
    return !INCLUDE.includes(m[1]);
}

function main() {
    const files = fs.readdirSync(r("src"));
    
    for (let file of files) {
        if (filter(file)) continue;
        
        console.log("Copying:", file);
        fs.copyFileSync(r("src", file), r("public", file));
    }
}

if (require.main === module) main();

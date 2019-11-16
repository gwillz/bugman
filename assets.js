
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
    if (!m) return true;
    return !INCLUDE.includes(m[1]);
}

function copy() {
    const files = fs.readdirSync(r("src"));
    
    for (let filename of files) {
        if (filter(filename)) continue;
        
        console.log("Copying:", filename);
        fs.copyFileSync(r("src", filename), r("public", filename));
    }
}

function watch() {
    copy();
    
    console.log("Watching: ./src");
    
    let timer = 0;
    fs.watch(r("src"), {}, (event, filename) => {
        if (filter(filename)) return;
        
        clearTimeout(timer);
        timer = setTimeout(() => {
            console.log("Copying:", filename);
            fs.copyFileSync(r("src", filename), r("public", filename));
        }, 250);
    });
}

function main() {
    if (process.argv.includes("watch")) {
        watch();
    }
    else {
        copy();
    }
}

if (require.main === module) main();


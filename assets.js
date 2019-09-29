
const path = require('path');
const fs = require('fs');

const r = path.resolve.bind(null, __dirname);

const FILTER = /.(?:css|html)$/;

function main() {
    const files = fs.readdirSync(r("src"));
    
    for (let file of files) {
        if (!FILTER.test(file)) continue;
        
        console.log("Copying:", file);
        fs.copyFileSync(r("src", file), r("public", file));
    }
}

if (require.main === module) main();

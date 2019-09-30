
const {spawnSync} = require('child_process')

function main() {
    console.log(getVersion());
}

function getVersion() {
    const count = getOutput("git", ['rev-list', 'HEAD', '--count']);
    return `v${count}`;
}

function getOutput(cmd, args) {
    const child = spawnSync(cmd, args);
    return child.stdout.toString().replace(/[\r\n\t ]/g, '');
}

module.exports = getVersion;

if (module === require.main) main();

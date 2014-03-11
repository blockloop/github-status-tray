stdout = stderr = null;
require('child_process').spawn('C:/node-webkit/nw.exe', ['.'], { detached: true, stdio: [ 'ignore', stdout, stderr ], env: process.env });
process.exit(0);


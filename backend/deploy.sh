#!/bin/sh
rsync -avz . esya@10.0.0.10:/home/esya/looker-hackathon --exclude node_modules --exclude .git
ssh esya@10.0.0.10 "cd /home/esya/looker-hackathon && npm install && npm run build && /home/esya/.npm-global/bin/pm2 restart all"

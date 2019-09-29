# Bugman
## Field Assistant


### Build
```sh
# install
npm ci
npm install -g firebase-tools

# dev
npm run assets
npm run webpack -- -w
npm start # in a separate terminal

# deploy
npm run assets
NODE_ENV=production npm run webpack
firebase login # only once
firebase deploy
```
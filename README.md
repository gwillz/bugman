# Bugman
## Field Assistant

### Tech
- Typescript
- Preact X
- React-Router
- Redux
- Redux Persist
- React Redux
- Workbox
- Luxon


### Build
```sh
# install
npm ci
npm install -g firebase-tools

# dev
npm run assets -- watch
npm run webpack -- -w
npm start # in a separate terminal

# deploy
npm run clean
npm run assets
NODE_ENV=production npm run webpack
firebase login # only once
firebase deploy
```


### TODO
- rich text notes
- fonts

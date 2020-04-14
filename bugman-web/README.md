# Field Assistant
## aka. Bugman

### Tech
- Typescript
- Preact X
- Redux
- Redux-Persist
- React-Redux
- React-Router
- React-DnD
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
- images
  - new storage backend (localForage/IndexedDB)
  - some sort of migration..?
  - create zip files
  - use react-native
- use fork-ts plugin
- remove specimen type from required
  - add to bugman template

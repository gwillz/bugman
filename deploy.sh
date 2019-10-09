#!/usr/bin/env bash
npm run clean
npm run assets
NODE_ENV=production npm run webpack
firebase deploy

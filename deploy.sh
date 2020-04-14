#!/usr/bin/env bash

function mmm {
    NODE_ENV=production $@ || exit $?
}

mmm npm run clean
mmm npm run assets
mmm npm run webpack
# mmm npm run firebase
mmm npm run pages

#!/usr/bin/env bash

function mmm {
    BASENAME=/bugman/ NODE_ENV=production $@ || exit $?
}

mmm npm run clean
mmm npm run webpack
mmm npm run firebase
# mmm npm run pages

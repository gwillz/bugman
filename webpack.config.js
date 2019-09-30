// @ts-check

/// <reference path="./src/serviceworker-webpack-plugin.d.ts" />

const path = require('path');
const webpack = require('webpack');
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');
const ServiceWorkerWebpackPlugin = require('serviceworker-webpack-plugin');

const presetMode = process.env.NODE_ENV || 'development';
const isProduction = (presetMode === 'production');

const r = path.resolve.bind(null, __dirname);

const VERSION = require("./version")();

/** @type {webpack.Configuration} */
module.exports = {
    mode: presetMode,
    context: __dirname,
    devtool: isProduction ? false : 'cheap-module-source-map',
    entry: {
        'index': r("src/index.tsx"),
    },
    output: {
        path: r("public"),
    },
    optimization: {
        splitChunks: false,
    },
    module: {
        rules: [
            {
                test: /\.(js|json|ts|tsx)$/,
                include: r("src"),
                exclude: r("src/sw.ts"),
                loader: 'ts-loader',
                options: {
                    experimentalWatchApi: true,
                    configFile: r("tsconfig.json"),
                },
            },
            {
                test: /\.(js|json|ts|tsx|mjs)$/,
                include: r("src/sw.ts"),
                loader: 'ts-loader',
                options: {
                    experimentalWatchApi: true,
                    configFile: r("tsconfig.sw.json"),
                },
            },
        ]
    },
    resolve: {
        extensions: ['.js', '.json', '.mjs', '.ts', '.tsx'],
        alias: {
            'react': 'preact/compat',
            'react-dom': 'preact/compat',
        },
    },
    plugins: [
        // new ForkTsCheckerWebpackPlugin({
        //     async: true,
        //     watch: r("/src"),
        //     tsconfig: r("tsconfig.json"),
        // }),
        new ServiceWorkerWebpackPlugin({
            entry: r("src/sw.ts"),
        }),
        new webpack.EnvironmentPlugin({
            ...process.env,
            VERSION,
            BUILD_TIMESTAMP: +new Date(),
        }),
    ]
}

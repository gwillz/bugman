// @ts-check

const path = require('path');
const webpack = require('webpack');
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');
const ServiceWorkerWebpackPlugin = require('serviceworker-webpack-plugin');

const presetMode = process.env.NODE_ENV || 'development';
const isProduction = (presetMode === 'production');

const r = path.resolve.bind(null, __dirname);

/** @type {webpack.Configuration} */
module.exports = {
    mode: presetMode,
    context: __dirname,
    devtool: isProduction ? false : 'cheap-module-eval-source-map',
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
                // Compile here, but type-checking happens in parallel.
                test: /\.(js|json|ts|tsx)$/,
                include: r("src"),
                exclude: r("node_modules"),
                loader: 'ts-loader',
                options: {
                    transpileOnly: true,
                    experimentalWatchApi: true,
                    configFile: r("tsconfig.json"),
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
        new ForkTsCheckerWebpackPlugin({
            async: true,
            watch: r("/src"),
            tsconfig: r("tsconfig.json"),
        }),
        new ServiceWorkerWebpackPlugin({
            entry: r("src/sw.ts"),
        }),
        new webpack.EnvironmentPlugin(process.env),
    ]
}

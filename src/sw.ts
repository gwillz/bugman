
// @ts-ignore
import {registerRoute} from 'workbox-routing/registerRoute';
// @ts-ignore
import {StaleWhileRevalidate} from 'workbox-strategies';

console.log("hello from sw");

registerRoute(
    /\.(?:js|css|html|png|ico|webmanifest)$/,
    new StaleWhileRevalidate()
);

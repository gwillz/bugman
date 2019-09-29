
import { registerRoute, registerNavigationRoute, setDefaultHandler } from 'workbox-routing';
import { Plugin as ExpirationPlugin } from 'workbox-expiration';
import { StaleWhileRevalidate, CacheFirst } from 'workbox-strategies';

const ONE_YEAR = 365 * 24 * 60 * 60;

// Home
registerRoute(/\//, new StaleWhileRevalidate());

// Cache Assets
registerRoute(
    /\.(?:js|css|html|webmanifest)$/,
    new StaleWhileRevalidate({
        plugins: [
            new ExpirationPlugin({
              maxEntries: 10,
              maxAgeSeconds: ONE_YEAR,
            }),
          ],
    })
);

// Cache images
registerRoute(
    /\.(?:png|ico)$/,
    new CacheFirst({
        cacheName: 'images',
        plugins: [
            new ExpirationPlugin({
                maxEntries: 10,
                maxAgeSeconds: ONE_YEAR,
            }),
        ],
    }),
);

// Push-state behaviour
registerNavigationRoute('/index.html');
setDefaultHandler(async () => await caches.match("/index.html") || Response.error());

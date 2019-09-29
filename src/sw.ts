
import workbox from 'workbox-sw';
const { registerRoute, setCatchHandler } = workbox.routing;
const { Plugin: ExpirationPlugin } = workbox.expiration;
const { StaleWhileRevalidate, CacheFirst } = workbox.strategies;

const ONE_YEAR = 365 * 24 * 60 * 60;

// Home
registerRoute(/\//, new StaleWhileRevalidate());

// Cache Assets
registerRoute(
    /\.(?:js|css|webmanifest)$/,
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
setCatchHandler(async () => await caches.match("/") || Response.error());

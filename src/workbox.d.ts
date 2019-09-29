
declare module 'workbox-routing' {
    import workbox from 'workbox-sw';
    type registerRoute = typeof workbox.routing.registerRoute;
    const registerRoute: registerRoute;
    type registerNavigationRoute = typeof workbox.routing.registerNavigationRoute;
    const registerNavigationRoute: registerNavigationRoute;
    type setDefaultHandler = typeof workbox.routing.setDefaultHandler;
    const setDefaultHandler: setDefaultHandler;
    export {registerRoute, registerNavigationRoute, setDefaultHandler};
}

declare module 'workbox-expiration' {
    import workbox from 'workbox-sw';
    type Plugin = typeof workbox.expiration.Plugin;
    const Plugin: Plugin;
    export { Plugin };
}

declare module 'workbox-strategies' {
    import workbox from 'workbox-sw';
    type StaleWhileRevalidate = typeof workbox.strategies.StaleWhileRevalidate;
    const StaleWhileRevalidate: StaleWhileRevalidate;
    type CacheFirst = typeof workbox.strategies.CacheFirst;
    const CacheFirst: CacheFirst;
    export { StaleWhileRevalidate, CacheFirst };
}

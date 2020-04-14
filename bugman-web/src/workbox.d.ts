
declare module 'workbox-routing' {
    import workbox from 'workbox-sw';
    
    const routing: {
        registerRoute: typeof workbox.routing.registerRoute,
        registerNavigationRoute: typeof workbox.routing.registerNavigationRoute,
        setDefaultHandler: typeof workbox.routing.setDefaultHandler,
        setCatchHandler: typeof workbox.routing.setCatchHandler,
        Router: typeof workbox.routing.Router,
        Route: typeof workbox.routing.Route,
        RegExpRoute: typeof workbox.routing.RegExpRoute,
        NavigationRoute: typeof workbox.routing.NavigationRoute,
    }
    export default routing;
}

declare module 'workbox-routing/registerRoute' {
    import workbox from 'workbox-sw';
    export const registerRoute: typeof workbox.routing.registerRoute;
}

declare module 'workbox-routing/registerNavigationRoute' {
    import workbox from 'workbox-sw';
    export const registerNavigationRoute: typeof workbox.routing.registerNavigationRoute;
}

declare module 'workbox-routing/setDefaultHandler' {
    import workbox from 'workbox-sw';
    export const setDefaultHandler: typeof workbox.routing.setDefaultHandler;
}

declare module 'workbox-routing/setCatchHandler' {
    import workbox from 'workbox-sw';
    export const setCatchHandler: typeof workbox.routing.setCatchHandler;
}

declare module 'workbox-routing/Router' {
    import workbox from 'workbox-sw';
    export const Router: typeof workbox.routing.Router;
}

declare module 'workbox-routing/Route' {
    import workbox from 'workbox-sw';
    export const Route: typeof workbox.routing.Route;
}

declare module 'workbox-routing/RegExpRoute' {
    import workbox from 'workbox-sw';
    export const RegExpRoute: typeof workbox.routing.RegExpRoute;
}

declare module 'workbox-routing/NavigationRoute' {
    import workbox from 'workbox-sw';
    export const NavigationRoute: typeof workbox.routing.NavigationRoute;
}

declare module 'workbox-expiration' {
    import workbox from 'workbox-sw';
    
    const expiration: {
        CacheExpiration: typeof workbox.expiration.CacheExpiration,
        Plugin: typeof workbox.expiration.Plugin,
    }
    export default expiration;
}

declare module 'workbox-expiration/CacheExpiration' {
    import workbox from 'workbox-sw';
    export const CacheExpiration: typeof workbox.expiration.CacheExpiration;
}

declare module 'workbox-expiration/Plugin' {
    import workbox from 'workbox-sw';
    export const Plugin: typeof workbox.expiration.Plugin;
}

declare module 'workbox-strategies' {
    import workbox from 'workbox-sw';
    
    const strategies: {
        CacheFirst: typeof workbox.strategies.CacheFirst,
        CacheOnly: typeof workbox.strategies.CacheOnly,
        NetworkFirst: typeof workbox.strategies.NetworkFirst,
        NetworkOnly: typeof workbox.strategies.NetworkOnly,
        StaleWhileRevalidate: typeof workbox.strategies.StaleWhileRevalidate,
    }
    export default strategies;
}

declare module 'workbox-strategies/CacheFirst' {
    import workbox from 'workbox-sw';
    export const CacheFirst: typeof workbox.strategies.CacheFirst;
}

declare module 'workbox-strategies/CacheOnly' {
    import workbox from 'workbox-sw';
    export const CacheOnly: typeof workbox.strategies.CacheOnly;
}

declare module 'workbox-strategies/NetworkFirst' {
    import workbox from 'workbox-sw';
    export const NetworkFirst: typeof workbox.strategies.NetworkFirst;
}

declare module 'workbox-strategies/NetworkOnly' {
    import workbox from 'workbox-sw';
    export const NetworkOnly: typeof workbox.strategies.NetworkOnly;
}

declare module 'workbox-strategies/StaleWhileRevalidate' {
    import workbox from 'workbox-sw';
    export const StaleWhileRevalidate: typeof workbox.strategies.StaleWhileRevalidate;
}

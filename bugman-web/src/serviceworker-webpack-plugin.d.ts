
declare module 'serviceworker-webpack-plugin' {
    import * as webpack from "webpack";
    
    interface ServiceWorkerOption {
        assets: string[];
        jsonStats: webpack.Stats.ToJsonOutput;
    }
    
    interface PluginOptions {
        entry: string;
        publicPath?: string;
        excludes?: string[];
        includes?: string[];
        filename?: string;
        template?: (option: ServiceWorkerOption) => Promise<string>;
        transformOptions?: (option: ServiceWorkerOption) => ServiceWorkerOption;
        minimize?: boolean;
    }
    
    class ServiceWorkerPlugin extends webpack.Plugin {
        constructor(options: PluginOptions);
    }
    
    export = ServiceWorkerPlugin;
}

declare module 'serviceworker-webpack-plugin/lib/runtime' {
    class Runtime {
        public register(): Promise<ServiceWorkerRegistration>;
    }
    
    export const serviceworker: Runtime;
    export default serviceworker;
}

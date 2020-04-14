
import { h, render } from 'preact';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { PersistGate } from 'redux-persist/integration/react';
import { Settings } from 'luxon';
import { Provider } from 'react-redux';
import { persistor, store } from './store';
import { Header, HeaderProvider } from './Header';
import { Footer } from './Footer';

import { HomeView } from './HomeView';
import { EntryEditView } from './EntryEditView';
import { EntryDeleteView } from './EntryDeleteView';
import { ClearView } from './ClearView';
import { ExportView } from './ExportView';
import { ConfigNewView, ConfigEditView, TemplateEditView } from './ConfigEditView';
import { SettingsView } from './SettingsView';
import { TemplatesView } from './TemplatesView';

Settings.defaultLocale = "en-AU";

import './index.css';
import './favicon.ico';
import './apple-touch-icon.png';
import './manifest.webmanifest';

function App() {
    
    return (
        <PersistGate persistor={persistor}>
        <Provider store={store}>
        <HeaderProvider>
        <BrowserRouter basename={process.env.BASENAME}>
            <Header/>
            <Switch>
                <Route exact path="/">
                    <HomeView/>
                </Route>
                <Route exact path="/settings">
                    <SettingsView/>
                </Route>
                <Route path="/config/edit">
                    <ConfigEditView />
                </Route>
                <Route path="/config/new">
                    <ConfigNewView/>
                </Route>
                <Route exact path="/templates">
                    <TemplatesView/>
                </Route>
                <Route path="/templates/:index">
                    <TemplateEditView />
                </Route>
                <Route exact path="/new">
                    <EntryEditView/>
                </Route>
                <Route exact path="/clear">
                    <ClearView/>
                </Route>
                <Route exact path="/export">
                    <ExportView/>
                </Route>
                <Route exact path="/:entry_id">
                    <HomeView/>
                </Route>
                <Route path="/:entry_id/edit">
                    <EntryEditView/>
                </Route>
                <Route path="/:entry_id/delete">
                    <EntryDeleteView/>
                </Route>
            </Switch>
            <Footer/>
        </BrowserRouter>
        </HeaderProvider>
        </Provider>
        </PersistGate>
    )
}

if (process.env.NODE_ENV === "production") {
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register("sw.js", { scope: process.env.BASENAME });
    }
    
    navigator.storage?.persist?.();
}

render(<App/>, document.getElementById('root') as HTMLElement);

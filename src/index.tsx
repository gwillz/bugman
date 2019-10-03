
import { h, render } from 'preact';
import runtime from 'serviceworker-webpack-plugin/lib/runtime';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { PersistGate } from 'redux-persist/integration/react';
import { Settings } from 'luxon';
import { Provider } from 'react-redux';
import { persistor, store } from './store';
import { HomeView } from './HomeView';
import { EntryView } from './EntryView';
import { EditView } from './EditView';
import { DeleteView } from './DeleteView';
import { ClearView } from './ClearView';
import { ExportView } from './ExportView';
import { Footer } from './Footer';

Settings.defaultLocale = "en-AU";

function App() {
    return (
        <PersistGate persistor={persistor}>
        <Provider store={store}>
        <BrowserRouter>
            <header className="header">
                <h1>
                    <img
                        src="/bugman_logo.svg"
                        className="logo"
                    />
                    <span>Field Assistant</span>
                    <img
                        src="/bugman_logo.svg"
                        className="logo flip"
                    />
                </h1>
            </header>
            <Switch>
                <Route exact path="/">
                    <HomeView/>
                </Route>
                <Route exact path="/new">
                    <EditView/>
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
                    <EditView/>
                </Route>
                <Route path="/:entry_id/delete">
                    <DeleteView/>
                </Route>
            </Switch>
            <Footer/>
        </BrowserRouter>
        </Provider>
        </PersistGate>
    )
}

if (process.env.NODE_ENV === "production") {
    if ('serviceWorker' in navigator) runtime.register();
}

render(<App/>, document.getElementById('root') as HTMLElement);

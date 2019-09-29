
import { h, render } from 'preact';
// @ts-ignore
import runtime from 'serviceworker-webpack-plugin/lib/runtime';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { PersistGate } from 'redux-persist/integration/react';
import { persistor, store } from './store';
import { TableView } from './TableView';
import { EntryView } from './EntryView';
import { EditView } from './EditView';
import { Provider } from 'react-redux';

function App() {
    return (
        <PersistGate persistor={persistor}>
        <Provider store={store}>
        <BrowserRouter>
            <header className="header">
                <h1>Bugman</h1>
            </header>
            <Switch>
                <Route exact path="/">
                    <TableView/>
                </Route>
                <Route exact path="/new">
                    <EditView/>
                </Route>
                <Route exact path="/:entry_id">
                    <EntryView/>
                </Route>
                <Route path="/:entry_id/edit">
                    <EditView/>
                </Route>
            </Switch>
        </BrowserRouter>
        </Provider>
        </PersistGate>
    )
}

if (process.env.NODE_ENV === "production") {
    if ('serviceWorker' in navigator) runtime.register();
}

render(<App/>, document.getElementById('root') as HTMLElement);

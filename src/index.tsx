
import * as React from 'react';
import * as ReactDOM from 'react-dom';
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
        <BrowserRouter>
        <PersistGate persistor={persistor}>
        <Provider store={store}>
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
        </Provider>
        </PersistGate>
        </BrowserRouter>
    )
}

if (process.env.NODE_ENV === "production") {
    if ('serviceWorker' in navigator) runtime.register();
}

ReactDOM.render(<App/>, document.getElementById('root') as HTMLElement);

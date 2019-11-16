
import { createStore } from 'redux';
import { persistReducer, persistStore } from 'redux-persist';
import storage from 'redux-persist/lib/storage';
import { Entry } from './Entry';
import { Configuration, templates } from './Configuration';

export interface State {
    timestamp: number;
    entries: Record<number, Entry | undefined>;
    config: Configuration | null;
}

export type Actions = ({
    type: "ADD";
    entry: Entry;
} | {
    type: "REMOVE";
    entry_id: number;
} | {
    type: "EDIT";
    entry_id: number;
    entry: Partial<Entry>;
} | {
    type: "CLEAR";
})

export type DispatchFn = (action: Actions) => void;

const INIT_STATE: State = {
    timestamp: 0,
    entries: {},
    config: null,
}

function reducer(state = INIT_STATE, action: Actions): State {
    const timestamp = +new Date();
    
    switch (action.type) {
        case "ADD": return {
            ...state,
            timestamp,
            entries: {
                ...state.entries,
                [action.entry.entry_id]: action.entry,
            },
        }
        case "REMOVE": return {
            ...state,
            timestamp,
            entries: {
                ...state.entries,
                [action.entry_id]: undefined,
            }
        }
        case "EDIT": return {
            ...state,
            timestamp,
            entries: {
                ...state.entries,
                [action.entry_id]: {
                    ...state.entries[action.entry_id]!,
                    ...action.entry,
                }
            }
        }
        case "CLEAR": return {
            ...state,
            timestamp,
            entries: {},
        }
    }
    return state;
}

export const store = createStore(
    persistReducer( {key: 'entries', storage }, reducer ),
    // @ts-ignore
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__(),
);

// @ts-ignore
export const persistor = persistStore(store);

export function stateEqual(left: State, right: State): boolean {
    return left.timestamp === right.timestamp;
}


import { useMemo } from 'react';
import { createStore } from 'redux';
import { persistReducer, persistStore } from 'redux-persist';
import storage from 'redux-persist/lib/storage';
import { shallowEqual, useSelector } from 'react-redux';

export type Mark = [number, number];

export interface Entry {
    entry_id: number; // timestamp
    mark: Mark;
    name: string;
    notes?: string;
}

export interface State {
    timestamp: number;
    entries: Record<number, Entry | undefined>;
}

export type Actions = ({
    type: "ADD";
    name: string;
    notes: string;
    mark: Mark;
} | {
    type: "REMOVE";
    entry_id: number;
} | {
    type: "EDIT";
    entry_id: number;
    entry: Partial<Entry>;
})

export type DispatchFn = (action: Actions) => void;

const INIT_STATE: State = {
    timestamp: 0,
    entries: {},
}

function reducer(state = INIT_STATE, action: Actions): State {
    const timestamp = +new Date();
    
    switch (action.type) {
    case "ADD":
        return {
            timestamp,
            entries: {
                ...state.entries,
                [timestamp]: {
                    entry_id: timestamp,
                    name: action.name,
                    notes: action.notes,
                    mark: action.mark,
                }
            },
        }
    case "REMOVE":
        return {
            timestamp,
            entries: {
                ...state.entries,
                [timestamp]: undefined,
            }
        }
    case "EDIT":
        return {
            timestamp,
            entries: {
                ...state.entries,
                [action.entry_id]: {
                    ...state.entries[action.entry_id]!,
                    ...action.entry,
                }
            }
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

function equalState(left: State, right: State): boolean {
    return left.timestamp === right.timestamp;
}

export function useGetEntry(entry_id?: string | number) {
    const id = entry_id ? parseInt(entry_id + "") : -1;
    
    return useSelector((state: State) => state.entries[id], shallowEqual);
}

export function useGetEntries() {
    const state = useSelector((state: State) => state, equalState);
    
    return useMemo(() => (
        Object.values(state.entries).filter(e => !!e) as Entry[]
    ), [state.timestamp]);
}

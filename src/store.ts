
import { useMemo } from 'preact/hooks';
import { createStore } from 'redux';
import { persistReducer, persistStore } from 'redux-persist';
import storage from 'redux-persist/lib/storage';
import { shallowEqual, useSelector } from 'react-redux';

export interface EntryPosition {
    latitude: number;
    longitude: number;
    elevation: number;
};

export interface Entry {
    entry_id: number; // timestamp
    position: EntryPosition;
    voucher: string;
    collector: string;
    specimen_type: string;
    specimen_count?: number;
    location?: string;
    method?: string;
    flower_type?: string;
    notes?: string;
}

export interface State {
    timestamp: number;
    entries: Record<number, Entry | undefined>;
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
}

function reducer(state = INIT_STATE, action: Actions): State {
    const timestamp = +new Date();
    
    switch (action.type) {
        case "ADD": return {
            timestamp,
            entries: {
                ...state.entries,
                [action.entry.entry_id]: action.entry,
            },
        }
        case "REMOVE": return {
            timestamp,
            entries: {
                ...state.entries,
                [action.entry_id]: undefined,
            }
        }
        case "EDIT": return {
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


function equalState(left: State, right: State): boolean {
    return left.timestamp === right.timestamp;
}

export function useGetEntry(entry_id?: string | number) {
    const id = entry_id ? parseInt(entry_id + "") : -1;
    
    return useSelector((state: State) => state.entries[id], shallowEqual);
}

export function useGetEntries() {
    const state = useSelector((state: State) => state, equalState);
    
    return useMemo(() => {
        const entries = Object.values(state.entries as Entry[])
            .filter(e => !!e);
        entries.sort(compareEntry);
        return entries;
    }, [state.timestamp]);
}

function compareEntry(left: Entry, right: Entry) {
    // Ascending order.
    return right.entry_id - left.entry_id;
}
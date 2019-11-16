
import { useMemo } from 'preact/hooks';
import { useSelector, shallowEqual } from 'react-redux';
import { State, stateEqual } from './store';

export interface EntryPosition {
    latitude: number;
    longitude: number;
    elevation: number;
}

export type EntryData = Record<string, string | number>;

export interface Entry {
    entry_id: number; // timestamp
    position: EntryPosition;
    voucher: string;
    collector: string;
    type: string;
    data: EntryData;
}

export function positionToString(position: EntryPosition) {
    return `${position.latitude.toFixed(5)}, ${position.longitude.toFixed(5)} @ ${position.elevation}m`;
}

export function useGetEntry(entry_id?: string | number) {
    const id = entry_id ? parseInt(entry_id + "") : -1;
    return useSelector((state: State) => state.entries[id], shallowEqual);
}

export function useGetEntries() {
    const state = useSelector((state: State) => state, stateEqual);
    
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

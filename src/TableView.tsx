
import * as React from 'react';
import { Link } from 'react-router-dom';
import { useGetEntries } from './store';
import { EntryBlock } from './EntryBlock';

export function TableView() {
    const entries = useGetEntries();
    
    return (
        <div>
            <div>
                <Link to="/new">Add Entry</Link>
            </div>
            <div>
                {entries.map(entry => (
                    <EntryBlock
                        key={entry.entry_id}
                        entry={entry}
                        short
                    />
                ))}
            </div>
        </div>
    )
}

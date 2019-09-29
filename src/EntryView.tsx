
import * as React from 'react';
import { DateTime } from 'luxon';
import { useParams } from 'react-router';
import { useGetEntry } from './store';
import { Link } from 'react-router-dom';
import { EntryBlock } from './EntryBlock';

type Params = {
    entry_id: string;
}

export function EntryView() {
    const {entry_id} = useParams<Params>();
    const entry = useGetEntry(entry_id);
    
    if (!entry) return <div>Not found</div>
    
    return (
        <div>
            <nav className="navbar">
                <Link className="button" to="/">
                    Back
                </Link>
                <Link className="button" to={`/${entry_id}/edit`}>
                    Edit
                </Link>
            </nav>
            <EntryBlock entry={entry} />
        </div>
    )
}

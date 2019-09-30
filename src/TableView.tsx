
import { h } from 'preact';
import { useRef } from 'preact/hooks';
import { Link } from 'react-router-dom';
import { useGetEntries } from './store';
import { EntryBlock } from './EntryBlock';

export function TableView() {
    const entries = useGetEntries();
    const ref = useRef<HTMLAnchorElement | null>(null);
    
    return (
        <div>
            <nav className="navbar">
                <Link className="button" to="/new">
                    Add Entry
                </Link>
                <Link className="button" to="/export">
                    Export
                </Link>
                <Link to="/clear" className="button">
                    Delete All
                </Link>
            </nav>
            <div className="entry-group">
                {entries.map(entry => (
                    <EntryBlock
                        key={entry.entry_id}
                        entry={entry}
                    />
                ))}
            </div>
            {entries.length == 0 && (
                <div className="text-center">
                    Hi there!
                    <br/>
                    There are no entries yet.
                    <br/>
                    Go ahead and add one.
                </div>
            )}
        </div>
    )
}

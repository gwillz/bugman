
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { useGetEntries } from './store';
import { EntryBlock } from './EntryBlock';

export function TableView() {
    const entries = useGetEntries();
    
    return (
        <div>
            <nav className="navbar">
                <Link className="button" to="/new">
                    Add Entry
                </Link>
            </nav>
            <div className="entry-group">
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

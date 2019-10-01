
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { useGetEntries } from './entry';
import { EntryBlock } from './EntryBlock';
import { css } from './css';

export function HomeView() {
    const entries = useGetEntries();
    
    const disabled = entries.length === 0;
    const highlight = entries.length === 0;
    
    return (
        <div>
            {entries.length == 0 && (
                <div className="text-message">
                    Hi there!
                    <br/>
                    Bugman looks after your field notes.
                    Go ahead and add one.
                </div>
            )}
            
            <nav className="navbar">
                <Link  to="/new" className={css("button", { highlight })}>
                    Add Entry
                </Link>
                <Link  to="/export" className={css("button", { disabled })}>
                    Export
                </Link>
                <Link to="/clear" className={css("button", { disabled } )}>
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
        </div>
    )
}

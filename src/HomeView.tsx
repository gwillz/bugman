
import { h } from 'preact';
import { Link, useParams } from 'react-router-dom';
import { useGetEntries } from './Entry';
import { EntryBlock } from './EntryBlock';
import { css } from './css';

type Params = {
    entry_id?: string;
}

export function HomeView() {
    const entries = useGetEntries();
    
    const params = useParams<Params>();
    const entry_id = parseInt(params.entry_id || "");
    
    const disabled = entries.length === 0;
    const highlight = entries.length === 0;
    
    return (
        <div>
            {entries.length == 0 && (
                <div className="text-message">
                    Hi there!
                    <br/>
                    Field Assistant looks after your field notes.
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
                        open={entry.entry_id === entry_id}
                    />
                ))}
            </div>
        </div>
    )
}

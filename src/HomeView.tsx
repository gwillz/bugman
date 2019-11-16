
import { h } from 'preact';
import { Link, useParams } from 'react-router-dom';
import { useGetEntries } from './Entry';
import { useGetFields } from './Configuration';
import { EntryBlock } from './EntryBlock';
import { css } from './css';

type Params = {
    entry_id?: string;
}

export function HomeView() {
    const entries = useGetEntries();
    const fields = useGetFields();
    
    const params = useParams<Params>();
    const entry_id = parseInt(params.entry_id || "");
    
    return (
        <div>
            {fields == null ? (
                <div className="text-message">
                    Hi there!
                    <br/>
                    Field Assistant looks after your field notes.
                    Start by creating your data format <Link to="/settings">here</Link>.
                </div>
            ) : entries.length === 0 && (
                <div className="text-message">
                    Hi there!
                    <br/>
                    You're ready to go.
                    Time to add a new entry.
                </div>
            )}
            
            <nav className="navbar">
                <Link to="/new"
                    className={css("button", {
                        highlight: fields !== null && entries.length === 0,
                        disabled: fields === null,
                    })}>
                    Add Entry
                </Link>
                <Link to="/export"
                    className={css("button", {
                        disabled: entries.length === 0,
                    })}>
                    Export
                </Link>
                <Link to="/settings"
                    className={css("button", { 
                        highlight: fields === null,
                    })}>
                    Settings
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

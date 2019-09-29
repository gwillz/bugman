
import { h } from 'preact';
import { useRef } from 'preact/hooks';
import { Link } from 'react-router-dom';
import { useGetEntries } from './store';
import { EntryBlock } from './EntryBlock';
import { CSVBuilder } from './CSVBuilder';
import { DateTime } from 'luxon';

export function TableView() {
    const entries = useGetEntries();
    const ref = useRef<HTMLAnchorElement | null>(null);
    
    function onExport() {
        if (!ref.current) return;
        
        const builder = new CSVBuilder();
        
        builder.setHeaders("date", "name", "latitude", "longitude", "notes");
        
        for (let entry of entries) {
            const date = DateTime.fromMillis(entry.entry_id);
            builder.add(date,
                entry.name,
                entry.mark[0],
                entry.mark[1],
                entry.notes || "");
        }
        
        ref.current.href = encodeURI("data:text/csv," + builder.build());
        ref.current.download = DateTime.local().toFormat("yyyy-MM-dd_HH-mm'.csv'");
        ref.current.click();
    }
    
    return (
        <div>
            <a ref={ref} style={{display: 'none'}} />
            <nav className="navbar">
                <Link className="button" to="/new">
                    Add Entry
                </Link>
                <button type="button"
                    className="button"
                    onClick={onExport}>
                    Export
                </button>
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


import { h } from 'preact';
import { useParams } from 'react-router';
import { Link } from 'react-router-dom';
import { useGetEntry } from './Entry';
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
                    Home
                </Link>
                <Link className="button" to={`/${entry_id}/edit`}>
                    Edit
                </Link>
                <Link className="button" to={`/${entry_id}/delete`}>
                    Delete
                </Link>
            </nav>
            
            <EntryBlock entry={entry} open />
            
        </div>
    )
}

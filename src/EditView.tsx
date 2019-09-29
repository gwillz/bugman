
import * as React from 'react';
import { useState } from 'react';
import { useParams, Redirect } from 'react-router';
import { useGetEntry, DispatchFn, Mark } from './store';
import { useInput } from './useInput';
import { Link } from 'react-router-dom';
import { useDispatch } from 'react-redux';

type Params = {
    entry_id?: string;
}

export function EditView() {
    const { entry_id } = useParams<Params>();
    const entry = useGetEntry(entry_id);
    const [redirect, setRedirect] = useState("");
    
    const dispatch = useDispatch<DispatchFn>();
    
    const [name, onName] = useInput(entry && entry.name);
    const [notes, onNotes] = useInput(entry && entry.notes);
    
    async function onSubmit(event: React.FormEvent<HTMLFormElement>) {
        event.preventDefault();
        if (!entry) {
            const mark = await getGeo();
            dispatch({type: "ADD", name, notes, mark });
            setRedirect('/');
        }
        else {
            const { entry_id } = entry;
            dispatch({type: "EDIT", entry_id, entry: { name, notes }});
            setRedirect(`/${entry.entry_id}`);
        }
    }
    
    if (entry_id && !entry) return <div>Not found</div>;
    
    if (redirect) return <Redirect to={redirect} />
    
    return (
        <div>
            <div>
                {entry && (
                    <Link to={`/${entry.entry_id}`}>View</Link>
                )}
                <Link to="/">All</Link>
            </div>
            <form onSubmit={onSubmit}>
                <label>Name</label>
                <input
                    type="text"
                    name="name"
                    value={name}
                    onChange={onName}
                    required
                />
                <br/>
                <label>Notes</label>
                <textarea
                    name="notes"
                    value={notes}
                    onChange={onNotes}
                />
                <br/>
                <button type="submit">
                    {entry ? "Save" : "Create"}
                </button>
            </form>
        </div>
    )
}



function getGeo() {
    return new Promise<Mark>((resolve, reject) => {
        navigator.geolocation.getCurrentPosition(geo => {
            const { latitude, longitude } = geo.coords;
            resolve([latitude, longitude]);
        }, reject);
    });
}

import { h } from 'preact';
import { useState } from 'preact/hooks';
import { useParams, Redirect } from 'react-router';
import { useDispatch } from 'react-redux';
import { DispatchFn, useGetEntry } from './store';
import { sleep } from './useGeo';
import { Link } from 'react-router-dom';

type Params = {
    entry_id: string;
}

export function DeleteView() {
    const { entry_id } = useParams<Params>();
    const entry = useGetEntry(entry_id);
    const dispatch = useDispatch<DispatchFn>();
    const [redirect, setRedirect] = useState("");
    
    async function onRemove() {
        dispatch({
            type: "REMOVE",
            entry_id: parseInt(entry_id) || 0,
        });
        await sleep(100);
        setRedirect("/")
    }
    
    if (redirect) return <Redirect to={redirect} />
    
    if (!entry) return <Redirect to="/" />
    
    return (
        <div>
            <h3>Deleting "{entry.voucher}" - are you sure?</h3>
            <div>
                <button type="button"
                    className="button"
                    onClick={onRemove}>
                    Yes, delete it
                </button>
                <Link to="/"
                    className="button">
                    Wait no!
                </Link>
            </div>
        </div>
    )
}

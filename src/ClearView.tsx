
import { h } from 'preact';
import { useState } from 'preact/hooks';
import { Redirect } from 'react-router';
import { useDispatch } from 'react-redux';
import { DispatchFn } from './store';
import { sleep } from './useGeo';
import { Link } from 'react-router-dom';

type Params = {
    entry_id: string;
}

export function ClearView() {
    const dispatch = useDispatch<DispatchFn>();
    const [redirect, setRedirect] = useState("");
    
    async function onRemove() {
        dispatch({ type: "CLEAR" });
        await sleep(100);
        setRedirect("/");
    }
    
    if (redirect) return <Redirect to={redirect} />
    
    return (
        <div>
            <div className="text-message">
                Deleting <em>everything</em>.
                <br/>
                Are you sure?
            </div>
            <div className="navbar">
                <button type="button"
                    className="button highlight"
                    onClick={onRemove}>
                    Yes, delete it all.
                </button>
                <Link to="/" className="button">
                    Oh shit.
                </Link>
            </div>
        </div>
    )
}

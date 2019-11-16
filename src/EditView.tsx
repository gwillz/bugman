
import { h } from 'preact';
import { useState, useMemo, useRef, useEffect } from 'preact/hooks';
import { useParams, Redirect } from 'react-router';
import { Link } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { DateTime } from 'luxon';
import { DispatchFn } from './store';
import { useGetEntry, positionToString } from './Entry';
import { useInput } from './useInput';
import { useGeo, sleep } from './useGeo';
import { ValidVoucherInput } from './ValidVoucherInput';
import { css } from './css';

type Params = {
    entry_id?: string;
}

export function EditView() {
    const { entry_id } = useParams<Params>();
    const entry = useGetEntry(entry_id);
    const [redirect, setRedirect] = useState("");
    
    const dispatch = useDispatch<DispatchFn>();
    
    // Note, this refreshes on every render.
    const timestamp = +new Date();
    
    // The datetime string is from either the creation timestamp (above)
    // or the entry timestamp being edited.
    const datetime = useMemo(() => {
        const date = DateTime.fromMillis(entry
                ? entry.entry_id
                : timestamp);
        return date.toLocaleString(DateTime.DATE_SHORT) + " " +
            date.toLocaleString(DateTime.TIME_24_SIMPLE);
    }, [entry && entry.entry_id, timestamp]);
    
    // highlight the 'create' button when valid (only for new entries).
    const [highlight, setHighlight] = useState(false);
    
    useEffect(() => {
        setHighlight(!entry && !!form.current && form.current.checkValidity());
    });
    
    const form = useRef<HTMLFormElement | null>(null);
    const [voucher, onVoucher] = useInput(entry && entry.voucher);
    const [collector, onCollector] = useInput(entry && entry.collector);
    const [specimen_type, onSpecimenType] = useInput(entry && entry.specimen_type);
    const [specimen_count, onSpecimenCount] = useInput(entry && (entry.specimen_count + ""));
    const [state, onState] = useInput(entry && entry.state);
    const [location, onLocation] = useInput(entry && entry.location);
    const [method, onMethod] = useInput(entry && entry.method);
    const [host_plant, onHostPlant] = useInput(entry && entry.host_plant);
    const [notes, onNotes] = useInput(entry && entry.notes);
    const position = useGeo(entry && entry.position);
    
    async function onSubmit(event: Event) {
        event.preventDefault();
        
        // Wait some more if the mark isn't populated yet.
        if (!position) await sleep(200);
        // @todo Can this actually update here?
        if (!position) return;
        
        // create
        if (!entry) {
            dispatch({
                type: "ADD",
                entry: {
                    entry_id: timestamp,
                    voucher,
                    position,
                    collector,
                    specimen_type,
                    specimen_count: parseInt(specimen_count) || 1,
                    host_plant,
                    state,
                    location,
                    method,
                    notes,
                },
            });
            setRedirect('/');
        }
        // edit
        else {
            dispatch({
                type: "EDIT",
                entry_id: entry.entry_id,
                entry: {
                    voucher,
                    collector,
                    specimen_type,
                    specimen_count: parseInt(specimen_count) || 1,
                    host_plant,
                    state,
                    location,
                    method,
                    notes,
                },
            });
            setRedirect(`/${entry.entry_id}`);
        }
    }
    
    // Not found.
    if (entry_id && !entry) return <div>Not found</div>;
    
    // Created/updated redirect.
    if (redirect) return <Redirect to={redirect} />
    
    return (
        <form onSubmit={onSubmit} ref={form}>
            <nav className="navbar">
                <Link className="button" to="/">
                    Home
                </Link>
                {entry && (
                    <Link className="button" to={`/${entry.entry_id}`}>
                        View
                    </Link>
                )}
                <button className={css("button", { highlight })} type="submit">
                    {entry ? "Save" : "Create"}
                </button>
            </nav>
            <div className="form">
                <div className="form-field">
                    <label>Voucher *</label>
                    <ValidVoucherInput
                        type="text"
                        name="voucher"
                        autoComplete="off"
                        autoCorrect="off"
                        autoCapitalize="off"
                        value={voucher}
                        onChange={onVoucher}
                        placeholder="XX--XX---"
                        required
                    />
                </div>
                <div className="form-field">
                    <label>Date &amp; Time *</label>
                    <input
                        type="text"
                        name="datetime"
                        value={datetime}
                        readOnly
                    />
                </div>
                <div className="form-field">
                    <label>Position *</label>
                    <input
                        type="text"
                        name="position"
                        value={position
                            ? positionToString(position)
                            : '...'}
                        readOnly
                    />
                </div>
                <div className="form-field">
                    <label>Collector *</label>
                    <input
                        type="text"
                        name="collector"
                        value={collector}
                        onChange={onCollector}
                        placeholder="N. A. Thornberry"
                        required
                    />
                </div>
                <div className="form-field">
                    <label>Specimen Type</label>
                    <input
                        type="text"
                        name="collector"
                        value={specimen_type}
                        onChange={onSpecimenType}
                        placeholder="Wasps"
                    />
                </div>
                <div className="form-field">
                    <label>Specimen Count</label>
                    <input
                        type="number"
                        name="specimen_count"
                        value={specimen_count}
                        onChange={onSpecimenCount}
                        placeholder="2"
                        step="1"
                    />
                </div>
                <div className="form-field">
                    <label>State/Territory</label>
                    <input
                        type="text"
                        name="state"
                        value={state}
                        onChange={onState}
                        placeholder="WA"
                    />
                </div>
                <div className="form-field">
                    <label>Location</label>
                    <input
                        type="text"
                        name="location"
                        value={location}
                        onChange={onLocation}
                        placeholder="5km N of Woop Woop"
                    />
                </div>
                <div className="form-field">
                    <label>Method</label>
                    <input
                        type="text"
                        name="method"
                        value={method}
                        onChange={onMethod}
                        placeholder="General sweep/malaise trap"
                    />
                </div>
                <div className="form-field">
                    <label>Flower/Host Plant</label>
                    <input
                        type="text"
                        name="flower_type"
                        value={host_plant}
                        onChange={onHostPlant}
                        placeholder="Eucalyptus leucoxylon"
                    />
                </div>
                <div className="form-field">
                    <label>Notes</label>
                    <textarea
                        name="notes"
                        value={notes}
                        onChange={onNotes}
                        placeholder="..."
                    />
                </div>
                <button className={css("button", { highlight })} type="submit">
                    {entry ? "Save" : "Create"}
                </button>
            </div>
        </form>
        
    )
}
    
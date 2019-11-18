
import { h } from 'preact';
import { useState, useMemo, useRef, useEffect } from 'preact/hooks';
import { useParams, Redirect } from 'react-router';
import { Link } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { DateTime } from 'luxon';
import { DispatchFn } from './store';
import { useGetEntry, positionToString, EntryData } from './Entry';
import { useGetFields } from './Configuration';
import { useInput } from './useInput';
import { useGeo, sleep } from './useGeo';
import { ValidVoucherInput } from './ValidVoucherInput';
import { EntryEditField } from './EntryEditField';
import { css } from './css';

type Params = {
    entry_id?: string;
}

export function EntryEditView() {
    
    // Note, this refreshes on every render.
    const timestamp = +new Date();
    
    const { entry_id } = useParams<Params>();
    
    const dispatch = useDispatch<DispatchFn>();
    const entry = useGetEntry(entry_id);
    const fields = useGetFields();
    
    // The datetime string is from either the creation timestamp (above)
    // or the entry timestamp being edited.
    const datetime = useMemo(() => {
        const date = DateTime.fromMillis(entry
                ? entry.entry_id
                : timestamp);
        return date.toLocaleString(DateTime.DATE_SHORT) + " " +
            date.toLocaleString(DateTime.TIME_24_SIMPLE);
    }, [entry && entry.entry_id, timestamp]);
    
    const [redirect, setRedirect] = useState("");
    
    // highlight the 'create' button when valid (only for new entries).
    const [highlight, setHighlight] = useState(false);
    
    useEffect(() => {
        setHighlight(!entry && !!form.current && form.current.checkValidity());
    });
    
    const form = useRef<HTMLFormElement | null>(null);
    const [voucher, onVoucher] = useInput(entry?.voucher);
    const [collector, onCollector] = useInput(entry?.collector);
    const [type, onType] = useInput(entry?.type);
    const [position, geo_busy, getGeo] = useGeo(entry?.position);
    
    const [data, setData] = useState<EntryData>(() => entry?.data ?? {});
    
    function onUpdateData(key: string, value: string) {
        const copy = {...data};
        copy[key] = value;
        setData(copy);
    }
    
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
                    type,
                    data,
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
                    type,
                    data,
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
                    <div className="form-group">
                        <div className="form-field">
                            <input
                                type="text"
                                name="position"
                                value={position
                                    ? positionToString(position)
                                    : '...'}
                                readOnly
                            />
                        </div>
                        <button type="button"
                            className="button icon"
                            disabled={geo_busy}
                            onClick={getGeo}>
                            <img src="/gmd-refresh.svg" />
                        </button>
                    </div>
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
                    <label>Specimen Type*</label>
                    <input
                        type="text"
                        name="type"
                        value={type}
                        onChange={onType}
                        placeholder="Specimen"
                        required
                    />
                </div>
                
                {fields?.map(field => (
                    <EntryEditField
                        key={field.name}
                        field={field}
                        onUpdate={onUpdateData}
                        value={data[field.name]}
                    />
                ))}
                
                <button className={css("button", { highlight })} type="submit">
                    {entry ? "Save" : "Create"}
                </button>
            </div>
        </form>
        
    )
}


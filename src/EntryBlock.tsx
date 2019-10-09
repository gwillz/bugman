
import { h, Fragment } from 'preact';
import { DateTime } from 'luxon';
import { Link } from 'react-router-dom';
import { Entry, positionToString } from './entry';
import { css } from './css';

type Props = {
    entry: Entry;
    open?: boolean;
}

export function EntryBlock(props: Props) {
    const {entry} = props;
    const {entry_id} = entry;
    
    return (
        <div className={css("entry-block", {"entry-open": props.open })}>
            <Link to={props.open ? "/" : `/${entry_id}`} className="entry-tab">
                {entry.voucher}
            </Link>
            {!props.open ? (
                <Fragment>
                    <div className="entry-brief">
                        <span>
                            {DateTime.fromMillis(entry.entry_id)
                                .toLocaleString(DateTime.DATE_MED)}
                        </span>
                        <span>
                            {entry.specimen_type}
                        </span>
                        <span>
                            {entry.collector}
                        </span>
                    </div>
                </Fragment>
            ) : (
                <Fragment>
                    <div className="entry-record">
                        <label>Voucher</label>
                        <span>
                            {entry.voucher}
                        </span>
                    </div>
                    <div className="entry-record">
                        <label>Date</label>
                        <span>
                            {DateTime.fromMillis(entry.entry_id)
                            .toLocaleString(DateTime.DATE_MED)}
                            &nbsp;-&nbsp;
                            {DateTime.fromMillis(entry.entry_id)
                            .toLocaleString(DateTime.TIME_24_SIMPLE)}
                        </span>
                    </div>
                    <div className="entry-record">
                        <label>Type</label>
                        <span>
                            {entry.specimen_type}
                        </span>
                    </div>
                    <div className="entry-record">
                        <label>Collector</label>
                        <span>
                            {entry.collector}
                        </span>
                    </div>
                    <div className="entry-record">
                        <label>Position</label>
                        <span>{positionToString(entry.position)}</span>
                    </div>
                    <div className="entry-record">
                        <label>Specimen Count</label>
                        <span>{entry.specimen_count}</span>
                    </div>
                    <div className="entry-record">
                        <label>Location</label>
                        <span>{entry.location}</span>
                    </div>
                    <div className="entry-record">
                        <label>Method</label>
                        <span>{entry.method}</span>
                    </div>
                    <div className="entry-record">
                        <label>Flower/Host Plant</label>
                        <span>{entry.host_plant}</span>
                    </div>
                    <div className="entry-record-block">
                        <label>Notes</label>
                        <div dangerouslySetInnerHTML={{
                            __html: entry.notes 
                                ? entry.notes.replace(/[\r\n]+/, "<br/>")
                                : '',
                        }}/>
                    </div>
                    <div className="navbar">
                        <Link className="button" to={`/${entry_id}/edit`}>
                            Edit
                        </Link>
                        <Link className="button" to={`/${entry_id}/delete`}>
                            Delete
                        </Link>
                    </div>
                </Fragment>
            )}
        </div>
    )
}


import { h, Fragment } from 'preact';
import { Entry } from 'store';
import { DateTime } from 'luxon';
import { Link } from 'react-router-dom';

type Props = {
    entry: Entry;
    detailed?: boolean;
}

export function EntryBlock(props: Props) {
    const {entry} = props;
    const {entry_id} = entry;
    
    return (
        <div className="entry-block">
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
            {props.detailed && (
                <Fragment>
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
                        <label>Flower Type</label>
                        <span>{entry.flower_type}</span>
                    </div>
                    <div className="entry-record">
                        <label>Notes</label>
                        <div dangerouslySetInnerHTML={{
                            __html: entry.notes 
                                ? entry.notes.replace(/[\r\n]+/, "<br/>")
                                : '',
                        }}/>
                    </div>
                </Fragment>
            )}
            {!props.detailed && (
                <div className="entry-footer">
                    <Link className="button" to={`/${entry_id}`}>
                        View
                    </Link>
                    <Link className="button" to={`/${entry_id}/edit`}>
                        Edit
                    </Link>
                    <Link className="button" to={`/${entry_id}/delete`}>
                        Delete
                    </Link>
                </div>
            )}
        </div>
    )
}
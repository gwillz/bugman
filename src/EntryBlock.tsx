
import * as React from 'react';
import { Entry } from 'store';
import { DateTime } from 'luxon';
import { Link } from 'react-router-dom';

type Props = {
    entry: Entry;
    short?: boolean;
}

export function EntryBlock(props: Props) {
    const { entry_id, name, mark, notes } = props.entry;
    
    return (
        <div className="entry-block">
            <div className="entry-record">
                <label>Date</label>
                <span>
                    {DateTime.fromMillis(entry_id)
                    .toLocaleString(DateTime.DATETIME_MED)}
                </span>
            </div>
            <div className="entry-record">
                <label>Name</label>
                <span>
                    {name}
                </span>
            </div>
            <div className="entry-record">
                <label>Mark</label>
                <span>
                    {mark[0]},&nbsp;{mark[1]}
                </span>
            </div>
            {!props.short && (
                <div className="entry-record">
                    <label>Notes</label>
                    <div dangerouslySetInnerHTML={{
                        __html: notes ? notes.replace(/[\r\n]+/, "<br/>"): '',
                    }}/>
                </div>
            )}
            {props.short && (
                <div className="entry-footer">
                    <Link className="button" to={`/${entry_id}`}>
                        Notes
                    </Link>
                    <Link className="button" to={`/${entry_id}/edit`}>
                        Edit
                    </Link>
                </div>
            )}
        </div>
    )
}
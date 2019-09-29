
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
        <div>
            <div>
                <label>Date</label>
                <span>
                    {DateTime.fromMillis(entry_id)
                    .toLocaleString(DateTime.DATETIME_MED)}
                </span>
            </div>
            <div>
                <label>Name</label>
                <span>
                    {name}
                </span>
            </div>
            <div>
                <label>Mark</label>
                <span>
                    {mark[0]},&nbsp;{mark[1]}
                </span>
            </div>
            {!props.short && (
                <div>
                    <label>Notes</label>
                    <div dangerouslySetInnerHTML={{
                        __html: notes ? notes.replace(/[\r\n]+/, "<br/>"): '',
                    }}/>
                </div>
            )}
            {props.short && (
                <div>
                    <Link to={`/${entry_id}`}>
                        View Notes
                    </Link>
                    <Link to={`/${entry_id}/edit`}>
                        Edit
                    </Link>
                </div>
            )}
        </div>
    )
}
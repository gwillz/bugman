
import { h } from 'preact';
import { ConfigField } from './Configuration';

type Props = {
    field: ConfigField;
    value: string | number;
}

export function EntryRecord(props: Props) {
    
    const { value } = props;
    const { name, type } = props.field;
    
    if (type === "text" && typeof value === "string") {
        return (
            <div className="entry-record-block">
                <label>{name}</label>
                <div dangerouslySetInnerHTML={{
                    __html: value.replace(/[\r\n]+/, "<br/>"),
                }}/>
            </div>
        )
    }
    else {
        return (
            <div className="entry-record">
                <label>{name}</label>
                <span>{value}</span>
            </div>
        )
    }
}


import { h } from 'preact';
import { ConfigField } from './Configuration';

type Props = {
    field: ConfigField;
    value: string | number;
}

export function EntryRecord(props: Props) {
    
    const { value } = props;
    const { type } = props.field;
    const label = props.field.label || props.field.name;
    
    if (type === "text" && typeof value === "string") {
        return (
            <div className="entry-record-block">
                <label>{label}</label>
                <div dangerouslySetInnerHTML={{
                    __html: value.replace(/[\r\n]+/, "<br/>"),
                }}/>
            </div>
        )
    }
    else {
        return (
            <div className="entry-record">
                <label>{label}</label>
                <span>{value}</span>
            </div>
        )
    }
}


import { h, JSX } from 'preact';
import { ConfigField } from './Configuration';

type Props = {
    field: ConfigField;
    value: string | number | undefined;
    onUpdate: (key: string, value: string) => void;
}

export function EditRecord(props: Props) {
    const { type } = props.field;
    
    if (type === "text") {
       return <AreaRecord {...props} />
    }
    else if (type === "integer" || type === "decimal") {
        return <NumberRecord {...props} />
    }
    else {
        return <StringRecord {...props} />
    }
}

function AreaRecord(props: Props) {
    const { field, value } = props;
    
    function onChange(event: JSX.TargetedEvent<HTMLTextAreaElement>) {
        const { value } = event.currentTarget;
        props.onUpdate(field.name, value);
    }
    
    return (
        <div className="form-field">
            <label>{field.label || field.name}</label>
            <textarea
                name={field.name}
                value={value}
                onChange={onChange}
                placeholder={field.placeholder || "..."}
            />
        </div>
    )
}

function NumberRecord(props: Props) {
    const { field, value } = props;
    const step = field.type === "integer" ? 1 : undefined;
    
    function onChange(event: JSX.TargetedEvent<HTMLInputElement>) {
        const { value } = event.currentTarget;
        props.onUpdate(field.name, value);
    }
    
    return (
        <div className="form-field">
            <label>{field.label || field.name}</label>
            <input
                type="number"
                name={field.name}
                value={value}
                onChange={onChange}
                placeholder={field.placeholder}
                step={step}
            />
        </div>
    )
}

function StringRecord(props: Props) {
    const { field, value } = props;
    
    function onChange(event: JSX.TargetedEvent<HTMLInputElement>) {
        const { value } = event.currentTarget;
        props.onUpdate(field.name, value);
    }
    
    return (
        <div className="form-field">
            <label>{field.label || field.name}</label>
            <input
                type="text"
                name={field.name}
                value={value}
                onChange={onChange}
                placeholder={field.placeholder}
            />
        </div>
    )
}

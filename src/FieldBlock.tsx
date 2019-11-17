
import { h, JSX } from 'preact';
import { ConfigField, TYPES } from './Configuration';

type Props = {
    index: number;
    field: ConfigField;
    onUpdate: (index: number, field: ConfigField) => void;
    onRemove: (index: number) => void;
}

export function FieldBlock(props: Props) {
    const { index } = props;
    const { name, type } = props.field;
    
    function onChange(event: JSX.TargetedEvent<HTMLSelectElement | HTMLInputElement>) {
        const { name, value } = event.currentTarget;
        
        props.onUpdate(index, {
            ...props.field,
            [name]: value,
        });
    }
    
    function onRemove() {
        props.onRemove(index);
    }
    
    return (
        <div className="form-group field-block">
            <div className="form-field">
                <input
                    type="text"
                    name="name"
                    placeholder="Field Name"
                    value={name}
                    onChange={onChange}
                    required
                />
            </div>
            <div className="form-field">
                <select
                    name="type"
                    value={type}
                    onChange={onChange}>
                    {TYPES.map(type => (
                        <option key={type} value={type}>
                            {type}
                        </option>
                    ))}
                </select>
            </div>
            <button type="button"
                className="button icon"
                onClick={onRemove}>
                X
            </button>
        </div>
    )
}

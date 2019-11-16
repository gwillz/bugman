
import { h, Fragment } from 'preact';
import { useState } from 'preact/hooks';
import { useDispatch } from 'react-redux';
import { useParams, Redirect } from 'react-router';
import { DispatchFn } from './store';
import { useGetFields, ConfigField } from './Configuration';
import { Link } from 'react-router-dom';
import { FieldBlock } from './FieldBlock';

import TEMPLATES from './templates';

const EMPTY_FIELDS: ConfigField[] = [{
    name: "",
    type: "string",
}]

type Params = {
    index?: string;
}

type Props = {
    editing?: boolean;
}

export function ConfigEditView(props: Props) {
    
    const { index } = useParams<Params>();
    const config = index ? TEMPLATES[+index - 1] : null;
    const stored_fields = useGetFields();
    const [fields, setFields] = useState(() => (
        props.editing
        ? stored_fields ?? []
        : config?.fields ?? EMPTY_FIELDS
    ));
    
    const [redirect, setRedirect] = useState("");
    const dispatch = useDispatch<DispatchFn>();
    
    function addField() {
        setFields([ ...fields, {
            name: "",
            type: "string",
        }]);
    }
    
    function updateField(index: number, field: ConfigField) {
        const copy = [ ...fields ];
        copy.splice(index, 1, field);
        setFields(copy);
    }
    
    function removeField(index: number) {
        const copy = [ ...fields ];
        copy.splice(index, 1);
        setFields(copy);
    }
    
    function onSubmit(event: Event) {
        event.preventDefault();
        dispatch({ type: "CONFIG", fields });
        setRedirect("/config");
    }
    
    if (redirect) {
        return <Redirect to={redirect} />
    }
    
    return (
        <form onSubmit={onSubmit}>
            {config ? (
            <Fragment>
                <div className="text-message">
                    Applying template: {config.name}
                </div>
                <div>
                    {config.description}
                    <br/>
                    By {config.contributor}.
                </div>
                <br/>
            </Fragment>
            ) : (
                <div className="text-message">
                    Edit Fields
                </div>
            )}
            <div className="form">
                {fields.map((field, index) => (
                    <FieldBlock
                        key={index}
                        index={index}
                        field={field}
                        onUpdate={updateField}
                        onRemove={removeField}
                    />
                ))}
                {fields.length == 0 && (
                    <span>No fields.</span>
                )}
            </div>
            <nav className="navbar">
                <Link to="/config"
                    className="button">
                    Back
                </Link>
                <button type="button"
                    className="button highlight"
                    onClick={addField}>
                    Add Field
                </button>
                <button type="submit"
                    className="button highlight">
                    {props.editing ? "Save" : "Apply"}
                </button>
            </nav>
        </form>
    )
}


import { h, JSX, Fragment } from 'preact';
import { useState } from 'preact/hooks';
import { useDispatch } from 'react-redux';
import { useParams, Redirect } from 'react-router';
import { Link } from 'react-router-dom';
import { DndProvider } from 'react-dnd';
import TouchBackend from 'react-dnd-touch-backend';
import { useGetFields, ConfigField, Configuration } from './Configuration';
import { DispatchFn } from './store';
import { FieldBlock } from './FieldBlock';

import { TEMPLATES } from './templates';

// The typings are kinda broken here, but it still works.
const HackDndProvider = DndProvider as (props: any) => JSX.Element;

const EMPTY_FIELDS: ConfigField[] = [{
    name: "",
    type: "string",
}]

export function ConfigNewView() {
    return (
        <ConfigFormView
            back_path="/settings"
            fields={EMPTY_FIELDS}
        />
    )
}

export function ConfigEditView() {
    const fields = useGetFields();
    
    if (!fields) {
        return <Redirect to="/config/new" />
    }
    
    return (
        <ConfigFormView
            back_path="/settings"
            fields={fields}
        />
    )
}

type Params = {
    index: string;
}

export function TemplateEditView() {
    const { index } = useParams<Params>();
    const config = TEMPLATES[+index - 1];
    
    return (
        <ConfigFormView
            back_path="/templates"
            fields={config.fields}
            config={config}
        />
    )
}


type Props = {
    back_path: string;
    fields: ConfigField[];
    config?: Configuration;
}

function ConfigFormView(props: Props) {
    const [fields, setFields] = useState(props.fields);
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
    
    function moveField(from: number, to: number) {
        const copy = [ ...fields ];
        const [item] = copy.splice(from, 1);
        copy.splice(to, 0, item);
        setFields(copy);
    }
    
    function onSubmit(event: Event) {
        event.preventDefault();
        dispatch({ type: "CONFIG", fields });
        setRedirect("/");
    }
    
    if (redirect) {
        return <Redirect to={redirect} />
    }
    
    return (
        <form onSubmit={onSubmit}>
            {props.config ? (
            <Fragment>
                <div className="text-title">
                    Applying template: {props.config.name}
                </div>
                <div>
                    {props.config.description}
                    <br/>
                    By {props.config.contributor}.
                </div>
                <br/>
            </Fragment>
            ) : (
            <div className="text-title">
                Edit Fields
            </div>
            )}
            <div className="form">
                <HackDndProvider backend={TouchBackend} options={{
                    delay: 350,
                }}>
                {fields.map((field, index) => (
                    <FieldBlock
                        key={field.name}
                        index={index}
                        field={field}
                        onUpdate={updateField}
                        onRemove={removeField}
                        onMove={moveField}
                    />
                ))}
                </HackDndProvider>
                {fields.length == 0 && (
                    <span>No fields.</span>
                )}
            </div>
            <nav className="navbar">
                <Link to={props.back_path}
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
                    Save
                </button>
            </nav>
        </form>
    )
}

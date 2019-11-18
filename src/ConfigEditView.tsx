
import { h, JSX, Fragment } from 'preact';
import { useState } from 'preact/hooks';
import { useDispatch } from 'react-redux';
import { useParams, Redirect } from 'react-router';
import { Link } from 'react-router-dom';
import { DndProvider } from 'react-dnd';
import TouchBackend from 'react-dnd-touch-backend';
import { useGetFields, ConfigField, Configuration } from './Configuration';
import { DispatchFn } from './store';
import { ConfigEditFieldBlock, EditConfigField } from './ConfigEditFieldBlock';

import { TEMPLATES } from './templates';
import { useBackPath } from './Header';

// The typings are kinda broken here, but it still works.
const HackDndProvider = DndProvider as (props: any) => JSX.Element;

const EMPTY_FIELDS: ConfigField[] = [{
    name: "",
    type: "string",
}]

export function ConfigNewView() {
    
    useBackPath("/settings");
    
    return (
        <ConfigFormView
            fields={EMPTY_FIELDS}
        />
    )
}

export function ConfigEditView() {
    const fields = useGetFields();
    
    useBackPath("/settings");
    
    if (!fields) {
        return <Redirect to="/config/new" />
    }
    
    return (
        <ConfigFormView
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
    
    useBackPath("/templates");
    
    return (
        <ConfigFormView
            fields={config.fields}
            config={config}
        />
    )
}


type Props = {
    fields: ConfigField[];
    config?: Configuration;
}


function ConfigFormView(props: Props) {
    const [fields, setFields] = useState<EditConfigField[]>(() => (
        props.fields.map(field => ({
            ...field,
            _timestamp: Math.floor(Math.random() * +new Date()),
        }))
    ));
    
    const [redirect, setRedirect] = useState("");
    const dispatch = useDispatch<DispatchFn>();
    
    function addField() {
        setFields([ ...fields, {
            _timestamp: +new Date(),
            name: "",
            type: "string",
        }]);
    }
    
    function updateField(index: number, field: EditConfigField) {
        const copy: EditConfigField[] = [ ...fields ];
        // Always remove placeholder if present.
        copy.splice(index, 1, {
            ...field, 
            placeholder: undefined,
        });
        setFields(copy);
    }
    
    function removeField(index: number) {
        const copy: EditConfigField[] = [ ...fields ];
        copy.splice(index, 1);
        setFields(copy);
    }
    
    function moveField(from: number, to: number) {
        const copy: EditConfigField[] = [ ...fields ];
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
                    <ConfigEditFieldBlock
                        key={field._timestamp}
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

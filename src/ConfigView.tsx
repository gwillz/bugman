
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { useState, useMemo } from 'preact/hooks';
import { DateTime } from 'luxon';
import hashSum from 'hash-sum';
import { useGetConfig, STANDARD_FIELDS, Configuration } from './Configuration';


import TEMPLATES from './templates';

type Props = {
    // config: Configuration;
}

export function ConfigView(props: Props) {
    
    const config = useGetConfig();
    
    return (
        <div>
            <nav className="navbar">
                <Link className="button" to="/">
                    Home
                </Link>
            </nav>
            <div>
                Current config: {config?.name || "unset"}
            </div>
            <div className="entry-group">
                {TEMPLATES.map((config, i) => (
                    <ConfigBlock
                        key={i}
                        config={config}
                    />
                ))}
            </div>
        </div>
    )
}

type CProps = {
    config: Configuration;
}

export function ConfigBlock(props: CProps) {
    const { config } = props;
    
    const config_fields = useMemo(() => (
        STANDARD_FIELDS.concat(
            config.fields.map(field => field.name)
        ).join(", ")
    ), [hashSum(config.fields)]);
    
    return (
        <div className="entry-block">
            <span className="entry-tab">
                {config.name}
            </span>
            <div className="entry-brief">
                <span>
                    {DateTime.fromMillis(config.created)
                    .toLocaleString(DateTime.DATE_MED)}
                </span>
                <span>
                    {config.fields.length + STANDARD_FIELDS.length} fields
                </span>
            </div>
        </div>
    )
}


export function EditConfigView(props: Props) {
    
    function onSubmit(event: Event) {
        event.preventDefault();
    }
    
    return (
        <form onSubmit={onSubmit}>
            
        </form>
    )
}
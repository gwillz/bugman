
import { h } from 'preact';
import { useState } from 'preact/hooks';
import { Link, Redirect } from 'react-router-dom';
import { ConfigBlock } from './ConfigBlock';
import TEMPLATES from './templates';


export function ConfigView() {
    
    const [redirect, setRedirect] = useState("");
    
    function onNewConfig() {
        setRedirect("/config/new");
    }
    
    if (redirect) {
        return <Redirect to={redirect} />
    }
    
    return (
        <div>
            <nav className="navbar">
                <Link className="button" to="/">
                    Home
                </Link>
                <Link to="/config/edit"
                    className="button highlight">
                    Edit Fields
                </Link>
                <button type="button"
                    className="button highlight"
                    onClick={onNewConfig}>
                    Create New
                </button>
            </nav>
            <div className="entry-group">
                {TEMPLATES.map((config, i) => (
                    <ConfigBlock
                        key={i}
                        index={i + 1}
                        config={config}
                    />
                ))}
            </div>
        </div>
    )
}

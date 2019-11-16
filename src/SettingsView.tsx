
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { useGetEntries } from './Entry';
import { useGetFields } from './Configuration';
import { css } from './css';

export function SettingsView() {
    
    const entries = useGetEntries();
    const fields = useGetFields();
    
    return (
        <div>
            <div className="text-message">
                Settings
            </div>
            <Link className="button" to="/">
                Home
            </Link>
            <div>
                Choose a format template
                <br/>
                <Link to="/templates"
                    className="button highlight">
                    Templates
                </Link>
            </div>
            <div>
                Create a custom format
                <br/>
                <Link to="/config/new"
                    className="button highlight">
                    Create
                </Link>
            </div>
            <div>
                Clear all data
                <br/>
                <Link to="/clear"
                    className={css("button", {
                        disabled: entries.length === 0,
                        highlight: entries.length !== 0,
                    })}>
                    Delete All
                </Link>
            </div>
            {/* @todo Space estimates. */}
        </div>
    )
}

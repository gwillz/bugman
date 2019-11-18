
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { useGetEntries } from './Entry';
import { useGetFields } from './Configuration';
import { StatsBlock } from './StatsBlock';
import { css } from './css';

export function SettingsView() {

    const entries = useGetEntries();
    const fields = useGetFields();
    
    return (
        <div>
            <div className="text-title">
                Settings
            </div>
            <div className="text-message">
                Choose a format template
            </div>
            <Link to="/templates"
                className="button highlight">
                Templates
            </Link>
            <div className="text-message">
                {fields === null
                    ? "Create a custom format"
                    : "Edit current format"
                }
            </div>
            <Link to={fields === null ? "/config/new" : "/config/edit"}
                className="button highlight">
                {fields === null ? "Create" : "Edit"}
            </Link>
            <div className="text-message">
                Clear all data
            </div>
            <Link to="/clear"
                className={css("button", {
                    disabled: entries.length === 0,
                    highlight: entries.length !== 0,
                })}>
                Delete All
            </Link>
            <div className="text-message">
                View Entries
            </div>
            <Link className="button" to="/">
                Home
            </Link>
            <br />
            <StatsBlock/>
        </div>
    )
}

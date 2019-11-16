
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { ConfigBlock } from './ConfigBlock';

import { TEMPLATES } from './templates';

export function TemplatesView() {
    return (
        <div>
            <nav className="navbar">
                <Link to="/settings" className="button">
                    Back
                </Link>
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

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
            <div className="">
                {TEMPLATES.map((config, i) => (
                    <ConfigBlock
                        key={i}
                        index={i + 1}
                        config={config}
                    />
                ))}
            </div>
            <div>
                <br/>
                If you have a set of fields you always use, feel free to send
                them through and they can be included here.
                <br/>
                <a href="mailto:bugman@gwilyn.com">
                    bugman@gwilyn.com
                </a>
            </div>
        </div>
    )
}

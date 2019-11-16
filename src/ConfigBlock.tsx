
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { Configuration, STANDARD_FIELDS } from './Configuration';

type Props = {
    index: number;
    config: Configuration;
}

export function ConfigBlock(props: Props) {
    const { config, index } = props;
    
    return (
        <div className="entry-block">
            <Link to={"/config/new/" + index}
                className="entry-tab">
                {config.name}
            </Link>
            <div className="entry-brief">
                <span>
                    {config.contributor}
                </span>
                <span>
                    {config.fields.length + STANDARD_FIELDS.length}
                    &nbsp;
                    fields
                </span>
            </div>
        </div>
    )
}

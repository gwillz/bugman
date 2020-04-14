
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { Configuration } from './Configuration';

type Props = {
    index: number;
    config: Configuration;
}

export function ConfigBlock(props: Props) {
    const { config, index } = props;
    
    return (
        <Link to={"/templates/" + index} className="config-block">
            <div className="text-bold">
                {config.name}
            </div>
            <div>
                {config.contributor}{" / "}
                {config.fields.length} fields
            </div>
        </Link>
    )
}

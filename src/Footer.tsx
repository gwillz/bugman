
import { h } from 'preact';
import { useMemo } from 'preact/hooks';

export function Footer() {
    const build_timestamp = useMemo(() => (
        new Date(process.env.BUILD_TIMESTAMP || "").toISOString()
    ))
    
    const build_year = useMemo(() => (
        new Date(process.env.BUILD_TIMESTAMP || "").getFullYear()
    ))
    
    return (
        <footer className="footer">
            <a href="//git.gwillz.com/gwillz/bugman" target="_blank">
                <div>Version: {process.env.VERSION}</div>
                <div>Build: {build_timestamp}</div>
            </a>
            <div>
                <a href="//gwilyn.com" target="_blank">
                    Gwillz
                </a>
                &nbsp;&&nbsp;
                <a href="//lourobinson.co" target="_blank">
                    Lou Design
                </a>
                <span>
                    &nbsp;
                    &copy;
                    &nbsp;
                    {build_year}
                </span>
            </div>
        </footer>
    )
}

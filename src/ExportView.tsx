
import { h } from 'preact';
import { Link } from 'react-router-dom';
import { useRef } from 'preact/hooks';
import { DateTime } from 'luxon';
import { useGetEntries } from './entry';
import { CSVBuilder } from './CSVBuilder';
import { useInput } from './useInput';


export function ExportView() {
    const entries = useGetEntries();
    
    const ref = useRef<HTMLAnchorElement | null>(null);
    const [filename, onFilename] = useInput(() => (
        DateTime.local().toFormat("yyyy-MM-dd_HH-mm")
    ))
    
    function onExport(event: Event) {
        event.preventDefault();
        
        if (!ref.current) return;
        
        const builder = new CSVBuilder();
        
        builder.setHeaders(
            "Voucher",
            "Date",
            "Time",
            "# of specimens",
            "Type",
            "Latitude",
            "Longitude",
            "Elevation (m)",
            "Collector",
            "Method",
            "Flower type",
            "Location",
            "Notes",
        );
        
        for (let entry of entries) {
            const date = DateTime.fromMillis(entry.entry_id);
            builder.add(
                entry.voucher,
                date.toLocaleString(DateTime.DATE_SHORT),
                date.toLocaleString(DateTime.TIME_24_SIMPLE),
                entry.voucher,
                entry.specimen_count || "",
                entry.specimen_type || "",
                entry.position.latitude,
                entry.position.longitude,
                entry.position.elevation,
                entry.collector || "",
                entry.method || "",
                entry.flower_type || "",
                entry.location || "",
                entry.notes || "",
            );
        }
        
        // @todo Download name prompt.
        ref.current.href = encodeURI("data:text/csv," + builder.build());
        ref.current.download = filename + ".csv";
        ref.current.click();
    }
    
    return (
        <form onSubmit={onExport}>
            <a ref={ref} style={{display: 'none'}} />
            
            <div className="navbar">
                <Link to="/" className="button">
                    Home
                </Link>
                <button type="submit"
                    className="button"
                    disabled={entries.length > 0}>
                    Export
                </button>
            </div>
            
            <div className="form">
                <h3>Exporting {entries.length} entries.</h3>
                
                <div className="form-field">
                    <label>File name</label>
                    <input
                        type="text"
                        name="filename"
                        value={filename}
                        onChange={onFilename}
                        required
                    />
                </div>
            </div>
        </form>
    )
}

import { h } from 'preact';
import { Link } from 'react-router-dom';
import { useRef } from 'preact/hooks';
import { DateTime } from 'luxon';
import { useGetEntries } from './entry';
import { CSVBuilder } from './CSVBuilder';
import { useInput } from './useInput';

declare global {
    interface WebShare {
        files?: Blob[];
        url?: string;
        text?: string;
        title?: string;
    }
    
    interface Navigator {
        share?: (data: WebShare) => Promise<void>;
        canShare?: (data: WebShare) => boolean;
    }
}


export function ExportView() {
    const entries = useGetEntries();
    
    const ref = useRef<HTMLAnchorElement | null>(null);
    const [filename, onFilename] = useInput(() => (
        DateTime.local().toFormat("yyyy-MM-dd_HH-mm")
    ))
    
    function onExport() {
        const csv = buildCSV();
        if (navigator.share && navigator.canShare) {
            const file = new File(
                [csv],
                filename + ".csv",
                { type: 'text/csv' },
            );
            
            const data: WebShare = {
                files: [ file ],
            };
            
            if (navigator.canShare(data)) {
                navigator.share(data)
                .then(() => void 0)
                .catch(err => {
                    console.log(err, err.message);
                })
            }
        }
        else if (ref.current) {
            ref.current.href = encodeURI("data:text/csv," + csv);
            ref.current.download = filename + ".csv";
            ref.current.click();
        }
        else {
            console.log("cant export!");
        }
    }
    
    function buildCSV() {
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
        return builder.build();
    }
    
    return (
        <div>
            <a ref={ref} style={{display: 'none'}} />
            
            <div className="navbar">
                <Link to="/" className="button">
                    Home
                </Link>
                <button type="button"
                    className="button"
                    onClick={onExport}
                    disabled={entries.length == 0}>
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
        </div>
    )
}
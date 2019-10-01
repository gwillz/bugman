import { DateTime } from 'luxon';

type CSVCell = number | string | DateTime;

export class CSVBuilder {
    
    private headers: string[];
    private rows: CSVCell[][];
    
    private url: string;
    
    constructor() {
        this.headers = [];
        this.rows = [];
        this.url = "";
    }
    
    public setHeaders(...names: string[]) {
        this.headers = names;
        return this;
    }
    
    public add(...data: CSVCell[]) {
        this.rows.push(data);
        return this;
    }
    
    public build(): string {
        let csv = "";
        
        const data = [this.headers, ...this.rows];
        
        for (let row of data) {
            csv += row.map(field => {
                // DateTime.
                if (DateTime.isDateTime(field)) {
                    return field.toISO();
                }
                else if (typeof field === "string") {
                    // Dirty strings.
                    if (/[ \r\n]/g.test(field)) {
                        const str = field
                            .replace(/"+/g, "\\\"")
                            .replace(/[\r\n]+/g, "\\n")
                            .trim();
                        return `"${str}"`;
                    }
                    // Clean strings.
                    else {
                        return field;
                    }
                }
                // integer
                else if (field % 1 == 0) {
                    return field.toFixed(0);
                }
                // float
                else {
                    // '7' appears to be the highest precision.
                    return field.toFixed(7);
                }
            })
            .join(",");
            
            csv += "\n";
        }
        
        return csv;
    }
    
    public buildFile(filename: string): File {
        const csv = this.build();
        
        if (!filename.endsWith(".csv")) {
            filename += ".csv";
        }
        
        return new File([csv], filename, { type: "text/csv" });
    }
    
    public buildFileUrl(filename: string): [string, string] {
        const file = this.buildFile(filename);
        
        if (this.url) {
            URL.revokeObjectURL(this.url);
        }
        
        this.url = URL.createObjectURL(file);
        return [this.url, file.name];
    }
}
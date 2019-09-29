import { DateTime } from 'luxon';

type CSVCell = number | string | DateTime;

export class CSVBuilder {
    
    private headers: string[];
    private data: CSVCell[][];
    
    constructor() {
        this.headers = [];
        this.data = [];
    }
    
    public setHeaders(...names: string[]) {
        this.headers = names;
        return this;
    }
    
    public add(...data: CSVCell[]) {
        this.data.push(data);
        return this;
    }
    
    public build() {
        let csv = "";
        csv += this.headers
            .map(field => `"${field}"`)
            .join(",");
        
        csv += "\n";
        
        for (let row of this.data) {
            csv += row.map(field => {
                if (DateTime.isDateTime(field)) {
                    return field.toISO();
                }
                else if (typeof field === "string") {
                    return `"${field}"`;
                }
                // integer
                else if (field % 1 == 0) {
                    return field.toFixed(0);
                }
                // float
                else {
                    return field.toFixed(12);
                }
            })
            .join(",");
            
            csv += "\n";
        }
        
        return csv;
    }
}
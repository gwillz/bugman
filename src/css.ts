
type CSSValue = string | Record<string, any> | string[];

export function css(...values: CSSValue[]): string {
    const out: string[] = [];
    
    let i = values.length;
    while (i--) {
        let value = values[i];
        console.log(i, value);
        
        if (typeof value === "string") {
            out.push(value);
        }
        else if (isArray(value)) {
            out.push(value.join(" "));
        }
        else if (isRecord(value)) {
            for (let key in value) {
                if (!value[key]) continue;
                out.push(key);
            }
        }
        // panic?
    }
    return out.join(" ");
}

function isRecord(test: any): test is Record<string, any> {
    return (
        typeof test === "object" &&
        test.constructor &&
        test.constructor.name === "Object"
    )
}

function isArray(test: any): test is string[] {
    return (
        typeof test === "object" &&
        test.constructor &&
        test.constructor.name === "Array"
    )
}

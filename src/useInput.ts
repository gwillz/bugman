
import { useState, useEffect } from 'preact/hooks';

type InitType = string | (() => string);

export function useInput(init: InitType = "") {
    const [value, set] = useState(init);
    
    useEffect(() => void set(init), [init && typeof init === "string"]);
    
    function handle(event: Event) {
        set((event.currentTarget as HTMLInputElement).value || "");
    }
    
    return [value, handle] as [typeof value, typeof handle];
}

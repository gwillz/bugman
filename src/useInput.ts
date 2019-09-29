
import { useState, useEffect } from 'preact/hooks';

export function useInput(init = "") {
    const [value, set] = useState(init);
    
    useEffect(() => void set(init), [init]);
    
    function handle(event: Event) {
        set((event.currentTarget as HTMLInputElement).value || "");
    }
    
    return [value, handle] as [typeof value, typeof handle];
}

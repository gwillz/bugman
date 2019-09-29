
import { useState, useEffect } from 'react';

export function useInput(init = "") {
    const [value, set] = useState(init);
    
    useEffect(() => void set(init), [init]);
    
    function handle(event: React.ChangeEvent<any>) {
        set((event.currentTarget as HTMLInputElement).value || "");
    }
    
    return [value, handle] as [typeof value, typeof handle];
}

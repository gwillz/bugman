
import { JSX } from 'preact';
import { useState, useEffect } from 'preact/hooks';

type InitType = string | (() => string);

export function useInput(init: InitType = "") {
    const [value, set] = useState(init);
    
    useEffect(() => void set(init), [init && typeof init === "string"]);
    
    function handle(event: JSX.TargetedEvent<HTMLInputElement>) {
        set(event.currentTarget.value || "");
    }
    
    return [value, handle] as [typeof value, typeof handle];
}

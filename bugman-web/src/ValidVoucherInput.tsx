
import { h, JSX } from 'preact';
import { useRef } from 'preact/hooks';
import { useGetEntries } from './Entry';

type Props = JSX.HTMLAttributes<HTMLInputElement> & {
    autoCapitalize?: string;
}

export function ValidVoucherInput(props: Props) {
    const ref = useRef<HTMLInputElement | null>(null);
    const entries = useGetEntries();
    
    function onChange(event: JSX.TargetedEvent<HTMLInputElement>) {
        if (ref.current) {
            const found = entries.find(entry => (
                entry.voucher.toLowerCase() === ref.current!.value.toLowerCase())
            );
            ref.current.setCustomValidity(
                !!found
                ? `"${found.voucher}" already exists.`
                : ""
            );
        }
        
        // Forward.
        props.onChange?.(event);
    }
    
    return (
        <input
            {...props}
            onChange={onChange}
            ref={ref}
        />
    )
}
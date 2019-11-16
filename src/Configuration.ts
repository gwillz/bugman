
import { useSelector, shallowEqual } from 'react-redux';
import { State } from './store';

export const STANDARD_FIELDS = [
    "voucher",
    "datetime",
    "position",
    "collector",
];

export interface ConfigField {
    type: "string" | "text" | "number" | "image";
    name: string;
    label: string;
    placeholder: string;
}

export interface Configuration {
    name: string;
    description: string;
    created: number;
    fields: ConfigField[];
}

export function useGetConfig() {
    return useSelector((state: State) => state.config, shallowEqual);
}

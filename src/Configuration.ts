
import { useSelector, shallowEqual } from 'react-redux';
import { State } from './store';

// These are the keys in Entry.
export const STANDARD_FIELDS = [
    "voucher",
    "datetime",
    "position",
    "collector",
    "type",
];

export interface ConfigField {
    type: "string" | "text" | "integer" | "decimal";
    name: string;
    placeholder?: string;
}

export type FieldTypes = ConfigField['type'];

export const TYPES: FieldTypes[] = ["string", "text", "integer", "decimal"];

export interface Configuration {
    name: string;
    description: string;
    contributor: string;
    fields: ConfigField[];
}

export function useGetFields() {
    return useSelector((state: State) => state.fields, shallowEqual);
}


import { useSelector, shallowEqual } from 'react-redux';
import { State } from './store';

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

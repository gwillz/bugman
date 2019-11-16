
import { Configuration } from '../Configuration';

const template: Configuration = {
    name: "Rocks",
    description: "Tester template.",
    created: 1573867557361, // Nov 16 2019.
    fields: [
        {
            type: "string",
            name: "rock_type",
            label: "Rock Type",
            placeholder: "Granite",
        },
        {
            type: "number",
            name: "size",
            label: "Diameter Size",
            placeholder: "5",
        },
        {
            type: "string",
            name: "roughness",
            label: "Roughness",
            placeholder: "Very",
        },
        {
            type: "text",
            name: "notes",
            label: "Notes",
            placeholder: "...",
        },
    ],
}

export default template;

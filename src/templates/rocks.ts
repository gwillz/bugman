
import { Configuration } from '../Configuration';

const template: Configuration = {
    name: "Rocks",
    contributor: "Gwillz, Adelaide",
    description: "Tester template.",
    fields: [
        {
            type: "decimal",
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

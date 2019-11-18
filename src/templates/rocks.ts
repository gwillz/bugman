
import { Configuration } from '../Configuration';

const template: Configuration = {
    name: "Rocks",
    contributor: "Gwillz, Adelaide",
    description: "Tester template.",
    fields: [
        {
            type: "decimal",
            name: "Diameter Size",
            placeholder: "5",
        },
        {
            type: "string",
            name: "Roughness",
            placeholder: "Very",
        },
        {
            type: "text",
            name: "Notes",
            placeholder: "...",
        },
    ],
}

export default template;

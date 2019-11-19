
import { Configuration } from '../Configuration';

const template: Configuration = {
    name: "Rocks",
    contributor: "Field Assistant, Adelaide",
    description: "Tester template.",
    fields: [
        {
            type: "string",
            name: "Type",
            placeholder: "Big one",
        },
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

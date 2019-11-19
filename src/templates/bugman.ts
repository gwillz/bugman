
import { Configuration } from '../Configuration';

const template: Configuration = {
    name: "Wasp/Bugs",
    contributor: "Bugman, Adelaide",
    description: "Wasp and bug collection",
    fields: [
        {
            type: "string",
            name: "Specimen Type",
            placeholder: "Wasp",
        },
        {
            type: "string",
            name: "Specimen Count",
            placeholder: "2",
        },
        {
            type: "string",
            name: "State/Territory",
            placeholder: "WA",
        },
        {
            type: "string",
            name: "Location",
            placeholder: "5km N of Woop Woop",
        },
        {
            type: "string",
            name: "Method",
            placeholder: "General sweep/malaise trap",
        },
        {
            type: "string",
            name: "Flower/Host Plant",
            placeholder: "Eucalyptus leucoxylon",
        },
        {
            type: "text",
            name: "Notes",
            placeholder: "...",
        },
    ],
}

export default template;
    

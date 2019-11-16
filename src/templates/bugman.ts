
import { Configuration } from '../Configuration';

const template: Configuration = {
    name: "Wasp/Bugs",
    contributor: "Bugman, Adelaide",
    description: "Wasp and bug collection",
    fields: [
        {
            type: "integer",
            name: "specimen_count",
            label: "Specimen Count",
            placeholder: "2",
        },
        {
            type: "string",
            name: "state",
            label: "State/Territory",
            placeholder: "WA",
        },
        {
            type: "string",
            name: "location",
            label: "Location",
            placeholder: "5km N of Woop Woop",
        },
        {
            type: "string",
            name: "method",
            label: "Method",
            placeholder: "General sweep/malaise trap",
        },
        {
            type: "string",
            name: "flower_type",
            label: "Flower/Host Plant",
            placeholder: "Eucalyptus leucoxylon",
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
    
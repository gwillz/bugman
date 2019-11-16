
import { Configuration } from '../Configuration';

const template: Configuration = {
    name: "Bugman",
    description: "Wasp and bug collection. Adelaide, Australia.",
    created: 1573867557361, // Nov 16 2019.
    fields: [
        {
            type: "string",
            name: "specimen_type",
            label: "Specimen Type",
            placeholder: "Wasps",
        },
        {
            type: "number",
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
    
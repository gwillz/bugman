
import { useState, useEffect } from 'preact/hooks';
import { EntryPosition } from './Entry';

export function useGeo(mark?: EntryPosition) {
    const [state, set] = useState(mark);
    const [busy, setBusy] = useState(false);
    
    useEffect(() => void get(), [mark]);
    
    async function get() {
        setBusy(true);
        await sleep(200);
        try {
            set(mark || await getGeo({ enableHighAccuracy: true }));
        }
        catch (error) {
            console.log(error);
        }
        setBusy(false);
    }
    
    return [state, busy, get] as [typeof state, typeof busy, typeof get];
}

export async function sleep(timeout: number) {
    return new Promise(resolve => setTimeout(resolve, timeout));
}

async function getGeo(options?: PositionOptions) {
    return new Promise<EntryPosition>((resolve, reject) => {
        navigator.geolocation.getCurrentPosition(geo => {
            const { latitude, longitude, altitude } = geo.coords;
            const elevation = parseInt(altitude ? altitude.toFixed(0) : "0");
            resolve({
                latitude,
                longitude,
                elevation,
            });
        }, reject, options);
    });
}

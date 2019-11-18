
import { h } from 'preact';
import { useState, useEffect } from 'preact/hooks';

type Quota = {
    usage: number;
    total: number;
}

export function StatsBlock() {
    
    const [worker, setWorker] = useState<ServiceWorkerRegistration | null>(null);
    const [quota, setQuota] = useState<Quota | null>(null);
    const [ready, setReady] = useState(false);
    const [persist, setPersist] = useState(false);
    const [geo, setGeo] = useState(false);
    
    useEffect(() => void init(), []);
    
    async function init() {
        const estimate = await navigator.storage?.estimate?.();
        if (estimate?.quota && estimate?.usage) {
            setQuota({
                total: estimate.quota / 1024 / 1024,
                usage: estimate.usage / 1024 / 1024,
            })
        }
        else {
            setQuota(null);
        }
        
        const persist = await navigator.storage?.persisted?.();
        setPersist(!!persist);
        
        const worker = await navigator.serviceWorker?.getRegistration();
        setWorker(worker || null);
        
        const geo = await navigator.permissions?.query?.({ name: "geolocation" });
        setGeo(geo?.state === "granted");
    }
    
    useEffect(() => {
        if (worker) {
            worker.addEventListener("statechange", workerEvent);
            setReady(!!worker.active);
        }
        return () => {
            if (worker) {
                worker.removeEventListener("statechange", workerEvent);
            }
        }
    }, [worker]);
    
    function workerEvent() {
        if (worker) {
            setReady(!!worker.active);
        }
    }
    
    return (
        <div>
            <div className="text-message text-bold">
                About your phone
            </div>
            <div>
                Offline Support: {!!navigator.serviceWorker ? "Yes" : "No"}
            </div>
            <div>
                Offline Ready: {ready ? "Yes" : "No"}
            </div>
            <div>
                Currently Offline: {navigator.onLine ? "No" : "Yes"}
            </div>
            <div>
                Has Geolocation: {geo ? "Yes" : "No"}
            </div>
            <div>
                Has Persistent Storage: {persist ? "Yes" : "No (not guaranteed)"}
            </div>
            <div>
                Storage Quota:
                &nbsp;
                {quota
                    ? `${format(quota.usage, 1)}/${format(quota.total, 0)}`
                    : "??/??"
                }
                &nbsp;
                MiB
            </div>
        </div>
    )
}


const formatter = new Intl.NumberFormat();

function format(value: number, precision: number) {
    return formatter.format(+value.toFixed(precision))
}

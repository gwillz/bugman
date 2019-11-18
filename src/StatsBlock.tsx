
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
                Storage Persistent: {persist ? "Yes" : "Not guaranteed"}
            </div>
            <div>
                Storage Quota:
                &nbsp;
                {quota
                    ? `${quota.usage.toFixed(1)}/${quota.total.toFixed(0)}`
                    : "??/??"
                }
                &nbsp;
                MiB
            </div>
        </div>
    )
}

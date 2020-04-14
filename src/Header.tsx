
import { h, JSX, createContext } from 'preact';
import { useContext, useState, useEffect } from 'preact/hooks';
import { Link } from 'react-router-dom';

interface State {
    returnPath?: string;
}

interface ContextStore {
    state: State;
    setState: (state: State) => void;
}

const Context = createContext<ContextStore>({} as ContextStore);

export function HeaderProvider(props: {children: JSX.Element}) {
    const [state, setState] = useState<State>({});
    
    return <Context.Provider value={{state, setState}}>
        {props.children}
    </Context.Provider>
}

export function useHeader() {
    const { state } = useContext(Context);
    return state;
}

export function useBackPath(returnPath: string) {
    const context = useContext(Context);
    
    useEffect(() => {
        if (returnPath) context.setState({ returnPath });
        return () => context.setState({ returnPath: undefined });
    }, [returnPath]);
}

export function Header() {
    
    const {returnPath } = useHeader();
    
    return (
        <header className="header">
            <div>
                {returnPath ? (
                    <Link to={returnPath}
                        className="button">
                        Back
                    </Link>
                ) : (
                    <h1>Field Assistant</h1>
                )}
                <Link to="/">
                    <img
                        src={require('./bugman_logo.svg')}
                        className="logo"
                    />
                </Link>
            </div>
        </header>
    )
}



import { h, JSX } from 'preact';
import { useRef } from 'preact/hooks';
import { useDrop, DropTargetMonitor, useDrag, DragSourceMonitor } from 'react-dnd';
import { ConfigField, TYPES } from './Configuration';
import { css } from './css';

interface DragItem {
    index: number;
    id: string;
    type: string;
}

type Props = {
    index: number;
    field: ConfigField;
    onUpdate: (index: number, field: ConfigField) => void;
    onRemove: (index: number) => void;
    onMove: (from: number, to: number) => void;
}

export function FieldBlock(props: Props) {
    const { index } = props;
    const { name, type } = props.field;
    
    const ref = useRef<HTMLDivElement | null>(null);
    
    const [, onDrop] = useDrop({
        accept: "FIELD",
        hover(item: DragItem, monitor: DropTargetMonitor) {
            if (!ref.current) return;
            if (item.index === index) return;
            
            const boundingBox = ref.current.getBoundingClientRect();
            const offset = monitor.getClientOffset()!;
            const { top, bottom } = boundingBox;
            
            const hoverMiddleY = (bottom - top) / 2
            const hoverClientY = offset.y - top;
            
            // Dragging downwards
            if (item.index < index && hoverClientY < hoverMiddleY) {
                return;
            }

            // Dragging upwards
            if (item.index > index && hoverClientY > hoverMiddleY) {
                return;
            }

            // Move and mutate.
            props.onMove(item.index, index);
            item.index = index;
        },
    })
    
    
    const [{dragging}, onDrag] = useDrag({
        item: { type: "FIELD", index },
        collect: (monitor: DragSourceMonitor) => ({
            dragging: monitor.isDragging(),
        })
    })
    
    onDrag(onDrop(ref));
    
    function onChange(event: JSX.TargetedEvent<HTMLSelectElement | HTMLInputElement>) {
        const { name, value } = event.currentTarget;
        
        props.onUpdate(index, {
            ...props.field,
            [name]: value,
        });
    }
    
    function onRemove() {
        props.onRemove(index);
    }
    
    return (
        <div ref={ref}
            className={css("form-group field-block", { dragging })}>
            <div className="form-field">
                <input
                    type="text"
                    name="name"
                    placeholder="Field Name"
                    value={name}
                    onChange={onChange}
                    required
                />
            </div>
            <div className="form-field">
                <select
                    name="type"
                    value={type}
                    onChange={onChange}>
                    {TYPES.map(type => (
                        <option key={type} value={type}>
                            {type}
                        </option>
                    ))}
                </select>
            </div>
            <button type="button"
                className="button icon"
                onClick={onRemove}>
                X
            </button>
        </div>
    )
}

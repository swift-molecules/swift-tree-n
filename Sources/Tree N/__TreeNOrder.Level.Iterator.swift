public import Buffer_Ring_Primitive
public import Memory
public import Memory_Allocator
public import Storage
public import Buffer
public import Store
public import Iterator

public import Ownership_Shared_Primitive
public import Queue
public import Tree

extension __TreeNOrder.Level {

    public struct Iterator<S: __TreeNStorage>: Iterator::Iterator.`Protocol`
    where S.Element: Copyable {
        @usableFromInline
        let tree: __Tree<S>

        @usableFromInline
        var pending:
            __Queue<
                Ownership.Shared<Store.Generational.Handle, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Store.Generational.Handle>>.Ring>
            >

        @usableFromInline
        init(tree: __Tree<S>) {
            self.tree = tree
            self.pending = __Queue<
                Ownership.Shared<Store.Generational.Handle, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Store.Generational.Handle>>.Ring>
            >()

            if let rootHandle = tree._rootHandle {
                pending.enqueue(rootHandle)
            }
        }

        @inlinable
        public mutating func next() -> S.Element? {
            guard let handle = pending.dequeue() else { return nil }

            let value = tree._value(of: handle)

            for child in tree._childHandles(of: handle) {
                pending.enqueue(child)
            }

            return value
        }
    }
}

public import Tree

public protocol __TreeNStorage: __TreeStorage, ~Copyable where Error == __TreeError {

    static var _arity: Int { get }
}

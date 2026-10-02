import Testing
import Tree_N_Test_Support

@testable import Buffer
@testable import Tree_N

@Suite(.serialized)
struct `Tree Binary Performance Tests` {

    @Test
    func `Insert 10,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree.insert(0, at: .root))

        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        #expect(tree.count == 10_000)
    }

    @Test
    func `Insert 50,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(50_000)

        positions.append(try tree.insert(0, at: .root))

        for i in 1..<50_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        #expect(tree.count == 50_000)
    }

    @Test
    func `Navigate 100,000 positions`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(1_000)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<1_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        var navigationCount = 0
        for _ in 0..<100 {
            for pos in positions {
                _ = tree.left(of: pos)
                _ = tree.right(of: pos)
                _ = tree.parent(of: pos)
                navigationCount += 3
            }
        }

        #expect(navigationCount == 300_000)
    }

    @Test
    func `Pre-order traversal 10,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        var count = 0
        tree.forEach.preOrder { _ in count += 1 }
        #expect(count == 10_000)
    }

    @Test
    func `In-order traversal 10,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        var count = 0
        tree.forEach.inOrder { _ in count += 1 }
        #expect(count == 10_000)
    }

    @Test
    func `Post-order traversal 10,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        var count = 0
        tree.forEach.postOrder { _ in count += 1 }
        #expect(count == 10_000)
    }

    @Test
    func `Level-order traversal 10,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        var count = 0
        tree.forEach.levelOrder { _ in count += 1 }
        #expect(count == 10_000)
    }

    @Test
    func `Remove subtree 5,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        let leftChild = tree.left(of: positions[0])!
        try tree.removeSubtree(at: leftChild)

        #expect(tree.count < 10_000)
    }

    @Test
    func `Clear 10,000 nodes`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        tree.clear()
        #expect(tree.isEmpty)
    }

    @Test
    func `Copy-on-write with 10,000 nodes`() throws {
        var tree1 = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(10_000)

        positions.append(try tree1.insert(0, at: .root))
        for i in 1..<10_000 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree1.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree1.insert(i, at: .right(of: parent)))
            }
        }

        var tree2 = tree1

        let leafPosition = positions.last!

        _ = try tree2.insert(99999, at: .left(of: leafPosition))

        #expect(tree1.count == 10_000)
        #expect(tree2.count == 10_001)
    }

    @Test
    func `Memory layout sizes`() {

        let positionSize = MemoryLayout<__TreePosition>.size
        let treeSize = MemoryLayout<__Tree<TreeStorage.N<Int, 2>>>.size

        #expect(positionSize <= 16)

        #expect(treeSize <= 64)

        print("Position size: \(positionSize) bytes")
        print("Tree handle size: \(treeSize) bytes")
        print("Position stride: \(MemoryLayout<__TreePosition>.stride) bytes")
        print("Tree handle stride: \(MemoryLayout<__Tree<TreeStorage.N<Int, 2>>>.stride) bytes")
    }

    @Test
    func `Token validation 100,000 operations`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(100)

        positions.append(try tree.insert(0, at: .root))
        for i in 1..<100 {
            let parentIndex = (i - 1) / 2
            let parent = positions[parentIndex]
            if i % 2 == 1 {
                positions.append(try tree.insert(i, at: .left(of: parent)))
            } else {
                positions.append(try tree.insert(i, at: .right(of: parent)))
            }
        }

        var sum = 0
        for _ in 0..<1_000 {
            for pos in positions {
                if let value = tree.peek(at: pos) {
                    sum += value
                }
            }
        }

        #expect(sum > 0)
    }

    @Test
    func `Deep tree (1,000 levels left-only)`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()

        var current = try tree.insert(0, at: .root)
        for i in 1..<1_000 {
            current = try tree.insert(i, at: .left(of: current))
        }

        #expect(tree.count == 1_000)

        #expect(tree.height == 999)

        tree.clear()
        #expect(tree.isEmpty)
    }

    @Test
    func `Deep tree (5,000 levels) - height and clear`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()

        var current = try tree.insert(0, at: .root)
        for i in 1..<5_000 {
            current = try tree.insert(i, at: .left(of: current))
        }

        #expect(tree.count == 5_000)

        #expect(tree.height == 4_999)

        tree.clear()
        #expect(tree.isEmpty)
    }
}

@Suite(.serialized)
struct `Tree Binary Stats Tests` {

    static func completeBinaryTree(
        _ nodeCount: Int,
        minimumCapacity: Int? = nil
    ) throws -> (__Tree<TreeStorage.N<Int, 2>>, [__TreePosition]) {
        var tree = minimumCapacity.map { __Tree<TreeStorage.N<Int, 2>>(minimumCapacity: .init(UInt($0))) } ?? __Tree<TreeStorage.N<Int, 2>>()
        var positions: [__TreePosition] = []
        positions.reserveCapacity(nodeCount)
        positions.append(try tree.insert(0, at: .root))
        for i in 1..<nodeCount {
            let parent = positions[(i - 1) / 2]
            positions.append(try tree.insert(i, at: i % 2 == 1 ? .left(of: parent) : .right(of: parent)))
        }
        return (tree, positions)
    }

    @Test(arguments: [(128, nil), (10_000, nil), (10_000, 10_000)] as [(Int, Int?)])
    func `Complete binary tree insert, with and without reserved capacity`(_ nodeCount: Int, _ capacity: Int?) throws {
        let (tree, positions) = try Self.completeBinaryTree(nodeCount, minimumCapacity: capacity)
        #expect(Int(bitPattern: tree.count) == nodeCount)
        #expect(positions.map { tree.peek(at: $0) } == Array(0..<nodeCount))
    }

    @Test
    func `Every traversal order visits each node of a 10,000-node complete binary tree once`() throws {
        let (tree, _) = try Self.completeBinaryTree(10_000)
        var pre: [Int] = []
        var inOrder: [Int] = []
        var post: [Int] = []
        var level: [Int] = []
        tree.forEach.preOrder { pre.append($0) }
        tree.forEach.inOrder { inOrder.append($0) }
        tree.forEach.postOrder { post.append($0) }
        tree.forEach.levelOrder { level.append($0) }
        #expect(level == Array(0..<10_000))
        #expect(pre.first == 0)
        #expect(post.last == 0)
        #expect(pre.sorted() == level)
        #expect(inOrder.sorted() == level)
        #expect(post.sorted() == level)
    }

    @Test
    func `Every traversal order visits a 5,000-deep left chain in chain order`() throws {
        var tree = __Tree<TreeStorage.N<Int, 2>>()
        var current = try tree.insert(0, at: .root)
        for i in 1..<5_000 {
            current = try tree.insert(i, at: .left(of: current))
        }
        var pre: [Int] = []
        var inOrder: [Int] = []
        var post: [Int] = []
        var level: [Int] = []
        tree.forEach.preOrder { pre.append($0) }
        tree.forEach.inOrder { inOrder.append($0) }
        tree.forEach.postOrder { post.append($0) }
        tree.forEach.levelOrder { level.append($0) }
        #expect(pre == Array(0..<5_000))
        #expect(level == Array(0..<5_000))
        #expect(inOrder == Array((0..<5_000).reversed()))
        #expect(post == Array((0..<5_000).reversed()))
    }

    @Test
    func `A copy shares until its first mutation, which leaves the original unchanged`() throws {
        let (tree, positions) = try Self.completeBinaryTree(10_000)
        var copy = tree
        let leaf = positions.last!
        _ = try copy.insert(99_999, at: .left(of: leaf))
        let added = copy.left(of: leaf)!
        _ = try copy.insert(99_998, at: .left(of: added))
        #expect(tree.count == 10_000)
        #expect(copy.count == 10_002)
        #expect(tree.left(of: leaf) == nil)
    }

    @Test
    func `Peeking every position and walking the leftmost path give exact results`() throws {
        let (tree, positions) = try Self.completeBinaryTree(10_000)
        #expect(positions.reduce(0) { $0 + (tree.peek(at: $1) ?? 0) } == (0..<10_000).reduce(0, +))
        var walked: [Int] = []
        var position = tree.root!
        for _ in 0..<10_000 {
            walked.append(tree.peek(at: position)!)
            guard let next = tree.left(of: position) ?? tree.right(of: position) else { break }
            position = next
        }
        #expect(walked == (0..<14).map { (1 << $0) - 1 })
    }
}

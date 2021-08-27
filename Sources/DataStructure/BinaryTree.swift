//
//  BinaryTree.swift
//  
//
//  Created by lzh on 2021/8/27.
//

extension BinaryTree {
    /// 结点
    class Node<Data> {
        /// 数据
        var data: Data
        /// 左指针
        var left: Node?
        /// 右指针
        var right: Node?

        init(_ data: Data) {
            self.data = data
            left = nil
            right = nil
        }
        
        /// 是否是叶子结点
        var isLeaf: Bool {
            left == nil && right == nil
        }
    }
}

/// 二叉树
class BinaryTree<Data> {
    /// 根结点
    var root: Node<Data>?
    
    /// 创建空二叉树
    init() {
        root = nil
    }
    
    /// 使用数组创建二叉树
    /// - Parameter array: 数据数组
    init(_ array: [Data?]) {
        var array = array
        
        // [0, 1, 3, nil, nil, 4, nil, nil, 2, 5, nil, nil, 6, nil, nil]
        //      0
        //    /   \
        //   1     2
        //  / \   / \
        // 3   4 5   6
        func create(with array: inout [Data?]) -> Node<Data>? {
            guard let first = array.first else { return nil }
            array.removeFirst()

            guard let data = first else { return nil }

            let node = Node(data)
            node.left = create(with: &array)
            node.right = create(with: &array)

            return node
        }
        
        root = create(with: &array)
    }
    
    /// 遍历顺序
    enum TraverseOrder {
        case preOrder
        case inOrder
        case postOrder
    }
    
    /// 递归遍历
    /// - Parameters:
    ///   - node: 遍历结点
    ///   - order: 遍历顺序
    ///   - execute: 遍历执行事件
    static func traverse(_ node: Node<Data>?, order: TraverseOrder = .preOrder, execute: (Node<Data>) -> Void) {
        guard let node = node else { return }

        switch order {
        case .preOrder:
            execute(node)
            traverse(node.left, order: order, execute: execute)
            traverse(node.right, order: order, execute: execute)
        case .inOrder:
            traverse(node.left, order: order, execute: execute)
            execute(node)
            traverse(node.right, order: order, execute: execute)
        case .postOrder:
            traverse(node.left, order: order, execute: execute)
            traverse(node.right, order: order, execute: execute)
            execute(node)
        }
    }
    
    /// 层次顺序遍历
    /// - Parameters:
    ///   - node: 遍历结点
    ///   - execute: 遍历执行事件
    static func traverseInLevelOrder(_ node: Node<Data>?, execute: (Node<Data>) -> Void) {
        var queue = [node]
        
        while !queue.isEmpty {
            let first = queue.removeFirst()
            guard let node = first else { continue }
            
            queue.append(node.left)
            queue.append(node.right)
            
            execute(node)
        }
    }
    
    /// 找到子节点的父结点
    /// - Parameters:
    ///   - node: 遍历结点
    ///   - son: 子结点
    /// - Returns: 找到的父结点
    static func parent(_ node: Node<Data>?, son: Node<Data>) -> Node<Data>? {
        guard let node = node else { return nil }
        
        if node.left === son || node.right === son {
            return node
        }
        
        if parent(node.left, son: son) != nil {
            return parent(node.left, son: son)
        } else {
            return parent(node.right, son: son)
        }
    }
    
    /// 二叉树结点个数
    /// - Parameter node: 遍历结点
    /// - Returns: 结点个数
    static func count(_ node: Node<Data>?) -> Int {
        guard let node = node else { return 0 }
        return count(node.left) + count(node.right) + 1
    }
    
    /// 二叉树深度
    /// - Parameter node: 遍历结点
    /// - Returns: 深度
    static func depth(_ node: Node<Data>?) -> Int {
        guard let node = node else { return 0 }
        return depth(node.left) > depth(node.right) ? depth(node.left) + 1 : depth(node.right) + 1
    }
    
    func traverse(order: TraverseOrder = .preOrder, execute: (Node<Data>) -> Void) {
        BinaryTree<Data>.traverse(root, order: order, execute: execute)
    }
    
    func traverseInLevelOrder(execute: (Node<Data>) -> Void) {
        BinaryTree<Data>.traverseInLevelOrder(root, execute: execute)
    }
    
    var count: Int {
        BinaryTree<Data>.count(root)
    }
    
    var depth: Int {
        BinaryTree<Data>.depth(root)
    }
}

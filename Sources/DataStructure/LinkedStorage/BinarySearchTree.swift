//
//  BinarySearchTree.swift
//  
//
//  Created by lzh on 2021/9/9.
//

extension BinarySearchTree {
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
    }
}

/// 二叉搜索树
class BinarySearchTree<Data: Comparable> {
    /// 根结点
    var root: Node<Data>?
    
    /// 创建空二叉搜索树
    init() {
        root = nil
    }
    
    /// 插入新数据
    /// - Parameters:
    ///   - data: 新数据
    ///   - node: 遍历结点
    /// - Returns: 每个结点所在的地址
    static func insert(_ data: Data, _ node: Node<Data>?) -> Node<Data>? {
        // 遍历到空结点时，新建结点并返回新结点地址
        guard let node = node else {
            return Node(data)
        }
        
        // 新数据小于当前结点数据时，向左子树插入
        // 新数据大于当前结点数据时，向右子树插入
        if data < node.data {
            node.left = insert(data, node.left)
        } else if data > node.data {
            node.right = insert(data, node.right)
        }
        
        // 新数据等于当前结点数据时，无需插入直接返回当前结点地址
        return node
    }
    
    /// 查询二叉搜索树中指定数据的地址
    /// - Parameters:
    ///   - data: 指定数据
    ///   - node: 遍历结点
    /// - Returns: 找到的结点地址
    static func firstAddress(of data: Data, _ node: Node<Data>?) -> Node<Data>? {
        guard let node = node else { return nil }
        
        if data < node.data {
            return firstAddress(of: data, node.left)
        } else if data > node.data {
            return firstAddress(of: data, node.right)
        }
        
        return node
    }
    
    /// 二叉搜索树中最小的值
    /// - Parameter node: 遍历结点
    /// - Returns: 找到的最小的值
    static func firstMin(_ node: Node<Data>?) -> Node<Data>? {
        guard let node = node else { return nil }
        
        // 返回最左侧的值，即为最小值
        if node.left == nil {
            return node
        }
        
        return firstMin(node.left)
    }
    
    /// 二叉搜索树中最大的值
    /// - Parameter node: 遍历结点
    /// - Returns: 找到的最大的值
    static func firstMax(_ node: Node<Data>?) -> Node<Data>? {
        guard let node = node else { return nil }
        
        // 返回最右侧的值，即为最大值
        if node.right == nil {
            return node
        }
        
        return firstMax(node.right)
    }
    
    /// 删除二叉搜索树中的指定数据
    /// - Parameters:
    ///   - data: 指定数据
    ///   - node: 遍历结点
    /// - Returns: 删除数据后，每个结点所在的地址
    static func remove(_ data: Data, _ node: Node<Data>?) -> Node<Data>? {
        guard let node = node else { return nil }

        // 指定数据小于当前结点数据时，在左子树中删除
        // 指定数据大于当前结点数据时，在右子树中删除
        if data < node.data {
            node.left = remove(data, node.left)
            return node
        } else if data > node.data {
            node.right = remove(data, node.right)
            return node
        }
        
        // 指定数据等于当前结点数据时，准备删除
        
        // 当前结点没有子结点，直接删除返回空
        // 当前结点没有左子树，跳过当前结点返回右子树以删除当前结点
        if node.left == nil && node.right == nil {
            return nil
        } else if node.left == nil {
            return node.right
        } else if node.right == nil {
            return node.left
        } else {
            // 当前结点同时有左右子树时，先找到右子树中最小的值
            let min = Self.firstMin(node.right)
            // 将当前结点的值替换为右子树的最小值
            node.data = min!.data
            // 再在右子树中删除右子树的最小值
            node.right = remove(min!.data, node.right)
            return node
        }
    }

    func insert(_ data: Data) {
        root = Self.insert(data, root)
    }
    
    func firstAddress(of data: Data) -> Node<Data>? {
        Self.firstAddress(of: data, root)
    }
    
    var firstMin: Node<Data>? {
        Self.firstMin(root)
    }
    
    var firstMax: Node<Data>? {
        Self.firstMax(root)
    }
    
    func remove(_ data: Data) {
        root = Self.remove(data, root)
    }
}

//
//  LinkedStack.swift
//  
//
//  Created by lzh on 2021/9/6.
//

extension LinkedStack {
    /// 结点
    class Node<Data> {
        /// 数据
        var data: Data
        /// 后指针
        var next: Node?
        
        init(_ data: Data) {
            self.data = data
            next = nil
        }
    }
}

/// 链式栈
class LinkedStack<Data> {
    /// 栈顶指针
    var top: Node<Data>?
    
    /// 创建空链式栈
    init() {
        top = nil
    }
    
    /// 入栈
    /// - Parameter data: 新数据
    func push(_ data: Data) {
        let node = Node(data)
        
        node.next = top
        top = node
    }
    
    /// 出栈
    /// - Returns: 栈顶数据
    func pop() -> Data? {
        defer {
            top = top?.next
        }
        
        return top?.data
    }
}

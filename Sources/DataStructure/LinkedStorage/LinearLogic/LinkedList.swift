//
//  LinkedList.swift
//  
//
//  Created by lzh on 2021/8/31.
//

extension LinkedList {
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

/// 链表
class LinkedList<Data: Equatable> {
    /// 头结点
    var first: Node<Data>?
    
    /// 创建空链表
    init() {
        first = nil
    }
    
    /// 使用数组创建链表
    /// - Parameter array: 数据数组
    init(_ array: [Data]) {
        guard let data = array.first else { return }
        first = Node(data)
        
        var current = first
        for data in array.dropFirst() {
            current?.next = Node(data)
            
            current = current?.next
        }
    }
    
    /// 链表结点个数
    var count: Int {
        var count = 0
        
        forEach { _ in
            count += 1
        }
        
        return count
    }
    
    /// 遍历
    /// - Parameter body: 遍历执行事件
    func forEach(_ body: (Node<Data>) -> Void) {
        var current = first
        while current != nil {
            body(current!)
            
            current = current?.next
        }
    }
    
    /// 查寻链表中指定数据的地址
    /// - Parameter data: 指定数据
    /// - Returns: 结点地址
    func firstAddress(of data: Data) -> Node<Data>? {
        firstAddress { node in
            node.data == data
        }
    }
    
    /// 查寻链表中符合条件的第一个地址
    /// - Parameter predicate: 查寻条件
    /// - Returns: 结点地址
    func firstAddress(where predicate: (Node<Data>) -> Bool) -> Node<Data>? {
        var current = first
        while current != nil {
            if predicate(current!) {
                return current!
            }
            
            current = current?.next
        }
        return nil
    }

    /// 定位索引对应的链表地址
    /// - Parameter index: 整型索引
    /// - Returns: 结点地址
    func locate(index: Int) -> Node<Data>? {
        guard index >= 0 else { return nil }
        
        var i = 0
        return firstAddress { node in
            defer {
                i += 1
            }
            return i == index
        }
    }
    
    /// 在索引处插入新值
    /// - Parameters:
    ///   - data: 新数据
    ///   - index: 整型索引
    func insert(_ data: Data, at index: Int) {
        let node = Node(data)
        
        guard let pre = locate(index: index - 1) else {
            if index == 0 {
                node.next = first
                first = node
            }
            return
        }
        
        node.next = pre.next
        pre.next = node
    }
    
    /// 删除在索引处的值
    /// - Parameter index: 整型索引
    func remove(at index: Int) {
        guard let pre = locate(index: index - 1) else {
            if index == 0 {
                first = first?.next
            }
            return
        }
        
        pre.next = pre.next?.next
    }
    
    /// 删除所有数据
    func removeAll() {
        while first?.next != nil {
            first?.next = first?.next?.next
        }
        
        first = nil
    }
}

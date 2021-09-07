//
//  LinkedQueue.swift
//  
//
//  Created by lzh on 2021/9/7.
//

extension LinkedQueue {
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

/// 链式队列
class LinkedQueue<Data> {
    /// 队首指针
    var front: Node<Data>?
    /// 队尾指针
    var rear: Node<Data>?
    
    /// 创建空链式队列
    init() {
        front = nil
        rear = nil
    }
    
    /// 入队
    /// - Parameter data: 新数据
    func enQueue(_ data: Data) {
        if front == nil {
            rear = Node(data)
            front = rear
        } else {
            rear?.next = Node(data)
            rear = rear?.next
        }
    }
    
    /// 出队
    /// - Returns: 队首数据
    func deQueue() -> Data? {
        defer {
            front = front?.next
        }
        
        return front?.data
    }
}

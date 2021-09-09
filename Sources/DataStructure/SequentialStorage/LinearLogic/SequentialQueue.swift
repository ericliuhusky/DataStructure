//
//  SequentialQueue.swift
//  
//
//  Created by lzh on 2021/9/3.
//

/// 顺序队列
struct SequentialQueue<Data> {
    /// 数据数组
    var dataArray: [Data?]
    /// 容量
    var capacity: Int
    /// 队首索引
    var front: Int
    /// 队尾索引
    var rear: Int
    
    /// 创建空顺序队列
    /// - Parameter capacity: 顺序队列的容量
    init(capacity: Int) {
        dataArray = Array(repeating: nil, count: capacity)
        self.capacity = capacity
        front = 0
        rear = 0
    }
    
    /// 入队
    /// - Parameter data: 新数据
    mutating func enQueue(_ data: Data) {
        // 确保队列不满
        guard (rear + 1) % capacity != front else { return }
        
        dataArray[rear] = data
        rear = (rear + 1) % capacity
    }
    
    /// 出队
    /// - Returns: 队首数据
    mutating func deQueue() -> Data? {
        // 确保队列不空
        guard rear != front else { return nil }
        
        defer {
            dataArray[front] = nil
            front = (front + 1) % capacity
        }
        
        return dataArray[front]
    }
}


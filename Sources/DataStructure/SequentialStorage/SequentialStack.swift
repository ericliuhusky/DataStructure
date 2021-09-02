//
//  SequentialStack.swift
//  
//
//  Created by ericliuhusky on 2021/9/2.
//

/// 顺序栈
struct SequentialStack<Data> {
    /// 数据数组
    var dataArray: [Data?]
    /// 容量
    var capacity: Int
    /// 栈顶索引
    var top: Int
    
    /// 创建空顺序栈
    /// - Parameter capacity: 顺序栈的容量
    init(capacity: Int) {
        dataArray = Array(repeating: nil, count: capacity)
        self.capacity = capacity
        top = -1
    }
    
    /// 扩容
    mutating func expandCapacity() {
        dataArray += Array(repeating: nil, count: 100)
        capacity += 100
    }
    
    /// 顺序栈元素个数
    var count: Int {
        top + 1
    }
    
    /// 入栈
    /// - Parameter data: 新数据
    mutating func push(_ data: Data) {
        if count + 1 > capacity {
            expandCapacity()
        }
        
        top += 1
        dataArray[top] = data
    }
    
    /// 出栈
    /// - Returns: 栈顶数据
    mutating func pop() -> Data? {
        guard top != -1 else { return nil }
            
        defer {
            dataArray[top] = nil
            top -= 1
        }
        
        return dataArray[top]
    }
}

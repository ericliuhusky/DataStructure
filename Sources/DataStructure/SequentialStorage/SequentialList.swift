//
//  SequentialList.swift
//  
//
//  Created by ericliuhusky on 2021/9/2.
//

/// 顺序表
struct SequentialList<Data: Equatable> {
    /// 数据数组
    var dataArray: [Data?]
    /// 容量
    var capacity: Int
    /// 最后一个元素的索引
    var last: Int
    
    /// 创建空顺序表
    /// - Parameter capacity: 顺序表的容量
    init(capacity: Int) {
        dataArray = Array(repeating: nil, count: capacity)
        self.capacity = capacity
        last = -1
    }
    
    /// 使用数组创建顺序表
    /// - Parameter array: 数据数组
    init(_ array: [Data]) {
        dataArray = array
        capacity = array.count
        last = array.count - 1
    }
    
    /// 扩容
    mutating func expandCapacity() {
        dataArray += Array(repeating: nil, count: 100)
        capacity += 100
    }
    
    /// 顺序表元素个数
    var count: Int {
        last + 1
    }
    
    /// 遍历
    /// - Parameter body: 遍历执行事件
    func forEach(_ body: (Data) -> Void) {
        for data in dataArray {
            guard let data = data else { continue }
            body(data)
        }
    }
    
    /// 查询顺序表中指定数据的第一个索引
    /// - Parameter data: 指定数据
    /// - Returns: 索引
    func firstIndex(of data: Data) -> Int? {
        firstIndex { item in
            item == data
        }
    }
    
    /// 查询顺序表中符合条件的第一个索引
    /// - Parameter predicate: 查询条件
    /// - Returns: 索引
    func firstIndex(where predicate: (Data) -> Bool) -> Int? {
        for (index, data) in dataArray.enumerated() {
            guard let data = data else { continue }
            if predicate(data) {
                return index
            }
        }
        return nil
    }
    
    /// 在索引处插入新值
    /// - Parameters:
    ///   - data: 新数据
    ///   - index: 整型索引
    mutating func insert(_ data: Data, at index: Int) {
        guard index >= 0 && index <= last + 1 else { return }
        
        // 当元素个数再加一超出容量时，自动扩容
        if count + 1 > capacity {
            expandCapacity()
        }
        
        // 当索引不为最后一个元素的索引加一时，需要前面的元素整体后移空出位置
        if index != last + 1 {
            for i in (index...last).reversed() {
                dataArray[i + 1] = dataArray[i]
            }
        }
        
        dataArray[index] = data
        last += 1
    }
    
    /// 删除在索引处的值
    /// - Parameter index: 整型索引
    mutating func remove(at index: Int) {
        guard index >= 0 && index <= last else { return }
        
        for i in index...last {
            dataArray[i] = dataArray[i + 1]
        }
        
        dataArray[last] = nil
        last -= 1
    }
    
    /// 删除所有数据
    mutating func removeAll() {
        guard last != -1 else { return }
        
        for i in 0...last {
            dataArray[i] = nil
        }
        
        last = -1
    }
}


//
//  HashTable.swift
//  
//
//  Created by lzh on 2021/9/16.
//

/// 哈希表
struct HashTable {
    /// 数据数组
    var dataArray: [Int?]
    /// 容量
    var capacity: Int
    
    /// 创建空哈希表
    /// - Parameter capacity: 哈希表的容量
    init(capacity: Int) {
        dataArray = Array(repeating: nil, count: capacity)
        self.capacity = capacity
    }
    
    /// 哈希函数
    /// - Parameter data: 指定数据
    /// - Returns: 指定数据的哈希值
    func hash(_ data: Int) -> Int {
        data % capacity
    }
    
    /// 指定数据在哈希表中的存储索引
    /// - Parameter data: 指定数据
    /// - Returns: 存储索引
    func index(of data: Int) -> Int? {
        // 理想哈希索引
        let hashIndex = hash(data)
        return hashCollisions(hashIndex, data)
    }
    
    /// 解决哈希冲突
    /// - Parameters:
    ///   - index: 遍历索引
    ///   - data: 指定数据
    /// - Returns: 解决冲突后的索引
    func hashCollisions(_ index: Int, _ data: Int) -> Int? {
        // 可能会重复遍历一部分
        guard index < capacity * 2 else { return nil }

        // 当前位置没有数据，或者当前位置的数据与指定数据相等时，返回索引
        if dataArray[index % capacity] == nil || dataArray[index % capacity] == data {
            return index
        }

        return hashCollisions(index + 1, data)
    }
    
    /// 向哈希表中插入新值
    /// - Parameter data: 新数据
    mutating func insert(_ data: Int) {
        guard let index = index(of: data) else { return }
        dataArray[index] = data
    }
    
    /// 删除哈希表中指定数据
    /// - Parameter data: 指定数据
    mutating func remove(_ data: Int) {
        guard let index = index(of: data) else { return }
        if dataArray[index] == data {
            dataArray[index] = nil
        }
    }
}

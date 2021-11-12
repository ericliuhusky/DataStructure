//
//  MinimumHeap.swift
//  
//
//  Created by lzh on 2021/11/12.
//

struct MinimumHeap<Data: Comparable> {
    var dataArray: [Data?]
    
    var capacity: Int
    
    var last: Int
    
    init(capacity: Int) {
        dataArray = Array(repeating: nil, count: capacity)
        self.capacity = capacity
        last = -1
    }
    
    init(_ array: [Data?]) {
        dataArray = array
        capacity = array.count
        last = array.count - 1
    }
    
    mutating func insert(_ data: Data) {
        var i = last + 1
        dataArray.append(nil)
        while let item = dataArray[i / 2] {
            if item <= data {
                break
            }
            
            dataArray[i] = dataArray[i / 2]
            
            i = i / 2
        }
        
        dataArray[i] = data
    }
}

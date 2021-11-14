//
//  MinimumHeap.swift
//  
//
//  Created by lzh on 2021/11/12.
//

// 堆是一种完全二叉树，只有底层可能不被完全填满，完全二叉树可以使用数组来表示[nil, i, 2i, 2i + 1]

/// 最小堆
struct MinimumHeap<Data: Comparable> {
    /// 用数组来表示最小堆
    var dataArray: [Data?]
    
    /// 使用数组创建最小堆
    /// - Parameter array: 数据数组
    init(_ array: [Data?]) {
        dataArray = array
    }
    
    /// 向最小堆中插入新数据
    /// - Parameter data: 新数据
    mutating func insert(_ data: Data) {
        dataArray.append(nil)
        
        // 最小堆的父结点数据不能大于子结点数据
        // 从末尾开始找新数据应当插入的位置，当新数据小于父结点的数据时，它应该上浮代替父结点的位置
        // 直到新数据大于父结点的数据时停止上浮，将新数据插入到目标位置
        
        var i = dataArray.count - 1
        while let parent = dataArray[i / 2] {
            if data >= parent {
                break
            }
            
            dataArray[i] = parent
            
            i /= 2
        }
        
        dataArray[i] = data
    }
    
    /// 删除最小堆中的最小数据
    /// - Returns: 最小数据
    mutating func removeMin() -> Data? {
        let minItem = dataArray[1]
        guard let lastItem = dataArray.removeLast() else { return nil }
        
        // 删除最小数据，空出来根结点的位置，需要调整堆的结点的位置
        // 使用末尾数据从根结点开始调整位置，当末尾数据大于左右子结点中较小的子结点的数据时，它应该下沉被更小的子结点替代
        // 直到末尾数据小于更小的子结点的数据时停止下沉，将末尾数据插入到目标位置
        
        var i = 1
        while i * 2 < dataArray.count {
            guard let left = dataArray[i * 2] else { continue }
            guard let right = dataArray[i * 2 + 1] else { continue }
            let smallerChild = min(left, right)
            let smallerChildIndex = (smallerChild == left) ? i * 2 : i * 2 + 1
            if lastItem <= smallerChild {
                break
            }
            dataArray[i] = smallerChild
            
            i = smallerChildIndex
        }
        
        dataArray[i] = lastItem
        
        return minItem
    }
}

//var heap = MinimumHeap([nil, 13, 21, 16, 24, 31, 19, 68, 65, 26, 32])
//heap.insert(14)
//print(heap)

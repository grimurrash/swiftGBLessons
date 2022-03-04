//
//  SixHomework.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 04.03.2022.
//

import Foundation

struct Queue<T> {
    private var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }

    public var front: T? {
        return array.first
    }

    public func filter(_ isIncluded: (T) throws -> Bool) throws -> [T] {
        return try array.filter(isIncluded)
    }

    public func map(_ transform: (T) throws -> T) throws -> [T] {
        return try array.map(transform)
    }

    subscript(_ index: Int) -> T? {
        return array[index]
    }
}

//
//  TwoHomework.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 08.02.2022.
//

import Foundation

public func readIntParameter(parameterName: String? = nil, isPositive: Bool = false) -> Int {
    repeat {
        if let parameterName = parameterName {
            print("Введите \(parameterName): ")
        }
        if let stringValidator = readLine(), let intValidator = Int(stringValidator) {
            if isPositive, intValidator < 0 {
                continue
            }
            return intValidator
        } else {
            print("Вы ввели не целое число")
        }
    } while (true)
}

public func isEven(_ number: Int) -> Bool {
    return number % 2 == 0
}

public func isDevidedWithoutRemainderByThree(_ number: Int) -> Bool {
    return number % 3 == 0
}

public func getAnArrayOfNumbersFromOneToHundred() -> [Int] {
    var numbers = [Int]()
    for i in 1...100 {
        numbers.append(i)
    }
    return numbers
}

public func newFibonacciNumber(_ numbers: [Int]) -> Int {
    return numbers[numbers.count - 1] + numbers[numbers.count - 2]
}

public func newFibonacciNumbere(numbers: Int...) -> Int {
    return newFibonacciNumber(numbers)
}

public func generatePrimes(count: Int) -> [Int] {
    var numbers = [Int]()
    var primes = [Int]()

    for number in 2... {
        let sharesNumber = numbers.filter { number % $0 == 0 }
        if sharesNumber.count == 0 {
            primes.append(number)
            if primes.count >= count {
                break
            }
        }
        numbers.append(number)
    }
    return primes
}

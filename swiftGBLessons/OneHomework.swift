//
//  OneHomework.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 08.02.2022.
//

import Foundation

public func readDoubleParameter(parameterName: String? = nil, isPositive: Bool = false) -> Double {
    repeat {
        if let parameterName = parameterName {
            print("Введите \(parameterName): ")
        }
        let stringValidator = readLine()
        if let doubleValidator = Double(stringValidator ?? "") {
            if isPositive, doubleValidator < 0 {
                continue
            }
            return Double(doubleValidator)
        } else {
            print("Вы ввели не число")
        }
    } while (true)
}

// MARK: quadraticEquation
public func quadraticEquation() {
    print("Решение квадратного уравнения!")

    print("Введите коэффициенты для квадратного уравнения (ax^2 + bx + c = 0):")
    let a = readDoubleParameter(parameterName: "a")
    let b = readDoubleParameter(parameterName: "b")
    let c = readDoubleParameter(parameterName: "c")

    let discr = b * b - 4 * a * c

    if discr > 0 {
        let x1 = (-b + sqrt(discr)) / (2 * a)
        let x2 = (-b - sqrt(discr)) / (2 * a)
        print(String(format: "x1 = %.2f; x2 = %.2f", x1, x2))
    } else if discr == 0 {
        let x1 = (-b) / (2 * a)
        print(String(format: "x1 = %.2f", x1))
    } else {
        print("Корней нет!")
    }
}

// MARK: triangle
public func triangle() {
    print("Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.")

    let a = readDoubleParameter(parameterName: "первый катет", isPositive: true)
    let b = readDoubleParameter(parameterName: "второй катет", isPositive: true)

    let c = sqrt(a * a + b * b)
    let P = a + b + c
    let S = (a * b) / 2
    print(String(format: "Гипотенуза = %.2f; Периметр = %.2f; Площадь = %.2f", c, P, S))
}

// MARK: depositAmount
func depositAmount() {
    print("Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.")
    var deposit = readDoubleParameter(parameterName: "сумму вклада в банк", isPositive: true)
    let annualInterest = readDoubleParameter(parameterName: "годовой процент", isPositive: true)
    for _ in 1...5 {
        deposit += (deposit / 100) * annualInterest
    }
    print(String(format: "Сумма вклада через 5 лет = %.2f", deposit))
}

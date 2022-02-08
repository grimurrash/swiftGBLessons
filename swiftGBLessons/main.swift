//
//  main.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 08.02.2022.
//

import Foundation

var isRepeat = true

repeat {
    print("---Меню---")
    print("1. Первое домашнее задание. 1. Решить квадратное уровнение")
    print("2. Первое домашнее задание. 2. Прямоугольный треугольник")
    print("3. Первое домашнее задание. 3. Рассчитать сумму вклада")
    print("4. Выйти из программы")
    print()
    let menuNumber = readDoubleParameter()
    print()
    switch menuNumber {
    case 1:
        quadraticEquation()
    case 2:
        triangle()
    case 3:
        depositAmount()
    case 4:
        isRepeat = false
    default:
        print("Введет неверный номер пункта меню. Попробуйте еще раз!")
    }
    print()
} while isRepeat

//
//  FiveHomework.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 20.02.2022.
//

import Foundation

// MARK: Протокол
protocol CarProtocol {
    var brand: String { get }
    var model: String { get }
    var yearOfIssue: Int { get }

    var engineStatus: CarEngineStatus { get set }
    var windowsStatus: CarWindowStatus { get set }

    mutating func action(_ action: CarAction) throws

    mutating func runEngine()
    mutating func stopEngine()
    mutating func openWindow()
    mutating func closeWindow()
    func loadCargo(cargoVolume: Int) throws
    func uploadCargo(cargoVolume: Int) throws
}

// MARK: Расширение протокола
extension CarProtocol {
    mutating func runEngine() {
        engineStatus = .run
    }

    mutating func stopEngine() {
        engineStatus.stopEngine()
    }

    mutating func openWindow() {
        windowsStatus.openWindow()
    }

    mutating func closeWindow() {
        windowsStatus.openWindow()
    }

    mutating func action(_ action: CarAction) throws {
        switch action {
        case .runEngine:
            runEngine()
        case .stopEngine:
            stopEngine()
        case .openWindow:
            openWindow()
        case .closeWindow:
            closeWindow()
        case .loadCargo(let cargoVolume, _):
            try loadCargo(cargoVolume: cargoVolume)
        case .uploadCargo(let cargoVolume, _):
            try uploadCargo(cargoVolume: cargoVolume)
        }
    }
}

// MARK: Класс SportCar реализующий протокол CarProtocol
final class SportCar: CarProtocol {
    let brand: String

    let model: String

    let yearOfIssue: Int

    private let trunkVolume: Int
    private var trunkFullness = 0 {
        didSet {
            if trunkFullness > oldValue {
                print("Загружено в багажник \(trunkFullness - oldValue); Стало \(trunkFullness) из \( trunkVolume)")
            } else {
                print("Выгружено из багажника \(oldValue - trunkFullness); Осталось \(trunkFullness) из \(trunkVolume)")
            }
        }
    }

    var engineStatus: CarEngineStatus = .run {
        willSet(newStatus) {
            print("Двигатель \(newStatus.rawValue)")
        }
    }

    var windowsStatus: CarWindowStatus = .close {
        willSet(newStatus) {
            print("Окна \(newStatus.rawValue)")
        }
    }

    init(brand: String, model: String, yearOfIssue: Int, trunkVolume: Int) throws {
        guard trunkVolume >= 0 else { throw CarInitError.invalidCargoVolume }
        guard !brand.isEmpty else { throw CarInitError.invalidBrand }
        guard !model.isEmpty else { throw CarInitError.invalidModel }
        guard yearOfIssue > 1700 else { throw CarInitError.invalidYearOfIssue }

        self.brand = brand
        self.model = model
        self.yearOfIssue = yearOfIssue
        self.trunkVolume = trunkVolume
    }

    func loadCargo(cargoVolume: Int) throws {
        guard cargoVolume + self.trunkFullness <= self.trunkVolume
        else { throw CarActionError.invalidLoadCargoVolume}

        self.trunkFullness += cargoVolume
    }

    func uploadCargo(cargoVolume: Int) throws {
        guard self.trunkFullness - cargoVolume >= 0 else { throw CarActionError.invalidUploadCargoVolume }

        self.trunkFullness -= cargoVolume
    }
}

// MARK: Реализация протокола CustomStringConvertible
extension SportCar: CustomStringConvertible {
    var description: String {
        return """
        Фирма: \(brand)
        Модель: \(model)
        Год выпуска: \(yearOfIssue)
        Двигатель: \(engineStatus.rawValue)
        Окна: \(windowsStatus.rawValue)
        Вместимость багажника: \(trunkVolume)
        Заполнено багажника: \(trunkFullness)
        """
    }
}

// MARK: Класс TrunkCar реализующий протокол CarProtocol
final class TrunkCar: CarProtocol {
    var brand: String

    var model: String

    var yearOfIssue: Int

    var engineStatus: CarEngineStatus = .run {
        willSet(newStatus) {
            print("Двигатель \(newStatus.rawValue)")
        }
    }

    var windowsStatus: CarWindowStatus = .close {
        willSet(newStatus) {
            print("Окна \(newStatus.rawValue)")
        }
    }

    private let trailerVolume: Int
    private var trailerFullness = 0 {
        didSet {
            if trailerFullness > oldValue {
                print("Загружено в прицеп \(trailerFullness - oldValue); Стало \(trailerFullness) из \(trailerVolume)")
            } else {
                print("Выгружено из прицепа \(oldValue - trailerFullness); Осталось \(trailerFullness) из \(trailerVolume)")
            }
        }
    }

    func loadCargo(cargoVolume: Int) throws {
        guard cargoVolume + self.trailerFullness <= self.trailerVolume
        else { throw CarActionError.invalidLoadCargoVolume}

        self.trailerFullness += cargoVolume
    }

    func uploadCargo(cargoVolume: Int) throws {
        guard self.trailerFullness - cargoVolume >= 0
        else { throw CarActionError.invalidLoadCargoVolume}

        self.trailerFullness -= cargoVolume
    }

    init(brand: String, model: String, yearOfIssue: Int, trailerVolume: Int = 0) throws {
        guard trailerVolume >= 0 else { throw CarInitError.invalidTrailerVolume }
        guard !brand.isEmpty else { throw CarInitError.invalidBrand }
        guard !model.isEmpty else { throw CarInitError.invalidModel }
        guard yearOfIssue > 1700 else { throw CarInitError.invalidYearOfIssue }

        self.brand = brand
        self.model = model
        self.yearOfIssue = yearOfIssue
        self.trailerVolume = trailerVolume
    }
}

// MARK: Реализация протокола CustomStringConvertible
extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
        Фирма: \(brand)
        Модель: \(model)
        Год выпуска: \(yearOfIssue)
        Двигатель: \(engineStatus.rawValue)
        Окна: \(windowsStatus.rawValue)
        Вместимость прицепа: \(trailerVolume)
        Заполнено прицепа: \(trailerFullness)
        """
    }
}

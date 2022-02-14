//
//  ThreeHomework.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 14.02.2022.
//

import Foundation

public enum CarAction {
    case runningEngine, deservedEngine
    case openWindow, closeWindow
    case loadCargo(UInt)
    case uploadCargo(UInt)
}

public enum CarEngineStatus: String {
    case run = "Запущен"
    case stop = "Заглушен"

    mutating func startEngine() {
        print("Двигатель запущен")
        self = .run
    }

    mutating func stopEngine() {
        print("Двигатель заглушен")
        self = .stop
    }
}

public enum CarWindowStatus: String {
    case open = "Открыто"
    case close = "Закрыто"

    mutating func openWindow() {
        print("Окно открыто")
        self = .open
    }

    mutating func closeWindow() {
        print("Окно закрыто")
        self = .close
    }
}

public enum CarInitError: Error {
    case invalidYearOfIssue
    case invalidBrand
    case invalidModel
    case invalidCargoVolume
}

public enum CarActionError: Error {
    case invalidLoadCargoValume
    case invelidUploadCargoValume
}

public struct SportCar {
    let brand: String
    let model: String
    let yearOfIssue: UInt
    let trunkVolume: UInt
    var engineStatus: CarEngineStatus = .run
    var windowsStatus: CarWindowStatus = .close
    var filledTrunkVolume: UInt = 0

    init(brand: String, model: String, yearOfIssue: UInt, trunkVolume: UInt) throws {
        guard yearOfIssue > 1700 else {
            print("Дата выпуска должна быть больше 1700 года")
            throw CarInitError.invalidYearOfIssue
        }

        guard !brand.isEmpty else {
            print("Бренд не может быть пустым")
            throw CarInitError.invalidBrand
        }

        guard trunkVolume <= 1000 else {
            print("Слишком большой багажник")
            throw CarInitError.invalidCargoVolume
        }

        guard !model.isEmpty else {
            print("Модель не может быть пустым")
            throw CarInitError.invalidModel
        }

        self.brand = brand
        self.model = model
        self.yearOfIssue = yearOfIssue
        self.trunkVolume = trunkVolume
    }

    mutating func action(_ action: CarAction) throws {
        switch action {
        case .runningEngine:
            self.engineStatus.startEngine()
        case .deservedEngine:
            self.engineStatus.stopEngine()
        case .openWindow:
            self.windowsStatus.openWindow()
        case .closeWindow:
            self.windowsStatus.closeWindow()
        case .loadCargo(let cargoVolume):
            guard cargoVolume + self.filledTrunkVolume <= self.trunkVolume else {
                print("Недостаточно места в багажнике")
                throw CarActionError.invalidLoadCargoValume
            }
            self.filledTrunkVolume += cargoVolume
            print("В багажник загружено \(cargoVolume)")
        case .uploadCargo(let cargoVolume):
            guard Int(self.filledTrunkVolume) - Int(cargoVolume) >= 0 else {
                print("В багажнике нет столько груза")
                throw CarActionError.invelidUploadCargoValume
            }
            self.filledTrunkVolume -= cargoVolume
            print("Из багажника выгружено \(cargoVolume)")
        }
    }

    mutating func infoString() -> String {
        return """
        ---Спортивная машина---
        \(brand) \(model)
        Год выпуска: \(yearOfIssue)
        Двигатель: \(engineStatus.rawValue)
        Окна: \(windowsStatus.rawValue)
        Вместимость багажника: \(trunkVolume)
        Заполнено багажника: \(filledTrunkVolume)
        ----------------------------------
        """
    }
}

public struct TrunkCar {
    let brand: String
    let model: String
    let yearOfIssue: UInt
    let trunkVolume: UInt
    var engineStatus: CarEngineStatus = .run
    var windowsStatus: CarWindowStatus = .close
    var filledTrunkVolume: UInt = 0

    init(brand: String, model: String, yearOfIssue: UInt, trunkVolume: UInt) throws {
        guard yearOfIssue > 1700 else {
            print("Дата выпуска должна быть больше 1700 года")
            throw CarInitError.invalidYearOfIssue
        }

        guard !brand.isEmpty else {
            print("Бренд не может быть пустым")
            throw CarInitError.invalidBrand
        }

        guard !model.isEmpty else {
            print("Модель не может быть пустым")
            throw CarInitError.invalidModel
        }

        self.brand = brand
        self.model = model
        self.yearOfIssue = yearOfIssue
        self.trunkVolume = trunkVolume
    }

    mutating func action(_ action: CarAction) throws {
        switch action {
        case .runningEngine:
            self.engineStatus.startEngine()
        case .deservedEngine:
            self.engineStatus.stopEngine()
        case .openWindow:
            self.windowsStatus.openWindow()
        case .closeWindow:
            self.windowsStatus.closeWindow()
        case .loadCargo(let cargoVolume):
            guard cargoVolume + self.filledTrunkVolume <= self.trunkVolume else {
                print("Недостаточно места в кузову")
                throw CarActionError.invalidLoadCargoValume
            }
            self.filledTrunkVolume += cargoVolume
            print("В кузов загружено \(cargoVolume)")
        case .uploadCargo(let cargoVolume):
            guard Int(self.filledTrunkVolume) - Int(cargoVolume) >= 0 else {
                print("В кузове нет столько груза")
                throw CarActionError.invelidUploadCargoValume
            }
            self.filledTrunkVolume -= cargoVolume
            print("Из багажника выгружено \(cargoVolume)")
        }
    }

    mutating func infoString() -> String {
        return """
        ---Грузовик---
        \(brand) \(model)
        Год выпуска: \(yearOfIssue)
        Двигатель: \(engineStatus.rawValue)
        Окна: \(windowsStatus.rawValue)
        Вместимость кузова: \(trunkVolume)
        Заполнено кузова: \(filledTrunkVolume)
        ----------------------------------
        """
    }
}

//
//  FourHomework.swift
//  swiftGBLessons
//
//  Created by Rashit Sabirov on 17.02.2022.
//

import Foundation

public enum CargoLocation {
    case trunk
    case trailer
    case body
}

public enum CarAction {
    case runEngine
    case stopEngine
    case openWindow
    case closeWindow
    case loadCargo(Int, CargoLocation = .trunk)
    case uploadCargo(Int, CargoLocation = .trunk)
}

class CarClass {
    fileprivate let brand: String
    fileprivate let model: String
    fileprivate let yearOfIssue: Int

    // Используем перечисление с прошлого ДЗ
    fileprivate var engineStatus: CarEngineStatus = .run {
        willSet(newStatus) {
            print("Двигатель \(newStatus.rawValue)")
        }
    }
    fileprivate var windowsStatus: CarWindowStatus = .close {
        willSet(newStatus) {
            print("Окна \(newStatus.rawValue)")
        }
    }

    init(brand: String, model: String, yearOfIssue: Int) throws {
        guard !brand.isEmpty else { throw CarInitError.invalidBrand }
        guard !model.isEmpty else { throw CarInitError.invalidModel }
        guard yearOfIssue > 1700 else { throw CarInitError.invalidYearOfIssue }

        self.brand = brand
        self.model = model
        self.yearOfIssue = yearOfIssue
    }

    func action(_ action: CarAction) throws {

    }

    func info() -> String {
        return """
        Фирма: \(brand)
        Модель: \(model)
        Год выпуска: \(yearOfIssue)
        Двигатель: \(engineStatus.rawValue)
        Окна: \(windowsStatus.rawValue)
        """
    }
}

final class SportCarClass: CarClass {
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

    init(brand: String, model: String, yearOfIssue: Int, trunkVolume: Int) throws {
        guard trunkVolume >= 0 else { throw CarInitError.invalidCargoVolume }

        self.trunkVolume = trunkVolume

        try super.init(brand: brand, model: model, yearOfIssue: yearOfIssue)
    }

    override func action(_ action: CarAction) throws {
        switch action {
        case .runEngine:
            self.engineStatus.startEngine()
        case .stopEngine:
            self.engineStatus.stopEngine()
        case .openWindow:
            self.windowsStatus.openWindow()
        case .closeWindow:
            self.windowsStatus.closeWindow()
        case .loadCargo(let cargoVolume, let cargoLocation):
            guard cargoLocation == .trunk else { throw CarActionError.invalidCargoLocation }
            guard cargoVolume + self.trunkFullness <= self.trunkVolume
            else { throw CarActionError.invalidLoadCargoVolume}

            self.trunkFullness += cargoVolume
        case .uploadCargo(let cargoVolume, let cargoLocation):
            guard cargoLocation == .trunk else { throw CarActionError.invalidCargoLocation }
            guard self.trunkFullness - cargoVolume >= 0 else { throw CarActionError.invalidUploadCargoVolume }

            self.trunkFullness -= cargoVolume
        }
    }

    override func info() -> String {
        var info = super.info()
        info += """

        Вместимость багажника: \(self.trunkVolume)
        Заполнено багажника: \(trunkFullness)
        """
        return info
    }
}

final class TrunkCarClass: CarClass {

    private let trailerVolume: Int
    private let bodyVolume: Int

    private var trailerFullness = 0 {
        didSet {
            if trailerFullness > oldValue {
                print("Загружено в прицеп \(trailerFullness - oldValue); Стало \(trailerFullness) из \(trailerVolume)")
            } else {
                print("Выгружено из прицепа \(oldValue - trailerFullness); Осталось \(trailerFullness) из \(trailerVolume)")
            }
        }
    }
    private var bodyFullness = 0 {
        didSet {
            if bodyFullness > oldValue {
                print("Загружено в кузов \(bodyFullness - oldValue); Стало \(bodyFullness) из \(bodyVolume)")
            } else {
                print("Выгружено из кузова \(oldValue - bodyFullness); Осталось \(bodyFullness) из \(bodyVolume)")
            }
        }
    }

    init(brand: String,
         model: String,
         yearOfIssue: Int,
         trailerVolume: Int = 0,
         bodyVolume: Int = 0
    ) throws {
        guard trailerVolume >= 0 else { throw CarInitError.invalidTrailerVolume }
        guard bodyVolume >= 0 else { throw CarInitError.invalidBodyVolume }

        self.trailerVolume = trailerVolume
        self.bodyVolume = bodyVolume

        try super.init(brand: brand, model: model, yearOfIssue: yearOfIssue)
    }

    override func action(_ action: CarAction) throws {
        switch action {
        case .runEngine:
            self.engineStatus.startEngine()
        case .stopEngine:
            self.engineStatus.stopEngine()
        case .openWindow:
            self.windowsStatus.openWindow()
        case .closeWindow:
            self.windowsStatus.closeWindow()
        case .loadCargo(let cargoVolume, let cargoLocation):
            guard cargoLocation != .trunk else { throw CarActionError.invalidCargoLocation }
            switch cargoLocation {
            case .trunk: break
            case .trailer:
                guard cargoVolume + self.trailerFullness <= self.trailerVolume
                else { throw CarActionError.invalidLoadCargoVolume}

                self.trailerFullness += cargoVolume
            case .body:
                guard cargoVolume + self.bodyFullness <= self.bodyVolume
                else { throw CarActionError.invalidLoadCargoVolume}

                self.bodyFullness += cargoVolume
            }
        case .uploadCargo(let cargoVolume, let cargoLocation):
            guard cargoLocation != .trunk else { throw CarActionError.invalidCargoLocation }

            switch cargoLocation {
            case .trunk: break
            case .trailer:
                guard self.trailerFullness - cargoVolume >= 0
                else { throw CarActionError.invalidLoadCargoVolume}

                self.trailerFullness -= cargoVolume
            case .body:
                guard self.bodyFullness - cargoVolume >= 0
                else { throw CarActionError.invalidLoadCargoVolume}

                self.bodyFullness -= cargoVolume
            }
        }
    }

    override func info() -> String {
        var info = super.info()
        info += """

        Вместимость прицепа: \(self.trailerVolume)
        Заполнено прицепа: \(trailerFullness)
        Вместимость кузова: \(self.bodyVolume)
        Заполнено кузова: \(bodyFullness)
        """
        return info
    }
}

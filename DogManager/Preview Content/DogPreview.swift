//
//  Dog preview.swift
//  DogManager
//
//  Created by Felipe Duarte on 11/09/24.
//

import Foundation

extension DogModel {
    static var preview: DogModel {
        DogModel(id: UUID(uuidString: "UUID-AVRIL")!, name: "Avril", age: 10, breed: "Siberian Husky")
    }
}

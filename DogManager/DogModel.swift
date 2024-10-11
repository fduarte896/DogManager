//
//  DogModel.swift
//  DogManager
//
//  Created by Felipe Duarte on 3/09/24.
//

import Foundation

struct DogModel : Identifiable, Codable, Hashable, Equatable {

    let id: UUID
    var name: String
    var age: Int
    var breed: String
    var profilePicture: Data?

    static func == (lhs: DogModel, rhs: DogModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

enum DogName: String, Codable, CaseIterable {
    
    case avril = "Avril"
    case eevee = "Eevee"
    case mac = "Mac"
    
}

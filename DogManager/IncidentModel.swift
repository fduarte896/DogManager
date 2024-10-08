//
//  IncidentModel.swift
//  DogManager
//
//  Created by Felipe Duarte on 6/09/24.
//

import Foundation

enum IncidentType: String, Codable, CaseIterable {
    case vomito = "Vómito"
    case cojera = "Cojera"
    case ocular = "Problema Ocular"
    case tos
    
    case otro = "Otro"
}

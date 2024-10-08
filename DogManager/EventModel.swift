//
//  Model.swift
//  DogManager
//
//  Created by Felipe Duarte on 3/09/24.
//

import Foundation
import Charts

struct EventModel : Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var title : String
    var date : Date
    var description : String?
    var eventType : EventType
    var dog : DogModel
}

enum EventType: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
//    case allEvents = "All events"
    case vetAppointment = "Veterinary"
    case vaccination = "Vaccination"
    case deworming = "Deworming"
    case grooming = "Grooming"
    case feeding = "Feeding"
    case symptom = "Symptom report"
}

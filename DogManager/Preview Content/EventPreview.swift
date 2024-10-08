//
//  EventPreview.swift
//  DogManager
//
//  Created by Felipe Duarte on 25/09/24.
//

import Foundation

extension EventModel {
    static var preview: EventModel {
        EventModel(id: UUID(), title: "Evento de prueba con titulo largo", date: Date(), description: "Este es un evento con una descripció de un tamaño relativamente largo, vamos a ver cómo se ve en la lista.", eventType: .symptom, dog: .init(id: UUID(), name: "Avril", age: 9, breed: "HUSKY", profilePicture: "hola"))
    }
}

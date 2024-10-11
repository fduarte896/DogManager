//
//  ViewModel.swift
//  DogManager
//
//  Created by Felipe Duarte on 3/09/24.
//

import Foundation
import SwiftUI

let urlEventsDocumentFolder = URL.documentsDirectory.appending(path: "MyEvents.json")
let urlDogsDocumentFolder = URL.documentsDirectory.appending(path: "MyDogs.json")

class EventViewModel : ObservableObject {
    
    @Published var selectedDate1: Date?
    @Published var selectedDogName1: String?
    @Published var selectedEventType1: EventType?
    
    @Published var events : [EventModel] = []
    @Published var dogs : [DogModel] = []
    @Published var selectedDate : Date?
    @Published var filteredEvents : [EventModel] = []
    @Published var presentEventSheet = false
     
    var eventsForChart = [String]()
    @Published var yAxisEvents = []
    
    init() {
        let today = Calendar.current.startOfDay(for: Date()) //Cargamos la fecha actual.
        selectedDate = today
        showEvents(for: today)
        addYAxisEvents()
        //Precarga de perros
        
        let avril = DogModel(id: UUID(), name: "Avril", age: 3, breed: "Husky")
        let eevee = DogModel(id: UUID(), name: "Eevee", age: 4, breed: "Border Collie")
        let mac = DogModel(id: UUID(), name: "Mac", age: 3, breed: "Australian Shepherd")

        dogs = [avril, eevee, mac]

    }

    func addYAxisEvents() {
        for event in EventType.allCases {
            yAxisEvents.append(event.rawValue)
        }
//        print(yAxisEvents)

    }
    
    func addDog(name: String, age: Int, breed: String, profilePictureData: Data) {
        let newDog = DogModel(id: UUID(), name: name, age: age, breed: breed, profilePicture: profilePictureData)
        dogs.append(newDog)
        persistDogs(dogsArray: dogs)
    }
    
    func persistDogs(dogsArray: [DogModel]) {
        do{
            let encodedData = try JSONEncoder().encode(dogsArray)
            try encodedData.write(to: urlDogsDocumentFolder, options: .atomic)
        } catch {
            print(error)
        }
    }

    func addEvents(title: String, date: Date, description: String, eventType: EventType, dog: DogModel) {
        let newEvent = EventModel(
            title: title,
            date: date,
            description: description,
            eventType: eventType,
            dog: dog
        )
        events.append(newEvent)
        persistEvents(eventsArray: events)
    }
    

    
    func deleteAllEvents() {
        events.removeAll()
        persistEvents(eventsArray: events)
    }
    
    func filterEvents(for date: Date?, dogName: String?, eventType: EventType?) {
        self.selectedDate1 = date
        self.selectedDogName1 = dogName
        self.selectedEventType1 = eventType

        filteredEvents = events.filter { event in
            let dateMatches = date == nil || Calendar.current.isDate(event.date, inSameDayAs: date!)
            let dogMatches = dogName == nil || event.dog.name == dogName
            let eventTypeMatches = eventType == nil || event.eventType == eventType
            return dateMatches && dogMatches && eventTypeMatches
        }
    }


    
    func persistEvents(eventsArray: [EventModel]) {
        
        do {
            let encodedData = try JSONEncoder().encode(eventsArray)
            try encodedData.write(to: urlEventsDocumentFolder, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    func decodeEvents() -> [EventModel] {
        if FileManager.default.fileExists(atPath: urlEventsDocumentFolder.path) {
            do {
                let data = try Data(contentsOf: urlEventsDocumentFolder)
                let decodedEvents = try JSONDecoder().decode([EventModel].self, from: data)
                print("Events loaded from disk")
                return decodedEvents
            } catch {
                print("Error loading Events data from disk", error)
                return []
            }
        } else {
            return []
        }
    }
    
    func decodeDogs() -> [DogModel] {
        if FileManager.default.fileExists(atPath: urlDogsDocumentFolder.path) {
            do {
                let data = try Data(contentsOf: urlDogsDocumentFolder)
                let decodedDogs = try JSONDecoder().decode([DogModel].self, from: data)
                print("Dogs loaded from disk")
                return decodedDogs
            } catch {
                print ("Error loading Dogs data from disk", error)
                return []
            }

        }
        else {
            return []
        }
    }

    func showDogs() {
        dogs = decodeDogs()
    }
    
    func showEvents(for date: Date? = nil) {
        // Cargamos los eventos desde el archivo
        events = decodeEvents()

        // Llamamos al filtrado usando los parámetros actuales (fecha, perro, tipo de evento)
        filterEvents(for: date, dogName: nil, eventType: nil)
    }
    
    
    
    func updateEventList(for date: Date?) {
        guard let selectedDate = date else {
            filteredEvents = []
            return
        }
        
        filteredEvents = events.filter { event in
            return Calendar.current.isDate(event.date, inSameDayAs: selectedDate)
        }
    }
    
    // Función para contar eventos por tipo para un perro específico. Nos devuelve un diccionario con el evento y el número de veces que sucedió dicho evento.
    
    func eventCountsByType(forDogName dogName: String) -> [EventType: Int] {
        let filteredEvents = events.filter { event in
            event.dog.name == dogName
        }

        let counts = filteredEvents.reduce(into: [EventType: Int]()) { counts, event in
            counts[event.eventType, default: 0] += 1
        }

        return counts
    }


    func updateEvent(_ updatedEvent: EventModel) {
        // Actualizar en 'events' array
        if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
            events[index] = updatedEvent
        }

        // Persistir los cambios
        persistEvents(eventsArray: events)

        // Re-aplicar los filtros actuales
        filterEvents(for: selectedDate1, dogName: selectedDogName1, eventType: selectedEventType1)
    }
}

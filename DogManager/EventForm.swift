//
//  EventForm.swift
//  DogManager
//
//  Created by Felipe Duarte on 25/09/24.
//

import SwiftUI

struct EventForm: View {
    var body: some View {
        
        Form(content: {
            TextField("Title", text: $title)
            Picker("Choose a dog", selection: $selectedDog) {
                ForEach(viewModel.dogs, id: \.id) { dog in
                    Text(dog.name.rawValue).tag(dog as DogModel?)
                }
            }
            DatePicker("Date", selection: $date)
            Picker("Event type", selection: $selectedEvent) {
                ForEach(EventType.allCases, id: \.self){ eventType in
                    Text(eventType.rawValue).tag(eventType as EventType?)
                }
            }
            TextField("Description", text: $description)
                           
            Button("Add event") {
                if let selectedDog = selectedDog, let eventType = selectedEvent {
                    viewModel.addEvents(title: title, date: date, description: description, eventType: eventType, dog: selectedDog)
                    showNewEventForm = false

                    print("Evento agregado: \(title), Perro: \(selectedDog.name.rawValue), Tipo: \(eventType.rawValue)")
                }
            }
        })
        
    }
}

#Preview {
    EventForm()
}

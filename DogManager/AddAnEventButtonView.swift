//
//  AddAnEventView.swift
//  DogManager
//
//  Created by Felipe Duarte on 4/09/24.
//

import SwiftUI
import HorizonCalendar

struct AddAnEventButtonView: View {
    
    let calendar = Calendar.current
    @State var showNewEventForm : Bool = false
    
    @State var title = ""
    @State var date = Date()
    @State var description = ""

    @Binding var selectedDog : DogModel? 
    @Binding var selectedEvent : EventType?
    @Binding var selectedDate: Date?
    
    @ObservedObject var viewModel : EventViewModel
    
    var body: some View {
        Button(action: {

            showNewEventForm = true
            
        }, label: {
            Label("Add an event", systemImage: "plus.circle").font(.title3).foregroundStyle(Color.orange)
        })
        
        
        .sheet(isPresented: $showNewEventForm, onDismiss: {
            showNewEventForm = false
            viewModel.showEvents(for: date)
            selectedDog = .none
            selectedEvent = .none
            title = ""
            description = ""
            viewModel.filteredEvents.removeAll()
            viewModel.showEvents(for: date)
        }, content: {
            Form(content: {
                TextField("Title", text: $title)
                Picker("Choose a dog", selection: $selectedDog) {
                    ForEach(viewModel.dogs, id: \.id) { dog in
                        Text(dog.name).tag(dog as DogModel?)
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

                        print("Evento agregado: \(title), Perro: \(selectedDog.name), Tipo: \(eventType.rawValue)")
                    }
                }
            })
            
        })

    }
}

#Preview {
    ContentView()
}

//
//  EventDetailView.swift
//  DogManager
//
//  Created by Felipe Duarte on 24/09/24.
//

import SwiftUI

struct EventDetailView: View {
    
    @ObservedObject var viewModel: EventViewModel
    @State var event: EventModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form (content: {
            Section {
                TextField("Title", text: $event.title)
            } header: {
                Text("Title")
            }
            
            Section {
                TextField("Description", text: Binding(
                    get: { event.description ?? "" },
                    set: { event.description = $0.isEmpty ? nil : $0 }
                ))
            } header: {
                Text("Description")
            }


            Section {
                DatePicker("Date", selection: $event.date)

                Picker("Choose a dog", selection: $event.dog) {
                    ForEach(viewModel.dogs, id: \.id) { dog in
                        Text(dog.name).tag(dog)
                    }
                }
                Picker("Event type", selection: $event.eventType) {
                    ForEach(EventType.allCases, id: \.self) { eventType in
                        Text(eventType.rawValue).tag(eventType)
                    }
                }
            } header: {
                Text("Other Details")
            }
            
            Button("Update") {
                viewModel.updateEvent(event)
                presentationMode.wrappedValue.dismiss()
            }
        })
        .navigationTitle("Edit Event")
    }
}

#Preview {
    //    EventDetailView(event: .preview)
    ContentView()
}

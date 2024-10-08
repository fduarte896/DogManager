//
//  dogDetailView.swift
//  DogManager
//
//  Created by Felipe Duarte on 3/09/24.
//

import SwiftUI
import Charts

struct dogDetailView: View {
    
    var dog : DogModel
    @ObservedObject var viewModel : EventViewModel
    
    private var eventCounts: [EventType: Int] {
        let counts = viewModel.eventCountsByType(forDogName: dog.name)
        print("Conteo de eventos en la vista: \(counts)")
        return counts
    }

    
    
    var body: some View {
        
        
        
        ScrollView {
            HStack {
                Image(dog.profilePicture)
                    .resizable()
                    .scaledToFit()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 150)
                VStack{
                    Text(dog.name)
                        .bold()
                        .font(.largeTitle)
                    LabeledContent{
                        Text(dog.name)
                    } label: {
                        
                        Text("Name")
                    }
                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    
                    
                    LabeledContent{
                        Text(dog.breed)
                    } label: {
                        
                        Text("Breed")
                        
                    }
                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    
                    LabeledContent{
                        Text(String(dog.age) + " years")
                    } label: {
                        
                        Text("Age")
                        
                    }
                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    
                    
                }
            }

            VStack {
                Text("Eventos de \(dog.name)")
                    .font(.headline)
                
                // Obtener el conteo de eventos por tipo para el perro a través de la creación de un diccionario de eventos:#
                let eventCounts = viewModel.eventCountsByType(forDogName: dog.name)
                
                Chart {
                    ForEach(EventType.allCases, id: \.self) { eventType in
                        let count = eventCounts[eventType] ?? 0
//                        print("Evento: \(eventType.rawValue), Conteo: \(count)")
                        BarMark(
                            x: .value("Tipo de Evento", eventType.rawValue),
                            y: .value("Cantidad", count)
                        )
                        .annotation(position: .top) {
                            Text("\(count)")
                                .font(.caption)
                        }
                    }
                }
                .frame(height: 300)
                .padding()
            }
        }
        .onAppear{
            viewModel.eventCountsByType(forDogName: dog.name)
        }
    }
}

#Preview {
    ContentView()
}

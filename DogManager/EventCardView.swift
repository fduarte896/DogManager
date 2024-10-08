//
//  EventCardView.swift
//  DogManager
//
//  Created by Felipe Duarte on 5/09/24.
//

import SwiftUI

struct EventCardView: View {
    
    var event : EventModel

    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(event.dog.name)
                    .font(.headline)
                Text(event.title)
                    .font(.headline)
//                    .padding(.bottom, 10)
                
                Text(event.eventType.rawValue)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                
                Text(event.description ?? "Event without description")
                
            }
            Spacer()
            VStack{
                Text(event.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.headline)
            }
        }
            .padding()
            .background(getBackgroundColor(for: event.dog))
            .clipShape(RoundedRectangle(cornerRadius: 20), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
    }
    
    func getBackgroundColor(for dog: DogModel) -> Color {
        
        switch dog.name {
        case "Avril":
            return Color.orange.opacity(0.3)
        case "Eevee":
            return Color.blue.opacity(0.3)
        case "Mac":
            return Color.green.opacity(0.3)

        default:
            return Color.red.opacity(0.3)
        }
        
    }
}

#Preview {
    EventCardView(event: .preview)
}

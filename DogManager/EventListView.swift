import SwiftUI
import HorizonCalendar

struct EventListView: View {
    
    @ObservedObject var viewModel: EventViewModel
    @State private var selectedEvent: EventType? = .none
    @State private var selectedDog: DogModel?
    @Binding var selectedDate: Date?
    
    @State var title = ""
    @State var date = Date()
    @State var description = ""
    
    @State private var isPresented = false
    @State private var eventSheet : EventModel?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Events")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                HStack {
                    AddAnEventButtonView(selectedDog: $selectedDog, selectedEvent: $selectedEvent, selectedDate: $selectedDate, viewModel: viewModel)
                    
                    Spacer()
                    
                    Picker("Filter by:", selection: $selectedEvent) {
                        Text("All events").tag(EventType?.none)  // Para mostrar todos los eventos
                        ForEach(EventType.allCases, id: \.self) { event in
                            Text(event.rawValue).tag(Optional(event))
                        }
                    }
                }
                .padding(.horizontal)

                ForEach(viewModel.filteredEvents) { event in
                    
                    Button {
                        eventSheet = event
                    } label: {
                        EventCardView(event: event)
                    }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundStyle(Color.black.opacity(0.8))
                    
                }
                .sheet (item: $eventSheet){ event in
                    EventDetailView(viewModel: viewModel, event: event)
                    
                }
                .onChange(of: selectedDate) { newDate in
                    let dogName = selectedDog?.name
                    viewModel.filterEvents(for: newDate, dogName: dogName, eventType: selectedEvent)
                }
                .onChange(of: selectedDog) { newDog in
                    let dogName = newDog?.name
                    viewModel.filterEvents(for: selectedDate, dogName: dogName, eventType: selectedEvent)
                    print("Cambio de perro a \(newDog?.name ?? "All dogs")")
                    print(viewModel.filteredEvents.count)
                }
                .onChange(of: selectedEvent) { newEventType in
                    let dogName = selectedDog?.name
                    viewModel.filterEvents(for: selectedDate, dogName: dogName, eventType: newEventType)
                }
                
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("Select dog", selection: $selectedDog) {
                        Text("All dogs").tag(DogModel?.none)
                        ForEach(viewModel.dogs, id: \.id) { dog in
                            Text(dog.name).tag(Optional(dog))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

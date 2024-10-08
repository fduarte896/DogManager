import SwiftUI
import HorizonCalendar

struct ContentView: View {

    @StateObject var viewModel = EventViewModel()
    
    var body: some View {
        
        TabView {
            CalendarView(viewModel: viewModel)
                
                .tabItem {
                    Label("My calendar", systemImage: "calendar")
                }

            
            MyDogsView(viewModel: viewModel)
                .tabItem {
                    Label("My Dogs", systemImage: "dog")
                }
//            if let avril = viewModel.dogs.first(where: { $0.name == .avril }) {
//                dogDetailView(dog: avril, viewModel: viewModel)
//                    
//                    .tabItem {
//                        Text("Avril")
//                    }
//            }
//
//            if let eevee = viewModel.dogs.first(where: { $0.name == .eevee }) {
//                dogDetailView(dog: eevee, viewModel: viewModel)
//                    
//                    .tabItem {
//                        Text("Eevee")
//                    }
//            }
//
//            if let mac = viewModel.dogs.first(where: { $0.name == .mac }) {
//                dogDetailView(dog: mac, viewModel: viewModel)
//                    
//                    .tabItem {
//                        Text("Mac")
//                    }
//                
//            }
//            
//            AddDogView()
//                .tabItem {
//                    Text("Add Dog")
//                }
//            
        }
    }
}

#Preview {
    ContentView()
}

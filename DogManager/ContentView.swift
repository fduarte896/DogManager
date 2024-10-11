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
                    Label("My Pets", systemImage: "pawprint")
                }

        }
    }
}

#Preview {
    ContentView()
}

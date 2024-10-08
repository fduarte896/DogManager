import SwiftUI
import HorizonCalendar

struct CalendarView: View {
    @State private var selectedDate: Date?
    @State private var rangeStartDate: Date? = nil
    @State private var rangeEndDate: Date? = nil
    @State private var proxy = CalendarViewProxy()
    
    @ObservedObject var viewModel : EventViewModel
    
    
    var body: some View {
        NavigationStack {
            ScrollView{
                let calendar = Calendar.current
                let today = Date()
                
                let startDate = calendar.date(from: DateComponents(year: 2024, month: 01, day: 01))!
                let endDate = calendar.date(from: DateComponents(year: 2030, month: 12, day: 31))!
                
                CalendarViewRepresentable(
                    calendar: calendar,
                    visibleDateRange: startDate...endDate,
                    monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions()),
                    dataDependency: nil,
                    proxy: proxy)
                    .days { [selectedDate, rangeStartDate, rangeEndDate, today] day in
                        let date = calendar.date(from: day.components)
                        let shape: AnyView
                        let topPoint: AnyView
                        let bottomPoint: AnyView

                        // Punto arriba del número si es el día actual
                        if calendar.isDate(date!, inSameDayAs: today) {
                            topPoint = AnyView(Circle().stroke(Color.orange.opacity(0.8), lineWidth: 3)
//                                .fill(Color.black)
//                                .frame(height: 50)
                                .padding(.bottom, -20)
                            )
                        } else {
                            topPoint = AnyView(EmptyView())
                        }

                        // Verificar si hay eventos para la fecha y mostrar un punto debajo del número
                        if let date = date {
                            let hasEventsForDay = viewModel.events.contains { event in
                                Calendar.current.isDate(event.date, inSameDayAs: date)
                            }

                            if hasEventsForDay {
                                bottomPoint = AnyView(Capsule()
                                    .fill(Color.blue) // Puedes cambiar el color del punto para los días con eventos
                                    .frame(width: 6, height: 6)
                                    .padding(.top, -3)
                                )
                            } else {
                                bottomPoint = AnyView(EmptyView())
                            }
                        } else {
                            bottomPoint = AnyView(EmptyView())
                        }

                        // Rectángulo rojo si la fecha está seleccionada
                        if let selectedDate = selectedDate, calendar.isDate(date!, inSameDayAs: selectedDate) {
                            shape = AnyView(Circle().fill(Color.orange.opacity(0.3)))
                        } else if let rangeStartDate = rangeStartDate,
                                  let rangeEndDate = rangeEndDate,
                                  date! >= rangeStartDate && date! <= rangeEndDate {
                            shape = AnyView(RoundedRectangle(cornerRadius: 12).fill(Color.green.opacity(0.3)))
                        } else {
                            shape = AnyView(EmptyView())
                        }

                        // Combinar los puntos y el número del día
                        return ZStack {
                            topPoint.padding(.top, -22) // Mostrar el punto de arriba si es el día actual
                
                                Text("\(day.day)")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color(UIColor.label))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(shape) // Mostrar el rectángulo si la fecha está seleccionada
                                 // Mostrar el punto debajo si hay eventos
                            bottomPoint.padding(.top, 30)
                        }
                    }
                    .onDaySelection { day in
                        let date = calendar.date(from: day.components)
                        selectedDate = date
                        viewModel.updateEventList(for: date) // Esto debería actualizar la lista de eventos filtrados
                        print("Día seleccionado \(date)")
                        print(viewModel.filteredEvents.count)
                    }
                    .interMonthSpacing(24)
                    .verticalDayMargin(8)
                    .horizontalDayMargin(8)
                    .layoutMargins(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .padding(.horizontal, 16)
                    .frame(height: 350)
                    .navigationTitle("DogManager")
                    .onAppear {
                        if let currentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today)) {
                            proxy.scrollToMonth(containing: currentMonth, scrollPosition: .centered, animated: false)
                        }
                        viewModel.showEvents(for: today)
                    }


                    .padding(.top, 20)
                
                
                EventListView(viewModel: viewModel, selectedDate: $selectedDate).padding(.top, -20)
            }
        }
    }
    
}




#Preview {
    ContentView()
}

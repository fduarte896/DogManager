import HorizonCalendar
import SwiftUI

//Bridges for SwiftUI.
struct DayRangeIndicatorViewRepresentable: UIViewRepresentable {
    let framesOfDaysToHighlight: [CGRect]

    func makeUIView(context: Context) -> DayRangeIndicatorView {
        DayRangeIndicatorView(indicatorColor: UIColor.systemBlue.withAlphaComponent(0.15))
    }

    func updateUIView(_ uiView: DayRangeIndicatorView, context: Context) {
        uiView.framesOfDaysToHighlight = framesOfDaysToHighlight
    }
}

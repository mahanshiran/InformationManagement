
import SwiftUI
import Charts

struct MountPrice: Identifiable {
    var id = UUID()
    var mount: String
    var value: Int
}

struct RuleChart: View {
    @State var activities: [ActivityModel] = []
    @State var data: [MountPrice] = []
    var body: some View {
        VStack(spacing: 5){
            Text("Future activities(in each day)")
                .font(.footnote)

                Chart(data) {
                    LineMark(
                        x: .value("Mount", $0.mount),
                        y: .value("Value", $0.value)
                    )
                    PointMark(
                        x: .value("Mount", $0.mount),
                        y: .value("Value", $0.value)
                    )
                }
                .frame(height: 250)
            
        }
        .onAppear{
            data.removeAll()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"

            activities = ActivityDB().getAll()
            for i in 0...10{
                let date = Date()
                var components = DateComponents()
                components.setValue(i + 2, for: .day)
                let expirationDate = Calendar.current.date(byAdding: components, to: date)
                let final = dateFormatter.string(from: expirationDate!)
                data.append(MountPrice(mount: "\(final)", value: Int(ActivityDB().getTotalInDay(day: i).0)))
            }
           
        }
    }
}

extension Date {
   static var tomorrow:  Date { return Date().dayAfter }
   static var today: Date {return Date()}
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}

////
////  ActivityRow.swift
////  InformationManagement (iOS)
////
////  Created by 𝔲𝔤𝔩𝔶 ♡ on 9/14/22.
////
//
//import SwiftUI
//
//struct ActivityRow: View {
//
//    private let societies = ["Math Lovers", "The ScienceXperiment"]
//    @State private var isFavorite = false
//
//    var body: some View {
//
//            List {
//
//                ForEach (societies, id: \.self) { society in
//
//                    VStack (spacing: 15) {
//
//                        HStack (alignment: .lastTextBaseline) {
//
//                            Text("Activity's name")
//                                .font(.caption)
//                                .bold()
//
//                            Spacer()
//
//
//                            if #available(iOS 15, *) {
//                                Text("\(Date.now.formatted(date: .omitted, time: .shortened))")
//                                    .font(.caption2)
//                            }
//
//                            Button { isFavorite.toggle() } label: {
//
//                                withAnimation {
//
//                                    Image(systemName: isFavorite ? "star.fill" : "star")
//                                        .scaleEffect(isFavorite ? 0.9 : 0.8)
//                                        .foregroundColor(isFavorite ? .yellow : .gray)
//
//                                }
//
//                            }
//
//                        }
//
//                        HStack (alignment: .lastTextBaseline) {
//
//                            VStack (alignment: .leading) {
//
//                                Text("From: \(society)")
//                                Text("Status: [scheduled, ongoing, ended]")
//                                Text("Participants: xxxx paricipants")
//                            }
//                            .font(.caption2)
//                            .foregroundColor(.gray)
//
//                            Spacer()
//
//                            Button {} label: {
//
//                                Text("View")
//                                    .accentColor(.white)
//                                    .font(.caption2)
//
//                            }
//                                .background( RoundedRectangle(cornerRadius: 5).fill(.blue).frame(width: 40, height: 20) )
//
//                        }
//
//                    }
//
//                }
//
//            }
//
//    }
//
//}
//
//struct ActivityRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityRow()
//    }
//}



import SwiftUI

struct ActivityRow: View {
    @State var date : Date = Date()
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    @State var boolFields : [Bool] = Range(0...10).map { _ in
        return false
    }
    let item : ActivityModel

    var body: some View {
        VStack(alignment: .center){
            
            
            VStack(alignment: .leading){
                Text("sid: \(item.sid)")
                Text("title: \(item.title)")
                Text("name: \(item.name)")
                Text("description: \(item.description)")
                Text("status: \(item.status)")
                Text("date: \(item.date)")
                
            }
            
         
        }
        .navigationTitle("Activities")
        .textFieldStyle(.roundedBorder)
        .padding()
    }
    
}

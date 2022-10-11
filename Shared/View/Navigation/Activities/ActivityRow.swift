


import SwiftUI

struct ActivityRow: View {
    @Environment(\.presentationMode) var presentationMode
    let user : UserModel
    let activity : ActivityModel
    var body: some View {
        NavigationLink(destination: Activity(user: user, activity: activity)){
            VStack(alignment: .leading){
                //MARK: Other Fields can be added
                Text(activity.name)
                if(activity.date < Date()){
                    Text("Finished")
                        .font(.footnote)
                        .foregroundColor(Color.orange)
                }
                
            }

        }
    }
    
}

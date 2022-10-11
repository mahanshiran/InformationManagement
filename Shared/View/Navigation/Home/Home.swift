//
//  Home.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI


enum Tab{
    case home, societies,activities, profile, test
}

struct Home: View {
    
    @State private var navigator = "Home"
    @Binding var tab: Tab
    let user: UserModel
    let activityMemberDB = ActivityMemberDB()
    @State var activityMembers : [ActivityMember] = []
    @State var showsSheet: Bool = false
    @State var adminOf : Int = 0
    @State var isSuperAdmin: Bool = false
    @State var seenActivities: [String] = []
    @State var search: String = ""
    @State var moveToSearchView: Bool = false
    @State var notJoinedActivities: [ActivityModel] = []
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .center) {
                NavigationLink("", isActive: $moveToSearchView) {
                    Search(search: $search, searchType: .activity, user: user)
                }
                TextField("Search activity name", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit({
                        if(!search.isEmpty){
                            moveToSearchView.toggle()
                        }
                    })
                    
                    
                
                Divider()
              
                VStack{
                    if(isSuperAdmin){
                        HStack{
                            NavigationLink {
                                UserManagement(user: user)
                            } label: {
                                Contaitner(value: "\(UserDB().getAll().count)", title: "Users", color: .blue)
                            }

                            Spacer()
                            NavigationLink {
                                AllSocieties(user: user)
                            } label: {
                                Contaitner(value: "\(SocietyMemberDB().getAll().count)", title: "Societies", color: .blue)
                            }


                            Spacer()
                            NavigationLink {
                                AllActivities(user: user)
                            } label: {
                                Contaitner(value: "\(ActivityDB().getAll().count)", title: "Activities", color: .blue)
                            }
                            Spacer()
                            NavigationLink {
                                AllComments(user: user, passedUser: nil, activity: nil)
                            } label: {
                                Contaitner(value: "\(PublicationDB().getAll().count)", title: "Comments", color: .blue)
                            }

                        }
                        .padding(.top, 10)
                        Spacer()
                        HStack{
                            Contaitner(value: "\(Array(Set(SocietyDB().getAll().map{ $0.admin})).count)", title: "Society admins", color: .gray)
                            Spacer()
                            Contaitner(value: "\(SocietyMemberDB().getAll().filter{$0.isApproved == false}.count)", title: "Pending societies", color: .gray)
                            Spacer()
                            Contaitner(value: "\(ActivityDB().getAll().filter({$0.date < Date()}).count)", title: "Finished activities", color: .gray)
                            Spacer()
                            Contaitner(value: "\(ActivityDB().getAll().filter({$0.date >= Date()}).count)", title: "Upcoming activities", color: .gray)
                        }
                        .padding(.bottom, 10)
                     
                    }else {
                        HStack{
                            Contaitner(value: "\(SocietyMemberDB().getAllForUser(username: user.id).count)", title: "Joined societies", color: .yellow)
                            Spacer()
                            Contaitner(value: "\(activityMembers.count)", title: "Joined activities", color: .red)
                            Spacer()
                            Contaitner(value: "\(adminOf)", title: "Owned societies", color: .green)
                            Spacer()
                            Contaitner(value: "\(PublicationDB().getAllForUser(userId: user.id).count)", title: "My comments", color: .blue)
                        }
                       
                    }
                    

                   
                }
                .buttonStyle(.plain)
                .frame(width: UIScreen.main.bounds.width / 1.05, height: isSuperAdmin ? (115 * 2) : 115, alignment: .center)
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                
                
                Divider()
                
                if(user.role == "super_admin"){
                    RuleChart()
                }
                
                Spacer()
                
                if(user.role != "super_admin"){
                    if activityMembers.isEmpty { NoFeeds(tab: $tab) } else {
                        
                        ScrollView{
                            ForEach(activityMembers, id:\.id){
                                member in
                                JoinedActivityRow(item: member, user: user)
                            }
                        }

                    }
                }

                
                Spacer()
                
                
                
            }
            .onAppear{
                activityMembers = activityMemberDB.getAllForUser(username: user.id)
                
                adminOf = SocietyDB().getForAdmin(user: user.id).filter { s in
                    s.admin == user.id
                }.count
                
                isSuperAdmin = user.role == "super_admin"
                UserDefaults.standard.register(defaults: ["seenActivities" : []])
                seenActivities = UserDefaults.standard.stringArray(forKey: "seenActivities") ?? []
                
                if(!isSuperAdmin){
                    notJoinedActivities = getNotJoinedActivities(user: user)
                }
                
                
            }
            .navigationTitle(navigator)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { tab = Tab.profile } label: {
                        Image(user.id)
                            .resizable()
                            .background(Color.gray)
                            .frame(width: 35, height: 35, alignment: .center)
                            .clipShape(Circle())
                    }
                    .opacity(user.role == "super_admin" ? 0 :1)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink { NotJoiendActivities(user: user) } label: { Image(systemName: "bell.fill").overlay(Badge(count: (notJoinedActivities.count))) }
                }
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 4){
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(user.status == "blocked" ? Color.red :  Color.green)
                            .offset(y: 1)
                            
                        Text(user.name)
                            .fontWeight(.semibold)
                    }
                    
                }
                


            }
            .navigationBarTitleDisplayMode(.inline)
            
        }
       
        .navigationViewStyle(.stack)
        
    }
    
}



struct Contaitner: View {
    let value: String
    let title: String
    let color: Color
    var body: some View {
        VStack(spacing: 1){
            VStack {
                Text(value)
                    .font(.title.bold())
                    
            }
            .frame(width: UIScreen.main.bounds.size.width / (UIDevice.isIPad ? 12 : 6.5), height: UIScreen.main.bounds.size.width / (UIDevice.isIPad ? 12 : 6.5), alignment: .center)
            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(color).opacity(0.8))
            .padding(.horizontal)
            .padding(.vertical,5)
            
            Text(title)
                .font(.caption2.bold())
                .frame(width: UIScreen.main.bounds.size.width / 6.5)
                .multilineTextAlignment(.center)
            
        }
        
        
    }
}

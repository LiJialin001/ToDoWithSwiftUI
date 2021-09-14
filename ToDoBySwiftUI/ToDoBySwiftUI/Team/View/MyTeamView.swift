//
//  File.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/7/24.
//

import SwiftUI


struct MyTeam: View {
    @EnvironmentObject var teamdatabase: TeamStore
    @EnvironmentObject var databaseMessage: MessageStore
    @State var editMode: EditMode = .inactive
    @State var messagesOpen = false
    @State var calenderOpen = false
    @State var MyJoin = true
    
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }

    var body: some View {
        ZStack{
            NavigationView{
                ZStack{
                    VStack{
                        Spacer()
                        MyTeamViewTop
                        if MyJoin {
                            MyJoinView()
                        }
                        else {
                            MyCrateView()
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack{
                                HStack {
                                    Button(action:{
                                        withAnimation {
                                            messagesOpen.toggle()
                                        }
                                        Haptics.giveHaptic()
                                    }){
                                        ZStack{
                                            Image(systemName: "message")
                                                .font(.title)
                                            if notReadMessage.count != 0 {
                                                Image(systemName: "\(notReadMessage.count).circle.fill")
                                                    .font(.body)
                                                    .foregroundColor(Color.red)
                                                    .background(Color.white)
                                                    .clipShape(Circle())
                                                    .padding(.init(top: -10, leading: 30, bottom: 10, trailing: 1))
                                            }
                                        }
                                    }
                                    .sheet(isPresented: $messagesOpen, onDismiss: {messagesOpen = false}) {MessageView(messagesOpen: $messagesOpen)}
                                    Spacer()
                                    Text(getCNDateYMD(Cdate:Date()))
                                        .font(.headline)
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            calenderOpen.toggle()
                                        }
                                        Haptics.giveHaptic()
                                    }){
                                        Image(systemName: "calendar")
                                            .font(.title)
                                    }
                                    .sheet(isPresented: $calenderOpen, onDismiss: {calenderOpen = false}){
                                        RootView(calenderOpen: $calenderOpen)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    var notReadMessage: [MessageItem] {
        return databaseMessage.Messages.filter{
            !$0.isRead
        }
    }
}





struct MyJoinView: View {
    @ObservedObject var getJoinedTeamManager = GetJoinedTeamManager()
    @EnvironmentObject var databaseTeam: TeamStore
    @State var editMode: EditMode = .inactive
    @State var searchTerm = ""
    @State var messagesOpen = false
    @State var showCancelButton: Bool = false
    @State private var isShowingScanner = false
//    @State var addTeamFormNet: [TeamItem]
    
    var TeamChoose: [TeamItem] {
        if searchTerm.isEmpty {
//            return databaseTeam.Teams
            return databaseTeam.Teams.filter{
                !$0.name.isEmpty
            }
        }
        else{
            return databaseTeam.Teams.filter {
                $0.name.lowercased().contains(searchTerm.lowercased())
            }
        }
    }
    
/*    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
       // more code to come
    }   */
    
    var body: some View {
        ZStack{
                ZStack{
                    VStack{
                    HStack{
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("search", text: $searchTerm, onEditingChanged: {
                                isEditing in
                                self.showCancelButton = true
                            }, onCommit: {
                                print("onCommit")
                            })
                                .foregroundColor(.primary)

                            Button(action: {
                                self.searchTerm = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .opacity(searchTerm == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(20.0)
                     //   .padding(1)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))

                        if showCancelButton  {
                            Button("取消") {
                                UIApplication.shared.endEditing()
                                self.searchTerm = ""
                                self.showCancelButton = false
                            }
                            .padding()
                            .foregroundColor(Color(.systemBlue))
                        }
                        if !showCancelButton{
                            Button(action:{
                                isShowingScanner.toggle()
                            })
                            {
                                Image(systemName: "qrcode.viewfinder")
                                    .font(.title)
                            }
                            .padding(2)
                            Spacer()
                        }
                    }
                        if #available(iOS 15.0, *) {
                            List{
                                ForEach(TeamChoose){ item in
                                    NavigationLink(destination:
                                                    JoinTeamDetailView(DetailItem: item, Item: item)
                                    ){
                                        TeamRowForJoin(item: item)
                                    }
                                }
                                .navigationBarTitle("我加入的")
                            }
                            .onAppear{
                                getJoinedTeamManager.placeOrder()
                                self.databaseTeam.Teams.append(TeamItem(name: getJoinedTeamManager.joinedTeam.result[0].team_name, synopsis: getJoinedTeamManager.joinedTeam.result[0].team_description, isMyTeam: false, theBoss: ""))
                            }
                            .navigationBarTitleDisplayMode(.inline)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    Spacer()
                }
   /*             .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(isShowingScanner: $isShowingScanner, codeTypes: [CIQRCodeDescriptor(coder: NSCoder)], simulatedData: "Paul Hudson\npaul@hackingwithswift.com")
                }   */
        }
        
    }
        
}




struct MyCrateView: View {
    @EnvironmentObject var databaseTeam: TeamStore
    @State var editMode: EditMode = .inactive
    @State var newTeamOpen = false
    @State var messagesOpen = false
    @State var showCancelButton: Bool = false
    @State var searchTerm = ""
    
    var TeamChoose: [TeamItem] {
        if searchTerm.isEmpty {
            return databaseTeam.Teams.filter{
                !$0.name.isEmpty
            }
        }
        else{
            return databaseTeam.Teams.filter {
                $0.name.lowercased().contains(searchTerm.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack{
            if !newTeamOpen {
                 ZStack{
                     VStack{
                    //     Spacer()
                         
                         HStack{
                             HStack {
                                 Image(systemName: "magnifyingglass")
                                 TextField("search", text: $searchTerm, onEditingChanged: {
                                     isEditing in
                                     self.showCancelButton = true
                                 }, onCommit: {
                                     print("onCommit")
                                 })
                                     .foregroundColor(.primary)

                                 Button(action: {
                                     self.searchTerm = ""
                                 }) {
                                     Image(systemName: "xmark.circle.fill")
                                         .opacity(searchTerm == "" ? 0 : 1)
                                 }
                             }
                             .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                             .foregroundColor(.secondary)
                             .background(Color(.secondarySystemBackground))
                             .cornerRadius(20.0)
                         //    .padding(1)
                             .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))

                             if showCancelButton  {
                                 Button("取消") {
                                     UIApplication.shared.endEditing()
                                     self.searchTerm = ""
                                     self.showCancelButton = false
                                 }
                                 .padding()
                                 .foregroundColor(Color(.systemBlue))
                             }
                             
                             if !showCancelButton{
                                 Button(action:{
                                     newTeamOpen.toggle()
                                     
                                 })
                                 {
                                     Image(systemName: "plus")
                                         .font(.title)
                                 }
                                 .padding(2)
                                 Spacer()
                             }
                            }
                         
                         if #available(iOS 15.0, *) {
                             List{
                                 ForEach(TeamChoose){ item in
                                     NavigationLink(destination:
                                                        CrateTeamDetailView(DetailItem: item, Item: item, theNumber: databaseTeam.Teams.firstIndex(of: item)!)
                                     ){
                                         TeamRowForCrate(item: item)
                                     }
                                 }
                                 .navigationBarTitle("我管理的")
                             }                             .navigationBarTitleDisplayMode(.inline)
                         } else {
                             // Fallback on earlier versions
                         }
                     }
                     
                 }
            }
            else{
                AddTeamView(newTeamOpen: $newTeamOpen)
            }
               
            
        }
        
    }
}





//MARK:-MyTeam导航栏

extension MyTeam {
    private var MyTeamViewTop: some View {
        
        VStack(alignment: .center, spacing: 0){
            
            HStack(spacing:60){
                Button(action:{
                    MyJoin = true
                }){
                        Text("我加入的")
                }
                Divider()
                Button(action:{
                    MyJoin = false
                }){
                        Text("我管理的")
                }
            }
            .frame(width: .infinity, height: 40)
        }
    }
}


//struct MyTeam_Previews: PreviewProvider {
//    static var previews: some View {
//        MyTeam()
//            .environmentObject(TeamStore())
//    }
//}


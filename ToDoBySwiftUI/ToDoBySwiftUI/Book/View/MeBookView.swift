//
//  MeBookView.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/7/24.
//

import SwiftUI




struct MeBook: View {
 //   @EnvironmentObject var quickActionSettings: QuickActionSettings
    @EnvironmentObject var databaseBook: BookStore
    @EnvironmentObject var databaseMessage: MessageStore
    @State var editMode: EditMode = .inactive
    @Namespace private var namespace
    @State var searchTerm = ""
    @State var size = "创建顺序"
    @State var messagesOpen = false
    @State var calenderOpen = false
    @State var newBookOpen = false
    @State var isBeginSearch = false
    @State var isSortButton = false
    @State private var showCancelButton: Bool = false
    
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    init() {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.setBackIndicatorImage( UIImage(systemName: "chevron.left")!, transitionMaskImage: UIImage(systemName: "chevron.left")!)
            navBarAppearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
    }

    var body: some View {
        ZStack{
            if !newBookOpen {
                NavigationView{
                    ZStack{
                        VStack{
                            Spacer()
                            
                            
                            //SearchBar
                            HStack{
                                Spacer()
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    TextField("search", text: $searchTerm, onEditingChanged: {
                                        isEditing in
                                        self.showCancelButton = true
                                        isBeginSearch = true
                                    }, onCommit: {
                                        print("onCommit")
                                    }).foregroundColor(.primary)

                                    Button(action: {
                                        self.searchTerm = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .opacity(searchTerm == "" ? 0 : 1)
                                    }
                                }
                                .padding(EdgeInsets(top: 6, leading: 10, bottom: 10, trailing: 5))
                                .foregroundColor(.secondary)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(20.0)
                                .padding(3)

                                if showCancelButton  {
                                    Button("取消") {
                                        UIApplication.shared.endEditing()
                                        self.searchTerm = ""
                                        self.showCancelButton = false
                                        isBeginSearch = false
                                    }
                                    .padding()
                                    .foregroundColor(Color(.systemBlue))
                                }
                                if !isBeginSearch {
                                    Menu(content: {
                                        Button(action: {
                                            size = "创建顺序"
                                            isSortButton = false
                                        }, label: {
                                            Text("按创建顺序排序")
                                        })
                                        Button(action: {
                                            size = "修改顺序"
                                            isSortButton = true
                                        }, label: {
                                            Text("按最近修改排序")
                                        })
                                   }){
                                        Label(title: {}) {
                                                Text(size)
                                        }
                                      }
                                   .padding(3)
                                }
                                Spacer()
                            }
                            
                            if #available(iOS 15.0, *) {
                                List{
                                    if isSortButton{
                                        ForEach(searchResults.sorted(by: { (lhs, rhs) -> Bool in
                                            lhs.eidtDate > rhs.eidtDate
                                        })){ item in
                                            NavigationLink(destination:
                                                            BookDetailView(DetailItem: item, mainText: item.substance, BeforeText: item.substance, AfterText: item.substance ,Item: item)
                                            ){
                                                BookItemRow(item: item)
                                                    .environment(\.editMode, self.$editMode)
                                            }
                                        }
                                        .onDelete { (indices) in
                                            self.databaseBook.Books.remove(at: indices.first!)
                                        }
                                    }
                                    else{
                                        ForEach(searchResults){ item in
                                            NavigationLink(destination:
                                                            BookDetailView(DetailItem: item, mainText: item.substance, BeforeText: item.substance, AfterText: item.substance ,Item: item)
                                            ){
                                                BookItemRow(item: item)
                                                    .environment(\.editMode, self.$editMode)
                                            }
                                        }
                                        .onDelete { (indices) in
                                            self.databaseBook.Books.remove(at: indices.first!)
                                        }
                                    }
                                    
                                }
                                .listStyle(DefaultListStyle())
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .principal) {
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
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                        
                        // 加号按钮
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    withAnimation (.easeInOut(duration: 0.6)){
                                        newBookOpen.toggle()
                                    }
                                })
                                {
                                    if #available(iOS 15.0, *) {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(Color.indigo)
                                            .shadow(color: .indigo.opacity(0.3), radius: 10, x: 0, y: 10)
                                            .background(.white)
                                            .clipShape(Circle())
                                            .padding(20)
                                           
                                    } else {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(Color.blue)
                                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 10)
                                            .background(.white)
                                            .clipShape(Circle())
                                            .padding()
                                    }

                                }
                            }
                            .matchedGeometryEffect(id: "button2", in: namespace)
                        }
                    }
                }
            }
            else{
                AddBookView(namespace: namespace, newBookOpen: $newBookOpen)
            }
        }
    }
    
    var notReadMessage: [MessageItem] {
        return databaseMessage.Messages.filter{
            !$0.isRead
        }
    }
    
    var searchResults: [BookItem] {
        if searchTerm.isEmpty {
            return databaseBook.Books.filter{
                !$0.title.isEmpty
            }
        }
        else {
            return databaseBook.Books.filter {
                $0.title.lowercased().contains(searchTerm.lowercased())
            }
        }
    }
    
    
}



//struct MeBook_Previews: PreviewProvider {
//    static var previews: some View {
//        MeBook()
//            .environmentObject(BookStore())
//    }
//}


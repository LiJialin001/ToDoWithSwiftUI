//
//  BookDetailView.swift
//  BookDetailView
//
//  Created by 李佳林 on 2021/8/18.
//

import Foundation
import SwiftUI
import Combine


struct BookDetailView: View{
    @EnvironmentObject var databaseBook: BookStore
    @Environment(\.presentationMode) var presentation
    @State var DetailItem: BookItem
    @State var showImagePicker = false
    @State var showAlert = false
    @State var mainText: String
    @State var BeforeText: String
    @State var AfterText: String
    var Item: BookItem
    let mainTextLimit = 200
    
    
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    func dataToImage(imageDate: Data?) -> UIImage {
        let uiimage: UIImage = UIImage.init(data: imageDate!)!
        return uiimage
    }
    func imageToBase64(image: UIImage) -> String {
        let imageData: Data? = image.jpegData(compressionQuality: 1.0)
        let str: String = imageData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        return str
    }
    func base64ToData(textImage: String) -> Data {
        let data: Data = Data(base64Encoded: textImage, options: .ignoreUnknownCharacters)!
        return data
    }
    
    var body: some View{
        ZStack{
            VStack{
//                HStack{
//                    Spacer()
//                    Button(action:{
//                        showAlert.toggle()
//                        Haptics.simpleSuccess()
//                        UIApplication.shared.endEditing()
//                        AfterText = mainText
//                        DetailItem.substance = mainText
//                        DetailItem.eidtDate = Date()
//                        self.databaseBook.Books[self.databaseBook.Books.firstIndex(of: self.Item)! ] = DetailItem
//                    }){
//                        Image(systemName: "checkmark")
//                            .font(.title)
//                    }
//                    .padding()
//                }
                ScrollView{
                    VStack(alignment: .leading){
                        TextField("主题", text: $DetailItem.title)
                            .font(.title)
                            .padding(.leading, 10)
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 0){
                            Text("\(getCNDateYMD(Cdate: DetailItem.eidtDate)) \(DetailItem.eidtDate, style: Text.DateStyle.time)")
                                .foregroundColor(Color.gray)
                                .font(.body)
                                .padding(.leading, 25)
                                .padding(2)
                            if Item.isTeams {
                                Text("来自：\(Item.Team!.name)")
                                    .foregroundColor(Color.gray)
                                    .font(.body)
                                    .padding(.leading, 25)
                                    .padding(2)
                            }
                        }
                        
                        
                        
                        ZStack(alignment: .leading) {
                            if mainText.isEmpty {
                                VStack(alignment: .leading) {
                                    Text("输入备忘录内容")
                                        .font(Font.body)
                                        .foregroundColor(Color.gray)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 4)
                                .zIndex(0)
                            }
                            TextEditor(text: $mainText)
                                .frame(height: 200, alignment: .leading)
                                .frame(maxWidth: .infinity)
                                .lineSpacing(5)
                                .onReceive(Just(mainText)) { mainText in
                                    textChanged(upper: mainTextLimit, text: &self.mainText)
                                }
                                .zIndex(1)
                                .opacity(mainText.isEmpty ? 0.25 : 1)
                        }
                        .frame(height: 200, alignment: .leading)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 30)
                        
              /*          HStack{
                            NavigationLink(destination:
                                 PhotoView(image: dataToImage(imageDate: base64ToData(textImage: DetailItem.textImages[0])))
                            ){
                                dataToImage(imageDate: base64ToData(textImage: DetailItem.textImages[0]))
                                //    .resizable()
                                //    .scaledToFit()
                                //    .frame(width: 150, height: 150)
                            }
                        }
                        */
                        
                        Spacer()
                    }
                }
                HStack(spacing:80){
                    Button(action:{
                        self.showImagePicker.toggle()
                    }){
                        HStack{
                            Image(systemName: "photo")
                            Text("添加图片")
                        }
                    }
                    .padding()
                    Button(action:{}){
                        HStack{
                            Image(systemName: "paperclip.badge.ellipsis")
                            Text("添加附件")
                        }
                    }
                    .padding()
                }
            }
            .alertDialog(show: $showAlert,duration: 1){
                AlertToast(type: .complete(Color.green), title: "已更改")
            }
     /*       .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    self.image = Image(uiImage: image)
                }
            } */
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack{
                    Text("备忘录")
                        .font(.body)
                        .foregroundColor(.blue)
                        .padding(1)
                    Spacer()
                    Button(action:{
                        showAlert.toggle()
                        Haptics.simpleSuccess()
                        UIApplication.shared.endEditing()
                        AfterText = mainText
                        DetailItem.substance = mainText
                        DetailItem.eidtDate = Date()
                        self.databaseBook.Books[self.databaseBook.Books.firstIndex(of: self.Item)! ] = DetailItem
                    }){
                    Image(systemName: "checkmark")
                       .font(.title2)
                    }
                    .padding()
                }
            }
        }
//        .navigationBarItems(leading:
//         HStack{
//            Spacer()
//                Button(action:{}){
//                    Image(systemName: "checkmark")
//                    .font(.title2)
//                }
//        }
//        )
    }
    func textChanged(upper: Int, text: inout String) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
}

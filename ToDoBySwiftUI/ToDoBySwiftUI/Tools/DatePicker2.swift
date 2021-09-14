//
//  TimePicker.swift
//  TimePicker
//
//  Created by 李佳林 on 2021/8/6.
//

import SwiftUI

struct DatePicker2: UIViewRepresentable {
    @Binding var date: Date
 
    private let datePicker = UIDatePicker()
 
    func makeUIView(context: Context) -> UIDatePicker {
      
        let loc = Locale(identifier: "zh")
        datePicker.locale = loc
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
        return datePicker
    }
 
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        datePicker.date = date
    }
 
    func makeCoordinator() -> DatePicker2.Coordinator {
        Coordinator(date: $date)
    }
 
    class Coordinator: NSObject {
        private let date: Binding<Date>
 
        init(date: Binding<Date>) {
            self.date = date
        }
 
        @objc func changed(_ sender: UIDatePicker) {
            self.date.wrappedValue = sender.date
        }
    }
}
 
 
struct DatePicker2_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker2(date: .constant(Date()))
    }
}
 

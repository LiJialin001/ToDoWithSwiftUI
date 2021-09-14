//
//  CalenderView.swift
//  CalenderView
//
//  Created by 李佳林 on 2021/8/31.
//

import Foundation
import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        return formatter
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}


struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
                .padding(2)
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    @EnvironmentObject var database: ToDoStore

    let month: Date
    let content: (Date) -> DateView

    init(month: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.month = month
        self.content = content
    }
    
    func isInMonth(date: Date, month: Date) -> Bool {
        let theMonth = Calendar.current.component(.month, from: month)
        let dateMonth = Calendar.current.component(.month, from: date)
        if theMonth == dateMonth {
            return true
        }else {
            return false
        }
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: 1)
        )
    }

    private var header: some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        return
            HStack{
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
                Text("本月共\(database.ToDos.filter{isInMonth(date: $0.date, month: month)}.count)个待办")
                    .font(.body)
                    .padding()
                Spacer()
            }
    }
    
    private var weekdays: some View {
        return
          HStack(spacing: 12){
              Text("30")
                  .hidden()
                  .padding(8)
                  .padding(.vertical, 4)
                  .overlay(
                      Text("日")
                  )
                Text("30")
                    .hidden()
                    .padding(8)
                    .padding(.vertical, 4)
                    .overlay(
                        Text("一")
                    )
                Text("30")
                    .hidden()
                    .padding(8)
                    .padding(.vertical, 4)
                    .overlay(
                        Text("二")
                    )
                Text("30")
                    .hidden()
                    .padding(8)
                    .padding(.vertical, 4)
                    .overlay(
                        Text("三")
                    )
                Text("30")
                    .hidden()
                    .padding(8)
                    .padding(.vertical, 4)
                    .overlay(
                        Text("四")
                    )
                Text("30")
                    .hidden()
                    .padding(8)
                    .padding(.vertical, 4)
                    .overlay(
                        Text("五")
                    )
                Text("30")
                    .hidden()
                    .padding(8)
                    .padding(.vertical, 4)
                    .overlay(
                        Text("六")
                            .bold()
                    )
            }
    }

    var body: some View {
        VStack{
            header
            weekdays
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}


struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        VStack{
            TabView{
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, content: self.content)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            Spacer()
        }
    }
}

struct RootView: View {
    @Environment(\.calendar) var calendar
    @EnvironmentObject var database: ToDoStore
    @Binding var calenderOpen: Bool
    @State var ToDoDaysViewOpen = false
    @State var theDate = Date()
    var year = DateInterval(start: Date(), end:Calendar.current.date(byAdding: .year, value: 1, to: Date())!)

    var body: some View {
        NavigationView{
            VStack(spacing:0){
                CalendarView(interval: year) { date in
                    if Calendar.current.isDate(date, inSameDayAs: Date()) {
                        VStack(spacing:0) {
                            Text("30")
                                .hidden()
                                .padding(7)
                                .background(Color.cyan)
                                .clipShape(Circle())
                                .padding(.vertical, 4)
                                .overlay(
                                    Text(String(self.calendar.component(.day, from: date)))
                                )
                                .onTapGesture {
                                    theDate = date
                                    ToDoDaysViewOpen.toggle()
                                }
                        }
                        
                    }else if (date > Date()) && !(database.ToDos.filter{Calendar.current.isDate($0.date, inSameDayAs: date)}.isEmpty) {
                        VStack(spacing:0){
                            Text("30")
                                .hidden()
                                .padding(7)
                                .padding(.vertical, 4)
                                .overlay(
                                    Text(String(self.calendar.component(.day, from: date)))
                                )
                                .onTapGesture {
                                    theDate = date
                                    ToDoDaysViewOpen.toggle()
                                }
                            Image(systemName: "circle.fill")
                                .font(.system(size:4))
                                .foregroundColor(Color.red)
                        }
                    }
                    else if (date > Date()) && (database.ToDos.filter{Calendar.current.isDate($0.date, inSameDayAs: date)}.isEmpty) {
                        VStack(spacing:0){
                            Text("30")
                                .hidden()
                                .padding(7)
                                .padding(.vertical, 4)
                                .overlay(
                                    Text(String(self.calendar.component(.day, from: date)))
                                )
                                .onTapGesture {
                                    theDate = date
                                    ToDoDaysViewOpen.toggle()
                                }
                            Image(systemName: "circle.fill")
                                .font(.system(size:4))
                                .foregroundColor(Color.clear)
                        }
                    }
                    else{
                        VStack(spacing:0){
                            Text("30")
                                .hidden()
                                .padding(8)
                                .padding(.vertical, 4)
                                .overlay(
                                    Text(String(self.calendar.component(.day, from: date)))
                                )
                            Image(systemName: "circle.fill")
                                .font(.system(size:4))
                                .foregroundColor(Color.clear)
                        }
                    }
                }
                .navigationBarTitle("DDL日历",displayMode: .inline)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $ToDoDaysViewOpen, onDismiss: {ToDoDaysViewOpen = false}){ToDoDaysView(theDate: $theDate)}
        }
    }
}


//MARK: - Have ToDos Days
struct ToDoDaysView: View {
    @EnvironmentObject var database: ToDoStore
    @Binding var theDate: Date
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    if Calendar.current.isDate(theDate, inSameDayAs: Date()) {
                        Text("今天是\(getCNDateYMD(Cdate: theDate))")
                            .font(.body)
                            .padding()
                    }else {
                        Text("\(getCNDateYMD(Cdate: theDate))")
                            .font(.body)
                            .padding()
                    }
                    
                    Spacer()
                }
                if database.ToDos.filter{Calendar.current.isDate($0.date, inSameDayAs: theDate)}.isEmpty {
                    VStack{
                        if Calendar.current.isDate(theDate, inSameDayAs: Date()) {
                            Text("今天没有DDL！！！")
                                .font(.title)
                                .bold()
                                .padding()
                        }else {
                            Text("暂时没有DDL！！！")
                                .font(.title)
                                .bold()
                                .padding()
                        }
                    }
                }else {
                    List{
                        ForEach(database.ToDos.filter{Calendar.current.isDate($0.date, inSameDayAs: theDate)}) { item in
                            ToDoItemRowForCrate(item: item)
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//
//  Calendar.swift
//  TrainingCalendar
//
//  Created by Jeff Cournoyer on 3/29/22.
//



import SwiftUI


// Testing Out markUp Languages
/**
  *Returns a Calendar*
  - important: This is
    a way to get the
    readers attention for
    something.

  - parameters:
     - parameter: monthStartIndex: Int
    
  - returns: A Calendar
 
  *Another description field*
  - version: 1.0
 */


struct CalendarView: View {
    
    var days: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 10, maximum: 100), spacing: 3), count: 7)
    @Binding var selectedIndex: String
    
    var monthStartIndex: Int?
    
    var exampleDays: [[Int]]?
    
    var body: some View {
        let weekdayNames = ["Su", "M", "T", "W", "R", "F", "Sa"]
        let monthsToView = 6
        
        VStack {
            // Current screen top. Most likely will take out when this part goes onto GitHub, to make things more customizable.
            ZStack {
                Color.teal
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 50)
                
                Text(selectedIndex)
            }
            
            //Implemented to allow the screen to scroll to the current month, regardless of the start month
            ScrollViewReader { reader in
                ScrollView {
                    
                    ForEach(((monthStartIndex ?? 0)..<monthsToView), id: \.self) { monthOffset in
                        
                        let weekdayPreGridOffset = calculateDayOffset(monthOffset: monthOffset)
                        let numberOfDaysInMonth = calculateDaysInDesiredMonth(monthOffset: monthOffset)
                        let monthPlusPreOffset = numberOfDaysInMonth + weekdayPreGridOffset
                        #warning("Simpler Way to calculate the appropriate amount of cells considering the month? (See Below)")
                        let postOffset : Int = (monthPlusPreOffset) / 7
                        let lazyGridTotal = (postOffset + 1) * 7
                        
                        VStack(alignment: .leading) {
                            
                            Text(getMonthName(monthOffset: monthOffset))
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding([.horizontal, .top])
                                .id(monthOffset)
                            
                            LazyVGrid(columns: days) {
                                ForEach(weekdayNames, id: \.self) { day in
                                    HStack {
                                        Text(day)
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .padding(.leading, 3)
                                        
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            LazyVGrid(columns: days, spacing: 3) {
                                ForEach((1...lazyGridTotal), id: \.self) { num in
                                    ZStack {
                                        determineDayColor(monthOffset: monthOffset, dayNumber: num, preGridOffset: weekdayPreGridOffset, daysInMonth: numberOfDaysInMonth, postGridOffset: postOffset)
                                            
                                        
                                        let isPastDay = determineIfDayIsInPast(monthOffset: monthOffset, num: num, weekdayPreGridOffset: weekdayPreGridOffset)
                                        
                                        if isPastDay {
                                            Color(UIColor.systemGray6).opacity(0.85)
                                        }
                                        
                                        VStack {
                                            Text((num >= weekdayPreGridOffset && num < numberOfDaysInMonth + weekdayPreGridOffset) ? "\(num - weekdayPreGridOffset + 1)" : "")
                                                .padding([.trailing, .bottom])
                                                .padding(.top, 10)
                                                .font(.caption)
                                            
                                            Spacer()
                                        }
                                        
                                       
                                    }
                                    .overlay {
                                        let isToday = determineIfToday(monthOffset: monthOffset, num: num, weekdatPreGridOffset: weekdayPreGridOffset)
                                        
                                        if isToday {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.yellow, lineWidth: 3)
                                        }
                                    }
                                    .cornerRadius(10)
                                    
                                    .onTapGesture {
                                        let selection = num - weekdayPreGridOffset + 1
                                        
                                        if (1...numberOfDaysInMonth).contains(selection) {
                                            selectedIndex = "\(getMonthName(monthOffset: monthOffset)) \(selection)"
                                        } else {
                                            selectedIndex = ""
                                        }
                                        
                                    }
                                }
                            }
                            .padding([.horizontal, .bottom])
                        }
                    }
                }
                .onAppear {
                    reader.scrollTo(0, anchor: .top)
                }
            }
        }
    }
    
    
    func calculateDayOffset(monthOffset: Int) -> Int {
        
        let desiredMonth = Calendar.current.component(.month, from: Calendar.current.date(byAdding: .month, value: monthOffset, to: Date())!)
        let desiredYear = Calendar.current.component(.year, from: Calendar.current.date(byAdding: .month, value: monthOffset, to: Date())!)
        
        let firstOfTheMonth = Calendar.current.date(from: DateComponents(year: desiredYear, month: desiredMonth, day: 1))!
        let weekDayOfFirst = Calendar.current.component(.weekday, from: firstOfTheMonth)
        
        return weekDayOfFirst
    }
    
    func calculateDaysInDesiredMonth(monthOffset: Int) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: Calendar.current.date(byAdding: .month, value: monthOffset, to: Date())!)!.count
    }
    
    func getMonthName(monthOffset: Int) -> String {
        
        let month = Calendar.current.component(.month, from:  Calendar.current.date(byAdding: .month, value: monthOffset, to: Date())!)
        
        return Calendar.current.monthSymbols[month - 1]
        
    }
    
    func determineDayColor(monthOffset: Int, dayNumber: Int, preGridOffset: Int, daysInMonth: Int, postGridOffset: Int) -> Color {
        if let exampleDays = exampleDays {
            if dayNumber >= preGridOffset && dayNumber < daysInMonth + preGridOffset {
                if exampleDays[0].contains(dayNumber - preGridOffset + 1) {
                    return Color.green
                } else if exampleDays[1].contains(dayNumber - preGridOffset + 1) {
                    return Color.blue
                } else if exampleDays[2].contains(dayNumber - preGridOffset + 1) {
                    return Color.mint
                } else {
                    return Color(UIColor.systemGray4)
                }
            } else {
                return Color(UIColor.systemGray6)
            }
        } else {
            return Color(UIColor.systemGray6)
        }
    }
    
    func determineIfDayIsInPast(monthOffset: Int, num: Int, weekdayPreGridOffset: Int) -> Bool {
        if monthOffset < 0 || (monthOffset == 0 && num < (Calendar.current.component(.day, from: Date()) + weekdayPreGridOffset - 1)) {
            return true
        } else {
            return false
        }
    }
    
    func determineIfToday(monthOffset: Int, num: Int, weekdatPreGridOffset: Int) -> Bool {
        let day = Calendar.current.component(.day, from: Date()) + weekdatPreGridOffset - 1
        
        if monthOffset == 0 {
            if num == day {
                return true
            }
        }
        
        return false
        
    }
    
}



struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(selectedIndex: .constant("Test"))
    }
}

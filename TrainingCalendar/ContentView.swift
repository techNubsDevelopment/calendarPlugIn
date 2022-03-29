//
//  ContentView.swift
//  TrainingCalendar
//
//  Created by Jeff Cournoyer on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedIndex = String()
    
    let exampleRunDays = [2,5,9,12,19]
    let exampleLiftDays = [1,4,6,15,26]
    let exampleMixDays = [7,14, 21, 28]
    
    var body: some View {
        CalendarView(selectedIndex: $selectedIndex, monthStartIndex: -2, exampleDays: createPassableArray(array1: exampleRunDays, array2: exampleLiftDays, array3: exampleMixDays))
    }
    
    func createPassableArray(array1: [Int], array2: [Int], array3: [Int]) -> [[Int]] {
        var returnArray = [[Int]]()
        
        returnArray.append(array1)
        returnArray.append(array2)
        returnArray.append(array3)
        
        return returnArray
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

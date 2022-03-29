//
//  TrainingProgramGenerator.swift
//  TrainingCalendar
//
//  Created by Jeff Cournoyer on 2/25/22.
//

import Foundation

struct TrainingProgramGenerator {
    
    func generateProgram(withProgram programType: ProgramType) {
        
        switch programType {
        case .distance:
            // 3 LSD
            // 1 HIIT
            // 2 flex
            // (optional) 1 rehab MSK day
            // 2 rests
            
            // 1 or 2 hybrids
            
            print("Distance Program")
        case .speed:
            // 3 HIIT
            // 1 LSD
            // 1 recovery
            // 2 flex
            // (optional) 2 rehab MSK days
            // 1 rest
            
            // 2 hybrids
            
            print("Speed Program")
        case .fitness:
            // 2 Hybrid
            // 2 LSD
            // 2 HIIT
            // 2 flex
            // 2 MSK days
            // 2 rests
            
            // up to 3 hybrids
            
            print("General Fitness Program")
        case .strength:
            // 3 MSK Days
            // 3 flex days
            // 1 LSD
            // 1 HIIT
            // 2 rests
            
            // 3 hybrids (all MSK & flex)
                
            print("Strenght Program")
        case .flexibility:
            // 2 MSK Days
            // 4 flex days
            // 2 LSD Days
            // 1 HIIT Day
            // 1 Recovery Day
            
            // up to 3 hybrids
            
            print("Flex Training")
        case .general:
            // 1 HIIT Day
            // 1 LSD Day
            // 1 Flex Day
            // 1 MSK Day
            // 1 Recovery Day
            // 1 Rest Day
            
            // 0 hybrids
            
            print("General Training")
        }
        
    }
    
}

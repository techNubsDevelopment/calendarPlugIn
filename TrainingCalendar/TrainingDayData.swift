//
//  TrainingDayData.swift
//  TrainingCalendar
//
//  Created by Jeff Cournoyer on 2/23/22.
//

import Foundation

struct CurrentProgram {
    var pID: UUID
    var startDate: Date
    var programLengthInMonths: Int
    var primaryProgramType: ProgramType
    var secondaryProgramType: ProgramType
    var trainingDaysPerWeek: Int
    var difficultyModifier: Int?
    var trainingDays: [TrainingDay]
}

struct TrainingDay {
    var tID: UUID
    var title: String?
    var description: String?
    var dayIndex: Int
    var traingType: TrainingType
    var speed: Double?
    var distance: Double?
    var onIntervalTime: Int?
    var offIntervalTime: Int?
    var sets: Int?
    var reps: Int?
    var daysUntilNextTraining: Int
}

enum TrainingType {
    case aerobicCardio
    case anaerobicCardio
    case MSK
    case hybrid
    case recovery
    case flexibilityOnly
}

enum ProgramType: String {
    case distance = "Increase Distance"
    case speed = "Get Faster / Reduce Time"
    case fitness = "Get Fit / Improve Endurance"
    case strength = "Get Stronger"
    case flexibility = "Train Flexiblity / Reduce Injuries"
    case general = "General Fitness"
}

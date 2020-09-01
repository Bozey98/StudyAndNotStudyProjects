//
//  Activity.swift
//  ActivityApp
//
//  Created by Денис Мусатов on 07.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import Foundation
import SwiftUI


struct Activity: Identifiable, Codable {
    enum ActivityType: String, Codable {
        case sport
        case education
        case homeWork
        case other
    }

    
    let id = UUID()
    let activityName: String
    let description: String
    let timeTake: String
    let activityType: ActivityType
    
    var image : String {
        switch activityType {
            case .education:
                return "study"
            case .homeWork:
                return "home"
            case .sport:
                return "sport"
            case .other:
                return "other"
        }
    }
    
    var color: Color {
        switch activityType {
            case .education:
                return Color.green
            case .homeWork:
                return Color.yellow
            case .sport:
                return Color.blue
            case .other:
                return Color.purple
        }
    }
}



class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(activities) {
                UserDefaults.standard.set(data, forKey: "Activities")
            }
            
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? decoder.decode([Activity].self, from: data) {
                activities = decoded
                return
            }
        }
        activities = []
    }
}

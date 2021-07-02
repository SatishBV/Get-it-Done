//
//  Task.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import Foundation

class Task: Identifiable, ObservableObject {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// Unique identifier for every task
    var id: UUID
    
    /// Indicaetes if a task is complete
    @Published var completed: Bool = false
    
    /// Name of the task
    @Published var title: String
    
    /// Deadline of the task. If the current date exceeds deadline, task should be highlighted as overdue
    @Published var deadLine: Date?
    
    /// Reminder of the task. If the reminder date has passed, the reminder gets removed
    @Published var reminder: Date?
    
    static let defaultTask: Task = Task(title: "Wash clothes", deadLine: Date(), reminder: Date())
    
    init(title: String,
         deadLine: Date? = nil,
         reminder: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.deadLine = deadLine
        self.reminder = reminder
    }
}

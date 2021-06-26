//
//  Task.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import Foundation

struct Task: Identifiable, Hashable {
    /// Unique identifier for every task
    var id: UUID
    
    /// Indicaetes if a task is complete
    var completed: Bool = false
    
    /// Name of the task
    var title: String
    
    /// Deadline of the task. If the current date exceeds deadline, task should be highlighted as overdue
    var deadLine: Date?
    
    /// Reminder of the task. If the reminder date has passed, the reminder gets removed
    var reminder: Date?
    
    static let defaultTask: Task = Task(id: .init(), title: "Wash clothes", deadLine: Date())
}

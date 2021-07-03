//
//  TaskRow.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: Task
    
    private var deadLineString: String {
        guard let deadLine = task.deadLine else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: deadLine)
    }
    
    private var reminderString: String {
        guard let reminder = task.reminder else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "d MMM yyyy h:mm a"
        return dateFormatter.string(from: reminder)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Checkbox(checked: $task.completed)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.system(size: 18))
                    .strikethrough(task.completed, color: Color.gray)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                if !task.completed {
                    HStack(spacing: 16) {
                        if !reminderString.isEmpty {
                            HStack(spacing: 4) {
                                Image(systemName: "alarm")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.black.opacity(0.4))
                                
                                Text(reminderString)
                                    .font(.system(size: 12))
                            }
                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                        }
                        
                        if !deadLineString.isEmpty {
                            HStack(spacing: 4) {
                                Image(systemName: "flag")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.black.opacity(0.4))
                                
                                Text(deadLineString)
                                    .font(.system(size: 12))
                            }
                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                        }
                    }
                }
            }
        }
    }
}

struct TaskRow_Preview: PreviewProvider {
    static var previews: some View {
        TaskRow(task: .defaultTask)
    }
}

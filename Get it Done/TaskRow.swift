//
//  TaskRow.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import SwiftUI

struct TaskRow: View {
    @State var task: Task
    
    private var deadLineString: String {
        guard let deadLine = task.deadLine else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter.string(from: deadLine)
    }
    
    var body: some View {
        HStack {
            Checkbox(checked: $task.completed)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.system(size: 18))
                    .strikethrough(task.completed, color: Color.gray)
                
                if !task.completed && !deadLineString.isEmpty {
                    HStack {
                        Image(systemName: "flag.fill")
                            .foregroundColor(.gray)
                        
                        Text(deadLineString)
                            .font(.system(size: 12))
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

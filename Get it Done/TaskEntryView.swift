//
//  TaskEntryView.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import SwiftUI

extension Binding {
    init<T>(isNotNil source: Binding<T?>, defaultValue: T) where Value == Bool {
        self.init(get: { source.wrappedValue != nil },
                  set: { source.wrappedValue = $0 ? defaultValue : nil})
    }
}

struct TaskEntryView: View {
    @ObservedObject var task: Task
    let addFunction: (Task) -> Void
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        let deadLineBinding = Binding<Date>(
            get: {task.deadLine ?? Date()},
            set: {task.deadLine = $0}
        )
        
        let reminderBinding = Binding<Date>(
            get: {task.reminder ?? Date()},
            set: {task.reminder = $0}
        )
        
        return Form {
            TextField("Task name", text: $task.title)
                .font(.system(size: 18))
                .padding(4)
                .cornerRadius(4)
            
            Section {
                Toggle(isOn: Binding(isNotNil: $task.deadLine, defaultValue: Date())) {
                    HStack {
                        Image(systemName: "flag.fill")
                            .foregroundColor(.red)
                        Text("Deadline")
                            .font(.system(size: 16))
                    }
                }
                if task.deadLine != nil {
                    DatePicker(
                        selection: deadLineBinding,
                        displayedComponents: .date
                    ) {
                        Text("Select date")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Section {
                Toggle(isOn: Binding(isNotNil: $task.reminder, defaultValue: Date())) {
                    HStack {
                        Image(systemName: "alarm.fill")
                            .foregroundColor(.green)
                        Text("Reminder")
                            .font(.system(size: 16))
                    }
                }
                if task.reminder != nil {
                    DatePicker(
                        selection: reminderBinding
                    ) {
                        Text("Select")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                }
            }
            
            if !task.title.isEmpty {
                Section {
                    Button(action: {
                        self.addFunction(task)
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Add task")
                    })
                }
            }
            
            
        }.navigationBarTitle(Text("Add task"), displayMode: .inline)
    }
}

struct TaskEntryView_Preview: PreviewProvider {
    static var previews: some View {
        TaskEntryView(task: Task(title: "")) { _ in
            
        }
    }
}

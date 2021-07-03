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
    enum Mode {
        case add((Task) -> Void)
        case edit
        
        var cta: String {
            switch self {
            case .add:
                return "Add task"
                
            case .edit:
                return "Done"
            }
        }
    }
    @State private var showingOptions = false
    @ObservedObject var task: Task
    let mode: Mode
    
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
            
            HStack {
                Text("Priority")
                    .frame(width: .infinity, height: .infinity)
                    .font(.system(size: 18))
                    .padding(4)
                Spacer()
                Image(systemName: task.priority?.iconString ?? "exclamationmark")
                    .foregroundColor(task.priority?.iconColor ?? .gray.opacity(0.5))
                    
            }
            .onTapGesture {
                showingOptions = true
            }
            .actionSheet(isPresented: $showingOptions) {
                ActionSheet(title: Text("Change background"), buttons: [
                    .default(Text("P1")) {
                        self.task.priority = .p1
                    },
                    .default(Text("P2")) {
                        self.task.priority = .p2
                    },
                    .default(Text("P3")) {
                        self.task.priority = .p3
                    },
                    .cancel()
                ])
            }
            
            Section {
                Toggle(isOn: Binding(isNotNil: $task.deadLine, defaultValue: Date())) {
                    HStack(spacing: 10) {
                        Image(systemName: "calendar")
                            .foregroundColor(.red)
                        
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Deadline")
                                .font(.body)
                            
                            if let deadLine = task.deadLine {
                                Text(DateUtils.dayIdentifier(date: deadLine))
                                    .font(.callout)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                if task.deadLine != nil {
                    DatePicker(
                        "",
                        selection: deadLineBinding,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle.init())
                }
            }
            
            Section {
                Toggle(isOn: Binding(isNotNil: $task.reminder, defaultValue: Date())) {
                    HStack(spacing: 10) {
                        Image(systemName: "alarm")
                            .foregroundColor(.green)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Reminder")
                                .font(.body)
                            
                            if let reminder = task.reminder {
                                Text(DateUtils.dayIdentifier(date: reminder, includeTime: true))
                                    .font(.callout)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                if task.reminder != nil {
                    DatePicker(
                        "",
                        selection: reminderBinding
                    )
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle.init())
                }
            }
            
            if !task.title.isEmpty {
                Section {
                    Button(action: {
                        switch self.mode {
                        case let .add(addFunction):
                            addFunction(task)
                        case .edit:
                            break
                        }
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        Text(self.mode.cta)
                    })
                }
            }
            
            
        }.navigationBarTitle(Text("Add task"), displayMode: .inline)
    }
}

struct TaskEntryView_Preview: PreviewProvider {
    static var previews: some View {
        TaskEntryView(task: Task(title: ""), mode: .add({ _ in
            
        }))
    }
}

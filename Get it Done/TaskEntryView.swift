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
    @State private var title: String = ""
    @State private var deadLine: Date?
    @State private var reminder: Date?
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        Form {
            TextField("Task name", text: $title)
                .font(.system(size: 18))
                .padding(4)
                .cornerRadius(4)
            
            Section {
                Toggle(isOn: Binding(isNotNil: $deadLine, defaultValue: Date())) {
                    HStack {
                        Image(systemName: "flag.fill")
                            .foregroundColor(.red)
                        Text("Deadline")
                            .font(.system(size: 16))
                    }
                }
                if deadLine != nil {
                    DatePicker(
                        selection: Binding<Date>(get: {self.deadLine ?? Date()},
                                                 set: {self.deadLine = $0}),
                        displayedComponents: .date
                    ) {
                        Text("Select date")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                }
            }
            
            if deadLine != nil {
                Section {
                    Toggle(isOn: Binding(isNotNil: $reminder, defaultValue: Date())) {
                        HStack {
                            Image(systemName: "alarm.fill")
                                .foregroundColor(.green)
                            Text("Reminder")
                                .font(.system(size: 16))
                        }
                    }
                    if reminder != nil {
                        DatePicker(
                            selection: Binding<Date>(get: {self.reminder ?? Date()},
                                                     set: {self.reminder = $0})
                        ) {
                            Text("Select")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            
            if !title.isEmpty {
                Section {
                    Button(action: {
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
        TaskEntryView()
    }
}

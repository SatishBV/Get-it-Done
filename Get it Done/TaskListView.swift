//
//  ContentView.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import SwiftUI

struct TaskListView: View {
    @State var tasks: [Task] = [Task.defaultTask]
    
    var body: some View {
        NavigationView {
            ZStack {
                List(tasks) { task in
                    TaskRow(task: task)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination:
                                        TaskEntryView(task: Task(title: ""),
                                                      mode: .add(addNewTask))) {
                            Text("+")
                                .font(.system(.largeTitle))
                                .frame(width: 60, height: 55)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 7)
                        }
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(30)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                    }
                }
            }
            .navigationBarTitle("Tasks")
        }.listStyle(InsetListStyle.init())
    }
    
    func addNewTask(_ task: Task) {
        tasks.append(task)
    }
}

struct TaskList_Preview: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

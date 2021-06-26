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
            List {
                ForEach(tasks) { task in
                    TaskRow(task: task)
                }
            }
            .navigationBarTitle("Tasks")
        }
    }
}

struct TaskList_Preview: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

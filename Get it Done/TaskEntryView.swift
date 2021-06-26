//
//  TaskEntryView.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import SwiftUI

struct TaskEntryView: View {
    @State var title: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task name", text: $title)
                    .font(.system(size: 18))
                
                Section {
                    Button(action: {
                        
                    }, label: {
                        Text("Add")
                    })
                }
                
            }
            .navigationTitle("New task")
        }
    }
}

struct TaskEntryView_Preview: PreviewProvider {
    static var previews: some View {
        TaskEntryView()
    }
}

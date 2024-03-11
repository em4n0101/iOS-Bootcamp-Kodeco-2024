//
//  AddTask.swift
//

import SwiftUI

struct AddTaskView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var taskStore: TaskStore
  @State private var title = ""
  @State private var notes = ""
  @State private var category: Category = .noCategory

  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Task Title")) {
          TextField("Title", text: $title)
        }
        Section(header: Text("Notes")) {
          TextField("Notes", text: $notes, axis: .vertical)
            .lineLimit(5...)
        }
        Section {
          Picker("Category", selection: $category) {
            ForEach(Category.allCases, id: \.self) { item in
              Text(item.rawValue)
            }
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            taskStore.addingTask = false
            dismiss()
          }, label: {
            Text("Cancel")
          })
        }
        ToolbarItem(placement: .principal) {
          Text("Adding New Task")
            .font(.headline)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            taskStore.addTask(task: Task(title: title, category: category, isCompleted: false, notes: notes))
            taskStore.addingTask = false
            dismiss()
          }, label: {
            Text("Add")
          })
          .disabled(title.isEmpty)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }

  }
}

struct AddTask_Previews: PreviewProvider {
  static var previews: some View {
    AddTaskView(taskStore: TaskStore())
  }
}

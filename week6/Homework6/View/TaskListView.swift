//
//  TaskListView.swift
//

import SwiftUI

struct TaskListView: View {
  @ObservedObject var taskStore: TaskStore
  var filter: (Task) -> Bool
  
  var body: some View {
    List(taskStore.tasks.filter(filter)) { task in
      NavigationLink(value: task) {
        TaskRowView(task: task, isAnimating: task.isCompleted) { task in
          taskStore.toggleTaskCompletion(task: task)
        }
      }
    }
    .padding([.trailing], 20)
    .listStyle(.plain)
    .navigationDestination(for: Task.self) { task in
      TaskDetailView(task: $taskStore.tasks
        .first(where: { $0.id == task.id })!)
    }
  }
}

struct TaskListView_Previews: PreviewProvider {
  static var previews: some View {
    TaskListView(taskStore: TaskStore(), filter: {$0.isCompleted} )
  }
}

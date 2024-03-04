//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
  @StateObject var taskStore = TaskStore()
  @State var categoryTitleSelected: String? = nil
  @State private var taskSearchTerm = ""
  
  var body: some View {
    TabView {
      HandlerTaskList(
        taskStore: taskStore,
        filter: {
          if taskSearchTerm.isEmpty { !$0.isCompleted}
          else {!$0.isCompleted && $0.title.lowercased().contains(taskSearchTerm.lowercased())}
        })
      .tabItem {
        Label("Tasks", systemImage: "list.bullet.circle")
      }
      
      HandlerTaskList(
        taskStore: taskStore,
        filter: {
          if taskSearchTerm.isEmpty { $0.isCompleted}
          else {$0.isCompleted && $0.title.lowercased().contains(taskSearchTerm.lowercased())}
        })
        .tabItem {
          Label("Completed", systemImage: "checkmark.circle")
        }
      
      let layout = [
        GridItem(.fixed(130)),
        GridItem(.fixed(130)),
      ]
      
      NavigationStack {
        VStack {
          LazyVGrid(columns: layout, spacing: 20){
            ForEach(Category.allCases, id: \.self) { category in
              GridItemView(
                title: category.rawValue,
                subtitle: String(taskStore.tasks.filter{ $0.category == category }.count),
                isSelected: (category.rawValue == categoryTitleSelected),
                onTap: {
                  if let categoryTitle = categoryTitleSelected {
                    if categoryTitle == $0 {
                      categoryTitleSelected = nil
                    } else {
                      categoryTitleSelected = $0
                    }
                  } else {
                    categoryTitleSelected = $0
                  }
                }
              )
            }
          }
          HandlerTaskList(
            taskStore: taskStore,
            filter: {
              if let categoryTitleSelected = categoryTitleSelected {
                if taskSearchTerm.isEmpty {
                  return $0.category.rawValue == categoryTitleSelected
                } else {
                  return $0.category.rawValue == categoryTitleSelected && $0.title.lowercased().contains(taskSearchTerm.lowercased())
                }
              } else {
                if taskSearchTerm.isEmpty { return true}
                else { return $0.title.lowercased().contains(taskSearchTerm.lowercased())}
              }
            })
        }
      }
      .tabItem {
        Label("All", systemImage: "list.bullet.below.rectangle")
      }
    }
    .searchable(text: $taskSearchTerm)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct HandlerTaskList: View {
  var taskStore: TaskStore
  var filter: (Task) -> Bool
  
  var body: some View {
    NavigationStack {
      VStack {
        if taskStore.tasks.isEmpty {
          Text("No tasks found")
        } else {
          TaskListView(taskStore: taskStore, filter: filter)
        }
        Spacer()
      }
      .navigationTitle("My Tasks")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NewTaskButtonView(taskStore: taskStore)
        }
      }
    }
  }
}

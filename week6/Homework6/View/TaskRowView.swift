//
//  TaskRow.swift
//  

import SwiftUI

struct TaskRowView: View {
  let task: Task
  @State var isAnimating: Bool
  var completeTask: (Task) -> Void

  var body: some View {
    HStack {
      Text(task.title)
      Spacer()
      Image(systemName: isAnimating ? "checkmark.square" : "square")
        .resizable()
        .foregroundColor(isAnimating ? .green : .gray)
        .frame(width: 25.0, height: 25.0)
        .onTapGesture {
          isAnimating.toggle()
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              completeTask(task)
          }
        }
        .animation(.easeIn(duration: 1), value: isAnimating)
    }
    .font(.title3)
    .bold()
    .padding([.top, .bottom], 15)
    .padding([.leading, .trailing], 10)
  }
}

struct TaskRow_Previews: PreviewProvider {
  static var previews: some View {
    TaskRowView(
      task: Task(title: "My Task", category: .noCategory, isCompleted: false),
      isAnimating: false){_ in
    }
  }
}

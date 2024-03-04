//
//  GridItemView.swift
//  Homework6
//
//  Created by Alejandro Barranco on 04/03/24.
//

import SwiftUI

struct GridItemView: View {
  let title: String
  let subtitle: String
  let isSelected: Bool
  var onTap: (String) -> Void
  
  var body: some View {
    VStack {
      Text(title)
      Text(subtitle)
    }
    .frame(width: 130, height: 130)
    .background(isSelected ? .green : .red)
    .cornerRadius(10)
    .shadow(radius: 5)
    .onTapGesture {
      onTap(title)
    }
  }
}

//
//  ContentView.swift
//  iOS Bootcamp Kodeco 2024
//
//  Created by Alejandro Barranco on 29/01/24.
//

import SwiftUI

struct ContentView: View {
  @State private var sliderRedValue = 100.0
  @State private var sliderGreenValue = 50.0
  @State private var sliderBlueValue = 200.0
  @State private var color: Color = Color(red: 100 / 255, green: 50 / 255, blue: 200 / 255)

  var body: some View {
    VStack {
      Text("Color Picker")
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .padding()
      
      RoundedRectangle(cornerRadius: 0)
        .fill(color)
        .frame(width: 350, height: 320)
        .padding()
      
      Text("Red")
      HStack {
        Slider(value: $sliderRedValue, in: 0.0...255.0)
        Text("\(Int(sliderRedValue.rounded()))")
      }.padding()
      
      Text("Green")
      HStack {
        Slider(value: $sliderGreenValue, in: 0.0...255.0)
        Text("\(Int(sliderGreenValue))")
      }.padding()

      Text("Blue")
      HStack {
        Slider(value: $sliderBlueValue, in: 0.0...255.0)
        Text("\(Int(sliderBlueValue))")
      }.padding()

      Button("Set Color") {
        self.color = Color(red: sliderRedValue / 255, green: sliderGreenValue / 255, blue: sliderBlueValue / 255)
      }.padding()
    }
  }
}

#Preview {
    ContentView()
}

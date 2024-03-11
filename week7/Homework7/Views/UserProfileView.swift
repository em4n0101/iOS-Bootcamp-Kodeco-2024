/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct UserProfileView: View {
  @ObservedObject var userStore: UserStore
  
  var user: Result? {
    userStore.userResult.first
  }
  
  var body: some View {
    VStack {
      ZStack {
        AsyncImage(
          url: URL(string: user?.picture.medium ?? ""),
          content: { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(height: 160)
              .blur(radius: 10)
          },  placeholder: {
            ProgressView()
          }
        )
        .frame(height: 160)
        
        AsyncImage(
          url: URL(string: user?.picture.medium ?? ""),
          content: { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 120, height: 120)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.white, lineWidth: 4))
          },  placeholder: {
            ProgressView()
          })
        .frame(width: 120, height: 120)
      }
      
      Text("\(user?.name.first ?? "") \(user?.name.last ?? "")" )
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(.white)
      
      Spacer()
      VStack(spacing: 8) {
        Label(user?.email ?? "", systemImage: "envelope.fill")
        Label(user?.phone ?? "", systemImage: "phone.fill")
        Text("Gender: \(user?.gender ?? "")")
        Text("Country: \(user?.location.country ?? "")")
        Text("State: \(user?.location.state ?? "")")
        Text("City: \(user?.location.city ?? "")")
      }
      Spacer()
    }
  }
}


struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    UserProfileView(userStore: UserStore())
  }
}

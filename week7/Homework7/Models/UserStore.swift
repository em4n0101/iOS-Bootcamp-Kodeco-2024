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

import Foundation

class UserStore: ObservableObject {
  @Published var errorMessage: String? = nil
  @Published var userResult: UserResult = UserResult(
    results: [],
    info: Info(
      seed: "",
      results: 0,
      page: 0,
      version: ""
    )
  ) {
    didSet {
      saveJSONPrioritizedUser()
    }
  }
  let userJSONURL = URL(fileURLWithPath: "UserResults",
                       relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
  
  init() {
    loadUserJSON()
  }
  
  private func loadUserJSON() {
    let jsonURL: URL
    
    if let bundleURL = Bundle.main.url(forResource: "userresults", withExtension: "json"),
      FileManager.default.fileExists(atPath: bundleURL.path) {
      jsonURL = bundleURL
    } else {
      if FileManager.default.fileExists(atPath: userJSONURL.path) {
        jsonURL = userJSONURL
      } else {
        errorMessage = "Error: Failed to load API data"
        return
      }
    }
    
    let decoder = JSONDecoder()
    
    do {
      let userData = try Data(contentsOf: jsonURL)
      let userCollectionDecoded = try decoder.decode(UserResult.self, from: userData)
      userResult = userCollectionDecoded
      
    } catch let error {
      print(error)
      errorMessage = "Error: Failed to decode API data"
    }
  }
  
  private func saveJSONPrioritizedUser() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
      let apiData = try encoder.encode(userResult)
      
      try apiData.write(to: userJSONURL, options: .atomicWrite)
    } catch let error {
      print(error)
    }
  }
}

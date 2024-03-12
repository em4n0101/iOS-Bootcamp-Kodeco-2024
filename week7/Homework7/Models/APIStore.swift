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

class APIStore: ObservableObject {
  @Published var errorMessage: String? = nil
  @Published var apiCollection: APICollection = APICollection(count: 0, entries: []) {
    didSet {
      saveJSONPrioritizedApi()
    }
  }
  let apiJSONURL = URL(fileURLWithPath: "API",
                       relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
  
  init() {
    loadApiJSON()
  }
  
  private func loadApiJSON() {
    let jsonURL: URL
    
    if let bundleURL = Bundle.main.url(forResource: "apiliest", withExtension: "json"),
      FileManager.default.fileExists(atPath: bundleURL.path) {
      jsonURL = bundleURL
    } else {
      if FileManager.default.fileExists(atPath: apiJSONURL.path) {
        jsonURL = apiJSONURL
      } else {
        errorMessage = "Error: Failed to load API data"
        return
      }
    }
    
    let decoder = JSONDecoder()
    
    do {
      let apiData = try Data(contentsOf: jsonURL)
      let apiCollectionDecoded = try decoder.decode(APICollection.self, from: apiData)
      apiCollection = apiCollectionDecoded
      
    } catch let error {
      print(error)
      errorMessage = "Error: Failed to decode API data"
    }
  }
  
  private func saveJSONPrioritizedApi() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
      let apiData = try encoder.encode(apiCollection)
      
      try apiData.write(to: apiJSONURL, options: .atomicWrite)
    } catch let error {
      print(error)
    }
  }
}

import Foundation
import CreateML

// Preprocessing
let path = "/Users/alanjeferson/projects/TDC2019SP/Training/TextClassification.playground/Pages/SpamAnalysis.xcplaygroundpage/Resources/SMSSpamCollection.txt"
let url = URL(fileURLWithPath: path)
let raw = try String(contentsOf: url)
let sents = raw.components(separatedBy: CharacterSet.newlines)

struct SpamPoint: Codable {
  let label: String
  let text: String
}

let points = sents.compactMap { sent -> SpamPoint? in
  let components = sent.components(separatedBy: "\t")
  guard components.count > 1 else {
    return nil
  }
  return SpamPoint(label: components[0], text: components[1])
}

let encoder = JSONEncoder()
let data = try encoder.encode(points)

let output = URL(fileURLWithPath: "/Users/alanjeferson/Desktop/spams.json")
try data.write(to: output)

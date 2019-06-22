import Foundation
import NaturalLanguage

let tagger = NLTagger(tagSchemes: [.sentimentScore])

// TODO Test performance on other languages

let sentences = [
  "Wow, Cheddar is so delicious!",
  "Cheddar is delicious",
  "Cheddar is good",
  "Cheddar is OK",
  "Cheddar tastes really bad",
  "Cheddar tastes really bad, worst thing ever",
  "Cheddar makes me sick",
  "I don't like Cheddar",
  "I like Cheddar",
]
sentences.forEach { sent in
  tagger.string = sent
  tagger.setLanguage(.english, range: sent.startIndex..<sent.endIndex)
  let (tag, _) = tagger.tag(at: sent.startIndex, unit: .paragraph, scheme: .sentimentScore)
  guard let sentiment = tag else { return }
  print("\(sent): \(sentiment.rawValue)")
}

// MARK: - Requesting Assets
// TODO Better understand this

NLTagger.requestAssets(for: .portuguese, tagScheme: .nameTypeOrLexicalClass) { (assetResult, err) in
  switch assetResult {
  case .available:
    print("Assets are available now!")
  case .notAvailable:
    print("Assets are unavailable")
  case .error:
    print("Assets errored out")
  }
  guard let error = err else { return }
  print(error)
}

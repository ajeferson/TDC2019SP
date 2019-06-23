import Foundation
import PlaygroundSupport
import NaturalLanguage

PlaygroundPage.current.needsIndefiniteExecution = true

// Sentiment Analysis is supported on the following languages:
// 1. English
// 2. Portuguese
// 3. Spanish
// 4. Italian
// 5. German
// 6. French
// 7. Simplified chinese
let exampleOfSentimentAnalysis = example(of: "Sentiment Analysis") {
  let tagger = NLTagger(tagSchemes: [.sentimentScore])
  func runSentimentAnalysis(on sents: [String], with language: NLLanguage) {
    sents.forEach { sent in
      tagger.string = sent
      tagger.setLanguage(language, range: sent.startIndex..<sent.endIndex)
      let (tag, _) = tagger.tag(at: sent.startIndex, unit: .paragraph, scheme: .sentimentScore)
      guard let sentiment = tag else { return }
      print("\(sent): \(sentiment.rawValue)")
    }
  }
  
  // English
  let englishSents = [
    "Cheddar is so delicious!",
    "Cheddar is delicious",
    "Cheddar is good",
    "Cheddar tastes really bad",
    "Cheddar tastes really bad, worst thing ever",
    "Cheddar makes me sick",
    "I don't like Cheddar",
    "I like Cheddar",
  ]
  
  // Portuguese
  let portugueseSents = [
    "Cheddar é o melhor queijo de todos!",
    "Cheddar é bom",
    "Cheddar não é tão bom assim",
    "Detesto cheddar!",
    "Eu gosto de cheddar",
    "Eu não gosto de cheddar"
  ]

  // Spanish
  let spanishSents = [
    "Cheddar es tan delicioso!",
    "El cheddar es delicioso",
    "Cheddar es bueno",
    "Cheddar sabe muy mal",
    "Cheddar sabe muy mal, lo peor"
  ]
  
  let tuples: [(NLLanguage, [String])] = [
    (.english, englishSents),
    (.portuguese, portugueseSents),
    (.spanish, spanishSents)
  ]
  
  tuples.forEach { language, sents in
    print("---------- Sentiment Analysis for \(language.rawValue) ----------")
    if NLTagger.availableTagSchemes(for: .paragraph,
                                    language: language).contains(.sentimentScore) {
      runSentimentAnalysis(on: sents, with: language)
    } else {
      // Download required assets if not available on device
      NLTagger.requestAssets(for: language, tagScheme: .sentimentScore) { (assetResult, error) in
        guard case .available = assetResult, error == nil else {
          print("Fail to fetch assets for \(language.rawValue)")
          return
        }
        runSentimentAnalysis(on: sents, with: language)
      }
    }
  }
}
exampleOfSentimentAnalysis()

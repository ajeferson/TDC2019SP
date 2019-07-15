import Foundation
import NaturalLanguage

let exampleOfNotHintedRecognition = example(of: "Not Hinted Recognition") {
  let corpus = "Apple Park is the Apple’s headquarters located in Cupertino."
  guard let language = NLLanguageRecognizer.dominantLanguage(for: corpus) else {
    print("Is that an alien language or something?")
    return
  }
  print("Language: \(language.rawValue)")
}
exampleOfNotHintedRecognition()

let exampleOfHintedRecognition = example(of: "Hinted Recognition") {
  let corpus = "And here we are at TDC SP 2019!"

  let recognizer = NLLanguageRecognizer()
  recognizer.processString(corpus)
  
  if let likelyLanguage = recognizer.dominantLanguage {
    print("Dominant: \(likelyLanguage.rawValue)")
  }
  
  print("Probabilities:")
  recognizer
    .languageHypotheses(withMaximum: 10)
    .map { ($0.key, $0.value) }
    .sorted { $0.1 > $1.1 }
    .forEach { language, probability in
      print("\(language.rawValue): \(String(format: "%.2f", probability * 100))%")
  }
  
  recognizer.reset()
  assert(recognizer.languageHypotheses(withMaximum: 10).count == 0)
}
//exampleOfHintedRecognition()

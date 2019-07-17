import Foundation
import NaturalLanguage

let exampleOfWordEmbeddingInfo = example(of: "Word Embedding Info") {
  guard let embedding = NLEmbedding.wordEmbedding(for: .english) else { exit(0) }
  print("Vocabulary Size: \(embedding.vocabularySize)")
  print("# Dimensions: \(embedding.dimension)")
  print("Revision: \(embedding.revision)")
  
  print("Arabic revision: \(NLEmbedding.currentRevision(for: .arabic))") // 0 for unsupported languages
  print("English revision: \(NLEmbedding.currentRevision(for: .english))")
}
//exampleOfWordEmbeddingInfo()

//guard let embedding = NLEmbedding.wordEmbedding(for: .english) else { exit(0) }
//guard let computerVector = embedding.vector(for: "computer") else { exit(0) }
//computerVector.count // 300
//embedding.dimension
//let laptopDistance = embedding.distance(between: "computer", and: "laptop")    // 0.8865093588829
//let guitarDistance = embedding.distance(between: "computer", and: "pineapple") // 1.3616414070129
//let neighbors = embedding.neighbors(for: "computer", maximumCount: 5, distanceType: .cosine).map { $0.0 } // workstation, mainframe, laptop, software, computing


guard let embedding = NLEmbedding.wordEmbedding(for: .english) else { exit(0) }
let dimensions = embedding.dimension
guard let computerVector = embedding.vector(for: "computer") else { exit(0) }
let laptopDistance = embedding.distance(between: "computer", and: "laptop")
let neighbors = embedding.neighbors(for: "computer",
                                    maximumCount: 5,
                                    distanceType: .cosine)

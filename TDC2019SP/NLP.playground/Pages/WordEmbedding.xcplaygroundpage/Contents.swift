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

let exampleOfEmbeddingNeighbors = example(of: "Embedding Neighbors") {
  guard let embedding = NLEmbedding.wordEmbedding(for: .portuguese) else { exit(0) }
  if let vector = embedding.vector(for: "computador") {
    print(vector.count) // should be equal embedding.dimension
  }

  print(embedding.distance(between: "computador", and: "laptop"))
  print(embedding.distance(between: "computafor", and: "guitarra"))

  // .cosine is the way of calculating the distance between two vectors in the embedding space
  embedding.neighbors(for: "computador", maximumCount: 5, distanceType: .cosine).forEach { word, distance in
    print(word, distance)
  }
}
exampleOfEmbeddingNeighbors()

import Foundation
import CreateML

// Loading dataset
let inputPath = "/Users/alanjeferson/projects/TDC2019SP/Training/TextClassification.playground/Pages/SpamAnalysis.xcplaygroundpage/Resources/HamSpamDataset.json"
let inputURL = URL(fileURLWithPath: inputPath)
let dataset = try MLDataTable(contentsOf: inputURL)

// Splitting into training/test sets
let splitRatio = 0.8
let (trainingSet, testSet) = dataset.randomSplit(by: splitRatio, seed: 7)

// Creating the model
let params = MLTextClassifier.ModelParameters(algorithm: .maxEnt(revision: 1),
                                              language: .english)
let model  = try MLTextClassifier(trainingData: trainingSet,
                                  textColumn: "text",
                                  labelColumn: "label",
                                  parameters: params)

// How well the model performed on test set (unseen data)
let testMetrics = model.evaluation(on: testSet)
let testAccuracy = testMetrics.accuracy * 100

print("Test Metrics:")
print("Accuracy: \(testAccuracy)")
print("Precision and Recall:")
print(testMetrics.precisionRecall)
print("Confusion Matrix:")
print(testMetrics.confusion.description)

// Otherwise, persist the CoreML model file
let metadata = MLModelMetadata(author: "Alan Jeferson",
                               shortDescription: "Spam Classifier for TDC SP",
                               version: "1.0")
let outputPath = "/Users/alanjeferson/Desktop/NLF/SpamClassifier.mlmodel"
let outputURL = URL(fileURLWithPath: outputPath)
//try model.write(to: outputURL, metadata: metadata)

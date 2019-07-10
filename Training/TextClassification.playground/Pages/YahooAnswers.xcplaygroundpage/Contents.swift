import Foundation
import CreateML

// Loading dataset
let inputURL = URL(fileURLWithPath: "/Users/alanjeferson/projects/TDC2019SP/Training/TextClassification.playground/Pages/YahooAnswers.xcplaygroundpage/Resources/YahooAnswers.json")
let dataset = try MLDataTable(contentsOf: inputURL)

// Splitting into training/test sets
let (trainingSet, testSet) = dataset.randomSplit(by: 0.8, seed: 7)

// Creating the model
let model  = try MLTextClassifier(trainingData: trainingSet, textColumn: "text", labelColumn: "label")

// How well the model performed on test set (unseen data)
let testMetrics = model.evaluation(on: testSet)
let testAccuracy = testMetrics.accuracy * 100

print("Test Metrics:")
print("Accuracy: \(testAccuracy)")
print("Precision and Recall:")
print(testMetrics.precisionRecall)
print("Confusion Matrix:")
print(testMetrics.confusion.description)

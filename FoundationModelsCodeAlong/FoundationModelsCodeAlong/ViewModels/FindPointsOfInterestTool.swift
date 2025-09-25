/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A tool to use alongside the models to find points of interest for a landmark.
*/

import FoundationModels
import SwiftUI

@Observable
final class FindPointsOfInterestTool: Tool {
    
    // MARK: - [CODE-ALONG] Chapter 5.1.1: Define tool name and description
    let name = "findPointsOfInterest"
    let description = "Finds points of interest for a landmark."

    
    let landmark: Landmark
    init(landmark: Landmark) {
        self.landmark = landmark
    }

    @Generable
    struct Arguments {
        // MARK: - [CODE-ALONG] Chapter 5.1.3: Define tool arguments
        @Guide(description: "This is the type of business to look up for.")
        let pointOfInterest: Category
        
    }
    
    func call(arguments: Arguments) async throws -> String {
        // MARK: - [CODE-ALONG] Chapter 5.1.4: Implement the tool's call logic
        let results = await getSuggestions(
            category: arguments.pointOfInterest,
            landmark: landmark.name
        )
        return """
             There are these \(arguments.pointOfInterest) in \(landmark.name): 
             \(results.joined(separator: ", "))
             """
    }
    
}

// MARK: - [CODE-ALONG] Chapter 5.1.2: Define searchable categories
 @Generable
 enum Category: String, CaseIterable {
     case hotel
     case restaurant
 }

func getSuggestions(category: Category, landmark: String) -> [String] {
    // MARK: - [CODE-ALONG] Chapter 5.1.5: Provide mock data for suggestions
    switch category {
     case .hotel : ["Hotel 1", "Hotel 2", "Hotel 3"]
     case .restaurant : ["Restaurant 1", "Restaurant 2", "Restaurant 3"]
     }
}

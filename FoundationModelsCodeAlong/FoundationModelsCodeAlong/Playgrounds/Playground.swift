/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Playground for testing Foundation Models framework features.
*/

import FoundationModels
import Playgrounds

#Playground {
    let landmark = ModelData.landmarks[0]
    let pointOfInterestTool = FindPointsOfInterestTool(landmark: landmark)
    
    let instructions = Instructions {
        "Your job is to create an itinerary for the user."
        "For each day, you must suggest one hotel and one restaurant."
        "Always use the 'findPointsOfInterest' tool to find hotels and restaurant in \(landmark.name)"
    }
    
    let session = LanguageModelSession(
        tools: [pointOfInterestTool],
        instructions: instructions
    )
    
    let prompt = Prompt {
        "Generate a 3-day itinerary to \(landmark.name)."
        "Give it a fun title and description."
    }
    
    let response = try await session.respond(
        to: prompt,
        generating: Itinerary.self,
        options: GenerationOptions(sampling: .greedy)
    )
    
    let inspectSession = session
}

// The @Generable macro makes your custom type compatible with the model.
@Generable
struct SimpleItinerary {
    // The @Guide macro provides hints to the model about a property.
    @Guide(description: "An exciting name for the trip.")
    let title: String

    @Guide(description: "A short, engaging description of the trip.")
    let description: String

    @Guide(description: "A list of day-by-day plans, as simple strings.")
    @Guide(.count(3))
    let days: [String]
}

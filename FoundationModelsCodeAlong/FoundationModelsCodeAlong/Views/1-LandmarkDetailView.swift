/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A SwiftUI view for displaying the appropriate view based on the availability of the System Language Model.
*/

import FoundationModels
import SwiftUI

struct LandmarkDetailView: View {
    let landmark: Landmark
    
    // MARK: - [CODE-ALONG] Chapter 1.4.1: Add a model instance
    private let model = SystemLanguageModel.default
    
    // MARK: - [CODE-ALONG] Chapter 1.4.2: Remove placeholder availability
    

    var body: some View {
        // MARK: - [CODE-ALONG] Chapter 1.4.3: Replace availability with model.availability
        switch model.availability {
        case .available:
            LandmarkTripView(landmark: landmark)
            
        case .unavailable:
            MessageView(
                landmark: self.landmark,
                message: """
                         Trip Planner is unavailable because \
                         Apple Intelligence has not been turned on.
                         """
            )
        @unknown default:
            MessageView(
                landmark: self.landmark,
                message: """
                         Trip Planner is unavailable. Try again later.
                         """
            )
        }
    }
}

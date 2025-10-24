//
//  LandmarkRow.swift
//  LandMarks
//
//  Created by Asif Habib on 01/12/24.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height:50)
            Text(landmark.name)
            Spacer()
            if landmark.isFavourite {
                Image(systemName: "star.fill")
            }
        }
    }
}

#Preview("forestrek") {
    Group {
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[1])
    }
    
}
#Preview("second") {
    LandmarkRow(landmark: landmarks[1])
}

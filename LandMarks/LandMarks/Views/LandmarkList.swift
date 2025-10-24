//
//  LandmarkList.swift
//  LandMarks
//
//  Created by Asif Habib on 01/12/24.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationSplitView{
            List(landmarks){ landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
                
            }
            .navigationTitle("Landmarks")
        } detail: {
            Text("select a landmark")
        }
        
    }
}

#Preview {
    LandmarkList()
}

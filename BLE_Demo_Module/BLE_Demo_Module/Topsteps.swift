//
//  Topsteps.swift
//  BLE_Demo_Module
//
//  Created by Asif Habib on 10/10/23.
//

import Foundation
import FitCloudKit

public class Topsteps {
    public static func getStepsData() {
        print(">> In Module :> Connected? ...", FitCloudKit.connected())
        FitCloudKit.requestHealthAndSportsDataToday(){ status, userId, dataObject, error in
            print(">> HEALTH Data for user \(userId), with status \(status): > ", dataObject)
        }
    }
}

//
//  IntroductionViewModel.swift
//  LocationSimulator
//
//  Created by Watanabe Toshinori on 2020/05/24.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class IntroductionViewModel: ObservableObject {

    var location: Location

    @Published var alert: ErrorAlert?

    // MARK: - Initializing ViewModel

    init(_ location: Location) {
        self.location = location
    }

    // MARK: - Actions

    func startPressed() {
        if
            Process.isExists("idevice_id") == false
        {
            self.alert = ErrorAlert(title: "Library not found",
                                    message: "The libimobiledevice library not found. Please install the library from github repository.")
            return
        }
        if
            Process.isExists("idevicesetlocation") == false || Process.isExists("idevicelocation") == false
        {
            self.alert = ErrorAlert(title: "Library not found",
                                    message: "The idevicelocation library not found. Please install the library from github repository.")
            return
        }
        guard let device = Device.find() else {
            self.alert = ErrorAlert(title: "Device not connected",
                                    message: "No device connected.\nPlease connect the device and trust this mac.")
            return
        }

        location.device = device
    }

}

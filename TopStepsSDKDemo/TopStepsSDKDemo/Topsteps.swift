//
//  Topsteps.swift
//  TopStepsSDKDemo
//
//  Created by Asif Habib on 08/10/23.
//

import Foundation
import FitCloudKit

class TopSteps: NSObject {
    static var manager = TopSteps()
    var fitCloudSDK: FitCloudKit!
    var findPhoneNotificationBlock : ((_ status: Bool) -> ())?
    public func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkNotification), name: NSNotification.Name(FITCLOUDEVENT_PERIPHERAL_CONNECTING_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connectedNotification), name: NSNotification.Name(FITCLOUDEVENT_PERIPHERAL_CONNECTED_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectNotification), name: NSNotification.Name(FITCLOUDEVENT_PERIPHERAL_DISCONNECT_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connectFailureNotification), name: NSNotification.Name(FITCLOUDEVENT_PERIPHERAL_CONNECT_FAILURE_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(writeCharNotification), name: NSNotification.Name(FITCLOUDEVENT_PERIPHERAL_WRITECHARACTERISTIC_READY_NOTIFIY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bindingResult), name: NSNotification.Name(FITCLOUDEVENT_BINDUSEROBJECT_RESULT_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(beginBinding), name: NSNotification.Name(FITCLOUDEVENT_BINDUSEROBJECT_BEGIN_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkNotification), name: NSNotification.Name(FITCLOUDEVENT_PREPARESYNCWORK_END_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkNotification), name: NSNotification.Name(FITCLOUDEVENT_PERIPHERAL_DISCOVERED_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onFitCloudKitInitializeResult), name: NSNotification.Name(FITCLOUDEVENT_INITIALIZE_RESULT_NOTIFY), object: nil)
    }
    func setUpSDK(){
        if self.fitCloudSDK == nil {
            let option = FitCloudOption.default()
            option?.debugMode = false
            option?.shouldAutoConnect = false
            self.fitCloudSDK = FitCloudKit.initWith(option, callback: self)
        }
    }
    @objc func checkNotification(){
        
        print(">> Connecting ... ", FitCloudKit.connected())
        
        
    }
    @objc func beginBinding() {
        print(">> Binding Begin ...")
    }
    @objc func bindingResult(){
        print(">> Binding Result ...")
    }
    
    @objc func connectedNotification() {
        print(">> Device connected")
//        delegate?.moveToDeviceInfoVC()
    }
    
    @objc func disconnectNotification() {
        print(">> Disconnect notification")
//        delegate?.moveToVC()
    }
    @objc func writeCharNotification() {
        print(">> writeCharNotification notification")
        if FitCloudKit.alreadyBound() == false {
            FitCloudKit.bindUserObject("10000", abortIfExist: false) { status, error in
                print(">> Bind success: \(status), error: \(String(describing: error))")
                if status {
//                    self.delegate?.moveToDeviceInfoVC()
                }
            }
        }
    }
    @objc func getAllConfigResult() {
        print(">> Got all config result ")
    }
    @objc func connectFailureNotification() {
        print(">> Failure in connection")
    }
    
    @objc func handleNotification(_ notification: Notification) {
        print("Received notification: \(notification.name.rawValue)")
    }
    
    @objc func onFitCloudKitInitializeResult(notification: NSNotification){
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary;
        print("UserInfo: \(userInfo)")
//        if userInfo.isKind(of: NSDictionary){
//            let isBound: Bool = userInfo
//        }
    }
    func connect(peripheral: CBPeripheral) {
        FitCloudKit.translate(peripheral) { status, error, peripheral in
            print(">> in connect method: ", status, error, peripheral)
            if let peripheral = peripheral {
               FitCloudKit.connect(peripheral)
                print(">> IS THE DEVICE BOUND ALREADY", FitCloudKit.alreadyBound(), FitCloudKit.isUserAlreadyBound("10000"))
                if !FitCloudKit.alreadyBound() {
                    self.bindUser(userId: "10000")
                }
            }
        }
    }
    
    func bindUser(userId:String){
        FitCloudKit.bindUserObject(userId, abortIfExist: false) { status, error in
            print(">> Bind status : \(status) and error: \(String(describing: error))")
        }
    }
}


extension TopSteps: FitCloudCallback {
    func onLogMessage(_ message: String, level: FITCLOUDKITLOGLEVEL) {
        print("FitCloudCallback: Message: \(message) Level: \(level.rawValue)")
    }
    
    func onFindiPhoneEvent() {
        print("Find phone tapped")
        self.findPhoneNotificationBlock?(true)
    }
}

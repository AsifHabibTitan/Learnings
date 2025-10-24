//
//  Manager.swift
//  BLEDemoApp
//
//  Created by Asif Habib on 04/10/23.
//

import Foundation
import FitCloudKit
import FitCloudDFUKit
import FitCloudWFKit

class Manager:NSObject {
    static var manager = Manager()
    
    override init() {
        super.init()
        self.dfuManager = DFUManager(manager: self)
       setUpSDK()
    }
    var syncStatus:Bool = false
    var delegate : ViewController?
    var deviceToConnect: CBPeripheral?
    var fitCloudSDK: FitCloudKit?
    var findPhoneNotificationBlock : ((_ status: Bool) -> ())?
    var dfuManager : DFUManager?
    func getLastConnectedDevice() -> FitCloudKitConnectRecord? {
        return FitCloudKit.lastConnectPeripheral()
        
    }
    
    public var state: CBPeripheralState {
        return FitCloudKit.connected() ? .connected : .disconnected
    }
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(prepareSyncWorkBeginNotification), name: NSNotification.Name(FITCLOUDEVENT_PREPARESYNCWORK_BEGIN_NOTIFY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(prepareSyncWorkEndNotification), name: NSNotification.Name(FITCLOUDEVENT_PREPARESYNCWORK_END_NOTIFY), object: nil)
    }
    
    func setUpSDK(){
        if self.fitCloudSDK == nil {
            let option = FitCloudOption.default()
            option?.debugMode = false
            option?.shouldAutoConnect = false
            self.fitCloudSDK = FitCloudKit.initWith(option, callback: self)
        }
    }
    @objc func checkNotification(notification:NSNotification){
        
        print(">> peripheralConnectingNotify Connecting ... ", FitCloudKit.connected())
        print(">> peripheralConnectingNotify IsDeviceReady ...", FitCloudKit.deviceReady())
        
        
    }
    @objc func beginBinding(notification: NSNotification) {
        let result = notification.userInfo?["result"] as? Bool ?? false
        print(">> Connected? ... ", FitCloudKit.connected())
        print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
        print(">> Binding Begin ... \(result) ")
    }
    @objc func bindingResult(notification: NSNotification){
        let result = notification.userInfo?["result"] as? Bool ?? false
        print(">> beginBinding Connected? ... ", FitCloudKit.connected())
        print(">> beginBinding IsDeviceReady ...", FitCloudKit.deviceReady())
        print(">> beginBinding Binding Result ... \(result)")
    }
    
    @objc func connectedNotification(notification: NSNotification) {
        print(">> Connected? connectedNotification ... ", FitCloudKit.connected())
        print(">> IsDeviceReady connectedNotification ...", FitCloudKit.deviceReady())
        print(">> isDeviceIdle connectedNotification ...", FitCloudKit.deviceIdle())
        print(">> allConfig connectedNotification ...", FitCloudKit.allConfig() ?? "")
        print(">> macaddr connectedNotification ...", FitCloudKit.macAddr() ?? "")
        print(">> Device connected connectedNotification", notification.userInfo ?? "")
        if FitCloudKit.isCurrentDFUMode() {
            self.exitDFUMode()
        }
//        delegate?.moveToDeviceInfoVC()
    }
    
    @objc func disconnectNotification(notification: NSNotification) {
        print(">> disconnectNotification Connected? ... ", FitCloudKit.connected())
        print(">> disconnectNotification IsDeviceReady ...", FitCloudKit.deviceReady())
        print(">> disconnectNotification Disconnect notification", notification.userInfo ?? "")
//        delegate?.moveToVC()
        
    }
    @objc func writeCharNotification(notification: NSNotification) {
        print(">> Connected? ... ", FitCloudKit.connected())
        print(">> writeCharNotification notification", notification.userInfo ?? "")
        print(">> writeCharNotification deviceReady", FitCloudKit.deviceReady())
        if FitCloudKit.alreadyBound() == false {
            FitCloudKit.bindUserObject("10000", randomCode: nil, abortIfExist: false) { status, error in
                print("Bind success: \(status), error: \(String(describing: error))")
                print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
//                if status {
//                    self.delegate?.moveToDeviceInfoVC()
//                }
            }
        }
    }
    
    @objc func prepareSyncWorkBeginNotification(notification: NSNotification) {
        print(">> Connected?  ... ", FitCloudKit.connected())
        print(">> Sync Work Begin", notification.userInfo ?? "")
        print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
    }
    @objc func prepareSyncWorkEndNotification(notification: NSNotification) {
        print(">> Connected? ... ", FitCloudKit.connected())
        print(">> Sync Work End", notification.userInfo ?? "")
        print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
        
        self.syncStatus = true
    }
    @objc func getAllConfigResult() {
        print(">> Connected? ... ", FitCloudKit.connected())
        print(">> Got all config result ")
        print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
    }
    @objc func connectFailureNotification(notification: NSNotification) {
        print(">> Connected? ... ", FitCloudKit.connected())
        print(">> Failure in connection", notification.userInfo ?? "")
        print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
    }
    
    @objc func handleNotification(_ notification: Notification) {
        print(">> Connected? ... ", FitCloudKit.connected())
        print("Received notification: \(notification.name.rawValue)")
        print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
    }
    
    @objc func onFitCloudKitInitializeResult(notification: NSNotification){
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary;
        print(">> Connected? ... ", FitCloudKit.connected())
        print(">> UserInfo: \(userInfo)")
//        if userInfo.isKind(of: NSDictionary){
//            let isBound: Bool = userInfo
//        }
    }
    
    func connect() {
        FitCloudKit.translate(deviceToConnect!) { status, error, peripheral in
            if let peripheral = peripheral {
               FitCloudKit.connect(peripheral)
                print(">> Connected? ... ", FitCloudKit.connected())
                print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
                print(">> IS THE DEVICE BOUND ALREADY", FitCloudKit.userBindStatus(), FitCloudKit.alreadyBound())
            }
            print(status, error ?? "", peripheral ?? "")
        }
    }
    func getSportsData(){
        FitCloudKit.requestHealthAndSportsDataToday(){ status, userId, dataObject, error in
            if let healthData = dataObject {
                print(">> getData Connected? ... ", FitCloudKit.connected())
                print(">> IsDeviceReady ...", FitCloudKit.deviceReady())
                print(">> HEALTH Data for user \(String(describing: userId)), with status \(status): > ", healthData)
                
            }
            if error != nil {
                print(">> Error >", error ?? "")

            }
                    }
        
    }

    private func enterDFUMode(binStringFile: String?) {
        FitCloudKit.enterDFUMode { [weak self] status, peripheral, chipVendor, error in
            if status {
                guard let peripheral = peripheral, let firmware = binStringFile, let weakSelf = self else { return }
                if let manager = self?.dfuManager{
                    FitCloudDFUKit.setDelegate(manager)
                    FitCloudDFUKit.start(with: peripheral, firmware: firmware, chipVendor: .REALTEK, silentMode: true)
                }
                
                
            } else {
                print(">> Low battery")
            }
        }
    }
    func installWatchFace() {
        print(">> Connected? ... ", FitCloudKit.connected())
//        let wfModule = FitCloudWatchfaceModule()
//        let info = FitCloudKit.getWatchUIInformation(){ a,b,c in
//            print(">> abc :", a,b,c)
//        }
        if let imagePath = Bundle.main.path(forResource: "38124WF", ofType: "bin") {
            if FitCloudKit.isCurrentDFUMode() {
                FitCloudKit.exitDFUMode { [weak self] status, err in
                    guard let weakSelf = self else { return }
                    if status {
                        weakSelf.enterDFUMode(binStringFile: imagePath)
                    } else {
                        print("error")
                    }
                }
            } else {
                self.enterDFUMode(binStringFile: imagePath)
            }
//            if let image = UIImage(contentsOfFile: imagePath) {
//                // Now you can use the 'image' instance as needed
//                let imageView = UIImageView(image: image)
//                imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//
////                self.superview.addSubview(imageView)
//            } else {
//                print("Failed to create UIImage from file.")
//            }
            
        } else {
            print("Image file not found in the bundle.")
        }
        self.enterDFUMode(binFile: "\(String(describing: getWatchfaceDestinationPath()))")
        FitCloudKit.getWatchfaceUIInformation()
//        WATCHFACEMODULESTYLE
//       FitCloudKit.setWatchfacePostion(4, modules: [FitCloudWatchfaceModule]?)
        
    }
    func getWatchfaceDestinationPath() -> URL? {
        
        let fileManager  = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let watchfaceDirectory = documentsUrl.appendingPathComponent("Watchface")
        if !fileManager.fileExists(atPath: watchfaceDirectory.path) {
            do {
                try fileManager.createDirectory(atPath: watchfaceDirectory.path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print("Couldn't create document directory")
                return nil
            }
        }
        let destinationURL = watchfaceDirectory
        return destinationURL
    }
    
    func sync() {
//        FitCloudKit.manualSyncData(with: FITCLOUDDATASYNCOPTION.Type, progress: String){
//
//        }
//        FitCloudKit.syncWeather(<#T##weather: FitCloudWeatherObject##FitCloudWeatherObject#>);)
    }
    func unBindDevice(callback: @escaping responseAndErrorCallback) {
         FitCloudKit.unbindUserObject(true)
         callback(true, nil)
    }
    func isDeviceConnected() -> Bool {
        return FitCloudKit.connected() && FitCloudKit.alreadyBound()
    }
    
    func getHistoryPeripherals() -> [FitCloudKitConnectRecord] {
        return FitCloudKit.historyPeripherals()
    }
    
    func removeDevice(callback: @escaping (_ status: Bool) -> ()) {
        FitCloudKit.unbindUserObject(true)
        let oldPeripherals: [FitCloudKitConnectRecord] = self.getHistoryPeripherals()
        if oldPeripherals.count > 0 {
            FitCloudKit.removePeripheralHistory(withUUID: (oldPeripherals.last?.uuid.uuidString)!)
        }
//        FitCloudKit.disconnect()
        callback(true)
    }
    func enterDFUMode (binFile:String?) {
        FitCloudKit.enterDFUMode(){ [weak self] succeed, peripheral, vendor, error in
            print(">> IN DFU succeed: \(succeed), peripheral: \(String(describing: peripheral)), vendor: \(vendor), error: \(String(describing: error ?? nil))")
            if error == nil {
                guard let peripheral = peripheral, let firmware = binFile, let _ = self else { return }
                FitCloudDFUKit.start(with: peripheral, firmware: firmware, chipVendor: .REALTEK, silentMode: true)
            }
//            if FitCloudKit.allConfig()?.firmware.hardwareSupported {
//                print(">> Hardware supports")
//            }
        }
    }
    func exitDFUMode(){
        FitCloudKit.exitDFUMode(){ status, error  in
//            guard let weakSelf = self else {return}
            print(">> EXIT STATUS : \(status), error: \(String(describing: error))")
        }
    }
}

class DFUManager :NSObject {
    weak var manager : Manager?
    init(manager: Manager) {
        self.manager = manager
    }
}

extension DFUManager: FitCloudDFUDelegate {
    func onStartDFUSuccess() {
        print(">> onStartDFUSuccess")
    }
    func onDFUFinish(withSpeed speed: CGFloat) {
        print(">> onDFUFinish with speed:", speed)
    }
    func onDFUProgress(_ progress: CGFloat, imageIndex index: Int, total: Int) {
        print(">> onDFUProgress progress: \(progress), imageIndex: \(index), total: \(total)")
    }
    func onStartDFUFailureWithError(_ error: Error) {
        print(">> onStartDFUFailureWithError : ", error)
    }
    func onAbortWithError(_ error: Error) {
        print(">> onAbortWithError: ", error)
    }
    
}

extension Manager: FitCloudCallback {
    func onLogMessage(_ message: String, level: FITCLOUDKITLOGLEVEL) {
        print("FitCloudCallback: Message: \(message) Level: \(level.rawValue)")
//        BandUtility.logger(event: message, level: .TopSteps, type: .INFO)
    }

    func onFindiPhoneEvent() {
        print("Find phone event")
        self.findPhoneNotificationBlock?(true)
    }
}




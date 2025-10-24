//
//  ViewController.swift
//  TopStepsSDKDemo
//
//  Created by Asif Habib on 07/10/23.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!

  
    @IBOutlet weak var searchBar: UISearchBar!
    var cbCentralMenager : CBCentralManager!
    var directoryManager = UserLogs.sharedDirectory
    var peripherals = [CBPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cbCentralMenager = CBCentralManager.init(delegate: self, queue: nil)
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        directoryManager.createLogDirectory()
        directoryManager.addTxtFileForUserInfo()
        tableView.register(DeviceCell.self, forCellReuseIdentifier: "DeviceCell")
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
                    // Perform search with searchText
                    print("Performing search with text: \(searchText)")
            self.peripherals = self.peripherals.filter({ peripheral in
                peripheral.name?.contains(searchText) == true
            })
            tableView.reloadData()
                }
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPeripheral = self.peripherals[indexPath.row]
        print(">> Trying to connect to \(selectedPeripheral.name ?? "No name")")
        TopSteps.manager.connect(peripheral: selectedPeripheral)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DeviceCell") as? DeviceCell else {
            return UITableViewCell() // Return a default cell or handle the error appropriately
        }

        cell.setLabel(label: self.peripherals[indexPath.row].name ?? "Noname")

        return cell
    }
    
    
}


extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        if central.state == .poweredOn {
//            central.scanForPeripherals(withServices: nil)
//            print("Scanning ... ")
//        }
        switch central.state {
                case .poweredOn:
                    // Bluetooth is powered on, you can start scanning for peripherals
                    central.scanForPeripherals(withServices: nil)
                    print("Scanning ... ")
                    break
                case .poweredOff:
                    // Bluetooth is powered off
                    print("Bluetooth is powered off")
                    break
                case .resetting:
                    print("resetting ... ")
                    break
                case .unauthorized:
                    // The app is not authorized to use Bluetooth
                    print("Not authorized to used BT")
                    break
                case .unsupported:
                    // Bluetooth is unsupported on this device
                    print("BT not supported.")
                    break
                case .unknown:
                    // Bluetooth state is unknown
                    print("Unknown state")
                    break
                @unknown default:
                    print("Unknown state")
                    // Handle future cases
                    break
                }
                print("Changed state")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        print(">>>>>>>> ", peripheral, advertisementData, RSSI, "<<<<<<")
        if !self.peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
        }
        

        tableView.reloadData()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnect", peripheral)
        print("scanned peripherals: ", self.peripherals)
//        peripheral.delegate = self
//        peripheral.discoverServices(nil)
        
    }
}

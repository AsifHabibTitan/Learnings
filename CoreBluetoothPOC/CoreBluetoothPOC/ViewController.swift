//
//  ViewController.swift
//  CoreBluetoothPOC
//
//  Created by Asif Habib on 11/08/23.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var cbCentralMenager : CBCentralManager!
    var peripherals = [CBPeripheral]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PeripheralCell.self, forCellReuseIdentifier: "PeripheralCell")
        self.cbCentralMenager = CBCentralManager.init(delegate: self, queue: nil)
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
        self.peripherals.append(peripheral)
//        if peripheral.name == "FT_38096_EAC4" {
//            print("stopping scan with peripheral: ", peripheral)
////            central.stopScan()
////            central.connect(peripheral)
//        }
        tableView.reloadData()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnect", peripheral)
        print("scanned peripherals: ", self.peripherals)
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
    }
    
    
}

extension ViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(peripheral.services)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row at : ", indexPath.row)
        print(self.peripherals[indexPath.row])
        cbCentralMenager.connect(self.peripherals[indexPath.row])
        cbCentralMenager.stopScan()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: ", self.peripherals.count)
        return self.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeripheralCell") as! UITableViewCell
        cell.tintColor = .black
//        cell.button?.titleLabel?.text = "self.peripherals[indexPath.row].name"
        let peripheralAtIndex = self.peripherals[indexPath.row]
        cell.textLabel?.text = peripheralAtIndex.name ?? peripheralAtIndex.identifier.uuidString
        return cell
    }
    
    
}

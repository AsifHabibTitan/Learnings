import UIKit
import RealmSwift
import Security

class ViewController2: UIViewController {
    var stressData = [Stress]()
    var spo2Data = [SpO2]()
    var bpData = [BloodPressure]()
    var heartRateData = [HeartRate]()
    var stepsData = [Steps]()
    var generatedData = Data()
    var realm : Realm?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("loading 2nd vc")
        
//        var config = Realm.Configuration(
//            fileURL: URL(filePath: "/Users/AsifHabib/Documents/custom.realm"),
////            encryptionKey: Data(count: 64)
//            schemaVersion: 1
//        )
        
        self.realm = try! Realm()
        
        
  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.realm?.invalidate()
    }
    
    @IBAction func generateButton(_ sender: UIButton) {
        let data = Data()
        data.bpData = generateBPData()
        data.hrData = generateHRData()
        data.spo2Data = generateSpO2Data()
        data.stepsData = generateStepsData()
        data.stressData = generateStressData()
        
        
//        let hrData = generateData2(interval: 5, start: 50, end: 150)
//        let stepsData = generateData2(interval: 30, start: 100, end: 1000)
//        let spo2Data = generateData2(interval: 60, start: 80, end: 100)
//        let bpData = generateData2(interval: 60, start: 80, end: 120)
//        let stressData = generateData2(interval: 10, start: 40, end: 100)

        self.generatedData = data
        print(self.generatedData)
    }
    @IBAction func storeButton(_ sender: UIButton) {
        do{
            try self.realm?.write{
                realm?.add(self.generatedData)
                print("added the object \(self.generatedData)")
            }
        } catch {
            print(error)
        }
        
        
    }
    @IBAction func FetchButton(_ sender: UIButton) {
        var data = try self.realm?.objects(Data.self)
        print("read data as : \(data)")
        
    }
    func generateData2(interval: TimeInterval, start:Int, end: Int) -> List<Category> {
//        var interval: Double = 60 // in minutes
        let startOfDay = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        var timestamp = startOfDay
        let currentTime = Date().timeIntervalSince1970
        
        let data = List<Category>()
        
        
        // for Spo2
        while timestamp <= currentTime {
            // generate individual object
            let newCategory = Category()
            newCategory.time = timestamp
            newCategory.value = Methods.getRandomNumber(start, end)
            data.append(newCategory)
            
            timestamp += interval * 60.0
        }
        return data
    }
    func generateSpO2Data() -> List<SpO2> {
        let interval: Double = 60 // in minutes
        let startOfDay = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        var timestamp = startOfDay
        let currentTime = Date().timeIntervalSince1970
        
        let spo2Data = List<SpO2>()
        
        // for Spo2
        while timestamp <= currentTime {
            // generate individual object
            let data = SpO2()
            data.spo2 = Methods.getRandomNumber(80, 100)
            data.time = timestamp
            spo2Data.append(data)
            
            timestamp += interval * 60.0
        }
        return spo2Data
    }
        
    private func generateHRData() -> List<HeartRate> {

        var timestamp = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        let interval: Double = 5
        let currentTime = Date().timeIntervalSince1970
        let heartRateData = List<HeartRate>()
        while timestamp <= currentTime {
            // generate individual object
            let data = HeartRate()
            data.time = timestamp
            data.heartRate = Methods.getRandomNumber(50, 150)
            heartRateData.append(data)
            timestamp += interval * 60.0
        }
        return heartRateData
    }
    private func generateStepsData() -> List<Steps> {
        
        var timestamp = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        let interval: Double = 30
        let currentTime = Date().timeIntervalSince1970
        let stepsData = List<Steps>()
        while timestamp <= currentTime {
            // generate individual object
            let data = Steps()
            data.time = timestamp
            data.steps = Methods.getRandomNumber(100, 1000)
            stepsData.append(data)
            timestamp += interval * 60.0
        }
        return stepsData
    }
    
    private func generateBPData() -> List<BloodPressure> {
        
        var timestamp = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        let interval: Double = 60
        let currentTime = Date().timeIntervalSince1970
        let bpData = List<BloodPressure>()
        while timestamp <= currentTime {
            // generate individual object
            let data = BloodPressure()
            data.time = timestamp
            data.systolic = Methods.getRandomNumber(80, 120)
            data.diastolic = Methods.getRandomNumber(80, 120)
            bpData.append(data)
            timestamp += interval * 60.0
        }
        return bpData
    }
    
    private func generateStressData() -> List<Stress> {
        
        var timestamp = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        let interval: Double = 10
        let currentTime = Date().timeIntervalSince1970
        let stressData = List<Stress>()
        while timestamp <= currentTime {
            // generate individual object
            let data = Stress()
            data.time = timestamp
            data.stress = Methods.getRandomNumber(40, 100)
            stressData.append(data)
            timestamp += interval * 60.0
        }
        return stressData
    }
    
    
        
}



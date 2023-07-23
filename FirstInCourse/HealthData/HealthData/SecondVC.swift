//
//  SecondVC.swift
//  HealthData
//
//  Created by Asif Habib on 30/06/23.
//

import Foundation
import UIKit

struct HealthRecord : Codable {
    let name: String
    let team: String
    let heart_rate: Int
    let stress : Int
    let spo2: Int
    
}
struct TableData: Decodable {
    let rows: [HealthRecord]
}

enum Criteria: String{
    case heart_rate, spo2, stress
}
enum Team: String{
    case Dev, QA, Cloud
}
enum Qntt: String{
    case Min, Max
}



class SecondVC: UIViewController {
    
    var rows : [HealthRecord] = []
    var filteredRows : [HealthRecord] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Filterbyvalue: UITextField!
    @IBOutlet weak var TeamOutlet: UISegmentedControl!
    @IBOutlet weak var Average: UILabel!
    @IBOutlet weak var CriteriaOutlet: UISegmentedControl!
    @IBOutlet weak var MinMax: UISegmentedControl!
    @IBOutlet weak var AvgLabel: UILabel!
    
    @IBAction func resetFilters(_ sender: Any) {
        unselectSegmentedControls()
        self.filteredRows = self.rows
        Average.text = ""
        showOrHideAvg()
        Filterbyvalue.text = ""
        tableView.reloadData()
    }
    fileprivate func unselectSegmentedControls() {
        TeamOutlet.selectedSegmentIndex = UISegmentedControl.noSegment
        CriteriaOutlet.selectedSegmentIndex = UISegmentedControl.noSegment
        MinMax.selectedSegmentIndex = UISegmentedControl.noSegment
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "FirstRowCell")
        tableView.dataSource = self
        tableView.delegate = self

        guard let jsonFileUrl = Bundle.main.url(forResource: "EmpData", withExtension: "json") else {
            return
        }
        
        guard let jsonData = try? Data(contentsOf: jsonFileUrl) else {
            print("json file not found")
            return
        }
        
        do{
            rows = try JSONDecoder().decode([HealthRecord].self, from: jsonData)
            filteredRows = rows
        } catch {
            print("Got an error \(error)")
        }
        
//        print(rows)
        unselectSegmentedControls()
        print(">>>>>>>>", CriteriaOutlet.selectedSegmentIndex)
        var crit : Criteria? = nil
        updateCriteria(CriteriaOutlet.selectedSegmentIndex, &crit)
        
        if let criteriaValue = crit {
            Average.text = String(getAvg(arr: getValuesArrayFromObjects(rows: self.rows, criteria: criteriaValue)))
        } else {
            Average.text = ""
            showOrHideAvg()
//            AvgLabel.isHidden = true
        }
        
        
        
        
        
    }
    
    func getCriteria(c: Criteria, row: HealthRecord) -> Int {
        switch c {
        case .heart_rate:
            return row.heart_rate
        case .stress:
            return row.stress
        case .spo2:
            return row.spo2
            
        }
    }

    func getMinimumValue(c:Criteria, rows: [HealthRecord]) -> Int {
        switch c {
        case .heart_rate:
            return rows.min(by: {$0.heart_rate < $1.heart_rate})?.heart_rate ?? rows[0].heart_rate
        case .stress:
            return rows.min(by: {$0.stress < $1.stress})?.stress ?? rows[0].stress
        case .spo2:
            return rows.min(by: {$0.spo2 < $1.spo2})?.spo2 ?? rows[0].spo2
       
        }
    }
    func getMaxValue(c:Criteria, rows: [HealthRecord]) -> Int {
        switch c {
        case .heart_rate:
            return rows.min(by: {$0.heart_rate > $1.heart_rate})?.heart_rate ?? rows[0].heart_rate
        case .stress:
            return rows.min(by: {$0.stress > $1.stress})?.stress ?? rows[0].stress
        case .spo2:
            return rows.min(by: {$0.spo2 > $1.spo2})?.spo2 ?? rows[0].spo2
        }
    }

    func applyValueFilter(rows: [HealthRecord], criteria: Criteria, filterValue: Int) -> [HealthRecord] {
//        print("in value filter", rows, criteria, filterValue)
        if filterValue == -1 {
            return rows
        }
        return rows.filter({
            getCriteria(c: criteria, row: $0) == filterValue
        })
    }
    func applyTeamFilter(rows:[HealthRecord], team:Team?) -> [HealthRecord]{
        if let teamValue = team {
            return rows.filter({
                $0.team == teamValue.rawValue
            })
        } else {
            return rows
        }
        
    }
  
    fileprivate func updateCriteria(_ criteriaIndex: Int, _ criteria: inout Criteria?) {
        switch criteriaIndex {
        case 0:
            criteria = Criteria.heart_rate
        case 1:
            criteria = Criteria.spo2
        case 2:
            criteria = Criteria.stress
        default:
            criteria = nil
        }
    }
    
    fileprivate func updateTeam(_ teamIndex: Int, _ team: inout Team?) {
        switch teamIndex {
        case 0:
            team = Team.Dev
        case 1:
            team = Team.QA
        case 2:
            team = Team.Cloud
        default:
            team = nil
        }
    }
    
    fileprivate func updateMinMaxValues(_ minMaxIndex: Int, _ qntt: inout Qntt?) {
        switch minMaxIndex {
        case 0 :
            qntt = Qntt.Min
        case 1:
            qntt = Qntt.Max
        default:
            qntt = nil
            
        }
    }
    
    fileprivate func getValuesArrayFromObjects(rows: [HealthRecord], criteria: Criteria) -> [Int]{
        switch criteria {
            
        case Criteria.heart_rate:
            return rows.map({$0.heart_rate})
        case Criteria.spo2:
            return rows.map({$0.spo2})
        case Criteria.stress:
            return rows.map({$0.stress})
        }
    
    }
    
    fileprivate func getAvg(arr: [Int]) -> Double {
        if arr.count < 1 {
            return 0
        }
        let sum = Double(arr.reduce(0, +))
        return sum/Double(arr.count)
    }
    fileprivate func showOrHideAvg(){
        if Average.text != ""{
            AvgLabel.isHidden = false
        } else {
            AvgLabel.isHidden = true
        }
    }
    
    @IBAction func filter(_ sender: Any) {
        self.filteredRows = rows
        let criteriaIndex = CriteriaOutlet.selectedSegmentIndex
        let teamIndex = TeamOutlet.selectedSegmentIndex
        let minMaxIndex = MinMax.selectedSegmentIndex
//        print("index before selection", criteriaIndex, teamIndex, minMaxIndex)
        var criteria: Criteria?
        var team: Team?
        var qntt: Qntt?
        
        updateCriteria(criteriaIndex, &criteria)
        
        updateTeam(teamIndex, &team)
        
        updateMinMaxValues(minMaxIndex, &qntt)
        
        
        if let filterValue = Filterbyvalue.text {
//            print("value : \(filterValue)")
            
            
            if filterValue == "" {
//                print("value of filters", qntt, criteria)
                
                self.filteredRows = applyTeamFilter(rows: self.filteredRows, team: team)
                if let criteriaValue = criteria {
                    self.filteredRows = applyValueFilter(rows: self.filteredRows, criteria: criteriaValue, filterValue: qntt == Qntt.Min ? getMinimumValue(c: criteriaValue, rows: self.filteredRows): qntt == Qntt.Max ? getMaxValue(c: criteriaValue, rows: self.filteredRows): -1)
                }
                
                
            } else {
                if let criteriaValue = criteria {
                    self.filteredRows = applyValueFilter(rows: self.filteredRows, criteria: criteriaValue, filterValue: Int(filterValue) ?? 0)
                }
                
                self.filteredRows = applyTeamFilter(rows: self.filteredRows, team: team)
            }
        }
        if let criteriaValue = criteria {
            Average.text = String(getAvg(arr: getValuesArrayFromObjects(rows: self.filteredRows, criteria: criteriaValue)))
        }
        showOrHideAvg()
        
        tableView.reloadData()
        
    }
}

extension SecondVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstRowCell", for: indexPath) as! CustomCell

        cell.heartRate.text = "\(filteredRows[indexPath.row].heart_rate)"
        cell.name.text = "\(filteredRows[indexPath.row].name)"
        cell.spo2.text = "\(filteredRows[indexPath.row].spo2)"
        cell.stress.text = "\(filteredRows[indexPath.row].stress)"
        return cell
    }
}

extension SecondVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

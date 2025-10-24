import Foundation

let MAC_PATH = "/Users/AsifHabib/Documents/remote_config"
let WINDOWS_PATH = "D:/Projects/remote_config"

func getPath() -> String {
    return MAC_PATH
}

//let outputFile = URL(fileURLWithPath: getPath()).appendingPathComponent("output.json")
let outputFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("output.json")
let parametersGroup: [String: String] = [
    "Smart World": "\(getPath())/Product_team/smart_world",
    "Multi Sport": "\(getPath())/Product_team/multi_sport"
]

let pathMapping: [String: (String, String)] = [
    "current_version_config.json": ("current_version", "NUMBER"),
    "privilege_access_default_value.json": ("privilege_access", "JSON"),
    "multi_sport_config_default_value.json": ("multi_sport_config", "JSON"),
    "smart_notification_config_default_value.json": ("smart_notification_config", "JSON"),
    "supported_products_default_value.json": ("supported_products", "JSON"),
    "countries_default_value.json": ("countries", "JSON"),
    "supported_features_default_value.json": ("supported_features", "JSON"),
    "app_config_default_value.json": ("app_config", "JSON"),
    "watchface_config_default_value.json": ("watchface_config", "JSON"),
    "multi_sport_category_config_default_value.json": ("multi_sport_category_config", "JSON"),
    "google_fit_config_default_value.json": ("google_fit_config", "JSON"),
    "url_config_default_value.json": ("url_config", "JSON"),
    "live_chat_default_value.json": ("live_chat_config", "JSON"),
    "otp_less_config_default_value.json": ("otp_less_config", "JSON"),
    "quick_reply_default_value.json": ("quick_reply_config", "JSON"),
    "full_page_campaign_default_value.json": ("full_page_campaign_config", "JSON")
]

func main() {
    var parametersMap = [String: Parameters]()
    for (key, value) in parametersGroup {
        var parameterMap = [String: Parameter]()
        let folder = URL(fileURLWithPath: value)
        if let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: []) {
            for file in files where file.pathExtension.lowercased() == "json" {
                if let content = try? String(contentsOf: file, encoding: .utf8) {
                    if let type = pathMapping[file.lastPathComponent] {
                        if type.1 == "JSON" {
                            if !isJSONValid(testString: content).0 {
                                print("Invalid JSON File: \(file.path) \nErrorMessage: \(isJSONValid(testString: content).1)")
                            }
                        }
                        parameterMap[type.0] = Parameter(defaultValue: DefaultValue(value: content), valueType: type.1)
                    } else {
                        parameterMap[file.deletingPathExtension().lastPathComponent] = Parameter(defaultValue: DefaultValue(value: content), valueType: "JSON")
                    }
                }
            }
        }
        parametersMap[key] = Parameters(parameters: parameterMap)
    }
    let output = try? JSONEncoder().encode(RemoteConfig(parameterGroups: parametersMap))
    if let jsonData = output, let jsonString = String(data: jsonData, encoding: .utf8) {
        writeContent(content: jsonString)
    }
}

func writeContent(content: String) {
    do {
        try content.write(to: outputFile, atomically: true, encoding: .utf8)
    } catch {
        print(error.localizedDescription)
    }
}

func isJSONValid(testString: String?) -> (Bool, String) {
    guard let testString = testString else { return (false, "Test string is nil") }
    if let _ = try? JSONSerialization.jsonObject(with: Data(testString.utf8), options: []) {
        return (true, "")
    } else {
        return (false, "Invalid JSON")
    }
}

struct RemoteConfig: Codable {
    let parameterGroups: [String: Parameters]
}

struct Parameters: Codable {
    let parameters: [String: Parameter]
}

struct DefaultValue: Codable {
    var value: String
}

struct Parameter: Codable {
    var defaultValue: DefaultValue
    var valueType: String
}

main()

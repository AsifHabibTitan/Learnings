import os
import json

MAC_PATH = "/Users/AsifHabib/Documents/remote_config"

def get_path():
    return MAC_PATH

output_file = os.path.join(get_path(), "output.json")

parameters_group = {
    "Smart World": os.path.join(get_path(), "Product_team", "smart_world"),
    "Multi Sport": os.path.join(get_path(), "Product_team", "multi_sport")
}

path_mapping = {
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
}

def main():
    parameters_map = {}
    for key, value in parameters_group.items():
        parameter_map = {}
        if os.path.isdir(value):
            for filename in os.listdir(value):
                if filename.endswith(".json"):
                    filepath = os.path.join(value, filename)
                    with open(filepath, 'r', encoding='utf-8') as file:
                        content = file.read()
                        type = path_mapping.get(filename)
                        if type is None or type[1] == "JSON":
                            is_valid, error_message = is_json_valid(content)
                            if not is_valid:
                                print(f"Invalid JSON File: {filepath} \nErrorMessage: {error_message}")
                        if type:
                            parameter_map[type[0]] = {"defaultValue": {"value": content}, "valueType": type[1]}
                        else:
                            parameter_map[os.path.splitext(filename)[0]] = {"defaultValue": {"value": content}, "valueType": "JSON"}
        parameters_map[key] = {"parameters": parameter_map}

    remote_config = {"parameterGroups": parameters_map}
    output = json.dumps(remote_config, indent=4)
    write_content(output)

def write_content(content):
    try:
        with open(output_file, 'w', encoding='utf-8') as file:
            file.write(content)
            print(f"Output written to {output_file}")
    except IOError as e:
        print(f"Error writing file: {e}")

def is_json_valid(test_string):
    try:
        json.loads(test_string)
    except json.JSONDecodeError as ex:
        return False, str(ex)
    return True, ""

if __name__ == "__main__":
    main()


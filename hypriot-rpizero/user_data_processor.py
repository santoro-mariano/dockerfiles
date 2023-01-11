import json


def main():
    with open("info.json") as info:
        data = json.load(info)

    with open("user-data.template") as template:
        template_text = template.read()

        f = template_text.replace("{HOST}", data["host"])
        f = f.replace("{USER}", data["user"])
        f = f.replace("{USER_PWD}", data["user-pwd"])
        f = f.replace("{LOCALE}", data["locale"])
        f = f.replace("{TIMEZONE}", data["timezone"])
        f = f.replace("{COUNTRY}", data["country"])
        f = f.replace("{WIFI_SSID}", data["wifi-ssid"])
        f = f.replace("{WIFI_PSW}", data["wifi-psw"])

    with open("user-data", "w+") as final_file:
        final_file.write(f)


if __name__ == '__main__':
    main()

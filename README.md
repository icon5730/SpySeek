A Bash script designed to automate the process of anonymously connecting to a third party server to perform reconnaissance against a target.

The script performs the following operations:
- Checks to make sure all tools are installed. If a tool is missing, the script attempts to install it.
- Connects to the Tor network and makes sure you're anonymous. If anonymity was achieved, the script lets the user know, and displays the spoofed IP address and associated country. If anonymity failed, the script alerts the user and retries connecting to the Tor network.
- Asks the user for the third party server IP address, login username, password and target IP address/Domain Name.
- Tries to connect to the third party server. If the connection is successful, the script aletrs the user and preforms a 'Whois' test as well as an nmap scan on the target. If it fails, the script alerts the user and asks them to retype the third party server info.
- All scans are dated and logged in a designated scanlog.txt file.
- All scanning data is saved in a .txt file named after the chosen target for convenience.

Notes:
Success of the tool installation segment may vary depending on the type of Linux Distro being used.

<b>Full Script Run:</b>

![1](https://github.com/user-attachments/assets/bc06567f-0439-46ed-b2a0-0af0a2e17cef)
![2](https://github.com/user-attachments/assets/7b85f25d-b097-4e18-8897-bfa6b4095d29)

<b>Full Log and Data:</b>

![3](https://github.com/user-attachments/assets/8e5a2522-07c0-4beb-b0fc-6fbe9618b97d)
![4](https://github.com/user-attachments/assets/26d4396f-e7e7-4bbe-b122-feed37663add)

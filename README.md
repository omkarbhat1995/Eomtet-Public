This is just the ReadME document for the actual private repository as the original repository has exploits to gain certain certificates to gain access to the networks. Along with exploits to gain access to admin for Windows and Linux.

Emotet Recreation 
====================
A very simple, fast, multi-threaded HTTPS server and client.
## Overview:
This project is to build a Botnet that uses SSL for communication and has a single as well as multi-server support.

The protocol for a single server is as follows:
1. The client(host) contacts the server to let the server know that it is activated and also provides a client id that will be used to uniquely identify the client to the server.
2. Server checks if the client is already present and if it's server proceeds to Step 4. If this client is new, it goes to Step 3.
3. Server checks if the said client has been sent a copy of the malware, if not then sends a copy of the malware and updates this information in its records.
4. Once the client has been sent the malware server waits for updates from the clients.
5. The server receives updates from the clients in order and stores all the files in a directory named *'files'*. The client goes to sleep after sending the update and then contacts the server again, so goes back to Step 1.


The protocol for multi-server is as follows:
1. The client (host) contacts the server to let the server know that it is activated and also provides a client id that will be used to uniquely identify the client to the server.
2. Server checks if the client is already present and if it is server proceeds to Step 5. If this client is new, it goes to Step 3.
3. Server checks if the new client is a handed off server or a completely new one. If it's handed off then it goes to Step 4. If the client is completely new then it hands it off to another server and then it goes to Step 1.
4. Server checks if the said client has been sent a copy of the malware, if not then sends a copy of the malware and updates this information in its records.
5. Once the client has been sent the malware server waits for updates from the clients.
6. The server receives updates from the clients in order and stores all the files in a directory named *'files'*. The client goes to sleep after sending the update and then contacts the server again, so goes back to Step 1.


Language: C++, Python
###  Versions:
- Version 0   :  C++ Server and Client Bot-Net (Star Topology)
- Version 1   :  Python Basic Botnet with Setup (Star Topology)
- Version 2   :  Python Botnet with Basic Communication (Star Topology)
- Version 3   :  Python Botnet in which server sends over the exe file and then waits and receives the updates from clients (Star Topology)
- Version 4   :  Python Botnet in which server sends over the exe file and then waits and receives the updates from clients (parallelised) (Star Topology)
- Version 1-multiserver   :  Python Botnet with multi-server, server sends a file and then waits for updates
- Version 2-multiserver   :  Python Botnet with multi-server, server sends a file and then waits for updates (parallelized)
- Version 3-multiserver   :  Python Botnet with Test Case and Shell scripts.


### Usage:
Execute *client.py* and *server.py*.To run multiple servers make sure to run the server on different IPs and then list them in the *server.py* file.

To test the setup follow the directions given below:
1. Run shell script for the Server named '_server.sh_' and then enter the Server's IP
2. Run shell script for Clients named '_client.sh_' and then enter a list of Server IPs
3. Once both scripts have completed execution, run the test written in python named 'test_client_server.py'.
To modify the test parameters take a look at the shell scripts and then modify as needed.


### Arguments:
SERVER:

`python3 server.py --host ip --port pt --serfile file_size  --acpttime time --test flag --testduration duration`
* ip : Server IP
* pt : Server Port
* file_size : Size of the file server sends to the client [in kB]
* time : Time to Accept Connections [in seconds]
* flag : Test flag: *True* if testing the program else *False*
* duration : The time for which the program is going to run during testing [in seconds]

CLIENT:

`python3 client.py --host ip --port pt --updatesize file_size --varfile var --beacontime time --test flag --testduration duration`
* ip : Server IP
* pt : Server Port
* file_size : Size of the update files sent by client [in kB]
* var : Deviation in the file size [in kB]
* time : Beaconing time [in seconds]
* flag : Test flag: *True* if testing the program else *False*
* duration : The time for which the program is going to run during testing [in seconds]

### Information Maintained by Server about Client(Host)

| **Field** | **Information** |
| ------ | ------ |
| localID | Client ID |
|Connections|Connection object for the client  |
|ClientIP| Client's IP address|
|ClientPort| Client's Port|
|Username| Clients's Username|
|Platform| Client's OS / Platform|
|FileSent| Check if the malware file is sent to client|
|Update_Number| Number of updates that are sent by the client|
|Last_Update_Time|Last Time when update was received|

### Certificate Generation:
Certificates are used for setting up the SSL communication. 
Use the certificate generation script, to get *server.key*, *client.key*, *server.crt* and *client.crt*.
The script is in the botnet directory. 
After Certificates are generated follow these steps:
1. Copy *client.crt*, *server.crt* & *server.key* to server directory.
2. Copy *client.crt*, *server.crt* & *client.key* to client directory.

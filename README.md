# Arcan Trial

## Requirements
- Docker and Docker Compose (See: https://docs.docker.com/engine/install/)

## How to run Arcan locally
First, clone or [download](https://github.com/Arcan-Tech/arcan-trial/archive/refs/heads/main.zip) this repository (`/arcan-trial` folder). Then, follow the instructions below.

### Obtain the licence file
- Fill in this [form](https://www.arcan.tech/on-premise-trial/). You will receive the license at the provided email address.
- Open the email and download the attached `ArcanLicence_YYYYMMDD` licence file.
- Copy the `ArcanLicence_YYYYMMDD` licence file to the [licences](./licences) directory.

### Configure the environment
- Copy the content of the [.env.example](./.env.example) file into a new file named `.env`.
- Change the value of the variable `ARCAN_LICENCE_FILENAME` with the name of licence file you copied in the [licences](./licences) directory.

### Run Arcan
- To run the Arcan dashboard and the server, open your favourite terminal and navigate to the `/arcan-trial` folder. Within the folder execute: `docker compose up`.
- You will find the dashboard at [http://localhost:3000](http://localhost:3000).
- To analyse a *remote* project, simply use the remote repo url when creating a new project. If the repo is private, remember to use a personal access token as password (see the [documentation](./documentation) for more info).
- To analyse a *local* project, copy the project folder into `/arcan-trial/projects`. When creating a new project, specify the path to analyse as follows: `./projects/<folder_name>`  (see the [documentation](./documentation) for more info).


#### Optional

Should you need to update to the latest Arcan version:
- Open the `.env` file. Change the value of the variable `ARCAN_DASHBOARD_VERSION` with the latest Arcan dashboard version tag. You can find the latest version [here](https://github.com/Arcan-Tech/arcan-2/pkgs/container/arcan-dashboard-trial).
- Change the value of the variable `ARCAN_SERVER_VERSION` with the latest Arcan server version tag. You can find the latest version [here](https://github.com/Arcan-Tech/arcan-2/pkgs/container/arcan-server-trial).

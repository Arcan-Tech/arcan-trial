# Arcan Trial

## Requirements
- Docker and Docker Compose (See: https://docs.docker.com/engine/install/)

## How to run Arcan locally
First, clone or download this repository. Then, follow the instruction below.

### Obtain the licence file
- Fill in the form at: [https://www.arcan.tech](https://www.arcan.tech). You will receive the license at the provided email address.
- Download the attached `ArcanLicence_YYYYMMDD` licence file.
- Copy the `ArcanLicence_YYYYMMDD` licence file to the [licences](./licences) directory.

### Configure the environment
- Copy the content of the [.env.example](./.env.example) file into a new file named `.env`.
- Open the `.env` file. Change the value of the variable `ARCAN_DASHBOARD_VERSION` with the latest Arcan dashboard version tag. You can find the latest version [here](https://github.com/Arcan-Tech/arcan-2/pkgs/container/arcan-dashboard-trial).
- Change the value of the variable `ARCAN_SERVER_VERSION` with the latest Arcan server version tag. You can find the latest version [here](https://github.com/Arcan-Tech/arcan-2/pkgs/container/arcan-server-trial).
- Change the value of the variable `ARCAN_LICENCE_FILENAME` with the name of licence file you copied in the [licences](./licences) directory.

### Run Arcan
- To run the Arcan dashboard and the server, open your favourite terminal and execute: `docker compose up`
- You will find the dashboard at [https://localhost:3000](https://localhost:3000)

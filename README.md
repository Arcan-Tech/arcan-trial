# Arcan Trial

## Requirements
- Docker and Docker Compose (See: https://docs.docker.com/engine/install/)

## How to run Arcan locally
First, clone or download this repository. Then, follow the instruction below.

### Obtain the licence file
- Fill in the form at: [https://www.arcan.tech](https://www.arcan.tech)
- Download the attached `ArcanLicence_YYYYMMDD` licence file received to the provided email address
- Copy the `ArcanLicence_YYYYMMDD` licence file to the [licences](./licences) directory

### Configure the environment
- Copy the [.env.example](./.env.example) file to a new file named `.env`
- Change the value of the variable `ARCAN_DASHBOARD_VERSION` (See available versions [here](https://github.com/Arcan-Tech/arcan-2/pkgs/container/arcan-dashboard-trial))
- Change the value of the variable `ARCAN_SERVER_VERSION` (See available versions [here](https://github.com/Arcan-Tech/arcan-2/pkgs/container/arcan-server-trial))
- Change the value of the variable `ARCAN_LICENCE_FILENAME` with the name of licence file you copied in the [licences](./licences) directory

### Run Arcan
- Run the Arcan dashboard and the server: `docker compose up`
- Visit the dashboard at [https://localhost:8080](https://localhost:8080)
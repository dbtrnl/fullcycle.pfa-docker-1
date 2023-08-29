## fullcycle.pfa-docker-1

PFA Docker's Challenge 1 from Full Cycle course.

A simple NodeJS application accessing a MySQL database, all behind an Nginx reverse proxy.
Everything is provisioned using Docker + Bash instead of Docker Compose, and works in a similar way.

---

How to run:
- In the project root `fullcycle.pfa-docker-1`:
Run `$ bash start.sh` to start containers and a local docker network. Error or success messages are shown.

- After that, the /GET endpoint should be accessible at `localhost:8888/fc_modules`, and returns a simple list of courses.

- Run `$ bash stop.sh` to stop the services, remove the docker containers and delete the images generated locally, doing a complete cleanup.

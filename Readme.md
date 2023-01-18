# Barber-shop Infrastructure provisioning

## Introduction

this repository contains the terraform micro-stacks for the provisioning of the kubernetes cluster responsible for the deployment of Barber shop API

## Micro-Stucks explaination

* **Kubernetes provisioning**: This micro-stack is responsible for deploying a kubernetes cluster to azure using azure kubernetes service

* **third party services installation**: the purpose behind this micro-stack is the installation of different third party dependecies in the cluster using helm that are:
    * **Prometheus-Server**
    * **Grafana-Server**
    * **Datadog-Agent**

* **DataBase installation**: this stuck creates a persistance volume and a persistance volume claim and then installs postgres using helm and append the PVC to the postgres pods

* **Application stack**: this stack is responsible for installing with helm the barbershop application helm charts

## Barbershop Application Architecture

![barbershop kubernetes architecture](./assets/Kubernetes%20Architecture.drawio.png)

## Disclaimers

* Since no github secretes were used for the moment the user of this repository is requiered to specify terraform.tfvars file to set values in the last two stacks

* Visit the code source of the application [Readme file](https://github.com/Ramzi-dev611/barber-shop#readme) to get more details about the creation steps of the application and what's done and what is missing

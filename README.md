# PHP - XT-Commerce (Docker)

Komplette PHP- und Datenbank-Umgebung um die XT-Commerce - Shops auf 'localhost' zu betreiben.


<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Purpose](#purpose)
- [Installation und Start](#installation-und-start)
  - [Basics](#basics)
  - [XT:Commerce 4.2](#xtcommerce-42)
  - [XT:Commerce 5.0](#xtcommerce-50)
  - [Shop-Environment](#shop-environment)
- [Datenbanken](#datenbanken)
  - [Live-Daten einspielen](#live-daten-einspielen)
  - [Devel-Daten sichern](#devel-daten-sichern)
- [Contributing](#contributing)
- [Copyright and license](#copyright-and-license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Purpose

Es ist fast nicht möglich ein Kunden-Live-Shop auf eine 'staging' - Domäne laufen zu 
lassen. Hintergrund sind die Lizenz-Kosten pro 'staging' - Domäne. Die Umgebung
erlaubt das Live-Shop einfach auf Eintwickler-Rechner zu ziehen und unter 'localhost'
laufen lassen.

Vorteile:
* Keine Weitere Lizenz-Domains außer Live-Domäne ('staging' - Domäne)
* Keine Spielerei mit Anpassungen an Einstellungen (config.php wird einfach aus Live-Übernommen)
* Kein Zeitaufwand zum beauftragen und austauschen von [Entwickler-Lizenz](http://addons.xt-commerce.com/index.php?page=developer_license) (Der Shop  Läuft komplett mit Kunden-Lizenz)
* Kein Zeitaufwand für das Einrichten von PHP und Datenbanken auf Entwickler-Rechner
* Separat gekaufte Plugin-Lizenzen werden auch Funktionieren

## Installation und Start

### Basics

* Zuerst muss man [Docker](https://docs.docker.com/install/) und 
[Docker-Compose](https://docs.docker.com/compose/install/) auf 
eigenem Rechner installieren. (**Einmalig**) 

### XT:Commerce 4.2

* Den Shop irgendwo auf eigenem Rechner ablegen. [Neue Installation](https://xtcommerce.atlassian.net/wiki/spaces/MANUAL/pages/917509/Download+und+Entpacken+der+Software)
* Das Projekt im Shop-Verzeichnis clonen und starten
```bash
cd /<my>/shop/path
git clone https://github.com/phoenixrvd/docker-xtc-environment
cd docker-xtc-environment
docker-compose up --build xt42
```
* Die Umgebung vorbereiten. (**Einmalig**) Somit wird die Datenbank eingerichtet, Schreibrechte gesetzt usw.
```bash
docker exec -it  xtc_xt42_1 xt-init
```
* Der Shop läuft nun unter [localhost:8042](http://localhost:8042)

### XT:Commerce 5.0

* Den Shop irgendwo auf eigenem Rechner ablegen. [Neue Installation](https://xtcommerce.atlassian.net/wiki/spaces/MANUAL/pages/917509/Download+und+Entpacken+der+Software)
* Das Projekt im Shop-Verzeichnis clonen und starten
```bash
cd /<my>/shop/path
git clone https://github.com/phoenixrvd/docker-xtc-environment
cd docker-xtc-environment
docker-compose up --build xt50
```
* Die Umgebung vorbereiten. (**einmalig**) Somit wird die Datenbank eingerichtet, Schreibrechte gesetzt usw.
```bash
docker exec -it  xtc_xt50_1 xt-init
```
* Der Shop läuft nun unter [localhost:8050](http://localhost:8050)

### Shop-Environment

Damit man die Live-Shop-Einstellungen zu 100% mit der Entwickler-Version übereinstimmen,
muss man die `.env.example` - Datei ins Shop-Hauptverzeichnis ablegen und zu `.env` umbenennen.

Die Datei enthält Einstellungen zu Datenbank usw. Die Einstellungen sollte am besten mit 
Live-Server-Einstellungen übereinstimmen.

Anmerkung: Nutzt man die Live-Daten, wird `xt-init` - Script automatisch die Datenbank und Benutzer anlegen.

## Datenbanken

### Live-Daten einspielen

* SQL-Dump unter ```<my_shop_path>/dump.sql``` ablegen
* ```bash docker exec -it  xtc_xt50_1 xt-init``` ausführen

### Devel-Daten sichern

* ```bash docker exec -it  xtc_xt50_1 xt-db-dump``` ausführen
* somit wird eine SQL unter ```<my_shop_path>/dump.sql``` abgelegt

## Contributing

**Aktualisieren von Inhaltsverzeichnis**

```bash
doctoc README.md --notitle
```

## Copyright and license

Code released under the [MIT License](https://opensource.org/licenses/MIT). 
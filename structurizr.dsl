workspace {

    model {
        house = softwareSystem "Home" "House or flat our client living in" {
            sensors = container "Sensors" "Movement, lighting, etc sensors"
            hub = container "Hub" "Smart home hub. IoT device consuming data from sensors" {
                sensors -> this "Push data every 10 seconds"
            }
        }
        
        smartHome = softwareSystem "Smart home service" {
            api = container "Smart home API" {
                hub -> this "Push data collected from sensors"
            }
            cache = container "Cache, Redis" "Service stores data from hubs before it's being written to DB" {
                api -> this "Stores cache"
            }
            db = container "Database" "Wide-column store" {
                api -> this "Reads from and writes to"
            }
            
            reportService = container "Report service" {
                this -> cache "Reads real-time data"
                this -> db "Reads data for other reports"
            }
        }
    }

    views {
        systemContext smartHome {
            include *
            autolayout lr
        }
        
        container house {
            include *
            autolayout lr
        }
        
        container smartHome {
            include *
            autolayout lr
        }

        theme default
    }

}
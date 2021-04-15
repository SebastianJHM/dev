module.exports = class Car{
    constructor(license, driver) {
        this.license = license;
        this.driver = driver;
    }

    get conductor() {
        return this.driver;
    }
    
}
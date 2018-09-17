class DeviceInfo {
    constructor(status, udid) {
        this.status = status;
        this.udid = udid;
    }
}

class SafariStatus {
    constructor(status) {
        this.status = status;
    }
}

class UserInfo {
    constructor(token) {
        this.token = token;
    }
}

class XYNative {
    constructor() {
        this.deviceinfo = new DeviceInfo("0", "");
        this.safaristatus = new SafariStatus("0");
        this.userinfo = new UserInfo("");
    }
}

var xynative = Object.create(XYNative.prototype);

XYNative.prototype.xyservice = function(parameters) {
    window.webkit.messageHandlers.xyservice.postMessage(parameters);
    return {};
}

XYNative.prototype.xyloadingpage = function(parameters) {
    window.webkit.messageHandlers.xyloadingpage.postMessage(parameters);
    return {};
}

XYNative.prototype.xycheckudid = function(parameters) {
    window.webkit.messageHandlers.xycheckudid.postMessage(parameters);
    return this.deviceinfo;
}

XYNative.prototype.xycompletecert = function(parameters) {
    window.webkit.messageHandlers.xycompletecert.postMessage(parameters);
    return {};
}

XYNative.prototype.xycheckjumptosafari = function(parameters) {
    window.webkit.messageHandlers.xycheckjumptosafari.postMessage(parameters);
    return this.safaristatus;
}

XYNative.prototype.xyopensafari = function(parameters) {
    window.webkit.messageHandlers.xyopensafari.postMessage(parameters);
    return {};
}

XYNative.prototype.xyinfo = function(parameters) {
    window.webkit.messageHandlers.xyinfo.postMessage(parameters);
    return this.userinfo;
}

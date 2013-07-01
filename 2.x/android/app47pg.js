/**
 * App47 Plugin for the Cordova/PhoneGap Android platform, created by the team @ App47, Inc.
 * The plugin's JavaScript functions are under the global "window.plugins.App47" object. 
 * 
 * Consult our wiki (http://www.app47.com/wiki) for more information on our Agent APIs.
 * 
 * See https://github.com/App47/phonegap-android-example for Plugin usage in sample Android project 
 * and https://github.com/App47/phonegap-ios-example for Plugin usage in sample iOS project.
 * 
 * If you have any questions/comments please find us at http://app47.com or contact us support@app47.com
 */

App47 = function() {
  this.serviceName = "App47";
};         

App47.prototype.sendGenericEvent = function(message, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "sendGenericEvent", message);
};

App47.prototype.startTimedEvent = function(name, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "startTimedEvent", name);
};

App47.prototype.endTimedEvent = function(name, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "endTimedEvent", name);
};

App47.prototype.debug = function(message, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "log", [{type:"debug", msg:message}]);
};

App47.prototype.info = function(message, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "log", [{type:"info", msg:message}]);
};

App47.prototype.warn = function(message, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "log", [{type:"warn", msg:message}]);
};

App47.prototype.error = function(message, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "log", [{type:"error", msg:message}]);
};

App47.prototype.getValue = function(grp, ky, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "configurationValue", [{group:grp, key:ky}]);
};

App47.prototype.getConfiguration = function(grp, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "configurationAsMap", [{group:grp}]);
};

App47.prototype.getConfigurationKeys = function(grp, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "configurationKeys", [{group:grp}]);
};

App47.prototype.getConfigurationGroupNames = function(success, fail) {
  return cordova.exec(success, fail, this.serviceName, "configurationGroupNames", []);
};

App47.prototype.configureAgent = function(appId, success, fail) {
  return cordova.exec(success, fail, this.serviceName, "configureAgent", appId);
};

App47.install = function(){
  if (typeof window.plugins == "undefined") window.plugins = {};
  if (typeof window.plugins.App47 == "undefined") window.plugins.App47 = new App47();
  return window.plugins.App47;
};

if(!window.plugins) {
  window.plugins = {};
}

if (!window.plugins.App47) {
  window.plugins.App47 = new App47();
}
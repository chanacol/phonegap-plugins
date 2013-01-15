package com.app47.pgplugin;

import org.apache.cordova.api.CallbackContext;
import org.apache.cordova.api.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

import com.app47.embeddedagent.EmbeddedAgent;
import com.app47.embeddedagent.EmbeddedAgentLogger;

public class App47PGPlugin extends CordovaPlugin {

	public boolean execute(String method, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (method.equals("startTimedEvent")) {
			Log.d("Cordova App47 Plugin", "action is startTimedEvent"  + " data is " + args);
			String udid = handleStartTimedEvent(args);
			callbackContext.success(udid);
			return true;
		} else if (method.equals("configurationValue")){
			Object value = handleConfigurationValue(args);
			callbackContext.success(value.toString());
			return true;
		}else {
			return handleActionWithCallback(method, args, callbackContext);
		}
	}

	private boolean handleActionWithCallback(String method, JSONArray args, CallbackContext callbackContext) {
		if(execute(method, args)){
			callbackContext.success();
			return true;
		}else{
			callbackContext.error("there was an error!");
			return false;
		}
	}

	public boolean execute(String methodToInvoke, JSONArray data) {
		Log.d("App47 Plugin", "action is " + methodToInvoke + " data is " + data);		
		try {			
			if (methodToInvoke.equals("sendGenericEvent")) {
				return handleGenericEvent(data);
			} else if (methodToInvoke.equals("endTimedEvent")) {
				return handleEndTimedEvent(data);
			} else { // then it is log
				return handleLog(data);
			}					
		} catch (JSONException e) {
			return false;
		}
	}

	private Object handleConfigurationValue(JSONArray data)
			throws JSONException {
		JSONObject values = data.getJSONObject(0);
		String group = values.getString("group");
		String key = values.getString("key");
		return EmbeddedAgent.configurationObjectForKey(key, group);
	}

	private boolean handleEndTimedEvent(JSONArray data)
			throws JSONException {
		String eventId = data.getString(0);
		EmbeddedAgent.endTimedEvent(eventId);
		return true;
	}

	private String handleStartTimedEvent(JSONArray data)
			throws JSONException {
		String eventName = data.getString(0);
		return EmbeddedAgent.startTimedEvent(eventName);
	}

	private boolean handleLog(JSONArray data) throws JSONException {
		JSONObject values = data.getJSONObject(0);
		String logLevel = values.getString("type");
		String message = values.getString("msg");
		Log.d("App47 Plugin", "Log event of type " + logLevel + " with message " + message);
		if (logLevel.equals("info")) {
			EmbeddedAgentLogger.info(message);
		} else if (logLevel.equals("warn")) {
			EmbeddedAgentLogger.warn(message);
		} else if (logLevel.equals("error")) {
			EmbeddedAgentLogger.error(message);
		} else { // debug
			EmbeddedAgentLogger.debug(message);
		}
		return true;
	}

	private boolean handleGenericEvent(JSONArray data)
			throws JSONException {
		EmbeddedAgent.sendEvent(data.getString(0));
		return true;
	}

}

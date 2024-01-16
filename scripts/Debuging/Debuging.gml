#macro LIVE_EXECUTE if (live_call()) return live_result;

global.testing = true;
#macro TESTING global.testing
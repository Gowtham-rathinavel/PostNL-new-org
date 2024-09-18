/**
 * Generic Apex Rest class used for Automation Regression Tests.
 *
 * @created     October 2017
 * @author      Vanessa Ayala Rojas (vayala@deloitte.nl)
 */
@RestResource(urlMapping='/ART/*')
global class ART_Handler {

	public static final String METHOD_PARAM = 'method';
	public static final String PAYLOAD_PARAM = 'payload';
	public static final String HANDLER_PARAM = 'handler';

	@HttpPost
	global static void execute() {
		Object responseMessage;
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		Map<String, String> params = req.params;
		System.debug(LoggingLevel.ERROR, 'params: ' + params);
		System.debug(LoggingLevel.ERROR, 'requestBody: ' + req.requestBody);

		try {
			if(params.containsKey(HANDLER_PARAM)) {
				Type cType = Type.forName(params.get(HANDLER_PARAM));

				if(cType != null) {
					if(cType.newInstance() instanceOf ART_Testable) {
						ART_Testable handler = (ART_Testable) cType.newInstance();
						responseMessage = handler.executeArt(params.get(METHOD_PARAM), req.requestBody.toString());
					} else {
						res.statusCode = 500;
						return;
					}
				} else {
					res.statusCode = 500;
					return;
				}
			} else {
				res.statusCode = 500;
				return;
			}

			System.debug(LoggingLevel.ERROR, 'responseMessage: ' + responseMessage);
			res.responseBody = Blob.valueOf( JSON.serialize(responseMessage) );
			res.addHeader('Content-Type', 'application/json');
			return;

		} catch (Exception e) {
			System.debug('An exception occurred: ' + e.getMessage());
			res.statusCode = 500;
			return;
		}
	}
}
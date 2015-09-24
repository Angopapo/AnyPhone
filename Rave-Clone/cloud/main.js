
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
var twilioAccountSid = 'twilioAccountSid';
var twilioAuthToken = 'twilioAuthToken';
var twilioPhoneNumber = 'twilioPhoneNumber';
var secretPasswordToken = 'anyToken';

var twilio = require('twilio')(twilioAccountSid, twilioAuthToken);

Parse.Cloud.define("sendCode", function(req, res) {
	var phoneNumber = "+1" + req.params.phoneNumber;

	Parse.Cloud.useMasterKey();
	var query = new Parse.Query(Parse.User);
	query.equalTo('username', phoneNumber + "");
	query.first().then(function(result) {
		var min = 1000; var max = 9999;
		var num = Math.floor(Math.random() * (max - min + 1)) + min;

		if (result) {
			result.setPassword(secretPasswordToken + num);
			result.save().then(function() {
				return sendCodeSms(phoneNumber, num);
			}).then(function() {
				res.success();
			}, function(err) {
				res.error(err);
			});
		} else {
			var user = new Parse.User();
			user.setUsername(phoneNumber);
			user.setPassword(secretPasswordToken + num);
			user.setACL({});
			user.save().then(function(a) {
				return sendCodeSms(phoneNumber, num);
			}).then(function() {
				res.success();
			}, function(err) {
				res.error(err);
			});
		}
	}, function (err) {
		res.error(err);
	});
});

Parse.Cloud.define("logIn", function(req, res) {
	Parse.Cloud.useMasterKey();

	var phoneNumber = "+1" + req.params.phoneNumber;

	if (phoneNumber && req.params.codeEntry) {
		Parse.User.logIn(phoneNumber, secretPasswordToken + req.params.codeEntry).then(function (user) {
			res.success(user.getSessionToken());
		}, function (err) {
			res.error(err);
		});
	} else {
		res.error('Invalid parameters.');
	}
});

function sendCodeSms(phoneNumber, code) {
	var promise = new Parse.Promise();
	twilio.sendSms({
		to: phoneNumber,
		from: twilioPhoneNumber,
		body: 'Your login code for AnyPhone is ' + code
	}, function(err, responseData) {
		if (err) {
			console.log(err);
			promise.reject(err.message);
		} else {
			promise.resolve();
		}
	});
	return promise;
}

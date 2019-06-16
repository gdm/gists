'use strict';

var spawn    = require('child_process').spawn;
var s3Upload = require('s3-stream-upload');
var config   = require('../config');
var Promise  = require('bluebird');
var moment   = require('moment');

var mysqlBackup = function() {
	AWS.config.update({ region: config.aws.buckets.backup.region });
        var s3Client = new AWS.S3();	
	var s3 = s3Upload(s3Client, {
		Bucket: config.aws.buckets.backup.name,
		Key: 'mysql-backup-' + moment().format('YYYY-MM-DD-HH-mm-ss') + '.sql'		
	});	

	var mysqldump = spawn('mysqldump', [
		'-u', config.db.connection.user,
		'-p' + config.db.connection.password,
		config.db.connection.database
	]);

	return new Promise(function(resolve, reject) {
		mysqldump
			.stdout
			.pipe(s3)
			.on('finish', function() {
				resolve();
			})
			.on('error', function(err) {
				reject(err);
			});
	});
};

module.exports = mysqlBackup;
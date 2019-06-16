'use strict';

var mysqlBackup  = require('./mysql-backup');
var schedule     = require('node-schedule');

schedule.scheduleJob({ hour: 22, minute: 0 }, mysqlBackup);
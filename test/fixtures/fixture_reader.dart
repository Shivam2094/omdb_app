import 'dart:io';

String fixture(String fixtureName) => File('test/fixtures/$fixtureName').readAsStringSync();
import 'package:flutter/cupertino.dart';

class Facility {
  String? ID;
  String? HospitalName;
  String? CREATED_BY;
  DateTime? CREATION_DATETIME;
  DateTime? DELETE_DATETIME;
  String? DELETED_BY;
  DateTime? UPDATE_DATETIME;
  String? UPDATED_BY;
  Facility(
      {@required this.CREATED_BY,
      this.CREATION_DATETIME,
      this.DELETED_BY,
      this.DELETE_DATETIME,
      this.HospitalName,
      this.ID,
      this.UPDATED_BY,
      this.UPDATE_DATETIME});
}


class CommonHttpHandler {
  CommonHttpHandler._();
}
///=============================================================================
class HttpCodes {
  HttpCodes._();

  static int error_requestNotDefined = 15;
  static int error_userIsBlocked = 20;
  static int error_userNotFound = 25;
  static int error_parametersNotCorrect = 30;
  static int error_databaseError = 35;
  static int error_internalError = 40;
  static int error_tokenNotCorrect = 55;
  //------------ sections -----------------------------------------------------
  static const sec_command = 'command';
  static const sec_userData = 'UserData';
  //------------ commands -----------------------------------------------------
  static const com_forceLogOff = 'ForceLogOff';
  static const com_forceLogOffAll = 'ForceLogOffAll';
  static const com_talkMeWho = 'TalkMeWho';
  static const com_sendDeviceInfo = 'SendDeviceInfo';
  static const com_messageForUser = 'messageForUser';
  static const com_updateProfileSettings = 'UpdateProfileSettings';
}

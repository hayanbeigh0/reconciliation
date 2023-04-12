class AfterLogin {
  ChallengeParameters? challengeParameters;
  AuthenticationResult? authenticationResult;
  UserDetails? userDetails;

  AfterLogin(
      {this.challengeParameters, this.authenticationResult, this.userDetails});

  AfterLogin.fromJson(Map<String, dynamic> json) {
    challengeParameters = json['ChallengeParameters'] != null
        ? ChallengeParameters.fromJson(json['ChallengeParameters'])
        : null;
    authenticationResult = json['AuthenticationResult'] != null
        ? AuthenticationResult.fromJson(json['AuthenticationResult'])
        : null;
    userDetails = json['UserDetails'] != null
        ? UserDetails.fromJson(json['UserDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (challengeParameters != null) {
      data['ChallengeParameters'] = challengeParameters!.toJson();
    }
    if (authenticationResult != null) {
      data['AuthenticationResult'] = authenticationResult!.toJson();
    }
    if (userDetails != null) {
      data['UserDetails'] = userDetails!.toJson();
    }
    return data;
  }
}

class ChallengeParameters {
  ChallengeParameters.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class AuthenticationResult {
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? refreshToken;
  String? idToken;

  AuthenticationResult(
      {this.accessToken,
      this.expiresIn,
      this.tokenType,
      this.refreshToken,
      this.idToken});

  AuthenticationResult.fromJson(Map<String, dynamic> json) {
    accessToken = json['AccessToken'];
    expiresIn = json['ExpiresIn'];
    tokenType = json['TokenType'];
    refreshToken = json['RefreshToken'];
    idToken = json['IdToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccessToken'] = accessToken;
    data['ExpiresIn'] = expiresIn;
    data['TokenType'] = tokenType;
    data['RefreshToken'] = refreshToken;
    data['IdToken'] = idToken;
    return data;
  }
}

class UserDetails {
  String? userId;
  String? userName;
  String? mobileNumber;
  String? countryCode;
  int? active;

  UserDetails(
      {this.userId,
      this.userName,
      this.mobileNumber,
      this.countryCode,
      this.active});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    userName = json['UserName'];
    mobileNumber = json['MobileNumber'];
    countryCode = json['CountryCode'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['UserName'] = userName;
    data['MobileNumber'] = mobileNumber;
    data['CountryCode'] = countryCode;
    data['Active'] = active;
    return data;
  }
}

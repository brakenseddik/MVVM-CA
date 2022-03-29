// convert a respone into a non nullable object ( model)
import 'package:mvvm/app/contants.dart';
import 'package:mvvm/data/requests/forget_request.dart';
import 'package:mvvm/data/responses/forgot_response.dart';
import 'package:mvvm/data/responses/responses.dart';

import 'package:mvvm/app/extensions.dart';
import 'package:mvvm/domain/models/forgot_model.dart';
import 'package:mvvm/domain/models/model.dart';


extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(),  this?.contacts?.toDomain());
  }
}
extension ForgotResponseMapper on ForgotResponse? {
  Forgot toDomain() {
    return Forgot(
        this?.support.orEmpty()?? EMPTY);
  }
}

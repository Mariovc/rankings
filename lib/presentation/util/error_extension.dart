import 'package:easy_localization/easy_localization.dart';
import 'package:ranking/domain/entities/errors.dart';

extension ErrorMessage on MainError {
  String get message {
    switch (runtimeType) {
      case const (NoInternet):
        return 'errors.no_internet'.tr();
      case const (ServerError):
        return 'errors.server'.tr();
      case const (BadRequestError):
        return 'errors.bad_request'.tr();
      case const (ForbiddenError):
        return 'errors.forbidden'.tr();
      case const (NotFoundError):
        return 'errors.not_found'.tr();
      case const (UnauthError):
        return 'errors.unauthorized'.tr();
      case const (ExpiredSessionError):
        return 'errors.expired_session'.tr();
      case const (InvalidCredentialError):
        return 'errors.invalid_credential'.tr();
      case const (InvalidEmailError):
        return 'errors.invalid_email'.tr();
      case const (EmailAlreadyInUseError):
        return 'errors.email_already_in_use'.tr();
      case const (WeakPasswordError):
        return 'errors.weak_password'.tr();
      case const (OperationNotAllowedError):
        return 'errors.operation_not_allowed'.tr();
      case const (UnknownError):
      default:
        return 'errors.unknown'.tr();
    }
  }
}

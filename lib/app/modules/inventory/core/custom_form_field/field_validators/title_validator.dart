import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/properties/app_form_field_sizes.dart';
import '../../../../../core/properties/app_owasp_regex.dart';
import '../../../../../core/texts_icons_provider/pages/inventory/field_form_validation_provided.dart';
import 'validator_abstraction.dart';

class TitleValidator extends ValidatorAbstraction {
  @override
  FormFieldValidator<String> validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD_INVALID_ERROR_MSG),
      Validators.patternString(OWASP_SAFE_TEXT, TEXT_NUMBER_INVALID_ERROR_MSG),
      Validators.minLength(FIELD_TITLE_MIN_SIZE, SIZE_05_INVALID_ERROR_MSG),
    ]);
  }
}
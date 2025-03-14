import 'package:storeappv2/app/sing_up/presentacion/model/form_sing_up_form_model.dart';

sealed class FormSingUpState {
  FormSingUpState({required this.model});

  final SingUpFormModel model;
}

final class InitialState extends FormSingUpState {

  InitialState():super(model: SingUpFormModel(id:"",name: "", document: "", user: "", password: "", image: ""));

}

final class DataUpdateState extends FormSingUpState{
  DataUpdateState({required super.model});

}

final class SubmitSuccessState extends FormSingUpState{
  SubmitSuccessState({required super.model});

}

final class SubmitErrorState extends FormSingUpState{
  SubmitErrorState({required super.model, required this.message});
  final String message;

}

import 'dart:async';

import 'package:EduMap/core/entities/constants.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/entities/router.dart';
import 'package:EduMap/core/network/network_info.dart';
import 'package:EduMap/core/strings/strings.dart';
import 'package:EduMap/core/theme/app_theme.dart';
import 'package:EduMap/core/utils/input_validator.dart';
import 'package:EduMap/core/widgets/text_input.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/trending_schools_bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/trending_schools_event.dart';
import 'package:EduMap/features/schools/presentation/pages/home_page.dart';
import 'package:EduMap/features/users/presentation/bloc/user/bloc.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_bloc.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_state.dart';
import 'package:EduMap/features/users/presentation/widgets/button_widget.dart';
import 'package:EduMap/features/users/presentation/widgets/header_widget.dart';
import 'package:division/division.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String MANDATORY_FIELDS =
    "Les Champs avec ce symbole ( * ) sont obligatoire.";

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  RegisterPageParams registerParams = RegisterPageParams();

  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  String selectedLevel = AppStrings.LEVEl_REGISTER_HINT;
  String selectedSpeciality = AppStrings.SPECIALITY_REGISTER_HINT;
  String selectedCountry = AppStrings.COUNTRY_REGISTER_HINT;
  String selectedCity = AppStrings.CITY_REGISTER_HINT;

  @override
  void initState() {
    super.initState();
    NetworkInfoImpl connectionStatus = NetworkInfoImpl.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    print("Connection status changed");
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBack,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Parent(
        style: AppThemes.pagePaddingStyle,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderWidget(
                bigTitle: AppStrings.CREATE_FREE_ACCOUNT,
                smallDescription: AppStrings.CREATE_FREE_ACCOUNT_SUB_TITLE,
              ),
              buildRegisterForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    return Parent(
        style: AppThemes.pagePaddingStyle,
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ...getPersonalInformationForm(),
                ...getContactAndEducationInformationForm(),
                ...getAddressAndLocationForm(),
                Txt(
                  MANDATORY_FIELDS,
                  style: AppThemes.smallTextStyle.clone()..margin(top: 30.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                (!isOffline)
                    ? initialBuildingRegisterForm()
                    : buildErrorDisplayWidget('Vous êtes hors connexion!'),
                SizedBox(
                  height: 20.0,
                ),
              ],
            )));
  }

  List<Widget> getPersonalInformationForm() {
    return [
      SizedBox(
        height: 20.0,
      ),
      TextFormInput(
        hint: AppStrings.USERNAME_REGISTER_HINT,
        icon: null,
        controller: registerParams.usernameController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      TextFormInput(
        hint: AppStrings.FIRST_NAME_REGISTER_HINT,
        icon: null,
        controller: registerParams.firstNameController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      TextFormInput(
        hint: AppStrings.LAST_NAME_REGISTER_HINT,
        icon: null,
        controller: registerParams.lastNameController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      TextFormInputPassword(
        hint: AppStrings.PASSWORD_REGISTER_HINT,
        icon: EvaIcons.unlock,
        controller: registerParams.passwordController,
        validator: (value) => InputValidator.validatePassword(value),
      ),
      TextFormInputPassword(
        hint: AppStrings.CONFIRM_PASSWORD_REGISTER_HINT,
        icon: EvaIcons.unlock,
        controller: registerParams.confirmPasswordController,
        validator: (value) => InputValidator.validatePassword(value),
      ),
    ];
  }

  List<Widget> getContactAndEducationInformationForm() {
    return [
      TextFormInput(
        hint: AppStrings.BIRTHDAY_REGISTER_HINT,
        icon: null,
        controller: registerParams.birthdayController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      TextFormInput(
        hint: AppStrings.PHONE_REGISTER_HINT,
        icon: null,
        controller: registerParams.phoneController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      TextFormInput(
        hint: AppStrings.EMAIL_REGISTER_HINT,
        icon: null,
        controller: registerParams.emailController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            elevation: 6.0,
            child: Text(selectedLevel),
            onPressed: () async {
              registerParams.selectedLevel = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildChoiceDialog(
                    context,
                    AppStrings.LEVEl_REGISTER_HINT,
                    AppConstant.levels,
                  );
                },
              );
              setState(() {
                selectedLevel = registerParams.selectedLevel;
              });
            },
          ),
          RaisedButton(
              elevation: 6.0,
              child: Text(selectedSpeciality),
              onPressed: () async {
                registerParams.selectedSpeciality = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return buildChoiceDialog(
                      context,
                      AppStrings.SPECIALITY_REGISTER_HINT,
                      AppConstant.specialities,
                    );
                  },
                );
                setState(() {
                  selectedSpeciality = registerParams.selectedSpeciality;
                });
              }),
        ],
      ),
    ];
  }

  List<Widget> getAddressAndLocationForm() {
    return [
      TextFormInput(
        hint: AppStrings.ADDRESS_LINE_REGISTER_HINT,
        icon: null,
        controller: registerParams.addressLineController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      TextFormInput(
        hint: AppStrings.ZIP_CODE_REGISTER_HINT,
        icon: null,
        controller: registerParams.zipCodeController,
        validator: (value) => InputValidator.validateEmptyField(value),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            elevation: 6.0,
            child: Text(selectedCountry),
            onPressed: () async {
              registerParams.selectedCountry = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildChoiceDialog1(
                    context,
                    AppStrings.COUNTRY_REGISTER_HINT,
                    AppConstant.countries,
                  );
                },
              );
              setState(() {
                selectedCountry = registerParams.selectedCountry;
              });
            },
          ),
          RaisedButton(
              elevation: 6.0,
              child: Text(selectedCity),
              onPressed: () async {
                registerParams.selectedCity = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return buildChoiceDialog1(
                      context,
                      AppStrings.CITY_REGISTER_HINT,
                      AppConstant.cities,
                    );
                  },
                );
                setState(() {
                  selectedCity = registerParams.selectedCity;
                });
              }),
        ],
      ),
    ];
  }

  SimpleDialog buildChoiceDialog(
      BuildContext context, String title, Map<String, String> mapItems) {
    List<SimpleDialogOption> options = convertMapToListOfOption(mapItems);
    return SimpleDialog(
      title: Text(title),
      children: options,
    );
  }

  SimpleDialog buildChoiceDialog1(
      BuildContext context, String title, List<String> items) {
    List<SimpleDialogOption> options = [];
    items.forEach((value) {
      options.add(SimpleDialogOption(
        child: Text(value),
        onPressed: () => Navigator.of(context).pop(value),
      ));
    });
    return SimpleDialog(
      title: Text(title),
      children: options,
    );
  }

  List<SimpleDialogOption> convertMapToListOfOption(Map<String, String> map) {
    List<String> titles = map.values.toList();
    List<SimpleDialogOption> options = [];
    titles.forEach((value) {
      options.add(SimpleDialogOption(
        child: Text(value),
        onPressed: () {
          Navigator.of(context).pop(
              map.keys.firstWhere((k) => map[k] == value, orElse: () => null));
        },
      ));
    });
    return options;
  }

  Widget initialBuildingRegisterForm() {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadedState) {
          Navigator.of(context).pushNamed(
            Router.homeRoute,
            arguments: HomePageParams(user: state.user),
          );
          return Container();
        } else
          return Container();
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitialState) {
            return buildRegisterFormButton();
          } else if (state is UserLoadingState) {
            return loadingRegistration();
          } else if (state is UserErrorState) {
            return buildErrorDisplayWidget(state.message);
          } else if (state is UserLoadedState) {
            return Container();
          } else
            return Container();
        },
      ),
    );
  }

  Widget buildRegisterFormButton() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8.0,
        ),
        AppButton(
          buttonTitle: AppStrings.REGISTER_BUTTON,
          isActive: true,
          isSmall: false,
          onPressedFunction: () {
            if (InputValidator.verifyAllRequiredFields(registerParams)) {
              RegisterEventParams registerEventParams = RegisterEventParams(
                username: registerParams.usernameController.text,
                firstName: registerParams.firstNameController.text,
                lastName: registerParams.lastNameController.text,
                birthday: registerParams.birthdayController.text,
                email: registerParams.emailController.text,
                password: registerParams.passwordController.text,
                confirmPassword: registerParams.confirmPasswordController.text,
                phone: registerParams.phoneController.text,
                role: RoleEnum.user,
                educationLevel:
                    EducationLevelEnum.valueOf(registerParams.selectedLevel),
                speciality:
                    SpecialityEnum.valueOf(registerParams.selectedSpeciality),
                addressLine: registerParams.addressLineController.text,
                zipCode: registerParams.zipCodeController.text,
                city: registerParams.selectedCity,
                country: registerParams.selectedCountry,
              );
              BlocProvider.of<UserBloc>(context).add(
                UserRegisterEvent(
                  registerEventParams: registerEventParams,
                ),
              );
              BlocProvider.of<TrendingSchoolsBloc>(context).add(
                GetTrendingSchoolsEvent(),
              );
              BlocProvider.of<SchoolsBloc>(context).add(
                GetSchoolsEvent(),
              );
              BlocProvider.of<CitySchoolsBloc>(context).add(
                GetSchoolsByCityEvent(registerParams.selectedCity),
              );
            }
            return buildErrorDisplayWidget(MISSING_FIELDS_ERROR);
          },
        ),
      ],
    );
  }

  Widget loadingRegistration() {
    return Parent(
      style: AppThemes.circularProgressIndicatorStyle,
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorDisplayWidget(String message) {
    return Column(
      children: <Widget>[
        Txt(
          message,
          style: AppThemes.failureTextStyle.clone()
            ..margin(
              bottom: 12.0,
            ),
        ),
        (!isOffline) ? buildRegisterFormButton() : Container(),
      ],
    );
  }
}

class RegisterPageParams {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressLineController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  String selectedCity = "";
  String selectedCountry = "";
  String selectedLevel = "";
  String selectedSpeciality = "";
}

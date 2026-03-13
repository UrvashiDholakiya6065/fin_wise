import 'package:bloc/bloc.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import '../../AppRoute/app_route.dart';
import '../../Network/Repository/repository.dart';
import '../../SessionManage/shared_pref.dart';
import '../../Utilites/GlobalWidgets/BiomatricService/biomatric_service.dart';
import '../../Utilites/GlobalWidgets/Constant/user_uid.dart';
import '../../Utilites/GlobalWidgets/FirebaseInstanceClass/firebase_instance_class.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;
  final BiometricService biometricService;


  AuthBloc(this.repository,this.biometricService) : super(AuthState()) {
    on<SignupEvent>(registerUser);
    on<LoginEvent>(loginUser);
    on<LoginWithBiometricEvent>(loginWithBiometric);
    on<FetchUserEvent>(fetchData);
    on<LogoutEvent>(logoutBloc);
  }


  Future<void> registerUser(
      SignupEvent event, emit) async {
    emit(state.copyWith(registrationStatus: AuthStatus.loading));
    try {

      await repository.registerUser(userModel: event.userModel);
      emit(state.copyWith(registrationStatus: AuthStatus.success));
      final String? idToken= await FirebaseInstanceClass.userCredential?.user?.getIdToken();
      print("GetId Token ::::::::$idToken}");
      final uid = FirebaseInstanceClass.auth.currentUser?.uid;
      print("Print Uid in register:$uid}");


      SharedPref.setUserUid(uid!);


      SharedPref.userIdAccessToken(idToken!);

    } catch (e) {
      emit(state.copyWith(
          registrationStatus: AuthStatus.error,));
    }
  }
  Future<void> loginUser(
      LoginEvent event, Emitter<AuthState> emit) async {

    emit(state.copyWith(registrationStatus: AuthStatus.loading));

    try {
      await repository.loginUser(
      loginModel: event.loginModel
      );
      final uid = FirebaseInstanceClass.auth.currentUser?.uid;
      print("Print Uid in login:$uid}");
      SharedPref.setUserUid(uid!);


      emit(state.copyWith(registrationStatus: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(registrationStatus: AuthStatus.error));
    }
  }

  Future<void> loginWithBiometric(
      LoginWithBiometricEvent event, Emitter<AuthState> emit) async {

    emit(state.copyWith(biometricStatus: BioStatus.loading));

    try {

      bool authenticated = await biometricService.authenticate();

      if (authenticated) {

        await SharedPref.setBiometricEnable(true);

        emit(state.copyWith(biometricStatus: BioStatus.success));

      } else {
        emit(state.copyWith(biometricStatus: BioStatus.error));
      }

    } catch (e) {
      emit(state.copyWith(biometricStatus: BioStatus.error));
    }
  }

  Future<void> fetchData(FetchUserEvent event,emit)async {
    emit(state.copyWith(registrationStatus: AuthStatus.loading));
    try {


      String? uid = await SharedPref.getUserUid();
      print("UID from pref for fetch ::: $uid");

      if (uid != null) {
        final userModel = await repository.getUserById();
        emit(state.copyWith(registrationStatus: AuthStatus.success, userModel: userModel));
      } else {
        emit(state.copyWith(registrationStatus: AuthStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(registrationStatus: AuthStatus.error));
    }
  }

  void logoutBloc(LogoutEvent event,emit){
    try{
      SharedPref.logout();
      appRoute.go(AppRoutePath.loginScreen.path);
    }catch(e) {
      print("Logout Catch error ::$e");

    }
    }
  }



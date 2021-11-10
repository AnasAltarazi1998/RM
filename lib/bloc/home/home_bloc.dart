import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rm_app/model/course_models.dart';
import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/model/home_screen_model.dart';
import 'package:rm_app/service/course_service.dart';
import 'package:rm_app/service/form_service.dart';
import 'package:rm_app/service/report_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  FormService formService = FormService();
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchCourseDetails) {
      yield LoadingCoursesDetailsState();
      try {
        List<FormModel> formModelList = formService.findAll();
        yield CourseDetailsLoadedState(formsModel: formModelList);
      } catch (e) {
        yield CourseDetailsErrorState(errorMessage: e.toString());
      }
    }
  }
}

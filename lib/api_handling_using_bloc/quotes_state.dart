import 'package:api_handling/api_handling_using_bloc/quote_data_model.dart';

abstract class QuotesState {}
class QuotesInitialState extends QuotesState{}
class QuotesLoadingState extends QuotesState{}
class QuotesLoadedState extends QuotesState{
  DataModel res;
  QuotesLoadedState({required this.res});
}
class QuotesErrorState extends QuotesState{
  String errorMsg;
  QuotesErrorState({required this.errorMsg});
}

import 'package:api_handling/api_handling_using_bloc/quote_data_model.dart';
import 'package:api_handling/api_handling_using_bloc/quotes_event.dart';
import 'package:api_handling/api_handling_using_bloc/quotes_state.dart';
import 'package:api_handling/api_helper.dart';
import 'package:api_handling/base_urls.dart';
import 'package:bloc/bloc.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesBloc() : super(QuotesInitialState()) {
    on<GetQuoteEvents>((event, emit) async {
      emit(QuotesLoadingState());

      var res = await ApiHelper().getApi(apiUrl: BaseUrls.quoteGetApi);
      print(res);
      if(res != null){
        var resData = DataModel.fromJson(res);
        print(resData);
        emit(QuotesLoadedState(res: resData));
      } else {
        emit(QuotesErrorState(errorMsg: 'Error ouccured !'));
      }
    });
  }
}

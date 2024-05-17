import 'package:api_handling/api_handling_using_bloc/quotes_bloc.dart';
import 'package:api_handling/api_handling_using_bloc/quotes_event.dart';
import 'package:api_handling/api_handling_using_bloc/quotes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuotesBloc>(context).add(GetQuoteEvents());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes"),
      ),
      body: BlocBuilder<QuotesBloc, QuotesState>(
        builder: (context, state) {
          if(state is QuotesLoadingState){
            return Center(
                child: CircularProgressIndicator()
            );
          } else if(state is QuotesLoadedState){
            var data = state.res;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var eachQuote = data.quotes![index];
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(15),
                          leading: Icon(
                            Icons.format_quote,
                            color: Colors.blue,
                            size: 40,
                          ),
                          title: Text(
                            eachQuote.quote!.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '- ${eachQuote.author.toString()}',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        )
                      )
                    );

                // return ListTile(
                //   title: Text(eachQuote.quote.toString()),
                //   subtitle: Text(eachQuote.author.toString()),
                // );
              }, itemCount: data.quotes!.length,
            );
          } else if(state is QuotesErrorState){
            return Center(
              child: Text(state.errorMsg),
            );
          }
          return Container();
        },
      )
    );
  }
}

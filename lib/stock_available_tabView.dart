import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';
import 'package:test_aplikasi_tugas_akhir/stock_available_model.dart';

class StockAvailableTabView extends StatefulWidget {
  const StockAvailableTabView({Key? key}) : super(key: key);

  @override
  _StockAvailableTabViewState createState() => _StockAvailableTabViewState();
}

class _StockAvailableTabViewState extends State<StockAvailableTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, _) => SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 220,
                  child: Consumer<ApplicationState>(
                    builder: (context, appState, _) => ListView.builder(
                      itemCount: appState.stockAvailableList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(appState.stockAvailableList[index].name!),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(appState
                                    .stockAvailableList[index].stockCode!),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(appState
                                    .stockAvailableList[index].quantity!
                                    .toString()),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 3,
                                      child: Text('Untung yang Diharapkan'),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Text(appState
                                          .stockAvailableList[index]
                                          .expectedIncome!
                                          .toString()),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                        );
                      },
                    ),
                  ),
                ),
              ]

                  // child: Column(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 300,
                  //       height: 200,
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.max,
                  //         children: <Widget>[
                  //           Expanded(
                  //             child: TextField(
                  //               decoration: InputDecoration(fillColor: Colors.black),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  ),
            ));
  }
}

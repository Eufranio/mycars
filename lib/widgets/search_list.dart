import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchList<T> extends StatefulWidget {

  final Create<Stream<List<T>>> stream;
  final Widget Function(T) buildItem;

  SearchList({
    @required this.stream,
    @required this.buildItem
  });

  @override
  _SearchListState<T> createState() => _SearchListState<T>();

}

class _SearchListState<T> extends State<SearchList<T>> {

  var searchWord = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextButton(context),
        Expanded(
          child: StreamBuilder<List<T>>(
            stream: widget.stream(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              Iterable<T> data = snapshot.data;
              if (searchWord.trim().isNotEmpty) {
                data = data.where((element) => (element as dynamic).modelo.toLowerCase().contains(searchWord.trim().toLowerCase()));
              }

              if (data.isEmpty) {
                return Center(
                  child: Text('Nada para exibir!'),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return widget.buildItem(data.elementAt(index));
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildTextButton(BuildContext context) => Padding(
    padding: EdgeInsets.all(15),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Pesquisar',
        prefixIcon: Icon(Icons.search, color: Colors.orange,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.orange)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.orange, width: 2)
        )
      ),
      onChanged: (value) {
        setState(() {
          searchWord = value;
        });
      },
    ),
  );
}
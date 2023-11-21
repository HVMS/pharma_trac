import 'package:flutter/material.dart';
import 'package:pharma_trac/ADR/add_adr.dart';

import '../Utils/colors_utils.dart';

class AdverseDrugReaction extends StatefulWidget {
  const AdverseDrugReaction({super.key});

  @override
  State<AdverseDrugReaction> createState() => _AdverseDrugReactionState();
}

class _AdverseDrugReactionState extends State<AdverseDrugReaction> {
  bool _isSearching = false;
  final _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text('Adverse Drug Reactions'),
        actions: _buildActions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAdverseDrugReactions()),
          );
        },
        backgroundColor: ColorUtils.floatingActionButtonColor,
        elevation: 5.0,
        child: const Icon(Icons.add, size: 40.0, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      cursorColor: ColorUtils.white,
      decoration: const InputDecoration(
        hintText: 'Search drug reactions',
        hintStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        )
      ),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
    });
  }
}
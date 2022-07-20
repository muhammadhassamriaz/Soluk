import 'package:flutter/material.dart';

import '../../widgets/community_header_text.dart';
import '../../widgets/tiles/community_follow_tile.dart';

class FollowView extends StatelessWidget {
  const FollowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderText('Soluk Friends'),
          TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                    fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                filled: true,
                fillColor: Color(0xffE6E6E6),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: _outlineInputBorder,
                isDense: true,
                disabledBorder: _outlineInputBorder,
                enabledBorder: _outlineInputBorder,
                focusedBorder: _outlineInputBorder),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 12, bottom: 10),
              itemCount: 6,
              itemBuilder: (context, index) {
                return CommunityFollowTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
);

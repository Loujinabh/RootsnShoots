import 'package:flutter/material.dart';
import 'package:plant_diary/API/DataModels/SearchPlantModel.dart';
import 'package:plant_diary/API/PlantSearchApi.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Utils/Debounced.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final Debounced _debounced = Debounced(250);
  List<SearchPlantModel> searchList = [];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.045,
      width: screenWidth * 0.8,
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: AppColors.main,
                width: 1.0,
              ),
            ),
            child: Center(
              child: SearchBar(
                controller: controller,
                shadowColor:
                    const MaterialStatePropertyAll<Color>(Colors.transparent),
                backgroundColor: MaterialStatePropertyAll<Color>(
                    AppColors.main.withAlpha(38)),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                // onTap: () {
                //   controller.openView();
                // },
                onChanged: (_) {
                  String searchText = controller.text;
                  _debounced.run(
                    () async {
                      searchList = await searchPlant(searchText);
                    },
                  );
                },
                leading: Icon(
                  Icons.search,
                  color: AppColors.gray,
                ),
                textStyle: const MaterialStatePropertyAll<TextStyle>(
                    TextStyle(color: Colors.black87)),
                hintText: "new plant ?",
                hintStyle: MaterialStatePropertyAll<TextStyle>(
                    TextStyle(color: AppColors.main)),
                trailing: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: AppColors.gray,
                    ),
                    onPressed: () => {},
                  )
                ],
              ),
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(searchList.length, (int index) {
            final String item = searchList[index].scientific_name;
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                  // Function to Creation page
                });
              },
            );
          });
        },
      ),
    );
  }
}

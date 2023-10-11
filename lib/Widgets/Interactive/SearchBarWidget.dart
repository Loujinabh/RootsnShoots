import 'package:flutter/material.dart';
import 'package:plant_diary/API/DataModels/SearchPlantModel.dart';
import 'package:plant_diary/API/PlantSearchApi.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Utils/Debounced.dart';
import 'package:plant_diary/Utils/Navigation.dart';
import 'package:plant_diary/Views/MyGarden/PlantCreation.dart';

class SearchBarWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool? hide;
  const SearchBarWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.hide,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final Debounced _debounced = Debounced(250);
  List<SearchPlantModel> searchList = [];
  String searchQuery = "";

  Future<List<SearchPlantModel>> updateList() async {
    searchList = await searchPlant(searchQuery);
    return searchList;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: widget.height ?? screenHeight * 0.045,
      width: widget.width ?? screenWidth * 0.8,
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
              border: Border.all(
                color: AppColors.main,
                width: 1.0,
              ),
            ),
            child: Center(
              child: SearchBar(
                overlayColor: widget.hide == null
                    ? null
                    : const MaterialStatePropertyAll<Color>(Colors.transparent),
                controller: controller,
                shadowColor: widget.hide == null
                    ? const MaterialStatePropertyAll<Color>(Colors.transparent)
                    : const MaterialStatePropertyAll<Color>(Colors.transparent),
                backgroundColor: widget.hide == null
                    ? MaterialStatePropertyAll<Color>(
                        AppColors.main.withAlpha(38))
                    : const MaterialStatePropertyAll<Color>(Colors.transparent),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () => controller.openView(),
                onChanged: (_) {
                  searchQuery = controller.text;
                  _debounced.run(
                    () async {
                      await updateList();
                    },
                  );
                },
                leading: widget.hide == null
                    ? Icon(
                        Icons.search,
                        color: AppColors.gray,
                      )
                    : null,
                textStyle: widget.hide == null
                    ? const MaterialStatePropertyAll<TextStyle>(
                        TextStyle(color: Colors.black87))
                    : const MaterialStatePropertyAll<TextStyle>(
                        TextStyle(color: Colors.transparent)),
                hintText: widget.hide == null ? "New plant?" : null,
                hintStyle: widget.hide == null
                    ? MaterialStatePropertyAll<TextStyle>(
                        TextStyle(color: AppColors.main))
                    : const MaterialStatePropertyAll<TextStyle>(
                        TextStyle(color: Colors.transparent)),
              ),
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          if (controller.text != searchQuery) {
            searchQuery = controller.text;
            _debounced.run(
              () async {
                await updateList();
              },
            );
          }
          return [
            FutureBuilder<List<SearchPlantModel>>(
              future: updateList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemExtent: screenHeight * 0.12,
                      itemCount: searchList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final int plantId = searchList[index].id;
                        final String name = searchList[index].common_name;
                        final String scientificName =
                            searchList[index].scientific_name;
                        final String imageSrc = searchList[index].default_image;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.005),
                          child: ListTile(
                            tileColor: AppColors.contrast,
                            visualDensity: const VisualDensity(vertical: 3),
                            leading: imageSrc.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: screenHeight * 0.2,
                                      width: screenWidth * 0.2,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.main),
                                      child: Image.network(
                                        imageSrc,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          try {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.contrast,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          } catch (e) {
                                            return Container(
                                              height: screenHeight * 0.2,
                                              width: screenWidth * 0.2,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.main),
                                              child: Center(
                                                child: Text(
                                                  "No Image",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.contrast,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: screenHeight * 0.2,
                                    width: screenWidth * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.main),
                                    child: Center(
                                      child: Text(
                                        "No Image",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.contrast,
                                        ),
                                      ),
                                    ),
                                  ),
                            trailing: Icon(
                              Icons.add,
                              color: AppColors.main,
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              scientificName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              setState(
                                () {
                                  controller.closeView(name);
                                  // Function to Creation page
                                  navigateToNewScreen(
                                    context,
                                    PlantCreation(
                                      plantId: plantId,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                }
                return LinearProgressIndicator(
                  backgroundColor: AppColors.main,
                  color: AppColors.secoundry,
                );
              },
            )
          ];
        },
      ),
    );
  }
}

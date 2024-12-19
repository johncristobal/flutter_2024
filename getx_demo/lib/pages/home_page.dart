import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/controllers/assets_controller.dart';
import 'package:getx_demo/models/tracked_asset.dart';
import 'package:getx_demo/widgets/add_assets_dialog.dart';

import '../utils.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  AssetsController assetsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  // NEW_2 para resize 
      appBar: _appBar(context),
      body: _buildUi(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const CircleAvatar(
        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
      ),
      actions: [
        IconButton(
          onPressed: (){
            Get.dialog( // GET_2
              AddAssetDialog()
            );
          },
          icon: const Icon(Icons.add)
        )
      ],
    );
  }
  
  
  Widget _buildUi(BuildContext context) {
    return SafeArea(
      child: Obx( // Get_11 again Obs widget
        () => Column(
          children: [
            _portafolioValue(context),
            _trackedAssetsList(context)
          ],
        ),
      )
    );
  }

  Widget _portafolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.03
      ),
      child: Center(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              const TextSpan(
                text: "\$",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),

              TextSpan(
                text: "${assetsController.getPortfolioValue().toStringAsFixed(2)}\n",
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const TextSpan(
                text: "Portfolio value",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w200,
                ),
              ),

            ]
          )
        ),
      ),
    );
  }

  Widget _trackedAssetsList(
    BuildContext context,
  ) {
    return Padding(padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.sizeOf(context).width * 0.03
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.05,
          child: const Text(
              "Portfolio",
              style: TextStyle(
                fontSize: 10,
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
            ), 
        ),

        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.65,
          width:  MediaQuery.sizeOf(context).width,
          child: ListView.builder(
            itemCount: assetsController.trackedAssets.length,
            itemBuilder: (BuildContext context, int index) {
              TrackedAsset asset = assetsController.trackedAssets[index];
              return ListTile(
                leading: Image.network(
                  getCryptoImageURL(asset.name!),
                ),
                title: Text(asset.name!),
                subtitle: Text("USD: ${assetsController.getAssetPrice(asset.name!).toStringAsFixed(2)}"),
                trailing: Text(
                  asset.amount.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),                
                ),
                onTap: () {
                  Get.to( // GET_12 - navitage with GET
                    () {
                      return DetailsPage(
                        coin: assetsController.getCoinData(asset.name!)!,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    ),);
  }
}
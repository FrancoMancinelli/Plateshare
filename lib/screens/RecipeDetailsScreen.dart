import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/Ingredient.dart';
import 'package:plateshare/screens/UserProfileScreen.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/IngredientContainer.dart';
import 'package:plateshare/widgets/InstructionsContainer.dart';

import '../services/firebase_service.dart';
import '../widgets/RecipeCommentList.dart';
import 'InicioScreen.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final String recipeID;
  final String recipeImage;
  final String recipeTitle;
  final String recipeTime;
  final String recipeRate;
  final int recipeLikes;
  final int recipeRations;
  final List<String> recipeSteps;
  final String ownerImage;
  final String ownerUsername;
  final List<Ingredient> recipeIngredients;
  final List<Map<String, dynamic>> recipeComments;

  final String userId;
  final String userImage;
  final String userName;
  final String userUsername;
  final String userEmail;

  final bool isFavorite;

  const RecipeDetailsScreen({
    Key? key,
    required this.recipeImage,
    required this.recipeTitle,
    required this.recipeTime,
    required this.recipeRate,
    required this.recipeLikes,
    required this.recipeRations,
    required this.recipeSteps,
    required this.ownerImage,
    required this.ownerUsername,
    required this.recipeIngredients,
    required this.userImage,
    required this.userName,
    required this.userUsername,
    required this.recipeComments,
    required this.recipeID,
    required this.userId,
    required this.isFavorite,
    required this.userEmail,
  }) : super(key: key);

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

dynamic screenSize;
int flag = 1;
double userValoration = 0;

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  Color firstButtonColor = AppColors.lightBrownRecipe;
  Color secondButtonColor = AppColors.brownButtonsRecipe;
  final TextEditingController _commentController = TextEditingController();
  bool isFavorite = false;
  int amountLikes = 0;
  bool isTheUserTheOwner = false;
  List<Map<String, dynamic>> comments = [];
  final GlobalKey<RecipeCommentListState> commentListKey =
      GlobalKey<RecipeCommentListState>();

  int recipeCount = 0;
  int follows = 0;
  String ownerName = '';
  String ownerEmail = '';
  String ownerImage = '';
  String ownerId = '';
  List<String> recipesIDs = [];
  List<dynamic> likedRecipesIDs = [];

  List<Map<String, dynamic>> data = [];

  //Obtieen los datos de una receta y su dueño
  Future<void> getProfileData() async {
    final ownerIdDB = await getDocumentIdByUsername(widget.ownerUsername);
    final recipeList = await getRecipeDocumentIDs(ownerIdDB);
    final recipeCountDB = recipeList.length;
    final followsList = await getFollows(ownerIdDB);
    final followsDB = followsList.length;
    final likedRecipesIDsFromUserId = await getLikedRecipes(ownerIdDB);
    final nameDB = await getNameByUsername(widget.ownerUsername);
    final emailDB = await getEmailByUsername(widget.ownerUsername);
    final imageDB = await getProfilePicByUsername(widget.ownerUsername);

    setState(() {
      recipeCount = recipeCountDB;
      follows = followsDB;
      ownerEmail = emailDB;
      ownerName = nameDB;
      ownerImage = imageDB;
      ownerId = ownerIdDB;
      likedRecipesIDs = likedRecipesIDsFromUserId;
      recipesIDs = recipeList;
    });
  }

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    amountLikes = widget.recipeLikes;
    checkOwner();
    refreshComments();
    getProfileData();
  }

  // Actualiza en tiempo real el listado de comentarios
  void refreshComments() async {
    List<Map<String, dynamic>> updatedComments =
        await getRecipeComments(widget.recipeID);
    setState(() {
      comments = updatedComments;
    });
    commentListKey.currentState?.updateComments(comments);
  }

  // Comprueba si el dueño de la receta es el usuario actual que esta visionandola
  Future<void> checkOwner() async {
    final ownerId = await getDocumentIdByUsername(widget.ownerUsername);

    setState(() {
      if (ownerId == widget.userId) {
        isTheUserTheOwner = true;
      } else {
        isTheUserTheOwner = false;
      }
    });
  }

  // Actualiza el estado de los botones y la bandera si se presiona el boton de ingredientes
  void handleFirstButtonPressed() {
    setState(() {
      secondButtonColor = AppColors.brownButtonsRecipe;
      firstButtonColor = AppColors.brownInfoRecipe;
      flag = 1;
    });
  }

  // Actualiza el estado de los botones y la bandera si se presiona el boton de instrucciones
  void handleSecondButtonPressed() {
    setState(() {
      firstButtonColor = AppColors.brownButtonsRecipe;
      secondButtonColor = AppColors.brownInfoRecipe;
      flag = 2;
    });
  }

  // Modifica el contenido del container dependiendo si esta seleccionado ingredientes o instrucciones
  Widget buildContainerBasedOnFlag(int flag) {
    if (flag == 1) {
      return IngredientContainer(
        recipeRations: widget.recipeRations,
        recipeIngredients: widget.recipeIngredients,
      );
    } else if (flag == 2) {
      return InstructionsContainer(
        recipeSteps: widget.recipeSteps,
      );
    } else {
      return Container();
    }
  }

  //Muestra un mensaje informativo en la parte inferior de la pantalla. Dependidendo del valor mostrará un mensaje u otro
  void showBottomMessage(int index) {
    switch (index) {
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Valoración actualizada con éxito'),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 1500),
          ),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Se ha eliminado la valoración'),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1500),
          ),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comentario enviado con éxito'),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 1500),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            leading: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8.5,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blackColor.withOpacity(0.5),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            actions: [
              Visibility(
                visible: isTheUserTheOwner,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      right: 8.5,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blackColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        bool confirmDelete = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmar eliminación'),
                              content: const Text(
                                  '¿Estas seguro que quieres eliminar esta receta para siempre? Se eliminará toda información relacionada a esta receta y los datos no podrán ser recuperados'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: const Text('Eliminar'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmDelete == true) {
                          String ownerId = await getDocumentIdByUsername(
                              widget.ownerUsername);
                          deleteCollections(ownerId, widget.recipeID);
                          deleteRecipe(ownerId, widget.recipeID);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InicioScreen(
                                        emailData: widget.userEmail,
                                        nameData: widget.userName,
                                        profilePicData: widget.userImage,
                                        usernameData: widget.userUsername,
                                      )));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.recipeImage,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 100, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 45,
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserProfileScreen(
                                        ownerUsername: widget.ownerUsername,
                                        follows: follows,
                                        likedRecipesIDs: likedRecipesIDs,
                                        ownerEmail: ownerEmail,
                                        ownerId: ownerId,
                                        ownerImage: ownerImage,
                                        ownerName: ownerName,
                                        recipeCount: recipeCount,
                                        recipesIDs: recipesIDs,
                                        currentUseremail: widget.userEmail,
                                        currentUserimage: widget.userImage,
                                        currentUsername: widget.userName,
                                        currentUseruserId: widget.userId,
                                        currentUserusername:
                                            widget.userUsername,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 17.5,
                                    backgroundImage:
                                        NetworkImage(widget.ownerImage),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '@${widget.ownerUsername}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 45,
                        color: Colors.black.withOpacity(0.5),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.white : Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              amountLikes.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 1050,
                  color: AppColors.accentColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              widget.recipeTitle,
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 34,
                                  color: AppColors.brownTextColor,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 3, 10, 0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.brownInfoRecipe,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 2, 0, 0),
                                child: Text(
                                  widget.recipeRate,
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.access_time,
                                color: AppColors.brownInfoRecipe,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(3, 2, 0, 0),
                                child: Text(
                                  '${widget.recipeTime} mins',
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 4, 2, 0),
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  color: AppColors.brownInfoRecipe,
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Text(
                                  '${widget.recipeComments.length} Comentarios',
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.brownButtonsRecipe,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            firstButtonColor),
                                  ),
                                  onPressed: handleFirstButtonPressed,
                                  child: Text(
                                    'Ingredientes (${widget.recipeIngredients.length})',
                                    style: GoogleFonts.acme(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                        fontFamily: 'Acme',
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            secondButtonColor),
                                  ),
                                  onPressed: handleSecondButtonPressed,
                                  child: Text(
                                    'Instrucciones (${widget.recipeSteps.length})',
                                    style: GoogleFonts.acme(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                        fontFamily: 'Acme',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyAccentColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 320,
                            child: buildContainerBasedOnFlag(flag),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Container(
                            color: AppColors.greyColor,
                            height: 2,
                            width: screenSize.width,
                          ),
                        ),
                        Column(
                          children: [
                            RatingBar.builder(
                              initialRating: 2.5,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                              ),
                              //Actualizo los datos de las valoraciones en la base de datos
                              onRatingUpdate: (rating) async {
                                String ownerId = await getDocumentIdByUsername(
                                    widget.ownerUsername);
                                List<double> totalRatings = [];
                                if (rating != 0) {
                                  await addOrUpdateRatingToRecipe(ownerId,
                                      widget.recipeID, rating, widget.userId);
                                  totalRatings = await getAllRatings(
                                      ownerId, widget.recipeID);
                                  if (totalRatings.isNotEmpty) {
                                    double sum = totalRatings.reduce(
                                        (value, element) => value + element);
                                    double newRate = sum / totalRatings.length;
                                    updateRecipeRating(
                                        ownerId, widget.recipeID, newRate);
                                  }
                                  showBottomMessage(1);
                                } else {
                                  removeUserRatingFromRecipe(
                                      ownerId, widget.recipeID, widget.userId);
                                  totalRatings = await getAllRatings(
                                      ownerId, widget.userId);
                                  if (totalRatings.isNotEmpty) {
                                    double sum = totalRatings.reduce(
                                        (value, element) => value + element);
                                    double newRate = sum / totalRatings.length;
                                    updateRecipeRating(
                                        ownerId, widget.recipeID, newRate);
                                  }
                                  showBottomMessage(2);
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.brownButtonsRecipe,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 0, 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 17.5,
                                          backgroundImage:
                                              NetworkImage(widget.userImage),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 0, 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: TextField(
                                            controller: _commentController,
                                            maxLength: 130,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Dejar un comentario...',
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 11),
                                              hintStyle: GoogleFonts.acme(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.greyColor,
                                                  fontFamily: 'Acme',
                                                ),
                                              ),
                                              counterText: '',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.send_rounded,
                                        color: AppColors.whiteColor,
                                      ),
                                      //Publica un comentario en la receta
                                      onPressed: () async {
                                        if (_commentController
                                            .text.isNotEmpty) {
                                          addCommentToRecipe(
                                            widget.recipeID,
                                            widget.userId,
                                            _commentController.text,
                                          );
                                          _commentController.clear();
                                          showBottomMessage(3);
                                          String userImage =
                                              await getProfilePicByUsername(
                                                  widget.userUsername);
                                          String ownerId =
                                              await getDocumentIdByUsername(
                                                  widget.ownerUsername);
                                          addNewNotification(
                                            ownerId,
                                            '${widget.userName} ha comentado en tu receta: ${widget.recipeTitle}',
                                            1,
                                            userImage,
                                          );
                                          refreshComments();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        RecipeCommentList(
                          key: commentListKey,
                          comments: comments,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

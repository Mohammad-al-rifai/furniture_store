part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistStates {}

class WishlistInitialState extends WishlistStates {}

//Add product 2 Wishlist States
class AddPro2WishlistLoadingState extends WishlistStates {}

class AddPro2WishlistDoneState extends WishlistStates {}

class AddPro2WishlistErrorState extends WishlistStates {}

//Get My Wishlist States
class GetMyWishlistLoadingState extends WishlistStates {}

class GetMyWishlistDoneState extends WishlistStates {}

class GetMyWishlistErrorState extends WishlistStates {}

class YouHaveNotWishlistState extends WishlistStates {}

//Remove Product From  Wishlist States
class RemoveProFromWishlistLoadingState extends WishlistStates {}

class RemoveProFromWishlistDoneState extends WishlistStates {}

class RemoveProFromWishlistErrorState extends WishlistStates {}

//Delete My Wishlist States
class DeleteMyWishlistLoadingState extends WishlistStates {}

class DeleteMyWishlistDoneState extends WishlistStates {}

class DeleteMyWishlistErrorState extends WishlistStates {}

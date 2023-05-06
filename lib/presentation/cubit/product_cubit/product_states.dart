part of 'product_cubit.dart';

@immutable
abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

// Get Single Product States:
class GetSingleProLoadingState extends ProductStates {}

class GetSingleProDoneState extends ProductStates {}

class GetSingleProErrorState extends ProductStates {}

class GetSinglePro404State extends ProductStates {}

// Get Product Gallery States:

class GetProductGalleryLoadingState extends ProductStates {}

class GetProductGalleryDoneState extends ProductStates {}

class GetProductGalleryErrorState extends ProductStates {}

// Get Product Video States:

class GetProductVideoLoadingState extends ProductStates {}

class GetProductVideo404State extends ProductStates {}

class GetProductVideoDoneState extends ProductStates {}

class GetProductVideoErrorState extends ProductStates {}

// Get Product VR Image States:

class GetProductVRImageLoadingState extends ProductStates {}

class GetProductVRImage404State extends ProductStates {}

class GetProductVRImageDoneState extends ProductStates {}

class GetProductVRImageErrorState extends ProductStates {}

// Get Product AR Image States:

class GetProductARImageLoadingState extends ProductStates {}

class GetProductARImage404State extends ProductStates {}

class GetProductARImageDoneState extends ProductStates {}

class GetProductARImageErrorState extends ProductStates {}

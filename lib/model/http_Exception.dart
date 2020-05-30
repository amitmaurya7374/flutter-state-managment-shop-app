///here exception is  the abstract class 
///so to get the whole functionality we need to implement
///this is like a signing the contract
class HttpException implements Exception{
    final String message;
    HttpException(this.message);
    @override
  String toString() {
    return message;
    // return super.toString();
  }
}
class CloudStorageMoodException implements Exception {
  const CloudStorageMoodException();
}

class CouldNotCreateMoodException extends CloudStorageMoodException {}

class CouldNotGetAllMoodsException extends CloudStorageMoodException {}

class CouldNotUpdateMoodException extends CloudStorageMoodException {}

class CouldNotDeleteMoodException extends CloudStorageMoodException {}

class InvalidMoodException implements Exception {}

class InvalidActivityException implements Exception {}

class MoodNotSetException implements Exception {}

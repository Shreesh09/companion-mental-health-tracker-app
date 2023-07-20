String extractName(String path) {
  path = path.substring(7);
  path = path.substring(0, path.length - 4);
  return path;
}

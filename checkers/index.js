fetch("./checkers_test.wasm")
  .then((response) => response.arrayBuffer())
  .then((bytes) => WebAssembly.instantiate(bytes))
  .then((results) => {
    console.log("WASM file loaded");
    instance = results.instance;
    console.log("instance", instance);

    var white = 1;
    var black = 2;
    var crowned_white = 6;
    var crowned_black = 5;

    console.log("Offset:");
    var offset = instance.exports.offsetForPosition(3, 4);
    console.log("Offset:", offset);

    console.log("White is white:", instance.exports.isWhite(white));
    console.log("Black is black:", instance.exports.isBlack(black));
    console.log(
      "Remove crown from black:",
      instance.exports.isCrowned(instance.exports.removeCrown(crowned_black))
    );
  });

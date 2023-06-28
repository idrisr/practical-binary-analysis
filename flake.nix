{
  inputs.nixpkgs.url = "nixpkgs";
  description = "linux practical binary analysis";
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in with pkgs; {
      thing = stdenv.mkDerivation {
        name = "thing";
        src = fetchurl {
          url = "https://practicalbinaryanalysis.com/file/pba-code.tar.gz";
          hash = "sha256-SP8F10UzwWcyIsJX8qO2zNWYyfrbzGMji9u/Gr7U4QQ=";
        };
        buildPhase = ''
          cd chapter7
          make all
        '';
        buildInputs = [ libelf ];
        installPhase = ''
          mkdir -p $out/bin
          mv xor_encrypt heapoverflow elfinject hello.bin hello-ctor.bin \
          hello-got.bin heapcheck.so $out/bin
        '';
      };
    };
}

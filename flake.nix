{
  description = "ftdv - A terminal-based file tree diff viewer with flexible diff tool integration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ]
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages.default = pkgs.callPackage ./default.nix { inherit pkgs self; };

          apps.default = {
            type = "app";
            program = "${self.packages.${system}.default}/bin/ftdv";
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              # Rust toolchain
              cargo
              rustc
              rustfmt
              clippy
              rust-analyzer

              # Additional development tools
              pkg-config
              openssl
            ];

            # Environment variables for development
            RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          };
        }
      );
}

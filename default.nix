{ pkgs, self }:
pkgs.rustPlatform.buildRustPackage {
  pname = "ftdv";
  version = "0.1.2";

  src = self;

  # Cargo dependencies hash (computed via nix build)
  cargoHash = "sha256-Mtg/kQ7HGVxITljs1rddCohUySD4Eaa7oAZTXTGP+/M=";

  meta = with pkgs.lib; {
    description = "A terminal-based file tree diff viewer with flexible diff tool integration";
    homepage = "https://github.com/wtnqk/ftdv";
    license = with licenses; [ mit asl20 ];
    mainProgram = "ftdv";
    maintainers = [ ];
  };
}

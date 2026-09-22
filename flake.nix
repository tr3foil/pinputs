{

description = "Pin your NixOS flake inputs to the system flake registry";

outputs = _: {
  nixosModules.default = import ./module.nix;
};

}

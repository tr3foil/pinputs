{

description = "Pin your NixOS flake inputs to the system flake registry";

outputs = { self }: {
  nixosModules.default = { config, lib, ... }: {
    options.pins = {
      inputs = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        description = lib.mdDoc "The set of inputs to pin";
      };
    };

    config = {
      nix.registry = let
        mkPin = name: value: { ${name}.flake = value; };
      in lib.concatMapAttrs mkPin config.pins.inputs;

      nix.nixPath = let
        mkPin = name: _: "${name}=flake:${name}";
      in lib.mapAttrsToList mkPin config.pins.inputs;

      assertions = [
        {
          assertion = lib.all (lib.isType "flake") (lib.attrValues config.pins.inputs);
          message = "'pins.inputs' needs to be an attribute set of flakes";
        }
      ];
    };
  };
};

}

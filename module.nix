# SPDX-FileCopyrightText: 2023, 2026 Clover Ison <clover@isons.org>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

{ config, lib, ... }: {

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

}

<!--
SPDX-FileCopyrightText: 2023, 2026 Clover Ison <clover@isons.org>

SPDX-License-Identifier: AGPL-3.0-or-later
-->

# pinputs
Pin your NixOS flake inputs to the system flake registry!

# Example
```nix
{
  description = "My NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pinputs.url = "github:tr3foil/pinputs/main";
  };

  outputs = inputs@{ self, nixpkgs, pinputs }: {
    nixosConfigurations.myComputer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        pinputs.nixosModules.default
        { pins = { inherit inputs; }; }
      ];
    };
  };
}
```

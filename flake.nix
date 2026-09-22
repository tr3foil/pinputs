# SPDX-FileCopyrightText: 2023, 2026 Clover Ison <clover@isons.org>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

{

description = "Pin your NixOS flake inputs to the system flake registry";

outputs = _: {
  nixosModules.default = import ./module.nix;
};

}

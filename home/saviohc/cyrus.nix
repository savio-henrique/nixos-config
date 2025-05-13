{ config, ... }: { 
  imports = [ 
    (import ./home.nix {base16 = "black-metal-dark-funeral";}) 
    ../common 
  ]; 
}

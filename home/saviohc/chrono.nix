{ config, ... }: 
{ 
  imports = [ 
    # Change the base16  theme for the host
    (import ./home.nix {base16 = "twilight";}) 
    ../common 
    ../common/visual.nix
    ../features/awesome
  ]; 

  awesome.background = "berserk-3.png";
}

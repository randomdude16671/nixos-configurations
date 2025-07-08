{pkgs, inputs, lib, ... }:
let 
	spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.system}; 
in  { 
	programs.spicetify = {
		enable = true; 
		enabledExtensions = with spicePkgs.extensions; [
			shuffle 
			hidePodcasts
		];
		theme =
			lib.mkDefault spicePkgs.themes.catppuccin; 
		colorScheme = 
			lib.mkDefault "mocha"; 
	}; 
}

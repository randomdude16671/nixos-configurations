{pkgs, ...}: 
{
	services = { 
		printing = {
			enable = true; 
			browsing = true; 
			drivers = with pkgs; [
				splix 
				gutenprint  
				foomatic-db 
				foomatic-db-ppds
			];
		};
		avahi = {
			enable = true; 
			nssmdns = true; 
			publish.enable = true; 
			publish.userServices = true; 
		};
		udev.packages = [ pkgs.sane-backends ]; 
	};
	networking.firewall.allowedTCPPorts = [ 631 ];
	security.pam.services.cups = {}; 
}

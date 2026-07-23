#! /bin/sh

printf "###################################"
printf "#      PAYA'S DOTFILE HELPER      #"
printf "###################################\n\n"


printf "Welcome, $(whoami)!"
printf "We'll be setting up your computer...\n\n"

printf "Installing dependencies..."
sudo pacman -Syu --noconfirm
sudo pacman -S  --noconfirm --needed git base-devel
printf "Done!\n\n"

printf "Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
printf "Done!\n\n"

printf "Installing Powershell 7..."
yay -S --noconfirm powershell-bin
printf "Done!\n\n"

printf "Installing chezmoi..."
yay -S --noconfirm chezmoi
printf "Done!\n\n"

printf "Installing 1Password and 1Password CLI..."
yay -S --noconfirm 1password 1password-cli
printf "Done!\n\n"

printf "Sign into 1password, then close it:"
1password --quick-access
read -n 1 -s -r -p "Press any key to continue..."
op signin

printf  "Initializing dotfiles from https://github.com/Tinkering-Townsperson/dotfiles.git ..."
chezmoi init https://github.com/Tinkering-Townsperson/dotfiles.git
printf "Done!\n\n"

chezmoi status

read -p "Show diff for incoming changes? (y/n): " showDiff

case $showDiff in
	[Yy]* )
		chezmoi diff
esac

read -p "Are you happy with these incoming changes and would like to apply them to your system? (y/n): " proceedApply

case $showDiff in
	[Yy]* )
		printf "Applying changes..."
        chezmoi apply -v
esac

printf "Thank you for using my dotfiles helper!"
printf "Find more repositories at https://github.com/Tinkering-Townsperson"
printf "Or visit my website at https://tinkering-townsperson.github.io"

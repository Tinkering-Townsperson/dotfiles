#! /bin/sh

echo "###################################"
echo "#      PAYA'S DOTFILE HELPER      #"
echo "###################################\n\n"


echo "Welcome, $(whoami)!"
echo "We'll be setting up your computer...\n\n"

echo "Installing dependencies..."
sudo pacman -Syu
sudo pacman -S --needed git base-devel
echo "Done!\n\n"

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo "Done!\n\n"

echo "Installing Powershell 7..."
yay -Sy powershell-bin
echo "Done!\n\n"

echo "Installing chezmoi..."
yay -Sy chezmoi
echo "Done!\n\n"

echo "Installing 1Password and 1Password CLI..."
yay -Sy 1password 1password-cli
echo "Done!\n\n"

echo "Sign into 1password, then close it:"
1password --quick-access
read -n 1 -s -r -p "Press any key to continue..."
op signin

echo  "Initializing dotfiles from https://github.com/Tinkering-Townsperson/dotfiles.git ..."
chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
echo "Done!\n\n"

read -p "Show diff for incoming changes? (y/n): " showDiff

case $showDiff in
	[Yy]* )
		chezmoi diff
esac

read -p "Are you happy with these incoming changes and would like to apply them to your system? (y/n): " proceedApply

case $showDiff in
	[Yy]* )
		echo "Applying changes..."
        chezmoi apply -v
esac

echo "Thank you for using my dotfiles helper!"
echo "Find more repositories at https://github.com/Tinkering-Townsperson"
echo "Or visit my website at https://tinkering-townsperson.github.io"

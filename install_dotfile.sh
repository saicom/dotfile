#install dependencies
sudo apt install -y git zsh gcc g++ make cmake ripgrep golang python3-venv nodejs npm autojump
go env -w GOPROXY=https://goproxy.cn,direct
go env -w GO111MODULE=on
go install github.com/jesseduffield/lazygit@latest

git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cp .zshrc ~/.zshrc
cd ~/.oh-my-zsh/tools && sh install.sh
cd -
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
#config neovim
if [ ! -d ~/.config ]; then
  mkdir -p ~/.config
  echo "Create ~/.config directory."
fi
cp -r nvim ~/.config


$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Src  = Join-Path $Root DotfileSync.javaDotfileSync.java
$Out  = Join-Path $Root .dotfiles-sync

New-Item -ItemType Directory -Force -Path $Out  Out-Null
javac -d $Out $Src
java -cp $Out DotfileSync @args

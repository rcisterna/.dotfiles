if has("gui_macvim")
  set guifont=Monaco:h12

  set guioptions-=r                 " Eliminar scrollbar derecha permanente
  set guioptions-=R                 " Eliminar scrollbar derecha en splits
  set guioptions-=l                 " Eliminar scrollbar izquierda permanente
  set guioptions-=L                 " Eliminar scrollbar izquierda en splits

  macmenu &File.Print key=<nop>
  macmenu &File.New\ Tab key=<nop>
endif

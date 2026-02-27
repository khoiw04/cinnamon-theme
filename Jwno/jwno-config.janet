(import jwno/ui-hint)

(:add-hook (in jwno/context :hook-manager) :filter-window
  (fn [_hwnd _uia _exe _desktop] false))

(def my-hint (ui-hint/ui-hint jwno/context))

(put my-hint :label-scale 0.7)

(put my-hint :colors {
  :text 0xF0F0F0
  :background 0x2A2A2A
  :border 0x666666
  :shadow 0x1A1A1A
  :highlight 0xFF8000
  :key 0x000000
})

(:enable my-hint)

(def km (in jwno/context :key-manager))
(def root-keymap (:new-keymap km))

(:define-key root-keymap "Win + J" [:ui-hint "ASDFGHJKL" (ui-hint/uia-hinter)])

(:set-keymap km root-keymap)

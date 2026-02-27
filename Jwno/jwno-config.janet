(import jwno/ui-hint)

(def UIA_ControlTypePropertyId 30003)
(def UIA_ButtonControlTypeId 50000)
(def UIA_CheckBoxControlTypeId 50002)
(def UIA_HyperlinkControlTypeId 50005)
(def UIA_IsInvokePatternAvailablePropertyId 30031)
(def UIA_IsKeyboardFocusablePropertyId 30009)

(def UIA_TextControlTypeId 50020)
(def UIA_DocumentControlTypeId 50030)
(def UIA_PaneControlTypeId 50033)
(def UIA_ImageControlTypeId 50006)

(:add-hook (in jwno/context :hook-manager) :filter-window
  (fn [_hwnd _uia _exe _desktop] false))

(def my-hint (ui-hint/ui-hint jwno/context))
(put my-hint :label-scale 0.7)
(put my-hint :colors {
  :text 0xF0F0F0 :background 0x2A2A2A :border 0x666666
  :shadow 0x1A1A1A :highlight 0xFF8000 :key 0x000000
})
(:enable my-hint)

(def km (in jwno/context :key-manager))
(def root-keymap (:new-keymap km))

(:define-key root-keymap "Win + J" [:ui-hint "ASDFGHJKL"
  (ui-hint/uia-hinter
    :action :click
    :show-highlights true
    :condition [:and
                 [:not [:property UIA_ControlTypePropertyId UIA_TextControlTypeId]]
                 [:not [:property UIA_ControlTypePropertyId UIA_DocumentControlTypeId]]
                 [:not [:property UIA_ControlTypePropertyId UIA_PaneControlTypeId]]
                 [:not [:property UIA_ControlTypePropertyId UIA_ImageControlTypeId]]

                 [:or
                   [:property UIA_ControlTypePropertyId UIA_ButtonControlTypeId]
                   [:property UIA_ControlTypePropertyId UIA_CheckBoxControlTypeId]
                   [:property UIA_ControlTypePropertyId UIA_HyperlinkControlTypeId]

                   [:and
                     [:property UIA_IsInvokePatternAvailablePropertyId true]
                     [:property UIA_IsKeyboardFocusablePropertyId true]]]])])

(:set-keymap km root-keymap)

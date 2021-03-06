
local LTMisc = _G.LTMisc

local moduleOptions = {
  name = function(info) return LazyTown:ApplyStateColor("Misc", LTMisc.db.enabled) end,
  handler = LTMisc,
  disabled = LazyTown.IsDisabled,
  type = 'group',
  childGroups = 'tab',
  args = {
    enabled = {
      name = "Enabled",
      order = 10,
      type = 'toggle',
      set = "SetModuleState",
      get = function(info) return LTMisc.db.enabled end,
    },

    rootTab = {
      name = "Misc",
      order = 20,
      type = 'group',
      args = {
        questGroup = {
          name = "Quest",
          type = 'group',
          args = {
            questTags = {
              name = "Show Quest Tags",
              order = 10,
              type = 'toggle',
              set = function(info, val) LTMisc.db.questLevels = val LTMisc:UpdateQuestLevels() end,
              get = function(info) return LTMisc.db.questLevels end,
            },
            onlyLevel = {
              name = "Only quest level",
              order = 20,
              disabled = function(info) return not LTMisc.db.questLevels end,
              type = 'toggle',
              set = function(info, val) LTMisc.db.onlyLevel = val end,
              get = function(info) return LTMisc.db.onlyLevel end,
            },
          },
        },
        pvpGroup = {
          name = "PvP",
          type = 'group',
          args = {
            arenaPoints = {
              name = "Show Arena Points",
              desc = "Displays the arena points awarded next to arena ratings",
              type = 'toggle',
              set = function(info, val) LTMisc.db.arenaPoints = val LTMisc:UpdateArenaPoints() end,
              get = function(info) return LTMisc.db.arenaPoints end,
            },
          },
        },
        itemGroup = {
          name = "Items",
          type = 'group',
          args = {
            itemGlow = {
              name = "Item Quality Glow",
              desc = "Displays item's quality on buttons. Customisation in the subgroup 'Item Glow Options'",
              order = 10,
              handler = LTItemGlow,
              type = 'toggle',
              set = "SetModuleState",
              get = function(info) return LTItemGlow.db.enabled end,
            },
            vSpace1 = LazyTown:OptionTableVSpace(20),
            durabilityPercent = {
              name = "Durability Percent",
              desc = "Displays durability percentages on equipped gear. Customisation in the subgroup 'Durability Options'",
              order = 30,
              handler = DurabilityPercent,
              type = 'toggle',
              set = "SetModuleState",
              get = function(info) return DurabilityPercent.db.enabled end,
            },
            itemGlowOptions = {
              name = "Item Glow options",
              handler = LTItemGlow,
              type = 'group',
              args = {
                itemGlowGearOnly = {
                  name = "Gear Glow Only",
                  type = 'toggle',
                  set = function(info, val) LTItemGlow.db.gearOnly = val end,
                  get = function(info) return LTItemGlow.db.gearOnly end,
                },
                itemGlowWhere = {
                  name = "Item Glow Where",
                  type = 'multiselect',
                  values = {
                    bank = "Bank",
                    char = "Character",
                    containers = "Containers",
                    craft = "Craft",
                    eqBags = "Bag bar",
                    guildBank = "Guild Bank",
                    inspect = "Inspect",
                    mail = "Mail",
                    merch = "Merchant",
                    trade = "Trade",
                    tradeSkill = "Tradeskill",
                  },
                  set = function(info, key, val) LTItemGlow.db.where[key] = val LTItemGlow:UpdateItemGlow() end,
                  get = function(info, key) return LTItemGlow.db.where[key] end,
                },
              },
            },
            durabilityOptions = {
              name = "Durability Options",
              handler = DurabilityPercent,
              type = 'group',
              args = {
                percent = {
                  name = "Show as percentage",
                  order = 10,
                  type = 'toggle',
                  set = function(info, val) DurabilityPercent.db.percent = val DurabilityPercent:RequestUpdate() end,
                  get = function(info) return DurabilityPercent.db.percent end,
                },
                inverted = {
                  name = "Inverted numbers",
                  desc = "Display 10% damaged instead of 90% durability",
                  order = 20,
                  type = 'toggle',
                  set = function(info, val) DurabilityPercent.db.inverted = val DurabilityPercent:RequestUpdate() end,
                  get = function(info) return DurabilityPercent.db.inverted end,
                },
                displayThreshold = {
                  name = "Display threshold %",
                  desc = "Display when item is at % durability",
                  order = 30,
                  type = 'range',
                  step = 1,
                  min = 25,
                  max = 100,
                  set = function(info, val) DurabilityPercent.db.threshold = val DurabilityPercent:RequestUpdate() end,
                  get = function(info) return DurabilityPercent.db.threshold end,
                },
                font = {
                  name = "Font",
                  order = 40,
                  type = 'select',
                  dialogControl = 'LSM30_Font',
                  values = AceGUIWidgetLSMlists.font,
                  set = function(info, val) DurabilityPercent.db.font = val DurabilityPercent:UpdateFont() end,
                  get = function(info) return DurabilityPercent.db.font end,
                },
                fontSize = {
                  name = "Font size",
                  order = 50,
                  type = 'range',
                  step = 0.25,
                  min = 8,
                  max = 14,
                  set = function(info, val) DurabilityPercent.db.fontSize = val DurabilityPercent:UpdateFont() end,
                  get = function(info) return DurabilityPercent.db.fontSize end,
                },
              },
            },
          },
        },
        generalUIGroup = {
          name = "General UI",
          type = 'group',
          args = {
            actionButtonGroup = {
              name = "Action Buttons",
              order = 10,
              type = 'group',
              inline = true,
              args = {
                hideMacroText = {
                  name = "Hide macro text",
                  type = 'toggle',
                  set = function(info, val) LTMisc.db.hideMacroText = val LTMisc:UpdateMacroText() end,
                  get = function(info) return LTMisc.db.hideMacroText end,
                },
                hideHotKeyText = {
                  name = "Hide hotkey text",
                  type = 'toggle',
                  set = function(info, val) LTMisc.db.hideHotKeyText = val LTMisc:UpdateHotKeyText() end,
                  get = function(info) return LTMisc.db.hideHotKeyText end,
                },
              },
            },
            vSpace1 = LazyTown:OptionTableVSpace(15),
            classIconPortraits = {
              name = "Class Icon Portraits",
              order = 20,
              type = 'toggle',
              set = function(info, val) LTMisc.db.classIconPortraits = val LTMisc:UpdatePortraits() end,
              get = function(info) return LTMisc.db.classIconPortraits end,
            },
            vSpace2 = LazyTown:OptionTableVSpace(25),
            gryphonAlpha = {
              name = "Gryphon Alpha",
              order = 30,
              type = 'range',
              step = 0.01,
              min = 0,
              max = 1,
              set = function(info, val) LTMisc.db.gryphonAlpha = val LTMisc:UpdateGryphonAlpha() end,
              get = function(info) return LTMisc.db.gryphonAlpha end,
            },
          },
        },
        mapGroup = {
          name = "World Map",
          type = 'group',
          args = {
            zoneLevels = {
              name = "Zone Levels",
              order = 10,
              type = 'toggle',
              set = function(info, val) LTMisc.db.zoneLevels = val LTMisc:UpdateZoneLevels() end,
              get = function(info) return LTMisc.db.zoneLevels end,
            },
            vSpace1 = LazyTown:OptionTableVSpace(15, "\n\n"),
            coordinates = {
              name = "Show coordinates",
              order = 20,
              type = 'toggle',
              set = function(info, val) LTMisc.db.coordinates = val LTMisc:UpdateCoordinates() end,
              get = function(info) return LTMisc.db.coordinates end,
            },
            precision = {
              name = "Decimal precision",
              order = 25,
              disabled = function(info) return not LTMisc.db.coordinates end,
              type = 'range',
              step = 1,
              min = 0,
              max = 2,
              set = function(info, val) LTMisc.db.precision = val LTMisc:UpdateCoordsFormat() end,
              get = function(info) return LTMisc.db.precision end,
            },
            vSpace2 = LazyTown:OptionTableVSpace(28, "\n\n"),
            backgroundAlpha = {
              name = "Background alpha",
              desc = "Black area that is behind the map",
              order = 30,
              type = 'range',
              step = 0.01,
              min = 0,
              max = 1,
              set = function(info, val) LTMisc.db.backgroundAlpha = val LTMisc:UpdateMapAlpha() end,
              get = function(info) return LTMisc.db.backgroundAlpha end,
            },
            mapAlpha = {
              name = "Worldmap alpha",
              order = 40,
              type = 'range',
              step = 0.01,
              min = 0.25,
              max = 1,
              set = function(info, val) LTMisc.db.mapAlpha = val LTMisc:UpdateMapAlpha() end,
              get = function(info) return LTMisc.db.mapAlpha end,
            },
          },
        },
        minimapGroup = {
          name = "Minimap",
          type = 'group',
          args = {
            hideCloseButton = {
              name = "Hide close button",
              hidden = function(info) return simpleMinimap ~= nil end,
              type = 'toggle',
              set = function(info, val) LTMisc.db.hideCloseButton = val LTMisc:UpdateCloseButton() end,
              get = function(info) return LTMisc.db.hideCloseButton end,
            },
            hideMapButton = {
              name = "Hide world map button",
              type = 'toggle',
              set = function(info, val) LTMisc.db.hideMapButton = val LTMisc:UpdateWorldMapButton() end,
              get = function(info) return LTMisc.db.hideMapButton end,
            },
            hideNorth = {
              name = "Hide north mark",
              type = 'toggle',
              set = function(info, val) LTMisc.db.hideNorth = val LTMisc:UpdateNorthMark() end,
              get = function(info) return LTMisc.db.hideNorth end,
            },
            hideTimeButton = {
              name = "Hide clock button*",
              desc = "Note: You can still reach the clock settings with the command\n'/run ToggleTimeManager()'",
              type = 'toggle',
              set = function(info, val) LTMisc.db.hideTimeButton = val LTMisc:UpdateTimeButton() end,
              get = function(info) return LTMisc.db.hideTimeButton end,
            },
            hideZoom = {
              name = "Hide zoom buttons",
              type = 'toggle',
              set = function(info, val) LTMisc.db.hideZoom = val LTMisc:UpdateZoomButtons() end,
              get = function(info) return LTMisc.db.hideZoom end,
            },
            mouseScroll = {
              name = "Mouse scroll zoom",
              type = 'toggle',
              set = function(info, val) LTMisc.db.scrollZoom = val LTMisc:UpdateScrollZoom() end,
              get = function(info) return LTMisc.db.scrollZoom end,
            },
          },
        },
        bagGroup = {
          name = "Bags",
          type = 'group',
          args = {
            which = {
              name = "Using which bag layout",
              desc = "If you are using wow's original bags or something created in an addon",
              order = 10,
              type = 'select',
              values = {
                original = "Original WoW bags",
                bagnon = "Bagnon",
              },
              set = function(info, val) LTMisc.db.bagType = val LTMisc:UpdateBagType() end,
              get = function(info) return LTMisc.db.bagType end,
            },
            deleteCheckbox = {
              name = "OneClick del checkbox*",
              desc = "One-click delete checkbox for easy item deletion - " ..
                     "Warning: This places a lot of power in your hands, so be very careful not to delete items you would need later",
              order = 20,
              type = 'toggle',
              set = function(info, val) LTMisc.db.checkboxDelete = val LTMisc:UpdateCheckbox('Delete') end,
              get = function(info) return LTMisc.db.checkboxDelete end,
            },
            deCheckbox = {
              name = "OneClick DE checkbox",
              desc = "One-click disenchant checkbox for easy disenchanting",
              order = 30,
              type = 'toggle',
              set = function(info, val) LTMisc.db.checkboxDisenchant = val LTMisc:UpdateCheckbox('Disenchant') end,
              get = function(info) return LTMisc.db.checkboxDisenchant end,
            },
            prospectCheckbox = {
              name = "OneClick pct checkbox",
              desc = "One-click prospect checkbox for easy prospecting",
              order = 40,
              type = 'toggle',
              set = function(info, val) LTMisc.db.checkboxProspect = val LTMisc:UpdateCheckbox('Prospect') end,
              get = function(info) return LTMisc.db.checkboxProspect end,
            },
          },
        },
        alignGroup = {
          name = "Alignment grid",
          type = 'group',
          args = {
            enable = {
              name = "Enable grid",
              order = 10,
              type = 'toggle',
              set = function(info, val) LTMisc.db.grid = val LTMisc:UpdateGrid() end,
              get = function(info) return LTMisc.db.grid end,
            },
            fourths = {
              name = "Show fourths",
              order = 20,
              type = 'toggle',
              set = function(info, val) LTMisc.db.gridFourths = val LTMisc:UpdateGrid() end,
              get = function(info) return LTMisc.db.gridFourths end,
            },
            white = {
              name = "White grid",
              order = 30,
              type = 'toggle',
              set = function(info, val) LTMisc.db.gridWhite = val LTMisc:UpdateGrid() end,
              get = function(info) return LTMisc.db.gridWhite end,
            },
            boxWidth = {
              name = "Box width",
              desc = "Width of the individual boxes inside the grid in pixels",
              order = 40,
              type = 'range',
              step = 1,
              min = 20,
              max = 200,
              set = function(info, val) LTMisc.db.boxWidth = val LTMisc:UpdateGrid() end,
              get = function(info) return LTMisc.db.boxWidth end,
            },
            boxHeight = {
              name = "Box height",
              desc = "Height of the individual boxes inside the grid in pixels",
              order = 50,
              type = 'range',
              step = 1,
              min = 20,
              max = 200,
              set = function(info, val) LTMisc.db.boxHeight = val LTMisc:UpdateGrid() end,
              get = function(info) return LTMisc.db.boxHeight end,
            },
          },
        },
      },
    },
  },
}

LazyTown:AddModuleOptions("miscGroup", moduleOptions)

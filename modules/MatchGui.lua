TributesEnhancement = TributesEnhancement or {}

local ETE = TributesEnhancement

local MatchGui = {}

local WM = GetEventManager() 

local function CreateMatchGui() 

    local name = ETE.name.."MatchGui"
    local store = ETE.store.matchGui

    -- header button  
    local winH = WM:CreateTopLevelWindow( name.."WindowHeader")

    winH:ClearAnchors() 
    winH:SetAnchor( TOPLEFT GuiRoot, TOPLEFT, store.position.x, store.position.y )
    winH:SetHidden(true) 

    MatchGui.ToggleHeader = function(state) 
            if state == nil then 
                state = winH:IsHidden()
            end
            winH:SetHidden(not state) 
            winH:SetMouseEnabled(state)
        end

    winH:SetHandler( "OnMoveStop", function() 
        store.position.x = win:GetLeft()
        store.position.y = win:GetTop() 
    end)

    local ctrlH = WM:CreateControl( name.."ControlHeader", winH, CT_CONTROL) 
    ctrlH:ClearAnchors() 
    ctrlH:SetAnchor( TOP, winH, TOP)

    local buttonH = WM:CreateControl( name.."ButtonHeader", ctrlH, CT_CONTROL)
    buttonH:ClearAnchors() 
    buttonH:SetAnchor(TOP, ctrlH, TOP, 0, 0)
    buttonH:SetDimensions(48, 48)
    local buttonH_texture = ""
    buttonH:SetNormalTexture(buttonH_texture.."_up.dds") 
    buttonH:SetMouseOverTexture(buttonH_texture.."_over.dds")  
    buttonH:SetHandler("OnMouseEnter", function() 
            InitializeTooltip(InformationTooltip, buttonH, RIGHT) end)
            InformationTooltip:AddLine( "Tributes Enhancement Toggle")
        end) 
    buttonH:SetHandler("OnMouseExit", function() ZO_Tooltips_HideTextTooltip end)
    buttonH:SetHandler("OnClicked", function() MatchGui.Toggle() end )


    -- match gui 
    local win = WM:CreateTopLevelWindow( name.."Window" )
    win:ClearAnchors() 
    win:SetAnchor( TOP, winH, TOP, 0, 0)

    MatchGui.Toggle = function(state) 
        if state == nil then 
            state = win:IsHidden()
        end
        win:SetHidden(not state) 
        win:SetMouseEnabled(state)
    end

    local ctrl = WM:CreateControl( name.."Control", win, CT_CONTROL )
    ctrl:ClearAnchors() 
    ctrl:SetAnchor()

    local back = WM:CreateControl( name.."Backdrop", ctrl, CT_BACKDROP)
    back:ClearAnchors()
    back:SetAnchor( TOP, ctrl, TOP )

end


local function Initialize() 
    CreateMatchGui() 
    return MatchGui
end

ETE.InitializeMatchGui = Initialize
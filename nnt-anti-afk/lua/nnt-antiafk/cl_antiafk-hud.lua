AntiAfkLanguage = "EN"
AntiAfkSelTheme = "Large"


include("modules/sh_language.lua")
include("modules/sh_themes.lua")
hook.Add( "Initialize", "NNT-AntiAFK-FinishLoading-Client", function()
	include("nnt-antiafk/cl_skin.lua")
end)
include("cl_skin.lua")
--[[
  /$$$$$$  /$$$$$$$  /$$      /$$ /$$$$$$ /$$   /$$       /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
 /$$__  $$| $$__  $$| $$$    /$$$|_  $$_/| $$$ | $$      | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \ $$| $$  \ $$| $$$$  /$$$$  | $$  | $$$$| $$      | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$$$$$$$| $$  | $$| $$ $$/$$ $$  | $$  | $$ $$ $$      | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$__  $$| $$  | $$| $$  $$$| $$  | $$  | $$  $$$$      | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$  | $$| $$  | $$| $$\  $ | $$  | $$  | $$\  $$$      | $$      | $$  | $$| $$\  $$$| $$      | $$
| $$  | $$| $$$$$$$/| $$ \/  | $$ /$$$$$$| $$ \  $$      | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/  |__/|_______/ |__/     |__/|______/|__/  \__/      |__/      |__/  |__/|__/  \__/|________/|________/
]]
function NNTAntiafkAdminPanel(data)


    local w = ScrW() / 2
    local h = ScrH() / 2
    PanelOff = nil
    SomeShittyTest = "undefined"
    SomeShittyTest1 = "undefined"
	SomeShittyTest2 = "undefined"
	SomeShittyTest3 = "undefined"


	local MainPanel = vgui.Create( "DFrame" )
	MainPanel:SetPos( w-250, h-200 )
	MainPanel:SetSize( 500, 400 )
	MainPanel:SetTitle( "" )
	MainPanel:SetDraggable( false )
	MainPanel:ShowCloseButton( true )
	MainPanel:MakePopup()
	MainPanel:SetSkin("NNT-AntiAFK")

	local WindowSelect = vgui.Create( "DPropertySheet", MainPanel )
	WindowSelect:SetPos(-1,33)
	WindowSelect:SetSize(502, 369)


	local GeneralSettingsM = vgui.Create( "DPanel" , WindowSelect)
	GeneralSettingsM:SetPos( 0, 0 )
	GeneralSettingsM:SetSize( 500, 336 )

	function GeneralSettingsM:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["GENSETTINGS"], "HudHintTextLarge",100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["TIMESSETTINGS"], "HudHintTextLarge",380, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end
	WindowSelect:AddSheet( " Settings", GeneralSettingsM, "nnt-antiafk/option.png" )


	local WhitelistS = vgui.Create( "DPanel" , WindowSelect)
	WhitelistS:SetPos( 0, 0 )
	WhitelistS:SetSize( 250, 200)
	WindowSelect:AddSheet( " WhiteList!", WhitelistS, "nnt-antiafk/users.png" )
	function WhitelistS:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		draw.DrawText("User's Whitelist!", "HudHintTextLarge", 100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
		draw.DrawText("Groups Whitelist!", "HudHintTextLarge", 365, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end


	local LanguagesAndThemes = vgui.Create( "DPanel" , WindowSelect)
	LanguagesAndThemes:SetPos( 0, 0 )
	LanguagesAndThemes:SetSize( 500, 336 )
	function LanguagesAndThemes:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
	end
	WindowSelect:AddSheet( " Languages and Themes", LanguagesAndThemes, "nnt-antiafk/translate.png" )

	local SetAFKMenu = vgui.Create( "DPanel" , MainPanel)
	SetAFKMenu:SetPos( 0, 20 )
	SetAFKMenu:SetSize( 400, 300 )
	function SetAFKMenu:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		draw.DrawText("Set Player AFK !", "HudHintTextLarge",250, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end
	WindowSelect:AddSheet( " Set Player", SetAFKMenu, "nnt-antiafk/clock.png" )

	local MoreInfo = vgui.Create( "DPanel" , WindowSelect)
	MoreInfo:SetPos( 0, 0 )
	MoreInfo:SetSize( 250, 200)
	WindowSelect:AddSheet( " More Info!", MoreInfo, "nnt-antiafk/question-mark.png" )

	local ThemesMenu = vgui.Create( "DFrame" , LanguagesAndThemes)
	ThemesMenu:SetPos( 250, 0 )
	ThemesMenu:SetSize( 250, 70 )
	ThemesMenu:SetTitle( "" )
	ThemesMenu:SetDraggable( false )
	ThemesMenu:ShowCloseButton( false )
	function ThemesMenu:Paint(w, h)
		//draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 0, 255, 100))
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["THEME"], "HudHintTextLarge", 100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end

	local LangMenu = vgui.Create( "DFrame" , LanguagesAndThemes)
	LangMenu:SetPos( 0, 0 )
	LangMenu:SetSize( 250, 70 )
	LangMenu:SetTitle( "" )
	LangMenu:SetDraggable( false )
	LangMenu:ShowCloseButton( false )
	function LangMenu:Paint(w, h)
		//draw.RoundedBox( 0, 0, 0, w, h,  Color(0, 255, 255, 100))
		draw.DrawText(AntiAfkTranslate[AntiAfkLanguage]["LANGUAGESET"], "HudHintTextLarge", 100, 5,Color( 255, 255, 0, 255 ),TEXT_ALIGN_CENTER)
	end






	local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( GeneralSettingsM )
    TextEntry:SetPos( 280, 24 )
    TextEntry:SetSize( 65, 25 )
    TextEntry:SetMin( 0 )
	TextEntry:SetMax(999999)
    function TextEntry:OnValueChanged( val )
	    -- print the form's text as server text
    end

    local TextEntry2 = vgui.Create( "DNumberWang")
    TextEntry2:SetParent( GeneralSettingsM )
    TextEntry2:SetPos( 400, 24 )
    TextEntry2:SetSize( 65, 25 )
    TextEntry2:SetMin( 0 )
	TextEntry2:SetMax(999999)
   	function TextEntry2:OnValueChanged( val )
	    	-- print the form's text as server text
    end



	-- Groups Bypass
	local checkboxGroupsbypass = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxGroupsbypass:SetPos( 22,65 )
	checkboxGroupsbypass:SetText( "Groups Bypass" )
	checkboxGroupsbypass:SetTextColor(Color(255, 255, 255))



	-- User Bypass
	local checkboxUbypass = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxUbypass:SetPos( 22, 45 )
	checkboxUbypass:SetText( "User Bypass" )
	checkboxUbypass:SetTextColor(Color(255, 255, 255))




	-- Anti AFK ENABLE
	local checkboxAntiAFK = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxAntiAFK:SetPos( 22, 25 )
	checkboxAntiAFK:SetText( "Activate AntiAFK" )
	checkboxAntiAFK:SetTextColor(Color(255, 255, 255))


	-- Ghost User When AFK
	local checkboxGHOST = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxGHOST:SetPos( 22, 85 )
	checkboxGHOST:SetText( "Ghost Mode" )
	checkboxGHOST:SetTextColor(Color(255, 255, 255))


	-- Freeze Salary When user is AFK
	local checkboxDarkRPFreeze = vgui.Create( "DCheckBoxLabel", GeneralSettingsM )
	checkboxDarkRPFreeze:SetPos( 22, 105 )
	checkboxDarkRPFreeze:SetText( "Freeze Salary (DarkRP)" )
	checkboxDarkRPFreeze:SetTextColor(Color(255, 255, 255))



	local SelectTheme = vgui.Create( "DComboBox", ThemesMenu )
	SelectTheme:SetPos( 65, 35 )
	SelectTheme:SetSize( 75, 20 )
	SelectTheme:SetValue( AntiAfkSelTheme )
	for k,v in pairs(AntiAfkDisponibleThemes) do
		SelectTheme:AddChoice(v)
	end
	SelectTheme.OnSelect = function( self, index, value )
		for k,v in pairs(AntiAfkDisponibleThemes) do
			if v == value then
					net.Start("nnt-antiak-settings")
						local temptable = {["THEME"] = v }
						net.WriteTable(temptable)
						net.WriteString("SetSettings")
            		net.SendToServer()
			end
		end
	end


	local MoreInfoTittle = vgui.Create( "DLabel", MoreInfo )
	MoreInfoTittle:SetPos( 10, 10 )
	MoreInfoTittle:SetSize(200, 24)
	MoreInfoTittle:SetFont("Trebuchet24")
	MoreInfoTittle:SetText( "InComming Features!" )
	MoreInfoTittle:SetTextColor(Color(255, 255, 255))

	local MoreInfoFeatures = vgui.Create( "DLabel", MoreInfo )
	MoreInfoFeatures:SetPos( 10, 40 )
	MoreInfoFeatures:SetSize(250, 50)
	MoreInfoFeatures:SetFont("Trebuchet18")
	MoreInfoFeatures:SetTextColor(Color(255, 255, 255))
	MoreInfoFeatures:SetText( [[
		- Enable / Disable God
		- Activate AFK in a certain time of the day
	]] )
	local MoreInfoTittle2 = vgui.Create( "DLabel", MoreInfo )
	MoreInfoTittle2:SetPos( 10, 75 )
	MoreInfoTittle2:SetSize(200, 24)
	MoreInfoTittle2:SetFont("Trebuchet24")
	MoreInfoTittle2:SetTextColor(Color(255, 255, 255))
	MoreInfoTittle2:SetText( "Credits!" )

	local MoreInfoCredits = vgui.Create( "DLabel", MoreInfo )
	MoreInfoCredits:SetPos( 10, 90 )
	MoreInfoCredits:SetSize(450, 100)
	MoreInfoCredits:SetFont("Trebuchet18")
	MoreInfoCredits:SetTextColor(Color(255, 255, 255))
	MoreInfoCredits:SetText( [[
		- Icons made by Freepik from www.flaticon.com is licensed by CC 3.0 BY
		- Icons made by Chanut from www.flaticon.com is licensed by CC 3.0 BY
		- Spanish translation made by Wex[A]rt
	]] )

	local SelectTranslate = vgui.Create( "DComboBox", LangMenu )
	SelectTranslate:SetPos( 65, 35 )
	SelectTranslate:SetSize( 75, 20 )
	SelectTranslate:SetValue( AntiAfkTranslate[AntiAfkLanguage]["NAME"] )
	for k,v in pairs(AntiAfkTranslate) do
	SelectTranslate:AddChoice(v["NAME"])
	end
	SelectTranslate.OnSelect = function( self, index, value )
		for k,v in pairs(AntiAfkTranslate) do
			if v["NAME"] == value then
					net.Start("nnt-antiak-settings")
						local temptable = {["LANGUAGE"] = k }
						net.WriteTable(temptable)
						net.WriteString("SetSettings")
            		net.SendToServer()
			end
		end
	end

    local list_btn = vgui.Create("DButton")
	list_btn:SetParent( GeneralSettingsM )
	list_btn:SetText( "SET KICK" )
	list_btn:SetPos( 278, 60)
	list_btn:SetSize( 70, 20 )
	list_btn:SetFont("DermaDefaultBold")
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 10, 0, 0, w, h,  Color(145, 0, 0, 230) ) end
	list_btn.DoClick = function ()
			surface.PlaySound( "ui/buttonclickrelease.wav" )
			if TextEntry:GetValue() >= 180 then
			net.Start("nnt-antiak-settings")
				local temptable = {["KICK"] = TextEntry:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
			else
				LocalPlayer():ChatPrint("[AFK] You need to enter a time above or equal to 180 in the kick time !")
			end
	end

    local list_btn2 = vgui.Create("DButton")
	list_btn2:SetParent( GeneralSettingsM )
	list_btn2:SetText( "SET WARN" )
	list_btn2:SetPos( 400, 60)
	list_btn2:SetSize( 70, 20 )
	list_btn2:SetFont("DermaDefaultBold")
    list_btn2:SetColor(Color(255, 255, 255))
	list_btn2.Paint = function( self, w, h ) draw.RoundedBox( 10, 0, 0, w, h,  Color(145, 0, 0, 230) ) end
	list_btn2.DoClick = function ()
		surface.PlaySound( "ui/buttonclickrelease.wav" )
		if TextEntry2:GetValue() >= 30 then
            net.Start("nnt-antiak-settings")
				local temptable = {["WARN"] = TextEntry2:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
		LocalPlayer():ChatPrint("[AFK] You need to enter a time above or equal to 30 in the warn time !")
		end
	end



	local Sign = vgui.Create( "DLabel", MainPanel )
	Sign:SetPos( 20, 375 )
	Sign:SetSize(150 , 25)
	Sign:SetColor(Color(255,255,255))
	Sign:SetText( "Made by Aiko Suzuki !" )

	net.Start("nnt-antiak-settings")
		net.WriteTable({"Pleasedata"})
		net.WriteString("LoadData")
	net.SendToServer()
	net.Receive("nnt-antiak-settings", function()
		local data5 = net.ReadString()
		local data4 = net.ReadTable()
		if data5 == "LoadData" then -- load all data at once
			print("Loading DATA")
			for k,v in pairs(data4) do
				if k == "AFK_WARN_TIME" then
					AFK_WARN_TIME = v
					TextEntry2:SetValue(tonumber(v,10))
				elseif k == "AFK_TIME" then
					AFK_TIME = v
					 TextEntry:SetValue(tonumber(v,10))
				elseif k == "AFK_ADMINBYPASS" then
					AFK_ADMINBYPASS = v
					if AFK_ADMINBYPASS == true then
						checkboxGroupsbypass:SetValue( 1 )
					end
				elseif k == "AFK_ADMINUBYPASS" then
					AFK_ADMINUBYPASS = v
					if AFK_ADMINUBYPASS == true then
						checkboxUbypass:SetValue( 1 )
					end
				elseif k == "AFK_ENABLE" then --Activate AntiAFK
					AFK_ENABLE = v
					if AFK_ENABLE == true then
						checkboxAntiAFK:SetValue( 1 )
					end
				elseif k == "AFK_GHOST" then --Activate AntiAFK
					AFK_GHOST = v
					if AFK_GHOST == true then
						checkboxGHOST:SetValue( 1 )
					end
				elseif k == "AFK_DARKRPMONEY" then --Activate AntiAFK
					AFK_DARKRPMONEY = v
					if AFK_DARKRPMONEY == true then
						checkboxDarkRPFreeze:SetValue( 1 )
					end
				end
			end
		elseif data5 == "Settings" then -- to load separate data
        	for k,v in pairs(data4) do
				if k == "WARN" then
					TextEntry2:SetValue(tonumber(v,10))
				elseif k == "KICK" then
					TextEntry:SetValue(tonumber(v,10))
				end
			end
		end

	function checkboxGroupsbypass:OnChange( val )
		surface.PlaySound( "ui/buttonclick.wav" )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["BYPASS"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["BYPASS"] = false }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end


	function checkboxUbypass:OnChange( val )
		surface.PlaySound( "ui/buttonclick.wav" )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["UBYPASS"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["UBYPASS"] = false  }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end


	function checkboxAntiAFK:OnChange( val )
		surface.PlaySound( "ui/buttonclick.wav" )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["ANTIAFK"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["ANTIAFK"] = false }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end


	function checkboxGHOST:OnChange( val )
		surface.PlaySound( "ui/buttonclick.wav" )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["GHOST"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["GHOST"] = false  }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end


	function checkboxDarkRPFreeze:OnChange( val )
		surface.PlaySound( "ui/buttonclick.wav" )
		if val then
			net.Start("nnt-antiak-settings")
				local temptable = {["DARKPMONEY"] = true }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		else
			net.Start("nnt-antiak-settings")
				local temptable = {["DARKPMONEY"] = false  }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
		end
	end

	end)


--[[
 /$$   /$$  /$$$$$$  /$$$$$$$$ /$$$$$$$   /$$$$$$        /$$      /$$ /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$$$  /$$       /$$$$$$  /$$$$$$  /$$$$$$$$
| $$  | $$ /$$__  $$| $$_____/| $$__  $$ /$$__  $$      | $$  /$ | $$| $$  | $$|_  $$_/|__  $$__/| $$_____/ | $$      |_  $$_/ /$$__  $$|__  $$__/
| $$  | $$| $$  \__/| $$      | $$  \ $$| $$  \__/      | $$ /$$$| $$| $$  | $$  | $$     | $$   | $$       | $$        | $$  | $$  \__/   | $$
| $$  | $$|  $$$$$$ | $$$$$   | $$$$$$$/|  $$$$$$       | $$/$$ $$ $$| $$$$$$$$  | $$     | $$   | $$$$$    | $$        | $$  |  $$$$$$    | $$
| $$  | $$ \____  $$| $$__/   | $$__  $$ \____  $$      | $$$$_  $$$$| $$__  $$  | $$     | $$   | $$__/    | $$        | $$   \____  $$   | $$
| $$  | $$ /$$  \ $$| $$      | $$  \ $$ /$$  \ $$      | $$$/ \  $$$| $$  | $$  | $$     | $$   | $$       | $$        | $$   /$$  \ $$   | $$
|  $$$$$$/|  $$$$$$/| $$$$$$$$| $$  | $$|  $$$$$$/      | $$/   \  $$| $$  | $$ /$$$$$$   | $$   | $$$$$$$$ | $$$$$$$$ /$$$$$$|  $$$$$$/   | $$
 \______/  \______/ |________/|__/  |__/ \______/       |__/     \__/|__/  |__/|______/   |__/   |________/ |________/|______/ \______/    |__/

 /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
| $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$      | $$  | $$| $$\  $$$| $$      | $$
| $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/      |__/  |__/|__/  \__/|________/|________/
]]


	local AdminPanelUsers_view = vgui.Create("DListView")
	AdminPanelUsers_view:SetParent(WhitelistS)
	AdminPanelUsers_view:SetPos(0, 30)
	AdminPanelUsers_view:SetSize(225, 200)
	AdminPanelUsers_view:SetMultiSelect(false)
	--AdminPanelUsers_view.OnClickLine = function(parent,selected,isselected) print(selected:GetValue(1)) end
	AdminPanelUsers_view.OnRowSelected = function(parent,selected,isselected) print(isselected:GetValue(1))
			tauser = isselected:GetValue(1)
	end
	AdminPanelUsers_view:AddColumn("SteamID")
	AdminPanelUsers_view:AddColumn("Name")
	AdminPanelUsers_view:SetSortable(true)

	local UserList = vgui.Create( "DComboBox" , WhitelistS )
	UserList:SetPos( 45, 240 )
	UserList:SetSize( 130, 20 )
	UserList:SetValue( "Select!" )

		net.Start("AntiAfkloaBypassUsers")
		net.SendToServer()
		net.Receive("AntiAfksenBypassUsers", function(len)
			AdminPanelUsers_view:Clear()
			antiuserstring = net.ReadTable()
			for k,v in pairs(antiuserstring) do
				if !IsValid(player.GetBySteamID(v)) then
					local plyname = v
					AdminPanelUsers_view:AddLine(k,plyname)
				else
					local plyname = v
					AdminPanelUsers_view:AddLine(k,plyname)
				end
			end
			UserList:Clear()
			for k, v in pairs( player.GetAll() ) do
				if !antiuserstring[v:SteamID()] then
					UserList:AddChoice( v:Nick() )
				end
			end
		end)



	UserList.OnSelect = function( a, b, value )
		for k,v in pairs(player.GetAll()) do
			if v == nil then print("NO PLAYER") return end
			if v:Nick() == value then
				SelectedPlayeris = v
			end
		end
	end


	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( WhitelistS )
	addgroups:SetText( "Add User" )
	addgroups:SetPos( 125, 270)
	addgroups:SetSize( 100, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		if SelectedPlayeris == nil then print("NO PLAYER") return end
		if string.StartWith(SelectedPlayeris:SteamID() , " " ) then
			LocalPlayer():ChatPrint('You cannot add a user starting with a space !')
		return end
		if SelectedPlayeris:SteamID() == "" then
			LocalPlayer():ChatPrint('You cannot add a empty user !')
		return end
		if antiuserstring[SelectedPlayeris:SteamID()] then
			LocalPlayer():ChatPrint('User ' .. SelectedPlayeris:Nick() ..' is already there !')
		return end
		net.Start("AntiAddBypassUsers")
			net.WriteString(SelectedPlayeris:SteamID())
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( WhitelistS )
	delbutton:SetText( "Del User" )
	delbutton:SetPos( 0, 270)
	delbutton:SetSize( 100, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		net.Start("AntiRemBypassUsers")
			net.WriteString(tauser)
		net.SendToServer()
	end

--[[
  /$$$$$$  /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$   /$$$$$$        /$$      /$$ /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$$$ /$$       /$$$$$$  /$$$$$$  /$$$$$$$$
 /$$__  $$| $$__  $$ /$$__  $$| $$  | $$| $$__  $$ /$$__  $$      | $$  /$ | $$| $$  | $$|_  $$_/|__  $$__/| $$_____/| $$      |_  $$_/ /$$__  $$|__  $$__/
| $$  \__/| $$  \ $$| $$  \ $$| $$  | $$| $$  \ $$| $$  \__/      | $$ /$$$| $$| $$  | $$  | $$     | $$   | $$      | $$        | $$  | $$  \__/   | $$
| $$ /$$$$| $$$$$$$/| $$  | $$| $$  | $$| $$$$$$$/|  $$$$$$       | $$/$$ $$ $$| $$$$$$$$  | $$     | $$   | $$$$$   | $$        | $$  |  $$$$$$    | $$
| $$|_  $$| $$__  $$| $$  | $$| $$  | $$| $$____/  \____  $$      | $$$$_  $$$$| $$__  $$  | $$     | $$   | $$__/   | $$        | $$   \____  $$   | $$
| $$  \ $$| $$  \ $$| $$  | $$| $$  | $$| $$       /$$  \ $$      | $$$/ \  $$$| $$  | $$  | $$     | $$   | $$      | $$        | $$   /$$  \ $$   | $$
|  $$$$$$/| $$  | $$|  $$$$$$/|  $$$$$$/| $$      |  $$$$$$/      | $$/   \  $$| $$  | $$ /$$$$$$   | $$   | $$$$$$$$| $$$$$$$$ /$$$$$$|  $$$$$$/   | $$
 \______/ |__/  |__/ \______/  \______/ |__/       \______/       |__/     \__/|__/  |__/|______/   |__/   |________/|________/|______/ \______/    |__/

 /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
| $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$      | $$  | $$| $$\  $$$| $$      | $$
| $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/      |__/  |__/|__/  \__/|________/|________/
]]

	local AdminPanelGroups_view = vgui.Create("DListView")
	AdminPanelGroups_view:SetParent(WhitelistS)
	AdminPanelGroups_view:SetPos(260, 30)
	AdminPanelGroups_view:SetSize(225, 200)
	AdminPanelGroups_view:SetMultiSelect(false)
	AdminPanelGroups_view.OnRowSelected = function( panel, rowIndex, row )
			tagroups = row:GetValue(1)
	end
	AdminPanelGroups_view:AddColumn("Groups")
	AdminPanelGroups_view:SetSortable(true)
	if ulx then
		local GroupList = vgui.Create( "DComboBox" , WhitelistS )
		GroupList:SetPos( 310, 240 )
		GroupList:SetSize( 130, 20 )
		GroupList:SetValue( "Select a group" )


		net.Start("AntiAfkloaBypassGroups")
		net.SendToServer()
		net.Receive("AntiAfksenBypassGroups", function(len)
			AdminPanelGroups_view:Clear()
			antiusergroupsstring = net.ReadTable()
			for k,v in pairs(antiusergroupsstring) do
				AdminPanelGroups_view:AddLine(v)
			end
			GroupList:Clear()
			for k, v in pairs( ulx.group_names ) do
				if !(table.HasValue(antiusergroupsstring, v)) then
					GroupList:AddChoice( v )
				end
			end
		end)


		GroupList.OnSelect = function( a, b, value )
			SelectedGroups = value

		end
	else
		net.Start("AntiAfkloaBypassGroups")
		net.SendToServer()
		net.Receive("AntiAfksenBypassGroups", function(len)
			AdminPanelGroups_view:Clear()
			antiusergroupsstring = net.ReadTable()
			for k,v in pairs(antiusergroupsstring) do
				AdminPanelGroups_view:AddLine(v)
			end
		end)
		local GroupList = vgui.Create( "DTextEntry", WhitelistS ) -- create the form as a child of frame
		GroupList:SetPos( 135, 244 )
		GroupList:SetSize( 130, 20 )
		GroupList:SetText( "Enter group name" )
		GroupList.OnChange = function( self )
			SelectedGroups = GroupList:GetValue()	-- print the form's text as server text
		end
	end


	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( WhitelistS )
	addgroups:SetText( "Add Groups" )
	addgroups:SetPos( 385, 270)
	addgroups:SetSize( 100, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		if SelectedGroups == "" or SelectedGroups == nil then
			LocalPlayer():ChatPrint('You cannot add a empty group !')
		return end
		if string.StartWith(SelectedGroups , " " ) then
			LocalPlayer():ChatPrint('You cannot add group starting with a space !')
		return end
		if table.HasValue(antiusergroupsstring, SelectedGroups) then
			LocalPlayer():ChatPrint('User group ' .. SelectedGroups ..' is already there !')
		return end
		net.Start("AntiAddBypassGroups")
			net.WriteString(SelectedGroups)
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( WhitelistS )
	delbutton:SetText( "Del Groups" )
	delbutton:SetPos( 260, 270)
	delbutton:SetSize( 100, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
		surface.PlaySound( "ui/buttonclick.wav" )
		net.Start("AntiRemBypassGroups")
			net.WriteString(tagroups)
		net.SendToServer()
	end

--[[
  /$$$$$$  /$$$$$$$$ /$$$$$$$$        /$$$$$$  /$$$$$$$$ /$$   /$$       /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
 /$$__  $$| $$_____/|__  $$__/       /$$__  $$| $$_____/| $$  /$$/      | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$  \__/| $$         | $$         | $$  \ $$| $$      | $$ /$$/       | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
|  $$$$$$ | $$$$$      | $$         | $$$$$$$$| $$$$$   | $$$$$/        | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
 \____  $$| $$__/      | $$         | $$__  $$| $$__/   | $$  $$        | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
 /$$  \ $$| $$         | $$         | $$  | $$| $$      | $$\  $$       | $$      | $$  | $$| $$\  $$$| $$      | $$
|  $$$$$$/| $$$$$$$$   | $$         | $$  | $$| $$      | $$ \  $$      | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
 \______/ |________/   |__/         |__/  |__/|__/      |__/  \__/      |__/      |__/  |__/|__/  \__/|________/|________/
]]


	local list_view = vgui.Create("DListView")
	list_view:SetParent(SetAFKMenu)
	list_view:SetPos(5, 30)
	list_view:SetSize(475, 175)
	list_view:SetMultiSelect(false)
	list_view.OnRowSelected = function( panel, rowIndex, row )
			taplayer = row:GetValue(2)
	end
	list_view:AddColumn("Player") -- Add columnfor k,v inpairs(player.GetAll()) do
	list_view:AddColumn("SteamID")
	for k,v in pairs(player.GetAll()) do
    	list_view:AddLine(v:Nick(), v:SteamID()) -- Add lines
	end
    local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( SetAFKMenu )
    TextEntry:SetPos( 205, 220 )
    TextEntry:SetSize( 75, 25 )
    TextEntry:SetMin( 180 )
    TextEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

	local list_btn = vgui.Create("DButton")
	list_btn:SetParent( SetAFKMenu )
	list_btn:SetText( "Set AFK" )
	list_btn:SetPos( 170, 260)
	list_btn:SetSize( 150, 25 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 10, 0, 0, w, h,  Color(145, 0, 0, 230) ) end
	list_btn.DoClick = function ()
			LocalPlayer():ConCommand( 'setafkplayer "' .. taplayer ..'" ' .. TextEntry:GetValue()  )
	end


end

--[[
 /$$   /$$             /$$           /$$       /$$ /$$
| $$$ | $$            | $$          | $$      |__/| $$
| $$$$| $$  /$$$$$$  /$$$$$$        | $$       /$$| $$$$$$$   /$$$$$$  /$$$$$$   /$$$$$$  /$$   /$$
| $$ $$ $$ /$$__  $$|_  $$_/        | $$      | $$| $$__  $$ /$$__  $$|____  $$ /$$__  $$| $$  | $$
| $$  $$$$| $$$$$$$$  | $$          | $$      | $$| $$  \ $$| $$  \__/ /$$$$$$$| $$  \__/| $$  | $$
| $$\  $$$| $$_____/  | $$ /$$      | $$      | $$| $$  | $$| $$      /$$__  $$| $$      | $$  | $$
| $$ \  $$|  $$$$$$$  |  $$$$/      | $$$$$$$$| $$| $$$$$$$/| $$     |  $$$$$$$| $$      |  $$$$$$$
|__/  \__/ \_______/   \___/        |________/|__/|_______/ |__/      \_______/|__/       \____  $$
                                                                                          /$$  | $$
                                                                                         |  $$$$$$/
                                                                                          \______/
]]

net.Receive("AntiAfkSendHUDInfo", function()
	local data1 = net.ReadString()
	if (data1 == "AntiafkAdminSetAfk") then
		NNTAntiafkAdminPanel("setafk")
	elseif (data1 == "AntiafkMainHUD") then
		RunString(NNTAntiafkThemes[AntiAfkSelTheme].."()","Load Warning")
	elseif (data1 == "AntiafkMainHUDSP") then
		NNTAntiafkMainHUDSP()
	elseif (data1 == "AntiafkAdminPanel") then
		NNTAntiafkAdminPanel()
	elseif (data1 == "AntiafkAdminPanelGroups") then
		NNTAntiafkAdminPanelGroups()
	elseif table.HasValue(AntiAfkDisponibleThemes, data1) then
		AntiAfkSelTheme = data1
		print("ANTIAFK: THEMES SELECTED : " .. AntiAfkSelTheme)
	elseif table.HasValue(AntiAfkDisponibleLang, data1) then
		AntiAfkLanguage = data1
		print("ANTIAFK: LANGUAGE SETTINGS RECEIVED : " .. AntiAfkLanguage)
	end
end)
net.Receive("BroadcastAFKPLAYER", function()
	local data2 = net.ReadTable()
	if data2["AFKSTATE"] == true then
		afktext = AntiAfkTranslate[AntiAfkLanguage]["NOWAFK"]
		afkcolor = Color( 198, 0, 0 )
	elseif data2["AFKSTATE"] == false then
		afktext = AntiAfkTranslate[AntiAfkLanguage]["NOLONGERAFK"]
		afkcolor = Color( 0, 0, 198 )
	end
	chat.AddText( Color( 255, 255, 255 ), "[ANTI-AFK]: ",Color( 0, 198, 0 ),data2["PlayerName"],afkcolor, " ", afktext)
end)
--[[
 /$$$$$$$$ /$$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$  /$$        /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$  /$$   /$$
|__  $$__/| $$__  $$ /$$__  $$| $$$ | $$ /$$__  $$| $$       /$$__  $$|__  $$__/|_  $$_/ /$$__  $$| $$$ | $$
   | $$   | $$  \ $$| $$  \ $$| $$$$| $$| $$  \__/| $$      | $$  \ $$   | $$     | $$  | $$  \ $$| $$$$| $$
   | $$   | $$$$$$$/| $$$$$$$$| $$ $$ $$|  $$$$$$ | $$      | $$$$$$$$   | $$     | $$  | $$  | $$| $$ $$ $$
   | $$   | $$__  $$| $$__  $$| $$  $$$$ \____  $$| $$      | $$__  $$   | $$     | $$  | $$  | $$| $$  $$$$
   | $$   | $$  \ $$| $$  | $$| $$\  $$$ /$$  \ $$| $$      | $$  | $$   | $$     | $$  | $$  | $$| $$\  $$$
   | $$   | $$  | $$| $$  | $$| $$ \  $$|  $$$$$$/| $$$$$$$$| $$  | $$   | $$    /$$$$$$|  $$$$$$/| $$ \  $$
   |__/   |__/  |__/|__/  |__/|__/  \__/ \______/ |________/|__/  |__/   |__/   |______/ \______/ |__/  \__/
]]

AntiAfkTranslate = AntiAfkTranslate or {}

AntiAfkDisponibleLang = {}

AntiAfkLanguage = "EN"

for _,v in pairs((file.Find("nnt-antiafk/lang/*.lua","LUA"))) do
	include("nnt-antiafk/lang/" .. v)
    print("Loaded " ..v )
end

AntiAfkDisponibleLang = {}

for k,v in pairs(AntiAfkTranslate) do
	table.insert(AntiAfkDisponibleLang, table.Count(AntiAfkDisponibleLang) + 1,k)
end

--[[
 /$$      /$$  /$$$$$$  /$$$$$$$  /$$   /$$ /$$$$$$ /$$   /$$  /$$$$$$        /$$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$
| $$  /$ | $$ /$$__  $$| $$__  $$| $$$ | $$|_  $$_/| $$$ | $$ /$$__  $$      | $$__  $$ /$$__  $$| $$$ | $$| $$_____/| $$
| $$ /$$$| $$| $$  \ $$| $$  \ $$| $$$$| $$  | $$  | $$$$| $$| $$  \__/      | $$  \ $$| $$  \ $$| $$$$| $$| $$      | $$
| $$/$$ $$ $$| $$$$$$$$| $$$$$$$/| $$ $$ $$  | $$  | $$ $$ $$| $$ /$$$$      | $$$$$$$/| $$$$$$$$| $$ $$ $$| $$$$$   | $$
| $$$$_  $$$$| $$__  $$| $$__  $$| $$  $$$$  | $$  | $$  $$$$| $$|_  $$      | $$____/ | $$__  $$| $$  $$$$| $$__/   | $$
| $$$/ \  $$$| $$  | $$| $$  \ $$| $$\  $$$  | $$  | $$\  $$$| $$  \ $$      | $$      | $$  | $$| $$\  $$$| $$      | $$
| $$/   \  $$| $$  | $$| $$  | $$| $$ \  $$ /$$$$$$| $$ \  $$|  $$$$$$/      | $$      | $$  | $$| $$ \  $$| $$$$$$$$| $$$$$$$$
|__/     \__/|__/  |__/|__/  |__/|__/  \__/|______/|__/  \__/ \______/       |__/      |__/  |__/|__/  \__/|________/|________/
]]
function NNTAntiafkMainHUD()

	local w = ScrW() / 2
    local h = ScrH() / 2

	AntiAFKTimer = AntiAFKTimer or {}


    VarTimeleft = "00m 00s"


    surface.CreateFont( "AFKLarge", {
	font = "Arial",
	extended = false,
	size = 60,
    } )
    surface.CreateFont( "AFKMedium", {
	font = "Arial",
	extended = false,
	size = 30,
    } )
    surface.CreateFont( "AFKsmall", {
	font = "Arial",
	extended = false,
	size = 21,
    } )
    surface.CreateFont( "AFKsmallK", {
	font = "Arial",
	extended = false,
	size = 18,
    } )

	function timeToStr( time )
		local tmp = time
		local s = tmp % 60
		tmp = math.floor( tmp / 60 )
		local m = tmp
		return string.format( "%02im %02is", m, s )
	end
	AntiAFKTimer.TimeLeft = "00m 00s"

	net.Start("AFKHUD2")
	net.SendToServer()
	net.Receive("AFKHUDR", function(len)
		ReceiveVar = net.ReadString()
		VarTimeleft = ReceiveVar
		timer.Create( "AFK:"..LocalPlayer():SteamID(), 1, ReceiveVar, function()
			x = VarTimeleft - 1
			VarTimeleft = x
			AntiAFKTimer.TimeLeft = timeToStr(VarTimeleft)
		end)
	end)

	local AfkPanelHUD = vgui.Create( "DFrame" )
	AfkPanelHUD:SetPos( ScrW() - w * 1.5  , h-200 )
	AfkPanelHUD:SetSize( ScrW()/2, ScrH() / 3 )
	AfkPanelHUD:SetTitle( "" )
	AfkPanelHUD:SetDraggable( true )
	AfkPanelHUD:ShowCloseButton( false )
	AfkPanelHUD:SetKeyBoardInputEnabled()
	AfkPanelHUD:SetMouseInputEnabled()
	AfkPanelHUD:SetDraggable(false)
	function AfkPanelHUD:Paint(w, h)
		draw.RoundedBox( 30, 0, 0, w, h,  Color(0, 0, 0, 235))
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["MAINTEXT"] , "AFKLarge", ScrW() - w * 1.5  , ScrH() / 16, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["WARN"].. " " .. AntiAFKTimer.TimeLeft , "AFKMedium", ScrW() - w * 1.5  , ScrH() / 7, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["CANCEL"] , "AFKsmall", ScrW() - w * 1.5  , ScrH() / 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( AntiAfkTranslate[AntiAfkLanguage]["MOVEKEY"]  , "AFKsmallK", ScrW() - w * 1.5  , ScrH() / 4, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end


	timer.Create( "AFKS:"..LocalPlayer():SteamID(), 30, 0, function()
		surface.PlaySound("buttons/button18.wav")
		surface.PlaySound("buttons/button18.wav")
		surface.PlaySound("buttons/button18.wav")
	end)


	net.Start("AFKHUD1")
	net.Receive("AFKHUD1", function(len)
		timer.Destroy("AFK:"..LocalPlayer():SteamID())
		timer.Destroy("AFKS:"..LocalPlayer():SteamID())
		AfkPanelHUD:Close()
	end)

	surface.PlaySound("buttons/button18.wav")
	surface.PlaySound("buttons/button18.wav")
	surface.PlaySound("buttons/button18.wav")


end

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


function NNTAntiafkAdminPanelUsers()


    local w = ScrW() / 2
    local h = ScrH() / 2

	local AdminPanelUsers = vgui.Create( "DFrame" )
	AdminPanelUsers:SetPos( w-200, h-200 )
	AdminPanelUsers:SetSize( 400, 430 )
	AdminPanelUsers:SetTitle( "" )
	AdminPanelUsers:SetDraggable( true )
	AdminPanelUsers:ShowCloseButton( false  )
	AdminPanelUsers:MakePopup()
	function AdminPanelUsers:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 175))
	end

	local ReturnBut  = vgui.Create( "DImageButton", AdminPanelUsers )
	ReturnBut:SetPos( 5, 0 )
	ReturnBut:SetSize( 32, 32 )
	ReturnBut:SetImage( "icon16/arrow_left.png" )
	ReturnBut.DoClick = function()
		AdminPanelUsers:Close()
		NNTAntiafkAdminPanel()
	end

	local AdminPanelUsers_view = vgui.Create("DListView")
	AdminPanelUsers_view:SetParent(AdminPanelUsers)
	AdminPanelUsers_view:SetPos(0, 30)
	AdminPanelUsers_view:SetSize(400, 300)
	AdminPanelUsers_view:SetMultiSelect(false)
	--AdminPanelUsers_view.OnClickLine = function(parent,selected,isselected) print(selected:GetValue(1)) end
	AdminPanelUsers_view.OnRowSelected = function(parent,selected,isselected) print(isselected:GetValue(1))
			tauser = isselected:GetValue(1)
	end
	AdminPanelUsers_view:AddColumn("SteamID")
	AdminPanelUsers_view:AddColumn("Name")

	local UserList = vgui.Create( "DComboBox" , AdminPanelUsers )
	UserList:SetPos( 150, 340 )
	UserList:SetSize( 100, 20 )
	UserList:SetValue( "Select Player !" )

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
			if v:Nick() == value then
				SelectedPlayeris = v
				print(SelectedPlayeris:SteamID())
			end
		end
	end

	for k, v in pairs( player.GetAll() ) do
		if !antiuserstring[v:SteamID()] then
			UserList:AddChoice( v:Nick() )
		end
	end

	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( AdminPanelUsers )
	addgroups:SetText( "Add User" )
	addgroups:SetPos( 220, 380)
	addgroups:SetSize( 150, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
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
	delbutton:SetParent( AdminPanelUsers )
	delbutton:SetText( "Del User" )
	delbutton:SetPos( 30, 380)
	delbutton:SetSize( 150, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
		net.Start("AntiRemBypassUsers")
			net.WriteString(tauser)
		net.SendToServer()
	end


	local Sign = vgui.Create( "DLabel", AdminPanelUsers )
	Sign:SetPos( 25, 410 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )


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

function NNTAntiafkAdminPanelGroups()


    local w = ScrW() / 2
    local h = ScrH() / 2

	local AdminPanelGroups = vgui.Create( "DFrame" )
	AdminPanelGroups:SetPos( w-200, h-200 )
	AdminPanelGroups:SetSize( 400, 430 )
	AdminPanelGroups:SetTitle( "" )
	AdminPanelGroups:SetDraggable( true )
	AdminPanelGroups:ShowCloseButton( false )
	AdminPanelGroups:MakePopup()
	function AdminPanelGroups:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 175))
	end

	local ReturnBut  = vgui.Create( "DImageButton", AdminPanelGroups )
	ReturnBut:SetPos( 5, 0 )
	ReturnBut:SetSize( 32, 32 )
	ReturnBut:SetImage( "icon16/arrow_left.png" )
	ReturnBut.DoClick = function()
		AdminPanelGroups:Close()
		NNTAntiafkAdminPanel()
	end



	local AdminPanelGroups_view = vgui.Create("DListView")
	AdminPanelGroups_view:SetParent(AdminPanelGroups)
	AdminPanelGroups_view:SetPos(0, 30)
	AdminPanelGroups_view:SetSize(400, 300)
	AdminPanelGroups_view:SetMultiSelect(false)
	AdminPanelGroups_view.OnRowSelected = function( panel, rowIndex, row )
			tagroups = row:GetValue(1)
	end
	AdminPanelGroups_view:AddColumn("Groups")

	local GroupList = vgui.Create( "DComboBox" , AdminPanelGroups )
	GroupList:SetPos( 150, 340 )
	GroupList:SetSize( 100, 20 )
	GroupList:SetValue( "Select Group !" )


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

	for k, v in pairs( ulx.group_names ) do
		if !(table.HasValue(antiusergroupsstring, v)) then
			GroupList:AddChoice( v )
		end
	end

	local addgroups = vgui.Create("DButton")
	addgroups:SetParent( AdminPanelGroups )
	addgroups:SetText( "Add Groups" )
	addgroups:SetPos( 220, 380)
	addgroups:SetSize( 150, 25 )
    addgroups:SetColor(Color(255, 255, 255))
	addgroups.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	addgroups.DoClick = function ()
		if string.StartWith(SelectedGroups , " " ) then
			LocalPlayer():ChatPrint('You cannot add group starting with a space !')
		return end
		if SelectedGroups == "" then
			LocalPlayer():ChatPrint('You cannot add a empty group !')
		return end
		if table.HasValue(antiusergroupsstring, SelectedGroups) then
			LocalPlayer():ChatPrint('User group ' .. SelectedGroups ..' is already there !')
		return end
		net.Start("AntiAddBypassGroups")
			net.WriteString(SelectedGroups)
		net.SendToServer()
	end

	local delbutton = vgui.Create("DButton")
	delbutton:SetParent( AdminPanelGroups )
	delbutton:SetText( "Del Groups" )
	delbutton:SetPos( 30, 380)
	delbutton:SetSize( 150, 25 )
    delbutton:SetColor(Color(255, 255, 255))
	delbutton.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	delbutton.DoClick = function ()
		net.Start("AntiRemBypassGroups")
			net.WriteString(tagroups)
		net.SendToServer()
	end


	local Sign = vgui.Create( "DLabel", AdminPanelGroups )
	Sign:SetPos( 25, 410 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )


end

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
function NNTAntiafkAdminPanel()

    local w = ScrW() / 2
    local h = ScrH() / 2
    PanelOff = nil
    SomeShittyTest = "undefined"
    SomeShittyTest1 = "undefined"
	SomeShittyTest2 = "undefined"
	SomeShittyTest3 = "undefined"



	local MainPanel = vgui.Create( "DFrame" )
	MainPanel:SetPos( w-200, h-200 )
	MainPanel:SetSize( 300, 200 )
	MainPanel:SetTitle( "ANTI AFK ADMIN PANEL" )
	MainPanel:SetDraggable( true )
	MainPanel:ShowCloseButton( false )
	MainPanel:MakePopup()

	local ExitBut = vgui.Create( "DImageButton", MainPanel )
	ExitBut:SetPos( 266, 10 )
	ExitBut:SetSize( 24, 24 )
	ExitBut:SetImage( "icon16/cross.png" )
	ExitBut.DoClick = function()
		MainPanel:Close()
	end
	function MainPanel:Paint(w, h)
		draw.RoundedBox( 20, 0, 0, w, h,  Color(0, 0, 0, 225))
	end


    local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( MainPanel )
    TextEntry:SetPos( 22, 130 )
    TextEntry:SetSize( 65, 25 )
    TextEntry:SetMin( 180 )
    TextEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

    local TextEntry2 = vgui.Create( "DNumberWang")
    TextEntry2:SetParent( MainPanel )
    TextEntry2:SetPos( 120, 130 )
    TextEntry2:SetSize( 65, 25 )
    TextEntry2:SetMin( 180 )
    TextEntry2.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

    local info = vgui.Create( "DLabel", MainPanel )
    info:SetPos( 200, 110 )
    info:SetSize(280, 100)
    info:SetText('Current Time : ' .. SomeShittyTest )
	info:SetColor(Color(255,255,0))

    local info2 = vgui.Create( "DLabel", MainPanel )
    info2:SetPos( 200, 122 )
    info2:SetSize(280, 100)
    info2:SetText('Warn Time : ' .. "Refresh !" )
	info2:SetColor(Color(255,255,0))


	-- Groups Bypass
	local checkboxGroupsbypass = vgui.Create( "DCheckBoxLabel", MainPanel )
	checkboxGroupsbypass:SetPos( 22, 90 )
	checkboxGroupsbypass:SetText( "Groups Bypass" )

	function checkboxGroupsbypass:OnChange( val )
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


	-- User Bypass
	local checkboxUbypass = vgui.Create( "DCheckBoxLabel", MainPanel )
	checkboxUbypass:SetPos( 22, 70 )
	checkboxUbypass:SetText( "User Bypass" )

	function checkboxUbypass:OnChange( val )
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


	-- Anti AFK ENABLE
	local checkboxAntiAFK = vgui.Create( "DCheckBoxLabel", MainPanel )
	checkboxAntiAFK:SetPos( 22, 50 )
	checkboxAntiAFK:SetText( "Activate AntiAFK" )

	function checkboxAntiAFK:OnChange( val )
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



	local SelectTranslate = vgui.Create( "DComboBox", MainPanel )
	SelectTranslate:SetPos( 205, 97 )
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
				--[[net.Start("AntiAfkSendHUDInfo")
					net.WriteString(k)
				net.SendToServer()]]
			end
		end
	end

    local list_btn = vgui.Create("DButton")
	list_btn:SetParent( MainPanel )
	list_btn:SetText( "SET KICK" )
	list_btn:SetPos( 22, 160)
	list_btn:SetSize( 65, 20 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn.DoClick = function ()
			net.Start("nnt-antiak-settings")
				local temptable = {["KICK"] = TextEntry:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
	end

    local list_btn2 = vgui.Create("DButton")
	list_btn2:SetParent( MainPanel )
	list_btn2:SetText( "SET WARN" )
	list_btn2:SetPos( 120, 160)
	list_btn2:SetSize( 65, 20 )
    list_btn2:SetColor(Color(255, 255, 255))
	list_btn2.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn2.DoClick = function ()
            net.Start("nnt-antiak-settings")
				local temptable = {["WARN"] = TextEntry2:GetValue() }
				net.WriteTable(temptable)
				net.WriteString("SetSettings")
            net.SendToServer()
	end


	local Groups_btn = vgui.Create("DButton")
	Groups_btn:SetParent( MainPanel )
	Groups_btn:SetText( "Groups" )
	Groups_btn:SetPos( 213, 70 )
	Groups_btn:SetSize( 55, 20 )
    Groups_btn:SetColor(Color(255, 255, 255))
	Groups_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Groups_btn.DoClick = function ()
		NNTAntiafkAdminPanelGroups()
		MainPanel:Close()
	end

	local Users_btn = vgui.Create("DButton")
	Users_btn:SetParent( MainPanel )
	Users_btn:SetText( "Users" )
	Users_btn:SetPos( 213, 45 )
	Users_btn:SetSize( 55, 20 )
    Users_btn:SetColor(Color(255, 255, 255))
	Users_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	Users_btn.DoClick = function ()
		NNTAntiafkAdminPanelUsers()
		MainPanel:Close()
	end

	local Sign = vgui.Create( "DLabel", MainPanel )
	Sign:SetPos( 100, 180 )
	Sign:SetSize(150 , 25)
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
					info2:SetText('Warn Time : ' .. v )
				elseif k == "AFK_TIME" then
					AFK_TIME = v
					info:SetText('Current Time : ' .. v )
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
				elseif k == "AFK_TIME" then
					AFK_TIME = v
					info:SetText('Current Time : ' .. v )
				end
			end
		elseif data5 == "Settings" then -- to load separate data
        	for k,v in pairs(data4) do
				if k == "WARN" then
					info2:SetText('Warn Time : ' .. v )
				elseif k == "KICK" then
					info:SetText('Current Time : ' .. v )
				elseif k == "ANTIAFK" then

				elseif k == "BYPASS" then

				elseif k == "UBYPASS" then

				end
			end
		end
	end)




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

function NNTAntiafkAdminSetAfk()


    local w = ScrW() / 2
    local h = ScrH() / 2

	local list_window = vgui.Create( "DFrame" )
	list_window:SetPos( w-200, h-200 )
	list_window:SetSize( 400, 555 )
	list_window:SetTitle( "Afk Set time" )
	list_window:SetDraggable( true )
	list_window:ShowCloseButton( true )
	list_window:MakePopup()
	function list_window:Paint(w, h)
		draw.RoundedBox( 4, 0, 0, w, h,  Color(0, 0, 0, 175))
	end

	local list_view = vgui.Create("DListView")
	list_view:SetParent(list_window)
	list_view:SetPos(0, 30)
	list_view:SetSize(400, 400)
	list_view:SetMultiSelect(false)
	list_view.OnRowSelected = function( panel, rowIndex, row )
			taplayer = row:GetValue(1)
	end
	list_view:AddColumn("Player") -- Add columnfor k,v inpairs(player.GetAll()) do
	for k,v in pairs(player.GetAll()) do
    	list_view:AddLine(v:Nick()) -- Add lines
	end

    local TextEntry = vgui.Create( "DNumberWang")
    TextEntry:SetParent( list_window )
    TextEntry:SetPos( 150, 440 )
    TextEntry:SetSize( 75, 25 )
    TextEntry:SetMin( 180 )
    TextEntry.OnEnter = function( self )
	    chat.AddText( self:GetValue() )	-- print the form's text as server text
    end

	local list_btn = vgui.Create("DButton")
	list_btn:SetParent( list_window )
	list_btn:SetText( "Set AFK" )
	list_btn:SetPos( 120, 480)
	list_btn:SetSize( 150, 25 )
    list_btn:SetColor(Color(255, 255, 255))
	list_btn.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h,  Color(145, 0, 0, 100) ) end
	list_btn.DoClick = function ()
			LocalPlayer():ConCommand( 'setafkplayer "' .. taplayer ..'" ' .. TextEntry:GetValue()  )
	end

	local Sign = vgui.Create( "DLabel", list_window )
	Sign:SetPos( 25, 520 )
	Sign:SetSize(150 , 25)
	Sign:SetText( "Made by Aiko Suzuki !" )



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
		NNTAntiafkAdminSetAfk()
	elseif (data1 == "AntiafkMainHUD") then
		NNTAntiafkMainHUD()
	elseif (data1 == "AntiafkMainHUDSP") then
		NNTAntiafkMainHUDSP()
	elseif (data1 == "AntiafkAdminPanel") then
		NNTAntiafkAdminPanel()
	elseif (data1 == "AntiafkAdminPanelGroups") then
		NNTAntiafkAdminPanelGroups()
	elseif table.HasValue(AntiAfkDisponibleLang, data1) then
		AntiAfkLanguage = data1
		print("ANTIAFK: LANGUAGE SETTINGS RECEIVED " .. AntiAfkLanguage)
	end
end)

--[[
 /$$   /$$ /$$   /$$ /$$$$$$$        /$$$$$$$   /$$$$$$  /$$$$$$ /$$   /$$ /$$$$$$$$
| $$  | $$| $$  | $$| $$__  $$      | $$__  $$ /$$__  $$|_  $$_/| $$$ | $$|__  $$__/
| $$  | $$| $$  | $$| $$  \ $$      | $$  \ $$| $$  \ $$  | $$  | $$$$| $$   | $$
| $$$$$$$$| $$  | $$| $$  | $$      | $$$$$$$/| $$$$$$$$  | $$  | $$ $$ $$   | $$
| $$__  $$| $$  | $$| $$  | $$      | $$____/ | $$__  $$  | $$  | $$  $$$$   | $$
| $$  | $$| $$  | $$| $$  | $$      | $$      | $$  | $$  | $$  | $$\  $$$   | $$
| $$  | $$|  $$$$$$/| $$$$$$$/      | $$      | $$  | $$ /$$$$$$| $$ \  $$   | $$
|__/  |__/ \______/ |_______/       |__/      |__/  |__/|______/|__/  \__/   |__/
]]

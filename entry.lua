local FM_dll=nil
-- Test Collision only
--local FM_dll= "A-6E_Intruder_FM.dll"
--Module entrance
local self_ID = "A-6E" --Define the module name and use it globally

declare_plugin(self_ID,
{
--Basic definition area
installed = true,
displayName = _("A-6E Intruder"), --module display name
developerName = _("Battlegear2099"), --Development team name
dirName = current_mod_path,

fileMenuName = _("A-6E"),
update_id = "A-6E",
version = "0.1.0", --current iteration version number
state = "installed",
info = _("A-6E is a WIP mod of DCS"), --Description information
encyclopedia_path = current_mod_path..'/Encyclopedia',
binaries =
{
     FM_dll
},

Skins =
{
{
name = _("A-6E"),
dir = "Theme"
},
},
Missions =
{
{
name = _("A-6E"),
dir = "Missions",
},
},
LogBook =
{
{
name = _("A-6E"),
type = "A-6E",
},
},
InputProfiles=
{
["A-6E"] = current_mod_path .. '/Input',
},

})
-------------------------------------------------- ----------------------------------
--Mount the 3D model directory and texture file directory
mount_vfs_texture_path (current_mod_path.."/Cockpit/Resources/Model/Textures")
mount_vfs_texture_path (current_mod_path.."/Cockpit/Textures/CPT_TEX")
--Mount model
mount_vfs_model_path (current_mod_path.."/Shapes")
mount_vfs_model_path (current_mod_path.."/Shapes/Loads") -- add weapon, pod and tanks

mount_vfs_liveries_path (current_mod_path.."/Liveries")
-- mount_vfs_liveries_path (current_mod_path.."/Theme/ME")
mount_vfs_texture_path (current_mod_path.."/Theme/ME")
mount_vfs_texture_path (current_mod_path.."/Textures")
mount_vfs_texture_path (current_mod_path.."/Textures/A-6E")
mount_vfs_texture_path (current_mod_path.."/Textures/A-6E-CPT")
mount_vfs_texture_path (current_mod_path.."/Textures/A-6E-WEAPON")
         
 
-------------------------------------------------- ----------------------------------------
-- Option Cockpit operationnel, HUD partiel
test_susp = {
{
wheel_radius = 0.45,
		
arg_post = 0,
arg_amortizer = 1,
arg_wheel_rotation = 76,
arg_wheel_yaw = 2,
collision_shell_name = "WHEEL_F",
},
{
wheel_radius = 0.77,
	
arg_post = 3,
arg_amortizer = 4,
arg_wheel_rotation = 77,
arg_wheel_yaw = -1,
collision_shell_name = "WHEEL_R",
},
{
wheel_radius = 0.77,
	
arg_post = 5,
arg_amortizer = 6,
arg_wheel_rotation = 77,
arg_wheel_yaw = -1,
collision_shell_name = "WHEEL_L",
},
}

local FM

dofile(current_mod_path.."/suspension.lua")

if FM_dll then
FM=
{
[1] = self_ID,
[2] = FM_dll,
center_of_mass = {0, -0.2, 0},--{5.8784 - 4.572, -0.7883, 0},
-- the moment_of_inertia is following the data from nasa
--reverse the axis of y and z
moment_of_inertia = {43580.057, 144223.779, 109659.913, - 2000},
suspension = suspension_data,
}
else
     FM=nil
end

make_flyable('A-6E', current_mod_path..'/Cockpit/Scripts/', FM, current_mod_path..'/comm.lua')

-- Load additional lua files
dofile(current_mod_path.."/A-6E.lua")
--dofile(current_mod_path.."/smoke.lua")

-- Load perspective
dofile(current_mod_path.."/Views.lua")
make_view_settings('A-6E', ViewSettings, SnapViews)


make_aircraft_carrier_capable('A-6E',{"AircraftCarrier","AircraftCarrier With Tramplin","AircraftCarrier With Catapult"})

plugin_done()
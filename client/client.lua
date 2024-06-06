-- ## Faint Command ## --
local ragdoll = false
function setRagdoll(flag)
  ragdoll = flag
end
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ragdoll then
      SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
      if IsControlJustPressed(0, 38) then -- 38 is the control the "E" key
        setRagdoll(false)
        ragdol = true
        lib.hideTextUI()
      end
    end
  end
end)
ragdol = true
RegisterNetEvent("Ragdoll")
AddEventHandler("Ragdoll", function()
  if ( ragdol ) then
    setRagdoll(true)
    lib.showTextUI('[E] To get up')
    ragdol = false
  else
    setRagdoll(false)
    ragdol = true
    lib.hideTextUI()
  end
end)

RegisterCommand("faint", function(source, args, raw) 
  TriggerEvent("Ragdoll")
end, false)


-- ## Die Command ## --
RegisterCommand("die", function(source, args, rawCommand)
    if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'mp_suicide',
            clip = 'pill',
        },
    }) then     
        lib.notify({
        title = 'Suicide',
        description = 'You killed yourself',
    }) else end
    local playerPed = GetPlayerPed(-1)
    SetEntityHealth(playerPed, 0)
end, false)



RegisterCommand("me", function(source , args, rawCommand)
    local Text = table.concat(args, ' ')
    TriggerClientEvent('me:image', -1, Text, source)
end, false)

RegisterCommand("mee", function(source , args, rawCommand)
    local Text = table.concat(args, ' ')
    TriggerClientEvent('me:image2', -1, Text, source)
end, false)

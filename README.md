# ygt_wallet

`inventory:server:UseItemSlot`

```lua 
if itemData.name == "wallet" then
  TriggerClientEvent('nw:wallet:client', src, itemData.info.walletid)
end
```

![image](https://cdn.discordapp.com/attachments/569978689241088109/892428099919175701/unknown.png)


`inventory:server:UseItem`

```lua 
if itemData.name == "wallet" then
  TriggerClientEvent('nw:wallet:client', src, itemData.info.walletid)
end
```

![image](https://cdn.discordapp.com/attachments/569978689241088109/892428516665208842/unknown.png)


`qb-inventory | app.js`

```javascript 
} else if (itemData.name == "wallet") {
  $(".item-info-title").html('<p>'+itemData.label+'</p>')
  $(".item-info-description").html('<p>Sahibi: ' + itemData.info.walletid + '</p>');
```

![image](https://cdn.discordapp.com/attachments/569978689241088109/892428755878936576/unknown.png)

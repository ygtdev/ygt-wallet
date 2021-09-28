# ygt_wallet

Önizleme: https://streamable.com/qawf4b
Gerekenler: https://github.com/ygtdev/ygt_base

Öncelikle dosyaları indirin ve indirdiğiniz dosyaları paketinize ekleyerek startını verin. Database wallet adında bir item ekleyin.(Yukarıda bulunan jsfour-idcard scriptini kendi paketinizdekiyle değiştirmeyi unutmayın!)

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

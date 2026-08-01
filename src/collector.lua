function yogi_magic_reload()

G.sealcollection = {}
for key, center in pairs(G.P_SEALS) do
    if center.set == "Seal" then
        table.insert(G.sealcollection, key)
    end
end

G.cardcollection = {}
for key, center in pairs(G.P_CARDS) do
    table.insert(G.cardcollection, key)
end

G.editioncollection = {}
for key, center in pairs(G.P_CENTERS) do
    if center.set == "Edition" then
        table.insert(G.editioncollection, key)
    end
end

G.enhancedcollection = {}
for key, center in pairs(G.P_CENTERS) do
    if center.set == "Enhanced" then
        table.insert(G.enhancedcollection, key)
    end
end


table.insert(G.sealcollection, nil)
table.insert(G.editioncollection, nil)
table.insert(G.enhancedcollection, "c_base")

print("[FAMS Y-SIDE] - loaded "..tostring(#G.sealcollection + #G.cardcollection + #G.editioncollection + #G.enhancedcollection).." of objects for challenge magic")

end


function build_large_textures()

G.lore1 = {}
for i = 1, 75 do
    table.insert(G.lore1, new_arbituary_image("textures/lore1/lore"..tonumber(i)..".png"))
end

G.lore2 = {}
for i = 1, 75 do
    table.insert(G.lore2, new_arbituary_image("textures/lore2/lore"..tonumber(i)..".png"))
end

G.lore3 = {}
for i = 1, 77 do
    table.insert(G.lore3, new_arbituary_image("textures/lore3/lore"..tonumber(i)..".png"))
end

G.lore4 = {}
for i = 1, 75 do
    table.insert(G.lore4, new_arbituary_image("textures/lore4/lore"..tonumber(i)..".png"))
end

G.lore5 = {}
for i = 1, 75 do
    table.insert(G.lore5, new_arbituary_image("textures/lore5/lore"..tonumber(i)..".png"))
end

G.lore6 = {}
for i = 1, 75 do
    table.insert(G.lore6, new_arbituary_image("textures/lore6/lore"..tonumber(i)..".png"))
end

G.lore7 = {}
for i = 1, 75 do
    table.insert(G.lore7, new_arbituary_image("textures/lore7/lore"..tonumber(i)..".png"))
end



end
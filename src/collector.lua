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
    G.coolAwesomeProphecyShader = new_arbituary_shader("deltARune")
    G.coolAwesomeProphecyShader:send("depths", new_arbituary_image("textures/depths.png"));
    G.lore = {
        new_arbituary_image("textures/lore/lore1.png"),
        new_arbituary_image("textures/lore/lore2.png"),
        new_arbituary_image("textures/lore/lore3.png"),
        new_arbituary_image("textures/lore/lore4.png"),
        new_arbituary_image("textures/lore/lore5.png"),
        new_arbituary_image("textures/lore/lore6.png"),
        new_arbituary_image("textures/lore/lore7.png")
    }
end
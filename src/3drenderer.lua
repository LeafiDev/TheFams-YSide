function draw_3d(x, y, z, size, rx, ry, rz, texture, color)

    local f = 400
    local cx, cy = 500, 300

    local cos = math.cos
    local sin = math.sin

    local verts = {
        {-1, -1, -1},
        { 1, -1, -1},
        { 1,  1, -1},
        {-1,  1, -1},

        {-1, -1,  1},
        { 1, -1,  1},
        { 1,  1,  1},
        {-1,  1,  1}
    }

    local points = {}

    for i, v in ipairs(verts) do

        local px = v[1] * size
        local py = v[2] * size
        local pz = v[3] * size

        local yy = py * cos(rx) - pz * sin(rx)
        local zz = py * sin(rx) + pz * cos(rx)

        py = yy
        pz = zz

        local xx = px * cos(ry) - pz * sin(ry)
        zz = px * sin(ry) + pz * cos(ry)

        px = xx
        pz = zz

        xx = px * cos(rz) - py * sin(rz)
        yy = px * sin(rz) + py * cos(rz)

        px = xx
        py = yy

        pz = pz + z

        local depth = pz + f

        if depth > 1 then

            local scale = f / depth

            points[i] = {
                cx + x + px * scale,
                cy + y + py * scale,

                pz
            }

        end
    end

    local faces = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {1, 2, 6, 5},
        {4, 3, 7, 8},
        {1, 4, 8, 5},
        {2, 3, 7, 6}
    }

    local colors = {
        {1, 0, 0, 1},
        {0, 1, 0, 1},
        {0, 0, 1, 1},
        {1, 1, 0, 1},
        {1, 0, 1, 1},
        {0, 1, 1, 1}
    }

    local uvs = {
        {0, 0},
        {1, 0},
        {1, 1},
        {0, 1}
    }

    local draw_faces = {}

    for n, face in ipairs(faces) do

        local a = points[face[1]]
        local b = points[face[2]]
        local c = points[face[3]]
        local d = points[face[4]]

        if a and b and c and d then

            local depth =
                (a[3] +
                 b[3] +
                 c[3] +
                 d[3]) / 4

            draw_faces[#draw_faces + 1] = {
                face = face,
                index = n,
                depth = depth
            }

        end
    end

    table.sort(draw_faces, function(a, b)
        return a.depth > b.depth
    end)

    for _, info in ipairs(draw_faces) do

        local face = info.face
        local n = info.index

        local a = points[face[1]]
        local b = points[face[2]]
        local c = points[face[3]]
        local d = points[face[4]]

        if texture then

            local mesh = love.graphics.newMesh({
                {
                    a[1], a[2],
                    uvs[1][1], uvs[1][2]
                },

                {
                    b[1], b[2],
                    uvs[2][1], uvs[2][2]
                },

                {
                    c[1], c[2],
                    uvs[3][1], uvs[3][2]
                },

                {
                    a[1], a[2],
                    uvs[1][1], uvs[1][2]
                },

                {
                    c[1], c[2],
                    uvs[3][1], uvs[3][2]
                },

                {
                    d[1], d[2],
                    uvs[4][1], uvs[4][2]
                }
            }, "triangles", "dynamic")

            mesh:setTexture(texture)

            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(mesh)

        else

            local col = color or colors[n]

            love.graphics.setColor(
                col[1],
                col[2],
                col[3],
                col[4] or 1
            )

            love.graphics.polygon(
                "fill",
                a[1], a[2],
                b[1], b[2],
                c[1], c[2],
                d[1], d[2]
            )

        end
    end

    love.graphics.setColor(1, 1, 1, 1)
end
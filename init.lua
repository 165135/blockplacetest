n2 = nil
time = 0
results = {}
core.register_on_placenode(function(pointed_thing, node)
    placetime = time
	return false
end)

minetest.register_globalstep(function(dtime)
    time = time + dtime

    checkupdate()

end)

function checkupdate()
    local pos = core.camera:get_pos()
	local pos2 = vector.add(pos, vector.multiply(core.camera:get_look_dir(), 100))

	local rc = core.raycast(pos, pos2)
	local i = rc:next()
    if i then
        if i.under then
            n1 = core.find_nodes_in_area(pos, i.under, {"default:cobble"})
        end
    end
    if n2 and placetime then
        if n1[1] ~= n2[1] then
            endtime = time
            print(endtime-placetime)
            table.insert(results,(endtime-placetime))
            total = 0
            for n=1, #results do
                total = total+results[n]
            end
            print("Average: " .. total / #results .. " over " .. tostring(#results) .. " repetitions")
            placetime = nil
        end
    end
    n2 = n1
    
end

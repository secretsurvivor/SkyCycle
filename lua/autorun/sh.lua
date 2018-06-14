if SERVER then
	local sun,color = ents.FindByClass("env_sun")[1],"249 249 249"
	sun:SetKeyValue("size",30)
	sun:SetKeyValue("overlaysize",30)
	local sun_color,moon_color = string.format("%s %s %s",241,240,199),string.format("%s %s %s",242,242,242)
	function Cycle(enum,cycle_len)
		if enum == 1 then
			sun:SetKeyValue("suncolor",moon_color)
			sun:SetKeyValue("overlaycolor",moon_color)
			sun:SetKeyValue("HDRColorScale","0.8")
		elseif enum == 0 or !(enum) then
			sun:SetKeyValue("suncolor",sun_color)
			sun:SetKeyValue("overlaycolor",sun_color)
			sun:SetKeyValue("HDRColorScale","2")
		end
		local time,seconds,enable = math.floor(CurTime()),cycle_len or 600,true
		local indent = 2/(seconds*2)
		function TransFunc()
			local trans = Lerp(indent*(CurTime()-time),-1,1)
			sun:SetKeyValue("sun_dir",string.format("%s 0 0",trans))
			if CurTime()-time < seconds and enable then
				timer.Simple(0.1,TransFunc)
			end
		end
		timer.Simple(0.1,TransFunc)
	end	
	function Day()
		Cycle(0,day_len)
		timer.Simple(day_len+5,Night)
	end
	function Night()
		Cycle(1,night_len)
		timer.Simple(night_len+5,Day)
	end
	
	local day_len,night_len = 600,500
	function StartCycle()
		Day()
	end
end

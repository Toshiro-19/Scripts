local p=game.Players.LocalPlayer
local g=p:WaitForChild("PlayerGui")
local s=Instance.new("ScreenGui")
s.Name="Toshiro Gui";s.Parent=g
local mF=Instance.new("Frame")
mF.Size=UDim2.new(0,400,0,300);mF.Position=UDim2.new(0.5,-200,0.4,-150)
mF.BackgroundColor3=Color3.fromRGB(30,30,30);mF.BorderSizePixel=0;mF.Parent=s
local cB=Instance.new("TextButton")
cB.Text="X";cB.Font=Enum.Font.SourceSansBold;cB.TextSize=20;cB.TextColor3=Color3.fromRGB(255,255,255)
cB.Size=UDim2.new(0,30,0,30);cB.Position=UDim2.new(1,-35,0,5)
cB.BackgroundColor3=Color3.fromRGB(200,50,50);cB.BorderSizePixel=0;cB.Parent=s
local gV=true
cB.MouseButton1Click:Connect(function() mF.Visible=not mF.Visible; gV=not gV end)
local t=Instance.new("TextLabel")
t.Text="Toshiro Gui";t.Font=Enum.Font.SourceSansBold;t.TextSize=24;t.TextColor3=Color3.fromRGB(255,255,255)
t.BackgroundTransparency=1;t.Size=UDim2.new(1,0,0,40);t.Parent=mF
local nF=Instance.new("Frame")
nF.Size=UDim2.new(0,120,1,-40);nF.Position=UDim2.new(0,0,0,40)
nF.BackgroundColor3=Color3.fromRGB(25,25,25);nF.BorderSizePixel=0;nF.Parent=mF
local fN={"Farmeo","Artículos","Teletransportar","Ajustes","Eventos"}
local fF={}
for i,n in ipairs(fN) do
	local fB=Instance.new("TextButton")
	fB.Text=n;fB.Font=Enum.Font.SourceSans;fB.TextSize=18;fB.TextColor3=Color3.fromRGB(255,255,255)
	fB.Size=UDim2.new(1,0,0,30);fB.Position=UDim2.new(0,0,0,(i-1)*30)
	fB.BackgroundColor3=Color3.fromRGB(35,35,35);fB.BorderSizePixel=0;fB.Parent=nF
	local fC=Instance.new("Frame")
	fC.Size=UDim2.new(0,280,1,-40);fC.Position=UDim2.new(0,120,0,40)
	fC.BackgroundColor3=Color3.fromRGB(40,40,40);fC.BorderSizePixel=0;fC.Visible=false;fC.Parent=mF
	fF[n]=fC
	fB.MouseButton1Click:Connect(function() for _,f in pairs(fF) do f.Visible=false end; fC.Visible=true end)
end
local function aFS(fC)
	local toggleButton=Instance.new("TextButton",fC)
	toggleButton.Size=UDim2.new(0.9,0,0,25); toggleButton.Position=UDim2.new(0.05,0,0,10)
	toggleButton.Text="Activar Auto Pescar"; toggleButton.Font=Enum.Font.SourceSans; toggleButton.TextSize=14
	toggleButton.TextColor3=Color3.fromRGB(255,255,255); toggleButton.BackgroundColor3=Color3.fromRGB(60,60,60)
	toggleButton.BorderSizePixel=0; local toggleCorner=Instance.new("UICorner",toggleButton)
	toggleCorner.CornerRadius=UDim.new(0,10)
	local isActivated=false
	toggleButton.MouseButton1Click:Connect(function()
		isActivated=not isActivated
		if isActivated then
			toggleButton.Text="Desactivar Auto Pescar"
			toggleButton.BackgroundColor3=Color3.fromRGB(0,255,0)
			while isActivated do
				local backpack=p.Backpack; local character=p.Character; local rod=nil
				for _,item in pairs(backpack:GetChildren()) do
					if item:IsA("Tool") and item:FindFirstChild("events") and item.events:FindFirstChild("cast") then
						rod=item; break
					end
				end
				if character then
					for _,item in pairs(character:GetChildren()) do
						if item:IsA("Tool") and item:FindFirstChild("events") and item.events:FindFirstChild("cast") then
							rod=item; break
						end
					end
				end
				if rod then
					rod.events.cast:FireServer(100,1)
					wait(0.1)
					game:GetService("ReplicatedStorage").events["reelfinished "]:FireServer(100,false)
				else
					print("No se encontró ninguna caña equipada."); wait(1)
				end
			end
		else
			toggleButton.Text="Activar Auto Pescar"
			toggleButton.BackgroundColor3=Color3.fromRGB(60,60,60)
		end
	end)
	local sellAllButton=Instance.new("TextButton",fC)
	sellAllButton.Size=UDim2.new(0.9,0,0,25); sellAllButton.Position=UDim2.new(0.05,0,0,40)
	sellAllButton.Text="Vender Todo"; sellAllButton.Font=Enum.Font.SourceSans; sellAllButton.TextSize=14
	sellAllButton.TextColor3=Color3.fromRGB(255,255,255); sellAllButton.BackgroundColor3=Color3.fromRGB(60,60,60)
	sellAllButton.BorderSizePixel=0; local sellAllCorner=Instance.new("UICorner",sellAllButton)
	sellAllCorner.CornerRadius=UDim.new(0,10)
	sellAllButton.MouseButton1Click:Connect(function()
		game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("SellAll"):InvokeServer()
		print("Vendido todo.")
	end)
	local boteButton=Instance.new("TextButton",fC)
	boteButton.Size=UDim2.new(0.9,0,0,25); boteButton.Position=UDim2.new(0.05,0,0,70)
	boteButton.Text="Traer Bote"; boteButton.Font=Enum.Font.SourceSansBold; boteButton.TextSize=14
	boteButton.TextColor3=Color3.fromRGB(255,255,255); boteButton.BackgroundColor3=Color3.fromRGB(60,60,60)
	boteButton.BorderSizePixel=0; local boteCorner=Instance.new("UICorner",boteButton)
	boteCorner.CornerRadius=UDim.new(0,10)
	boteButton.MouseButton1Click:Connect(function()
		local jugador=game.Players.LocalPlayer
		local personaje=jugador.Character or jugador.CharacterAdded:Wait()
		local humanoidRootPart=personaje:WaitForChild("HumanoidRootPart")
		local bote=workspace.active.boats:FindFirstChild("DIABLOmalo134284") and workspace.active.boats.DIABLOmalo134284:FindFirstChild("Jetski")
		if bote and humanoidRootPart then
			if not bote.PrimaryPart then
				local base=bote:FindFirstChildWhichIsA("BasePart")
				if base then bote.PrimaryPart=base else warn("No se encontró una parte principal en el bote."); return end
			end
			local primaryPart=bote.PrimaryPart
			local function obtenerAlturaAgua(posicion)
				local rayOrigin=posicion+Vector3.new(0,50,0)
				local rayDirection=Vector3.new(0,-100,0)
				local raycastParams=RaycastParams.new()
				raycastParams.FilterDescendantsInstances={personaje, workspace.active.boats}
				raycastParams.FilterType=Enum.RaycastFilterType.Blacklist
				local raycastResult=workspace:Raycast(rayOrigin,rayDirection,raycastParams)
				return raycastResult and raycastResult.Position.Y or posicion.Y
			end
			local nuevaPosicion=Vector3.new(humanoidRootPart.Position.X+5,obtenerAlturaAgua(humanoidRootPart.Position)+1,humanoidRootPart.Position.Z)
			primaryPart.CFrame=CFrame.new(nuevaPosicion)
			local bodyPosition=Instance.new("BodyPosition",primaryPart)
			bodyPosition.MaxForce=Vector3.new(0,math.huge,0); bodyPosition.P=5000; bodyPosition.D=500
			local bodyGyro=Instance.new("BodyGyro",primaryPart)
			bodyGyro.MaxTorque=Vector3.new(400000,0,400000); bodyGyro.P=3000; bodyGyro.D=100
			task.spawn(function()
				while bote and bote.Parent and bodyPosition do
					local alturaAgua=obtenerAlturaAgua(primaryPart.Position)
					bodyPosition.Position=Vector3.new(primaryPart.Position.X,alturaAgua+1,primaryPart.Position.Z)
					bodyGyro.CFrame=CFrame.new(primaryPart.Position)
					task.wait(0.1)
				end
			end)
		else
			warn("No se encontró la moto acuática o el jugador.")
		end
	end)
end
aFS(fF["Farmeo"])
local function aIS(fC)
	local iB=Instance.new("TextButton",fC)
	iB.Size=UDim2.new(0.9,0,0,25); iB.Position=UDim2.new(0.05,0,0,10)
	iB.Text="Activar script de item"; iB.BackgroundColor3=Color3.fromRGB(60,60,60)
	iB.TextColor3=Color3.fromRGB(255,255,255); iB.TextSize=14; iB.Font=Enum.Font.SourceSans
	local iBCorner=Instance.new("UICorner",iB); iBCorner.CornerRadius=UDim.new(0,10)
	local iA=false
	iB.MouseButton1Click:Connect(function()
		if iA then
			iA=false; iB.Text="Activar script de item"
			iB.BackgroundColor3=Color3.fromRGB(60,60,60); print("Desactivar evaluación automática.")
		else
			iA=true; iB.Text="Desactivar evaluación automática"
			iB.BackgroundColor3=Color3.fromRGB(0,255,0); print("Script de item activado.")
			while iA and wait() do
				if workspace:FindFirstChild("world") then
					workspace.world.npcs.Appraiser.appraiser.appraise:InvokeServer()
				end
			end
		end
	end)
	local lB=Instance.new("TextButton",fC)
	lB.Size=UDim2.new(0.9,0,0,25); lB.Position=UDim2.new(0.05,0,0,40)
	lB.Text="Comprar suerte"; lB.BackgroundColor3=Color3.fromRGB(60,60,60)
	lB.TextColor3=Color3.fromRGB(255,255,255); lB.TextSize=14; lB.Font=Enum.Font.SourceSans
	local lBCorner=Instance.new("UICorner",lB); lBCorner.CornerRadius=UDim.new(0,10)
	lB.MouseButton1Click:Connect(function()
		workspace:WaitForChild("world"):WaitForChild("npcs")
		:WaitForChild("Merlin"):WaitForChild("Merlin")
		:WaitForChild("luck"):InvokeServer()
		print("Suerte comprada.")
	end)
	local rB=Instance.new("TextButton",fC)
	rB.Size=UDim2.new(0.9,0,0,25); rB.Position=UDim2.new(0.05,0,0,70)
	rB.Text="Comprar reliquia"; rB.BackgroundColor3=Color3.fromRGB(60,60,60)
	rB.TextColor3=Color3.fromRGB(255,255,255); rB.TextSize=14; rB.Font=Enum.Font.SourceSans
	local rBCorner=Instance.new("UICorner",rB); rBCorner.CornerRadius=UDim.new(0,10)
	rB.MouseButton1Click:Connect(function()
		workspace:WaitForChild("world"):WaitForChild("npcs")
		:WaitForChild("Merlin"):WaitForChild("Merlin")
		:WaitForChild("power"):InvokeServer()
		print("Reliquia comprada.")
	end)
	local mB=Instance.new("TextButton",fC)
	mB.Size=UDim2.new(0.9,0,0,25); mB.Position=UDim2.new(0.05,0,0,100)
	mB.Text="Meteorito"; mB.BackgroundColor3=Color3.fromRGB(60,60,60)
	mB.TextColor3=Color3.fromRGB(255,255,255); mB.TextSize=14; mB.Font=Enum.Font.SourceSans
	local mBCorner=Instance.new("UICorner",mB); mBCorner.CornerRadius=UDim.new(0,10)
	mB.MouseButton1Click:Connect(function()
		local c=p.Character or p.CharacterAdded:Wait()
		local d=workspace:FindFirstChild("MeteorCrater")
		if d then
			if d:IsA("Model") and d.PrimaryPart then
				c:MoveTo(d.PrimaryPart.Position)
			elseif d:IsA("BasePart") then
				c:MoveTo(d.Position)
			else
				warn("El objeto 'MeteorCrater' no tiene una posición válida.")
			end
		else
			warn("La ubicación 'MeteorCrater' no se encontró en el workspace.")
		end
	end)
	local totemButton=Instance.new("TextButton",fC)
	totemButton.Size=UDim2.new(0.9,0,0,25); totemButton.Position=UDim2.new(0.05,0,0,130)
	totemButton.Text="Seleccionar Tótem"; totemButton.BackgroundColor3=Color3.fromRGB(60,60,60)
	totemButton.TextColor3=Color3.fromRGB(255,255,255); totemButton.TextSize=14; totemButton.Font=Enum.Font.SourceSans
	local totemCorner=Instance.new("UICorner",totemButton); totemCorner.CornerRadius=UDim.new(0,10)
	local totemOptionsFrame=Instance.new("Frame",fC)
	totemOptionsFrame.Size=UDim2.new(0.9,0,0,150); totemOptionsFrame.Position=UDim2.new(0.05,0,0,160)
	totemOptionsFrame.BackgroundColor3=Color3.fromRGB(40,40,40); totemOptionsFrame.BorderSizePixel=0
	totemOptionsFrame.Visible=false; local totemOptionsCorner=Instance.new("UICorner",totemOptionsFrame)
	totemOptionsCorner.CornerRadius=UDim.new(0,10)
	local totems={
		{"Tótem Solar",Vector3.new(-1148.00,134.50,-1075.00)},
		{"Tótem Eclipse",Vector3.new(5969.72,274.11,842.18)},
		{"Tótem Aurora",Vector3.new(-1811.00,-136.93,-3282.00)},
		{"Tótem Neblina",Vector3.new(2789.00,139.83,-625.00)},
		{"Tótem Tormenta",Vector3.new(35.00,132.50,1943.00)},
		{"Tótem Viento",Vector3.new(35.00,132.50,1943.00)}
	}
	for i,totem in ipairs(totems) do
		local totemOptionButton=Instance.new("TextButton",totemOptionsFrame)
		totemOptionButton.Size=UDim2.new(0.9,0,0,22); totemOptionButton.Position=UDim2.new(0.05,0,0,(i-1)*26)
		totemOptionButton.Text=totem[1]; totemOptionButton.BackgroundColor3=Color3.fromRGB(60,60,60)
		totemOptionButton.TextColor3=Color3.fromRGB(255,255,255); totemOptionButton.TextSize=14; totemOptionButton.Font=Enum.Font.SourceSans
		local totemOptionCorner=Instance.new("UICorner",totemOptionButton)
		totemOptionCorner.CornerRadius=UDim.new(0,6)
		totemOptionButton.MouseButton1Click:Connect(function()
			local character=p.Character or p.CharacterAdded:Wait()
			if character and character.PrimaryPart then
				character:SetPrimaryPartCFrame(CFrame.new(totem[2]+Vector3.new(0,5,0)))
				totemOptionsFrame.Visible=false
				print("Teletransportado a "..totem[1])
			else
				warn("No se pudo teletransportar: el personaje o su PrimaryPart no están disponibles.")
			end
		end)
	end
	totemButton.MouseButton1Click:Connect(function()
		totemOptionsFrame.Visible=not totemOptionsFrame.Visible
	end)
end
aIS(fF["Artículos"])
local tS=Instance.new("ScrollingFrame",fF["Teletransportar"])
tS.Size=UDim2.new(1,0,1,0); tS.CanvasSize=UDim2.new(0,0,2,0)
tS.ScrollBarThickness=6; tS.BackgroundTransparency=1
local locations={
	{"Atlantis storm",Vector3.new(-3409.43,134.39,261.15)},
	{"Ancient Isla",Vector3.new(5959.56,231.72,400.36)},
	{"Desolado profundo",Vector3.new(-1619.77,-214.19,-2865.55)},
	{"Brine Pool",Vector3.new(-1811.55,-136.91,-3282.01)},
	{"Altar de los guardianes",Vector3.new(1392.30,-810.67,-63.33)},
	{"Pantano",Vector3.new(2661.76,131.27,-644.24)},
	{"Vértigo",Vector3.new(-165.78,-515.17,1141.76)},
	{"Las profundidades",Vector3.new(1040.84,-709.07,1333.52)},
	{"Arrecife",Vector3.new(-3549.60,144.52,533.44)},
	{"Roslit",Vector3.new(-1527.69,142.75,647.71)},
	{"Fabricación de cañas",Vector3.new(-3158.95,-745.46,1674.96)},
	{"Atlantis",Vector3.new(-4264.45,-603.40,1848.81)},
	{"Piscina kraken",Vector3.new(-4407.98,-996.26,1998.58)},
	{"Expedición Norte",Vector3.new(19580.99,148.99,5255.94)},
	{"Isla de nieve",Vector3.new(19580.99,148.99,5255.94)},
	{"Moosewood",Vector3.new(391.95,134.50,262.13)}
}
table.sort(locations,function(a,b)return a[1]<b[1] end)
for i,loc in ipairs(locations) do
	local b=Instance.new("TextButton",tS)
	b.Size=UDim2.new(0.9,0,0,22); b.Position=UDim2.new(0.05,0,0,(i-1)*26)
	b.Text=loc[1]; b.BackgroundColor3=Color3.fromRGB(60,60,60)
	b.TextColor3=Color3.fromRGB(255,255,255); b.TextSize=14; b.Font=Enum.Font.SourceSans
	local uic=Instance.new("UICorner",b)
	uic.CornerRadius=UDim.new(0,6)
	b.MouseButton1Click:Connect(function()
		local character=p.Character or p.CharacterAdded:Wait()
		if character and character.PrimaryPart then
			character:SetPrimaryPartCFrame(CFrame.new(loc[2]+Vector3.new(0,5,0)))
			mF.Visible=false
		else
			warn("No se pudo teletransportar: el personaje o su PrimaryPart no están disponibles.")
		end
	end)
end
local function aAS(fC)
	local iyButton=Instance.new("TextButton",fC)
	iyButton.Size=UDim2.new(0.9,0,0,25); iyButton.Position=UDim2.new(0.05,0,0,10)
	iyButton.Text="Infinite Yield"; iyButton.BackgroundColor3=Color3.fromRGB(60,60,60)
	iyButton.TextColor3=Color3.fromRGB(255,255,255); iyButton.TextSize=14; iyButton.Font=Enum.Font.SourceSans
	local iyCorner=Instance.new("UICorner",iyButton); iyCorner.CornerRadius=UDim.new(0,10)
	iyButton.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
		print("Infinite Yield cargado.")
	end)
	local rsButton=Instance.new("TextButton",fC)
	rsButton.Size=UDim2.new(0.9,0,0,25); rsButton.Position=UDim2.new(0.05,0,0,40)
	rsButton.Text="Remote Spy"; rsButton.BackgroundColor3=Color3.fromRGB(60,60,60)
	rsButton.TextColor3=Color3.fromRGB(255,255,255); rsButton.TextSize=14; rsButton.Font=Enum.Font.SourceSans
	local rsCorner=Instance.new("UICorner",rsButton); rsCorner.CornerRadius=UDim.new(0,10)
	rsButton.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
		print("Remote Spy cargado.")
	end)
	local dexButton=Instance.new("TextButton",fC)
	dexButton.Size=UDim2.new(0.9,0,0,25); dexButton.Position=UDim2.new(0.05,0,0,70)
	dexButton.Text="Dex Explorer"; dexButton.BackgroundColor3=Color3.fromRGB(60,60,60)
	dexButton.TextColor3=Color3.fromRGB(255,255,255); dexButton.TextSize=14; dexButton.Font=Enum.Font.SourceSans
	local dexCorner=Instance.new("UICorner",dexButton); dexCorner.CornerRadius=UDim.new(0,10)
	dexButton.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
		print("Dex Explorer cargado.")
	end)
end
aAS(fF["Ajustes"])
local function aES(fC)
	local mB=Instance.new("TextButton",fC)
	mB.Size=UDim2.new(0.9,0,0,25); mB.Position=UDim2.new(0,0,0,10)
	mB.Text="Teletransportar a Megalodon"; mB.BackgroundColor3=Color3.fromRGB(60,60,60)
	mB.TextColor3=Color3.fromRGB(255,255,255); mB.TextSize=14; mB.Font=Enum.Font.SourceSans
	local mBCorner=Instance.new("UICorner",mB); mBCorner.CornerRadius=UDim.new(0,10)
	mB.MouseButton1Click:Connect(function()
		local d=workspace:WaitForChild("zones"):WaitForChild("fishing"):WaitForChild("Megalodon Default")
		p.Character:SetPrimaryPartCFrame(d.CFrame)
		print("Teletransportado a Megalodon Default.")
	end)
	
	local oB=Instance.new("TextButton",fC)
	oB.Size=UDim2.new(0.9,0,0,25); oB.Position=UDim2.new(0,0,0,40)
	oB.Text="Evento Orca"; oB.BackgroundColor3=Color3.fromRGB(60,60,60)
	oB.TextColor3=Color3.fromRGB(255,255,255); oB.TextSize=14; oB.Font=Enum.Font.SourceSans
	local oBCorner=Instance.new("UICorner",oB); oBCorner.CornerRadius=UDim.new(0,10)
	oB.MouseButton1Click:Connect(function()
		local d=workspace:WaitForChild("zones"):WaitForChild("fishing"):WaitForChild("Orcas Pool")
		p.Character:SetPrimaryPartCFrame(d.CFrame)
		print("Teletransportado a Orcas Pool.")
	end)
	
	local aB=Instance.new("TextButton",fC)
	aB.Size=UDim2.new(0.9,0,0,25); aB.Position=UDim2.new(0,0,0,70)
	aB.Text="Evento Ancient Depth Serpent"; aB.BackgroundColor3=Color3.fromRGB(60,60,60)
	aB.TextColor3=Color3.fromRGB(255,255,255); aB.TextSize=14; aB.Font=Enum.Font.SourceSans
	local aBCorner=Instance.new("UICorner",aB); aBCorner.CornerRadius=UDim.new(0,10)
	aB.MouseButton1Click:Connect(function()
		local d=workspace.active:WaitForChild("Ancient Depth Serpent")
		if d then
			p.Character:SetPrimaryPartCFrame(d.CFrame+Vector3.new(0,5,0))
			print("Teletransportado a Ancient Depth Serpent.")
		else
			warn("El evento 'Ancient Depth Serpent' no se encontró en el workspace.")
		end
	end)

	-- Nuevo botón agregado debajo del de Ancient Depth Serpent
	local nB=Instance.new("TextButton",fC)
	nB.Size=UDim2.new(0.9,0,0,25); nB.Position=UDim2.new(0,0,0,100)
	nB.Text="Evento love"; nB.BackgroundColor3=Color3.fromRGB(60,60,60)
	nB.TextColor3=Color3.fromRGB(255,255,255); nB.TextSize=14; nB.Font=Enum.Font.SourceSans
	local nBCorner=Instance.new("UICorner",nB); nBCorner.CornerRadius=UDim.new(0,10)
	nB.MouseButton1Click:Connect(function()
		local character = game.Players.LocalPlayer.Character
		if character and character:FindFirstChild("HumanoidRootPart") then
			character.HumanoidRootPart.CFrame = workspace.zones.fishing["Lovestorm Eel"].CFrame
		end
	end)
end
aES(fF["Eventos"])

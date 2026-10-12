-- 1. Load Script Asli
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- ID Logo Baru
local newLogo = "rbxassetid://6023426923"
local blackColor = Color3.fromRGB(20, 20, 20)

-- Fungsi cek warna merah (lebih akurat)
local function isRed(color)
    return color.R > 0.7 and color.G < 0.3 and color.B < 0.3
end

-- Fungsi rebrand
local function applyRebrand(gui)
    pcall(function()
        local fullName = gui:GetFullName():lower()
        
        -- PROTEKSI: Skip GUI yang bukan Chilli
        -- Cek apakah ini GUI Chilli (biasanya ada "chilli" di nama)
        -- Kalau bukan, skip
        if not (fullName:find("chilli") or fullName:find("spicy") or fullName:find("hub")) then
            -- Tapi tetep cek descendant-nya
            return
        end
        
        -- A. Rebrand Teks
        if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
            local txt = gui.Text
            if txt:find("Chilli") or txt:find("chilli") then
                gui.Text = txt:gsub("Chilli Hub", "RAEL COMMUNITY")
                           :gsub("Chilli", "RAEL COMMUNITY")
                           :gsub("chilli", "RAEL COMMUNITY")
            end
            if txt:find("CJK4bs2mgT") then
                gui.Text = "discord.gg/JVRN3MCfz"
            end
        end
        
        -- B. Ganti Warna Merah → Hitam (lebih akurat)
        if gui:IsA("GuiObject") then
            if isRed(gui.BackgroundColor3) then
                gui.BackgroundColor3 = blackColor
            end
            if isRed(gui.BorderColor3) then
                gui.BorderColor3 = blackColor
            end
            
            local stroke = gui:FindFirstChildOfClass("UIStroke")
            if stroke and isRed(stroke.Color) then
                stroke.Color = blackColor
            end
        end
        
        -- C. Ganti Logo (lebih spesifik)
        if gui:IsA("ImageLabel") or gui:IsA("ImageButton") then
            -- Cek apakah ini logo (biasanya ada di header, ukuran persegi)
            local size = gui.AbsoluteSize
            local isLogoSize = size.X >= 30 and size.X <= 80 and size.Y >= 30 and size.Y <= 80
            
            -- Cek parent, apakah di header (bukan di grid/scroll)
            local parent = gui.Parent
            local isInHeader = parent and (parent.Name:lower():find("header") or parent.Name:lower():find("title") or parent.Name:lower():find("logo"))
            
            if isLogoSize and isInHeader then
                if gui.Image ~= newLogo and gui.Image ~= "" then
                    gui.Image = newLogo
                    gui.ImageTransparency = 0
                end
            end
        end
    end)
end

-- 2. Eksekusi
task.spawn(function()
    task.wait(2) -- Tunggu Chilli load dulu
    
    -- Scan GUI yang ada
    for _, gui in ipairs(game.CoreGui:GetDescendants()) do
        applyRebrand(gui)
    end
    
    -- Scan GUI yang baru muncul
    game.CoreGui.DescendantAdded:Connect(function(gui)
        task.wait(0.1)
        applyRebrand(gui)
    end)
end)

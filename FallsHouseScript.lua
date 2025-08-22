local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Функция загрузки модели дома по ID
local function loadHouseModel(houseId)
    local model = InsertService:LoadAsset(houseId):GetChildren()[1]
    if model:IsA("Model") then
        return model
    else
        return nil
    end
end

-- Основная функция дропа дома
local function dropHouse(targetPosition)
    local houseId = 8959904556 -- ID стандартного домика в Roblox (можно заменить на любой другой)
    local houseModel = loadHouseModel(houseId)
    
    if not houseModel then
        warn("Не удалось загрузить модель дома!")
        return
    end

    houseModel.Parent = workspace
    houseModel:SetPrimaryPartCFrame(CFrame.new(targetPosition + Vector3.new(0, 100, 0))) -- Падает с высоты 100 studs

    -- Разъединяем все части и убираем якоря (чтобы дом развалился)
    for _, part in ipairs(houseModel:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = false
            part:BreakJoints()
        end
    end

    -- Добавляем эффект "падения" и небольшой взрыв для хаоса
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, -50, 0) -- Скорость падения
    bodyVelocity.Parent = houseModel.PrimaryPart
    delay(0.5, function() bodyVelocity:Destroy() end)

    -- Через 10 секунд убираем дом
    delay(30, function()
        houseModel:Destroy()
    end)
end

-- Привязка к клику мыши
Mouse.Button1Down:Connect(function()
    local targetPos = Mouse.Hit.Position
    dropHouse(targetPos)
end)

print("✅ Скрипт активирован! Кликай куда хочешь уронить дом (с неба).")
print("⚠️ Пранк удался! Дом упадёт, развалится и исчезнет через 10 секунд.")

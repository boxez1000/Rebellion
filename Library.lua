local CoreGui = game:GetService('CoreGui')
local UserInputService = game:GetService('UserInputService')

local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end)

local ScreenGui = Instance.new('ScreenGui')
ProtectGui(ScreenGui)

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = CoreGui
ScreenGui.DisplayOrder = 1e9-1

local Library = {
    MainColor = Color3.fromRGB(30, 30, 30),
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    AccentColor = Color3.fromRGB(170, 0, 255),
    OutlineColor = Color3.fromRGB(40, 40, 40),
    TextColor = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Code,
}

function Library:MakeDraggable(Trigger, Frame)
    local Dragging = false
    local DragInput, InputPos, FramePos

    Trigger.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            InputPos = Input.Position
            FramePos = Frame.Position

            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    Trigger.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            DragInput = Input
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and Input == DragInput then
            local Delta = Input.Position - InputPos
            Frame.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
        end
    end)
end

function Library:CreateWindow(Title)
    if Title == nil then
        Title = "Rebellion UI"
    elseif type(Title) ~= "string" then
        warn("CreateWindow expected a string, but got: " .. tostring(Title))
        Title = tostring(Title)
    end

    local Window = Instance.new("Frame")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    local HeaderFrame = Instance.new("Frame")
    local HeaderLabel = Instance.new("TextLabel")
    local UIPadding = Instance.new("UIPadding")
    local TabContentFrame = Instance.new("Frame")
    local TabButtonFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")

    Window.Name = "Window"
    Window.Parent = ScreenGui
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = Library.BackgroundColor
    Window.BorderColor3 = Library.AccentColor
    Window.Position = UDim2.new(0.5, 0, 0.5, 0)
    Window.Size = UDim2.new(0.5, 0, 0.600000024, 0)

    UIAspectRatioConstraint.Parent = Window
    UIAspectRatioConstraint.AspectRatio = 1.471

    HeaderFrame.Name = "HeaderFrame"
    HeaderFrame.Parent = Window
    HeaderFrame.AnchorPoint = Vector2.new(0.5, 0)
    HeaderFrame.BackgroundColor3 = Library.MainColor
    HeaderFrame.BorderColor3 = Library.OutlineColor
    HeaderFrame.Position = UDim2.new(0.5, 0, 0, 5)
    HeaderFrame.Size = UDim2.new(1, -10, 0, 25)
    HeaderFrame.ZIndex = 2

    HeaderLabel.Name = "HeaderLabel"
    HeaderLabel.Parent = HeaderFrame
    HeaderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderLabel.BackgroundTransparency = 1.000
    HeaderLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HeaderLabel.BorderSizePixel = 0
    HeaderLabel.Size = UDim2.new(1, 0, 1, 0)
    HeaderLabel.ZIndex = 3
    HeaderLabel.Font = Library.Font
    HeaderLabel.Text = tostring(Title)
    HeaderLabel.TextColor3 = Library.TextColor
    HeaderLabel.TextSize = 14.000
    HeaderLabel.TextWrapped = true
    HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding.Parent = HeaderLabel
    UIPadding.PaddingLeft = UDim.new(0, 5)

    TabContentFrame.Name = "TabContentFrame"
    TabContentFrame.Parent = Window
    TabContentFrame.AnchorPoint = Vector2.new(1, 1)
    TabContentFrame.BackgroundColor3 = Library.MainColor
    TabContentFrame.BorderColor3 = Library.OutlineColor
    TabContentFrame.Position = UDim2.new(1, -5, 1, -5)
    TabContentFrame.Size = UDim2.new(0.75, -15, 1, -40)
    TabContentFrame.ZIndex = 2

    TabButtonFrame.Name = "TabButtonFrame"
    TabButtonFrame.Parent = Window
    TabButtonFrame.Active = true
    TabButtonFrame.AnchorPoint = Vector2.new(0, 1)
    TabButtonFrame.BackgroundColor3 = Library.MainColor
    TabButtonFrame.BorderColor3 = Library.OutlineColor
    TabButtonFrame.Position = UDim2.new(0, 5, 1, -5)
    TabButtonFrame.Size = UDim2.new(0.25, 0, 1, -40)
    TabButtonFrame.ZIndex = 2
    TabButtonFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabButtonFrame.ScrollBarThickness = 1
    TabButtonFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    UIListLayout.Parent = TabButtonFrame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    Library:MakeDraggable(HeaderFrame, Window)

    local Tabs = {}

    local First = true

    function Tabs:AddTab(TabName)
        if TabName == nil then
            TabName = "Tab"
        elseif type(TabName) ~= "string" then
            warn("AddTab expected a string, but got: " .. tostring(TabName))
            TabName = tostring(TabName)
        end
   
        local Button = Instance.new("TextButton")

        Button.Name = TabName .. "Button"
        Button.Parent = TabButtonFrame
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundTransparency = 1.000
        Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(1, 0, 0, 20)
        Button.ZIndex = 4
        Button.Font = Library.Font
        Button.Text = TabName
        Button.TextSize = 14.000
        Button.TextWrapped = true
        Button.TextColor3 = Library.TextColor

        local Content = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")

        Content.Name = TabName .. "Content"
        Content.Parent = TabContentFrame
        Content.Active = true
        Content.AnchorPoint = Vector2.new(0.5, 0.5)
        Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Content.BackgroundTransparency = 1.000
        Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Content.BorderSizePixel = 0
        Content.Position = UDim2.new(0.5, 0, 0.5, 0)
        Content.Size = UDim2.new(1, 0, 1, 0)
        Content.ZIndex = 3
        Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        Content.ScrollBarThickness = 1
        Content.Visible = false
        Content.AutomaticCanvasSize =Enum.AutomaticSize.Y

        UIListLayout.Parent = Content
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        UIPadding.Parent = Content
        UIPadding.PaddingBottom = UDim.new(0, 5)
        UIPadding.PaddingTop = UDim.new(0, 5)

        if First then
            First = false
            Button.TextColor3 = Library.AccentColor
            Content.Visible = true
        else
            Button.TextColor3 = Library.TextColor
            Content.Visible = false
        end

        Button.MouseButton1Click:Connect(function()
            for _, Child in pairs(TabContentFrame:GetChildren()) do
                if Child:IsA("ScrollingFrame") then
                    Child.Visible = false
                end
            end

            for _, Button in pairs(TabButtonFrame:GetChildren()) do
                if Button:IsA("TextButton") then
                    Button.TextColor3 = Library.TextColor
                end
            end

            Button.TextColor3 = Library.AccentColor
            Content.Visible = true
        end)

        local Sections = {}

        function Sections:AddSection(SectionName)
            if SectionName == nil then
                SectionName = "Section"
            elseif type(SectionName) ~= "string" then
                warn("AddSection expected a string, but got: " .. tostring(SectionName))
                SectionName = tostring(SectionName)
            end

            local Section = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            local SectionHeader = Instance.new("Frame")
            local SectionLabel = Instance.new("TextLabel")

            Section.Name = SectionName .. "Section"
            Section.Parent = Content
            Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Section.BackgroundTransparency = 1.000
            Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, -10, 0, 0)
            Section.ZIndex = 4
            Section.AutomaticSize = Enum.AutomaticSize.Y

            UIListLayout.Parent = Section
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 5)

            SectionHeader.Name = "SectionHeader"
            SectionHeader.Parent = Section
            SectionHeader.BackgroundColor3 = Library.MainColor
            SectionHeader.BorderColor3 = Library.AccentColor
            SectionHeader.BorderSizePixel = 1
            SectionHeader.Size = UDim2.new(1, 0, 0, 20)
            SectionHeader.ZIndex = 5

            SectionLabel.Name = "SectionLabel"
            SectionLabel.Parent = SectionHeader
            SectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionLabel.BackgroundTransparency = 1.000
            SectionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionLabel.BorderSizePixel = 0
            SectionLabel.Size = UDim2.new(1, 0, 1, 0)
            SectionLabel.ZIndex = 6
            SectionLabel.Font = Library.Font
            SectionLabel.Text = SectionName
            SectionLabel.TextColor3 = Library.TextColor
            SectionLabel.TextSize = 14.000
        
            local Components = {}

            function Components:AddLabel(Text)
                if Text == nil then
                    Text = "Text"
                elseif type(Text) ~= "string" then
                    warn("AddLabel expected a string, but got: " .. tostring(Text))
                    Text = tostring(Text)
                end

                local TextLabel = Instance.new("TextLabel")

                TextLabel.Name = Text .. "Label"
                TextLabel.Parent = Section
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextLabel.BorderSizePixel = 0
                TextLabel.Size = UDim2.new(1, 0, 0, 20)
                TextLabel.ZIndex = 5
                TextLabel.Font = Library.Font
                TextLabel.Text = Text
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextSize = 14.000
            end

            function Components:AddButton(Text, Callback)
                if Text == nil then
                    Text = "Text"
                elseif type(Text) ~= "string" then
                    warn("AddButton expected a string, but got: " .. tostring(Text))
                    Text = tostring(Text)
                end
                Callback = Callback or function() end

                local Button = Instance.new("TextButton")

                Button.Name = Text .. "Button"
                Button.Parent = Section
                Button.BackgroundColor3 = Library.MainColor
                Button.BorderColor3 = Library.OutlineColor
                Button.Size = UDim2.new(1, 0, 0, 20)
                Button.ZIndex = 5
                Button.Font = Library.Font
                Button.Text = Text
                Button.TextColor3 = Library.TextColor
                Button.TextSize = 14.000

                Button.MouseButton1Click:Connect(Callback)
            end

            function Components:AddToggle(Text, Callback)
                if Text == nil then
                    Text = "Text"
                elseif type(Text) ~= "string" then
                    warn("AddToggle expected a string, but got: " .. tostring(Text))
                    Text = tostring(Text)
                end
                Callback = Callback or function() end

                local Toggled = false

                local ToggleFrame = Instance.new("Frame")
                local Outer = Instance.new("Frame")
                local Inner = Instance.new("TextButton")
                local ToggleLabel = Instance.new("TextLabel")

                ToggleFrame.Name = Text .. "ToggleFrame"
                ToggleFrame.Parent = Section
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleFrame.BackgroundTransparency = 1.000
                ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Size = UDim2.new(1, 0, 0, 20)
                ToggleFrame.ZIndex = 5

                Outer.Name = "Outer"
                Outer.Parent = ToggleFrame
                Outer.AnchorPoint = Vector2.new(0, 0.5)
                Outer.BackgroundColor3 = Library.MainColor
                Outer.BorderColor3 = Library.OutlineColor
                Outer.Position = UDim2.new(0, 0, 0.5, 0)
                Outer.Size = UDim2.new(0, 15, 0, 15)
                Outer.ZIndex = 6

                Inner.Name = "Inner"
                Inner.Parent = Outer
                Inner.AnchorPoint = Vector2.new(0.5, 0.5)
                Inner.BackgroundColor3 = Library.MainColor
                Inner.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Inner.BorderSizePixel = 0
                Inner.Position = UDim2.new(0.5, 0, 0.5, 0)
                Inner.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
                Inner.ZIndex = 7
                Inner.Font = Enum.Font.SourceSans
                Inner.Text = ""
                Inner.TextColor3 = Color3.fromRGB(0, 0, 0)
                Inner.TextSize = 14.000

                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.AnchorPoint = Vector2.new(1, 0)
                ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.BackgroundTransparency = 1.000
                ToggleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ToggleLabel.BorderSizePixel = 0
                ToggleLabel.Position = UDim2.new(1, 0, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -20, 1, 0)
                ToggleLabel.ZIndex = 6
                ToggleLabel.Font = Library.Font
                ToggleLabel.Text = Text
                ToggleLabel.TextColor3 = Library.TextColor
                ToggleLabel.TextSize = 14.000
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

                Inner.MouseButton1Click:Connect(function()
                    if Toggled then
                        Toggled = not Toggled
                        Inner.BackgroundColor3 = Library.MainColor
                    else
                        Toggled = not Toggled
                        Inner.BackgroundColor3 = Library.AccentColor
                    end

                    pcall(Callback, Toggled)
                end)
            end

            function Components:AddDropdown(Text, List, Callback)
                if Text == nil then
                    Text = "Text"
                elseif type(Text) ~= "string" then
                    warn("AddDropdown expected a string, but got: " .. tostring(Text))
                    Text = tostring(Text)
                end
                List = List or {}
                Callback = Callback or function() end

                local DropdownFrame = Instance.new("Frame")
                local DropdownLabel = Instance.new("TextLabel")
                local DropdownButton = Instance.new("TextButton")
                local DropdownArrow = Instance.new("TextLabel")
                local DropdownList = Instance.new("Frame")
                local UIListLayout = Instance.new("UIListLayout")

                DropdownFrame.Name = "DropdownFrame"
                DropdownFrame.AutomaticSize = Enum.AutomaticSize.Y
                DropdownFrame.Parent = Section
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownFrame.BackgroundTransparency = 1.000
                DropdownFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownFrame.BorderSizePixel = 0
                DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
                DropdownFrame.ZIndex = 5

                DropdownLabel.Name = "DropdownLabel"
                DropdownLabel.Parent = DropdownFrame
                DropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownLabel.BackgroundTransparency = 1.000
                DropdownLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownLabel.BorderSizePixel = 0
                DropdownLabel.Size = UDim2.new(1, 0, 0, 20)
                DropdownLabel.ZIndex = 6
                DropdownLabel.Font = Enum.Font.Code
                DropdownLabel.Text = Text
                DropdownLabel.TextColor3 = Library.TextColor
                DropdownLabel.TextSize = 14.000
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left

                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = DropdownFrame
                DropdownButton.BackgroundColor3 = Library.MainColor
                DropdownButton.BorderColor3 = Library.OutlineColor
                DropdownButton.Position = UDim2.new(0, 0, 0, 20)
                DropdownButton.Size = UDim2.new(1, 0, 0, 20)
                DropdownButton.ZIndex = 6
                DropdownButton.Font = Library.Font
                DropdownButton.Text = "-"
                DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownButton.TextSize = 14.000

                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownButton
                DropdownArrow.AnchorPoint = Vector2.new(1, 0)
                DropdownArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownArrow.BackgroundTransparency = 1.000
                DropdownArrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownArrow.BorderSizePixel = 0
                DropdownArrow.Position = UDim2.new(1, 0, 0, 0)
                DropdownArrow.Rotation = 90.000
                DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
                DropdownArrow.ZIndex = 7
                DropdownArrow.Font = Library.Font
                DropdownArrow.Text = ">"
                DropdownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownArrow.TextSize = 14.000

                DropdownList.Name = "DropdownList"
                DropdownList.AutomaticSize = Enum.AutomaticSize.Y
                DropdownList.Parent = DropdownFrame
                DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                DropdownList.BorderColor3 = Color3.fromRGB(40, 40, 40)
                DropdownList.Position = UDim2.new(0, 0, 0, 40)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.Visible = false
                DropdownList.ZIndex = 6

                UIListLayout.Parent = DropdownList
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

                for _, Option in next, List do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Name = Option .. "Option"
                    OptionButton.Parent = DropdownList
                    OptionButton.BackgroundColor3 =Library.MainColor
                    OptionButton.BorderColor3 = Library.OutlineColor
                    OptionButton.BorderSizePixel = 1
                    OptionButton.Size = UDim2.new(1, 0, 0, 20)
                    OptionButton.ZIndex = 7
                    OptionButton.Font = Library.Font
                    OptionButton.Text = Option
                    OptionButton.TextColor3 = Library.TextColor
                    OptionButton.TextSize = 14.000

                    OptionButton.MouseButton1Click:Connect(function()
                        Callback(Option)
                        DropdownList.Visible = false
                        DropdownButton.Text = tostring(Option)
                        DropdownArrow.Rotation = 90
                    end)
                end

                DropdownButton.MouseButton1Click:Connect(function()
                    if DropdownList.Visible then
                        DropdownList.Visible = false
                        DropdownArrow.Rotation = 90
                    else
                        DropdownList.Visible = true
                        DropdownArrow.Rotation = -90
                    end
                end)

            end

            return Components
        end

        return Sections
    end

    return Tabs
end

return Library

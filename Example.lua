-- Load the library from the URL
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/boxez1000/Rebellion/main/Library.lua"))()

-- Create a window titled "Rebellion"
local Window = Library:CreateWindow("Rebellion")

-- Add two tabs to the window
local Tab1 = Window:AddTab("Tab 1")
local Tab2 = Window:AddTab("Tab 2")

-- Create a main section inside Tab1
local MainSection = Tab1:AddSection("Main Section")

-- Add a label with the text "Hello, Welcome!"
MainSection:AddLabel("Hello, Welcome!")

-- Add a button with the label "Run Test" and a function that prints a custom message when clicked
MainSection:AddButton("Run Test", function()
    print("Test button was pressed!")
end)

-- Add a toggle with the label "Enable Feature" and a function that prints the toggle state in a friendly format
MainSection:AddToggle("Enable Feature", function(State)
    if State then
        print("Feature is enabled!")
    else
        print("Feature is disabled!")
    end
end)

-- Add a dropdown menu with options "Option 1", "Option 2", and "Option 3" and a function that prints the selected option
MainSection:AddDropdown("Choose Option", {"Option 1", "Option 2", "Option 3"}, function(Option)
    print("You selected: " .. Option)
end)

﻿. .\beacon.ps1
. .\registry.ps1

# Debugging reference!
#[System.Windows.Forms.MessageBox]::Show("Exists")

Function Get-DataBeacon
{
    # Log Location Text
    $logLabel = New-Object System.Windows.Forms.Label
    $logLabel.text = "Log Location"
    $logLabel.Location = New-Object System.Drawing.Point(15,50)
    $logLabel.AutoSize = $true
    $logLabel.Font = $textFont
    #$logLabel.TabIndex = $selectedTab.TabIndex
    $scriptBeacon.Controls.Add($logLabel)

    # Browse Button
    $buttonBrowse = New-Object System.Windows.Forms.Button
    $buttonBrowse.location = New-Object System.Drawing.Size(700,50)
    $buttonBrowse.Size = $buttonSize
    $buttonBrowse.Text = "Browse"
    $buttonBrowse.Font = $buttonFont
    #$buttonBrowse.TabIndex = $selectedTab.TabIndex
    $scriptBeacon.Controls.Add($buttonBrowse)
    $buttonBrowse.Add_Click(
        {
            $browser = New-Object System.Windows.Forms.FolderBrowserDialog
            $browser.ShowDialog()
                    
            $textFileLocation = New-Object System.Windows.Forms.TextBox
            $textFileLocation.text = "$($browser.SelectedPath)\beaconlog.txt"
            $textFileLocation.Location = New-Object System.Drawing.Point(130, 50)
            $textFileLocation.Size = New-Object System.Drawing.Size(550,40)
            $textFileLocation.ReadOnly = $true
            $textFileLocation.Font = $textFont
            $scriptBeacon.Controls.Add($textFileLocation)
            $script:logLocationBeacon = $textFileLocation.Text
            
            if (!(Test-Path $logLocationBeacon))
            {
                New-Item -Path $browser.SelectedPath -Name beaconlog.txt
            }
        }
    )
}

Function Get-DataRegistry
{
    # Log Location Text
    $logLabel = New-Object System.Windows.Forms.Label
    $logLabel.text = "Log Location"
    $logLabel.Location = New-Object System.Drawing.Point(15,50)
    $logLabel.AutoSize = $true
    $logLabel.Font = $textFont
    #$logLabel.TabIndex = $selectedTab.TabIndex
    $scriptRegistry.Controls.Add($logLabel)

    # Browse Button
    $buttonBrowse = New-Object System.Windows.Forms.Button
    $buttonBrowse.location = New-Object System.Drawing.Size(700,50)
    $buttonBrowse.Size = $buttonSize
    $buttonBrowse.Text = "Browse"
    $buttonBrowse.Font = $buttonFont
    #$buttonBrowse.TabIndex = $selectedTab.TabIndex
    $scriptRegistry.Controls.Add($buttonBrowse)
    $buttonBrowse.Add_Click(
        {
            $browser = New-Object System.Windows.Forms.FolderBrowserDialog
            $browser.ShowDialog()
                    
            $textFileLocation = New-Object System.Windows.Forms.TextBox
            $textFileLocation.text = "$($browser.SelectedPath)\registrylog.txt"
            $textFileLocation.Location = New-Object System.Drawing.Point(130, 50)
            $textFileLocation.Size = New-Object System.Drawing.Size(550,40)
            $textFileLocation.ReadOnly = $true
            $textFileLocation.Font = $textFont
            $scriptRegistry.Controls.Add($textFileLocation)
            $script:logLocationReg = $textFileLocation.Text

            if (!(Test-Path $logLocationReg))
            {
                New-Item -Path $browser.SelectedPath -Name registrylog.txt
            }
        }
    )
}

Function New-Form
{

    #[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
    #[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    ##########################################################################################
    #
    #   Begin section for declaring sections of the form
    #
    ##########################################################################################


        # Form Setup
        $form = New-Object System.Windows.Forms.Form
        $tabControl = New-Object System.Windows.Forms.TabControl
        $welcomePage = New-Object System.Windows.Forms.TabPage
        $labelInformation0 = New-Object System.Windows.Forms.Label
        $labelInformation1 = New-Object System.Windows.Forms.Label
        $labelInformation2 = New-Object System.Windows.Forms.Label
        $scriptRegistry = New-Object System.Windows.Forms.TabPage
        $scriptBeacon = New-Object System.Windows.Forms.TabPage
        $scriptCleanup = New-Object System.Windows.Forms.TabPage
        $labelIP = New-Object System.Windows.Forms.Label
        $textIP = New-Object System.Windows.Forms.TextBox
        $buttonIPUpdate = New-Object System.Windows.Forms.Button
        $labelPings = New-Object System.Windows.Forms.Label
        $textPings = New-Object System.Windows.Forms.TextBox
        $buttonPingUpdate = New-Object System.Windows.Forms.Button
        $buttonOkay = New-Object System.Windows.Forms.Button
        $buttonCancel = New-Object System.Windows.Forms.Button

        # Button size standardization
        $buttonSize = New-Object System.Drawing.Size(120,25)

        # Setting up fonts for specific pieces
        $mainFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
        $buttonFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
        $textFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Italic)
        $resultFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Bold)
        # Font styles are Regular, Bold, Italic, Underling, Strikeout

        # Main Form
        $form.Text = "Exercise Script"
        $form.Name = "form"
        $system_drawing_size = New-Object System.Drawing.Size
        $system_drawing_size.Width = 900
        $system_drawing_size.Height = 720
        $form.ClientSize = $system_drawing_size
        $form.WindowState = "Normal"
            # Maximized, Minimized, Normal
        $form.StartPosition = "CenterScreen"
            # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
        #$form.BackColor = "LightGray"
            # color names are static properties of System.Drawing.Color
            # you can also use ARGB values, such as "#FFFFEBCD"
        $form.ForeColor = "Black"
        $form.Font = $mainFont


    ##########################################################################################
    #
    #   Begin section for Setting up the Tabs
    #
    ##########################################################################################
        
    # Tab Control
    $tabControl.Location = New-Object System.Drawing.Point(0,0)
    $tabControl.Name = "tabControl"
    $tabControl.Size = New-Object System.Drawing.Size(900,650)
    $tabControl.ForeColor = "Black"
    $form.Controls.Add($tabControl)


    ##########################################################################################
    #
    #   Begin section for Welcome Tab
    #
    ##########################################################################################


    # Blank "Welome Tab"
    $welcomePage.UseVisualStyleBackColor = $True
    $welcomePage.Name = "welcomePage"
    $welcomePage.Text = "Welcome"
    $tabControl.Controls.Add($welcomePage)

    $labelInformation0.Location = New-Object System.Drawing.Size(50,50)
    $labelInformation0.Name = "labelInformation"
    $labelInformation0.Text = "Labor of love. This was built in order to have a central place to setup, configure, and run scripts as necessary for exercises."
    $labelInformation0.Height = 150
    $labelInformation0.Width = 700
    $welcomePage.Controls.Add($labelInformation0)

    $labelInformation1.Location = New-Object System.Drawing.Size(50,210)
    $labelInformation1.Name = "labelInformation"
    $labelInformation1.Text = "Select the tab above to set up the script you'd like to run. Ensure that all of your settings are correct and run the script."
    $labelInformation1.Height = 150
    $labelInformation1.Width = 700
    $welcomePage.Controls.Add($labelInformation1)

    $labelInformation2.Location = New-Object System.Drawing.Size(50,370)
    $labelInformation2.Name = "labelInformation"
    $labelInformation2.Text = "Created by: SSgt Machaby -- Last updated: 03 Feb 2019"
    $labelInformation2.Height = 120
    $labelInformation2.Width = 700
    $welcomePage.Controls.Add($labelInformation2)


    ##########################################################################################
    #
    #   Begin section for Beacon Script Tab
    #
    ##########################################################################################

    # Beacon Script
    $scriptBeacon.UseVisualStyleBackColor = $True
    $scriptBeacon.Name = "scriptBeacon"
    $scriptBeacon.Text = "Beacon Script"
    $tabControl.Controls.Add($scriptBeacon)

    Get-DataBeacon
    # IP Address Label
    $labelIP.Text = "What is the Desitnation IP?"
    $labelIP.Location = New-Object System.Drawing.Size(15,100)
    $labelIP.AutoSize = $True
    $labelIP.Font = $textFont
    $scriptBeacon.Controls.Add($labelIP)

    # IP Address for Beacon Script
    $textIP.text = "000.000.000.000"
    $textIP.Location = New-Object System.Drawing.Point(230,100)
    $textIP.Size = New-Object System.Drawing.Size(150,40)
    $textIP.Font = $textFont
    $scriptBeacon.Controls.Add($textIP)

    # IP Address update Button
    $buttonIPUpdate.location = New-Object System.Drawing.Size(700,100)
    $buttonIPUpdate.Size = $buttonSize
    $buttonIPUpdate.Text = "Set"
    $buttonIPUpdate.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonIPUpdate)
    $buttonIPUpdate.Add_Click(
        {
            $script:ipaddress = $textIP.Text
            $messageboxConfirm0 = [System.Windows.Forms.MessageBox]::Show("IP is now $($ipaddress). Is this right?","IP Address","YesNo")
            switch ($messageboxConfirm0)
            {
                'Yes'
                {
                    # Keep IP Address
                    
                }

                'No'
                {
                    # Close message box and allow re-enter of IP Address
                    [System.Windows.Forms.MessageBox]::Show("Double check your IP Address")
                }
            }
        }
    )

    # How many times it attempts to "reach out"
    $labelPings.Text = "How many pings?"
    $labelPings.Location = New-Object System.Drawing.Size(15,150)
    $labelPings.AutoSize = $True
    $labelPings.Font = $textFont
    $scriptBeacon.Controls.Add($labelPings)

    # Get input from User
    $textPings.Text = "100"
    $textPings.Location = New-Object System.Drawing.Point(230,150)
    $textPings.Size = New-Object System.Drawing.Size(75,40)
    $textPings.Font = $textFont
    $scriptBeacon.Controls.Add($textPings)

    # Ping Number update Button
    $buttonPingUpdate.location = New-Object System.Drawing.Size(700,150)
    $buttonPingUpdate.Size = $buttonSize
    $buttonPingUpdate.Text = "Set"
    $buttonPingUpdate.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonPingUpdate)
    $buttonPingUpdate.Add_Click(
        {
            $script:pings = $textPings.Text
            [System.Windows.Forms.MessageBox]::Show("Max tries is set!","Confirmed","OK")
        }
    )

    ##########################################################################################
    #
    #   Begin section for Registry Script Tab
    #
    ##########################################################################################

    # Registry Script
    $scriptRegistry.UseVisualStyleBackColor = $True
    $scriptRegistry.Name = "scriptRegistry"
    $scriptRegistry.Text = "Registry Script"
    $tabControl.Controls.Add($scriptRegistry)

    Get-DataRegistry


    ##########################################################################################
    #
    #   Begin section for Cleanup Tab
    #
    ##########################################################################################

    # Cleanup Script
    $scriptCleanup.UseVisualStyleBackColor = $True
    $scriptCleanup.Name = "scriptCleanup"
    $scriptCleanup.Text = "Cleanup Script"
    $tabControl.Controls.Add($scriptCleanup)

    ##########################################################################################
    #
    #   Begin section for running or canceling the scripts
    #
    ##########################################################################################

    # Okay Button
    $buttonOkay.location = New-Object System.Drawing.Size(300,690)
    $buttonOkay.Size = $buttonSize
    $buttonOkay.Text = "Okay"
    $buttonOkay.Font = $buttonFont
    $form.Controls.Add($buttonOkay)
    $buttonOkay.Add_Click(
        {
            Get-Date | Out-File -FilePath $logLocation -Append
            $break = "###########################################"
            $break | Out-File -FilePath $logLocation -Append
            $ipaddress | Out-File -FilePath $logLocation -Append
            $pings | Out-File -FilePath $logLocation -Append
        }
    )

    # Cancel Button
    $buttonCancel.location = New-Object System.Drawing.Size(500,690)
    $buttonCancel.Size = $buttonSize
    $buttonCancel.Text = "Cancel"
    $buttonCancel.Font = $buttonFont
    $form.Controls.Add($buttonCancel)
    $buttonCancel.Add_Click(
        {
            $form.Close()
        }
    )

    $form.ShowDialog() | Out-Null
}


New-Form
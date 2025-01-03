
function Add-CustomSharePointSiteAgent {
    param (
        $AgentTemplateFile,
        $SiteUrl,
        $DisclaimerText,
        $ClientId
    )
    BEGIN {
        Connect-PnPOnline -Url $SiteUrl `
                  -ClientId $ClientId
        $agentTemplateContent=Get-Content $AgentTemplateFile -raw
        $site=Get-PnPSite -Includes Id
    }
    PROCESS {
        $webs=Get-PnPWeb -Includes Title,Id
        foreach ($w in $webs) {
            $thisAgentContent=$agentTemplateContent | ConvertFrom-Json
            $thisAgentContent.customCopilotConfig.conversationStarters.welcomeMessage.text += $disclaimerText
            $thisAgentJSON = $thisAgentContent | ConvertTo-Json -Depth 10
            $thisAgentJSON=$thisAgentJSON.replace("<<SiteId>>",$site.Id)
            $thisAgentJSON=$thisAgentJSON.replace("<<SiteURL>>",$w.Url)
            $thisAgentJSON=$thisAgentJSON.replace("<<Site Name>>",$w.Title)
            $thisAgentJSON=$thisAgentJSON.replace("<<WebId>>","$($w.Title) Agent")
            $thisAgentJSON=$thisAgentJSON.replace("<<AgentName>>",$w.Id)
            $thisAgentJSON=$thisAgentJSON.Replace( "\\n","\n") #added this because PowerShell ConvertTo-Json escapes the new line characters
            
            $agentFileName = "$($w.Title) Agent.agent"
            $webRelativePath = $w.Url -replace "^(https?://[^/]+)", ""

            Add-PnPFile -FileName $agentFileName -Folder "$webRelativePath/SiteAssets/Copilots/Approved" -Content $thisAgentJSON
        }

    }
    END {


    }
}

#Update the variables below for your environment
$agentTemplateFile = ".\AgentTemplate.agent" #Update to the path where you store the agent template if it is in a different directory
$siteUrl = "https://contoso.sharepoint.com/sites/site"
$clientId="<<Your Microsoft Entra Client Id>>"
$disclaimerText = " \n\n**** DISCLAIMER: Please note that responses from this agent are AI generated and may be incorrect. ****"

Add-CustomSharePointSiteAgent -AgentTemplateFile $agentTemplateFile `
    -SiteUrl $siteUrl `
    -DisclaimerText $disclaimerText `
    -ClientId $clientId
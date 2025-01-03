# Overview

These scripts are examples of how to update and create SharePoint Agents via PowerShell

# Script Reference

| Script | Description | Permissions Required | Dependencies | 
| --- | --- | --- | --- |
| Add-SharePointAgentDisclaimer | Iterates through Site Collections, Webs, Lists, and Items to gather information at each level | SharePoint Application Sites.FullControl.All | PnP PowerShell |
| Add-CustomSharePointSiteAgent.ps1 | Adds a custom SharePoint Agent to the Site Assets/Copilot/Approved folder of a site | SharePoint Application Sites.FullControl.All | PnP PowerShell<br>AgentTemplate.agent file (included in repo)  |


# PowerShell Requirements

*   [Windows PowerShell 7.0 or higher](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4)
*   [PnP.PowerShell module 2.99.74 or higher](https://pnp.github.io/powershell/articles/installation.html)
*   [Entra ID Application Registered to use with PnP PowerShell](https://pnp.github.io/powershell/articles/registerapplication)
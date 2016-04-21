//------------------------------------------------------------------------------
// <copyright file="ApplicationConfigurationPage.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

namespace System.Web.Administration {
    using System;
    using System.Configuration;
    using System.Globalization;
    using System.Security;

    public class ApplicationConfigurationPage : WebAdminPage {
        protected override void OnInit(EventArgs e) {
            NavigationBar.SetSelectedIndex(2);
            base.OnInit(e);
        }
    }
}



//------------------------------------------------------------------------------
// <copyright file="WebAdminPage.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

namespace System.Web.Administration {
    using System.Web.UI;
    using System.Configuration;
    using System.Web.Configuration;

    // Base class for use elsewhere in the code directory
    public abstract class NavigationBar : UserControl {

        public abstract void SetSelectedIndex(int index);
    }
}


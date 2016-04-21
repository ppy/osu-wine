//------------------------------------------------------------------------------
// <copyright file="WizardPage.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

namespace System.Web.Administration {

    public abstract class WizardPage : WebAdminPage {
        public abstract void DisableWizardButtons();
        public abstract void EnableWizardButtons();
        public abstract void SaveActiveView();
    }
}



Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF2CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B3D40663;
	Mon,  8 Sep 2025 13:05:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 263A640264
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757329531; x=1788865531;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uvdr1xoD0bDMd48BA5w1WyMqw6cB1HkJM3AayvQeUsk=;
 b=ARfSWlKd+dC7BbxzL1Txz7ICSFZP40RDe1iWUk5EVPbpekaOzDjovuTG
 PZlyoawuE6hpjynxYlPsyCfQeLZ1gu4v5utl2Fjt4+UI7A3ciS0Fq27Dn
 AnNUhFtgKSbw7LMtQT02QOl6kBwCoxf243KdNi9E9DwbhoZxqcVoZDBYE
 HcKRiQmR8vMeQsJ+gQl+t67Z/0hnokRKcG8GQmubX7DXz4e2lRsS7qHxc
 9zBHDHnekbG2l+hGOK+z6RrxYgGKHIwWyfgmf9GUPoLRS6PO7+n4JF2J/
 +arUQjwUF7soN+RRlcw8fubE170S2P5S8TA7fYpcsvWVgyIT4HPbyOcHp w==;
X-CSE-ConnectionGUID: q2oyiPVMSyiJYrBeizR6Vw==
X-CSE-MsgGUID: leX7WGCwQu6sgHXLK22P3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59537086"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59537086"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 04:05:30 -0700
X-CSE-ConnectionGUID: lwrVSL09RB+VWp4CUOlQ0g==
X-CSE-MsgGUID: X+g9dHD4QHafnsTsCHZzNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="172886327"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 04:05:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 04:05:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 04:05:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.78)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 04:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP4qCgMD5U6hMvtCLmaNkZnj+uTuYE26jRvYCMdbZA0cRYwGX7UHGZBYu1GNBWM21jXffE+BxUd1HAf9GvB/dGU6gCBDUtD4aquVSNOQ89yHTwRENu21Dw85BDkSz3WJ2K14wKVsyvsxnsKAihveBpXvgeIczl097h5PSTayRfk0ahwtmfbhj3Mta4uzudHsL6u73/JtYnbIr/ph9HCHG7kVSM0E/o8CEQWhAaNs3Adlp1UymwXYPyCdciizJhNiH6AUjjF4e2WcYpg0LoJ4Lap9JnKiK19gDIt7FUZ3hHAkXNAua5MNABM0yiJmhcum7DXZY8/T/FWvBCbQqL1bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MDR++j2QPYPvuPLHLz9tzAJQe5gCCTK6C2SbRr0FfY=;
 b=cQqfjQhVHvNiRCOfPNPLFID7s/X4ZVpihwWeAC9K7J8zgBoUAZqmnqMptoz/hyK/2LpATJ82H7IM0iM3sVjGN1mn8DHLsowFxUEIQROyeUzTfIK9fPSyO/ODnsQf8/vDKpQXXa/GIbcQaP0znbDFx/KjtKJU5wwQcDYJ2jTZEZ9gjqpoX4BQD+7ug26WY0vWKcEo+a3KjwEJyxn1qaJlcUy6ee1Wo4+PnCxw03PbP7u1MtSUMQH52oQ7P8ZYZfkmaf+PK4pRBLDttzZfBl7IFAIQqjE3JEHZGRmyebmRIr+3qP9WPcRhHUlEf0X3LdWPBoYYQZbDYHdPn5uCIDMXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7625.namprd11.prod.outlook.com (2603:10b6:806:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:05:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:05:22 +0000
Date: Mon, 8 Sep 2025 12:05:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/ice: make link state configurable on device close
Message-ID: <aL64bkrhe6B-5VHP@bricha3-mobl1.ger.corp.intel.com>
References: <20250828102305.1522036-1-ciara.loftus@intel.com>
 <20250829094523.1582102-1-ciara.loftus@intel.com>
 <aL63ZoyNsi1hKyyC@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aL63ZoyNsi1hKyyC@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P194CA0015.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 944f0f59-367e-478b-0d6e-08ddeec79aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SbduAZ/N7Xf0CdFWAdFwD/6OwJoQMgCbwSsJXrFk7k6ugoArHgnlCaxRDtub?=
 =?us-ascii?Q?cW9S8CYGwwRcnEdvgUHeNh7xlY/0WxW9pAHSdvyTI1CaxpxuYjoxzyF7AMOv?=
 =?us-ascii?Q?qWqteE4wOqCuLVE14p7WaXP+TzxADy4kwv/2qPNjX9yaMyoqHWIMHsbjfjSi?=
 =?us-ascii?Q?A9T0jFIQCwI57H/DBri4Zb1OqoXwkJGTSwHt0dekUVOQNZzlMvpCXhwtsbIg?=
 =?us-ascii?Q?p/NnEUGk8JXR5TGissXbaEzoLC8PebzRhDH6z5cBEWIfS7maXKHGWaITHM9x?=
 =?us-ascii?Q?pRZgO8ZbrTB0gVdGomzD2GlZVLASOclxgZuEWk9hPk9bMbWnkDplO9oNukQV?=
 =?us-ascii?Q?G0B3w2163WdJF6ysjVyYyntzbDYmIj8cdqTkEeGXLn6pHsX/u4oOhhxKdIYg?=
 =?us-ascii?Q?swJtXkLCQ+EmNU4cbp7xjdN/0vwedftYwnPtxXDQmVQVCEA8olahOrMt3iEH?=
 =?us-ascii?Q?JSCkXdWah/ZyihJc/VLacNJw407cAuHnPbRBkV+mB4TAd978DO8sw5sRB2eb?=
 =?us-ascii?Q?1jW5QZHKwqhoR+0Yc7y8rgyma3EUmNto+BJOAgGrJ3Zrvp3aTfVbvU8VzIDp?=
 =?us-ascii?Q?8gciPED6l4KzZ3bIvgEp74H/fTrp3JRVkCYidC/zGx/RtB9E2lEvkpA1trJh?=
 =?us-ascii?Q?k+q+hgWZkn5lLD/WOWNF5D/u4yLunJSgA+Gh3B2KH0IYOAcb2bVtdzGN1Vsu?=
 =?us-ascii?Q?kFOm2wJFxt55tOnHaxvbVDnK0iH4MfTDFnm6rsjLlQ2MQXpcmY5cZir2EIhs?=
 =?us-ascii?Q?qXkOQXAQLYTCLdW3HLNaFL4r+IHtCeJIWxk80yR1RL6YEgO9lYoVmhv3ECqL?=
 =?us-ascii?Q?EGOJQio4kpWL1jcoZgfsvN/yAgPhQjpEkZJJwafz8pviuYoz5s2Ugqoh4D2s?=
 =?us-ascii?Q?bTK+ZH2nFjD0uOsLmfaEpIk0YiNAV4V1gF4D+ZYpNrVkg1MbKX2rQS0D2vxd?=
 =?us-ascii?Q?+aFvGgTqFqM3AcX+dYLCcF6sKCA69qg620RyM1jDPuq9P0noQNcExZVpRH6D?=
 =?us-ascii?Q?JCqM5iUyCjH3SyKqEqiap4+ujPhurgspjOMte1DqbqrVCkXPUHJ18JJvQw0p?=
 =?us-ascii?Q?DHpqz3wp2tOwPvuY95WLO9PBZTKpzJzclN/2WZsiaqqcuj5GE7o6fYIonWbI?=
 =?us-ascii?Q?RCVRaomUuDV98leUcTA4KYFbDud17/TcrjFTFl27q38b4V7dODTFq/eufhTk?=
 =?us-ascii?Q?x86qftSPMQnNfBvmzsKhGMpelHxjN+HOcbxs/OzGpL7RzmOIYihdscwY3wzV?=
 =?us-ascii?Q?SuUKvaLTqG6zFVm0t19aNmA9HYHmvg90pydR+uabrrorJAO2cCbBcTXbpmCw?=
 =?us-ascii?Q?CptlpOiJ4CEq4SgXrbNHV8YKTkHAvq0738BgUGuLm+5LijdDn1W9UATAF22l?=
 =?us-ascii?Q?uMeQrUDrp/Bb+QHTCgZsUthc9haZj+211EwZG0CDpQNaCTTP2m6POc3aFv7k?=
 =?us-ascii?Q?29g4yPbDxOg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pX7BdVvhAmAArlVr6iu81gJ17dwyR59zdtTzub9cAY6qT6L9jCGNX0v2yBhA?=
 =?us-ascii?Q?rH6UQRNAdI9mQv64Fobi4FT53yvpAaWjcH6PvVZgPPhVqlyVbG7/LHeUbMrQ?=
 =?us-ascii?Q?mtX/ZNbJvdccBjYovWw0kG3skg7iUu+aJVg1sG5XWLRu3OkUvWofs2eUYn89?=
 =?us-ascii?Q?nO0H9smbpQYPEpyrsZslVmR28bH0gPvvG5lawscNFxIv4PFQ3uteJn4VwHyO?=
 =?us-ascii?Q?gjWqkP20dq3myu+DF4jmo2CJT72uwwIaoyW9+dn6Ppirc+kn13MCv5EJOeAE?=
 =?us-ascii?Q?iyiVVKuGRoCTYFjpd3jPKFHqTRPf2WgdGa9TuvuOWIgDcKwqAtyQEfBtwHwq?=
 =?us-ascii?Q?SNcqZnfzIGBx1IXk90LpxvXuq4sIJr6XqHqY2nt9Icg+nEzhNhg7jljS4w4W?=
 =?us-ascii?Q?D2Ru7oyEFWPCnalNizQDcQ03I1k9dnvSzbL+Fj1+SB1nE0l4dzVPLOOlLC4L?=
 =?us-ascii?Q?g3/axabT3Y35ngq8Eld0nwWuuaFTX0ydZIE2oDWt9thlJNxUzN6+Umjphlm3?=
 =?us-ascii?Q?km+YWsb5bBNqr38DDvGiJsE4Wip288ogFCVnpnAjnVZKc46agrtg3xoBcbJk?=
 =?us-ascii?Q?rLrOhrNDKXpbj046WrvOc9Pp5x+aL5GH//MCPOPThor08ttHXXfTKol/zBJe?=
 =?us-ascii?Q?5fokRZp/UwRqcB1TGK8M9hE6d5ifhjri+xpwOdHvYQyRYG0JvI6PXBrnwS9r?=
 =?us-ascii?Q?InXsRCrBE52NGYs3n8g81Sl8goMDMqSULZ7dTk5BRn4Xoj4yn3nUy4X32+JA?=
 =?us-ascii?Q?NAUpLDGikUXoecEsSqx0GpaG+BIfzpAEwvclC9CN9ppCHXrZ8ObvZr3KSOzl?=
 =?us-ascii?Q?+RLjMOmg076eDDuv8nZ/jo/0iyTjBkyA4WEC53iPNvn70eEa+HAHHfmZaxNW?=
 =?us-ascii?Q?uF1dKZ+hPOZpyqjs1CT5B6htvCPtfVgNXsJGWMENi2W8xPIWS43OmUkAtZSL?=
 =?us-ascii?Q?PgTnBm/8ah9wmbncfozjrVNKtnXG+oaBigFwTka4yTWEpaGrKXg27aXst/SJ?=
 =?us-ascii?Q?oDlM+x22/CbS+ke6UQ9WRD6wWEzvzwQ3KI1K+Az8enBTiqhR14Gwcx8SN96G?=
 =?us-ascii?Q?eLYG5RazPTCxroGUe5shlRBcqpEZ92CXS1MzxQoGQ+FxDiPOX8LGfA7hLamr?=
 =?us-ascii?Q?FWGka/y3bopuy66V3aPFCRph0hqm6p7G7XvyVR7RPR3RzWIYcDvRbW2UiwCS?=
 =?us-ascii?Q?AUcWkaph3CFceeyLwW+cCf1ZO3iDzLcRtPnIFslgwlVkupk2Z+qgV/ry0F6T?=
 =?us-ascii?Q?cDMgCsR4GCEdj/PcOy7qUGTm33jahmVr03n4zfqrxRJgWVNTj43+qcKUWq7q?=
 =?us-ascii?Q?p3Q7omwc+7EMCIp82THhIHvbjj8dgXLf/fZzqudAqffLqZl+TXVH1q0REEQL?=
 =?us-ascii?Q?SgJ3K4vy3QeBaSlq8/tV6lDng7sUDsy9GdpBOssbvPvPRsyjEzLzskS2Zas5?=
 =?us-ascii?Q?9g+KX1PPbjiHjy8BVVIeeBA+VHvcvcLRP/P1nZfV6G60WdJW+/f8x9siwq0A?=
 =?us-ascii?Q?gQ4tuZqumZ0zpBOv7i2KWBjBY+GAlGBLAxSiKKCDP44HO3uF15KKtMDU85EP?=
 =?us-ascii?Q?RuPLYutY7ZxHBlC2ijKZVqSYyWHdfMdN52nyodRx/zpWBtasVwi7tBliID4R?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 944f0f59-367e-478b-0d6e-08ddeec79aff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:22.4875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AslDA8hZz5Ct0CRKk4SDj4AI48tcYofLcTlzP4oMLAhHge3gPVnaAu30qr6Wc/lVqy3URQRi0843rbbRvZ6aw+8Z9gLaxjCm7RDwoJbLC8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7625
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Mon, Sep 08, 2025 at 12:00:54PM +0100, Bruce Richardson wrote:
> On Fri, Aug 29, 2025 at 09:45:23AM +0000, Ciara Loftus wrote:
> > Introduce the device argument link_state_on_close for the ice driver.
> > When the device is stopped or closed, the link state will be configured
> > as follows for each of the three options:
> > 1. down: bring (or keep) the link down
> > 2. up: bring (or keep) the link up
> > 3. initial: restore the link to the state it was in when the device
> > started.
> > 
> > Prior to this commit the default behaviour was to always restore the
> > link to its initial state. The new default behaiour is to always bring
> > the link down, which is in keeping with most other drivers.
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel, thanks.

Hopefully we can get rid of this devarg in future if/when the proposed
ethdev setting for this behaviour is finalized and merged.

/Bruce

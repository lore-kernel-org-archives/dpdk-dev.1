Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E29C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDB6A402AB;
	Fri,  8 Aug 2025 18:47:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 205814028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:47:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754671658; x=1786207658;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HR0KgHPJWFSYXWrZdNkj1DbzfuC4D78l67g360TMWj4=;
 b=TZOEvHByI7c1U7nFxO7SfwA9AnfQrQaS2IEO2nqW30kj10fWLr+nyGD9
 9dDanGdSUXwg9Ch2cy0dQx54ZpZYZJo8g+nkyJRHPbLdBTZXdu/+8knUL
 TY4i4mU34zeR3cnuYJ5RMw+pwjpaJbrjIoVVgjGsEawgXDcFlEiFcX3w2
 URnadsbQ9ICPIRL3qC+68mmIVIF9S8KrdoKLIWT8PL+vWmOJ+uzg+H/LD
 UmNUFHPNttXvrIYc38xRU0/dEBebvQysNcaAw72VPyj8HfMAp4BGlkjte
 rsH34WFbVCiqzv3wxJKYX8fYbCGoPirPCksqggT10esAmneGU2/kUmKk/ w==;
X-CSE-ConnectionGUID: FBld3zIHS3CyYbohxz5sEg==
X-CSE-MsgGUID: OrePu3quTY+PHh26fCX+Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="67725317"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67725317"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 09:47:37 -0700
X-CSE-ConnectionGUID: QmnALMgzTSObcPtab8nIRQ==
X-CSE-MsgGUID: hTlakTCvSR+4GuVFY7OJ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="164602561"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 09:47:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 09:47:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 09:47:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 09:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZEmMl2+k3V2DEavgqmjK6SGc/Jlos1hIYAUXECR167+FpJ+pV0+L0/dgG9Zc4pFWfiOpokqTOBWbWqrOf3utHYs2x/ZCbBQuz1C/JLdxriRJii4VzLZ1mUoitRQ1DKZdzsn0XHnvLHzooPExv+p/DKAduyrC2kvM/AXGM75KcI6kihLMqjjjrLig18jEmelC8mrBIR+UFUNEa3rLI6En7lybOyy/p7bP7XNnMRbNsaRtmidTj8Al9ZVAuHopUs8kk/VYaH6dSCHfpznBamS3t2vkcp5Py1YC4zqCCLrlqrXOjkTlOznwQ53/U35EioYkRos+9tNmd/WzYo23ey8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkpykLtIwgwEUTaJJUlz/9aDVMGak5SZ/EFqkDoO3Wg=;
 b=WORVjTBsBx5JPAxO2yaaujxCUspRfsQUU1Hil+05vEzl0usy4I+vN1wYLAD4WeNDdac5LgTkCiL2yS45U/sjsN0MwrkxPOBjV11VJNkNyANlpPp3dYFMZU7YrVolRXNJnPxRsYdr+zsV2FwP2BMBBAoAAvZxJvToRmI2RzojtQ4rI/Hc+z3zEZlWoNUyDHZj1NjU2Ff2LUpIy2AbcbZsbNGyQ0PgRIbviiEgsXNqwzcodM29TMG5qLvaHnNRJOBPv4rScx9hrDgliNAq7BTmYVv6LAoXVSPU1ksqYbgeQfLPUH0NvUzpaBjIkqBR73PG3JcAwavcMklSoGua6ILkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPFED6629EA1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 16:47:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 16:47:34 +0000
Date: Fri, 8 Aug 2025 17:47:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
Message-ID: <aJYqITy_o_dK42aZ@bricha3-mobl1.ger.corp.intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808142721.408998-2-bruce.richardson@intel.com>
 <2b31ddbcc8174ff89b5c4a063e55003c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b31ddbcc8174ff89b5c4a063e55003c@huawei.com>
X-ClientProxiedBy: DBBPR09CA0031.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPFED6629EA1:EE_
X-MS-Office365-Filtering-Correlation-Id: eac8d104-1ca7-4b73-f3aa-08ddd69b45fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wm2n7XFCJrMq7/EAUCL0kbhZ+8D32lkG6PeOPHjC3foByyh0Ct58Vmexq3oT?=
 =?us-ascii?Q?FhuSMgE+U2s1BDV0/vDvIoO+ctzP8Lep7yUGTR1rKy/YiproajKU9tGCfuf6?=
 =?us-ascii?Q?B2X7+LA9P7Kh854OrBuDRIb+uZgkl/v/Kwcl8J6SJH+Hp4CEfvWzGz7sMgOe?=
 =?us-ascii?Q?bvu7QPiR8My4NXwGmc+xj8VYozGFn0Lp69/HyvRSEuDXqJyWxKSpsl4HEnSm?=
 =?us-ascii?Q?AN8D8lVYW/Wl1SA4XotH6JzFlm8i5yL1HoTB5PUW01oXzjPGXAeWAm/Xv+2s?=
 =?us-ascii?Q?mZZbk+VrWuZfAO8lWP1yMv0cRM9cjB3xxr/7LOWRdYMcIPVozArPCxExfjPx?=
 =?us-ascii?Q?u2ULyB5kXCSwk8bLcjy9eY7uFxJ9C5OpBLU/HuED9yywl2AFqjdCBcY/0Cm3?=
 =?us-ascii?Q?PuPZFQKZYlIea4by683tHypIVxHBqYNygGch7DmJC2An0B+n5dK5DR8CF98b?=
 =?us-ascii?Q?sYOADcwvzCcua2a5lQfi+3zRpXlC7wyg9bmq7HVGPigHJRgmF2MV6wg5fGDG?=
 =?us-ascii?Q?EWGnjMDArU0GRmiVXZpNsPVtD64jLLEZr4mkXsJGowowInq1dcepkWj9vSMX?=
 =?us-ascii?Q?IROCzII1XrmY3HEhOSW5v63h6+BcDNr1TvV0Oc2HelgkKAu821OFRLshSaEb?=
 =?us-ascii?Q?OZIj+FVzyiFw2kThGMEtEHa1Gs+lehaDOwsLaw6WDlV9q6HOOvvf0ad7uw2h?=
 =?us-ascii?Q?CoHu6mYdhPE/H/AjZhgBcoykeD2urUlTL1+CG2WKmwGZ13yzssfW7Trd8i3R?=
 =?us-ascii?Q?RuUv6ZrxQKZu/noFhMO6xS0R2KupUXsq/jzGxWQUdKoo97fJWA4Y39bXGBzC?=
 =?us-ascii?Q?HRf/w5gUSmacB439SxYXknmsi6cGFUgc5MuZV9Pa5lflvMLoItt+p3YrsxMk?=
 =?us-ascii?Q?3qaWwn74XwJzP8CEjmzva9oihyM7on49zjK0e2NoW/YGRGkQ5zNmmvzUIAbw?=
 =?us-ascii?Q?Qqlnai1+PQBo+B6EgnShNwBYV/GRnx9Yf9yIV1CitP1g/u7oEXc2AP4Ss8kD?=
 =?us-ascii?Q?Lx7NX+neEPyU1yMv39AMSr6uZZrnBfFXv0CtqWFfNf8FrGa8l53xMlhLcmgY?=
 =?us-ascii?Q?lL4INFyUJfmjhZ9mP8thmUaYLeg5exa53ZTP+eq32DabomQNnkpv9V2oPWwR?=
 =?us-ascii?Q?/fSuOqzkHO+cc2j3ciFrSqN2NpVJ5Xlm9nJfFocy4rTN6DgFJPlradaPcs2B?=
 =?us-ascii?Q?z2MJ58bwhS6hkhXlrY9jAGfXl6wDQhrqbWSgF11gCs6EMlETI4so7SzZDDU3?=
 =?us-ascii?Q?dKu/pbj4qcPWJUL/s7r7adlVOJFbZm9ndWWvDGHnyd1t4rTIZrZtflk1SF6A?=
 =?us-ascii?Q?dD52W5Sj+b7eoNga9AZ9ah9E3Ufp5S1Fp1ZJOkyT5pG+aIJhWEgnT01PkTmf?=
 =?us-ascii?Q?THw2C5oxteG6vHQNJs49HXkfiGewVqUCrTdcaDGB1Ea17tuj2DvPC19YeXZF?=
 =?us-ascii?Q?jBSRU92a/0I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CC5u72/+sP+FUm5zMTTKKPsN5yAdsXNilJ63i7e+cw2/jb/XENOqni7L7CbJ?=
 =?us-ascii?Q?BWHsW/d8FwxKT9x2A0jPszucl3i5nhsMbD+M+uSrpVKM3ZPgcOSC2KzyrigU?=
 =?us-ascii?Q?hQ2JbBvPpodt+MgWd/36Sv7zzDYOrbMR3ACbsCPky73tYQwfo2/HsSpeIQmj?=
 =?us-ascii?Q?tXWqrnC3w3rK2j+Ofgif4E/97o1hKuwyLqXVj8o5pccxyXUuRjA/Ger0opcq?=
 =?us-ascii?Q?5emGdJa2m8Lpv9EiyyVl1f6Y3ATV8kCn3hK5RaNHzoz3kgTSybQsJaQSa0Wi?=
 =?us-ascii?Q?MwG7DfT0loGOcuknFdMFrpHmI/4GU0FYAWhDwY4aBTZoOryJ2EvM0j1amNq6?=
 =?us-ascii?Q?AxThk9iuvAeVvWpCwPDwCQTrld2LanDSeScpw7UFCeW3tw8twjKjV+iXrDnh?=
 =?us-ascii?Q?JBjUp8YNli7gUzOheHs0ycH64yiL3ECSAcx3QgZzYZYu3Y+d3QrqIXfr86hj?=
 =?us-ascii?Q?vh6m8Qrc50+16bql5//NWQiiCEBmQDkQSd22zdap7RWUCuHL2J1OL29h51Px?=
 =?us-ascii?Q?Px9EiqAnLc3SSiGijSGK1sIDGtqEwEoR+zExWw5fmm+ZAjvAtKy7v18AwD6F?=
 =?us-ascii?Q?X38lShY5cumT7TuTnrhJpfFavTano80o8fQhPffYNuwxSbhstyv18UVGy+V/?=
 =?us-ascii?Q?IMhMA8C4mpcZiL6fArR+BCLu2/xby/hIDpp1nvWETXig4YbCwU3zO74FV0El?=
 =?us-ascii?Q?c1Pj1rxrb9LBfnGlsYLzCsHLrDle8/p4uHTXFcuN+fRkKgaoScFHXDhnRNe9?=
 =?us-ascii?Q?W0u6TYd6LV+pxOEPiyzCd79WOVDmzBlQCie8jd9OjwEToBVvZGIJrwdKUhV1?=
 =?us-ascii?Q?n+TN090arucxP4/QWbpC7QrVllLU5Pez5Ps0nFGDh3cn9idWlvZUbCRzh5cg?=
 =?us-ascii?Q?U2oeJNJj7j0sxwQoN1xZzMiGGGCJB2muQklL1KQ940CeAPkOymhHoAq650nO?=
 =?us-ascii?Q?28GZRmcW4S1QKIf+339fam7imWmBBkuNPSocxDPUyskUl/q06Yx7ez89zbqQ?=
 =?us-ascii?Q?Wm+/62E960lrIbn3iTD9MPTWIP8LalM+W/x7CdUjludaiZf2dJCSpems+U0a?=
 =?us-ascii?Q?R8nWmT9C6ZYVYV3ZKEa3xKwux2Bi8RV8wzGTnsiPbEttnudsDqITrfaLE6G9?=
 =?us-ascii?Q?EebeOlSWWMg8A8/qRembbiHLnLmIZAgnPGnO1yFVOPxE0Jf1ji7FDDwMv0ta?=
 =?us-ascii?Q?P/N4jx05oey/U/mNCb8A3EIfciuxS97vi5DSuq6+V/S/5qTsVenmxNjFKeWH?=
 =?us-ascii?Q?wdSNIR0mCVQJjCpkP54ZYbF8x7Mu9+Aovn7Zlk1M9vCDCvf+JwaeMWiRzjBa?=
 =?us-ascii?Q?xWr0eKb4Ik03JYiE+akxNyb7egrTjiOhVw4pnZ9bHVPrVVLMJeLoGSeiSoxj?=
 =?us-ascii?Q?f8WQB3PKbYlJldqk76voKSYg9s1vQoF2qODPJdibAQCVOWPUbKnyZNFa1mKz?=
 =?us-ascii?Q?yP++swxAe1yt9TJXmQbO2ZZyalMy2xgT67P2a1xCVoky4OP+WVRaR2CcQi0r?=
 =?us-ascii?Q?+1KfWmKEjbgkyzpIN9QikPkmLGFKkbI6u3ItG0F+lyZRLqb8nVPannqk/zlz?=
 =?us-ascii?Q?WY0CLwiinkVVSwlmz9bAJg1mJDqrSHVyCZnNIdB4jexhjqEx9aCQHr8nlvtz?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eac8d104-1ca7-4b73-f3aa-08ddd69b45fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 16:47:34.1513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YsmrX/2/KGK3psQZ017iJR5sQ2y3njaeku48tYEV9H7b36anhjLKD6ZvkJBCJV7nlzDawRVOa+cWwzRWEreDnLHTig5PjJbDLIczgwjaUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFED6629EA1
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

On Fri, Aug 08, 2025 at 04:44:02PM +0000, Marat Khalili wrote:
> Thank you for doing this! Very cool script, see couple of nits below.
> 

Plenty of nits, actually! :-) Some very good suggestions, most of which
I'll hopefully take on board for a V2.

Thanks for all the feedback.

/Bruce

> > -----Original Message-----
> > From: Bruce Richardson <bruce.richardson@intel.com>
> > Sent: Friday 8 August 2025 15:27
> > To: dev@dpdk.org
> > Cc: Bruce Richardson <bruce.richardson@intel.com>
> > Subject: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
> > 
> > Add a script to easily add entries to, check and sort the mailmap file.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  devtools/mailmap_ctl.py | 211 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 211 insertions(+)
> >  create mode 100755 devtools/mailmap_ctl.py
> > 
> > diff --git a/devtools/mailmap_ctl.py b/devtools/mailmap_ctl.py
> > new file mode 100755
> > index 0000000000..ffb7bcd69b
> > --- /dev/null
> > +++ b/devtools/mailmap_ctl.py
> > @@ -0,0 +1,211 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: BSD-3-Clause
> > +# Copyright(c) 2025 Intel Corporation
> > +
> > +"""
> > +A tool for manipulating the .mailmap file in DPDK repository.
> > +
> > +This script supports three operations:
> > +- add: adds a new entry to the mailmap file in the correct position
> > +- check: validates mailmap entries are sorted and correctly formatted
> > +- sort: sorts the mailmap entries alphabetically by name
> > +"""
> > +
> > +import sys
> > +import os
> > +import re
> > +import argparse
> > +import unicodedata
> > +from pathlib import Path
> > +from dataclasses import dataclass
> > +from typing import List, Optional
> > +
> > +
> > +@dataclass
> > +class MailmapEntry:
> > +    """Represents a single mailmap entry."""
> > +
> > +    name: str
> > +    name_for_sorting: str
> > +    email1: str
> > +    email2: Optional[str]
> > +    line_number: int
> > +
> > +    def __str__(self) -> str:
> > +        """Format the entry back to mailmap string format."""
> > +        return f"{self.name} <{self.email1}>" + (f" <{self.email2}>" if self.email2 else "")
> > +
> > +    @staticmethod
> > +    def _get_name_for_sorting(name):
> > +        """Normalize a name for sorting purposes."""
> > +        # Remove accents/diacritics. Separate accented chars into two - so accent is separate,
> > +        # then remove the accent.
> > +        normalized = unicodedata.normalize("NFD", name)
> > +        normalized = "".join(c for c in normalized if unicodedata.category(c) != "Mn")
> > +
> > +        return normalized.lower()
> > +
> > +    @classmethod
> > +    def parse(cls, line: str, line_number: int) -> Optional["MailmapEntry"]:
> > +        """
> > +        Parse a mailmap line and create a MailmapEntry instance.
> > +
> > +        Valid formats:
> > +        - Name <email>
> > +        - Name <primary_email> <secondary_email>
> > +        """
> > +        line = line.strip()
> > +        if not line or line.startswith("#"):
> > +            return None
> > +
> > +        # Pattern to match mailmap entries
> > +        # Group 1: Name, Group 2: first email, Group 3: optional second email
> > +        pattern = r"^([^<]+?)\s*<([^>]+)>(?:\s*<([^>]+)>)?$"
> > +        match = re.match(pattern, line)
> > +        if not match:
> > +            return None
> > +
> > +        name = match.group(1).strip()
> > +        primary_email = match.group(2).strip()
> > +        secondary_email = match.group(3).strip() if match.group(3) else None
> > +
> > +        return cls(
> > +            name=name,
> > +            name_for_sorting=cls._get_name_for_sorting(name),
> > +            email1=primary_email,
> > +            email2=secondary_email,
> > +            line_number=line_number,
> > +        )
> > +
> > +
> > +def read_and_parse_mailmap(mailmap_path: Path) -> List[MailmapEntry]:
> > +    """Read and parse a mailmap file, returning entries."""
> > +    try:
> > +        with open(mailmap_path, "r", encoding="utf-8") as f:
> > +            lines = f.readlines()
> > +    except IOError as e:
> > +        print(f"Error reading {mailmap_path}: {e}", file=sys.stderr)
> > +        sys.exit(1)
> > +
> > +    entries = []
> > +    line_num = 0
> > +
> > +    for line in lines:
> > +        line_num += 1
> 
> nit: could use `for line_num, line in enumerate(lines, 1)`.
> 
> > +        stripped_line = line.strip()
> > +
> > +        # Skip empty lines and comments
> > +        if not stripped_line or stripped_line.startswith("#"):
> > +            continue
> > +
> > +        entry = MailmapEntry.parse(stripped_line, line_num)
> > +        if entry is None:
> > +            print(f"Line {line_num}: Invalid format - {stripped_line}", file=sys.stderr)
> > +            continue
> 
> Should we fail here instead of continuing? If the operation is check, the check should not pass. If the operation is add, we probably don't want to simply remove everything we couldn't parse.
> 
> > +
> > +        # Check for more than two email addresses
> > +        if stripped_line.count("<") > 2:
> > +            print(f"Line {line_num}: Too many email addresses - {stripped_line}", file=sys.stderr)
> 
> If this is invalid should we perhaps modify regex to disallow it in MailmapEntry.parse so that it affects new records as well?
> 
> > +
> > +        entries.append(entry)
> > +    return entries
> > +
> > +
> > +def write_entries_to_file(mailmap_path: Path, entries: List[MailmapEntry]):
> > +    """Write entries to mailmap file."""
> > +    try:
> > +        with open(mailmap_path, "w", encoding="utf-8") as f:
> > +            for entry in entries:
> > +                f.write(str(entry) + "\n")
> > +    except IOError as e:
> > +        print(f"Error writing {mailmap_path}: {e}", file=sys.stderr)
> > +        sys.exit(1)
> > +
> > +
> > +def check_mailmap(mailmap_path, _):
> > +    """Check that mailmap entries are correctly sorted and formatted."""
> 
> As noted above, it will not fail if some entries are incorrectly formatted.
> 
> Also, we could probably check for duplicates.
> 
> > +    entries = read_and_parse_mailmap(mailmap_path)
> > +
> > +    errors = 0
> > +    for i in range(1, len(entries)):
> > +        if entries[i].name_for_sorting < entries[i - 1].name_for_sorting:
> 
> nit: could use `for entry1, entry2 in itertools.pairwise(entries):`
> 
> > +            print(
> > +                f"Line {entries[i].line_number}: Entry '{entries[i].name}' is incorrectly sorted",
> > +                file=sys.stderr,
> > +            )
> > +            errors += 1
> > +
> > +    if errors:
> > +        sys.exit(1)
> > +
> > +
> > +def sort_mailmap(mailmap_path, _):
> > +    """Sort the mailmap entries alphabetically by name."""
> 
> Should we warn user somewhere that all comments are going to be deleted?
> Should we allow comments at all if this is what we do?
> 
> > +    entries = read_and_parse_mailmap(mailmap_path)
> > +
> > +    entries.sort(key=lambda x: x.name_for_sorting)
> > +    write_entries_to_file(mailmap_path, entries)
> > +
> > +
> > +def add_entry(mailmap_path, args):
> > +    """Add a new entry to the mailmap file in the correct alphabetical position."""
> > +    if not args.entry:
> 
> nit: it is possible to make argparse check it using subparsers or groups.
> 
> > +        print("Error: 'add' operation requires an entry argument", file=sys.stderr)
> > +        sys.exit(1)
> > +
> > +    new_entry = MailmapEntry.parse(args.entry, 0)
> > +    if new_entry is None:
> 
> nit: it is possible to make argparse convert argument to MailmapEntry and report error to the user in a standard way if it fails, but it will require some redesign of MailmapEntry so maybe not worth it.
> 
> > +        print(f"Error: Invalid entry format: {args.entry}", file=sys.stderr)
> > +        sys.exit(1)
> > +
> > +    entries = read_and_parse_mailmap(mailmap_path)
> > +
> > +    # Check if entry already exists, checking email2 only if it's specified
> > +    if (
> > +        not new_entry.email2
> > +        and any(e.name == new_entry.name and e.email1 == new_entry.email1 for e in entries)
> > +    ) or any(
> 
> This will usually trigger even when `not new_entry.email2`. 
> 
> > +        e.name == new_entry.name and e.email1 == new_entry.email1 and e.email2 == new_entry.email2
> > +        for e in entries
> > +    ):
> > +        print(
> > +            f"Warning: Duplicate entry for '{new_entry.name} <{new_entry.email1}>' already exists",
> 
> Probably not a "Warning" if we exit with error code right after.
> 
> Also the error message is slightly misleading when the second any returns true. I'd split this into two independent checks each with own error message, and select between them depending on the presence of new_entry.email2.
> 
> > +            file=sys.stderr,
> > +        )
> > +        sys.exit(1)
> > +
> > +    entries.append(new_entry)
> > +    entries.sort(key=lambda x: x.name_for_sorting)
> > +    write_entries_to_file(mailmap_path, entries)
> > +
> > +
> > +def main():
> > +    """Main function."""
> > +    parser = argparse.ArgumentParser(
> > +        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
> > +    )
> > +    parser.add_argument("operation", choices=["check", "add", "sort"], help="Operation to perform")
> 
> Can we build choices from keys of operations dict?
> 
> > +    parser.add_argument("--mailmap", help="Path to .mailmap file (default: search up tree)")
> > +    parser.add_argument("entry", nargs="?", help='Entry to add. Format: "Name <email@domain.com>"')
> 
> Secondary email is not mentioned. Actually, if I want to add a secondary email when I already have primary, what do I do?
> 
> > +
> > +    args = parser.parse_args()
> > +
> > +    if args.mailmap:
> > +        mailmap_path = Path(args.mailmap)
> > +    else:
> > +        # Find mailmap file
> > +        mailmap_path = Path(".").resolve()
> > +        while not (mailmap_path / ".mailmap").exists():
> > +            if mailmap_path == mailmap_path.parent:
> > +                print("Error: No .mailmap file found", file=sys.stderr)
> > +                sys.exit(1)
> > +            mailmap_path = mailmap_path.parent
> > +        mailmap_path = mailmap_path / ".mailmap"
> > +
> > +    # Handle operations
> > +    operations = {"add": add_entry, "check": check_mailmap, "sort": sort_mailmap}
> > +    operations[args.operation](mailmap_path, args)
> > +
> > +
> > +if __name__ == "__main__":
> > +    main()
> > --
> > 2.48.1
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F295CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 13:35:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F053340DD8;
	Fri, 17 Oct 2025 15:35:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B894B40DD8
 for <dev@dpdk.org>; Fri, 17 Oct 2025 15:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760708117; x=1792244117;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yvjueUdKjiq3whzCpbXEC1A0BXTzuCFkBoGiTcsWnV0=;
 b=An/dTq+X6Zh9Lr0u33UGYkbeMbqr3Sn73AZo3PfV1C//RECnblh3ZM2z
 3jTBrpZn+KnY5kWoXs/vX+/3KfLGJPI0vGgTquNctj33n28ffTEyzJ6w0
 WsV91NcrhiDZdb2Zqj/Dkb8OC0+LBud5+LDmXm6TUkEIcBwq8BDPGcqqf
 meZnwUDXdJPRdo8/5Ft3G6Zdn2y0y1lpOvD7jX1xDSQ7a6qpbVbDU9NCZ
 w/YKB/dZmhWFgCZ9mbZnu0lMW2m/Xd+tlGqvC8h6z8NQl+mGxW0WO24gz
 CFGBqzqMwXSk1Ck3smSbDonKOjPs8wp7ZHL8KOpnp1as/Hy9uNwNgKZKl Q==;
X-CSE-ConnectionGUID: a5Tcg8OWQ02d7/6h7wjhGw==
X-CSE-MsgGUID: CVCiVnZfTlypcgndvdHTGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="65532202"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="65532202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 06:35:16 -0700
X-CSE-ConnectionGUID: BxXKG42TRhKHJPuMgqQFRA==
X-CSE-MsgGUID: A2TWcvOBTNCpeJ5NPw444g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="182736687"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 06:35:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 06:35:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 06:35:15 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 06:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXSO4jwzKIGSdNZGa1X7tI9iRM3gPywAimci0kckbsGRScmdvUHOdB+LBYy61tvVJwYD9H/+qiEbdG4jJbK0eMZrcoNYlLRzXPYEPhfIL+XFJdMgGIZCqfhHPpE2qM6ZpLFJ/j5QHJkI2HubGns8KnskvUWg7ZRpDddWPZn4mFgqT4/HwTiojo6JphQhcoVLk6gDOJ8XHxT8mNQiyprPKXlwoM2OxO02Nw8AMSmdw4oseB7CbD6whFRKqL1toO2J5Eg3cht5tsARqkeuePNG9IadG16bIycHAJuYOtXx2D7+343eKHpAeMFav/mvig0kXIsBGSLI9s+RK1/3O0jQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LwBzHq714gA8R5d1M8NYLO/kkHZDixKeg5VV08ov3Y=;
 b=mt/Mi0a7O11SFjKUxVW6ULVK0gTng3IG0qzOJeAw9YH7zsG4YHWNGSCRVKy37vACStRuGlUlMJZ+S69QMbKwpiSJmTzokXXrJsKIZxPFoWGhyTvzGFD/taEhHoWqiAFDtxjUmWgHuWLkgY+E/HUNqajfCReuTr6moqHCV+58qF+B2pMn2UyR/keJaG7Xi9nZLMwt8NeuJcKqpVkjMIfpzsIQG/2XwLIAu+MMNQFXcNt3336X/OJJ3/MwVoYZAZnWEZeq05Je5/6Uhaf10n+MGFVg7V8k+VyDpgXK2O20F4lr8VkLszIRxX7YSgoSEmNwErjG3DNRZkl6l8dgjbw3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 13:35:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 13:35:12 +0000
Date: Fri, 17 Oct 2025 14:35:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, <marat.khalili@huawei.com>
Subject: Re: [PATCH v2 1/2] devtools/mailmap_ctl: script to work with mailmap
Message-ID: <aPJGCjDJ5Gu3UQkg@bricha3-mobl1.ger.corp.intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808210837.518507-1-bruce.richardson@intel.com>
 <20250808210837.518507-2-bruce.richardson@intel.com>
 <DDIYNM2UVM02.I4Z8DDUEEU68@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DDIYNM2UVM02.I4Z8DDUEEU68@redhat.com>
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c12fa9-a9aa-4bfc-dc10-08de0d81fefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TWIzR8WtH0Ten/lUBTHQeTTJGIFO2n0e+f587Hw25LuyhlMp+486XgySqGYh?=
 =?us-ascii?Q?GwCyvEaGgxvjKmrvw2LIPfupvDPZHsRBwELcaRd+UdElMMrSxORnuwZ+mvXh?=
 =?us-ascii?Q?ZafG9J2QPY7DfmiXukt9LS7E4SBAsY4Ixd/OnyG/j/V1w5dULEjA3cYVel6z?=
 =?us-ascii?Q?RoXfEuLvw8QcOgQHcYfLyTIeqqG8Qw9idH79LHGP8FMlEaS/VtxBmdnuPINo?=
 =?us-ascii?Q?dGRTUjvyaAbMIcL2NrN/3nAKh8iNwMjVaNU+JdcsdkATKk8WGRW5zNQ44q5s?=
 =?us-ascii?Q?TsiJ20eJsO+8B5BMxSNiQzNd0lm83BvvW33Yh2taCDGGl70WeGa1dbz8To0y?=
 =?us-ascii?Q?r6+he2NykE2t8wt4G75i06B3tf48upNZgB4YKlaTg77sSFEmT/nOozeG1x97?=
 =?us-ascii?Q?gc9WjPgTjh2FDICdQRkQOhbmHNmg6WVdq9/lL7W8jUccuEI9SBvB2/KyJbRT?=
 =?us-ascii?Q?JDX8+yurLuLcRRm9z/K27qv5w7j9A/j5smgFODYGXZ5qv6zndNRWH0N7DUDA?=
 =?us-ascii?Q?oEx7bxS9UJ7/ND/Q9srrdItN6hDV37DfWEb2IPVj5ikokRPlrt2ox4Gufgdf?=
 =?us-ascii?Q?t68OXxmigtHeT0RtNyHI2PF0F2VvALWKmBikzKK1CPVMwlscJgroPi00eVyU?=
 =?us-ascii?Q?HkCl76L86t4s60WOWvWRtGHT27K3+MV/URXYk3Yr+Ma+Umm/AJXKrZ1bqP/L?=
 =?us-ascii?Q?ZBm6TPl9ohCGj9fnfqnEEu5v6VNX2NHCNX3NvGdu+z3a+ZhLwxuZe6aBJIEL?=
 =?us-ascii?Q?fRcoknorVMkBGIUq/MvsA5QEfBdSJkDSBOisYU8tBPQBuHme6oYiMeZScD1n?=
 =?us-ascii?Q?pw/7WauOWqgpKKaFBjxAwDP1ZahjYrWL6IftA7pyBBwaqtbk7gIvZEZlaml9?=
 =?us-ascii?Q?fVWBFs5HIinLFglEtYpXlsAxgAyzc7dFReq0HYOQJrt2qfPXgLM1i18dErRZ?=
 =?us-ascii?Q?64EZqXVJN4yK5Vb/Heg5kdhq95I8szporR7vMf3QlP8TX4ixnC98J5Xdt4s1?=
 =?us-ascii?Q?5lBu3wDpQIfigTJdVoRMesQhUBxxO2h+Jg1bdhV5saAA+mmSLSlahcomvhcw?=
 =?us-ascii?Q?AgHHGaSKfZQz+HlPFlcxMpiQyuQJfg6ziXkQGFDnLZw6u/hCGbI4hXe/b7nm?=
 =?us-ascii?Q?D4on1cSrd0Q7KIVNtBzlQKjik0LSvmWmU74XKjEsybEhdDpphHR/RwKZDu1C?=
 =?us-ascii?Q?uIcCWCvAL0sTuqqGIlDmBa6nWttSJkIjLrYEfZ/WpqdPAlcKongLvwvoQKFN?=
 =?us-ascii?Q?jtLd2XvyPvXJ1W98h4EGCkSwbfVkORNV1Rm3/BUtE+BRyham+ZRoGkHE5vEe?=
 =?us-ascii?Q?kjGRybr7rgeJX0xpFhkfQqMClhytW/fQ6DypiBGLndaHIv4dKl3rSzXKkCUb?=
 =?us-ascii?Q?Wc/jC8c57huKWU5j/O3J5AbQDec4r13jwPFyvrTrUKc64Vlmq/cH3R+a3eAU?=
 =?us-ascii?Q?QuWR8kJfw7+QzSFFRSR0NCgofTo2hudH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TqXTFG7VDdLd1j5fF3Dgx6agAfb10du/n4G+Xd/Kej2FCYzAaiK4l38yImHt?=
 =?us-ascii?Q?gP4zgYpAT0UUw4O5g1gCey+8luppkQ1P8DFSVCX42owXr1UgL++IzajKq5fL?=
 =?us-ascii?Q?IQ+bHFKXqrfKHZe/P2/OTMjfbmkJeQVqGqljBIh3+f6yL89fmckGbp5UzAnU?=
 =?us-ascii?Q?mp3d36L4qwPqBQQsR4FwNrVPP2XfJpPy3GWF4wG7Fuw6JEkbXn4ALzyJNL8+?=
 =?us-ascii?Q?Z7US7oOLmc7DUoICYaPQBtDgwLDj9P3eLxpPXiQjecgs9RJcSWlgamUZtN8m?=
 =?us-ascii?Q?AeBVA2Bt26chxO5utZuayKm1DUEKkzqGHUO8KWkgOx2u8BBHfFBK36XLZz4S?=
 =?us-ascii?Q?GkrvXSw3Xv8FNRLjueg9KNi+hh8v11b17OC/PrH7lF9av7vRDC2lp5+FT/g2?=
 =?us-ascii?Q?03JVkvKUZKVfPrMziO84FAXFHENHAU7CMH5/VM0brVXf/B0/n61F7rEd47+0?=
 =?us-ascii?Q?uCCwZgDeb3Um0V1a8XznBEP+WgprcA+ub/PdB1A5+Ee8dzEKrvpuC0DrMl0d?=
 =?us-ascii?Q?GPOv5LiUMv3j7L4QYi2UTt0Y7itSHlFDYXOsywn+b+xFlyB8jXSybOyIZCfl?=
 =?us-ascii?Q?696Da7x++5r6SV5N0QNNe84O3gTm8c1vrf2qzYF4XM4x344BJrQiF6ICJ1rp?=
 =?us-ascii?Q?hUZywroJFR8ohWPOFcRjLpOInzFFmmP8Rmv6W5uTWm+ufTGa0fGSUsVwlXNh?=
 =?us-ascii?Q?/D0kBr4IjBpHobqUxwzvuGglE67yQIu7lt1kBaAr2eEwSaqywF9KiujNtghy?=
 =?us-ascii?Q?+R3jwKOFf/AJrfAQGhNmuEu9ZeeHB7cnIx/PW6fzMsFbNQCI+RNOVQNpf0n4?=
 =?us-ascii?Q?YgiIVC2de976eYI/+Z/W0R3agpzRbcAfD7pRC3cLbpD+fMmd+Up8nvJS10CH?=
 =?us-ascii?Q?PyNIi7JHQ3inn/NirtHX+7ycz6A0Io3QUk/2FV0WmJU2lE6XTZhS4bzNl83k?=
 =?us-ascii?Q?pM594uHS6TB/6WzaN8dimdLUFnLXW89htWjKaj2uLy3qT0WQk0Kqv4CF/2jW?=
 =?us-ascii?Q?mYHO7f/c4BfN03pGffLH/EosUsmJXkR39IUla8shrNvPSHHlWPP71a04vJgQ?=
 =?us-ascii?Q?A7JnyFGQ212oilml2//L9xBKCJmxRZEC20hS9N0hxNVEafn0t9LwXa83HYRj?=
 =?us-ascii?Q?duc51licW1jUzjLQgjqF3Ycs2yPDynwW6n04HPFXbtOdWClXeM9rA21qejZD?=
 =?us-ascii?Q?is6EuGgin5kYkj/0cGCJk8MVbmYlqXvlPOerjvlYG4zdRIdwrx0AlAa8FXIW?=
 =?us-ascii?Q?Oy/e8Ng2jKZaqfxBXXn/fzbeX7NeHQgwh5shV/xJuqunv7pCdFoX8QFWtAcr?=
 =?us-ascii?Q?CoLb13tuP8acoAWi0qoe2oulUsSxDel/wlQHOu/CCGCuP1hU+rd+gQnzok8T?=
 =?us-ascii?Q?EkCrZz+um6Wa57LWTBUQ+Ig5M6CNiDgAz1R9YKyCeAAVxLO43Ypl73bWwHz9?=
 =?us-ascii?Q?gDCBiR77yEmsynMogP7MHr3JXhzFNdD99NQQnklNg07WJBH/tYt3V1/CQNwa?=
 =?us-ascii?Q?lFdD3onqgKd198KBedbOJldGZzAjq4z9KAlQBh2mBlMnnyKbBzNEZEHtaC1T?=
 =?us-ascii?Q?egb4whaFitdbYA42HC/2tqnVP7hfOL+utExNq8NCUWkA2XyhD+xhPz6iIDUn?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c12fa9-a9aa-4bfc-dc10-08de0d81fefe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:35:11.7911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UBqZfXRcPw4yLqif3pQhg4vk75D7bK5HkV5U27DljkZJH69KuzaVAjB+1cyUy/9KicFTfsbFcw+ySgPECCsld4bAYfQSvbuF1zpCcHqYhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
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

On Wed, Oct 15, 2025 at 04:20:57PM +0200, Robin Jarry wrote:
> Hi Bruce, see my comments inline.
> 

Thanks for review. Taking nearly all feedback in v3. See inline below.

/Bruce

> Bruce Richardson, Aug 08, 2025 at 23:08:
> > Add a script to easily add entries to, check and sort the mailmap file.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  devtools/mailmap_ctl.py | 212 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 212 insertions(+)
> >  create mode 100755 devtools/mailmap_ctl.py
> >
> > diff --git a/devtools/mailmap_ctl.py b/devtools/mailmap_ctl.py
> > new file mode 100755
> > index 0000000000..15548c54cd
> > --- /dev/null
> > +++ b/devtools/mailmap_ctl.py
> > @@ -0,0 +1,212 @@
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
> 
> You can remove the second paragraph and the bullet points. See at the
> end.
> 

Ack, will remove in v3

> > +"""
> > +
> > +import sys
> > +import re
> > +import argparse
> > +import itertools
> > +import unicodedata
> > +from pathlib import Path
> > +from dataclasses import dataclass
> > +from typing import List, Optional
> 
> That's a matter of preference, but for such a small script I prefer to
> only import top level modules, e.g.:
> 

Given the script is short, I prefer the opposite - the amount of context is
so small there is no need to keep the namespace along with the functions
like Path, or dataclass.

> import pathlib
> import dataclasses
> 
> By the way, since python 3.10, you can use the builtin symbols instead
> of importing typing symbols. See below for more details.
> 

Ack. Not sure what our min python is, but this is not a regular user tool,
so requiring 3.10 should be fine for any devs or maintainers.

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
> 
> Replace with python 3.10 syntax:
> 
> 	email2: str | None
> 

Will fix in v3

> > +    line_number: int
> > +
> > +    def __str__(self) -> str:
> > +        """Format the entry back to mailmap string format."""
> > +        return f"{self.name} <{self.email1}>" + (f" <{self.email2}>" if self.email2 else "")
> > +
> > +    @staticmethod
> > +    def _get_name_for_sorting(name) -> str:
> > +        """Normalize a name for sorting purposes."""
> > +        # Remove accents/diacritics. Separate accented chars into two - so accent is separate,
> > +        # then remove the accent.
> > +        normalized = unicodedata.normalize("NFD", name)
> > +        normalized = "".join(c for c in normalized if unicodedata.category(c) != "Mn")
> > +
> > +        return normalized.lower()
> > +
> > +    @classmethod
> > +    def parse(cls, line: str, line_number: int = 0):
> > +        """
> > +        Parse a mailmap line and create a MailmapEntry instance.
> > +
> > +        Valid formats:
> > +        - Name <email>
> > +        - Name <primary_email> <secondary_email>
> > +        """
> > +        # Pattern to match mailmap entries
> > +        # Group 1: Name, Group 2: first email, Group 3: optional second email
> > +        pattern = r"^([^<]+?)\s*<([^>]+)>(?:\s*<([^>]+)>)?$"
> > +        match = re.match(pattern, line.strip())
> > +        if not match:
> > +            raise argparse.ArgumentTypeError(f"Invalid entry format: '{line}'")
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
> > +def read_and_parse_mailmap(mailmap_path: Path, fail_on_err: bool) -> List[MailmapEntry]:
> 
> Replace with python 3.9 builtin list and use pathlib module directly:
> 
> def read_and_parse_mailmap(mailmap_path: pathlib.Path, fail_on_err: bool) -> list[MailmapEntry]:
> 

Ack for using builtin lists. Keep un-namespaced Path.

> > +    """Read and parse a mailmap file, returning entries."""
> > +    try:
> > +        with open(mailmap_path, "r", encoding="utf-8") as f:
> > +            lines = f.readlines()
> > +    except IOError as e:
> > +        print(f"Error reading {mailmap_path}: {e}", file=sys.stderr)
> > +        sys.exit(1)
> > +
> > +    entries = []
> > +    for line_num, line in enumerate(lines, 1):
> > +        stripped_line = line.strip()
> > +
> > +        # Skip empty lines and comments
> > +        if not stripped_line or stripped_line.startswith("#"):
> > +            continue
> > +
> > +        try:
> > +            entry = MailmapEntry.parse(stripped_line, line_num)
> > +        except argparse.ArgumentTypeError as e:
> > +            print(f"Line {line_num}: {e}", file=sys.stderr)
> > +            if fail_on_err:
> > +                sys.exit(1)
> > +            continue
> > +
> > +        entries.append(entry)
> > +    return entries
> > +
> > +
> > +def write_entries_to_file(mailmap_path: Path, entries: List[MailmapEntry]):
> 
> Same:
> 
> def write_entries_to_file(mailmap_path: pathlib.Path, entries: list[MailmapEntry]):
> 
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
> > +    entries = read_and_parse_mailmap(mailmap_path, False)
> > +
> > +    errors = 0
> > +    for e1, e2 in itertools.pairwise(entries):
> > +        if e1.name_for_sorting > e2.name_for_sorting:
> > +            print(
> > +                f"Line {e2.line_number}: '{e2.name}' should come before '{e1.name}'",
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
> > +    entries = read_and_parse_mailmap(mailmap_path, True)
> > +
> > +    entries.sort(key=lambda x: x.name_for_sorting)
> > +    write_entries_to_file(mailmap_path, entries)
> > +
> > +
> > +def add_entry(mailmap_path, args):
> > +    """Add a new entry to the mailmap file in the correct alphabetical position."""
> > +    if not args.entry:
> > +        print("Error: 'add' operation requires an entry argument", file=sys.stderr)
> > +        sys.exit(1)
> > +
> > +    new_entry = args.entry
> > +    entries = read_and_parse_mailmap(mailmap_path, True)
> > +
> > +    # Check if entry already exists, checking email2 only if it's specified
> > +    if (
> > +        not new_entry.email2
> > +        and any(e.name == new_entry.name and e.email1 == new_entry.email1 for e in entries)
> > +    ) or any(
> > +        e.name == new_entry.name and e.email1 == new_entry.email1 and e.email2 == new_entry.email2
> > +        for e in entries
> > +    ):
> > +        print(
> > +            f"Error: Duplicate entry - '{new_entry.name} <{new_entry.email1}>' already exists",
> > +            file=sys.stderr,
> > +        )
> > +        sys.exit(1)
> > +
> > +    for n, entry in enumerate(entries):
> > +        if entry.name_for_sorting > new_entry.name_for_sorting:
> > +            entries.insert(n, new_entry)
> > +            break
> > +    else:
> > +        entries.append(new_entry)
> > +    write_entries_to_file(mailmap_path, entries)
> > +
> > +
> > +def main():
> > +    """Main function."""
> > +    # ops and functions implementing them
> > +    operations = {"add": add_entry, "check": check_mailmap, "sort": sort_mailmap}
> > +
> > +    parser = argparse.ArgumentParser(
> > +        description=__doc__,
> > +        formatter_class=argparse.RawDescriptionHelpFormatter,
> > +        epilog="NOTE:\n for operations which write .mailmap, any comments or blank lines in the file will be removed",
> > +    )
> > +    parser.add_argument("operation", choices=operations.keys(), help="Operation to perform")
> > +    parser.add_argument("--mailmap", help="Path to .mailmap file (default: search up tree)")
> > +    parser.add_argument(
> > +        "entry",
> > +        nargs="?",
> > +        type=MailmapEntry.parse,
> > +        help='Entry to add. Format: "Name <email@domain.com>"',
> > +    )
> 
> Here you can use sub parsers instead:
> 
> 	parser = argparse.ArgumentParser(
> 		description=__doc__,
> 		epilog="NOTE: for operations which write .mailmap, any comments or blank lines in the file will be removed",
> 	)
> 	parser.add_argument("--mailmap", help="Path to .mailmap file (default: search up tree)")
> 	sub = parser.add_subparsers(title="sub-command help", metavar="SUB_COMMAND")
> 	sub.required = True
> 	add = sub.add_parser("add", description=add_entry.__doc__, help=add_entry.__doc__)
> 	add.add_argument(
> 		"entry",
> 		type=MailmapEntry.parse,
> 		help='Entry to add. Format: "Name <email@domain.com>"',
> 	)
> 	add.set_defaults(callback=add_entry)
> 	check = sub.add_parser("check", description=check_mailmap.__doc__, help=check_mailmap.__doc__)
> 	check.set_defaults(callback=check_mailmap)
> 	sort = sub.add_parser("sort", description=sort_mailmap.__doc__, help=sort_mailmap.__doc__)
> 	sort.set_defaults(callback=sort_mailmap)
> 

Very neat thanks. Adding to v3.

> > +
> > +    args = parser.parse_args()
> > +
> > +    if args.mailmap:
> > +        mailmap_path = Path(args.mailmap)
> 
> 	args.mailmap = pathlib.Path(args.mailmap)
> 
> > +    else:
> > +        # Find mailmap file
> > +        mailmap_path = Path(".").resolve()
> > +        while not (mailmap_path / ".mailmap").exists():
> > +            if mailmap_path == mailmap_path.parent:
> > +                print("Error: No .mailmap file found", file=sys.stderr)
> > +                sys.exit(1)
> > +            mailmap_path = mailmap_path.parent
> > +        mailmap_path = mailmap_path / ".mailmap"
> 
> 	args.mailmap = mailmap_path / ".mailmap"
> > +
> > +    # call appropriate operation
> > +    operations[args.operation](mailmap_path, args)
> 
> And there (you'll need to adjust all callbacks to take a single args
> parameter):
> 
> 	args.callback(args)
> 

Changed in v3.

> > +
> > +
> > +if __name__ == "__main__":
> > +    main()
> 
> 
> -- 
> Robin
> 
> > Do not use or store near heat or open flame.
> 

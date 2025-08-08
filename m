Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56847C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 19:59:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 308F9402B3;
	Fri,  8 Aug 2025 21:59:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1094E40270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 21:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754683144; x=1786219144;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kdcT9K8WV7r/2d6a7w5nTFF4bdjTcMMpfets8jPpCBU=;
 b=Aa83dPoSSTDGeQJVdDfcFPOmBiXH0rQqJRXdwuvr8ZnDnLMLB+BI7dBK
 P38Dz3J8gGw3+rI4kxrJ6+ectDXlFXAFZJk0mIdYDUpX461XX7MROVI7i
 HuYOREARgZfpKJtMInsBNWq07KG0O6sGnLeFAIB8qybST0Py5C3fW9YFu
 qwBi20DkStcvnwxSZReIc5d8Ls3EuHjLX401afMy8JNXXOGSgSQKEHA2R
 yeLR/JUwXlswn3wug4EJaO0o3hDD7aihDUai+/gjkmSn+fHHilhMCSJaz
 p+t6vNliBSlwLDfqkpvBarx7BjGrTaYcYWO9uz2GxO9E2szV8p1EU2i8C Q==;
X-CSE-ConnectionGUID: d13bjqigT1u7aSb1hUZqRg==
X-CSE-MsgGUID: S72KQ1YQQGGCp34eyySxaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56937456"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="56937456"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 12:59:02 -0700
X-CSE-ConnectionGUID: s9uiPw8mSkaDY+4+lruujg==
X-CSE-MsgGUID: FyyzVIofT/yabeotzxChOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="169525825"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 12:59:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 12:59:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 12:59:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.78) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 12:59:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPxjNlnHrHCfAMRE4VDW0GALbaUVElZaA46njsg27Qb/Q/TIGr9VeeWE2vQ4zxA/8uCmIhRIHw+yxW/sSkSR/VqSf009QGLTYAZqJEVf5/okYyUmuxa3Ffmd0h2UUe4lE9ycxMA0rY7R9lC+vMaydQLGjmW8pNV2Sr34XH9pL4H0d2J60KvSCo5LetXwCiF6ercvew9lmQtiqGsAxhXzIklMvMkgmvpLCrz7iw222yeXS1QypXbbH97qi1LKWpE2b/Ivc5FadkbeDYOPllP3GAao8NiZgI4QUEtfKLqHWiM+h+osyyDegbIS7+xJ9ekmcNGekGD770mZIZ6/LxpbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGXXjAD2R3vauLJb1y4n0l7rrqAS7+oqq+srMz7d7GQ=;
 b=xYvZLBsz6FkY5pDD3DIKnwrI/4/7WfOs+kRGzRFb7rUyqUuyMgIxb+3GcQlqRjwxY1poNfLfUGID9y9HpZjmSSlVG2G1ajy+vUnUnT2TdGcJnBKDSYnT8Dflp07nawLV3KtDOUA5a3BKdmzhvpLq+Q2yG1BEpr8N8kcbhuxW7VA96JnItr1BXtymIorozaXFJbcyUjWXkyfa8ctNyD+Aetcr4QIwbzxhvFKhzICe5h6x0iaCN3StoiE28Nxg94S4YSter1a+qSIk2j+uAHoIIALDWgqC3AFmIFJmcUjDF+mIdRhEfCJvjJhh6d7zOYQxUhqE3kuNJ2g2yxxn1vRRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Fri, 8 Aug
 2025 19:59:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 19:59:00 +0000
Date: Fri, 8 Aug 2025 20:58:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
Message-ID: <aJZW_0ZJJ34q3LFs@bricha3-mobl1.ger.corp.intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808142721.408998-2-bruce.richardson@intel.com>
 <2b31ddbcc8174ff89b5c4a063e55003c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b31ddbcc8174ff89b5c4a063e55003c@huawei.com>
X-ClientProxiedBy: DB8PR04CA0002.eurprd04.prod.outlook.com
 (2603:10a6:10:110::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d60355-d530-47b1-a460-08ddd6b60424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DJgxvKvhBQTAiRXXPVY2kFSfVw7ep4+MfTR2zx1Jhmrwy3aqIzI+tK6CTgwc?=
 =?us-ascii?Q?uP/5TjHwO11WLPpm1NjzzAv2v+kwuB0N+NJbcq3L+YhZvIZYrRmFFuA81eVq?=
 =?us-ascii?Q?BoYoPSAPJYFqc07HSY21OKtL2MGNkdSQleTMGzmh/X5uJtS5IpBwJxWn1Q5a?=
 =?us-ascii?Q?KsscC30K8ISvYqvNjzPMrTyaslFuiKZK1sBK//VB5w/DhhwbWwkg6z3CpeaZ?=
 =?us-ascii?Q?f006Erx0ob/rVs2UFvnTd6bF0f3FCDD7vJZNHlA8vmUf1VkLGUlOQx1HRdCM?=
 =?us-ascii?Q?emsOmPTVhR0jLfj3ZUsV2mAmgJ/3/VviKg9E0yE0VSYzvx9xdUsq2R8otjC5?=
 =?us-ascii?Q?wgQqHhnA0u6ytfd2BHe/m/lMXiXxR1hRxR3qtQMAlkYmdMRA5yE8ws2x/JjN?=
 =?us-ascii?Q?KkoOmbL5Mm2nqa5RmmMRuymr5zh9/tS/8bzmPoRdUbsaigLmLrG6b+OqdW+j?=
 =?us-ascii?Q?UAc1TKx5PubpKCdwJCbcPzBLkUPDAh2fn+8t7pIq3jZzdlffAYq61KogWKBV?=
 =?us-ascii?Q?SAnL+xsBySLzWmNKkxAjtEcUPgv5uKD0MsezdiXYLWA4WfxezQ8YHP/to0OX?=
 =?us-ascii?Q?9PNc2ZtD+exQJxaL22oU6Ge0TXDIB0eUvQTmMlrZm9OsGH5xfTFk7uitdWKy?=
 =?us-ascii?Q?qq99xMCJQKplwJyo5JJnRBZ7hPz4dPpuTfqFltYqflBx+65y4bXbrAsLREyq?=
 =?us-ascii?Q?m9OMYmBSaDwDisLCftKUmP5Q+xYL77QBpkxd0m/1CZWy4AtUA3r0g14Zqf21?=
 =?us-ascii?Q?NSJjpDFnV1GOJKuMdAB4OVnQ1BTr+I6ioQbrZI4f1dUx085Ik6W9C5+lYC1F?=
 =?us-ascii?Q?ON+fF3d6uldPnJRPc7kQaHizu3wdsv3jEDH156UOrrOI+Buv67vpSRYbFb+5?=
 =?us-ascii?Q?tPpo3h6YsUFYIUpWu9bNx4ZXN0EFsiTmBvpB26+BMY+DSIPmzcIExhauP4Ep?=
 =?us-ascii?Q?4NUu9heKOVVaWbsRzlaL+SEWnQuEBSE5d6r3qN+QPiWfjvA12qkZuWz1+nL8?=
 =?us-ascii?Q?vgH5XY9z0ZflQghUP2Jn631awixLxXq++tf4yPeJ7Z9ffEigvUYb3XX9y4SJ?=
 =?us-ascii?Q?PmHtBK6KQKWN5r1erQGqUQoPLHV8hHICSvp/1kxXz4NoTnBif2dXSLLSTMSO?=
 =?us-ascii?Q?pXM3FXdqhTMRuvKtAI1JIvp1VfEexYBn8mOam6buH28tqLJYqVSE5dcgaZGg?=
 =?us-ascii?Q?+axHGySiyYnV+c2348BJhGuS4uoYiy4rQ5UuTHXdGF5Q93DBLSalw+t3XqWb?=
 =?us-ascii?Q?CLDM/Fv5JMEYHcFz5UrrfEzAZtnjHdwXw3KHtH0+I/ao9nYC4W03vZ9oWnzK?=
 =?us-ascii?Q?+lypnGazXcwFVdaMSEOBXWZN5ngqjLNT2cFv4Ks6P2aUk3RGtoWEvABj3uSE?=
 =?us-ascii?Q?J2j5b30c5tk6ms3C+tkasBWq17ZX2bGtusPmUnBJRPTXjXsMJ/pO2r1qBlV1?=
 =?us-ascii?Q?Xg/cUKpjP+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DOFLHaLYm71ogOKmSDI4sTJ3JaS6u4GfK6UnYBqwM5+9gCuhqKPRQv24X0GO?=
 =?us-ascii?Q?IF/Yzojnieomxxshsx6KgEItm9QoU6132kCigj9C+4omV46N1QjTy78fDOc6?=
 =?us-ascii?Q?4sNjW+PJjBdd0y9Q/p9RDhriWPoeuYUYIPJn0xmTBSNxAIHN5AillxB9xQxf?=
 =?us-ascii?Q?az3nzRuPEH4Nc5nIZ3YbICmXY78F/bc4W8TeP+58Y5mFPhSj1eP95J35w+eV?=
 =?us-ascii?Q?LfScd1Y8+c4l/WWIqvCOkgFsz6u7ueZnVL/YriaCIQyMjNERRgSCU4bexxXG?=
 =?us-ascii?Q?xZpGI03f+g8u4R2QMENDhcJ2PNAiWaWMu1l6zqtcceKpAiJczfsGSF/Bd6D7?=
 =?us-ascii?Q?bk+Ql8y3uWbsybUw2Ii0hj6Yj4ObXwKk9IuwOmR0QQ84GL0pyLiUP2KzBlz2?=
 =?us-ascii?Q?fF6n+Tb4ZwanrpZHUQMeXFgYx9tmGl1mi6y4CSB2t9F0fteS9IFB/KUJze3q?=
 =?us-ascii?Q?vZ7DL8TyMprPXenl2356YhhvZwkyURN7A6DZw2udHsG0Gi8DfG7Y0F69vivz?=
 =?us-ascii?Q?waZ/vMnbdB4R7SKkKNnmt80zcx2mU8KnO36exscD7BZ+5OXE4zElWJfrT4Ao?=
 =?us-ascii?Q?d9GywpA56Ua35ZAt5Ud3gb8b8Qw5THToDs9qE3L21Y8qhnb/CTxHSNNCvHRL?=
 =?us-ascii?Q?AdF5xDRxllXjBpCNddc8vDPBy7MIDdyqHa16tu2VVDhyuj33ACcftehU4h4r?=
 =?us-ascii?Q?C+9fobtZ77rdkVEi9HtGRR+HQu4sVymz3lf3vZ00dF91+fqyFPr5q0MKLSaO?=
 =?us-ascii?Q?rwfpzOCjQeftLtuhiw3UYQ48xFt+j8ZJYl9d+sbyqs9OUOXrrAXLmo+vzOCx?=
 =?us-ascii?Q?MBrNLvKEwLArK+QlVwauaNx4r/ImlsEeVgm5sS38i+GQCL1a0y2emv0bkN4X?=
 =?us-ascii?Q?hvvIsnrAKhgfLmDyOw5wAXQ94BvpY4r8L5zysjSW/Ah19cF7SYZ+pyYyxix3?=
 =?us-ascii?Q?MCUwzR4Bn/b6O+baxwwho/WT3RDFSMZQKfQMXoLA0Y+3VPNf/W/GCPfbVsxx?=
 =?us-ascii?Q?x3v503Uznu8CXoZPC5PnUGsvU4WFKTT0p3GgfFjE4gVXMjj+E5uN4LfBOvHr?=
 =?us-ascii?Q?PNFXnwmlkbW2rQLyfgTO/U7EDdofl+W7xOYkg8hjYvTp9pB0dwmYSfpdnQOA?=
 =?us-ascii?Q?IPKdqJ9hD36bEd5sRS0EadUOvcCFD/lK/bs1m6UfkCHrdOVFqVLFocEA7+V+?=
 =?us-ascii?Q?UK0Lvi9EaYz3syCDUGWMCnMieKGbvglEUODO46dE9ZkeDg4OS6DIcin4uoS9?=
 =?us-ascii?Q?lBEXUEgQikS1d+D6gU1Up0Mlmhs00CouLyDLJhc/GM/tUu8NA+T8wTKLYKGs?=
 =?us-ascii?Q?ukzjP+P6W6K5nBvN4qW5GHLOItQVnFGsZ9TlPZgnrpCwEC0BFppP8Yc0XOkL?=
 =?us-ascii?Q?Pf3LH0PE8muX8KqDX21wG6UAKjp1sB5zp7ASBphEK84NAK2nz2bL7HvFch1+?=
 =?us-ascii?Q?4HoHdA4rYgnxwVGNNhBDhQuNdfARs5jKKg2bCSxnp/XOBC0ys3bc1QMfRXFr?=
 =?us-ascii?Q?HQS0PRZozq4ddweqqtmPTF5W+nxwNoVDUKytDS2yS8NscRJyQSxf1OKkCv7R?=
 =?us-ascii?Q?BoXWj/saqUSE0qnveO+Qwbny9Ziy1C1pJBG2yOUPnlEY3tS1ryvvPcRRl/pN?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d60355-d530-47b1-a460-08ddd6b60424
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 19:59:00.0705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6Scj1I4xPFMmAAjkJTK4bhfyQi/D67+3ZtQxsZlMd/+4ksog1GV+pkNkEACmaMGDplDgHg07s3D8qSo9uGim3F7FaBop+oy9Rzx764fXp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
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
Ack. Will change in V2.

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
Adding a fail-on-error parameter to the function to handle the two cases.
For "check" op, we continue, for other cases we exit(1).

> > +
> > +        # Check for more than two email addresses
> > +        if stripped_line.count("<") > 2:
> > +            print(f"Line {line_num}: Too many email addresses - {stripped_line}", file=sys.stderr)
> 
> If this is invalid should we perhaps modify regex to disallow it in MailmapEntry.parse so that it affects new records as well?
> 
Good point - the regex should already enforce this, because it checks the
full entry up to end of line, and only supports an optional second address.
A quick test proves this out - attempting to add a line with 3 email
addresses we get a failure before we reach this point.

Therefore, I'll remove this check completely in V2.

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
Yes, but I will leave this for future work, as I don't believe it's a
problem we currently have with our mailmap file.

> > +    entries = read_and_parse_mailmap(mailmap_path)
> > +
> > +    errors = 0
> > +    for i in range(1, len(entries)):
> > +        if entries[i].name_for_sorting < entries[i - 1].name_for_sorting:
> 
> nit: could use `for entry1, entry2 in itertools.pairwise(entries):`
> 
Interesting. Will test this option out.

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
Again, in DPDK case, we don't have comments so this is not an issue.
However, I'll add a note to the usage details.

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

Something to investigate. May not make V2 of this patch.

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
Can you clarify this comment? Is there something I need to fix here?

> > +        e.name == new_entry.name and e.email1 == new_entry.email1 and e.email2 == new_entry.email2
> > +        for e in entries
> > +    ):
> > +        print(
> > +            f"Warning: Duplicate entry for '{new_entry.name} <{new_entry.email1}>' already exists",
> 
> Probably not a "Warning" if we exit with error code right after.
> 
Good point, I'll change it to an error.

> Also the error message is slightly misleading when the second any returns true. I'd split this into two independent checks each with own error message, and select between them depending on the presence of new_entry.email2.

Only very slightly misleading, IMHO, so I don't think it's worth adding a
different error message for the second case.

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
Yes we can. Nice design change which makes it easier to add new ops in
future.

> > +    parser.add_argument("--mailmap", help="Path to .mailmap file (default: search up tree)")
> > +    parser.add_argument("entry", nargs="?", help='Entry to add. Format: "Name <email@domain.com>"')
> 
> Secondary email is not mentioned. Actually, if I want to add a secondary email when I already have primary, what do I do?
> 
You hand-edit for now! :-)
That is something that I think we should add in future, but I'm keeping it
simple for now. [For most of the patch application that I do to my tree,
it's only adding completely new entries to mailmap, so getting that working
was my primary concern]

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

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4947CA5FB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 17:35:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1B4C40ED9;
	Tue, 20 Jan 2026 18:35:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A720E40E0C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 18:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768930556; x=1800466556;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3Nbu026ub0xL6ePcJRYG6lzbKDRJAmsQuwHekOEk33Q=;
 b=U7fV65KdDVkrxWE2Cdlxrl6vC4tnRylrTaUK+01/67LFK4+DeKCCdCmR
 Og5Rg6HpI3IGj7u42ukTWRb0aE4JDYvLoe7jQ0gIsP/H4VPHPhdnaSI4m
 6wHV4en0nCu8uJlJpyZ9ILwa9UlMLYPez0zcFSzAWKT6jQaAi7jDRn6fN
 zXWQZVbOwoYFqCJh2lIDACs/AD4Dmg4mIgXTEVxPvrI9o4T0/yD6qL4Tc
 VLIEetilEC+IZzez1c88yqsxoH0nWC8mQ89Mb4xoIKBQm09YgpXbfFhaA
 yW/c7f5uz6bWiZtgs6rgxMJ2tobQRkcMJibfBwfc8YqAUiBUjxBmwoopm w==;
X-CSE-ConnectionGUID: jsGeco/IReKW/iR/3aJrZQ==
X-CSE-MsgGUID: E3b/4+C1RFKfZIZmz5vQyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70052117"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; d="scan'208";a="70052117"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 09:35:55 -0800
X-CSE-ConnectionGUID: w3OBzXbSQqON1Qv+hCEa8w==
X-CSE-MsgGUID: i5FXf5WQTHuTUaCx9UNOXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; d="scan'208";a="210334164"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 09:35:54 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 09:35:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 09:35:54 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 09:35:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIoU2tMSokfc+woPRSXQUa8vi3d73KaJBr5Aq62UH58K1M2kjH8Sj0nHDEJb0pblEF2auBwFKpH0jrBFMkDo7scgjiqwUxfvnDNqHTkl9l78ZpWioQXn2Y7EYViD917qiAuEuAyx/iOm35K09PmY0wGJ0BeYDiIlHcELFNIOLuYJpHFP7zqpgq0c0tKds9ZHM0nXzv7rOEphvEds7orTIDcjB0N1PtbqnV5gGMlasHFPxRTkjdJarAKhv6T3CX40MV9iFtwLFdwwvmlH3zdJXjIFppheyos8NME2XnGg2bgQTAgdtIaKaYBlz4HEIMabgpyTqyrA4lkvzNJ/x3R7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pccN+oJqjg6QIAmqWQuAs0Aa3KF5tqyneu6wFdb//aA=;
 b=wElZdIj0Ay4b9AotybY6YJJAjK5pLOQXBWAg16pbEiIEshwx4vqimSVny5aBfZ2NPHUv0CD9mCfmMQSDXkVmQ5wkf4ai4SeAFa6kBg351vima4LRJ87B9l6RZ52JWdcviMyeuLaLvyABdh+FLlorFBQe2ZhBnAzsrnbxpymtZSZdFFpoGv6o8KQ+mJSVjvmBnklrx6tNw0kD0w/dW35S+5UJszkgsZ8NHk+Nv+O2w0YXmEtau4OX+6HOrgGEe/nW8CPASc2XRyqTKuhTD5cD8Ept94VvwxLYOH0u5IC9Iu64jx9s9x9Xw02NVIGTW8XKV1yp7D2E3vs/tY0ajfswYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFE241D7F14.namprd11.prod.outlook.com (2603:10b6:518:1::d57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:35:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:35:51 +0000
Date: Tue, 20 Jan 2026 17:35:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4] doc: add AGENTS.md for AI-powered code review tools
Message-ID: <aW-88uhZe3wta0_7@bricha3-mobl1.ger.corp.intel.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260116174741.15502-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260116174741.15502-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0335.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFE241D7F14:EE_
X-MS-Office365-Filtering-Correlation-Id: ce19f3f3-931d-4e82-f5aa-08de584a5b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IK4GvCGxBXX7Qxr/w42WgCoNYZ0tbtFjkqZdnMjg5X/l+u4LYWNyUgSziZ4u?=
 =?us-ascii?Q?tvgfqjVwdUkvwn+/HeCGtEkGRuBkSznM0NLHDeFuAqeClnJB+yGzw17yn2PQ?=
 =?us-ascii?Q?wqs1PpFbTjXGOMAGSow9fw6O7GtpmKLHFZwDqxzmAlx89NPeCiL/1FWH+vJ4?=
 =?us-ascii?Q?v07feOY7pKUdMTlYHsmjJnM8yQH2GGdcLXw0WlQIVIe9LFQ1Lhrid/MhU6Dd?=
 =?us-ascii?Q?9k55KIPwiWv0wz46hc1xXDe3k2zH/wyooQdMVyIYgP2ooBVFGr5HIraJrIV8?=
 =?us-ascii?Q?fV+7qJGexDtm6BtkncsJ+/5SceiA/EZO+2R4eakm5j/0I+750g9zyTlYAi0u?=
 =?us-ascii?Q?3Ga2Rz19yGocCG0pfqQFl0LjA27eexOSkyKZG/3Wt4TcSP3OtD0IrPWWR+Fx?=
 =?us-ascii?Q?qE0u9+jDGTtdCGO/qsoO21GjjnCF7bsaGCoVawMw1UXTGl8c/7blf71XRLcK?=
 =?us-ascii?Q?4REH25QvjdC8Y0TmhnmAwO63BuJXDtx6Lzw3KccJw9ZWhXIO1AG5Jky1Dmx0?=
 =?us-ascii?Q?tQiMwNiNVprRonzwDT9/ImfBPdw4gh4d/5XQel46KYK5GDZC/IE3PQTZY2Yi?=
 =?us-ascii?Q?I5qO1RLcszILvYbQnahKQW4e8TjTqa0ZIyYz7Nz4aSLGWddnhdvdjFU6GEC5?=
 =?us-ascii?Q?WNAaXUMrbG5iPONWvxSbPMkq2ac6MVa6VFCmtAhmWN3GAobA7aqcEKbaEI2a?=
 =?us-ascii?Q?BJ5P2EQsXR7b1EYFNfQOLijHKllcwrZDS67ZQ8D2wZQ2ZUHBmZ1hnSchH/QC?=
 =?us-ascii?Q?16Fn03Nqnf9G9IYIhOYre+SqlQ786nAZsryZr54V7iXiS9VKDHm5Tc/MoONV?=
 =?us-ascii?Q?hPJgUYTu+cKZqILVDRA55X9fEAFKc+b1Ag7N7KH7IlSKHzsZZOJ3OLbXYonK?=
 =?us-ascii?Q?elwQYCzYCXlz4I2X5RFg4bBAZ9pPHBp6tduxpkkYIVhrLAndDpfJNwCLvw1b?=
 =?us-ascii?Q?1h/TPEArp6eKPzeTvf59zGLYTdgj6H0LZOGHNKXO6nubfletKitCUIbeMTln?=
 =?us-ascii?Q?99GmELqqaWyvknMdzUatxa4JjGFje9llx5HL/+fI89Z3s/Tf0DFUx/u6lOrC?=
 =?us-ascii?Q?9Dz5sYlGEjpcoaACnYP1R25teHDqp2dSdWc1YjbGxYTeuIEnVbA32MiR/cq2?=
 =?us-ascii?Q?/DGqECchY1io5CIjTKl6kJS+zpnwPxSdXK5m/2jVWLGxXIsuJYcAkRiF5h/8?=
 =?us-ascii?Q?caGJP6EJ7076p5fxV/50FCBLDHzaVxw4oQp3EAXAnzke6eFRgaLXbnCN0ba2?=
 =?us-ascii?Q?HkdctGVWsgWHCjJiYfM74AUrwkwn+Mi5rgK8oPPuRHGadqPMCu0zIN+4SaGZ?=
 =?us-ascii?Q?3TD26A6rfioDhN8s3qEeo+qJo0tNMIZBoqvwixszVuRUCDHwDvhaV3QrBcAy?=
 =?us-ascii?Q?L9keEH08tDA/05x76D/lxw6lMdgsD42fyYjX1qHGpfB7Z0f3mt6wwX+J1AkH?=
 =?us-ascii?Q?HLNshdkE53QhXMIcq3I32ACuwX3zdKiLI/RaMrilFPXW/F06/XMv3tC7/KU9?=
 =?us-ascii?Q?GnJcGz/Mqq9npkMwSiGZlKEk9xhD2QgQz3QPVWyTz9ZTvNZwjmEPEhg8Q41v?=
 =?us-ascii?Q?QIXAGSwqLr7YB7WE3NFuVoqH70exuIyfxmUhXkLC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?elQeqLVTyMFzEiUZHVdjqdQG+5IMySdoCNDHc75h1TnAS2eqi/gJvohp8lH/?=
 =?us-ascii?Q?Gg4lTxYZSCZmLaY5nteFS4ZidcDmI8NUifbvevNOWrV/gConfmMrpldX+DVQ?=
 =?us-ascii?Q?gESa1DCKUsM/j+Ii8MmnRH7uV1jxNXw51NCCYEI7EGDeRlAjNicHEx/2ldng?=
 =?us-ascii?Q?b1CW2UM5ExwHmNrSiZKFUH5gHyMx5LMxQylI6isT7mfy2IZyMQAp57eVyjxJ?=
 =?us-ascii?Q?cFukOmy0gBgoeKj1V7F4M52thxqVOhOMSseCCiwDDu1F/JGXCuJ/m8z4CLnL?=
 =?us-ascii?Q?ma9+guAjdx55yHSmjyXvbFiu4EQ7VstHAPux+ZGlUB4tffFmNMA+dZz+rRY8?=
 =?us-ascii?Q?MezwKz9CBfySWopt7O20tA2yDclatUQWhJh7O02Z4TWNWS9kPVIXIp2Pe3d+?=
 =?us-ascii?Q?pF9wcKKqKGfvKyKmuUqisqdFJAcpGPb2RLfop9995e8UhBOhvI/nNoT3EKH9?=
 =?us-ascii?Q?lS8oiZ9IdCDg4vsKaJxj1J0lQ2G1yt6ZtlCa2Ys4tFQe29UtZgpyai/6WF52?=
 =?us-ascii?Q?lyfaZnwN2Sd002Bv7Rpl0Jrtw8ocUO2bO04yAHunPs4kW7OlfqRDQhPniZXF?=
 =?us-ascii?Q?e2O4F23J11wD8XGIa4Vny+FEs/12yvs+MiHxYPc2Q4xCXmEvd4xxYt80V0em?=
 =?us-ascii?Q?A2XDhDSAD3EJj9iObR052lLavlLZudfFYHskd3qfPAcTxNFA5K5i6erltn0D?=
 =?us-ascii?Q?1h8PZdLDDisYFzNi8Skl3PGXYgmxx7fSoNVwRdiAuRGF/FdYDn+/cuAl+ott?=
 =?us-ascii?Q?I98cP3nZ3IWQuyoSL1Yc2leLChel6AkwPSBxNRpd0fFZpYfxOeFPoPNsCPWj?=
 =?us-ascii?Q?5p7seQ9lW+tN1Ad1nt+IEWbPtwLkxUOWZiYORkEEmiqxdlaYdvRuD55gB874?=
 =?us-ascii?Q?s+y0poW9g6oPvKLJurbuR1Z2oWA/v6h6srZl+pfzF4vU2SYh+xMkuGjPEcWo?=
 =?us-ascii?Q?GSDuUUSgcWWxGcgOQsRIEcTaXMRL+Pk9PTVIFYnt/H99LoUyczd1pCjCfDnY?=
 =?us-ascii?Q?5vj/vBL0ia3/DHyzInbVu0zeC04ZQKe/SkYczxjX1mMlrd3ly+a+acaadKUu?=
 =?us-ascii?Q?WuYy5vz/X3kk0LMv6ZVr9XPc4+QPKzQbdBWGWi87wDyF2uRgkzIBHnInHPYL?=
 =?us-ascii?Q?aOGRtg0w49K/OvTfWayQzqlxXk+LWts7D1jSW2juBqwgL46gAo7AdOf8VYXV?=
 =?us-ascii?Q?bwJk2tHckKEjrGAHdzm7sLJWUK4dZHbJPu+TKNW05pzKfQR9OTZfzZodd7d/?=
 =?us-ascii?Q?+nUP+/N0/CqjZ1q5b6gxtI+KM9QKKbLosXdazgi8z0zO5A4IxmoTjo96eeXW?=
 =?us-ascii?Q?vmeVdNsNuI2hCM9sihXW4Ii9Z/rJvUq5PMXeAUCmA1LWxMHh3EjRXTjYEo8H?=
 =?us-ascii?Q?3UoHQBw0HUR4mjDhoZ7sT1hmb7ygIPPtWOcr24yyR/MDxeWfiuhc5chwJiQc?=
 =?us-ascii?Q?HcxN++M05ztXlgtM6g5QwqoBotIcWhr98h9vo2UZyyRV4tJocSAkA2QV3pG2?=
 =?us-ascii?Q?MrmGg6iiC1Ek9blN+azQmR4z/vMfpYijRa4rFvYs3eTfRMc69e1C97ITo1on?=
 =?us-ascii?Q?/pYsRfz8jA+v6dPQAFJBK0ChHgww9PicQeOYaiICS+VCV4Z7wuZJarPkfIsx?=
 =?us-ascii?Q?Yjz8Qoim5XIM8L8L+UXcuaF8nSaj/YJy00qqZN47uH6CSLihhx/tlUc1h1Cf?=
 =?us-ascii?Q?/GnsUIh2w65/pIhmsOX+aezFT5TW7Q7wId2sq9GCPFdJp0yTfqpZsEamQucD?=
 =?us-ascii?Q?lC4wA/gvgt2KQO1wmDVGCHZX/htfQlY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce19f3f3-931d-4e82-f5aa-08de584a5b0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:35:51.3629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOmAHpE+EE740VXFA0nuF/vzImIVuYDLqNoGVfKeijra4ycBKktN2sWMa3kjm1VEpJOjsZ7k49MBAM8Qk0gL51PvoxSJcPnt9sv79YwBA4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE241D7F14
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

On Fri, Jan 16, 2026 at 09:46:41AM -0800, Stephen Hemminger wrote:
> Add a structured reference document that enables AI code review tools
> to validate DPDK contributions against project standards. This document
> consolidates requirements from multiple sources into a machine-readable
> format optimized for automated validation workflows.
> 
> The AGENTS.md file synthesizes guidelines from:
> - DPDK Contributing Code documentation (patches.rst)
> - DPDK Coding Style guidelines (coding_style.rst)
> - DPDK validation scripts (check-git-log.sh, checkpatches.sh)
> - Linux kernel patch submission process
> - SPDX License Identifier specification
> - DPDK Coccinelle scripts (cocci)
> - common items spotted on mailing list review
> 
> Key sections include:
> - SPDX license and copyright header requirements
> - Commit message format with precise limits (60 char subject,
>   75 char body) and tag ordering rules
> - C coding style including explicit comparison requirements
> - Forbidden tokens table derived from checkpatches.sh
> - API tag placement rules for experimental and internal APIs
> - Patch validation checklists with severity levels
> 
> The forbidden tokens section documents restrictions on deprecated
> atomics, logging functions, threading APIs, and compiler built-ins
> that are checked by the existing checkpatches.sh infrastructure.
> 
> Severity levels (error/warning/info) align with the exit codes and
> messaging from check-git-log.sh and checkpatches.sh to help automated
> tools prioritize feedback appropriately.
> 
> References:
> - https://doc.dpdk.org/guides/contributing/patches.html
> - https://doc.dpdk.org/guides/contributing/coding_style.html
> - devtools/check-git-log.sh
> - devtools/checkpatches.sh
> - devtools/cocci/
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> 
> v4 - revise based on use in reviewing patchs
>      get rid of false positives from variable declarations
>      add checks for rte_malloc and rte_memcpy
> 
> 
>  devtools/AGENTS.md | 939 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 939 insertions(+)
>  create mode 100644 devtools/AGENTS.md
> 
I see you are putting this in the devtools directory. To have it picked up
automatically, should this not be put in the root directory?

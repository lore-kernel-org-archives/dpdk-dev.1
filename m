Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2843C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 08:11:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6902740BA4;
	Tue,  5 Aug 2025 10:11:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6715540A4B
 for <dev@dpdk.org>; Tue,  5 Aug 2025 10:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754381512; x=1785917512;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UQw7ouiVwm8t7clYzQ7TGOdCa/nIRASHWYdXbsHD19g=;
 b=QnsR7lCLsrRL4pD5Hb1Zh1HdY/4zGoHCo66vxaK/X07zjqfhPK4JaOtf
 ge37MYgTJCIbpWNvqnCJG3kLV8YXDTbuFiF4L0ti1/SX+N5HChrXYz6R+
 BVEY42R/HKnUmpdRmLZfaBMJEi+uvKrhybbshY5Gi7wYozSu+nuuYoATi
 DnMFWz3Mla8josTgHhZUg0ld72vyg9sUFwPiZ48gHi30yU5BjCK6/km+m
 sqotMIylbzZfFhyDWkisIBNglGfqHsAPbYgHR6tjRytGkWv6N61xNi7W0
 vRCOfG4jEW+830Je702j7ADEzZ2hOuIOc6sn8QyaDxtAAQT8sNChgtsvv A==;
X-CSE-ConnectionGUID: ZCAun+OkTNC+RipMirOzng==
X-CSE-MsgGUID: x7Go4j0lTV2icyCbOt5RRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="79220717"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="79220717"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2025 01:11:50 -0700
X-CSE-ConnectionGUID: HSRz/GuTQlmloVE/ReiwiQ==
X-CSE-MsgGUID: 4Hh6QYWzS2eQb3elNYKBRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="164835098"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2025 01:11:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 01:11:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 01:11:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 01:11:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tisUL0nmX014Mjo/OP8+J4DPifFBNczrWtNSImqMhIt/QtwZtZSLXHi815Qut7Mva2m06+xj0zV85czYDsiOJoCJjxgo6jlykdslXZo1o1kFnhillbWS/rr9zSni4EcktwTeCjyVT/vAo4j4l0DAlml5SXEF3D6iKoG3ZCKFZ7pwpl0ajhyzC2R82RmNi2J+mmlvoRq/vge7BMUxmRCEuCAoX12GVAjx/cSEC++y6mEvlMOuIT7K8D5pyCo+a9t5YwuLD60/nV1Uf+vM4kymafKwPgf/O7LdeDqC6gq39FRTivGndWwOSbjRW62JWen/9EaeRCfMsU0KvY53/x0j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY5RHvrSb3IsQ6v93UgB4Xn0s2WkvkQHeK57ukyHaY0=;
 b=g12rsKBJZVsGEhcraIFsBQOHTpue9ZjU20MH9G7lbTUOELDdiOdLijPJenPjhyxjZKDpQk2LL3kztwfNmLhanho9wZI5+c9OMBgVaMlBOC6k1v5kEbD3enPSrAKOavxB+JJxvP8efVcPJF01dj+15Fee0c3nHwTzWeUyg950yyZYTfvmAPeBTnIdy9RKRWAuZqw3hZ/1gkJccFc/SauDMFl2f1gJmVqIuzrVOVkz/i8HsZNZUetSzygeKRvk4xMQmrQUhRwHj8ovylrivHCmiqrSyA11DWIORrRy5ggS4xvx7JVLlDGatklar3OMFw2DrbzHZoXrNLFLRPOGdMIR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7143.namprd11.prod.outlook.com (2603:10b6:510:22d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 08:11:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:11:16 +0000
Date: Tue, 5 Aug 2025 09:11:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <andremue@linux.microsoft.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v4 1/4] eal: add basename function for common path
 manipulation
Message-ID: <aJG8oNFsY2vLZ4OX@bricha3-mobl1.ger.corp.intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
 <20250731160041.914837-2-bruce.richardson@intel.com>
 <20250801145611.7a2ef22f@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250801145611.7a2ef22f@hermes.local>
X-ClientProxiedBy: DUZP191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 19116fab-eec0-45eb-951d-08ddd3f7a6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SBq28OEn3EkyA7FShvkxwb5T/AiWAsZFeX/K2wRm6PmtiB1X5X9j0iL9++pG?=
 =?us-ascii?Q?E2bee+/BtclPkOYrWsmiFnby57imHvBhetzyXZLejxNWgqsbCL09dibYsbod?=
 =?us-ascii?Q?iawmB14k5KNARf7xJ9Hy16m2DtaytHWZzaNpKe7BmFGEaDKMNOET9ukI2QGr?=
 =?us-ascii?Q?UZnx/I0Nch+8ietjplo1Z8zyQyEcsZPDJ9OmO5iw26+IqudtBOpc7xUPnxES?=
 =?us-ascii?Q?Wa4ssocj2frNEXCEvuoR57lwQJUP/G1mOcndQZbTUmVv5LMPPgYxxdXRuVYq?=
 =?us-ascii?Q?LGev37Og0GCyMPzCt156yfVZsTT8xRiTDtGb8wDq0egXuDTj31YNYdQd3abK?=
 =?us-ascii?Q?D4HhIAtJxH69etzTYGnXKXmUtpZGEzu/1+0/NHEAM+rBXDRdSScqGJkNn9Fs?=
 =?us-ascii?Q?tQ1a5dlorRpeRs1RG3H57TqJEP75bHKBJOEoU5vK+3AInkbYSYTZcLUqtihb?=
 =?us-ascii?Q?R4T2mV/E3BHLCitnSWMciXsSFf9Hdl5KnW/g/UsKdtewfV5FcJK06kAed5Vb?=
 =?us-ascii?Q?XrgFu5Zxq/s0Zvs2deMVMB6Tz7elrEpSW3U6OWarR0ngPiWGGyu4g8XZVP4j?=
 =?us-ascii?Q?/0zsOikuI6ZW84BYD39FhC5tO/MkuliThEpexz2QAMkVHyBYaLIE9Aw0GD9L?=
 =?us-ascii?Q?gzZLqpE2X8kQZiM2gRFCGU77CuTDSKsU9SFxWiq5tlL7ZySHat5PMZZFUh1X?=
 =?us-ascii?Q?zhzo9fBWS0/zhFvE3n6dYrgwrpWVdLvZe5W1sJ9znUUlAO8ZlB2PLp+48isz?=
 =?us-ascii?Q?sQ7up+FxZbGTiReGgECnvzDqOgoMJ4IvVVYBRMQBGsuHsek0WB1NxqTny7PO?=
 =?us-ascii?Q?HVZuz7WEzZwbtJic8KO1cChuqQi0BkCWsx6butyIKnoJPPfbAh4UVyujzO6H?=
 =?us-ascii?Q?rvWEqCTyei8xrc1zQym/d/VncDfc/zmw8cg1YqmbGChmvD/uflZ9x7m057ks?=
 =?us-ascii?Q?LnfLogTiseFPpkH7+YueLY4r/m085eeDU+RZX1VRlYaoHKElIzeyvEXQhmv+?=
 =?us-ascii?Q?9tTiuRBtrorAsGQ9DAxaXgcuxyzeybV9XaqeasQd7bF3+dlFy0oc2w2eP0cj?=
 =?us-ascii?Q?WOs/WetKrdFg82JJGG3txrz2U0j222TpJ9tgRCWbVRYflntQGqmd8FVjPivD?=
 =?us-ascii?Q?Mu+5zlywaGNA3xBr8zlTE4k2UN37LZ19w12MkmTkXCjJ/OrHRX+lXviE+i3i?=
 =?us-ascii?Q?c0KLnKQwXLZXC6C3vN90ucqoYE3K9tnPzr+g7VRPvmlu+yDaDwX3ZJQksFLH?=
 =?us-ascii?Q?zyNA71zMbYpU3+S+pm0Uyhe/0Hpzr6EjcDEjbpOtE8biD0+4XwGmeOxQZW9P?=
 =?us-ascii?Q?CIGK7T9yxC42PZ9zLGspTasw9wAMIoLL07wOR3w1R4mYpdO3RFWvvJxrlcrZ?=
 =?us-ascii?Q?/NfmNFLL+1YNE8PWa3HaGTvk+yDk8mW1CXuxlfBkG3F0eis2PUkfMyMdrR8m?=
 =?us-ascii?Q?nQpVv9Py9Us=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q7BAeN9ZmiG3bloAXepTXaIc7fUZaAQAPo0SaB5cKM1K/HbAb8fyMhmrWL9v?=
 =?us-ascii?Q?OPNe4gvtWeX7S7Y0UphksRQ72U6zCw1gaSw85cHTnF0OsjVRoLhvcO1BxWCD?=
 =?us-ascii?Q?CK7CmWJFxJ0G85Sj49y33o7VHAohQ7NQ3ekkmCBIPxei7LA0MBY0yZJCFSZo?=
 =?us-ascii?Q?CQNMMUD7DIlmJkQXLJAuhszX3usK/t51x7z5VArZ2Z1lUILkX1mdwMIvJ9Oy?=
 =?us-ascii?Q?+C+JvwMIB61WnWkhxDy1GeUc7uvC+2SdTJnC+TgA8fyenY9pOQLfQyokjAA3?=
 =?us-ascii?Q?T3Qk3fxVzVMxxf2BgMLL85twExZZE08NDr389OPcQEX6OwgILERzf8lBa3BP?=
 =?us-ascii?Q?fQdAk9FXRweaUZ/UzaMf2sOOWnK9PFY5KAQe9IiF6T8BVh+Dsy8rzG06TQzt?=
 =?us-ascii?Q?VZQDiF5S5cHNu3hhzm29hBsKTwcsQAhleBqTFl1ybQTzigxfPjcuekBApIC3?=
 =?us-ascii?Q?0R2ZCdRpej1CyDHu5F9eBoSW8lQthw2fhp6mXOx9VvNehzmBHQpPeKM7+qsH?=
 =?us-ascii?Q?PFkHvQ2MN0S7H9EAs3MuUi1T6Byyt266sRvy/zG3D9pTlAzErgLClDKU/A6u?=
 =?us-ascii?Q?99eKogEtiOEI01+jSF4+A4ZzibgsRMFZx8phFSx93bvlkqON8lnvJLXxgru+?=
 =?us-ascii?Q?zH9+Un77lHVVpMMw/R4Mh70C8qPDsRR2vuijF53ydoj7yQvKkORq4B22EGi4?=
 =?us-ascii?Q?NgIx6zPdNcz5IAf3HMcnathVE6s7aaV/0Cks3ZT3KDBaD5nmou6Y2o+YDlbL?=
 =?us-ascii?Q?57ktlMxX4UBX+vadJ9eGd/mjMKjF3XL3ESo8LBhqdertZQGVeN5PG4dvXQp8?=
 =?us-ascii?Q?DXu7+3JXYaINsdIgjF6wbZgFqDw01DO0gvqunvR+yVj4w+h0GcpcbcpeSIx1?=
 =?us-ascii?Q?5HBt8q7z0IePK4D+7Tw/YEE5GgyEzy7Xbp5YdNOyFzyB1vSiLNeMKf2kO0vR?=
 =?us-ascii?Q?6eCLJVGZLvZPDSFuezyDKS5XmFZfz5Ay+i3vDZPI6UjOUI4V/bBoQoias5+f?=
 =?us-ascii?Q?NYnpnhx5SVyN8WN7LcIC8Bxab8Dwwqx8D08M1ckNy+KBYMVNen6glfPcOKBt?=
 =?us-ascii?Q?t6ZsrFl36684MYp0ew+HvhrTNXLKpFRdbifYWRhlSEk4LOPV3d8k1vKEusCq?=
 =?us-ascii?Q?ujjuNo3ODx6T2A7PxIWkP6aCbaWT4yVl7OrwVkHl73mCKgLpMOUlkFeDs3Lq?=
 =?us-ascii?Q?vqbx6NM4JA+c3eCB6XNbg9KQJMn7JAXID8VqmP0p0iMrAnyFwjP75FLP+udT?=
 =?us-ascii?Q?hLTCdFVEfXObCxkWxHQpLIf9sAMhGtnnmSOZszsA4qua16s6t9YyCyVaAN5r?=
 =?us-ascii?Q?IGV0ichDO/HfSWT0UHClstqPnZQtrzJAlSjd/1NM+WzN1ZzP9n2vP4VY52fA?=
 =?us-ascii?Q?VpmmzxXa5HuaLVJkvWJvP6sMYTQDOr/Bgh10JDTGEORcsFQ7rfXWnlAfgJvJ?=
 =?us-ascii?Q?nTl/vEFrInF3zvBkZ5uPhDzpCroRCtDbnmjijal5ZWFwiNwJXRYuLcUGgAIn?=
 =?us-ascii?Q?JRHtj3SYGbTsCE15lspSQO5AiZB1yskGqy4zfvTygVpA4P+SHasHagTDvrWj?=
 =?us-ascii?Q?vSxFjqWX/79FEPbQCZDYuVF2vRxYID9ECVadxsgEM0cD+ZGdRnzBqUSu6AJK?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19116fab-eec0-45eb-951d-08ddd3f7a6c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:11:16.9125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKKQzAVYtmltxI5VDCM4lZQMeDeqvs+vo3VNuApk8ojLFSV+9Z2O+cpXtcRxkZIVxQXlyvat1gK8HzK3tFPrLlX6C7wsEbU7pynys7zMGPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7143
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

On Fri, Aug 01, 2025 at 02:56:11PM -0700, Stephen Hemminger wrote:
> On Thu, 31 Jul 2025 16:00:38 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > There is no standard, cross-platform function to get the basename of a
> > file path across all the supported DPDK platforms, Linux, BSD and
> > Windows. Both Linux and BSD have a "basename" function in standard
> > library, except:
> > * Linux has two different basename functions, a POSIX version (which may
> >   or may not modify args), and a GNU one which is guaranteed *not* to
> >   modify the input arg and returns pointer to internal storage.
> > * FreeBSD has just the one basename function, but, to be different, it is
> >   guaranteed *always* to modify the argument and re-use it for output.
> > * Windows just doesn't have a basename function, but provides _split_path
> >   as a similar function, but with many differences over basename, e.g.
> >   splitting off extension, returning empty basename if path ends in "/"
> >   etc. etc.
> > 
> > Therefore, rather than just trying to implement basename for windows,
> > which opens the question as to whether to emulate GNU and *never* modify
> > arg, or emulate BSD and *always* modify arg, this patchset introduces
> > "rte_basename" which should have defined behaviour on all platforms. The
> > patch also introduces a set of test cases to confirm consistent behaviour
> > on all platforms too.
> > 
> > The behaviour is as in doxygen docs. Essentially:
> > - does not modify input path buffer
> > - returns output in a separate output buffer
> > - uses snprintf and strlcpy style return value to indicate truncation
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> What about existing uses of basename()
> 
> 0 main.c                  main                       553 char *token = strtok(basename(rst_path),
>                                                          ".");
> 1 process.h               get_current_prefix         220 snprintf(prefix, size, "%s",
>                                                          basename(dirname(buf)));
> 2 mlx5_common_auxiliary.c mlx5_auxiliary_get_pci_str  85 base = basename(sysfs_pci);
> 3 idxd_bus.c              is_for_this_process_use    271 prefix = basename(runtime_dir);
> 4 bnxt_tf_pmd_shim.c      ulp_pmd_get_mac_by_pci     156 intf_name = basename(gres.gl_pathv[0]);
> 5 eal_common_proc.c       rte_mp_channel_init        628 strlcpy(mp_filter, basename(path),
>

I wasn't planning on updating existing uses unless necessary, but I'll take
a look.

/Bruce

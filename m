Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5A8CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 10:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 466324029D;
	Wed, 20 May 2026 12:18:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3E75C40144
 for <dev@dpdk.org>; Wed, 20 May 2026 12:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779272294; x=1810808294;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=camo3HEDxLTcGNkuezi6//Bjluk/HmBemzwWwh6IZv4=;
 b=mxQk7AR/zhkBR+Mq/PeFsLECMsFTJ1s5DofRjEO5GI9JyPdt+gxNtXa5
 fVKpe7OCU5q7SQ8VnxEGTAPSF3i/UrIvW2JoweMD0FdnJPNN+Y8wlCu+R
 AcV0TDvC0+1AruETY+My0DBbZw6WH/G73ufOm1p2XseNFlRhhQ5VezxZK
 BWQgpFBzd2I0KtymKFLf76q1zoIm8eADG1//WDrSlo+thwVB4QZ7kpvEF
 cHyYJQ9I9JkqIX4YViWase4pZaYlgIXrr5yVAnY1PbbTgZGJJElakQ6+h
 uqlQ4R4gjNrUvlmxl7PWncCkRJu9aFicqmb9GJ0r+zmnnbvIQSIPgarVi Q==;
X-CSE-ConnectionGUID: jxW93cDbS/yrNKESULJ3Kg==
X-CSE-MsgGUID: gGeEi0UfTKieXjCW1SP0vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79314251"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="79314251"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:18:13 -0700
X-CSE-ConnectionGUID: rHh58ue1SAa+yNU7uuOjow==
X-CSE-MsgGUID: 7qEb157MSQua3UIYBKen5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237522124"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:18:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:18:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 03:18:11 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:18:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHRS/ycJpIeb+zJrgd+kpimUG/YfOWxj5zvoWWzmyiOGq3nytMdW3TqFqCHs40hCR0FTckdOD/Q7DgfjaPzg11ZDW/R6xHcsGhVr2vZap5dXJ0Gc3uFEuXkZ91vpWHZpEg00Js4o0Z78d00/+ISlTws/L+ZPd3LsiBl36VonB78St+AfBDvEbKFUNVDOw0OnBbkt87PquJbUs1Z1q8GnY449+wd1juUqVtc5yp2Sf1GZXMgS/xqR2jKrAnDPENHsPPiDvccBYyLZ1sFRKEKEg4ncRiV4xWE+KCAZzdDhd/3m6iLmVlblQ4yv3O2/kT6aU4wOrXBguEqNkZU5EgGN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3QEqStEHz358mJws5XXuG/YkIxRGLO1JEoI5QKMLII=;
 b=FYEOi1921ujkbvUo2nR6cMPoXDkH+0kvEGvNS/5Cvrm34D9V6/u+kNRYXg/eN80BLNEYUNTddNnxyH/w9mfYhzGhtFGArzVRotIFU2Sb8cItWByLzm9n4hdnGZCCwREqyo8yEVHC4RVt1si1uten0W2plh86fQyMUwYU8pEcIdVpr1xW2bA3NJ3mhUfrTbvkv9O2lcAq0gABHLcMdnUWQz/ZGX4A7vMdNTpSfPj7eAhQ7djK9PO/TK49dkhC3OzAueuaCGy3XbS9YmqeovJE/HLnl9NNs2LnRgCYi6zqcZMk3ntyD24V56uHXCS3sSZg8ly4pEj3ImEdQPrQbW5xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:18:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:18:01 +0000
Date: Wed, 20 May 2026 11:17:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] i40e base code update
Message-ID: <ag2KVC75BIE0KxiE@bricha3-mobl1.ger.corp.intel.com>
References: <20260519145227.308814-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519145227.308814-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: ff79e81c-2eed-43d1-df9d-08deb6591244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5I/fzeLV2TwWfkGx/OfRIk1LFTGzNiUFt6pypnsCAsL8zVoVI5R04Mpv3TR3CdtfJh5cmoPU7PqfpNhuZTgjjiidTZ4iFWTUUO7Hs0brY9pEnlm2zPYWEQXpMaFtOBQX3AxpwnnrfrICNTe8I2Vz/kE9wTAoU+xsidKBYrUP3x51gQF4QM1BHcsQSvM3DcvPMVn5QRq+VAiPaKSXmLfRJik+eT4igiyfuKUf04uqcIopAtKTCJ0rHOyx398GRcIom0MbhSrfM4e8vZ0AG1BF3JpJwiVGhyhEsMYYXiBDUsr1J8UC4u/8UlC+My81d6rovQAlI1p7jz4wM6x8327geuAjzmOfEbPCnxkAZtc2BBqhVF7dZF9KHglUjRaoxC1DIMCiJMv+iXAkGTtabwWrWSRz+ibRHe8Tjurptor0loI7peXLKQdRjuXvULmW789/ZJGwczFSjxQiiVb48cutrjNIZxo0ZErWRdK7vnW0mJjEvJfdHBoHm+e6ylPrbJns/zAFZvmORgyiaYTtGwP8juQ9EJHgmpxiZ5xF3tqX2pLs+fWcfyJ06ceLT+KduuE61dUDPSKvYAbjE48mrT25eGwE5C9agNKbucFt5tziFAS0rwrq5jEjf0n8/Icie3IPsm5t6IjBnGNBMWifBWFXmv4NXB9FDHbvEjSuk75cS2C/93S/DdZom6bQbx3mqkIp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zVkAJU+hFnw8KPtMNweNivG/H6UnNqEtCjmlQ2SUJJmVxQVPuab84JChM6KG?=
 =?us-ascii?Q?tCOWKa6rqrK9CoNFKN8B4hP2ch6cDLCPs1BYXOawkfOZTHflwL4tvR1mYSue?=
 =?us-ascii?Q?9xifmeOmItkLoVCQF52NxwK/1xORl+nQUoJ0eFltLsMZGBokk3uOhqEdC4Fa?=
 =?us-ascii?Q?Zq7jq+sf9KE4YHx4SGKOEn9u+kHnkqBTPOO/PMeRMDXxE7ubDiwm7XmjKxNg?=
 =?us-ascii?Q?UQMuJFN0CSuo5ys0NF2oIH/AD53iWjuvLcVmNYy9nzPTn6eDXf0yX4+HyNKx?=
 =?us-ascii?Q?Svn11n6UM4WJkmuDdrJVhVn870YzAu4ourEGUoGVrdkbgR9P5DQ0w0VkL0eE?=
 =?us-ascii?Q?1HhQukBzP8AEQjrkS+KxLKoUambB237IYHBHx4gQLlnTersKxwdM1IrrkSxF?=
 =?us-ascii?Q?sDxaLec4IQNvk0m1sJhHOCYp7MsglM4YVAmwNERBvj9opR2fTWdfXGlfomfE?=
 =?us-ascii?Q?EyD16DPGzjRcaIoojFaQKa4oJjk/4UvuK8ygylACgFVLB+zcQbAM1vX3VgEU?=
 =?us-ascii?Q?WcbiOz/1XXMME1cvOwix9HC8ih6E+1Nk8I3fhtnJZMTftbeC0bm9ZPFkfbuv?=
 =?us-ascii?Q?EEU3o6rKXap/a4Jr30wQtBYhUj5WsvmNCoB7sXfwYIaGUmWqsa+EiUj+CNvq?=
 =?us-ascii?Q?oe50DwtQW10dgFhU7r5HPO/4ix6yuTyN60Wv4NdmhmbmbSaVBto1qyySgAXr?=
 =?us-ascii?Q?DsdNRarmCRgoIjld1fOo94jp3l8pg/B8x6UTILX8SukXxSsFQPcmHeHM62Wl?=
 =?us-ascii?Q?JOzfYMbrjPxV06eulLaVdUudP/vATNCSpM1z8mBL1vzlh1RhkDsRCPhK9nOD?=
 =?us-ascii?Q?aUn89W8bYpWRfhjmXiKqkmuoOWHqMJgxPShVI/+98x8+hytVky1NWC8Xi/JK?=
 =?us-ascii?Q?03qzsS8gR7/Nea+KeF7O6hS7KNfISk0f8j/UQVCLMwwTHfP9XTjTqMM4BFET?=
 =?us-ascii?Q?grWUpgaxcMwNdz0JRRmpJDQo2hC+3k7Ux5Fn4jPfaoGHvvBE34nmuXQnYy7s?=
 =?us-ascii?Q?fXQoXTa1cA/riBzIuatdZU1icabGNbeS6eOdv9rNmFHtPD+J9hOWxRURMp5v?=
 =?us-ascii?Q?bsmBECD+tOn8m85QFgJvmP0eYzeV19gy/Y8/OrLtKM73ba54mDumnvoNDRKe?=
 =?us-ascii?Q?/hOZp0l80O2UoWpKnTGERTZfbuffu91v+6zP35N2WA5Zq+T8Lx7t0QyS6uCC?=
 =?us-ascii?Q?OTa4iNOV5Pw4GBYkwaNmqCq/JyrmFTBf4uC7Wa6ygCrKje3MLxc3Hpz2gTlp?=
 =?us-ascii?Q?ZxK4dtRjAQrN3dlimTyhMnh0BPlMqgiWLM5saGtLgwa7OYd5e9qbs/r2P4jV?=
 =?us-ascii?Q?oKey9Qbod2kvXagRKpi85UjPXLe41ZVsrJ5cFEGoeMsZa8PA4+If0N671fJk?=
 =?us-ascii?Q?eX0k2O1pPLliMpc8gHbm7iUDGN92QlIGKLUAZChzIvoe/IzzHCU1vecsuXOP?=
 =?us-ascii?Q?YQwlnyda0G4f8bUnxIUj9ExwVZMTMR/evwSnPG1n4zO8DoMvJx2w5YZXGAXQ?=
 =?us-ascii?Q?0KY7QFiNChvyaDPbp7WT/ndaogcq9I4makPeJ00HOCYsnZbr4VResLryZHWu?=
 =?us-ascii?Q?EEHxK7dwwjiUROCRfJnQMOBA4HfN5YJjpC1HAvesk4ildY6t09tdSkWS8ImV?=
 =?us-ascii?Q?is8cF9pUEhtVjOqOLNfIUtnzgS4xGfP0szhPbZEins+uIv9Sbb3YwbJRWuoX?=
 =?us-ascii?Q?XgpN5jY3pj8uDYSmbis9oLCG3K/R5nOc2D7zBUGqjMUM3ic5mIl8CfgruhmZ?=
 =?us-ascii?Q?mdk+L8FbTtg6Z/RbLgN3G8Hc+sHgNlY=3D?=
X-Exchange-RoutingPolicyChecked: Ot+hhpElJlvg09X+jGJuHIl30ZGBMNwZEKuKGAtSTis/t+Ly+E2AStqGycuRxglAw0R5DXm/e03SRWgBZpx6fy0uiNWwWc/mk/3mDCcqTwiyr3D+fRy59pBI9fcSKv8IhOrLIcuUwVy0O/0y3e0VAjZW+uCcZtmczpBS+MBTcTI54QCjXCatmzPsvuINx38IcruL0fqtzdLtrOZKe3u0nbhlIeSZC+/p+bEpQGeu8iXB0EpWnbybfJXRXPo605ay/uXv9CpY6J7J83D4/LGtWH1wMWNEgS4jbKjqsRYGLngJTaLBemFBK8ZcCIHkqfsL4023h/316d53NVivyzC15g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff79e81c-2eed-43d1-df9d-08deb6591244
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:18:00.9704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C41qZq+9Xpv5QFUrhm1kS93kLIUVgLJPfRLoGmQ02lVEOjCypy34UM3vYfUuA8ea/XVcQz5eZuDeRn9fxyGUJDldqYsn2kAZvP9QifOB8gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
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

On Tue, May 19, 2026 at 02:52:20PM +0000, Ciara Loftus wrote:
> Update the i40e base code. Both patches address integer type width issues
> that can cause incorrect behaviour and are candidates for stable backport.
> 
> Chinh Cao (1):
>   net/i40e/base: fix integer overflow in NVM timing logic
> 
> Ciara Loftus (1):
>   net/i40e/base: update version info
> 
> Deepthi Kavalur (1):
>   net/i40e/base: fix loop counter width in DCB parsing
> 
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
>  .mailmap                                     |  1 +
>  drivers/net/intel/i40e/base/README           |  4 +-
>  drivers/net/intel/i40e/base/i40e_dcb.c       |  6 +-
>  drivers/net/intel/i40e/base/i40e_nvm.c       | 67 +++++++++++++-------
>  drivers/net/intel/i40e/base/i40e_prototype.h |  2 +-
>  drivers/net/intel/i40e/base/i40e_type.h      |  2 +-
>  drivers/net/intel/i40e/i40e_ethdev.c         |  3 +-
>  7 files changed, 55 insertions(+), 30 deletions(-)
> 
> -- 
> 2.43.0
> 

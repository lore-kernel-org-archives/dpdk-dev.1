Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE29CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AF9740668;
	Thu,  6 Nov 2025 16:11:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 19B8D4066B
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:11:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762441864; x=1793977864;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JKe25bO3POlGQCs958rXpUII76yCMCCb4KGTVgzV/K0=;
 b=GsD/ngK9B6at6dUDCRSk3OmjNxTuOBczAwqwyoTarW59ZFfgcW5nEVoD
 I4w2zYuyVCd+ogbR4eAwBTrGnIYRG14HGXdWWpnUzMxljvZ8wMQSlZGpJ
 NnfpeYqhRwD26EQjsgJnHUzr7pYA4vtsM5H0BSgRNk1fbDx1gxRdoDvk/
 cpTP8oVaktVf2o/C2xrVZIOZgN6cJBEk2SIULuFv2W3QKI2kDKepo9t2Y
 nFfgnzBLfOOhqvybC+V8tTC7LHWEMucX2amiQ3WCizniAeg+9HXrz1fml
 P07LZbkM261G2J7GKAQKxrjZa7+SpGT4gC1ZgoBtoSZZloxzox+Zbfu59 A==;
X-CSE-ConnectionGUID: DRHwpLbXRjOg2RkNOQPfvA==
X-CSE-MsgGUID: DuLaq618QLmDcooPTkp6EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64488578"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64488578"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:11:03 -0800
X-CSE-ConnectionGUID: AYnmSzX4ShOKUPYQe0a54Q==
X-CSE-MsgGUID: FhXy3vtUSHS6BMowHjKLWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="218533497"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:11:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:11:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:11:02 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:11:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uajikrN+MpgN+A8uiWUAPZoFU2Sz7YqrS54bRucrPWLLZjx9d42LDDYSCDH6juXcb2ntGJir6rR/HyOlD7al8d5iD4t9ElDrmv4yKLYO40PBNcODlZ85lEWIo8L9622oxdOptcCe90IiXEzc1zWPQYldcKPhNKgQwTacjiA7WQvq2Y0QJuWi0DpPqd4IjUi3h6BLrqC2vIFquAsfmSjD8BXE4q/kbHvFzC3o3FSdvQiGd7avsZGYKUB5JntLbOGNu7vnoOJiiowvrMbpl+iM+f6OFW8qejgoZS6blAW6F9HmM/mPN5PBJCg6sPggZg4T1scbk4P/CNuVKmOc1CCh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0YaoZKifNf6OoLsDDcC1kPIQmSZEgM/pAoUAIZBRUE=;
 b=XGST3WvQU4cFUJG+1NVPZN/nek8tIQntWqTme9Ch9NzFJwtLWor6lFpmLH3m7dCIC6xed0NCVBOqDLEBEzwZ4oj3GyhFVwQonRnIDuGjiqWG+CzFDx97Gb3+r+bg/iAgF/ljAmWAaW5KWQQ3yNc1L10k3UwHWVMQtWmS1j5HlU9QH+a02HFLzLj10YfWW+XR08lxktcYqAF+7eJmT7UX4janPD0ciSiilU7vOAwtrCo1QKc44rM06/+NAxpvsYiY1tRuJ9Jt18Zu3II2Ta5kjB31QgR0hfYI1Wu/frlzGQPLP9CtSm7jdH29PvzausZ+NxnV2/t6fOtvlU+l/qLP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 15:11:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:11:00 +0000
Date: Thu, 6 Nov 2025 15:10:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 6/6] net/iavf: fix QinQ insertion with mbuf flags VLAN
 and QINQ
Message-ID: <aQy6f3Hvkxk5NhM6@bricha3-mobl1.ger.corp.intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
 <20251106115016.3035639-7-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106115016.3035639-7-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: fa30cc00-e15e-4df1-382a-08de1d46b199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?06wLWMVyhFVMooWhnDna2zFXKs0xCpNZ3Ifa7jmYQGvlS2pFOm8L6r2Nxdwt?=
 =?us-ascii?Q?PK1sJdODFzByp5ID1yXxFM8qv59Uh+RSMkQbBe8LoY2C1QXeKhTRuNG5WL0/?=
 =?us-ascii?Q?LOQJ9ehy8TIwiUzQI5LSP/6Y1G4QhxOijt3onZ4SDIBg5H8ya7VMnud5nqNZ?=
 =?us-ascii?Q?i8wyvkv3IfJ14xgF0yx6jcQh2bSIV0hzKc6d8ieCA9qTRXvhTMMmBsnrvx3c?=
 =?us-ascii?Q?U4CCQGD0/l8rdstBaG+v7de0/IVzt5RLOEguDiPQHaXA8jlKrtcwIgn50qT7?=
 =?us-ascii?Q?8EDt6rv7Si6vreKT31BmbxKWv4nuzpJrYfIbRmWPEkSZeZZjQR6uxWPVFJry?=
 =?us-ascii?Q?tvHkTrs6h7NbqbN438niLj3fAku3I2hGBiHFktrjTBOKcMXrqEr24jAxuxqj?=
 =?us-ascii?Q?erF1jaC1Iclalcltt1km2DXiyDUxYC0FGgClWsfpFRR2am1Hxvkuuyh3Qz72?=
 =?us-ascii?Q?OPumgpq8CF6gotluNtYYxJsZnFCjLo2WGum0395f+0Cxyk4SlKGimZ2fMlKE?=
 =?us-ascii?Q?NSSf1gQODJWDrufJRAdlGsQOl7pzzdF+c2WlZ6KyINHf16QFWlkWfQ/hI7Ca?=
 =?us-ascii?Q?RgRdemIvzDG7vvURE7HyiIv25gCxlQLsncJd5jY4Z7Is4FQdy8/R3YYG4Tli?=
 =?us-ascii?Q?5h9vhV1xGkPNmupGgqVX7gIFxSwJXJA39IhI0Hu8Bl+jcfoHgDmXtkqriTvA?=
 =?us-ascii?Q?loaNtYKrj1XLyIRmD93bS53a7zx3zIsQtPALnnkCxjWZ56zBYey2jUkra5Hx?=
 =?us-ascii?Q?3LymQJP3lnC7TfEmZaMrFsvIhcdsy0DW565LCYA2NHiQkPTrglZDpSFAfj+M?=
 =?us-ascii?Q?mH9blpC9JWnMJpQUqi+84FTQkF/CzGXhm9drKHlVaJQG4oZ3iyLvj54BOFnN?=
 =?us-ascii?Q?6WLrz7kN9XRrAhmv2MscKXRwwSh3xHs5dW2+yo3+fiHwmnIY5fdH1Ehsxqv8?=
 =?us-ascii?Q?eqWtPAUpEiysiOGazIr0Liu/Y5kIDOyaM5ubDd93d0MFIrQgi6UUpOo59JSY?=
 =?us-ascii?Q?rpVAAVICyD/EKQ4usOBYUCMamXWdvTmlpwiY0wtYwBPMsUo0a+awKQg2DvpW?=
 =?us-ascii?Q?OLBOQ1kgPH+x7QaY2s5/TAQNtR/DM/v4+yvn6D9vIqjiSbBEq/gSnwyKixTS?=
 =?us-ascii?Q?nXF69WSh/SX7g12nypcxALm27hIBLKPFPMbDbwNt0zXYQm31lDBotbjfBaqs?=
 =?us-ascii?Q?IGcqPsdastDcfnicNfo4ditGZjPDO/tgkyKvk9eBwAbtFoZGRVvCFhWGu/tP?=
 =?us-ascii?Q?2+hHB5BlzV3IQlwMan5Aie3v91lL3VNztVwHKkyiHQZSG+M/HNwV5AUeBTlF?=
 =?us-ascii?Q?1fFnHCPgi46a1NP5q5fxsVpUCkeFM64iWIe6gl7ld67Zi43tA/7T04koJkap?=
 =?us-ascii?Q?tVzdybU6q9nFLpMSVuU0p6WrrJR0zlP6QsVdn2/CZR7GcJmyk2C6pBVkFKSu?=
 =?us-ascii?Q?SE8G4iCa2gBeoNVMo/p5JSle2yA3S2sK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdvIlAR/bVDYnWnc1FKXX/oZEMdsdvgbNsBkE4aonxcQ50EJJ28g2V6hioP5?=
 =?us-ascii?Q?wUGFQC//zxipcKSzgaI7B9lrJy/MYXJhs1FIFYXHNV4ID2v0dw1PmTrnnmbS?=
 =?us-ascii?Q?MvwRiPgpAgoB2gXN2X/ersSzKN//35OURiqv3MH7Ku3R1tD/lcuH1X+uYKF4?=
 =?us-ascii?Q?jXpzetRKNqWQX9mb9NV8azxzv3WPrVxK2/CDpPuaaqDpqJJ4N9JUddZfCVtd?=
 =?us-ascii?Q?TO2G9klqOvZunnphScmyulgyZ/E1V03vhhymdarfRHm3tEgfZbE1SAFM4hT1?=
 =?us-ascii?Q?up1iZu7aeyk6ZJlTzWZ2pvG+TCrDqs4+0FlQhx1mG8bpDVDFPAFqtuMU7IIC?=
 =?us-ascii?Q?AVN6HLYh3s4M1e3oZnzUa8YODx3W77eeE4Hvp3W+W1M4sgP56X4Z2/qjFrvk?=
 =?us-ascii?Q?DBwMEC6vWUDCjA/flS61wbRnMUToy4WosJRpPNhdmpCLdW9hzwZlYez7yXrC?=
 =?us-ascii?Q?PIhKHHGqEnetQgwQYRvNVC+pogGXTXEPmvsieGDO8D4LSW/q74eWaCSO4QEZ?=
 =?us-ascii?Q?xNe9+kzCGhtamXp6xiF76L+S79R1kf7uzZmFBnh0V+wqRnmc97E5zF6ci6yP?=
 =?us-ascii?Q?fZAqeYJmeks7IVc/uXT65OC3iQsaMLjCt87Zoj7+Sbsr6a7SkQKAXIxCnuH5?=
 =?us-ascii?Q?ETDDSS2MLK0uPNM4Rmn6xK+xs0Z79BqIvvRKMGn+11CXnHH50QjOQwxAmBbY?=
 =?us-ascii?Q?XmF06Xg6C8R6O1WVmPoKEFqdO9b7aryB2w8OPXsMo9o292OZBNpFrfdIHqQh?=
 =?us-ascii?Q?KlU/KUlynyy9xapp4g05ViijoNbqckZfY4QSFFLiR+XCsHif1xgzEKBi3pw5?=
 =?us-ascii?Q?GTqRgY0SCVy0HcfYta2ZNDGF1XwyhsFpiszb76+SnuHwJ8r6saDdbL1NeiF/?=
 =?us-ascii?Q?MqK5sEErMVpPQ/+C7H1kKNXY+mZI37CV55q+WTaxJnyel7ivrC1/GQDw0CVF?=
 =?us-ascii?Q?zmtl4jW0CQkGxygFudzftWrxIwhl1f1KW+MBndZGtGqG6J4MU8guhEQkU/WZ?=
 =?us-ascii?Q?A3q6SzSbIdcXC+u4CfaNb+c6fYh0HMqXuXM1ap8RkwBg2vK7U8jpQilUxFGL?=
 =?us-ascii?Q?VaL5h5pmXU94j5YToNNLIxeAwRhlC2gJ7d5SBi68muWOVfHHb6mUDu1basGF?=
 =?us-ascii?Q?avycF/CRsh5hSXVyMKgQ7MyPGehhLI9AsPYy0QdROEP5gSn1qCWU4udnIS4T?=
 =?us-ascii?Q?4IvWU3YLnuBA6XV3SIvTbR8be4dxRQe+2W+nn/R9QpL0NtcHb2iI2fHiWOeI?=
 =?us-ascii?Q?Vf2IyO982t/+bIjLs30pVAZMnkASob6EkJmgG/zIQ1TTGxY/kL0dzFGNVGGU?=
 =?us-ascii?Q?PRPIr6TEG25qnejmX7l5f3O6goEyKVRxfEiBpBUiYs5Cn8bb74BAX/MxWkbK?=
 =?us-ascii?Q?1VTQgNJljXOo/LW6heo/lTHGSWaBG0mecGJhekqiC0ETUr9+WfI/ndbW/tr9?=
 =?us-ascii?Q?5c82gbewZk8h5Ig8BD50sAPKt5niyn81AuIatpJK3S7TzW486yrd6NQMBsLy?=
 =?us-ascii?Q?kwofwsOrZXGcM5dp8nba4rGPa8n3Mae81R5uuDpAKDYL4fcSvNiUYBK8i7jQ?=
 =?us-ascii?Q?V5uhQ977d7p8GuDBwu4AuEWRTUUUjS4uJLty5gUB/2PV1wesSRm9LBqRc4h5?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa30cc00-e15e-4df1-382a-08de1d46b199
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:10:59.9057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQZYijbREjmFKs9ColLqe8fNzrjaoAiTuPRQgk6MdciQS8Rgagf3m45H+r3LMLiCvOy23CRup46EYmF/NLsWd8WiN29jYQ0llCo3pwi9D1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
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

On Thu, Nov 06, 2025 at 11:50:16AM +0000, Ciara Loftus wrote:
> Fix an issue that would arise in the event an mbuf had both the VLAN and
> QINQ insertion offload flags set. In this case the L2TAG2 field would be
> written to twice and could cause the tag to be corrupted. Reorder the
> logic of populating the L2TAG2 field and ensure that the field is only
> written to once.
> 
> Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 26 +++++++++----------
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  9 +++----
>  2 files changed, 15 insertions(+), 20 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

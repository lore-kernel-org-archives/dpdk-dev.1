Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57291CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:47:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A58AC40647;
	Mon, 20 Oct 2025 18:47:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id AB741402B0
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760978860; x=1792514860;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sFY34u6VQnUMZ5for+idWfTq1riyu9Mp9cE64o6vTaI=;
 b=f5UzvRz31BqTacPTrXFR1YhHnseEi6bXGOFBELIMzlPcKcKAJoapYMHm
 W71iT0oxitd2e21OVm+tpfDlmhTyvvP6U3dmTrBy6uwAShz0V33+Ux8QX
 d7r5A5o4bJ1F4jtLrStO3RHz5KEuREB4zyrCroLq81f1h62CMceKtuDmg
 1Tiu69ym13d2nmWYia/c9w6MEkGPj17RYO7P0EGNpJvsfeeBP3jnXhJIm
 3hxFAt4I6tZsq7EVq3lEJgMLMwWqnRJRM/mq60Zr2fKOAXOYWTQ+/+Bl9
 dwmUqRZActybueK3lc3+dlh2IHxOwzYlSaq2oAZyEbdReMnVePAFSUuNg A==;
X-CSE-ConnectionGUID: 3KvOUgNIStOvntfleP737w==
X-CSE-MsgGUID: onUtCUScTPK1XQF6O3zhyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63137868"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63137868"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 09:47:39 -0700
X-CSE-ConnectionGUID: SnJu8rurQka4HyEY2cnEZw==
X-CSE-MsgGUID: hcvH/mIBSRu9RXIYe1b7Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="182516704"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 09:47:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 09:47:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 09:47:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 09:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shxvLOo2cMRibYsSWzfh1xJ3ebwqfljcRJ8pq2LwxY9UM00PpgjBRdcdxmVoRcXtpKH+LyAeHqq4OlSAwRxnWkPac6RjTSNrqBgXSBYyNs/PH3jfzIWMM10t8n0hGEGc2nsmkqy9x12kZPeRXpEN6WmTQ0G3xiYpGYIV8RYBA2BvKx2hfmcKiPTjEbUfpp4GoHNWPDkM6OK5CT6ijlcGpC0r9mZxPcICjm2bcCnd6Lw0+66vGFFsEBQS8a6s1C4VMofKbimhSPeOTt968bJISU+w7Uk0CK/w5ZqXHhjGrnRUnpoLBeVxz5JkzBoTAnOkfa005IWKwbJI+L3mgdFqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPs2POfjwU0MZfHLPU8uBerjaFLB6u8vmjUh7X+s7XQ=;
 b=zTB5gm1xSMHVCjCnHg2SijReUxu1romXDfpy/IxRFqBKkLSXvvg/2z+6EspJFDAhqAwnEaByixA0tNugUZJt6J1OFJ52zmRPscGAQFScOFhTPezMH8xeX+50vsEcE14b+iG18RvK6uWqCjDlOS/4LoARC05ddaGp90WUm/4RDKhspUpn1IzG+dove1PxdA4TiZecB1ohODos3L5Tas6VZDthAzv5ZIRvBbRf3IiutV1AmZ29A4RxTQ+axma1gA+1I8CtUowPsUetQJojrmmPnmy0XlKMnO2Bnbti1chvMYzvIyhO5LOHCfy+FHWfY6ZZqBvV+9IyeHSKmYcJ8wv3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 16:47:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 16:47:36 +0000
Date: Mon, 20 Oct 2025 17:47:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jeff Shaw <jeffrey.b.shaw@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] Revert "net/ice: count drop-all filter in Rx stats"
Message-ID: <aPZno9kkhEkPhIw5@bricha3-mobl1.ger.corp.intel.com>
References: <20251020164230.3724539-1-jeffrey.b.shaw@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251020164230.3724539-1-jeffrey.b.shaw@intel.com>
X-ClientProxiedBy: DU2PR04CA0238.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bf551a-3ecf-4ba1-cbd0-08de0ff85f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3w8iT+nMAxEVpg00XK8SNBGcFvUgXVVLnSTOKBZex3SW9AHPlJQ26bNZMFgD?=
 =?us-ascii?Q?aSRg4Q0wlV6mtdY17HH2DGNPcljLR1UhEisvhK+xg//+oOtCPlQmy9B2DLhf?=
 =?us-ascii?Q?K3JAOh/nYJR01rthLvx8+zjlxGAZxRMG7a0QGXF/Y03Mf9qgd+OA+BECXog9?=
 =?us-ascii?Q?SshFC2LVuawKpGiNC3isDACnBRu95lGvtb3QrSRrxzsCTsDA2tflMXNe/xnQ?=
 =?us-ascii?Q?TdpMnIUx8dZId/N+owlBLiKzFJvEyQYQgGS48f+sDcZWhuRp+LyZ5+NQWAL/?=
 =?us-ascii?Q?wr9QwBA2thta4HawL0JDa6JqBXnsL2uorvgBj5nIBN62Yyi4zkq9cYec/PZi?=
 =?us-ascii?Q?HgwjF1tYF+vNPeVw6PNVUEv7TQ3MkyB591LGtC0xfRa3PorKFCK0x/s+RHa0?=
 =?us-ascii?Q?2l5HfFWA94p/3EPcJWNhgzJGeLSMEYyb8Wg7TgyXLb/v3r8Jf/W6rPNlrsnK?=
 =?us-ascii?Q?bLj4Hi526yLvRh/74U0ogODtF59Wljczd/b0mhP5o7uX5vZuYrNWVz4yylwy?=
 =?us-ascii?Q?IlMQWWjeQKuoq3bDQerWBGa4hxlxwGKy0aGP4SAKjKRt92j/TH97TtaVZCIt?=
 =?us-ascii?Q?Pd3vwO7sO1hnTuvBepLtkakjrgbkikE/zJBPLs7izh1LXgzlrTEVhBIU0PR1?=
 =?us-ascii?Q?dqs1BUxQcKPgH72nigysAuLLoGaW3tnrn6nEJehIjZeMIB802CB7pjwQ6lrc?=
 =?us-ascii?Q?iEZXaecjWtIODPtPpIvlc/z/tS4b44ZjK39bXW3zce47p3aUVw0jsQEXivNM?=
 =?us-ascii?Q?XS8sy80c1GCXAwbsDE/wXUeRxvT55wPa4Wy+9D9MCJcv60BGLH7JW0OF4nHi?=
 =?us-ascii?Q?Rk3/Y00aoa9pJgn+rKymAf96yqNqtMBCCAcU2f4OTNyNNEDj8xw3dHIT8/0M?=
 =?us-ascii?Q?gB0dXTbfVmejPuKulxmakrCerrxnv4T50Lilop7OoPGwpYlMRjQta1i+sDpG?=
 =?us-ascii?Q?kK/S6jj6cuSQ3CdKMyedrSNOonYzQCQI0+r54W7gjkvEm8PrTdxSEI5YEdzh?=
 =?us-ascii?Q?vNdHr8HOAW726U8jJh8J0B/CT+XlxdssEwKB/blhEN1EeqLlAMAHBDHiLOMm?=
 =?us-ascii?Q?rBipR3+hXzyKxTEJlaX0wmCgY+sjRokkdMKjUJuTZ+XSMsmtl/Qa+bGpbd5P?=
 =?us-ascii?Q?AFJnm+ke907OUuO10f/AwqVUdODwiS6LVj2AT0+5lz8pEX2V8kxQwyfqsZJa?=
 =?us-ascii?Q?/6Itn3ZkaO2YGDcm1nQraynndMGJVSuyR3pWl9vciVm7Fd6BzZQHHcrjMMcl?=
 =?us-ascii?Q?jjbwR77etWYE+/rEhwlmpQVIQjsDNNtJN37sPc6KNhzH5qthoWomg3r+9TIr?=
 =?us-ascii?Q?fRdrzhZW+rlUlmk11XASMwyZngXsZC4IBJYo/Y+AOW1DGAR1zyJzkFpuTku0?=
 =?us-ascii?Q?1qyB+TDG919uHrXqS68ZdKwnqSGDDuh02HpJxxHN78bwxdpKWaeXp1s1bZZE?=
 =?us-ascii?Q?GGci+Xos5stVH756de8F+w3Dr2LBxkDI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hwgk76YS3WxXPJDUDNX35p1PboW+oVX0eJQTutKUjVKNlodYP/ar/Tgd8ifU?=
 =?us-ascii?Q?onYH2FsuuYN9dnERE+lCxJn86s5J5AP9qT8v/lCm/a8CCRXXeYV2qJvpXXZ5?=
 =?us-ascii?Q?WoP+PGjuLz6ulxiprVdKAOaYC/ZDi18bqxbSR3TSuEa8Jbg/8nYtc1t8y5vO?=
 =?us-ascii?Q?3JamMSBqhhW9TkQQfIWzvOCCWhSBK/tqqRGxZGwD6xSAiHFwYcDyDW8EoYz7?=
 =?us-ascii?Q?fwh+EN3zv5pFcnEuclnD1fG2mtp65qg97wl0ftWH69He7Hy8M2FuRkZ99YVY?=
 =?us-ascii?Q?UA1MoO0vj6Mis5r3olHGpCxiO30/Ks+mIa8Zqc7AJadqLCR9Q49xu1oLpzDC?=
 =?us-ascii?Q?62+n9aIMGXDFQ+TCS2dEmOcVZqAqw6ldy0xzHAJIx9p3zkrxFralKxI13ySG?=
 =?us-ascii?Q?1TKLGh2APdRhcc7NstoLzffeaiWHGo3ph3RcX1GWCjXC0dOWCWIhb7J3xScj?=
 =?us-ascii?Q?lWF9KFiRadZpy+pwwoZB2cVT2oxxqou6NSm8IwensPL9SqX3l9rfixzK5kNz?=
 =?us-ascii?Q?a2oprTRsdr89Rol+yJTwsi928V/7pXZoA43HYA70xY6X2Ts082pEeHOClM/x?=
 =?us-ascii?Q?RdON1ITLfakEd2+QxD+xiXG/Zm61zHUzh5FZXuGfuuMS3rOvVzYZco1X9rue?=
 =?us-ascii?Q?OZW/umdKHBINW9c+5OrazAvs71wDdiEbsVynFd+GwUvZV42376TxH0p6Mtbp?=
 =?us-ascii?Q?ByULOSvYuysWKRDpgIGzKCG/VjdH+amxT8qDrlv7vXWJtO+AoLv2120Wm6yK?=
 =?us-ascii?Q?LHBq6hQIdiJGdAwYbiaKKbO8aa34ugnxnpL/FGd3F6ShG7DpKSBXCSMe5A2+?=
 =?us-ascii?Q?LOn6/9PiYUzwmxCeLIqXRWHNMzN0VsPywtd0T5kRsFzck6KeqkDwyZUQ0Eno?=
 =?us-ascii?Q?WuLGuNjU6Pmzk/7l7rmlOgxqDFkjPjcE9BOW7WqG9EZiHsJi7ZUNursxo8IX?=
 =?us-ascii?Q?bgNr7wGXsdQXQKp4I00Ht5Ve/avuwJFYisLlUN+STxTMN6HTSBgtm1/S4Pp/?=
 =?us-ascii?Q?IYLUMgaAbxI6yqZsldFdVfgBpredjNprFViegCu1FoS49UgK+Ow1ONKvhm76?=
 =?us-ascii?Q?7uvpw4OLc2sKe5I9zRjU1uiDhhfmtKycFdKJfgxyY1bxR5Zx3TJ3Ubsm+uEY?=
 =?us-ascii?Q?dOKMYImQ20iGbaZ5UqUY4Dx4BdXMm2N0tSdKcFRpNQGpRpYtvsP18aUWVUtb?=
 =?us-ascii?Q?iEJWv8C+RA24Fg2brELW9XJ34/JziQpFCfPIMaNzb5YYc5JU77/IqxwT19HX?=
 =?us-ascii?Q?wMO0HW+JUgapOO7cqEFExUrnwWbNasdGrIgzKtYodaqaouSx3ScZdXFNgjEi?=
 =?us-ascii?Q?C4j4mMAtsF02FOSnsIvpHZbNI6bUmxQYihdAm8iugNpvyJdydTGXvZtjPwrb?=
 =?us-ascii?Q?JYsU04Qam69LwMh+TQmsWv/8Ynaq7qN4pRoubltmEyYNyyJcIe9iXaTsw6BV?=
 =?us-ascii?Q?H27bKe7cIGnHQFFN4kaDXD/nm5iswREGHED08OaUY5gZpRYcKZs3qF+TGkZS?=
 =?us-ascii?Q?QiozJw0POYndjOgO2slQTGPdJGgI9WhxhKH1XlyJVGLWbDxoYvRavo2aas31?=
 =?us-ascii?Q?PqEXNuLM1rwfm6rs5/6Eqq4AQ1btgEuHA3mPdEVIxjmyAVQMG7uzcQ58gI2a?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf551a-3ecf-4ba1-cbd0-08de0ff85f6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:47:36.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAc7XXqvG18qCwZpr4ANm4eOGfHo5Zvr0+DSIrzW4GnBE4WjxsLNPvHlhGFPDklrjE3fpQYGpw45beUkjctUKwjL2/kBw+8e1BgxcHqt2dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
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

On Mon, Oct 20, 2025 at 09:42:29AM -0700, Jeff Shaw wrote:
> This reverts commit af05f9e37153c53335938bcde2978a359c5f4efa.
> 
> A side effect of this patch is that it also counts frames which
> are dropped when the PF receives frames not destined for it when
> promiscuous mode is disabled.
> 
> Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D9606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GHPb+5xp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0593402B6;
	Fri, 23 Oct 2026 11:37:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 05BD340299
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792748254; x=1824284254;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BrWWwQbAMa1Fu/bFP9G5en5ayq20dHHHcVIZmxBeDIg=;
 b=GHPb+5xp1WPAcyyle9GFPcKr8dG0flib6xhUbcjulymx70gKCR2AoZwc
 JYYikSmUG461HPK/FXHqknyh9B+6Wn7ASLgNiiMbzrUm3X/xo/jCweRwN
 QoRq/fGvNWOgcB70hUJSj5BaCZr+r3594rYJFKExDWUtA+qPImeOq2UO+
 FXbtm1tg7qWMJ0iXufWbg5fEdCZpFCsIoFE0+l+RtoXUaPLGohE7lFQxd
 uw5S9/X1Abih1maiTN+XHKPkpSNSp2qQsCn5pdJmI5CFbIBGUca4oBJ5N
 InKJiRN0qhZWYcynMkzYcOkH2O272DKTCmzIDkBXM4dkPopf+MCxjKAtJ w==;
X-CSE-ConnectionGUID: 1RjX6NRYRNWWo9A3MrqtMA==
X-CSE-MsgGUID: felm8jLcQAuH57XcYF3ZMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1539241"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1539241"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:37:33 -0700
X-CSE-ConnectionGUID: fN4WaA3USkGR5yMRrBkpkQ==
X-CSE-MsgGUID: LWrCtfQ6QGioPLF3Yxwhhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3952017"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:37:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 02:37:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 02:37:31 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 02:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDvFtC62M/8iLns790eGP9yoNL0Xni2lnvtrsv7Ohddotthl8BFfn7oOjmBxa+qQiw5f5ujT8K7j/qTLQ7SPGrf5jeJvxStgdR74qD5ZXtuUa93IEbYQDbgspxBsLlnw6RtcXldX+YFagtrw/7PXr+Qm9PZqccx8zVADtFRaYBRsM/CSjmUEH/UcWkHV1P4F5plRazc8w8Ig34ORUH2UO+ViSjme8y+SwET/+8yBaJMHSyDP84KskpFnT7TmlT+K7mSuHJcVq911mK7nMm47tKxmvenJ6xDKSLuBjlL8g63QOHmYFnZBM9K4A78w3+1RQRI76F32VpAyHMKv/Bn/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXGmtXEGHHKBtdzhkWk/83iwFupNX16RAdbCVpZQ0vA=;
 b=o67VBFRlBdMIIHWbMu9L4usAcqJ62Stb3TYJGIHy4dyjZJ8Dscbuwe/omf0tN/m5BmXDSrBWSZhDZjRCv01RDDJPt/dcoRmxqvFri4AoPac5DlYwIdBqgo/gEoUa7R8u5gi5RqwXeF0n1Smc6IQILsuxuHmRJsEx+hEDlOXA9cfKTiLhFdoPrQjKOKIlYIp4EfJZDozOfCRZFl7V/CUt2QcxOutStSEaanov++jqBBTufp98NTh935IVtDr8/0N+iZ8AYX1t2RM21t3EyDYpnLsRkMqet+sqEX/H8rCuIZIeGfTmARqLBoYPcmVLLzyDqeSnn+ddd2bTwVYoN8caUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA0PR11MB7305.namprd11.prod.outlook.com (2603:10b6:208:439::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:37:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 09:37:27 +0000
Date: Fri, 23 Oct 2026 10:37:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Ting Xu
 <ting.xu@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: Re: [PATCH v5 04/10] net/iavf: fix memory leaks around IRQ resources
Message-ID: <atsq0gXTDdVtG-fe@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792747916.git.anatoly.burakov@intel.com>
 <cover.1792747916.git.anatoly.burakov@intel.com>
 <a97d124a185df54bb9e4b9def2866bb3086a4692.1792747917.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a97d124a185df54bb9e4b9def2866bb3086a4692.1792747917.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA0PR11MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 078f1d4c-55a5-459c-dd94-08df30e94063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261022075727099003|56012099006|4143699003|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: DqpOcvccvgA4/C0MzWI1IGLpSJ33o45P6H8WIGaMme+F4smzvjDpzUytbbMw07yGGp9WGYWXdOaSAqco830EdbPAzlWM9hzLhKOA1se2n0rDGX90Ypjs+C4BlVjJCiZPCl2LC9qhm1SPY9vE/Nl7cbtiMnMT99q/ucm3ZTkimvsnUGoatJ6WO3KJLh3sco/DQcMopWi3pTo2cB7SIBAurdipl61qoi6CUgHMo6sNp0JgCKJnlyt1fgO+9bVZ3pLe9hqpatllrzs9nMYoJWTXoKw06+wj38rAt+rTfQXmZW1KAxtuIATVLxKJuX9RwGq6UfeTonYSDmXrDI3n8JNvtFxmX1UN5oppQHu6qoaddi06DOnV9WckfEJOJnONhcbImMHkZxlltjHQUBA+PTkyde6/LzfZkFioYI1QTJ1lBFYFaB52pFAjbFu5EPDtudHRDD1eKjZhmzq+xuV2ibiMakC1Bl/EAiKsERwcskRwJwrXsfkrH8hEAqJ3cLEPnsiFU/+cgv/Bd8cS+M/IC2MRkBwoPLc2XC8nS9rs83a/Le6YVsUW5S9yU36obY39UsxszMqEcdC/dfj1LSwGkIYMJT6LFIw/s14k+SAHnO0+YXc/HaASLcu+VcdpqXkPy2Csz3ZznptXjNrgAZSe7d9gB5ycNCqkCPcNExCuPwW5Nsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tIUDW75KmeM90ZZ+pJQf+gm1F+onMxyW60LNmXslFEZ0Z054UDMEEGyey3fv?=
 =?us-ascii?Q?5up+RG2Drqvvyh9KQbi5NksWEmPI5bfsQedSqaB8vxV5igdSE0o3AHyEm2fC?=
 =?us-ascii?Q?mZfEDsPmitPgdXC/WJen97ktfQGR6F4MdtCGXLq3lzI295XGydsdRnU5rpls?=
 =?us-ascii?Q?YB6y/M9dssriJLWD86FHCJ14NSFWHDYAuqy/P8PCYX62FTr3Q7E9CucVaCpG?=
 =?us-ascii?Q?Tbxy1VCxWHZZGxeqHKL6lOTLQlzn0UC6A1E9YPV0I7fSa8BzGRJBsMhyf1BU?=
 =?us-ascii?Q?F+SHH58xs4hu0aaylvPWhQh5+jH8YlYH3RQWJiFLwxB7kPRld7JiJIbmLzaI?=
 =?us-ascii?Q?x1Hs5qnC9NZF7W1Aq63x/rqtk0n/3jzpkEzIIhw/5mq+n2t7PEmx2WQcrNys?=
 =?us-ascii?Q?6+EbcBqyJtoWrpT6IO1d8jHxzzM+m/kY0vxX2RMv1ohRd6Lbzsf/XZxXZDcJ?=
 =?us-ascii?Q?VtQONPbQKF+W5hKtA2oHK8nZmMrGMB1rjbTxfufBmX3mEbeF+S9cIav2CIpf?=
 =?us-ascii?Q?d2va0SPHDC8Yk+KrnFNGSa+DNXDP0aXzFcZxyEM2oyhrtUSLLB/csAyVsJ1l?=
 =?us-ascii?Q?KxJ01BWV2XbRXGjbIPrgjt8//6TgT6aGGmSs4hymDS68X2IHhCBhOEKcG3lR?=
 =?us-ascii?Q?imH4GHo+6rB6DO9dDD+I96RKka/vVNtkNm2cNVrauHzQDfn4T7cFs9vdUlP5?=
 =?us-ascii?Q?hwAVchw838NmbqNXTNj4zyMM/v26n7DFvrfkO13ZjuSyvtn8QSfs5XWH+loi?=
 =?us-ascii?Q?Ov+maTB9pZEimzhb946B7ctzD1wEyV0AqU3bT49M7S08P1nyRnku5Co1ocM3?=
 =?us-ascii?Q?+V6+d9uQuv/cZV7FU3Vkeo8pWgRq3WWr2xv3ED3T2PKbo7/ulQMjLA3GrFHk?=
 =?us-ascii?Q?c6oBvARZHJ2tYh97HR+WGitM3C5Bx/JAxpjdS8EA9JVFkzPjazKGWJxmfZxh?=
 =?us-ascii?Q?VcAgEVRpelqqKAuSl4OdmTTZNjRgnFaZBM1yOdNZfabblp7jId0C9q47H/Cf?=
 =?us-ascii?Q?vnCtzfeJCmpNB2gMWESgW8zMKmt9yZqpk1EUTptbqB9q1Ys4HoSBwaOo/DYX?=
 =?us-ascii?Q?JgoBkyU8ntzUdSARBgmXv6v6eiE5UJMYmlTT9CZEddRREaVaXiY/3RMpMLiO?=
 =?us-ascii?Q?XppnLcj55TLI/Crh3G5mtgh5VoAkep6fxm4sNQkrpc1Dkwk3fLpSI98K71bP?=
 =?us-ascii?Q?h5ghNW4EPnuUp8EgRuRjk3tMwFLDZwy0yc+G7SfieSSKD5jRoFIlvUKtptgv?=
 =?us-ascii?Q?MQOUbJJicgi8sDpLXjspEp+jrZPPpc/ndYceUI6/36/l5zbFXsLgPeaJGTd4?=
 =?us-ascii?Q?Ve4D01jKSiJ+tO/BQt304iEpmJrjuqkIGAmP26kiGoVYF8m8IyT+wcadIevh?=
 =?us-ascii?Q?3TyH0lr3OYGjs01L90SKKS/5WmyY3CVOguz0r5tWMfOWekjbrglTZ6Ix/KMB?=
 =?us-ascii?Q?y1EM3TWYEUcgws83CJOejqQLhMLe1DniQGyi/5ti25wMVfeez5Zf80Bi1/S2?=
 =?us-ascii?Q?r9sHdQc1tmZ26tgd5ksX4lmbBVudDXJ881jDlLuYckQ2eDbSd/f7NYnI+xaC?=
 =?us-ascii?Q?TxZctD1roEObQBDD9HX7TcCtRYaHiwZ6nKMwKUnG2LpOgAB6DOZ5hvOT90K5?=
 =?us-ascii?Q?Gwo6aG+kgACrxU2d426p+lIJsRTiN1Jpc32lh65JjfvEOAKWrnfwprocMiNU?=
 =?us-ascii?Q?n7z008tR0ehgyK6wsErSe1+tgfwlL0oP8PBjRuw2Tv2wwaC+NDCemXgCIPbP?=
 =?us-ascii?Q?A7j3vtDiU3+0HJdC6tXdNg6HeV6yuKw=3D?=
X-Exchange-RoutingPolicyChecked: u76l2FS+Enm+SO0Swn5EkYoyJeC3zl765/QIlWpZCfhh3yLJENlpW1JDCTIAoYWqBF6YFkAp+tHpDmOL6hoRuBHk5d/s17E3Byr1U00i3DZeaFyAPaYs0zY8FV/eX8mNQixj7yZZIpH9hyPcI6jepRyYCbC8P7hzR/emOb6xZ92SaiHZYTMIZ/UO/zpimb4E8Lj44xqEQzd2b8fmH7iyTIznCmpDCLOoymG7fe29t4s3XvUwpPB+ycn3cPj8pgi9YDCNObg8aG/ZLZPQ28IL887Xc/F7UE4cHVpc2TQlkMlf1sBTEkjAX0tYWf/TKG31KR1zGPx9wlxWC9LGA6YqPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 078f1d4c-55a5-459c-dd94-08df30e94063
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:37:27.7204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdULFeFmxKhC2wIaDT7g0DtrSuUpK4JXn2GiBkrsuwmwteLMyY0NC26mAIs1su2yMMrD0hvB1KaAulVNG+z8Ehaj1Ma9M9hqgnOLnHpYvXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7305
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 10:32:24AM +0100, Anatoly Burakov wrote:
> `iavf_config_rx_queues_irqs()` allocates a queue-vector map and may
> enable eventfds and allocate an interrupt vector list. If queue startup
> then fails, those resources remain allocated. The queue-vector map is
> also retained after a normal stop, leaking it across start/stop cycles.
> 
> Release the resources on failed startup and free the queue-vector map
> on stop.
> 
> Fixes: f593944fc988 ("net/iavf: enable IRQ mapping configuration for large VF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

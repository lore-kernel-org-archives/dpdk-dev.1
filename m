Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F35CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 16:08:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13629402AC;
	Tue, 26 May 2026 18:08:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D03A740290
 for <dev@dpdk.org>; Tue, 26 May 2026 18:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779811727; x=1811347727;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pZe8jdZIGzQYklbLtNNpvLD+HmB3EdqKzDsEwCBBzyY=;
 b=D0g6iCtr502V6ttVvmuXubYkhsF7LrXTTYn73yuVqBJMA7aV/48Ik0EE
 cszbSwKQbED3IMNkUgrXCu7n591v6HijVoUQhwzgmyNHpL71v+RZ6TeNF
 pfDvk2f5+Q03x89I5gfWbrGArFtxVkGt31DhmP0OjHwd4tbulG1RzxnPR
 cecKrb9sJeRhvmRazyXc7bCMWWxLLaIMft7IFAvSmhcSks/D67+0gZvEP
 kjti5aq2C0SU55qs2Q6HaZpOJzTpTMHGHOCc2RSxPSxMBfDuYI6G9N9zA
 Qpk7nOI0RAh44BnGtLJISgj5Ll+RvEMI3LnJMzpAcgqw+cwTWTm5/31lt w==;
X-CSE-ConnectionGUID: H0a2I7h7QOyL8r0S6qN8uw==
X-CSE-MsgGUID: pnkrl88RRK2LqMmKoCzBFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="106087784"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="106087784"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:08:46 -0700
X-CSE-ConnectionGUID: I5gGLzeQQfKdROmi//Szeg==
X-CSE-MsgGUID: YzySin0lTUi6oszpSmKPGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="239354375"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:08:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:08:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 09:08:45 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:08:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JawuGtwSthIEcGSq1Wdxn3J6szq+ofd5cUIfFhg1QIgiTUMzZGxN0TjlkGlSiHY2sPbdsImPAZ+r02m/IBowTv9tO0pfg1udmadJENbMCk7ucwIH6AIlMeB3QyCaiMlbbTJBXkSHZnBA+fnlQlKmIebRwblJIKjC/s3FXcG6kI7nG0Ho1eqgirzx+8ekqkI8PIB27pLOErg5DgxYgtzmvuXEeSk6cBlz2K1bdkxDyl4vT7ewHDzbOWm6C5csXjEj9uD6MbYg3MjSkkEaAC27ZsadNiEoGyw7DrOyBYa5LEm6LUo8pf75QcsoKLVKJ4EKBnfwrdKGCNwqAN24W5egog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wlYrO+mDuugOV2GIjEXKsgL7Tux2bqtsT6vLEGt8b8=;
 b=JvD9l0yf1xb9lzWPvrfeAoa/FzXSDi4hFt+aVdYSKK/Ojy8u80SwBFChHobnBcns0K1PYTEihWN+AYuJ0zHX2Yw5Tsw5FPeak9qYCB8WkeEVeCfz0h6v4vrnp1Hy0lbzFoDw5PGDAHuhaRSm19wzLyFoKtoZvc0qWCZ17ibslg2LkRS6uE9x27qtulx+tVV6Qs5dbOPYrFogEUqi2QKWKkuXs0Uk87syWIywAaemcWArB0B4BMiApOk4IileLlCL7/zhFq6046QdxIFqEyLGneP7C98WBydyn4NmvjgenDHaHTkPApZUTGhMBnv2hNCzcGLRjTDlvqordfUz4Q4qSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 16:08:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:08:37 +0000
Date: Tue, 26 May 2026 17:08:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v2 5/6] eal/memory: store default segment limits in config
Message-ID: <ahXFgH0wLr17tPJs@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <4b4aa7b43e8354f5ae325e634c88e4e649707be5.1773417833.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b4aa7b43e8354f5ae325e634c88e4e649707be5.1773417833.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0251.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af54f41-7557-4028-8cae-08debb410b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: JacaMakBHqgJD2McVbnmajiQ4+0tXJ4jl7H0LDab3ELm08lowNlmvgA5sw8HQzGi7w9sYv9ewZXJVGO7dWUrRqRxAOb7HQI3lPKNUnivq7y23uarxt/eax0tfvbhX43kBrivBJ7Umjf6YAyV5fOKpubsMizcngI++cFDBykFACDac5ek4qbvB8srEWAfq2I75QnI1DA8GWzTWBQ/XK/Jxq3FGBevp/bkE664BzWBEpIc1QyyYEwCABMGD7AEfeqKBZywii8iawMrAJOc33b9NbEUZ6I198MVoe3pEuh6i+UmykeK6QkL+Q2U6t+FYifKVFEE5KhPenWZc3POBfcvxdrMF+48DjG2vRoxOMEHGulKFbp37LUOTr+7QEEbNNA5Z1bw1DrWwRgqYIDtbjVoj+H54dJN0DllHRQWT6MUeE/HZdKle36Ruejb5FAwN5nVKt1+HcAU1+dzy0uJ7qd06ePuyaykIv0dOtPj1d9WnRywp3fpFSHBJ5EYnybAflbIZJ3KeYEuzRiB9KxNE2uNmh/DLhEMZOjBW20tX2ZDCiX8BkZUUsrNkz5xE2y+Ja5NmwmOKMJwoRXArng07XjN2bWETzRGFp1BVPzHeH6cxHAy3pHVgJIjeMoST0j1+MoyxCzM1Xu2qXmHk1ut4k91f9T/M/WvsMxdSdbMfH9HWYsqFKr6DmVq6v6iVO6HfAhE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r94DNBIHv02nwnkXqI8X4D+6FvuD7j7x/GYsw30ZsGGQmdnFCLtxtA2j1TRp?=
 =?us-ascii?Q?LKSs6atJ72khd4S0m+z9lRdahnTETW8T/PnyLOTXcdUslY+U6+S0eseegsbw?=
 =?us-ascii?Q?X7PN5sdUa0i1n00w6BJE7QuMModtkxUkEQjm5gwkRNnoVAR7V76XOHSF/BjN?=
 =?us-ascii?Q?ZaeBI/9NFPUGqR27CBzqBiA/zZzLarQrTLKf+v5M47Z4wPF3EaFP1Hr85/GH?=
 =?us-ascii?Q?3UAWltiNPA72gMRWzvCawFig9gWTU9Xt1mXKDYgMl7LVmpSydYemCm2fZ/R1?=
 =?us-ascii?Q?TixUbrKx58scdBAPYPJxpexeMviiHfubz9be1Q/5fBjkN0jwhsogGDEJzy0p?=
 =?us-ascii?Q?/0hgt8qFX/OcTQ47w8MvaZb+TZzx17sJVlZqxTvOICyUKo6TjytD+Wg4eVWy?=
 =?us-ascii?Q?RcqJy+PLNQ/Nd96FHQ1/MbRBoOlgM/bjqcm7wGFNBJ+dIO3m7/k8LOrCShcj?=
 =?us-ascii?Q?CSPhF2GRTLAEQ8Sx0A74/TOWJWBKwAVPTkLAoydXTBBQbSHAHz1Dmf2Vq9tH?=
 =?us-ascii?Q?qXn2NceQpWhBU5HdDGcRTDqOcEiTNqXNS4mBueBQGB4LsuXtngHbDBXzox0T?=
 =?us-ascii?Q?BoXgmgFuT3lfB3CxdsJP1aIBgBdxeUlwSj847CbedllbvjOKNOt54uryJYap?=
 =?us-ascii?Q?IXJVkRop71BdPUMZP8G/yInQ02zK41eKmqbCpzdY54UBa1LVi59zyOll8wdf?=
 =?us-ascii?Q?CdGpKC/dX4FgUXf2U6ausiTfMuHv14nz3ZNwa2lGu2MS2toIFpIIZr5D9kqB?=
 =?us-ascii?Q?RSnbogqWsqrE889avgPAiAjQEqQ5wWSGXzdBBhSl1SqKbz0OsrgsWKtx6ni7?=
 =?us-ascii?Q?fjnSOmgvtSYOsPQKWgnVVP9cAyUYbO7ixaAuGnQqO0Fc1KQrY0wTBCiftpGH?=
 =?us-ascii?Q?Di7lboksF2S0Nsldy//PfwJWSjO7qtkLHLvudaDR6fOi0fKOLOD73rgC2eBN?=
 =?us-ascii?Q?/oAvW7ZazqmOJIr6ZfUXkBqQ3lmxk3o77aOtxP9X16HqKfemajSmwuDZMq0C?=
 =?us-ascii?Q?gg6FQV51tq01+GRCSIZ1ma7yDTAxkC+t+2JgVjKxO7fWTLEhyHNg1P2hinqO?=
 =?us-ascii?Q?gotAbQfpOnRCG9cNEiuoihHHwk5XyxNdzr+PKiTxqjalAdhAap/rDDDAScrZ?=
 =?us-ascii?Q?hU6IYoxfQ1P4cjfIB5S54RZIxSrx7yJfNNj6LrTu/chV4d1Q0HqUk+7D8bmf?=
 =?us-ascii?Q?TuiYeonVWFk0NghUacYj0sRLKaH3nzcgFxj9fIxkdA0HoMQpsh4F4Z9inWqB?=
 =?us-ascii?Q?7mw6owN/rscgxRbY2Kb3NupGjf0U7ndCT432RDLVzEyS1MudGabI1JImTrYU?=
 =?us-ascii?Q?lFdi0O9kAV0KhnI2DBqK75ehF+v4AmUGg0Nz2zWFkY96kKLuYbNYeiowWsHl?=
 =?us-ascii?Q?CSOUza876OhfOEYzBrXZQLbG2P9dY7PQVDsVu8/qxUu/036StECAwuV8ewRH?=
 =?us-ascii?Q?okv1QNmmFw3m9A1Ip/F36JzWy7wg7/s+znWAKNyAIDeHPK119urTxaf6UIZ+?=
 =?us-ascii?Q?PYawko5n8UnKtkK7xcxAMoJ/1xm0VEOWcsFRRQrmMj7W8GebFomIfrRof913?=
 =?us-ascii?Q?XVNDT6w1DsvMu3x0WI42aTy76orL6uO5+WKOv1EfHEDDdNHa9gyNezJgqWIQ?=
 =?us-ascii?Q?edxf7aB4GC5UXspSvWiuLoN01vN8OzkzEZ8bLgQe/7qeHQnOY6D3TgGwCy2R?=
 =?us-ascii?Q?afSX2nkdp9J8J1ag1102rMuUVhvpH22pM6hq0jgoTPgHtQs5i4FhWCcuamyP?=
 =?us-ascii?Q?/6FIZHKGWRKRUn1whLoAWQrhnPzqmAM=3D?=
X-Exchange-RoutingPolicyChecked: hbs6IIYCZnBKxEOiS/cAeU1eqhxPWqwXdiZbxF+7n5pHZ6R4h5/pc1STS+y9UkCEFmBmE745Yaxf9Rxnd4fIQP5uoA/uVNQiKo6zANz+76UwNi+UdtlqOtkqjXBZXS+/PbVnx69wNbz3yBTIFb/3Fuariw//8Y2CXblY+J23QtroSQG2gd4kFH5/65frxEO6wDuWoNJnjREn8Ze2aFkIGI5Sb/mXPFQO+2IhuW3eudf5ucbcEijBYq0r2mnDNUqiCz7Tg5ek+8tcw0vlS1reEZLY/7/82dQjLSiP87VAfmIdpeVEQ2PngP+1/IYeDsbVh3sT0Bxb0C+D5nyJq0SXXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af54f41-7557-4028-8cae-08debb410b47
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:08:37.1113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LoQUgXT7FxG7/SShF8DSdBFXj/GNepSi/WtmuBx5fcExntkaC6XDHt98RvTXO+jtEm7Zf6O5RnI/9zfRVJeTv1XsJ1Uyh6A4+RozfFtqOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
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

On Fri, Mar 13, 2026 at 04:06:36PM +0000, Anatoly Burakov wrote:
> Currently, VA space allocation is regulated by two constants picked up from
> config - max memseg per list, and max memory per list. In preparation for
> these limits being dynamic, add a per-page-size limit value in config,
> populate that value from these defaults at init time, and adjust the code
> to only refer to the mem limits from internal config.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

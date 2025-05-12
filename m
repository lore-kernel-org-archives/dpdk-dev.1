Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3230DC3ABCB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 16:19:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 205614026C;
	Mon, 12 May 2025 18:19:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 474B64025F
 for <dev@dpdk.org>; Mon, 12 May 2025 18:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747066781; x=1778602781;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7Dm+Y6V1tU8FT4mx8ymGbtRd3RWvhtPzD8ml2JdtxNU=;
 b=GV8v8FdhrIYNtTRzPD1UFMZ94Df5UM/vBB838oBY07iZab7szCB8LjeN
 jitX87Y39k/lkeylQkv3MSsuZ/cfqcbg+EBb6MVb0LcB23hTpxLnIm9DK
 hAiX9gfCTRzoW3wvDIitvdcz69oUZaNtSRBSJgA4gvcdoErsyKeFz0T8y
 X1WQ8v7TQtE5dFBJPhtSpllsoqTfjOm/oQKqEhzFHE7OFG6YVpRBcQ1PP
 EidLDmm4mL8PorQW0fz9eYmSf4/W2/a2xuE6i2Mz8h0b6U8MauyS+TzCL
 6dBBIKQ0dcYJtzCo+b2ZZZCwi342bddDSYroi6UBZbVBIN+UBB7nNgjGY w==;
X-CSE-ConnectionGUID: wXEY/fjaTIC2/ZOsPr5jdQ==
X-CSE-MsgGUID: CDOrlKiwQFeuz5rExRlo3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66282462"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="66282462"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 09:19:40 -0700
X-CSE-ConnectionGUID: hGC7LcniR1WI31waTyDvbg==
X-CSE-MsgGUID: s2h0vT6sT+mECkH/i0vgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="142294774"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 09:19:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 09:19:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 09:19:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 09:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdOJEONXegf8doCsKh9Grx5uuGXO5XGR3wSl/FhgZWxYk3/mlFichQ5LOmjOCg0cOiMZGpNz0Yk+TOo9QZZyMzsda1W9AlGudw9P/mY5sqVnU3wDPYYh2toj+dYgLWXgKdVwJejQiTlYNtIagROepk3oEkFsa7PqnfpYG7/+ABbdg7wMU4sOvYKtfEr+BtQ6PmN57woR3kR7I9V+TL0buSrS2VP+tIu9ux64x4BCmvOKNkflXyHjgDEDgp+AjhQk90aVMsE6dtZV4IbJfT4LAAQQbEFUyuTKf+rXhgDFi9MR8/Ke4Sgjd5H/rxNOhyvMSdWJzYsLr2bd0zFqiETUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pixiSSSx0f8PthlzAllDNYcPgvizPvuF0kVBzy1yszs=;
 b=W5eotnCX/wao7070duQQzeKXbCBU/YRS1aIhRRbI9IPeFA/Aa1a4b3SLTZ4iJhmkJtVDjo7pSR3XzOlVNG9UL+MWteuuV48PZklWMqT2dORTx2HAAXxiZ18V2xr5rqkwF8cxC5MQJd+HrH5l4j3ogizEeKgct/uH8RQk4guGeHacs2HpfRdQAjYUCag5uCmVtQlIi3iadMfnF6UYE0ENjB46WEYscOPoIQEmWqb+3wotLN1Wga3IuNXU34uMONMZiSj3Lrz/pTpqe8o2i5gF425R7qExMNSau/63M0SUOTWSH4IdEwlbc/bs7QZTjNq/S4L5ZIdqzPcz2njB9CxPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:19:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:19:37 +0000
Date: Mon, 12 May 2025 17:19:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: LukeSeewald <luke.seewald@gmail.com>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <luke@aterlo.com>
Subject: Re: [PATCH] net/ice: enlarge limits to 64 bits (ice_stats_get)
Message-ID: <aCIflUH48vRmVE01@bricha3-mobl1.ger.corp.intel.com>
References: <20250403135041.1377720-1-luke.seewald@gmail.com>
 <aCIcBLJyohs6H3gh@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aCIcBLJyohs6H3gh@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW6PR11MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 346f2848-f4ba-4eaf-7e40-08dd9170ca58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cIKKIitM+vLkIV2ckgGAAGd0ReVSJNIEI5ZPNfMLFx7vAFW3We50EYqqYUlf?=
 =?us-ascii?Q?9ARoGP9dHhxaQSY5KnMLYeKyMmF0AuDkICGOsV26CtgarhApzGBCIhdiu/ze?=
 =?us-ascii?Q?57kfhF5PEQ7SjE8n1MhHX1IQ+qscl8uq2KKIMGyx643rf0XV6EMrTI/YowQw?=
 =?us-ascii?Q?T/p7DptfoPf08mmPmQkMEgoLsUC7QDlGPxnU67uPMvj4OXRHpEVMfwfPk3DO?=
 =?us-ascii?Q?avnXhASzduW7/9Mrep5uMKw9G0UYhpPZ3QXq/iZqsNBdZ7bbd21NjA5SsugS?=
 =?us-ascii?Q?ANQGXP2P15o3F6Dj3krsqunWAKoghVcgq4+CYIUA4a1FBpPP5CRA9yxdERtF?=
 =?us-ascii?Q?Y3N4gjCus377Xn6qOd9+Mgi+ohg8hWENxYqnkUjdAJ9Pp+kZ8s5V+sWPt9/W?=
 =?us-ascii?Q?mglB3DYj/GsGMKRJQmlWIX4M/2Nf3HWL2tF2nh9z/yrsBGtgYQ5kLaNERrfW?=
 =?us-ascii?Q?muKKSzU5IZ7wDlQ10wXjDBBMrInyqh97ffzu1Lp/BQpQDDVW6qRnP7EpvuKL?=
 =?us-ascii?Q?32ksIxqkiPMZkygApp+goVJBwsea0BkOnDeTzGROGJY/7K3+vXS4Qn6lMuAv?=
 =?us-ascii?Q?cA75cH8FMGzvB59gRu3KFx6zpp9Do8wBj8ZOlzRXecHvaG44P72xSaLRrqJw?=
 =?us-ascii?Q?YPxtQc4l8yMRd6ECyLDmsO8WnOYCMY3BldqS2554siI0FF7fExutihAZyvTx?=
 =?us-ascii?Q?RLfG/ZUSkrcjELuByB+0Zq3/veOgIduUCDYiFW5N49orUo9jfF01mSDNJRjf?=
 =?us-ascii?Q?y2ewcriFtMeTLdpJosEXeHPW/nazqCEb8KmHYvyZ679SOV8oA6BynB5+arxq?=
 =?us-ascii?Q?S4p/ZXTFumoWTmslWvhv2zPWssxlZdpCVpqezTAhhW4szkkeLEbistbyIrE6?=
 =?us-ascii?Q?hvs2lUvLaeDqLDcRuwBnjqjQyUjrqNglcvIdWtNL0YyBy/b2us7bVGT1b0h2?=
 =?us-ascii?Q?/BoXje4qmg/SKYkmy5vhmZJuLcc3fJbrkjmu2d4EL3w5wweGwqW41MURGU5t?=
 =?us-ascii?Q?xl9Ow5c5y98r2lZeayY2DMuhc7SGl2S6igkmwB+mi4fz6GOdtBq72cnDkqDJ?=
 =?us-ascii?Q?zeEqdJ5QnN0/YSdgX9/gbb/391m9dhNtCrQzzsuSZiy5vtmaN+B0U5aek88Y?=
 =?us-ascii?Q?NQ2ovs7NizdBiqHEmFmCuuUpIg8lWd23xZkoco1cGS1TWc24scis+kNTHZer?=
 =?us-ascii?Q?qi7gYwGhE95MapjKDx+1NMdQzs49GADa3Le6P1QIxmmnrQWibff/e/x6L0vo?=
 =?us-ascii?Q?inLL8AcbkbBiPTPcAPIn/V+tIYvW+TnvAOkSaHzJQDkC5F/Kt+9MnVFV7QCL?=
 =?us-ascii?Q?uNM0AZ9UZskkNPQG0X4nRU+FpHylKtGqADmX//l2NzGXzUbQw0LkNwja5cGP?=
 =?us-ascii?Q?sC6yO+Z1jrYsPvP0SAYU0upH1RGFc0wjrSkaZ7Ffu+Q1m22IvfLl3LD6+XBO?=
 =?us-ascii?Q?i5s7631vpUo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKjLEvKAzkShwcAGmK6WgS18eSB6jZaT1aT+6d0LMobj+pT0t4MYVS/rA3aa?=
 =?us-ascii?Q?kXo14AQl1mxkoWjtwiKxIwgrjSA2Agc0Wh3RSM7cROqjj8+1egtecjvzwLdD?=
 =?us-ascii?Q?eh7+ebKbej7wc6fWy5wKlpnEOqfnNg/n81RRo80AWYg2wM8Wxs9rHKL1yeDs?=
 =?us-ascii?Q?TL2tURSLQt+RSEzyyPrrnGySVdIFjgPlSNw/ezZhK+pv5ZoDJUNeBLfK8DU/?=
 =?us-ascii?Q?HeEdotwh3T4osfkP8rCxbctH9QQjVb2BW9Vt7lnAysKqK24CV0usYiVYtGeL?=
 =?us-ascii?Q?ozswAgdHOT4j+D9s24FGYUoU0lJyqzxWqrSmUPwAHEvYWiPVaEjztY1aU8gn?=
 =?us-ascii?Q?DZv1ScuWpfey2WLlTz7kMFV9jfLhLdoI6+G73akO79NyjYm2g7JCFkvoDwyU?=
 =?us-ascii?Q?PcRXEn7kAGJMYTzv8E8dlXI6BCKKxVX6oKuVY3/W9APW47/7MfMLMHPCLkZk?=
 =?us-ascii?Q?qpx1Johj3zrpUiOqPtnw0AxzxsN5wrKysR2ZRfRWWXg0cj1gDTDkxdMnm0ck?=
 =?us-ascii?Q?/MlXOOt+/PgbDSkCVIeGeJy8iywGcrVTeE/PpcIZri2OJxtgkIhlV4r7CeMD?=
 =?us-ascii?Q?mHUgNfrPtHQPRjWjmbO9x0nqZ2IZU0A3jgg/vkSDUWuwljEbWwdX4m1SBqSO?=
 =?us-ascii?Q?1EKy/k3gv4NpAOKzzf2jL/IQmjYwRqF+WR7mJ04p/ZssKfTOP8dRIxazlKV+?=
 =?us-ascii?Q?Zk8b5y9CPErTLIdxlK7lhT88ZadQEDgr+4xnop90win8vnq54gK1/GXVeUhI?=
 =?us-ascii?Q?hcDKRi3IX87QHg1LvKQ2oDmx7XPek7RS1roiAhd1gpuf9PMlm/3gI/f0//Ll?=
 =?us-ascii?Q?wcXJqh2V9uQwEdxnaPSNtUOYFaN5cA11z/pi/uFOLxDhrUBjywcblYjryTxX?=
 =?us-ascii?Q?RHNXPMBVxAygo8UkyxgM+YVgGcm6LAUe9O6OMExTNCPdBi7hmU02LZ5Gd2RS?=
 =?us-ascii?Q?Ikag1go3S9PF32DWJDpBjGPEJpMxnKztGLkmXmYxADWoliVBzPIf40rCOz0k?=
 =?us-ascii?Q?s+XtEPFPiBMpvnE62okPone/uKjNySj5DPAynEKIvt/qmhguGF0KgEpUFj1D?=
 =?us-ascii?Q?rLbV1F429wHH3uRBbEdwWLcypvLeb3xjkgp219SyyVWtwl/EqZB0c9xAl5e+?=
 =?us-ascii?Q?OyxfaT6QFQNRwa5LiFcuiranwwicYnv1HW3rmL+srgs/VWW7/ksvfdQC3UAo?=
 =?us-ascii?Q?w012gdtbPXZwrU3W053PMgZvI2DhVJybPbPw6taODmDKyPB/01mPF66ESEfX?=
 =?us-ascii?Q?+FS0fghk/zCZWQmBcv+/81OXAv/9sSBqPB9ZqiMsY54o/wREDqdQ5k0P/U8x?=
 =?us-ascii?Q?LoQPWSPuAzQONoQMRee8N9HRbxW4uOjRYrZhi3R5lfS/huTYQKCgC+JAXssI?=
 =?us-ascii?Q?72ncUw8bx6+TOcSGFGra/GxAWGtqtCD6//wV7vjpKKPF7Eru9I6e2quSQr2j?=
 =?us-ascii?Q?2MbAz0PPl9GmA1+w0TYu+Rrkc3ibDmP26HfQ6/nviR4RipdIqzIa1l9eLpHd?=
 =?us-ascii?Q?gBHQ1sMcdAezIDGSL6MJEdSZkqvxSSaG8zAicwadX8PeZ3+SkkH1yzM/5cQe?=
 =?us-ascii?Q?0DaNCDyvUFKKp+O71+27LNSYArbcv8iFiiLJvlKL7Rp2fSF5F/50ggggGTMG?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 346f2848-f4ba-4eaf-7e40-08dd9170ca58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:19:37.6236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Buvvq96E3BDj6PdSebmvtYZvF3FOvraRTYTMMZRxPlhtkFA6IKk+aG79GxOIDoxE/kEFeIVtC6FU/g46b8j8jkdc3R4s3uGZvreOS2OrH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
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

On Mon, May 12, 2025 at 05:04:20PM +0100, Bruce Richardson wrote:
> On Thu, Apr 03, 2025 at 09:50:41AM -0400, LukeSeewald wrote:
> > There are various counters/stats coming from ice_stats_get that appear
> > to only use 32 or 40 bits and once it hits that limit it "overflows"
> > and resets. This was causing large spikes (sudden 2^42 increase from
> > one second to the next) in values of ibytes and obytes, while causing
> > sudden drops in opackets and ipackets (as they "overflow" and reset).
> > The sudden spike in bytes is due to the packets count being multiplied
> > by 4 (crc bytes) and subtracted from the byte count. E.g. One second
> > the packet count could be just under the 40 bit limit, subtracting a
> > very large number from the byte count and then in the next second hit
> > the limit, "overflow" and reset subtracting a very small number, thus
> > causing the byte counts to appear as if there was a large increase in a
> > single second.
> > 
> > This patch fixes the issue by enlarging the limitations of any counters
> > or stats used by ice_stats_get to 64 bits, following the pattern of a
> > previous patch -
> > https://mails.dpdk.org/archives/stable/2020-July/023940.html
> > 
> > Signed-off-by: LukeSeewald <luke.seewald@gmail.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c | 103 +++++++++++++++++++++--------
> >  drivers/net/intel/ice/ice_ethdev.h |  44 ++++++++++--
> >  2 files changed, 115 insertions(+), 32 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel.
Thanks,
/Bruce

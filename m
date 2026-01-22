Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D413D3EE72
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 14:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04DF94027A;
	Thu, 22 Jan 2026 15:59:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D8DFC4021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 15:59:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769093972; x=1800629972;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wwSoVm/AUnqHfaPcQvE8EoPLWdenklCiJQaSTY/7xk4=;
 b=eHa0COz/c6ZPKO4ZV8aRgCSgpt/2NWjYw0ZcWSzl9J58rpD6UiEarJHN
 HPlIK5HL/5iiFN6ZaPTCbYUpNbzsnfp8RB2TM295Un9N8px3YHACQVleK
 iG2ufNXuXwX3oJgibBM9j4eiKHoV+sWDC1WBSoDaDIywgvJGfAAetLaRE
 fUu/vFukWCQ7twI0tTT053W31tcfGiqkY09DK4e2NQ7xEfLcER2WKlVOZ
 aTqbRELYYLfGL/RW9NaLARPtuujsPPWPh9xkrsZJ7GH6KZElFQeaa5jqd
 iMXhE1k7rBFjqINGZwXkJgVYDlIFPD8XOTvFF/ugLivlmdfFrBjeS1qxw A==;
X-CSE-ConnectionGUID: iEUzuG8LT2mNlAopVJFZjQ==
X-CSE-MsgGUID: vb1JpoG5SJCsVChNjSpqsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70250747"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="70250747"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 06:59:30 -0800
X-CSE-ConnectionGUID: idYGj1xPR/ClJiJeRr7u/A==
X-CSE-MsgGUID: xg1kt45/RrWAhxkSmARg6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="206571260"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 06:59:29 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 06:59:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 06:59:28 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 06:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZCQ3tBj+Q0y+RNXnJpb1Q7WHqwPFPJMorpFVSxwL33HrNkSVNcH8FRKwKKNRxeOUa0pKBNiJbUsjw/V4BKoteH1HhoPmvv6KvxGfAfIK7eZXqQR/F/ql98I2ZbBRyAMR8USrq+/Dse/vI936JtNGOCPKJ72oNkYGfksg2wKXHQOIU19YuAaFMJkomtKWVBWeaqW5G90GQRrP+oIAk9Luxv3Hmm4Wz3bWtnzJmUYO5nB9gzYM6d/3/EcJMg2go1PyGHnLBijfbVU5+m4NcfuyIK3ZBk58cwX66TW1sCtNjhvxZGOgivfs4lNTL5eF191bKfJvilDa+ZKTXr/zBwahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsJFoVLVhty7c1lWRGID9wkY0xhJl36tetDVbi4P+9k=;
 b=eaxsthdbEvCThk8WZiy9eHS621z3E7d/pFyiORw+TVsuvn+Jy+qpU7X72ZVp3A3+lh0O3bHDnzNThVgEqk2fRt+ZDkwMBlq64suERjca9WHoj35xln+tR6o9A7gEH/6C68X6j/wMItVAtmxp49jO9TD6+/qqsfh+I9H+OWgxURkZuC3ALljEFIsD3Hh5jQMZXYCSUBTVjo6EBP3Y8xy5hzOd1I47h4206VCfqRcN5zwdyoMY0yky5DfDpqep9cuqblKOtRTVEM5PJRD01G9HzWyHWtqHOe3Zu62xoABC+vV+ydlgzy4NZ5MNFjZDX/S2/NdH/l7gMJpVouzgRoYliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF9623118BD.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Thu, 22 Jan
 2026 14:59:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:59:26 +0000
Date: Thu, 22 Jan 2026 14:59:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Message-ID: <aXI7STpuEtMWQloB@bricha3-mobl1.ger.corp.intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
 <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568F@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6568F@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF9623118BD:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f0f5f0-df77-4321-9d22-08de59c6d62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Mg2Mm9hPA6s+GZzD5TXMk8o7i5SPJ4u1Uk9CdJMJkeoHFf6GN1y6WsUBYp?=
 =?iso-8859-1?Q?vQtVh6rr9FroC/e15u/ZJWbd97hSbSJQ5Hvbu43fiaENK8ENqh8tZk8CmT?=
 =?iso-8859-1?Q?smhG2KWd5K9krhjsakyE+SA3F9jaufvTaluMjkePMb2/Y4jzSDAEU7k90t?=
 =?iso-8859-1?Q?rVvjGUQ+HczITRomIJri0KimCBKleR/msiRSdInw47EMr/g06uu3lnSUWC?=
 =?iso-8859-1?Q?h75HK8Am12LoXNCYuNU5zl9bTuAz1iDKiicFkFbTC1TNrB3MW0K9T5uqDH?=
 =?iso-8859-1?Q?fAqSTwoIZtoxT+FwxNDL1RM/HesVPJaIoTt1SG+QuzQbC238+EoqLAly8M?=
 =?iso-8859-1?Q?SLNRpQMREHoklA1DrLc4vFaM1GWUHHIth31hCzEFuvWqeDl9ifacQuTlsB?=
 =?iso-8859-1?Q?Nh3Ub9WrXYKuIaHX7yUceBk/WtUrIio5MJ+UV35WIzY6zi+YMgnlqBM257?=
 =?iso-8859-1?Q?rjsTu3L+9mp7Iuv4IaId89Cq9RXPgRNNbWrWqJ1iBOcfnt4BRX4GpAW5rE?=
 =?iso-8859-1?Q?JADzqYeEt1n2tFWmPbvYpvoL6jx8ONvzoToN/pfsneX8Z9WI5twBwwjJiQ?=
 =?iso-8859-1?Q?IU2bjKBcoHh+0jDrfx9QzvkCbZwpxYKItnGgVAI3qqvBNv3ZnHK+PspNIV?=
 =?iso-8859-1?Q?Ct2BjxkjxjyA0HWh/GCAQa4rQSY8CYQijG2TCuVEIP1nJLN/GQSipYseFz?=
 =?iso-8859-1?Q?f6iYIs8g3hafGDIqSoeNiXVxLy63i1aWXDtLDGVXGI1qAtjLCwDeIZiMvq?=
 =?iso-8859-1?Q?fckg0/qGeMDWNQyRjBzMDcCuWyJFMvEYjr22EAeQ/raTXluWH2bOmrXERK?=
 =?iso-8859-1?Q?LjAZmCH23pDUAHmtOS/xHW+LlbbbzZ7iQUGlBPqpvs9OO2u46C4CXMEIqq?=
 =?iso-8859-1?Q?jSnpLtwxamfeuBexevFRQaNsRviA3GN8bpAXXOkY6thmGrSB3aWxWFJf3W?=
 =?iso-8859-1?Q?s9pboicH5Ea2eMbvzyrO6PYT175XvhI941z5HHi63lhv5MMlJ/M0OoyRVO?=
 =?iso-8859-1?Q?I8GlxPx6hgeWQ2V1oZJwwECplxXOFzy12EPi1AHkzUFNmiAA8UwIkwvnW+?=
 =?iso-8859-1?Q?VNXGF6Ck41W8u9QrHvXRTyVmeLXqwMh1pbW/DlCyZTWptgZZq8zRp3HKtH?=
 =?iso-8859-1?Q?YRSa3xdGqex3U2nh8nqAzyIO9PkN5hu9TN+1+YMydwOmpvXgwtu/ThA931?=
 =?iso-8859-1?Q?7asdJ0OGrdRU17RpX51SlRM7KOfd6L1i5ARvhtPpvIsdpM2NQEcy+9dcbD?=
 =?iso-8859-1?Q?0lRFgcM46y07Qi/Bvs7zYRlpxo6Fj4Tm+YBmbrlkBsKLJSUn9dD91v/D1S?=
 =?iso-8859-1?Q?Az8N9RuJ9AJ/tt9iHuN97sZwHgKa6TwWtOFlDDvvUoKgD4yr1+wTp7WttQ?=
 =?iso-8859-1?Q?QgLOWuyptmuVfhAKHoHq8h0Equex45MHDfwydlEMkyubnfHBWI/M8JhAj0?=
 =?iso-8859-1?Q?1y1p1cOUzNlR0FqoI9BIYZZUKG6J7f6g/SZH+dsm6uM9VMIpvaz8Dl7ek3?=
 =?iso-8859-1?Q?6iR/BZYn02gEyWAexUrtbTQ8Rf2Q+R6BnbCf1+LSxVt5V+M9gFPJrNTzDJ?=
 =?iso-8859-1?Q?NcQWfvQTRNfkFDrHKfU/GXHBRKNcJg2v7F6bzPS/T9Vyiz0zqLMNXLbzkM?=
 =?iso-8859-1?Q?WyDP501tch3vc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NJqIUzfOQbIz/t/bDI0UG6k74RFmQ2pfntGxq5fNMzMTmbLlqoZVRxrvaB?=
 =?iso-8859-1?Q?89o6b2abcUy4jdQtGeohB+Egal65Ah0WkArA4kenX7PwedqqUbbxYJIhBs?=
 =?iso-8859-1?Q?LczonOzKciPEXCqgNH4pivhD/nPPZhZHumJpyOFVyq3wPVaKvCqjt+Y192?=
 =?iso-8859-1?Q?00omc3zyU9JMjtRIzE7nKdUmtNot0UU2hngh+4aGXMvzhckfDH8t4V6mgP?=
 =?iso-8859-1?Q?baJLfYlFkak31xRWuJ/XyhyV1jKrE81DXkimExZRuyotLg/MtZsaiI48lf?=
 =?iso-8859-1?Q?xK1785D8N7qt2/dIHRbPgLGfRxCUzvDLfwBuawv5ecKQ6oS3D07PwvRzXR?=
 =?iso-8859-1?Q?HIPKhcyU1bZE9R+rvKHXtlSt8LVTM28Va/OFbNhyw/tWHexbsxWinAlI82?=
 =?iso-8859-1?Q?DxLf7eIRA0fJYznHYajv2zld+CmAcqlicC62/HL3B14u+QVRzWtjblvnBQ?=
 =?iso-8859-1?Q?6hYJD0vuaodIXSTscF8MjBjx2TLQ7xF3ghceTj1PcZFsAbFFiw4Oz1Syy5?=
 =?iso-8859-1?Q?ZNjHa/QGvL9FEsHcdKWl4S+3YRcb0rkYZOefFttMQtSIY+5ZleZW1qNYDs?=
 =?iso-8859-1?Q?1dVjrzimQMBdJrmtCSTynmUVTSZ1HSzJaTVT+Fqaq75/ML94Ctzs7OyW3b?=
 =?iso-8859-1?Q?DrV3HV9Cq4TRYzYoUaDmrmnY8awz2yxeARvOckqtRGOL2eAzCH87KL+Z58?=
 =?iso-8859-1?Q?H50Qm99vLSmfbAYJsRmGMCG6b4R3hxhr2xboDCK8wpzbJXe3Uuoa9sagAR?=
 =?iso-8859-1?Q?vfAHSBrsF3oWdzL9jHbWWqG0M2z8TGx/pMAp4BGHCTfQTCblLD+DLQXadt?=
 =?iso-8859-1?Q?WNZ2rM6+5hDoL2agbqdMPDkc0eI6czev6xYwHs4ObVKELmfD4xr+idS1dw?=
 =?iso-8859-1?Q?PhDXb7zhti0zW70+B90E2wX7ROSLhlyH3X8QxsaH62tXnfuSXeK6igiK2r?=
 =?iso-8859-1?Q?GgNOHsGew1MXt+fx8OF11khADbzXSCu4/lm3SycYc5iX+w2Bm0FYSHs15x?=
 =?iso-8859-1?Q?kv1hJIPnkKDn65zLMzKsOWvZgLgslDaKTlPRNTXJsL5KhESw6yrQeBYLYb?=
 =?iso-8859-1?Q?YjrpdMPYR6yPHcvXfRDT11eodKDPQMJaGUtrIeuHRajCeTeZY4dcP5qROX?=
 =?iso-8859-1?Q?AbMAK9CC6/wQGgtUu59HGp8Yr0qabU5xLwquRLtWA6QjiLLG4WnMW/cgZt?=
 =?iso-8859-1?Q?XPtJfpkpa4aFsmQS062Z+soqzrpILkoyqCoHwFnK/FejxpDRXE0PFOglkN?=
 =?iso-8859-1?Q?sD/Dv1ZvcAFxntJ7VZXaGPNhswKyTY8kiStf+0vrmPlOy/pws1+4Xlo9y7?=
 =?iso-8859-1?Q?0o2qIhNv2rdRWJ1niqfZdqe5tEyYCqkQ5C3w461y8Zj4Q6Lc9U3s8lp/ov?=
 =?iso-8859-1?Q?vK4TawfbCPAyDDNUdvuNRmXW1+aMKrlr3G88vATUPdzMryxihJ3oxgl73k?=
 =?iso-8859-1?Q?spDjiycBfBGq+k1WWWRbjz2dmjIbujVc6OL3IYInwC9em025QkXLoc2vCm?=
 =?iso-8859-1?Q?Wczw6LPpKSerBOT0AdAmpou8K/WJThyQZpuKiDQ2MuEwwjsNrpoATGaytN?=
 =?iso-8859-1?Q?En3ZNYk6NMScLxjr2ohwzt1SPyWJi7z3dfv9AGmAht0jGt9O5AVSaYgQwc?=
 =?iso-8859-1?Q?VFWkaERmZ0ESc8JHxLEGXcxo/9cPJax2hfDu6LNO+pZ5zsxJ0omlbKbE41?=
 =?iso-8859-1?Q?N6+rW6RP9ifh10b9nJe/mxH+I+iYm/4adjK80QPaxY4m7g1YVTPFx/U5mj?=
 =?iso-8859-1?Q?g39p7CkpzMpUG37mFyrko2s4aSRkuqO4XBc+v8eWtfV1JD3S8MhJGwz86Y?=
 =?iso-8859-1?Q?8nvXdXGb+r3qfr3fuPc62dvQZHS89QQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f0f5f0-df77-4321-9d22-08de59c6d62c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:59:26.7194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFpaAqBz6vMCpcIg5n7ubGkR/cMJQb0T8IcW7oftFOgLixkpmliQSTJs44wv14rcLOK9wj/SnHeIdNzNFuUZqt7PKvYg8FRj95MFtIKMYtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9623118BD
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

On Thu, Jan 22, 2026 at 02:40:45PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 22 January 2026 14.32
> > 
> > On Thu, Jan 22, 2026 at 02:13:06PM +0100, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Thursday, 22 January 2026 13.24
> > > >
> > > > Having the net_null driver always available can be convenient and
> > > > allows
> > > > use by unit tests, so add this trivial driver to the always-enable
> > > > list.
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > >
> > > > ---
> > > > I'm not sure if we want this to be always enabled or not, so
> > sending
> > > > this as an RFC. I can see definite advantages to doing so, but I
> > also
> > > > dislike having too many components on the always-enable list.
> > > >
> > > > Since I'm ambivilent myself, including this patch so the community
> > can
> > > > decide.
> > >
> > > I don't think real applications use this.
> > > If they do, they can include it manually.
> > >
> > > My main objection is:
> > > We are setting the wrong precedence if we make stuff like this
> > mandatory for convenience.
> > >
> > > But I agree with the reason you are suggesting it.
> > >
> > > Is there some other way it can be enabled for unit tests?
> > > Maybe the null driver can depend on the unit tests being built?
> > >
> > > I don't mind that the driver is being built.
> > > I just don't want it included by default when statically linking a
> > monolithic application.
> > >
> > > I'm flexible on this RFC, so it's a very soft NAK from me.
> > > If it can be disabled at build time, I'm OK with it. (But still
> > concerned about setting the wrong precedence.)
> > >
> > Yes, I agree.
> > 
> > Why I'm proposing this is because, in order to give me faster rebuilds
> > and
> > because of the hardware I have available to me, I generally set up my
> > builds with "-Denable_drivers=net/intel/*", since that really speeds up
> > my
> > dev-build-test cycle. In doing so, though, I do miss out on having some
> > unit tests available when I run the fast-test suite, which is why I
> > suggested this addition in case there are others who limit the builds
> > to
> > just the hardware they are using.
> 
> You can build with "-Denable_drivers=net/intel/*,net/null".
> 
> Then I'll suggest an alternative to this patch:
> Change the fast-test application, so it emits an informational message about which tests are being skipped because the net/null driver is missing.
>
That is sadly non-trivial, and if we do so for net-null, we should also do
so for a bunch of other components where we disable tests if they are
missing. But the idea of just informing the user rather than force-enabling
the driver is a good one.

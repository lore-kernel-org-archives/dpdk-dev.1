Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29ACCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 16:50:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63413402A0;
	Thu,  9 Oct 2025 18:50:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5E8EB40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 18:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760028602; x=1791564602;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xXN/TXrJRODOFo3mWhGX64qfRZAyyyvXZr3jP1OiILY=;
 b=IzHqVPt9KxdzRpTihF+iFLdCxVnk74IgOvEKBAKROu5iOv5znz6tQnvR
 MH/Tlhfkxri/zlIIhdpyphmxyVG9bf61aj4WGUUtCC8oeJwtWIlVQqoj2
 v5MwS+0NigPYDChlhds4308MsTuMyLHMhzpv/epCpjUHIdeDb2VKnOOud
 udEAEYA8/oFcqH2yu0bIWuX/4F0ksmNqGt/vg3fXlq+6w7aaXQhdmBLdd
 zpQmXZ5iSMuCsYY97ULdypmw4crzmWj9ujfYb6lpQadIaUQQxHPKhDiJc
 dOPVAjs47WoJWSbdhmAatuHCu4+DLz00X8b5w/uY5ozGJXvp1yerRYDiX w==;
X-CSE-ConnectionGUID: PaWIDAr1Q4WR/0ACyUsAJg==
X-CSE-MsgGUID: io7V80L1TcSFqi2BW9K/+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73674356"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="73674356"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:50:01 -0700
X-CSE-ConnectionGUID: rqDKX/+xQBidcLW3tMthVA==
X-CSE-MsgGUID: ny5ybVY3SySIA3VNp/2nzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="181186319"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:50:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:50:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 09:50:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKe04C+jGPGgcyWhE0lTir3N+s1voU5tBJ/zGIHkNa1QR041G9eKuk0Qyi3yyQcpRw2lMV0EQmgyy6YBWg3Eof/7x/bhrFmDHIwl60TGlep+1bm5XI7GFJy44wjHigTqfGddU1zciAltJvoKoKY2fV8d71hcRNgW4cWUXrgUiH23ycJkAZUYAxZvu1Ap2MwvEx5juKmF5g4PxC5DdRNuFquj/Insho1gz67BDDg9zhxagNDCXKCVFqeAgjd3sJP0cdPa92pEIC7ZzkVxUxfH7bOk+RIDRoWvXrq4yxp5F/PFlIahZAggalglu5okYoh8AMJvCuKD8vjSJyWKv9o6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaS4An4vEbDlcRX33tsANXQjA/00B8iLaBBcusKOdHM=;
 b=OULQ15TGsCsq/Ux6TRk79acJBly5Kp8rRjvM58y2gKT25R6fjhV+0euHHru6hGdizDT+8MVkcgnWZAdNAYY2vgBtfLXupfTK0K6CC88MUWSmwkUXboxFvjAnXGpFAPHkm4qsyLKEUTjy7dBXTuCslBS7evIvJiTbZoyoRh3cq6CmkXcAcgtJwFDVqFCs1ApE24zQ9Rp6TnC+a5M0uR5zq3O4zhrHF+MNBRXQS/KQiO2+FuY6kzyaCY5UpA0/sL7hjb37J8z9v54Utbj7AkZTvcsDMCTe3TONU/McsXbQVfZcy/1RkhnrI+Lp+XxK4yOY9Z70ANyXRD7jo435c6Q4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 16:49:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 16:49:53 +0000
Date: Thu, 9 Oct 2025 17:49:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
Message-ID: <aOfnq0bx0py_XTQz@bricha3-mobl1.ger.corp.intel.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-2-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250823063002.24326-2-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZP191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: c47fb0b0-6a72-431d-9114-08de0753de60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nP37cELTZ9plOXsEgXUlHX7hWeChYsPQvc1B2WyLe2AvRVMMbAPWAAiqGH?=
 =?iso-8859-1?Q?qs+mwaKm2k9gIgzlKG7isujqY1wzdJopgb3Vx6mVdb+eDnu30VOKS2acE1?=
 =?iso-8859-1?Q?hTctrzeIStB/yJozzEw3uRD1CZJpRtz1wl59d+SFtbBdDGXVGeJ+6TrQie?=
 =?iso-8859-1?Q?ruypHUXsQc1v6r6oL+Q1x1QtQlLfbNRFjjCZK6tqUpjyV4ZzsB4KtCtFfd?=
 =?iso-8859-1?Q?WWKmXWlkuTOw2P6Ua/8gMHkYZX+ijU5DzIcNYsm5k0W0sHGeDbrpCQ4Pdz?=
 =?iso-8859-1?Q?JPJdt6vv6iV1chCzMjDmn1Z+4R39rkzmUzHnM9PivNAi11QtV55NMd6AUw?=
 =?iso-8859-1?Q?YLe4f/tR+OejlG/dk2j265E+NgLEjRfuI7sGgonYd/+HhM5YhaUIWVnob1?=
 =?iso-8859-1?Q?cZOtkMYFz3W9JKXdlZTQQW1hrWNG+iNIsS3rQbKZl7Vv91MXhdUELGrwQE?=
 =?iso-8859-1?Q?tcyAYjsr5Lf1KfgdZVDKTHgztnf8dbijeGX8K1wQxLeomVTBOYrTNg0fZS?=
 =?iso-8859-1?Q?E/X9bKTS63yTjrKY7ZUGWm1/KGJCl9T2BXvr9KjQPZRJQsrcr7pWJY43/d?=
 =?iso-8859-1?Q?sIWKDzJFC4HfgALlL6zQvbV22QoAsanVJSpchg/ugXDxkqG67CkhOppFkD?=
 =?iso-8859-1?Q?28OvVS/aXzaVSsZnUjQNDotevuDNeiP5v9kyR9UJ8Xm3Tq4fe8UvlZ0Ey6?=
 =?iso-8859-1?Q?hq/wsodV9+ISqn6iqckvxo/1/xvKkA48lVWNRug/8vwxnM9tV8hkPrBZ5+?=
 =?iso-8859-1?Q?PM7u2537Snweqd+Yfb86HJ5ZGGlZTbC14rgFBsAPUqSII/SCdbNoRgXXeu?=
 =?iso-8859-1?Q?kEY2sfMKm9+h4ZXoonpU0GmKiTjS85jJfacFTg8NktmQYvk6pu/WfZQM97?=
 =?iso-8859-1?Q?IU/s4ogZpqMtpd+PUod7GFxkKLver4J8eE+WLJ6p22oQDdw60noJ6//JKL?=
 =?iso-8859-1?Q?vkZ+0OorOjDrjsv+DxQW7tHIcqrPd2F4EBlUAhD7vzAXlttdmAkDF2qyae?=
 =?iso-8859-1?Q?5p9Z7GUT7POIWts29YxvolMYzcKwOY29zXWQE+7ofXbCcKXmrimzFTy2I9?=
 =?iso-8859-1?Q?zB/SxIOJVAAjLVL01iiHbDA8049w1h3fDHQgVjN7cN86DbvGK2LQ3E+xPO?=
 =?iso-8859-1?Q?iSpIT64ahlSZPJcUIeoDxcJCCisGbho794H6yUHiLkNvS+jTlSj2qfd7wt?=
 =?iso-8859-1?Q?Fc9fU2VcD2/cFq5t7+cz+MVHUaf2UWdu4sre12ixL4eAN4pNzixP6IY5BD?=
 =?iso-8859-1?Q?jDRWfrJ2fhh9UvHLF/4g7qD9a/iBF2j9IFfmVeJfDWFzsBoeISTF1znIIb?=
 =?iso-8859-1?Q?JXn1Cw1TTbroKUqO8llB7JWvSufJWJ0UHc2GB3mnJBjYtdmCKnxUZOdJfm?=
 =?iso-8859-1?Q?XDG+nUd4+ZdXCtGdcwu5hh0Za7r97A3bGITs1p+Jdj0/WVB5xMkQcbUQpU?=
 =?iso-8859-1?Q?bMgM20JRcbt2LSAWNR/BkP4+v40eGLD3G9GqMlPxCA6n7/ZV7d6o88Q2no?=
 =?iso-8859-1?Q?YD2Xj0yRs4FwW0muMUUeBj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a70SA6ICwxIG+GrTzBkGqemFMiQyqN0pCIWvF/dIOeqIg//MPikmskCdII?=
 =?iso-8859-1?Q?2xVu5QbW0/ILC6uZp8DSWFX1U9TWb2fIY9AYImnZDRD8kAEh+bCUKp87NR?=
 =?iso-8859-1?Q?LR3KxkiM1gR/4xNjLwTYz1HbqiKkrUIiHdRRgiqM9LJNADQSzj1UpQWWRM?=
 =?iso-8859-1?Q?yMdqOzKbvm3u2yahOL7vrpCnYJmhmuUbUeXryKzocHWm4HK+LhMI/XDqhA?=
 =?iso-8859-1?Q?i2Tw672hF8brMkOo8l8Md4f5J2uvnN+Z7iVJogF4LNys2/7O1OJjRgrExD?=
 =?iso-8859-1?Q?Fr4ZjrqBH9CqzkU6hoGyRZahqofzbS5CB6xnk5OGZE5eu0yk/u+y3bcBx8?=
 =?iso-8859-1?Q?oOjvXg55bFtpXG/vfT9aWQqo+1/bMCNwC9ch3YGEBDMRlofCarKr7D3PZm?=
 =?iso-8859-1?Q?77unsdFty6wnWuP5pzgFO+k21TCPQtfv8nZXtxbyl6ytuQVAfKq1gO1nNP?=
 =?iso-8859-1?Q?EukKq9PhdUlh5G83eLwQpTcW4JRZAVQuvJGEJZP6FVolqMgfj3UEDydwTB?=
 =?iso-8859-1?Q?Sc1kkCdgBJeO6ZmmsIJlBAEwPFYLpy7BgOjDD8VkE6wxHFylIdzy13kegD?=
 =?iso-8859-1?Q?QGq0sKfeeekTseTIVDjnQL2x8HmSP376EFogxyN8U9SmrV9rHOqluPZ08T?=
 =?iso-8859-1?Q?XTwV6KYp+rs/Wnma9BbFdaFUH55vVim95Gp5azpqTZhUE1gxWN1MBqUg32?=
 =?iso-8859-1?Q?Gv//zZiaI2v+x196IRwMPtQY4y+yyid1ZmFymcVM2/9sP+jLy3MAkszPpB?=
 =?iso-8859-1?Q?Dcf+K/kKda4UdG6lZgw1+DXb/siTKNO2Q+XmMVIAr/HTt8TxrkAk68WLI+?=
 =?iso-8859-1?Q?4VR3AUIqFhl+rSJjUj3oOiRWqDrCsxWhMfOVxCaFrYJNxqgIwV+5A+8KBX?=
 =?iso-8859-1?Q?w40Kk9kBKwICsEKrH34Ql03hrYDlbZYu5kLbVmTyh9yyi+FyrdvaaZzD0e?=
 =?iso-8859-1?Q?1kY1wUQznXLfv90jpVNPJ5ysfURKG+P6KEXaE7PgKQbbc6JcMztA5lA7G9?=
 =?iso-8859-1?Q?Xj+VuN5f9qBtaUaEO13vnHOb65rUfltJ1wPaJIDE9xwqTNc67kb9lWJSiw?=
 =?iso-8859-1?Q?bBwonOqQ9KO+6JiK+VXMwPcChG6cIFBR692oWJMeOfqLIYN7VFGi/2KCCL?=
 =?iso-8859-1?Q?7ubccwyn3aS98i0AfIuv+kLw/FlDZtcelFRe9D2mcGp8GVdsu592MnfF1A?=
 =?iso-8859-1?Q?7p+77mHgg+JuD5huhP/zGyLqcC8G+DBdf6rn9Aql3/0D+wphVtia4oOzod?=
 =?iso-8859-1?Q?4NOZw3DF3+t4c7UXvUa9SnPIKmYSRKnxClLgOlZ66nEgJIMnAK76kfdhWD?=
 =?iso-8859-1?Q?gb3HadO8Zoq+3gZiXg5IGdvPtoXkv4iei3wSx2lLiZDWxdooYF2Z6DPmc1?=
 =?iso-8859-1?Q?XYUlEj9xl6Q2Vy8kEET2PHe6/y5GKhnNPSZ7TnUQ1P0RxW+521g90VRovU?=
 =?iso-8859-1?Q?DZgYH1PQhMwmyq2GDnP49+45DhQVlEaYHifCSfDrY6nT5RX7MLsuRGnvFP?=
 =?iso-8859-1?Q?GCWi/x9XhNDd/MfgI4ZP/ft5tC0nUiejeprFY0PEgLVseI894NxBrtrkN0?=
 =?iso-8859-1?Q?kRgiNJffKahEJ19bq9iJkr7egygAHpd6aJDmVLiXJZ0Kq0wI665/CPzQHv?=
 =?iso-8859-1?Q?qqeSSndas39o3Oj5nDxXXC5wsNmudMRsV8p85FcDiMsgDp4aMRxcjOVw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c47fb0b0-6a72-431d-9114-08de0753de60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:49:53.0139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYsZzRuY+JNngfq8j5VP60NujoFAXhB9Hd01FafVVi/wIiK11RjSHo3Yd3u68Z3SWjaAkPIwNtQGvxeU2ZkJe8R77x4PATZbDdxzj9iVfUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
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

On Sat, Aug 23, 2025 at 06:30:00AM +0000, Morten Brørup wrote:
> Sanity checking a reinitialized mbuf (a.k.a. raw mbuf) has been refactored
> to follow the same design pattern as sanity checking a normal mbuf, and
> now depends on RTE_LIBRTE_MBUF_DEBUG instead of RTE_ENABLE_ASSERT.
> 
> The details of the changes are as follows:
> 
> Non-inlined functions rte_mbuf_raw_sanity_check() and rte_mbuf_raw_check()
> have been added.
> They do for a reinitialized mbuf what rte_mbuf_sanity_check() and
> rte_mbuf_check() do for a normal mbuf.
> They basically check the same conditions as __rte_mbuf_raw_sanity_check()
> previously did, but use "if (!condition) rte_panic(message)" instead of
> RTE_ASSERT(), so they don't depend on RTE_ENABLE_ASSERT.
> 
> The inline function __rte_mbuf_raw_sanity_check() has been replaced
> by the new macro __rte_mbuf_raw_sanity_check_mp(), which either calls
> rte_mbuf_raw_sanity_check() or does nothing, depending on
> RTE_LIBRTE_MBUF_DEBUG, just like the __rte_mbuf_sanity_check() macro does
> for a normal mbuf.
> 
> Note that the new macro __rte_mbuf_raw_sanity_check_mp() takes an optional
> mempool parameter to verify that the mbuf belongs to the expected mbuf
> pool.
> This addition is mainly relevant for sanity checking reinitialized mbufs
> freed directly into a given mempool by a PMD when using
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE.
> 
> The macro __rte_mbuf_raw_sanity_check() has been kept for backwards API
> compatibility.
> It simply calls __rte_mbuf_raw_sanity_check_mp() without specifying a
> mempool.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---

Looks ok to me, one comment inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> v3:
> * Removed experimental status for the new functions.
>   Experimental is optional for new symbols, to allow for future API
>   changes. But this has been around for a long time. (Stephen Hemminger)
> * Consequentially, the added build check for ALLOW_EXPERIMENTAL_API with
>   RTE_LIBRTE_MBUF_DEBUG is no longer needed, and was removed.
> v2:
> * Added explicit build check for ALLOW_EXPERIMENTAL_API being enabled when
>   RTE_LIBRTE_MBUF_DEBUG is enabled, with descriptive error message if not
>   so. (Ivan Malov)
> * Fixed typo in patch description.
> ---
>  lib/mbuf/rte_mbuf.c | 61 ++++++++++++++++++++++++++++
>  lib/mbuf/rte_mbuf.h | 96 +++++++++++++++++++++++++++------------------
>  2 files changed, 119 insertions(+), 38 deletions(-)
> 
> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> index 9e7731a8a2..af39c13cf7 100644
> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -373,6 +373,67 @@ rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
>  	return mp;
>  }
>  
> +/* do some sanity checks on a reinitialized mbuf: panic if it fails */
> +RTE_EXPORT_SYMBOL(rte_mbuf_raw_sanity_check)
> +void
> +rte_mbuf_raw_sanity_check(const struct rte_mbuf *m, const struct rte_mempool *mp)
> +{
> +	const char *reason;
> +
> +	if (rte_mbuf_raw_check(m, mp, &reason))
> +		rte_panic("%s\n", reason);
> +}
> +
> +RTE_EXPORT_SYMBOL(rte_mbuf_raw_check)
> +int rte_mbuf_raw_check(const struct rte_mbuf *m, const struct rte_mempool *mp,
> +		   const char **reason)
> +{
> +	/* check sanity */
> +	if (rte_mbuf_check(m, 0, reason) == -1)
> +		return -1;
> +
> +	/* check initialized */
> +	if (rte_mbuf_refcnt_read(m) != 1) {
> +		*reason = "uninitialized ref cnt";
> +		return -1;
> +	}
> +	if (m->next != NULL) {
> +		*reason = "uninitialized next ptr";
> +		return -1;
> +	}
> +	if (m->nb_segs != 1) {
> +		*reason = "uninitialized nb_segs";
> +		return -1;
> +	}
> +	if (RTE_MBUF_CLONED(m)) {
> +		*reason = "cloned";
> +		return -1;
> +	}
> +	if (RTE_MBUF_HAS_EXTBUF(m)) {
> +		if (!RTE_MBUF_HAS_PINNED_EXTBUF(m)) {
> +			*reason = "external buffer not pinned";
> +			return -1;
> +		}
> +
> +		uint16_t cnt = rte_mbuf_ext_refcnt_read(m->shinfo);
> +		if ((cnt == 0) || (cnt == UINT16_MAX)) {
> +			*reason = "pinned external buffer bad ref cnt";
> +			return -1;
> +		}
> +		if (cnt != 1) {
> +			*reason = "pinned external buffer uninitialized ref cnt";
> +			return -1;
> +		}
> +	}
> +
> +	if (mp != NULL && m->pool != mp) {
> +		*reason = "wrong mbuf pool";
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  /* do some sanity checks on a mbuf: panic if it fails */
>  RTE_EXPORT_SYMBOL(rte_mbuf_sanity_check)
>  void
> diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> index 06ab7502a5..552cda1ae5 100644
> --- a/lib/mbuf/rte_mbuf.h
> +++ b/lib/mbuf/rte_mbuf.h
> @@ -339,11 +339,17 @@ rte_pktmbuf_priv_flags(struct rte_mempool *mp)
>  
>  #ifdef RTE_LIBRTE_MBUF_DEBUG
>  
> +/**  check reinitialized mbuf type in debug mode */
> +#define __rte_mbuf_raw_sanity_check_mp(m, mp) rte_mbuf_raw_sanity_check(m, mp)
> +
>  /**  check mbuf type in debug mode */
>  #define __rte_mbuf_sanity_check(m, is_h) rte_mbuf_sanity_check(m, is_h)
>  
>  #else /*  RTE_LIBRTE_MBUF_DEBUG */
>  
> +/**  check reinitialized mbuf type in debug mode */

This is in release mode, not debug mode. Comment below seems wrong too.

> +#define __rte_mbuf_raw_sanity_check_mp(m, mp) do { } while (0)
> +
>  /**  check mbuf type in debug mode */
>  #define __rte_mbuf_sanity_check(m, is_h) do { } while (0)
>  
> @@ -513,6 +519,46 @@ rte_mbuf_ext_refcnt_update(struct rte_mbuf_ext_shared_info *shinfo,
>  } while (0)

<snip>

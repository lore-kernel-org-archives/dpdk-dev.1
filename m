Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF2C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 13:35:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2308442DB0;
	Wed, 18 Jun 2025 15:35:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C3C46427E0;
 Wed, 18 Jun 2025 15:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750253722; x=1781789722;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BtRfOQdttdtdmmhL6Z+2rNJe4LB/MtzCjcZJ3LkyPAk=;
 b=FovMXd9deyau1cXHEFbMI62DWOUneATPba7DFLjgeyRBNWRgTwZZ3QvJ
 emIB62CCIY4qqf//b0+1p7vSoNgrnqU+z6NHaYfoJB4jJE1P47LnoZcst
 R4wSoqaCgwa2nSBWVtwz9tcRnhj1II2Q8WO6NwQ/0fIXWlyFQJhKBakWP
 sqEwQF34lEV5AzUO+uAHimArvTrFvT9N3n0aHCNxVX4nP62feAd+3oSWr
 R6m6/U2xAw7HSraL7EVUVPwM/y/ZaVjs3zB6RZJAMckJuVd3evvi4ioIO
 Sdo/805X6f1X5xA5Y7b/ipdWTALafibXIklWdTsRij9+Ft2yErLw3RZYs g==;
X-CSE-ConnectionGUID: M8So001XT1aW38Rs2VzUAA==
X-CSE-MsgGUID: FwjHhIMwS22TInS39eTGnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="55089308"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; d="scan'208";a="55089308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 06:35:10 -0700
X-CSE-ConnectionGUID: WBFbaFSJTASpuFDKea+xgQ==
X-CSE-MsgGUID: 61Qef9DMTaerG0YEAUN8hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; d="scan'208";a="150323768"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 06:35:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:35:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 06:35:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:35:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRvKl12FjjCva3foE1Q45oyYrtK0v7L20aZ83szR8+bPiYymI7R0NPDb4Vl5bysNGbe6A8GlYktNtveGrqIcIu9VNhEGsmBRpRD0t+VL+8Glv2pa3ffy92C2Wie7YGgeIEHeM7HmP8ExNySbG2EnOd3/VZZ1lFWi51gnxJdrqSdNgk2pKqdBeSMgvmPULJ8i4Kbzr5QaRzfoefDqB1eksPgmzJokTxum+n0JPJbz6vWTQgWEsj6CD2fPj+jmITQb/XX++7L7HhSQcj9q9+XHoGJgLgqHE+VIhgCOJPjUndGMEYM2nwlhcwYOQo22sxiRGNep+2nQ1IiuEqzhs08IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2Q+13yobX3I7gkcidvbDphDRLFtxZuFJYKASvTuY5c=;
 b=JFIwVcAJTt5JX7FPZAmOp6M00jIDeWuJZCTUzp9QSTqNdyQSFMLniTGY/RHb75cn7NBk8m9bvTbkPW254U78/ET7ivglHkMrsGontxlxZvNk2GknblYMqxncPffXcd0I2gbmdE0eYGnrZclzQahy8ECujLR9oRkHa98em9nN9hp14/590fPo+JviZzv+QALHjaRK+opOIIK7RdWB3T4mAYsj10yM9QYpw/dOTpBowWhwcT/rv+Idymu7CBeYKvDlLNZfEKcejU8Zi8iHB4CULALIQVX4WD+BvNojm+qwPnom54YcReGl1PH3oGTLVDByIBGmRAZQ78zbqHUArKapkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 13:34:32 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 13:34:32 +0000
Date: Wed, 18 Jun 2025 14:34:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 1/2] net/ice: fix getting DCF RSS hash
Message-ID: <aFLAYp7tnzDSppfS@bricha3-mobl1.ger.corp.intel.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
 <20250618070844.174484-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618070844.174484-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DUZPR01CA0246.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::12) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM4PR11MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: b6699f09-1ea2-4d94-29d3-08ddae6cdb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5X7FaRo933YxC9ikMOeN9uSZvJ4yK1TCwpOzvlM99jZd1a12T338Gj3r7Md0?=
 =?us-ascii?Q?nPLeX4Kpu6deDO6pojox/6r6uUjLMrRQvhOLTH/FqptInNajRM5ZqRE9LYjO?=
 =?us-ascii?Q?zO6zedGDA3i/l7rVIawz+3v0/XAi8PmZNK3Kh3D+MszMe83/OVY9RfX1wyYI?=
 =?us-ascii?Q?rUgJ4HCeV6gGuNp9df4MjBRzjRm8IKGEk/YYGnUnRA5bjs4Yj5fvxfmYy6OK?=
 =?us-ascii?Q?uRx7K0DLQsNATANVzoKUjH2X4Buim+XMg4flTJahE+D0HkaH78gPKLWraFy4?=
 =?us-ascii?Q?V/7IqaiPMMng5hJAs3l19h4FJLU2q7Bx8BNQ8nzs7EQbHKwCznwP5rpE8MDl?=
 =?us-ascii?Q?laiMqkXx4FJ1j2vnh1CVKl5B8CkmxA07JgIM/DWQo2s1NLP++mccaKmQHxnx?=
 =?us-ascii?Q?itoPDyy/LAKvqKolg9/QB/DpD/eADhhrNeLb37dFD52BbvVq6TJOr+yQScLe?=
 =?us-ascii?Q?Ju7f4ABXpjvHj7eo4awx5cetrtpkhw8UDjUnhC/Z+WS9uVyjd9YHpxjQrD70?=
 =?us-ascii?Q?P2+JZw872KoPAavxiDIUpvpPhzOq/3PP3xDMy+AFgKUou4UTZNlUAngNVxtN?=
 =?us-ascii?Q?3jgGAgMGrQ3kq68Wt8YIbM9kqlqobID8k1FM2UhNctkxjJrchZ8vYTwCSSBM?=
 =?us-ascii?Q?BZ30Wyc3szSnTQtxAo1D94lfBk5IHM7r3MLE/ohDs3Lx1fCSwPTI3gDKRT7M?=
 =?us-ascii?Q?lEUCfqcXY69Kpmt/WYz+p2JLKW1txeuTcxcSQ/dD40faPHhmFYnIXz6Ie0nw?=
 =?us-ascii?Q?tTZwXq3kyLbryHNRvVNnpZ+CHjolsiPxzBe4SI+D3RL7qj2EMI9N2Q9a+Q2j?=
 =?us-ascii?Q?aqKlSofIqynlWSB3HaZtJpeVkNGR+jw/DjpNt7zdFzXtQGOkGsY//IeePDR9?=
 =?us-ascii?Q?nGjNz3UKIFM8PZVtdcjPIL0EZhDNaJ1srpSLVhdNiJeSC3RnUIJk7938EnGh?=
 =?us-ascii?Q?MoTMzX4OH4Dn0rENAQtEqgWNgx/xVjn/f9uv+ZNNIoHk3zd1MJAnAbfKT3lG?=
 =?us-ascii?Q?vC7kQSqyQ/zAXQ8cjDmQmG1uZ9xtFzB0CTa3mzVpWDcC89taC/aoukoSfn9f?=
 =?us-ascii?Q?tFbrdE0Lm5E1A2crQNhV/z2pNgSDcagtLeNZ3Ljt4c1IspZm9r4pR0IPXFNH?=
 =?us-ascii?Q?I9StgMURigVD4oMLue40AJySOH4hMdYF05FHpMYsklZWyPPAP5KI+qUBUOyY?=
 =?us-ascii?Q?UC4Fe6sZ7pBqB3ffAr1OGE6Hg0qxgqjZa0HDXfYtmKtd6efjX0/YSsJKuN2j?=
 =?us-ascii?Q?G/mAMsNFU820YVu9bLQn5hMaxpS2ZJE86PRyEznZB7jiFBSPS0jgm/quXh7P?=
 =?us-ascii?Q?wnHN+2R5joUXw59u5aA9yD+LpSaczwnpQ17WBYyv0yaoC6T4j9s4i2dQFguc?=
 =?us-ascii?Q?6DRXdYNxCd3YTUw0hnrsBEdQFILCWZety/mqFbmn/DVST2lkHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qlyCWXMNsO6ZEd+RqPDyHys75NbX4cz5ftXRwVro50dGV4CCZOssgRttGKMb?=
 =?us-ascii?Q?4mhQNCl+/FJIpJaVoAb2nYe7G2+dVoaAmp4Vl874Jm9J5ojOCgVW2OXZnksj?=
 =?us-ascii?Q?SLOJoGsJXaAtoNj5BrFtB3x/WaH1PDzivTZyvD0giGCudQIrQ1DvtMDOd1Q7?=
 =?us-ascii?Q?0j/8G2Z/KQxO8kmSSv4Ka3vV1DW4vsR4OzErnQtAEoxWGX/z5HgR12zZ7H7y?=
 =?us-ascii?Q?hnsAwR57Fgr/O6VHyYh6wja8xTMKugSVZhWPlddjJbTizsTtksTyLNoIyHzE?=
 =?us-ascii?Q?31VpIFIxfDKDUkIaPL2zDmpPQHnH1MfMx912kLZa7PBC9f+HvXXrMHkUyBoo?=
 =?us-ascii?Q?y6nFfNrFJCiHTTr3lYMedt0O8OhEQYHMDTB1GIJgLt/5DP7RLwZNpw7dMJmb?=
 =?us-ascii?Q?pOrsbOGE4EREsenOMwddBxcHm444QirvBZE4Yh3cXa8AeSF8EZfG4GH22HHZ?=
 =?us-ascii?Q?YceYMF39jD38MpxLSoKT+3QItIwlWiuOF38h8etoxe14XPqm+0foSQHUEqvA?=
 =?us-ascii?Q?mJ/l56Gc7Nod8YLK6XD5KS/SWGaJ0E2Xa/f63f5d9Q9Ns9DL8q84AvTsgN2G?=
 =?us-ascii?Q?0E8e3WZ5NhHiSfSiDRML1ytT7sYVddeMZlhAdmxZZFtvoa1jMeC74KEVZO4z?=
 =?us-ascii?Q?tYothG/CH3RjrftfswXXHptx8WJKUNWALMsG9+n09azgPs569kay7MoQCIYE?=
 =?us-ascii?Q?LYuj4+5Fqx4TsYheWW1W5J1eV+ds/OapvY1IWBcjMhK0YEOZ4ipt7B65jS0+?=
 =?us-ascii?Q?hLb5PnjHoZ7Y6LMAWow6uDeolHrfIh7kggm+DLVcVaco+MR9u1i8JPErU/tL?=
 =?us-ascii?Q?+jmuxKESmPpixg3ILQw6zWxTtSvXed5/7qKOaF6mDjBfGElOktyt0w1S8xzt?=
 =?us-ascii?Q?5skTq8wvpVoATUp3/G30mh2oiv+q3+UYKTzLR25q5ezPzMoDb7ofbYr+wR0E?=
 =?us-ascii?Q?3KK2RZxYnuBb3yU570FPpGXPN0Qe1th4VTBU3t/NFt1UuKEHZvrP0ICROuid?=
 =?us-ascii?Q?vxfSEPOqjBJJ7BKSzrND13FY78D0DXu1G0ezODPhQOn19s1k+T3JGoiUMGRk?=
 =?us-ascii?Q?i8YiscI6kbhcynT94QX6cEjISKV5vVqhDE18YRquW2s2PXYohDCaEkXJv+/7?=
 =?us-ascii?Q?OgAz9QWXTVcfuvdyKj0672TZpayKJkhwbEQfJB6XN6Si/dRd3OT+UhbD9b7U?=
 =?us-ascii?Q?xSHD6JI15eVnu/lWNUrgWgAgnF2/76+qSI3ybuj9B2KCSXGgsjVSF7Si0oYh?=
 =?us-ascii?Q?I166JnuSGF5WLYocGwqz/8J5NoQU374wSvXbWINJCOpnG2S730JkLoZHTg3Q?=
 =?us-ascii?Q?hDJURTLBg0ZDGlGTNgg2mYZnX54UfFP2Omfil8bbbxTnMlfPLChjl46cSo67?=
 =?us-ascii?Q?fM7qMMQ0B3fG7ZJSFbo10OFgNUEffpp2kA4dS40FTsrABiQ7ElH9jw4+8DF4?=
 =?us-ascii?Q?WAjSTSl3fD3dWmWRNE90kb4vW7Miy47i3MPFDYmSSu+MXxFMxIDMxF4jXbcW?=
 =?us-ascii?Q?48EmPtT1gmkLX5D6fcoFz6vkGoM/Po3GFNWg3DmrOltAX9QE8Z0xyDDQGAHY?=
 =?us-ascii?Q?Ah4mM1mxOEhf3xP3xEFbaEzgsXCTcemVryaKA0923WHaMhcJmQJc75hioi80?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6699f09-1ea2-4d94-29d3-08ddae6cdb8e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 13:34:32.1292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13wpfBUcAXa7sD0DP21x1ie0cNj+QQTlF2XWjDqnRZJpvbyEAtflEOgP6wxS+b4mwQkxikpOjmD11W0wWoMlQF15r4xeFXupCaWJ+zC2HWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
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

On Wed, Jun 18, 2025 at 07:08:43AM +0000, Mingjin Ye wrote:
> When getting the rss hash configuration, it returns the currently
> configured rss_hf instead of the default value.
> 
> Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


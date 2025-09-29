Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1FDCAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 07:39:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3472F4028C;
	Mon, 29 Sep 2025 09:39:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9703E4026D;
 Mon, 29 Sep 2025 09:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759131583; x=1790667583;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MPSPCY3qMszV0T5XNJkmZ4sgq46nn4SvCcBYA7uM/xk=;
 b=Ggpsd14pfxMdq+xuGQMsCOQh11M7hbsRL1M9wGsUDg3FNMeI8zryrMEN
 5KYNYh7hisH9bzQ37RSD+AxY//S451ChDGpZU/sE1Et9/zUvCr9q+l0wh
 GNg9aw7krdB97Nr0LZCf54DRxIo2rU0jqA6rr5OEqIqIBcbH8gaAXNm/g
 YvKUNJvQ2psHZUXt1eAi3YM38Hn7FSUawmOone7ZdGe0UfTwpanoNL7Hv
 Wn8yvwyPwoRtFigJO6rEDwrcrON7I8jE8K+Qu1vMo7fWWGrmcXRGy0bRA
 5dXRu7EOBUaEq/QbxG3IeshSi1yOqQD7ElcuxHKlR+FSrqYbLstvIVPlZ Q==;
X-CSE-ConnectionGUID: Z1wqFYuLRZGDkpeOJMrDbw==
X-CSE-MsgGUID: ZnoZkyNVQyy7Lr74shFyug==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="71613686"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="71613686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 00:39:42 -0700
X-CSE-ConnectionGUID: qAgod2/rSDGhq+7qWgFbiQ==
X-CSE-MsgGUID: gqBHNB4EQRe25Pz9TVd8Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178592875"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 00:39:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 00:39:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 00:39:37 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 00:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Doge0Mp+Jhp1tlGjdzrgf9OPYBb9o4Annk+1nIS95A+psql+vDmaUDY4lczSABkFhroALWXuUAUmK4jr7FB5X11TxHG9zQglSGHy8ro9oy/60CeLyaGQQT/lozjq7xWWj9u6Ovo5NTUlE7xc/qPEg7o0Kuc8YELccZVK20Xg1zh9WI3QVDPLloHvHubWDz7jMtfYIRrpJgylDgpqjXKSDay+cd78UQ93KzYV7ytYpY3z7yPhowuP6R4CMAiZQhUSXyg+d7mmYivaqZtYywBo52KwNGneUbgpc34SYOoLFdH07OIQRQWFo62WOd0Cb5D472vxW2ol66ozuXNzlmUU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxRT0ywJChRi/YnFCsUTWaZkTiZDvIUbkeZ4maFPGM0=;
 b=Wfl1hRTHgG/LcWTjDpvll/M8dnfehUYUMwIZMtPOJ8VJA3/bCSl16DGozBuQf8mXD/98Ea5aRwG5HgxTBvJw2QXaSvOVpFSEA23lfhCLRfb8Amr/NCH39T/b3PoaE4UlhgDEzt5kc8zeZPyP4H0FqMiONlcFq9FJonFRB4b7OA/6hqXim1hd/7Na5Ybg6KwrpCwa7cjiOTIJhtmCEjzGpqjhTD90DhtjdxlYANmrlqrL5HSR4eAIKrVRonjor0oT3/WrqVhpk3FasyRVJLzoS00akfJBodL3xxsFIWc4G0gyQg78IpSIGR0s2MlXeXb0i/0NUakJiFHD8rSs+bRXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8177.namprd11.prod.outlook.com (2603:10b6:8:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 07:39:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 07:39:34 +0000
Date: Mon, 29 Sep 2025 08:39:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Kai Ji <kai.ji@intel.com>, <dev@dpdk.org>, <gakhil@marvell.com>,
 <konstantin.ananyev@huawei.com>, <thomas@monjalon.net>, <stable@dpdk.org>
Subject: Re: [dpdk-dev v2 1/2] eal: Add rte_consttime_memsq() to prevent
 timing attacks memcmp.
Message-ID: <aNo3qUKUGbRyGLmI@bricha3-mobl1.ger.corp.intel.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <20250926154905.54416-1-kai.ji@intel.com>
 <20250926110752.51572f6e@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250926110752.51572f6e@hermes.local>
X-ClientProxiedBy: DB7PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:10:52::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1037b487-2deb-44ca-5cc5-08ddff2b55a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zkFSyIUyTiMpJbpBZLL8v9WDzrZb8pbaYrcWzVDKoVQrM5NYtCcpHilqyoLN?=
 =?us-ascii?Q?b08fCLC4jOhyq80oXoa5/Jk/mMuD/QTCuMzXQir5NU6reqBtJuU1kMWCQK67?=
 =?us-ascii?Q?u3nef80ZAFXol0BTTrjqH9Or1UogtmuG8xJ28eYlh7kZuqQAp6SdUsiVe1F5?=
 =?us-ascii?Q?bR3uY62h1HOLk3gt5sgWJi4+crGZ18eRkzG/VMhnspvZYyyC/vEyEtceF+Qj?=
 =?us-ascii?Q?LZhxZzwwGpu+DX8/uU5AukSJZAc/eUC/DH2vwju5l1fCFidgr9YqRYYimEa2?=
 =?us-ascii?Q?L4AOtU5Y8O0wQ6MANjGIWWh1mHHFrUhdOcltdUXfBIrfnNr08mH8X2p/R0c2?=
 =?us-ascii?Q?M0IPGyzQvyZFRPlB2p0V12WbmK7MURlPC7gCRbdRjp//B9S2zakU2TztEtYA?=
 =?us-ascii?Q?I1pba5eO2ybsFmOoERpJS8VW85DQFF6/SDlLh6owrMHm/LoSVR9S1qJKFE2t?=
 =?us-ascii?Q?iL9H9dUeacAaBC11c/4jUSuEKgqUVRsA1UAM0KvPuByVjsOlbVcgvBSxR/Z8?=
 =?us-ascii?Q?L0CrFhtduTa3oz/jle/Mm2H93JyKV4NwEcrcvBNxO1vza39WeEq9yqJI/1A3?=
 =?us-ascii?Q?ZSRdoJ61MJdvL7ZACwHpp86K3Zz2UZZOOrQQRy3gpEagybrnD2U8EbRIoeU7?=
 =?us-ascii?Q?P3A/16zPFgJ9RESXc+gILV9MpPJirHuJaWCjwA9CQ+LSW6LfVpD5rzLrw5lV?=
 =?us-ascii?Q?S0A7b0KQpXm07wOXovXod6uZ5u5WDHETmbIKMmUhWbaNnc3ugQwIIG2jBU4A?=
 =?us-ascii?Q?q7ksfs8vWkNwHM/Ni8qfbdPdC5+hBwrFM8ewkcCLhx7/38aIblXePDSOUPoh?=
 =?us-ascii?Q?QecvAkK8ZbNczkKKqj26WBBg3W+/0QR+eBcZEW4/EaWcikwskd21O1mgE1MW?=
 =?us-ascii?Q?IYujpkW6Itdo/S5hjAF7u7OuvuiSMx7EJ/lgmBHI35/yzPDXiwH5eZ7bdM1O?=
 =?us-ascii?Q?RqhZNpeJyqTbIG7e4/2o7bYZQM5mGZTaFia1rtM4kSKlmNGCOBRVWpkhKqdL?=
 =?us-ascii?Q?7wWb3ct80ekzkU2dR0ZzmeiHc7s6OWJYv2dqiYkzRxswgYAlOMJZW2Ahfl5U?=
 =?us-ascii?Q?WlzB2kzj4M9XyWHgKMx44ZqhXm2KjDC7LAhqSI9P7sQSOI8ptOxKSpotEyH3?=
 =?us-ascii?Q?psgYfGIjcWBO3YZ5JY9AamG20FHfPCYXpY97Qxy847dE3YpZYuW7GVnue0jY?=
 =?us-ascii?Q?f4VowhpihjJxHbIL19OkGwgYfnAQ7Egkn0ZdULtjr1Rkm1R7KAnO8urecqd7?=
 =?us-ascii?Q?PfTVizAQP/0T8n08p5TEhss/LNbA+742K0FzCq9QHa6t4GrmsRov/6C6w98L?=
 =?us-ascii?Q?d22fInkFH0LKU5ig8wvN45jJ4v58sAByBu4luTdreUtDKW/lmOBRiorcvn+v?=
 =?us-ascii?Q?aO/fh4aCrOKIJasEDWvzVnYItwK6dPSaA7dvd1XNCJJMTVQKSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+C0CfWn6VBvsBHjUs2NLCiJMTMdhUzEozIW7poCnh8NqoQYR6R22EUds+nX6?=
 =?us-ascii?Q?m47+FW7+BFscwdH995XmBn/I75sU5230hPMzsAilOHyX88wpfteIozDJB+vQ?=
 =?us-ascii?Q?gIUy2bJdRCeaUsIyzt+SagZN58l6diOULMaxRjz2ZFhjXTTMDcwAnE27iBSi?=
 =?us-ascii?Q?A8I33kEV1n1f6ZodVETHu8JWsZqxB6t97WM2ZnwS2kFCEqUhTdHVFJ6AAHjt?=
 =?us-ascii?Q?4BcBdHyolS67NM49zeQw4Gzbp5tmBXO+zSutItcpuycBHydjgz/2osSqXvCS?=
 =?us-ascii?Q?zSnPoHWeV5arKrCpvRmBwNuOwpb/rqLgQfFYSz+RhmFre0UGd/KjB/RPxRwN?=
 =?us-ascii?Q?oPk58ML9aeco1Nu4HgR4uEwhlfZJbPrjLtrbbrAYNqlD1Kc7xszqdA6s6jA0?=
 =?us-ascii?Q?W16Up9qn81xnZd4ii/noB+RCF4dKx73Fd4IvY0qzDosTrNHqTCbGxEvVGrfN?=
 =?us-ascii?Q?J3xg1h1VYVAAYsEuB+N8h2cnk5DU3jvxxU6y+G8CbH1cJRqrc4w5RdIYReoM?=
 =?us-ascii?Q?74Txy0/cwRkQTqdL1trdqMzdchOvL1wu2lFB6VN3HXnLTJ44bRYG7WN6cuDy?=
 =?us-ascii?Q?yEg0YhXyTH9B4dW/qneY86hwZlYe9EZp9/wVHzxoVhIW6QiDRB4SYiQniYpR?=
 =?us-ascii?Q?Go5tXpQ20i5IiQAzbxwjdPYu04fpGjwdgOwi4hmk6Qc+YeF2tIVA5BdhpiaR?=
 =?us-ascii?Q?uMKx2oAo9J9C+RddZgDfKj35uSfn+Ju3xAYnmYyFtMC9hitT3LTcnidjG+0H?=
 =?us-ascii?Q?dtN0goR1IXQ3JlplA419LnOMfVoOZ3usneWEQVj8Gov7yYJ+TjgSAMhIwh3E?=
 =?us-ascii?Q?2Q0+dVYi1pfspsd2/N8kKuQtk37T6CNCLaygL7pIa52Fuzj3gaUK3HDVOSJ6?=
 =?us-ascii?Q?Nn7nOLWKLe/PBjDT+v0y/ndl2ewNwsB3ZsspnY+NM8ovidk3Hg5v4oj4/q3h?=
 =?us-ascii?Q?qby4Q1EUhqCyHKFRod1Wj5GG5g/Y4Uj0zglFYZkbaEAankKt86sV/IHC1ADU?=
 =?us-ascii?Q?0jIHdMDIi1GR98XFrh81FvMVawzlEI8V/xjoDNetfi85Rw0o8ZoeNSlaqG6M?=
 =?us-ascii?Q?pz1JdYMLCwhTGcFhtedusHPT/0NxRCysUr9ru/P5uIa4XttFXIQJ254Nk+2o?=
 =?us-ascii?Q?OTxqpEkaw4F4de8mLFPPy1tetMtd4W63BFgLFy7dYxgM6ZFWoi1jDUaFdexn?=
 =?us-ascii?Q?9Z/DWOTIbvjYjRjq3xkBRLQRVoRkYzYXtowA4vT7BOxdzC53uUnHbVc7wCad?=
 =?us-ascii?Q?r+hS5UPB+GppC7IUgTkiMGETuAMlqTj5kl2naVcMSBUYrMrcRoC0w3Opc4ex?=
 =?us-ascii?Q?K2ZE8xNNOUYjJaaZpV3Lz1cIp74tfj7uUvc2cDvPoIlkN/P+Ynj7fyGTygmu?=
 =?us-ascii?Q?DmCx7KjHRLCv4uQmnkNiEaPEr0XP5CtnEIClRMeJmi/WA5rDj5RJHNZIs04A?=
 =?us-ascii?Q?SHSHB/7saTNEEOGupCkpyTfOz1LoTjIHv+41zkP7Crw/i+tWm8VnR0toaYPr?=
 =?us-ascii?Q?suPgbdmNkwqLbVWSTnL9YsxOV2VmiXp5U5dPDiRwpZ8A+ruQtRGc55Uz5oAG?=
 =?us-ascii?Q?4LTpvCdZEgsy3Luy7uSX+0vcTAc3cOY8dkX+MfjR6cSnusEUALDzcWdhojf1?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1037b487-2deb-44ca-5cc5-08ddff2b55a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 07:39:34.4661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tFwCQ95uJh/s5QgGDX8Pxg2xNXVQ4+/PNmZVy8y1Q33fUeonqXP/Uh+ANdo9lPL4L+2/RkHCqzTHIQequ6fhlF4G8I1XyrIXUSkFFb9wwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8177
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

On Fri, Sep 26, 2025 at 11:07:52AM -0700, Stephen Hemminger wrote:
> On Fri, 26 Sep 2025 15:49:04 +0000
> Kai Ji <kai.ji@intel.com> wrote:
> 
> > Bugzilla ID: 1773
> > Cc: stable@dpdk.org
> > 
> > [0] https://bugs.dpdk.org/show_bug.cgi?id=1773
> > 
> > Signed-off-by: Kai Ji <kai.ji@intel.com>
> > ---
> >  lib/eal/include/rte_common.h | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> > index 9e7d84f929..ddbba083be 100644
> > --- a/lib/eal/include/rte_common.h
> > +++ b/lib/eal/include/rte_common.h
> > @@ -700,6 +700,40 @@ rte_is_aligned(const void * const __rte_restrict ptr, const unsigned int align)
> >  	return ((uintptr_t)ptr & (align - 1)) == 0;
> >  }
> >  
> > +/**
> > + * Constant-time memory inequality comparison.
> > + *
> > + * This function compares two memory regions in constant time, making it
> > + * resistant to timing side-channel attacks. The execution time depends only
> > + * on the length parameter, not on the actual data values being compared.
> > + *
> > + * This is particularly important for cryptographic operations where timing
> > + * differences could leak information about secret keys, passwords, or other
> > + * sensitive data.
> > + *
> > + * @param a
> > + *   Pointer to the first memory region to compare
> > + * @param b
> > + *   Pointer to the second memory region to compare
> > + * @param n
> > + *   Number of bytes to compare
> > + * @return
> > + *   false if the memory regions are identical, true if they differ
> > + */
> > +static inline bool
> > +rte_consttime_memneq(const void *a, const void *b, size_t n)
> > +{
> > +	const volatile uint8_t *pa = (const volatile uint8_t *)a;
> > +	const volatile uint8_t *pb = (const volatile uint8_t *)b;
> > +	uint8_t result = 0;
> > +	size_t i;
> > +
> > +	for (i = 0; i < n; i++)
> > +		result |= pa[i] ^ pb[i];
> > +
> > +	return result != 0;
> > +}
> 
> New functions usually have to be marked experimental.
> 
> Since DPDK adopts many things from FreeBSD, perhaps the function
> should use the same naming conventions. That would mean
> 
> int rte_consttime_memequal(void *, void *, size_t len);
> 
> And will also need to update release notes.

+1 for removing the "not" from the name which avoids having double
negatives in conditionals. Also agree with keeping consistency with BSD
name.

/Bruce

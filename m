Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342FE9B37E
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 16:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1013C40E36;
	Mon,  2 Mar 2026 17:58:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C521E400D7;
 Mon,  2 Mar 2026 17:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772470723; x=1804006723;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5jypFgrqyJLzbaIlVgQJF/TRFdnZUkgs3gCScI+8zxE=;
 b=B1Uav9Vlx2HKk68R87wwb8+QxdUly2XsrvactHvHRnOPj3U0AAKJXlMO
 z0SVu/PrMdY+CDzzplwOhsJM8vIZDWiEjgO5uL/NsFWSpr4A+y5vF3NVe
 xb4078c4e9gOMX7i4Eivj+yrZ3G8l8N99ajtxsCEV40HTMLn+swlkkeoN
 wGryAtqVT1IVIDqkeGexEAc0ji7mM+vpdRkXdUI2sQm4qTeccS1RTfIV9
 QRiJxg0/1NhD4VD3bXisvIvEaiehDUT/OASzjd9LZNF2cZbSIB01YU5BK
 KDnfwqHKIBwUbZBysCp+wdS7r304u6Re4UItk5o0RbbZVTj2s4o7Vujc/ w==;
X-CSE-ConnectionGUID: nZ5hvg7SSliFR0jzhVadNg==
X-CSE-MsgGUID: HqwMNeuCSeS/DK6BBy3DQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="76089308"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; d="scan'208";a="76089308"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 08:58:35 -0800
X-CSE-ConnectionGUID: zr4Tyo+ORwmiu+ZfZcT02A==
X-CSE-MsgGUID: dh3gWsc5QViDIktHLYH9ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; d="scan'208";a="216950310"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 08:58:35 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 08:58:34 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 08:58:34 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 08:58:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAM0mPWSC3UchoMPp8B/GuJlIrIVF4S6aqueR/LZ20oCXgQydGEBhG25DNaW4mudJxBmCF0en3iMv6xSJGoZJhgg2rVFD6/JloaTg9AyJK+g5qxS5obSVcWPoFIJDLQ2MwlORmMLkj9T/rQdeovVDYhBqEde+1kveGsU2gVdWaP7/+xga92cTpsRZmoijjwKa932wyEf7JXR2/MNMInJn7tBbVjCYiPORRW+4Ed3egmcY8lHXlW2R4s8IqjTb0iEhPp+K5gEhnJpHs6GCoK+ZvTWhse+U/Fkw5tSyooVgEBcwep4srlJ3GjClGyz6/6JWrYlv618/Y9oY0g9MlDVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTIym4M1ujTECeF3BSKj/GyIE2elnFju4629CF+K4+0=;
 b=mEN9/Ae3B1u0fSbVm5QuedecSbFoWku6Csop8KTxcE6H8SjLfCAw/f2XkzuVA9ge7UEMn5BW/NQ3ybxriFiuOUU+je/NAUY8jw3WJkLPTTMhoCAi3QWwLugO2cMporDGqKgdfhWaOSym8yfrWMmVwk+2pw5F0JRwmqW72kpagqxdgtiPq8ncwFzPdBbLMhX7AFx9/rUBcEo2Rw0AnfTa2+BQL3IcKJjSNG0dvywHczM2F93m1oT51xpI1dL2hTNSMjHt5KZ6k1Z9HYmuKhHUNI4epWPQ8kJ22sybLbaZhGBatn+e13ueQ4h500m6iXOnHpSyQ6e0A6aRhj3/8QXj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 16:58:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:58:32 +0000
Date: Mon, 2 Mar 2026 16:58:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kai Ji <kai.ji@intel.com>
CC: <dev@dpdk.org>, <gakhil@marvell.com>, <stable@dpdk.org>
Subject: Re: [dpdk-dev v1] doc: update Multi-buffer library version to 2.0.1
Message-ID: <aaXBsxmQBJlvEZm3@bricha3-mobl1.ger.corp.intel.com>
References: <20260302164742.2230427-1-kai.ji@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260302164742.2230427-1-kai.ji@intel.com>
X-ClientProxiedBy: DB3PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:8:1::15)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 82157287-6e7b-4f67-4bd3-08de787cef8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 33l2iLCpQ7MPGgqsdo57yh0o0h+FV4LmuJ0M6fs57Jv57cICbAdWw4ykOctBbjBt/Wyix7E8CuLRUVS+9VTUpBor6DjYvc257hdxs4fC0PhA3XzIRsOGBnN0lRfJU/m23qghyWxZeZNVnxFtI2BNcMxuJ4ApuvSBCat+6qatBJIxou3k7+MGq8dEZ64cRy5ApDpOERs6bfXMz8RzNbSJ1i29lFDkohKEaBL0DJC/7Yn95p9uvBxrK7IWGNlVI8t5eqCldap4aJfkDYBhMnwkhjIYknRgpqCR6WI2Ib6a5Opv4rkUSeK3x9e52tzA0OavfZCqjWzsFEO0M222AO+mt38RGhvu6k0QraUL9JbOzu07+owe7zZR4s/bvMioNSX6P1FLT2QlW26y28fjEaF/29wADWArmVOVk7TQkp1EZQ4HdMwhn92gvKsJbOaCKmxOAsQWbZ29Do6d1GlLQ4qiPrGgmn2UFfsIs9M7eoRxGGhtjObOTzQqr2qiKMgE6srGeBz5vcM87/zA6MV/sreaty2hhj3/flB3BtvDpeL3WkqMui/HJ9A782p2WJyZqA7XyQcQfc6Ek4DZ9b28d1Tgs9Zl6b7ciTHqC3pA8kH6/OhUwayg5svIE/xklHUXV3w5PJGo3C66Ojaq4cRrPYZWPLsGq5h6MEvueIB3qihk56tmXNn3F/z5XEspKrP6wgi7llV4AvB18rlYcgZWrzCXAW8lsPizdBK9rxOwGrsmzpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Pn9WQWreTKgiQP7H0hMee0SVD4Cce0OpmruA5AdieVhNMwlJYnW1DWEhhwl?=
 =?us-ascii?Q?9iFhP2UaE2BQEbMvEO+ts/qLbKGEuRfNYr0oTFT4XrPhr4UzNGVUhqanOFWq?=
 =?us-ascii?Q?sFb7g7R4PBJI8ATCcVBqMjH5rAJ82vkSK0TmV6yzFhm3xnWYY5e+nkr3Rsqo?=
 =?us-ascii?Q?yxfmwnjWl/wc1GAj42QELVxcquBAnOfWIt83XLn7Ota40gIWSLkXiXWO/LQT?=
 =?us-ascii?Q?CuO7LXA6Hyyeg0Y43xmNpbBW6UzpzDqhJr577gIDRiVwK480jICrXp//63Rh?=
 =?us-ascii?Q?7Wbd2EJmw3dD4pDjeeEnQ88IBvTRW1ogYl2n+Hn9q0Hsmq7hYLHqKfNp59VA?=
 =?us-ascii?Q?M92b4HFS95wauY9E/AmUMmjMYAHtf9LmJZkpl7pcRn7Cm0YJW0C2dud7N75c?=
 =?us-ascii?Q?iKrFmcGdFQLcIhbxvoF6sETpsJJ9Q9vSUpAZ0WCFhQHbpzJ0YdVRgTuXTnit?=
 =?us-ascii?Q?w86vL4/2sOqny86weXar5pZEpoR7+VBV8+r10CoJLh9ULIfNl/PSG3EQHLOY?=
 =?us-ascii?Q?XLiADQ07qqF6bDO356mYoEr3DV9TSeI3vZ4N00yuv+Q53kcIYpGXNru+OJsT?=
 =?us-ascii?Q?n7p7+oxCv7N/zAA2ZoxzG5Wq7N9kjde6Pi3BCmvYR/iV2g9CFi3TUM95KyOg?=
 =?us-ascii?Q?NwhM1IltGFe3mR74axbMErfg0aP/FkNw8c/APbLs28D7/APjrQYMTVghc8Gy?=
 =?us-ascii?Q?WFeNTFDUmKVEijCOjLyglfFdGmc4E2RPJ3oMEa5C1XwGWI/xXqPxlCiiDilC?=
 =?us-ascii?Q?lXRPXFif+itsP8yWPJUct1R+vN7+yxjWyiN3Bc0AwRBw8C0cOPbd26r6vQU/?=
 =?us-ascii?Q?Tnii2ly/bXXEPgLwfP+Uoh4ZI3IbEeMbhOcriwk74KnAmhoaBZWxvox+f1/g?=
 =?us-ascii?Q?zoYYbyONitucBwvR5IHJEPScbUCeuof+4CvF2Ic3wqYxTvRaJ3dXS7O6Ygbu?=
 =?us-ascii?Q?O/cxjOrqdcWuvLZPUR9uHKjzqflkf2/+4605hYqDt3I8+WaYst6S8rv1vXAl?=
 =?us-ascii?Q?8nKxXtbza5hhUev7qTLzWjNBeR5T4MHCFca51nC5AAJEUGJwM3z0WWhPdpf9?=
 =?us-ascii?Q?cm4+6yVkWKgPvxZbtFp9bVkr9AAIhR83qdbQvDIBLdLgqd1IkfvHrhUWgJ5W?=
 =?us-ascii?Q?du03n2XBktR2BwnsDfRc57+X59E87jEqGW4D5roA/ZNdaJuIX6dgwFBSh+cR?=
 =?us-ascii?Q?h5XHEhiMQ0xsBELhmNGEwn+65Ggk1COjcucu6UlFBcMtvHtKuJwpw0S2j/LO?=
 =?us-ascii?Q?yr2VXWBXcjras0WjkEj1MeQ0gPC/eKsYVCQuHly4VXH7wvj7QV0keLNC2Em1?=
 =?us-ascii?Q?pD9HHFKsqKSGj6Nn4J1h1zvi3X3qFlT8PuO5TUYESqQ0MT9AviwuJK2QsaFW?=
 =?us-ascii?Q?ZOT2SF9feok6hOaV97sGOQS50AduDLLIjt+peslmiE7PfijegCarFpCF6V6X?=
 =?us-ascii?Q?obAPl/7PXi+X+nVb8roEG0MFqKme/JbM3TQnD/joDJ+owvhJpFy7w9J5aTkL?=
 =?us-ascii?Q?x9DjpsfhpWaFUQ9uoPxtGsIJRmoXgN2Twc0X2wvxKuVvlByjn2Wcaumd0uY/?=
 =?us-ascii?Q?sifht4p2ybvRYrRnwuny0OSNIFlXt5XTJ+E7ZRf6xZ0YRE01utUcXrVA2W1S?=
 =?us-ascii?Q?7Fvw/rfffj87RMvkvlyuikcvK++0wwxszPlAr42Kzv7XMh6Q3J8Ks1IufVD1?=
 =?us-ascii?Q?am80PEalkGscwnZnMnKGx5LvGYwJHkHMoEHbIgmdANmKgt67wuyQZZKHfsVd?=
 =?us-ascii?Q?6Aq0EBcLAcYe7LKwRwtP2SfHpTvQzE0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82157287-6e7b-4f67-4bd3-08de787cef8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:58:32.6366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17cD4g0FFGauoZxDPDQQQnNE0Te79ACJvB3LpY1NQGtLtyksnDZefJGM+hFuwhonaw6BUL/WcIQo184QFJEnHbfZyIbLix5IizBprcphWQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
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

On Mon, Mar 02, 2026 at 04:47:42PM +0000, Kai Ji wrote:
> Update the maximum supported Intel Multi-buffer library version
> from 1.5 to 2.0.1 for DPDK 24.11+ in the cryptodev guides.
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  doc/guides/cryptodevs/aesni_gcm.rst         | 2 +-
>  doc/guides/cryptodevs/aesni_mb.rst          | 2 +-
>  doc/guides/cryptodevs/chacha20_poly1305.rst | 2 +-
>  doc/guides/cryptodevs/snow3g.rst            | 2 +-
>  doc/guides/cryptodevs/zuc.rst               | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
> index 16bdaf3cb4..8d833c92aa 100644
> --- a/doc/guides/cryptodevs/aesni_gcm.rst
> +++ b/doc/guides/cryptodevs/aesni_gcm.rst
> @@ -75,7 +75,7 @@ and the external crypto libraries supported by them:
>     =============  ================================
>     20.11 - 21.08  Multi-buffer library 0.53 - 1.3
>     21.11 - 24.07  Multi-buffer library 1.0  - 1.5
> -   24.11+         Multi-buffer library 1.4  - 1.5
> +   24.11+         Multi-buffer library 1.4  - 2.0.1
>     =============  ================================
>  

Minor question - is it worth leaving the last version here as open ended
until such time as you get a version that is not supported in that release,
e.g. "24.11+ Multi-buffer library 1.4+"?

That would save updating each time there is a new supported release, and
you can close off the line and start a new one once there is a release you
don't support for that version any longer..

/Bruce

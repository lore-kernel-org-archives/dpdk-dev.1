Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC35C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:54:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 854EA4029F;
	Wed, 26 Feb 2025 10:54:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id CF28D4029A
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:54:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740563647; x=1772099647;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6ffBQ8qlgb8ss4/HQnBHjLGI7py4j+fNP3XgRQFyjZQ=;
 b=GFO5HyOjG+3mrp6YG22wAiLLHM7hFGvRIzQzZkhgyQWbO+rIBN73Okpp
 AZIZoPXGABjtU8Yy5dYBMcuxexZXyc0dGJu9+Ju8YPMaEAIJwj/IAN8z5
 H8/Mf3faj6OekjCodRVHMxYVqQfxJbAFsrCVU6fqx1q/W3+bI3b651oJ/
 Df1YpXB+c69osuwNU07XEo/XzXWQJ455v6CTdFyMukm930qKpCH1yBgsi
 k1aSIFkxekg9RBxlNkqKtLsnYkn6gOyZBLf3U8DaZ5uOrw7IKE62VJZMC
 Tyt7M03FbsV+dvoEpgQlSpeW9srznt6/aEK8dNTpuY4ljuKOpFMwK3N7T Q==;
X-CSE-ConnectionGUID: HzY12yvpRIeMq21SvOIpvg==
X-CSE-MsgGUID: L4DP+RXrR+yEcOdcvmgHiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41103242"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="41103242"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:54:06 -0800
X-CSE-ConnectionGUID: vTi+ZsaySEeV2il1S4walw==
X-CSE-MsgGUID: +JlqUL6pTFOYLQtGu8/lgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="120769963"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2025 01:54:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 01:54:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 01:54:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 01:54:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OodzHn3S2F6SegmHxzCievr/KnTOdmpUcDL3mERucxkIb2iaBdRD0ld4b0qLpmeW16WH/lMBDzkmMF4GexK2+jNDIJMX2wRwcanue07BRYJV+jOJ/y35IoYcNFW8csg1fYGbfI9Qn4q8JeNZPGf1Sc9ocoISvBvjgTolzhsOO1NEZ2rFMK3lRvQDtP1/eTTck6K0vfpgNRL54UYJkN0tVzmXO1mXzioag8tcBrkvinBBTT9Jwf48fnKdyOm1HC3P7nVl3K1U1hmWdoWsy73bWnuhhAHe9HSSPvK1IaYIw/RV0cIpk5+y0ilgJIv2xJDGSu/Q5tQtDwT+7THwpjJFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axz/zFrNppc1krrz18p9sQx6QaVUGF3zCfVXUaeKm+U=;
 b=Ty8ijaamIzlufsJtjm4l909P8n4cMw9BFfCWyjoaktoxRGOyEhheF3u29Iy/Li3I+V2IgteiK8cYgNTsZjg/sEl6xJ0laBLNv6sAPiACGLQ2MY5V9u4kgAgiYA2n9EplMa+Lx4MqbWHDsBXwQsp+OhmXIxO+pYvFIwiqFnqd+e21yF3RyBeKxD2lkrC+HqQXRmBKho2edmkvhJQCw9cs5OqpzI5tqeUjgzqcl+fj/L047b/XHXm8dcIHEdtWYDOmIwLTQuhDjtCFcklBNahuBqSl5HVeBjmYkSduuB93cEj5MkXghZ8P3RqGViRy3kiZo/qOIEcx3jTosGH9JfigPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:53:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:53:16 +0000
Date: Wed, 26 Feb 2025 09:53:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 4/5] drivers/net: make compatible with instruction set
 updates for MSVC
Message-ID: <Z77khxxsPFf_ZydV@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-5-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740532016-6789-5-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2cee40-1d69-425a-9a9e-08dd564b6415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6sq5yr+wbj6UOXwpnQhIOIoo+m4G016u61GdAjYuExXVUnx7mCoQKF+j2dHR?=
 =?us-ascii?Q?WI/3+5MQvsr8tIwUFTKfMaMMh0Jk9lRIYcFYtSFrZP51lv+n/25KsD7iyY7o?=
 =?us-ascii?Q?+fB91t4Re7Ev1dGQEG+AiP9AVVJ4rfsGbP6q2ugwHbd74FREBI5ojxhFARoX?=
 =?us-ascii?Q?71lsaTG+AX7KkzqWUhwMiznZq1+CuL06xavm2f0m1WHRT3ia3cez1AubcBLo?=
 =?us-ascii?Q?VCvXR7g5YXV+mtILE0YAvdQtVo1en7lEH40WCJuhXplNgJJCTwNkDji+OW+f?=
 =?us-ascii?Q?hcgn7HWM+FT7S6WhKSPCAsag0zqALuZenDf4vNO6bBIeIMo7FYqIqVJW3L5P?=
 =?us-ascii?Q?4XVr9janBqyide3YJhXKeVShhLLqg0Ezo7XpjI7EO+PVC0/uNO3xIMlJ1W99?=
 =?us-ascii?Q?YStEpkMt0Ke8uyHtwhpvppi7r1qzvdUWOdmMMvLjgocdmf6rWB0KWNZkNHNh?=
 =?us-ascii?Q?lcfmMqFbdxP2qnmrbLEeOv7YurmrlIQ8QoedftDw7IG1X2Kt2VGAD6IUT/I1?=
 =?us-ascii?Q?Bct9usBrCoBb3mZkVt5ZJx2Xk88Jb79XxNvo3vfksc0WafR/mOfw59vikcFd?=
 =?us-ascii?Q?YUzBJs77bkYeeFbBGI6ViT4ttQ9DXyFB4PmLzVIc+h/nl3QwLFYRZcFeN+Gk?=
 =?us-ascii?Q?3XXGSnqtZnrSfqrjEDFcU8F54ZRNWy4ZPz7gVDqCWKh+yHBxiGFB4OlCFUQx?=
 =?us-ascii?Q?BRWv6Se2QQJGlgx9SKodFqF4VtlOXSPhcCMDQmyqOQ1GdFHDaR3ZPlDHLdOe?=
 =?us-ascii?Q?DLG7I9fN8jdJY9JusaEtQfPe2CZhbvl36V+BVn6Ped5mNXxhXJSBejFpW99B?=
 =?us-ascii?Q?g75rq7QvkCdw2zfqBQW3B7GT8u01Q6bBBmjkfLiCWQIBIGieMBszi04r/UX3?=
 =?us-ascii?Q?8rBBNVsIZN1UIh5iKAHpc8LP7dkTyz8IJiH95F4P8q427fuzVyLxj/6Bd1UT?=
 =?us-ascii?Q?APU5KSzvP0T7VR97vsJNnU4XpolGisyL4cJ8i9HS03YAnMirOsYLgCr+ot53?=
 =?us-ascii?Q?NggFS3sksSRDV2AYiueaTVLH9JT+2Oe0UFyAykXUavGyW74R2J4I6Q7cJOS1?=
 =?us-ascii?Q?P2dd3GxfnXjZhQ3MK5WGhrp4Dzn1d30vYeCt2CAYMR99kTRQ2dW25DROehhh?=
 =?us-ascii?Q?mLaRSvqHG22cYeR9Pzwr1W7bAVGkDfMN5aXDrUBsJJNRv7SGQ95N+mRn0phF?=
 =?us-ascii?Q?ugu5WlBNgnHA8uEjLVLXEVlzA8GkUe0+w9q57EQcn91vUWqFdOAzkfUTYawO?=
 =?us-ascii?Q?kJYac5Epkgu0DC8/i606gFFT7zm7sYY7JOeicjlJ3kuSxLmIJDy1GPnXVvs8?=
 =?us-ascii?Q?1lfEv3OF1ng4OCIZpIAJ8aNUxAIskzw2InZP6xh2rRPCvgnOLesyfDgVBYyM?=
 =?us-ascii?Q?Sy1BHOcqkWdOaxET39y3kK4Y26fM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BgeY/cTTxBXjflX9LOhwuRQdnZhdYU4zixNOCFGjoXpZ+MLAbskBa2NtoyYX?=
 =?us-ascii?Q?A4GHgr1wJQuFQnHgTtFjKRDlFJmAhecZCHsAp4exYPMR9N4Cbt5EnwzNsn4q?=
 =?us-ascii?Q?D8DjgSVvi0DW08wO6SZyAKQcSj4UQKhezTldEry3kh4nS6tjaPHERUeVWuhq?=
 =?us-ascii?Q?Sgs857tYKw+QXHT6RxFV4tUgut+QknrtqjWYLCutfspEvVpcwi6z2S07dk6s?=
 =?us-ascii?Q?hww4p2rzVUDMutDLhl4CMyoHTqVRzUrc4+KXh2NNKokrcBwyoLjTx5TqxW6v?=
 =?us-ascii?Q?cLpz4HuwxWJqI5rK2+LSvlkBaunmXsz9m172ws+SjrNAKp8YDkHR0TDKiQ/Z?=
 =?us-ascii?Q?8yVMprl+/eRhH0jCwD+ohrlNts8B/kvRZQetlqYXh+FMBWv0GBTWjy/oCPJ+?=
 =?us-ascii?Q?uP0ifFwaiOzsx/e+DeWeiEsFNX/UkSzwe3PYuWgDpMe99Ch600ngl/HRK3iG?=
 =?us-ascii?Q?pUnqDGS0q15omSqFhVczBVUnFILgf3l0jJ7LQ1wODnf0KnLfa1II52b11iF9?=
 =?us-ascii?Q?GXUPwBaK3Dks/hOiomNv/jvc/9aQrNSbC2McXPuC2vm3TE/jk0jPDqKYAdHL?=
 =?us-ascii?Q?d3y2gg702oTLdmpxuOm8zoP5cwqcxY8kj5dYLkb5gSHzseTMysIDmqIuDs5J?=
 =?us-ascii?Q?+nuGWSku9weEYq3Ep9eVYqVj8bfcziDHJ6oYCSYKnJ4WXpDtMcQyMQd4dcnw?=
 =?us-ascii?Q?Ll3eicmxDgfaw0HYKpGtsBr3AdrgsHJh62uisD7SPe/eDskYfjJbcLGNQe56?=
 =?us-ascii?Q?xwHIneeWvTnhHswltvU0FAwhSo5DQTew3lK3kpZzcnJJY2syFDjVxbdlOkqV?=
 =?us-ascii?Q?e5T28mA91JlOUQOEvDo+UbeUaTJP2vTboP5IzMazApV9ezYCkim/doH/nIh2?=
 =?us-ascii?Q?1rM00ydbfnQXTBDTwBrI2v+1mb7MGHgiNR98/lhMAeMGAy+iDr2hJzuoCQAc?=
 =?us-ascii?Q?RqO93RK8TOkmEP49SsKebTB50c9Vk3A9v4M33aQv7j0Zteoo1gIy0xtnamvE?=
 =?us-ascii?Q?9QX+jNa5Orp/iVP57Vj+bRTNzOdkX2q2b895Y+3y0uIZ4N09N4N4jAsToBrF?=
 =?us-ascii?Q?S4+F34uKjKqiMjIRRBc9laNSBPBl9XiL0V15idJkihq0kr6U3DdfAZG+whsI?=
 =?us-ascii?Q?W3IwJIrD3Sw1bO8V8DgDVhnbn57B2G75vwUXvvvrpi/YwfOUC9+qt5il1IkD?=
 =?us-ascii?Q?EaIM97OZkFGbMOqPYdChGtvpJ5PVTshh9AGAIVJGKQtnMJ4DvIclnXbwEQRe?=
 =?us-ascii?Q?9q7DYCzJ4wNPKpBGG3DB1DVtvLIAZ1Q77z3dYj09PZg4fljqw+B6R/LSceL7?=
 =?us-ascii?Q?LrYvwWwhQMBCPVxT0MhW19xPVbik0dB1MjXDQ2hy7ADEo3P46k9VJFTM+4BT?=
 =?us-ascii?Q?csyoR49xYIR/hpJjjG71ujrAeasStpW0t0XL6ZASzIz3/YDRlZQ8NAfcfRq/?=
 =?us-ascii?Q?Do5SDj5qV0/cNWKmafzpuNFVW0sezXrNg6E8sTZf1QrwIN4E+WBN4oM7MshF?=
 =?us-ascii?Q?Q7UxvaMaRziBZ5T8UVHKDI6xBxaxeRmokl16fwDLeja7ECIiAnfkSlD2HF7C?=
 =?us-ascii?Q?fRg9tyrFwGoELRwNMM1nVRX1m6A/MGaWM22sjEz0u0L1NHToDA1wNzlm9gJz?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2cee40-1d69-425a-9a9e-08dd564b6415
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:53:15.9577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdrrevglQQx7KSYzQ9IPeY//2RuneRtG5ti0jSkKnngJ8Mm2iBkRYj9X/1qLxVvy3qgD/funxc8EC3pUOhJBvBIbDaAH85aPqIacrh+GMw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
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

On Tue, Feb 25, 2025 at 05:06:55PM -0800, Andre Muezerie wrote:
> Top level 'cc_avx2_flags' was created and holds the correct flags
> depending on the compiler used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

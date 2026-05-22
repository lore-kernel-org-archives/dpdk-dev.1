Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E43CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 16:12:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B5C402ED;
	Fri, 22 May 2026 18:12:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 25825402DE
 for <dev@dpdk.org>; Fri, 22 May 2026 18:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779466319; x=1811002319;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gkqOFdoBNz3BBeOCQwCpfUmFhQWZ9c70tJIP9Iuot/A=;
 b=jCRXOTW52LkFTswOW9Q4pRg4mBuSNoUPLxlTau2OhFO1mm7R1RdGmDMi
 HJr+3Sl2WELLlpkTGN9IcnF/zU69kgGeXHX75lLK0X/sXgL1lkKI+06sn
 n2r4KnaYdK1Hrc1Beqx1Pmb4QfpCmLKUaMdorGQzr+Mda0o5eA4tRlioE
 Nfipb+4qU2m1GpgsWG/0FyIdSS2PkVLw0FpQ1HOSAhDZ6rPnxAE9siSLr
 jxp30e5puoNGJLzzS8hSWwzEOt9eIrmWbnFj21z3Hzon9QhTyRnd64CKr
 InHaTQJi3qpYyxOBnGui1yltVxFqZ+bY2hrym2naxSYpi7SmwM9kxtm29 g==;
X-CSE-ConnectionGUID: 6gfiYTccQQ+SDY1/ZYrLSw==
X-CSE-MsgGUID: CGdfQclqQPK7KZJu2NpHNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97822510"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97822510"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 09:11:57 -0700
X-CSE-ConnectionGUID: 3whz7WsiQvOd9KDrfZCP8A==
X-CSE-MsgGUID: oPd2Mp4BQKiMet/LkvzS8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="264776373"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 09:11:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 09:11:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 09:11:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 09:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im+9dH8FOiL5GzLO03KFaaPQcv57SyU5XDST0JRa0GzDg+FRqYKhTE1cMw5w4uOokYJ/3YjLgUO14FY3eWMrM+7kvPKWVHfOwHSn1CsDZCfPgqBva5zoeBFbLsJ95WW3Tim6h0uHKJRJeuAhX+LzaccckVY/c+vsmxpwcELrBecuQbgLZv4bBzNEs9DLm0SSz0I7b/o1S33e+NPQQ5cnQ4xQEwsHt55BiYk/OVJHnsDD8Rrv3BdVXN4PPMFbffBEQ5ZzF+RxrrxRtD3Zmn/rpqr04uaAq9CK+T65zrzlUF8+3p3CQYHc9WenY+mAU3PfVeTnDY+VaOPjvo3BwrqBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piJ7fmGYRP9DOz0L0lnIcwvKAUzrda94o3fiRKpazeo=;
 b=AINAGlfNJA/b9sS3hIlEufnLbo7DDfsSabUj8ttCKvDAqUxc21c7srMRSeF4iqDGGkk0y4ejsVqkyw3ZWjh5BPEF03Ix/pbHxQ9/AduRHcakhXiUubgaDa+3qHEkbjt/+ysoyoqBWzNttLVm+10pRYsEDKGEGGhiZQtVTX4lp13YHkHlogP4fh68U6IpAxgo0npr3YJvZr8smMp+FzulcqqNnEC+s9ltLHeSe6hfmzZnPILcAuJewLZLx6Tp8Yop8y7C9X4KjBZwmbYeMlKax4ivnjdsQ9hDWGCsljGnwNp4dUKuNPXe0FdBvLpZ+utbMNEVi5NltE8mbhS3KHcHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 16:11:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:11:47 +0000
Date: Fri, 22 May 2026 17:11:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "Jingjing Wu" <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, "Hemant Agrawal" <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@oss.nxp.com>
Subject: Re: [PATCH v5] mempool: improve cache behaviour and performance
Message-ID: <ahCAPT1LEn_Rc7Pk@bricha3-mobl1.ger.corp.intel.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260419095526.39526-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DB3PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:8:1::37)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8d7671-677d-46db-469c-08deb81cd33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: SSRNC1pA3B/Jjz48YTpvuni/99o3D0S6N4rlfCcjvKwTiVrngWLCoTQpQO7Bp2/SmefHx5buCuRl3LG1eHXCJwAy8xNHKu89hD4+W5g/2jV/XlzwJWICf8GXuwC3MBhKfoskJWTunpbQzJQKrIxLZeTYPIZ7iO/GDO43F6/74Gv4VrcDw9Nk+qQmfWaOy0bXCH35UlMYxo6LjeE6S91uG7wHVBTdZnX7EA0q/ZoBzJh9KPEi90HJpbHfsDX8OQQFrh+o/ghKqu/1BYSUSiHIHdJqrffDNUTAa97l47BhJ1+kNC8ckQvBdlejhqub6K/Z3kCX4XE1siZVMRSAGmiveIZy7UM9358mATQs19vhvd+8m96/zzu1PqRUtlXl1k1gUxySE5LcDBxTGPehbdDE2Up8EvabH1s059K5cgLmbPA3mGtY/Qd1M4REonO24tUM5qvsTuP3FQqjwC0cu8ofLwvJCDJfyLDteo/pt2HhKKtkMFU4uAqwpwxpZANVVIuMca7imHr9Y3tWUVYYykAqKODwohcVAQsNd5jRN+nDT9pvBhM1FM1UY8ittk7qr7c7PIrxI1aozMW182r4/WsZphQzSBJ+N1wSNUOhU7vSGErC1Ieo3QVOFduUVzoUUV3jY77nJJi7b+UU5nwdRBM6zxUECXFXcx2S1l+5/b2JJSNtNJDEp3my8PCMtEBruNu7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?64WH5GcDQqlShxY49PrUK4zHuRi5edYUXY/NuL8hExOCpGK5B9VbvjGLE3?=
 =?iso-8859-1?Q?Nvm3m4KIAhYahDAtxUR40tu5EfwhM3ocirC4NquKEk86Ux0728gXINk2Gq?=
 =?iso-8859-1?Q?WwpDt3g1jGzjTgH/wVA7r9wK3PMjrtVRXPu2ci5Rah0zuHMInkv60ASMTB?=
 =?iso-8859-1?Q?VKbDvHfytQlcjxG13A46i6Vx+U/UOelYCrYGqqsMyI5KIrrRm6rCnRRkX6?=
 =?iso-8859-1?Q?lwoz0kc1srbzBmdnksgL9xv6WlgiZfntYCKgbag5ryGkUsZEa9Av7+TQ74?=
 =?iso-8859-1?Q?wUIPgYLNYWmv7YHpn1NvCjmlnFE00p9aGRAkn6APQBXNfuxaMkZeUnCWOZ?=
 =?iso-8859-1?Q?gxa+w9yduDabYAnPUH3AkqillmhupMHUlIp0HroJlt06uZxTS1wLGWJUcW?=
 =?iso-8859-1?Q?zyg452Ru82lrJ0LMygzutXgBaUQFp0Wb5MIioqzy+CnwWaZJ1ZnDOoPLjM?=
 =?iso-8859-1?Q?0qAtl5D0MPC+Xdm45z+0RnFsN91CSI/PmbibCzbAaLlS/q/SJGqoLlSJYK?=
 =?iso-8859-1?Q?g9uKPK/ECnMfcGbxKRit02LFF3z0jzbFPOfpNq3COJiJ6WfeeI5FbNqTGa?=
 =?iso-8859-1?Q?D5K0qAAVOa2w0AXwrXywCCdCQGgKWHnkFaV/j97nH/vg972emonq7YQgiS?=
 =?iso-8859-1?Q?W0hdrrt0wX0p6tPwY9dAntjKbM1gsW+7J10D40jd6frG8QMLKgLylxkSI+?=
 =?iso-8859-1?Q?5Y4YbH+xzb/Bi+s3tKy54mjFh5ML2kWwM2es7e4Gx60ByK2E8CKCxn3PaT?=
 =?iso-8859-1?Q?+Wgs5pfifISar16dFerId/yOS/OaSf0eqWA0hc6NMeV5BBVVvUQAYWWddF?=
 =?iso-8859-1?Q?gjl0n6Q8nEHiILEGOpW4mAS48GyS+WTHsAZn7seQpTep6xiI/jT13pEu01?=
 =?iso-8859-1?Q?IUApplGaQ5PUPkKfp/uvLUbR99YLvZNq9Ikq4NtH/EeUQgYDgbv9ShLgfy?=
 =?iso-8859-1?Q?lCMw3ubNeuqemx7gt7u0oHG5A5M4v3aj9RXXqE4kBztjPkyQMaeEWHSkZp?=
 =?iso-8859-1?Q?toxRXoZjocbvQzzq/kN64NIApOy4cheUfXB5PSRIZlGjg6tHn8GBPiDkYT?=
 =?iso-8859-1?Q?GxuLm1GOsB2Xq9JHj42CVg5/78cmKi7FV20+mALvw4ZamVxZp8OsXcxh9e?=
 =?iso-8859-1?Q?xyXs2aSLPVxa9rTh95Oi3ZOjvdUN2NvUBEAdxpD75xrzRfRIDUKdvlOqb0?=
 =?iso-8859-1?Q?uqmbLZ/nSD/KRVs4Yu8tfxriYT/CT83LZyU7X50hJOCxH1Ej02oOIDFnZ4?=
 =?iso-8859-1?Q?Cxz35UQEYBTai02XNLt2xer9fROdGbcLMC7za6ZZCI2Ir3DnS65ex/j81+?=
 =?iso-8859-1?Q?ZIjiR8gYlqQgzNC5wrz4f5WCSqewY+BQmkPnEc089aCLUDvtB0hmyBXo8K?=
 =?iso-8859-1?Q?HyQmMRM1IjhJUfwJTA3xsqnqpL4CmCWevIPa+uFV+Ijo3JtvIfB/05EItl?=
 =?iso-8859-1?Q?3CDq30zJISfh3A6bdi207+NePEjJh0ubhKtYi2Ixh6ChYcfxG5ic7qyEtR?=
 =?iso-8859-1?Q?dHMt7pO7t70nYOAkVrBNoHTH2Ifsi2zDFuiFob/Zc1zvTVEKIT3KoTPoyV?=
 =?iso-8859-1?Q?ubLhdB+4XVZY69b3pQWA4F65ra+SKIAInHFwMoKleNEyDnsoHI8CC/3h1S?=
 =?iso-8859-1?Q?GSqqWmC2ulJZ/Ew5AabsjpUpcXBdJDOQsEMsgrSGCr9YHoGBTdbbwrPD73?=
 =?iso-8859-1?Q?/2JjzK9i4wH2mfqynN3qba8OPGuBZ8Ro4VeATFV556Ttys/7Y1EsGFfhfX?=
 =?iso-8859-1?Q?yaBUrwZ/9ofaosahHCYlhSst7lzRH9xKUGKl7FoBqGqo/x1Ia3FLaNQgre?=
 =?iso-8859-1?Q?Xnlz3Nr0HSH8e61Ek3lDDu/Oufs6yss=3D?=
X-Exchange-RoutingPolicyChecked: h28vnY7EV9UyWjmBsLwuxSCH5/A4DiiKBnWuFkQt4RDeuuDRqSGV3HvA2jQNTawk7zf0iUzIAU6FttHXWfe8A+Hd0KLbnwNyxK764Ib3MnOjBJQpX7t23LtbzZsaz3yFddbB2XnqKFpz2TdbwM7gi2U6aJL1uI3alvU+qJBfgm+tFGvxm5HyHhmCuWc7oGV/5x+KgyVTN7dcUxop6ziWvhj04z2fmqz5AyE7IyzJdPOWlBrIadQNEWOQMa7TA8DVSGSLPTHD45hn2FY0cImFsXTLkxigO37mSmJzRJnHKhKAtHGHg7IIjLQKgO0NFrBcl5R3D/84eqmageCdLOCH5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d7671-677d-46db-469c-08deb81cd33d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:11:47.8425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr6CwQZAwN6PD6qNtyJVKgiDanmT0X8rs8cQZpz6omNDYr2ZTGCcnpgZ6oEOUnpipKqMPjUR3PHRoXz0xnj0HI3IibeMYFmDo5XZRc7Cmh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
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

On Sun, Apr 19, 2026 at 09:55:26AM +0000, Morten Brørup wrote:
> This patch refactors the mempool cache to eliminate some unexpected
> behaviour and reduce the mempool cache miss rate.
> 

Agree in principle with most of these changes. As we dicussed at the DPDK
summit conference, only issue I really have is with the threshold limits
here - allocating and freeing only half the cache at a time seems overly
conservative. Thinking about use-cases:

1 for apps where alloc + free (generally Rx+Tx) is on the same core(s),
  then we should run (almost) entirely out of cache.
2 for apps where we have alloc and free on different cores, then we have
  some caches always being filled and others always being emptied

For case #1, we only need worry about the thresholds for the odd case where
we have a burst that causes us to overflow our cache (and we can't increase
our cache size to cope and avoid that). Otherwise the thresholds don't
matter. However, for case #2, the thresholds are constantly involved as we
always are going to backing store. In this case, we really want to have the
allocs *always* fill the cache completely, and the frees completely empty
the cache.

Because of this, while we want to avoid cases where we fill the cache
completely only to have a further free causing it to be flushed, because of
case #2 we cannot be overly conservative in how much we free/empty.
Ideally, we want to fill to full less a single burst, and empty leaving
only a single burst in the cache. Unfortunately, we don't know what those
burst limits are, so we have to try and guess the best behaviour from
everything else.

All that said, commits with specific suggestions inline.

/Bruce

<snip>

> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index 2e54fc4466..432c43ab15 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -89,7 +89,7 @@ struct __rte_cache_aligned rte_mempool_debug_stats {
>   */
>  struct __rte_cache_aligned rte_mempool_cache {
>  	uint32_t size;	      /**< Size of the cache */
> -	uint32_t flushthresh; /**< Threshold before we flush excess elements */
> +	uint32_t flushthresh; /**< Obsolete; for API/ABI compatibility purposes only */
>  	uint32_t len;	      /**< Current cache count */
>  #ifdef RTE_LIBRTE_MEMPOOL_STATS
>  	uint32_t unused;
> @@ -107,8 +107,10 @@ struct __rte_cache_aligned rte_mempool_cache {
>  	/**
>  	 * Cache objects
>  	 *
> -	 * Cache is allocated to this size to allow it to overflow in certain
> -	 * cases to avoid needless emptying of cache.
> +	 * Note:
> +	 * Cache is allocated at double size for API/ABI compatibility purposes only.
> +	 * When reducing its size at an API/ABI breaking release,
> +	 * remember to add a cache guard after it.
>  	 */
>  	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
>  };
> @@ -1046,12 +1048,17 @@ rte_mempool_free(struct rte_mempool *mp);
>   * @param cache_size
>   *   If cache_size is non-zero, the rte_mempool library will try to
>   *   limit the accesses to the common lockless pool, by maintaining a
> - *   per-lcore object cache. This argument must be lower or equal to
> - *   RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5.
> + *   per-lcore object cache. This argument must be an even number,
> + *   lower or equal to RTE_MEMPOOL_CACHE_MAX_SIZE and n.
>   *   The access to the per-lcore table is of course
>   *   faster than the multi-producer/consumer pool. The cache can be
>   *   disabled if the cache_size argument is set to 0; it can be useful to
>   *   avoid losing objects in cache.
> + *   Note:
> + *   Mempool put/get requests of more than cache_size / 2 objects may be
> + *   partially or fully served directly by the multi-producer/consumer
> + *   pool, to avoid the overhead of copying the objects twice (instead of
> + *   once) when using the cache as a bounce buffer.
>   * @param private_data_size
>   *   The size of the private data appended after the mempool
>   *   structure. This is useful for storing some private data after the
> @@ -1390,24 +1397,32 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
>  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
>  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
>  
> -	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> -	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> -	__rte_assume(cache->len <= cache->flushthresh);
> -	if (likely(cache->len + n <= cache->flushthresh)) {
> +	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> +	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> +	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> +	__rte_assume(cache->len <= cache->size);
> +	if (likely(cache->len + n <= cache->size)) {
>  		/* Sufficient room in the cache for the objects. */
>  		cache_objs = &cache->objs[cache->len];
>  		cache->len += n;
> -	} else if (n <= cache->flushthresh) {
> +	} else if (n <= cache->size / 2) {
>  		/*
> -		 * The cache is big enough for the objects, but - as detected by
> -		 * the comparison above - has insufficient room for them.
> -		 * Flush the cache to make room for the objects.
> +		 * The number of objects is within the cache bounce buffer limit,
> +		 * but - as detected by the comparison above - the cache has
> +		 * insufficient room for them.
> +		 * Flush the cache to the backend to make room for the objects;
> +		 * flush (size / 2) objects from the bottom of the cache, where
> +		 * objects are less hot, and move down the remaining objects, which
> +		 * are more hot, from the upper half of the cache.
>  		 */
> -		cache_objs = &cache->objs[0];
> -		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
> -		cache->len = n;
> +		__rte_assume(cache->len > cache->size / 2);
> +		rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache->size / 2);
> +		rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
> +				sizeof(void *) * (cache->len - cache->size / 2));
> +		cache_objs = &cache->objs[cache->len - cache->size / 2];
> +		cache->len = cache->len - cache->size / 2 + n;

The flushing of only half the cache I'm not so certain about. I agree that
we want to not flush to empty, but I also think that we want to do more
than a half-flush, especially since we do an enqueue to the cache
immediately afterwards. Consider the case where we have a cache size of
128, and we do an enqueue of 32, with the cache currently full. In that
case we only flush 64, reducing the cache to 64, but then immediately
bringing it back up to 96. For cases where we have pipelines with all alloc
on one core and all free on another, this half-flush would be inefficient.

Instead, I would look to have a lower target threshold post-flush, and I
would suggest 25% - taking into account the newly freed buffers. For
example:

	/* if n > our target of 1/4 full, flush everything,
	 * else flush so that we end up with 1/4 full after n added.
	 */
	flush_count = n > cache->size/4 ? cache->len :
			(cache->len + n) - cache->size/4;


>  	} else {
> -		/* The request itself is too big for the cache. */
> +		/* The request itself is too big. */
>  		goto driver_enqueue_stats_incremented;

I think original comment is better. The request itself is not too big for
the whole mempool, just for the cache.

>  	}
>  
> @@ -1524,7 +1539,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
>  	/* The cache is a stack, so copy will be in reverse order. */
>  	cache_objs = &cache->objs[cache->len];
>  
> -	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> +	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
>  	if (likely(n <= cache->len)) {
>  		/* The entire request can be satisfied from the cache. */
>  		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> @@ -1548,13 +1563,13 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
>  	for (index = 0; index < len; index++)
>  		*obj_table++ = *--cache_objs;
>  
> -	/* Dequeue below would overflow mem allocated for cache? */
> -	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
> +	/* Dequeue below would exceed the cache bounce buffer limit? */
> +	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> +	if (unlikely(remaining > cache->size / 2))
>  		goto driver_dequeue;
>  
> -	/* Fill the cache from the backend; fetch size + remaining objects. */
> -	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
> -			cache->size + remaining);
> +	/* Fill the cache from the backend; fetch (size / 2) objects. */
> +	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs, cache->size / 2);

Again, the cache->size / 2 doesn't seem right here. We at most half-fill
the cache and then take some objects from that, meaning that have just done
a re-fill of cache but end the function with it less than half full. Since
we take from this value, I'd suggest just filling the cache completely.

>  	if (unlikely(ret < 0)) {
>  		/*
>  		 * We are buffer constrained, and not able to fetch all that.
> @@ -1568,10 +1583,11 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
>  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
>  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
>  
> -	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> -	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> -	cache_objs = &cache->objs[cache->size + remaining];
> -	cache->len = cache->size;
> +	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> +	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> +	__rte_assume(remaining <= cache->size / 2);
> +	cache_objs = &cache->objs[cache->size / 2];
> +	cache->len = cache->size / 2 - remaining;
>  	for (index = 0; index < remaining; index++)
>  		*obj_table++ = *--cache_objs;
>  
> -- 
> 2.43.0
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5297CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 16:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5EF74065B;
	Fri, 22 May 2026 18:13:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 77B22402ED
 for <dev@dpdk.org>; Fri, 22 May 2026 18:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779466383; x=1811002383;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Wp+rMVra7hA3V47TW292nAJ9THTAIIbSSJsCFhlEXfQ=;
 b=XK5rLVgbzJdKbEYoUsj3x4XjHEejLdepA9Mn2M3QWNhBnhL3mbD6I6p+
 kkzE9P5qjZuSLkfFBTTm85kJpQ7oSOo94P5kc4E6qKFQq6C1Ra/yZkrx5
 pnEWzH1dQWYl1O7B6j+krGNQg6X4+IdaHu28MwpwgmgMltRVCSKQKTQ3s
 6y/DzwHjUktaQIsbFptliwQPJAbJaBwPZulJic7Kk94BWHqOAgaAgCtg/
 9VARb0z9PjD5awDLM9+SP3wa69+it1FyD+qZjAj5TGgDpSkE+/NFhINlu
 dHXxFqx0c7SYHmA1OPfK5CsN/abL+97j4RimET0SOsFwJva6pax/u/uMj Q==;
X-CSE-ConnectionGUID: AATR/6DRQOekpwMSIxwYOw==
X-CSE-MsgGUID: CD27JGpvTfuFJK0cikYmUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97822603"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97822603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 09:13:02 -0700
X-CSE-ConnectionGUID: NIZSTCpDQ7SUUlxGpxhbPA==
X-CSE-MsgGUID: vmSfSPKCQcabYRF1gjQuzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245932795"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 09:13:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 09:13:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 09:13:02 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 09:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id1Q4DRGYlVx9pRpRaWoWtmvyKs5CRoFh9fdDFTTIN/0vEDoYfU6SBM4tftXPgWGObxEGgh5sv2U7Hazl7d9tALUFzAxaRVbC+BeD6gpF6RhyAqBINTnCZrqNopQUlA1HvCBmSD7IAAOnngVOCX+eh3xw8g3+WoZLoiqXOyf04IRt/N77iZDaYpGL3MIuR1VDxBGetm0o77E1kr5bs4P2ZsmeS5cSaLra7At4QHHIP23Pj5KJC+4tGySjcd+qL0K+oP0mHa0JNwe5k+07FAIHJk1LtQjXYMWMPRHmcYy+45o4ZTwDjjT126aV49c2SM77ZsO8j1v4LWdMjXe4qhkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWaRknaBWnc0+z6p9PSOml0WZq1ai8U/R3PIL2Y8oE0=;
 b=A7kV4lz4TtjXw3AnIPdu2wH6gw69Fnx8m3omAe1axXf5TpwIT1GAd3nIXpgnYabUctS/jaQr4/SJn/GMUkcyeUsWWjXeCbwYZklYe0tveqs4eywm2NA7gGp5xlWZCLLfsXHHUPhRuWUCznldsonPHr6RwGhrVrMRfwHpFNz1mGk+O15AfHpDZRUYRonsvaeKypTswaURdpjlsA+IwmyUNeztKQr39IQLrXZLFAzRWf/6SJTbis5HldyPBBAfqqHsXTuqTW7WUD8+nd9/PGHJAFk3t7wCrIHXQicAKod9WxT4Ga4pwwgLT8WRQLOVvo5D4uCghbT9+Nvpuzb/aUXsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 16:12:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:12:55 +0000
Date: Fri, 22 May 2026 17:12:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "Jingjing Wu" <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, "Hemant Agrawal" <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@oss.nxp.com>
Subject: Re: [PATCH v5] mempool: improve cache behaviour and performance
Message-ID: <ahCAgitAAK3e5Kf3@bricha3-mobl1.ger.corp.intel.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260419095526.39526-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0273.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ad5f27-eb16-46d5-cb37-08deb81cfbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: QkLhqr1MwNReZQJz6Nq1jbL60k3Yblb7masrGyRFjZ4OxclbKHJ5HKEJHTGu+k9LvLeCIcDSRFSt4co7qR+sb0J4mYCoULzHYyHVslm7Non224Bfx7ZXiycO6pnCvorrT/qSVKxpiwCACtMG44FMfzTKsnRI/8cztYFwISXw6+JwUNCd+1tmw8zNICtH80Mo90XaUx0S7ngxTKz1qarrf13DlRYT2ODz8Aqdo65bjzSqEwPFZoTuD1eHf97ac0hdxfnuRxQ2JvsqGqMetUQF6cc/ZRPhUqsi+mY+GJCFcTMmJoROHl0+53zZUHxCpukchbVNBv95GviUBAU89Mzap7wIrwDvmXmVU9xzjJlDEBow+i3flBW99ug0KsgOk8B6XVaWTClVs/mfxH29nSHFgEimQGGrkrGTIEJD5LKjK+pN6NRkjznTjs/5UP5RdT6cIQZMuAGbNc35KsQhr+n8O/Z5wWY/wbnsqaGkDZdQ2wLfjgWBGWYvLnrS7B6FT1SE8DXRgHbzkDrBxK6qVeT6pRTeAMXRTDEsrqRJvc0m9n2ACMzw4Fl0tWAVAHstT9m03JZiT5MDFqTWm8AUQvfGMyD7nEs1bTnJmuYlcRluBoE9mQDD8ye/pBmrzOpi9XS0QQjX8snYkw8F3AZCfXqyjNccSalq1OX+/r7DJGGbV9bC3LFzy5ogXjN3/OMQ190u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iEfVHmjMbFAoQVsyhL5KexWpb8Bb014tO8FFq2Pa5oEdZc3JezUYnm6MRB?=
 =?iso-8859-1?Q?091qtfoAkxDCWnayIHt7cxUzjE9qFFLpyskzLL+G2EZ3seTkFII+uZD53C?=
 =?iso-8859-1?Q?FRXnLAtarBZjD9TIVnFEe87pKnS904Yw+Kxblk8l9RCuamcs2SDc6NqCCh?=
 =?iso-8859-1?Q?+5HR6VtrWejEr1gEVCin4MotI3d8ddfa15YW2ogCpVmi3kd64k2IhEFBuh?=
 =?iso-8859-1?Q?EIFNKF59ovaMmgWIK45zwR0w4boWaZmXq9GTxuOsDeaJzE/RRgza4EcbgY?=
 =?iso-8859-1?Q?hYq3EZfixjdQM6q+MmzOhRNBaZfuQ11OIuRG57gsRjzIPXCAAmk+i4AWd0?=
 =?iso-8859-1?Q?SgfSG3FAYQO93rddB0nvq/GbTixJxQTr7bO+uMNkWdAbFoW8LsbMAKTbyi?=
 =?iso-8859-1?Q?d2fcokEi48iHqJjkLx9SoyTnBCWMRf9Wy/OaqmbdPWlO3rQLgsGkrG1Kgn?=
 =?iso-8859-1?Q?bdLyn8rq7IozM9fXbGVG7sn9Nw013/8fWC4QLmNBTdOckI5mPHyP/VkavT?=
 =?iso-8859-1?Q?c578XYbDVzqiEcBsXbvRjM3MdYvb/5UMw3z44kTIzeaJeT/JUdgEVc9TQy?=
 =?iso-8859-1?Q?q4yofVaFBVvo8Bgdwy1UZlOMNYNpLzCXMxZN2XjECk4HryKTbRt/qUVykE?=
 =?iso-8859-1?Q?nB9ZJm+uEbxcGqoVZEGQfy3jloyQXD9ijo3Oi1vx4PDExVuJaYOajcFZ5Q?=
 =?iso-8859-1?Q?xxQS7359B0a/dGpnwXYbQaTt7H3eV8YNm92sBUdU1wdfqb/N2AtUvmA907?=
 =?iso-8859-1?Q?wFQHcfCWyvyh+PbKnz73NIqnjFdYWuZJ6CSLGyzKNbEEJmHF6TIJI4PCPn?=
 =?iso-8859-1?Q?tOFrLBFfHS8hIyngg2BC8JZVp3f5Eanno0GoEAw3jzntAXWfz6u6JDhCjj?=
 =?iso-8859-1?Q?+qIMe3l4oLdGZAVdSRzvHHX667YzGU4/fE5kxMxnwPZpFSzFabOMUZ6TYd?=
 =?iso-8859-1?Q?pjX4sZXyAjUg5rfe9hQqSp8Ys8H3/Ss8z6TFf1N/Otf1c0Ina68xZyVysk?=
 =?iso-8859-1?Q?1oqO9cG5s8h8DFTVF70kbTXX3a5RDTH/AjiMGVBKbHm7zXqScWYSZL6Qss?=
 =?iso-8859-1?Q?D+7DcQJDUTN0TM5MRwV1tRxj3T7MYAGmNxcOlCgNP+5V6pu9PA8+iwJQX0?=
 =?iso-8859-1?Q?N1gASneH41VUY0Vfv9gaLu0P6ggLyeiPyEr4pezCZapuD8btNOeboiC0Pj?=
 =?iso-8859-1?Q?OXmgWZMwAdj1ZSLE4FCmjcQAZX94xPzHCF9pCgdkP+nINgaEHU+Wx5rK68?=
 =?iso-8859-1?Q?GqX/Pj/wESRGHZuElDj0OrMoZ3iUOOLqRI+gOg6HRvGPVIBcZHWWEHmOI2?=
 =?iso-8859-1?Q?nPDW/1QLQ7ErBWAQh+WUdm8pI3JfISQPLheuXn3py8JZlVPRweOt7FzrtM?=
 =?iso-8859-1?Q?7rY6bBIaV0VcdUntVNOXLU5hRXOkID/pTwJlNOd2EPXQBr2VrJzXmzm7d6?=
 =?iso-8859-1?Q?egnI3nFYi/1BXk1Pvtp1iohuOoL8jwmgcKjBimFJbW/OLqZvACQPt6Q0hu?=
 =?iso-8859-1?Q?zHrYw0kkXOgL++SIW+SSjTohJqiSNJO1tVshvflb+ReFPWfsx4kidHSacM?=
 =?iso-8859-1?Q?M5EHLSWVHSPfQV1Y1Nx4iTON/QB2KdOxagXsRzGiy+6t74wwKCdfN0Ph16?=
 =?iso-8859-1?Q?2T7W4hn7VAxmXORFIF1B4FZlJZVUiaFxbLJUv3dX/AeELMjiYMHUrhOodr?=
 =?iso-8859-1?Q?+UYMK0vyDzvtDo2pzy4uHYClYwoUn563P9M8Wj59qjEsBcmEfYp7mrdcNm?=
 =?iso-8859-1?Q?bJ+Th3dQiyx9TdQ9X7E2pd8Vi8tqCRRP1PDpB21+u2dzuuyqRLaMKwbfDn?=
 =?iso-8859-1?Q?bOh51NnaAXgNgW/dkFMViZOWJQdtqJg=3D?=
X-Exchange-RoutingPolicyChecked: Mx5XtrB2T69vuD3DbVqOpkL6UhfSiDY5QA53D0wErMyT3mPYhWwJAwHnHQ6v02bFgS+cfBhW2+TV+CakzDMg3Z7o91aB3iDp/kINfvHefuuE+ii7lmr+nm9UlfrJjvHBcuyA/CrKW3cIiFMM1B91V0p4uSnwZsxQlINJvmHP0PmjM8ZU/a0D9Nv4ccfOrQA/eX2nEsQWYYqCUP332fy5fy2c4YRyIRXrEgyVG13QpFqxJjB8/hVb7IlfVt7n0RsFbE7ievdxJiFIc+e0D1e0V2JoJmQ/s/Fi1hYotTWYhqiNJn24QoX7C0a40qbXJyEp+szTMkl9PrZOlae1OpxA5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ad5f27-eb16-46d5-cb37-08deb81cfbc2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:12:55.7691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYeM/+jtagY3FYaf4UP9C++jt58jduPZXicyBjvl/b07t9Ca0x7ZtbP2T8SOZ31fSSAFiWOuc19Q3WNwEMRM9KdwOsiW9vBLT3CfIYDWD4s=
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
> 1.
> The actual cache size was 1.5 times the cache size specified at run-time
> mempool creation.
> This was obviously not expected by application developers.
> 
> 2.
> In get operations, the check for when to use the cache as bounce buffer
> did not respect the run-time configured cache size,
> but compared to the build time maximum possible cache size
> (RTE_MEMPOOL_CACHE_MAX_SIZE, default 512).
> E.g. with a configured cache size of 32 objects, getting 256 objects
> would first fetch 32 + 256 = 288 objects into the cache,
> and then move the 256 objects from the cache to the destination memory,
> instead of fetching the 256 objects directly to the destination memory.
> This had a performance cost.
> However, this is unlikely to occur in real applications, so it is not
> important in itself.
> 
> 3.
> When putting objects into a mempool, and the mempool cache did not have
> free space for so many objects,
> the cache was flushed completely, and the new objects were then put into
> the cache.
> I.e. the cache drain level was zero.
> This (complete cache flush) meant that a subsequent get operation (with
> the same number of objects) completely emptied the cache,
> so another subsequent get operation required replenishing the cache.
> 
> Similarly,
> When getting objects from a mempool, and the mempool cache did not hold so
> many objects,
> the cache was replenished to cache->size + remaining objects,
> and then (the remaining part of) the requested objects were fetched via
> the cache,
> which left the cache filled (to cache->size) at completion.
> I.e. the cache refill level was cache->size (plus some, depending on
> request size).
> 
> (1) was improved by generally comparing to cache->size instead of
> cache->flushthresh, when considering the capacity of the cache.
> The cache->flushthresh field is kept for API/ABI compatibility purposes,
> and initialized to cache->size instead of cache->size * 1.5.
> 
> (2) was improved by generally comparing to cache->size / 2 instead of
> RTE_MEMPOOL_CACHE_MAX_SIZE, when checking the bounce buffer limit.
> 
> (3) was improved by flushing and replenishing the cache by half its size,
> so a flush/refill can be followed randomly by get or put requests.
> This also reduced the number of objects in each flush/refill operation.
> 
> As a consequence of these changes, the size of the array holding the
> objects in the cache (cache->objs[]) no longer needs to be
> 2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and can be reduced to
> RTE_MEMPOOL_CACHE_MAX_SIZE at an API/ABI breaking release.
> 
> Performance data:
> With a real WAN Optimization application, where the number of allocated
> packets varies (as they are held in e.g. shaper queues), the mempool
> cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
> This was deployed in production at an ISP, and using an effective cache
> size of 384 objects.
> 
> As a consequence of the improved mempool cache algorithm, some drivers
> were updated accordingly:
> - The Intel idpf PMD was updated regarding how much to backfill the
>   mempool cache in the AVX512 code.
> - The NXP dpaa and dpaa2 mempool drivers were updated to not set the
>   mempool cache flush threshold; doing this no longer has any effect, and
>   thus became superfluous.
> 
> Bugzilla ID: 1027
> Fixes: ea5dd2744b90 ("mempool: cache optimisations")
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> Depends-on: patch-163181 ("net/intel: do not bypass mbuf lib for mbuf fast-free")
> ---
> v5:
> * Flush the cache from the bottom, where objects are colder, and move down
>   the remaining objects, which are hotter.
> * In the Intel idpf PMD, move up the hot objects in the cache and refill
>   with cold objects at the bottom.
> v4:
> * Added Bugzilla ID.
> * Added Fixes tag. For reference only.
> * Moved fast-free related update of Intel common driver out as a separate
>   patch, and depend on that patch.
> * Omitted unrelated changes to the Intel idpf AVX512 driver, specifically
>   fixing an indentation and adding mbuf instrumentation.
> * Omitted unrelated changes to the mempool library, specifically adding
>   __rte_restrict and changing a couple of comments to proper sentences.
> * Please checkpatches by swapping operators in a couple of comparisons.
> v3:
> * Fixed my copy-paste bug in idpf_splitq_rearm().
> v2:
> * Fixed issue found by abidiff:
>   Reverted cache objects array size reduction. Added a note instead.
> * Added missing mbuf instrumentation to the Intel idpf AVX512 driver.
> * Updated idpf_splitq_rearm() like idpf_singleq_rearm().
> * Added a few more __rte_assume(). (Inspired by AI review)
> * Updated NXP dpaa and dpaa2 mempool drivers to not set mempool cache
>   flush threshold.
> * Added release notes.
> * Added deprecation notes.
> ---
>  doc/guides/rel_notes/deprecation.rst          |  7 ++
>  doc/guides/rel_notes/release_26_07.rst        | 10 +++
>  drivers/mempool/dpaa/dpaa_mempool.c           | 14 ----
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c      | 14 ----
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 52 +++++++++++---
>  lib/mempool/rte_mempool.c                     | 14 +---
>  lib/mempool/rte_mempool.h                     | 70 ++++++++++++-------
>  7 files changed, 104 insertions(+), 77 deletions(-)
> 
Can the idpf and dpaa changes be made in separate patches, so we can review
the mempool changes along in a single patch? Even if the commits can't work
logically together, perhaps they can be separated for review, and then
squashed on apply?

/Bruce

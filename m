Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E25E81A5D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB3F640296;
	Mon, 16 Feb 2026 18:34:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DDDD040289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771263256; x=1802799256;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ve5zaNUJhlxCT8bikVzsGbY6+yAG5rXOJT9KK0EqBTk=;
 b=Sre80Y5ZGCfITIeVpHr5UO9ILG+LkRQmU3feLIVlUD6MlVygDzmbP7v6
 SFQTZ71J0xgTE2rLQXZ0vIwUztcTgx60v+cvJ6spbYW7U0OUZkeerh097
 TlwMgateu+11zSWMm7AQKon6S2mPQCdd391gZZzlA0u1/hrMOcd/y+6qH
 SYkMTlHvgHSHWCsaITtSH8/O6C/dycXxrR/y9SBYJzttRZXHPvoiGLBCB
 i9HX+76oT5BE24hTGwMSLxQOjNvvrhMrxdnJ8D58+8J8tdoeqSDU/PgFl
 8UJ2Iw3bRO34TB/5Y2kH6KPFKdyYZLbjJB6f504cKwmvHd2Z0HQT3za0p Q==;
X-CSE-ConnectionGUID: fo9xKdTiSdyfgfz5bvXPNQ==
X-CSE-MsgGUID: yXy/c/BtRLKAZZSL9EDbJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72244823"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72244823"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:34:15 -0800
X-CSE-ConnectionGUID: aFUXwY0CQy2wYUOhJv5XUg==
X-CSE-MsgGUID: 2hojICGbQiqy7VM1bg7QEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212971097"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:34:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:34:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:34:14 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:34:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdh7hFsj5W5fPpImW13W6BmfACo0+uGEGFflcAW4q/I7gjzet+BzGcX/pvsHGPVTLzW18fjsdSmxHHsbhQfNrFKRs8IY2Ozc1RPDbOylDs4EyswvWrWXOhNkmCWMfWCLSF9GagZKQybECA+RmySmmY8DEdoTuRe9TYXFMgCHpqQUTBGm5BWcK3E6k/VFKPcHWVnpcayiJG1KIhfkI4GqEnufhv1HPj3REcKbFQ6xfQ26ZEK6c418pixXfYyhqY88Za30f6NFovK450s1L9Cx+huMVlu6MAs/29ROX5wedBX0UJlhE8oTkZuITixPRMKhUVicLpL2wxuDYXNdssGdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxziXT+0p+xsR/3osLH5ctFs/f0jCOI3CQLCjrUlOLY=;
 b=f3paSi8jI9P3ick5Dkg2hS98Vxzf7zfHSGD11H1UQTuL6syhhTgKpec8jvM+/OxhQoxp8nKTdgBY3fEE8esO+TKCzSzDD3DP4nnt7rS7LDIfc2NbXQISQzfNj/2XxZ5uRkaGoeSbtuZUMhK+tKZ1nWPmL7v26j4BbuIXRtkcLqILHjUmkx7VpoyjQr/aGSTUbDspsOPiLKOLSKSGWH7WpW0z2ZmnBb5K5Rqam/4SH1KHp07yU/O7XCXWWDFYvpxQsrqzVTMbuHWyxPyor6n0lOX0VIk/O0DFe/rhiVrvdZW+Uc2vUQIeITkDfBzYa+KXZR5Bi3WvwDHVjEDgUr7iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9452.namprd11.prod.outlook.com (2603:10b6:8:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:34:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:34:12 +0000
Date: Mon, 16 Feb 2026 17:34:07 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 26/27] net/ice: avoid rte malloc in raw pattern parsing
Message-ID: <aZNVD_m9qk-kzcWr@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <57ad21a01563d1de714879d25f48dc89f7dc1273.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57ad21a01563d1de714879d25f48dc89f7dc1273.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 88452a59-d64a-4b04-7934-08de6d81991e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wRP/2+q6o8igcBKFX7l/mVLA+dWZ5ZI+jvIcmnTiRPOfEv7oN6m6ST+pw4E2?=
 =?us-ascii?Q?dTY3Xjzqk+gx03241l6Ok4cW2D8Qoa2HPKBmmwHVzsifCJqvXin1xVA1E+m2?=
 =?us-ascii?Q?AqAAZYRf7cFHiIQ9GqHUAEd+x5jkKWpPPJGCEKTFuoQglbixP2vTsaBC86Ai?=
 =?us-ascii?Q?VQhLVyclTcOvZLG4wHUTH9D5+pwYQlCwsxi3d05LJdGDfI2hfSDZSjFD0D9v?=
 =?us-ascii?Q?LX38FHJhS02m90ohoEClofvL6HaUWk1LONx8imZuggvUHQ/pMZDQL449nzj/?=
 =?us-ascii?Q?PB64/v8K8677Mn2l3bjWy1/hAYzGiL0frJyvfMZN4viBnveKsF3wglOzmoim?=
 =?us-ascii?Q?n8mhebo3Ymp/4lmTkOYKlbb6C2fsDIe1Re5UrSGSZyruXzgdXDMbPgLopTjx?=
 =?us-ascii?Q?ElqSCYr3WsByztxOEJ1CTQupT3tSiUUFf9GOOR0ngPeIH5j/XneMwAROx+LI?=
 =?us-ascii?Q?UBWoe1gVfDWh6K0tcOQbZ6x1K8FuMkofmEUkVa0yIjYPbpaHQ3gfIW+tAEVk?=
 =?us-ascii?Q?rb4Ii199IlmsSDCO9TbnoDpUVQKBNREafD+291AnQFkPE1RoWJJE+2j4YnCN?=
 =?us-ascii?Q?mFhm7HhYMqHqfYOJoSso6pzmqAg+NPMaUE8EAgMtXfWWa2mBvnUKFa5OtoMi?=
 =?us-ascii?Q?vt/2K5QH14lm4OCY5pIsDvxKFDvyIeAA2MlIFLMjCjGXpG6JtqNic05qNwpI?=
 =?us-ascii?Q?2xmjkSJAHgJiCgHuvOi9zm1I9UVKjMdyPxaxcr5GJW3wYonXes7KfqhskiXt?=
 =?us-ascii?Q?PtBa19tGOkbVZ6rt96ZxbPcib8iyi0hqYcicLekRTrUsrIXas8Y/qKN7OQcw?=
 =?us-ascii?Q?JtW/LV2Hzxvyae72RC9Rgtf4GhnXBi2Fhvr+Tai4nH27Nhml6ghl3/NAZ4Sh?=
 =?us-ascii?Q?5BSn++Vni3GskvkIu0T57x01vRWgjblg0OZs/yBYZMS5g1hyy9Q0IWxM2kr1?=
 =?us-ascii?Q?3wmwRDpAhfM9W+3HcVa0Q6z1Jw5ccreyn2fhhE0mwTrbtuV1tRtLy6eqhXOX?=
 =?us-ascii?Q?DpQ2JBSzBDFKoBPNkDiq67hVJFYPhQdV7sEntD0s81u7DxORC6zkZkbuW1PU?=
 =?us-ascii?Q?jVK09px9rJYmo0uXjdeT9D9ARud7PSrwR/TmTc6lPBbavS8FxFvBR31kY9dr?=
 =?us-ascii?Q?dmyzSCvD8DCKp4KyZ2196Sg2idVYTOniGf0n7GnB8DSjFMSqUDITp/mhP+Vk?=
 =?us-ascii?Q?roRGXnwYJoJbR2p+RtU8PDvWGVGFMvvl09Mc4iB+ciY3ufxMBvjTh47/wim7?=
 =?us-ascii?Q?iuKC2siZtgXtwt8HA3nlFdCWtTcAVD/KHC5MfCBcqNZI42yBTlHDzfL3v8eZ?=
 =?us-ascii?Q?M2KS1iucoScIfk4SwhpPd1ExT0CBDl/4RqwXOIG4rjm4i9006eWkCiijX1K1?=
 =?us-ascii?Q?jrw6wmFOIdHbUZ+UsQx9f37rntTmOQ7aAn/akaLLqT/5yMepJNscTNJlrk6g?=
 =?us-ascii?Q?qADtzRYvoOlXeHBFo5d99krd3y8hKtJ+44ZU+fJ++yEDD04Y9QYII8foYJzZ?=
 =?us-ascii?Q?JR7b/EsxcY0DbwKQIqIbUWQDw1JmFhKrccWFBIXRUTzYy6507UOZs6onuimG?=
 =?us-ascii?Q?hIKh2yiP6AD6lv2ABzs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fXdHAIt+VqPl7UIf6j1EKECn+paQUGAOHCCQEG7Qb7iNp3DM/UMaMtpVvmlX?=
 =?us-ascii?Q?GIr30x8iOxB2ZGDFJQijfozWzwOUWdQEvzR6CVmqcQ64wpK1yNKisg5+wsq0?=
 =?us-ascii?Q?gxAUNz51XROY4N9sQgpuoQqyJlbTRAQS2PIpzmS3tJUj2C88qzVdj/KQgBvK?=
 =?us-ascii?Q?7UOoiIzWrdw3zBkD0DdDAzikQSQdr1rR9CZ3XfWVQPG3mSJm/HMKfq0CZxGY?=
 =?us-ascii?Q?ad/yN/RIlync2+65S2IVi6brxqUYgUCX2yIrPx4aJsMmvb8CEvmHWUFVTOfx?=
 =?us-ascii?Q?xyHsYtGzMS5Ky9EU4JgEfPtLIm2OuutYQEEYW8wiPrwJiNNMSJqrmK7xzj4o?=
 =?us-ascii?Q?yzsbiF3yk/elbDPfHbkGurTMX+ysGOxXZSjoHHmkX5NoMU1j5axn6/BlDBEe?=
 =?us-ascii?Q?Mfv9xvFlHy3WEj4mIXMyBKDB8LSUe4oYWgQh3DNbYnvWRLOF7N4gPbOcZdJs?=
 =?us-ascii?Q?QrVLy95hgiRtt+VfuAIYsWkO5nBwEKaZrcMOxioRP5/N4vCSHz01e1ooIE7R?=
 =?us-ascii?Q?YC0egEbHXhimTe9kQ0EMNDLctj9iJmhltgYF0Dm+b+WShVTPs7NLdoDx0Qol?=
 =?us-ascii?Q?oOuZkRviF6Q9YFCMftwpMVBHIl8urjtxdNusMBrVZFjZJjc4N3u7H6Ql5QpE?=
 =?us-ascii?Q?R1RuH2MVTB2dAJ/7/ID1Y1UWt1WCYnECH5j6xLHhkk0xsCLyAW+tUV6ikc3q?=
 =?us-ascii?Q?kQZGwVNR2gA+o8Eixjx8RmIx/ttG69zwXst9ahP+MhB67wdTAiYiMw8GdJMF?=
 =?us-ascii?Q?BOnA8TunnOqsbSz8el6V1x7pVAaQ8cMXDjUhMjEOpN9pqK8IHJU9Og1ik+3t?=
 =?us-ascii?Q?NFRk7GCzMcfB6S6Fe3AstdwLWCix9uvHhsmWIphurkjAUi0m/jzPw7hc1suW?=
 =?us-ascii?Q?zgCfAFDogCZuJw0f6xU+BQMoHdwVIEgQhURx/eM6oqL6lhqRhCd84IC13HSR?=
 =?us-ascii?Q?EjW6FbV/276Dg/inSuLUSCa8FmL9t4dkuclszxhQTGwCCzddTAezMXrncXFv?=
 =?us-ascii?Q?tKfEbnEcSyz33pOMYDTgpZdFIoP6LvdxXqA3Vf5xgo0Wmvsz4drK1VbXw+mL?=
 =?us-ascii?Q?Pc6kyRiW5Dne02xorLoFV//KQJgkjApYDlJEXf8PsHuL59l6nFWKLdLjhr66?=
 =?us-ascii?Q?bnYUKtLnLOTPPb+/NIHwHjWuU3KRDIm07cbSr+MPobXGcPfCZ8SzXps+sI3I?=
 =?us-ascii?Q?R9f8sgoqFFI6dDwgnXM0A2+AaPfjBumfImz1xL6vlKD2HeaIGnr9vGgVZaxE?=
 =?us-ascii?Q?7TCAI08DwuXUh9DHx9+QmRYwLEwmXzALBuT+lhe+JiLjEBUiU0NL0H6p+6eV?=
 =?us-ascii?Q?BgCIBP3kz9uDU0hbgbIGZf6RUwiiG4e4XuPDISgq5qw+qBGnFeUFrea65nRI?=
 =?us-ascii?Q?Eci/0HkBUmD54Lao/fMOHUkVBlQ92KiCg1Blp3+2qmQRhjwScSkh7Aylgk0x?=
 =?us-ascii?Q?jl7PHFcyQoapMi68rOZ25o8szH3x97nGIPqPSScOHYAH5gC0Vh52BlVc0rro?=
 =?us-ascii?Q?/SJpaguDIhCY9S2g4H3XfS3g+fWraDXk4DBgzD6mD273ruamiMJG1lEs2/jx?=
 =?us-ascii?Q?XA4U2wbYID8QkyutTYMQHp4GeBOaDLzJrKRHGD6IS+ZppRZjHy4Dpe0W1/lB?=
 =?us-ascii?Q?cmX5k2M8rtsC6pl0kovvOgezR7fkCYzWm3t+ayiedUcJGOp5n+ByOhInrmMF?=
 =?us-ascii?Q?O7B97tQdAkG0udpwzXNDmd9RY4EfYl+NjvORxau7KyzVakaiuq8K0ufYgXKg?=
 =?us-ascii?Q?4uEeg1caRHO2RU0ppksu26IQHbLzEjw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88452a59-d64a-4b04-7934-08de6d81991e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:34:12.1171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgE7bKhguGOCwvQrvdqSXf5pKacItgfc7uS4NWUGNwefDy3ZyTgsP/wAbdz9PBQRIL/lyCvPyGoqj5klBvCuMq0waU+8DhnfYAeCHeEtpX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9452
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

On Fri, Feb 13, 2026 at 10:26:37AM +0000, Anatoly Burakov wrote:
> Currently, when parsing raw flow patterns, we are using rte_zmalloc
> followed by an immediate rte_free. This is not needed as this memory is
> not being stored anywhere, so replace it with regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 14 +++++++-------
>  drivers/net/intel/ice/ice_hash.c        | 10 +++++-----
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

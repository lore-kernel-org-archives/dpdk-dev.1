Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EAFC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 18:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECDB0402C4;
	Wed, 19 Mar 2025 19:09:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 04D134026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 19:09:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742407742; x=1773943742;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8ruZVdh/10cKHtUmpy4f0syl251C50CyZfrp3EIGZqg=;
 b=JYwJoQfo0RR9hJEBp/pEEcgZkHJccWRoM+fcf/Yoe6Y6bSpCZ01ibjLf
 inr+BWWzrLlg40uoTfnqtQlQRAChSK60uNPNJcUkMQP3SnvV7s0JmQ3pu
 dyZoot5wqmGH4v7zzo/jfVsdprEUONqrrpwiSkSkoSbHqt6cQXoLfz6lz
 qnVY3/IcALCWkBEZltfBmaxChonjlO84dbC1mAkAvvlLdc87Ndke1MzYH
 D3rXzNIglBInul52G81kfJotfx5r8MP1VN3D5DuXQWNXoxIxkM8PCPc8/
 A+Wib+WmXFFN+yOodI6n73XAfQIZ8sktIRpIdBuhLcZfOuWC6of5y+7zM A==;
X-CSE-ConnectionGUID: lulrG5HvRieoJv5kiVutPQ==
X-CSE-MsgGUID: fddgYf/6SxGwbahVTvmoEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43631699"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43631699"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 11:09:01 -0700
X-CSE-ConnectionGUID: 3GotulsqR/qBxEqmAGy9Jw==
X-CSE-MsgGUID: BqoX5tI1QIOUxfyV7ZOfwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="145932529"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 11:09:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 11:09:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 11:09:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 11:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4WwLH97onWToqOCvYKC6Eba+1efJiT+DZ7U3xE+Fev7/GTrnaQpY4S3jAbR3hPVN2OJBDb37nYKrPuGXLKwo1OSuaoxNs0ylfm6Pr80sUhGdsJe5vrhICgqiFMVOg7YwjMFwjBGjaby/K2qJ0LAcsrrZZ2aaM2GBwqUm0tZKShvx2lv32XjZX92LfdL9j8zXWJAhuhv1KsM3dSo6RzCP7yrMbjftw8YJOGqhieH22TvwcNfZWLJlIylJL1pGg4krP1qFSs6GPIHWs7kSu+xGS6E3TMvQ1CAKOCuETI8N6DMfyi5zEhUucJjQkKqEWlD29NQDeU8b9hsHGfH7djrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul7kdcd/CtVcF0pPyFuntpH0uHViNB7sEKsO5fizS4U=;
 b=ikNtHn9Hm5I758YX/JndVaS9hk+CB4vgiq98f46dZ0pVe80994CWKii0VHV6/blIiiVZ4rJYOSXQMhG1/r2fIk6Z/zVZ8OkowbnRZZElB5oSisnGjoAdHeP9LJnJQrDg219FUGy4uldgGyfY/6B67BaMv04cqX6vUYXTCaZ7d+NcnQUhGEUf/uVO/M53OLCD6X8wAmH6vLigtHaiZnmIhtJlc9VqFJnbmERUiKFEdDTk/OIBLsNDHoLMBohKVQhy9uplNya0W7Fg6mtxIfUQO5EtXnp8XoLiQUjo6HxVRUYmW/PsF6+sTKR60nNRtWrM2QLCFKpQNaB1LgwWhD2/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ5PPF44E8B88DF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::825) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 18:08:30 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 18:08:30 +0000
Date: Wed, 19 Mar 2025 18:08:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: Re: [PATCH v4 00/11] remove component-specific logic for AVX builds
Message-ID: <Z9sIGDafadtgB9gr@bricha3-mobl1.ger.corp.intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250319172942.2992053-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB8P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::24) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ5PPF44E8B88DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f3cb4a-c20c-4508-c517-08dd67110db4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LeYSU2rzJqst8Iw/6WCuSE9q7emT+sm/Qp+ceKfddQrp29nOKGjF4C72NooV?=
 =?us-ascii?Q?j8fnWUogixFtL86/8QFSQjtH8h6QkwLbwPJ7cAbZIGsumf7yErjotwWSjiXC?=
 =?us-ascii?Q?POEJCbBaIesgLLJm5wfgZhnVuV/sTxLCFWE29S3+z8mC5xyvCcMfjhJieZhV?=
 =?us-ascii?Q?61k8wV4jncA6jsc/dvbR+drNralXVVPrwrMXp6hAETXphlifqmuCQUIOjaZC?=
 =?us-ascii?Q?2i/5UFa3tySfAzmhGCrHsnB8FX/y4m/Dn8w8QOtxds9fxmuhjWG/fpWIiPen?=
 =?us-ascii?Q?rBItRMGA6HF/mwjj2WpJJx9bw7n5h/RgCmKmzCeRH2YQZ/igeYJ+KlKdCAH0?=
 =?us-ascii?Q?5RRnzvcVMYIUAmh6ie3fAkVAEeC9F6178gaxeUekIUOqHzZ9SaJP2iLprF3E?=
 =?us-ascii?Q?rsQuajAG7tvpcpJ5SX+vKvQrWKisGspKpwTnGUKzFz49KPeoADYKJfiEPCsZ?=
 =?us-ascii?Q?qKEJs5RiX1H82A9Lv9xtgAWYTVO243LmhWUFQUbS1zm1cRAC52FI8OSmBTUx?=
 =?us-ascii?Q?cV4ftI36KSJlWdXZGhKvUAbwmNLR3EOLFVbtdnbD/kPmdojfgmEjknBTHjzo?=
 =?us-ascii?Q?zgFLOXxPbat34yF/8NtBi3ya/sZsh9mSlkuryzf1SJx2P0n0NIOlnq5/YVgd?=
 =?us-ascii?Q?jtxEP5StB/dftz+8IX6WESEzHd81OwkBzRRpJzKmI4lLBdlp5z1rVGEcqjsr?=
 =?us-ascii?Q?C4gF5JzP5mn7i9cLZT02hWe47LVm5rNXyGX4caD0ZNGjT/0G0W/kUDdDdJpg?=
 =?us-ascii?Q?fwbv1WQLWkAM1+fMUp4/9PWKx0GfuDPOZWSfdKxlVqvsAbygvHoUuU+ccoOh?=
 =?us-ascii?Q?WLEpcSf6fu9XY/ClDHXQuPfRmGjjYlheu9D70FaCnehnM8qQ2c6qCZTJGqxh?=
 =?us-ascii?Q?vBIAj5akC0bSam90jpV5DG+wcqxo45nvu1PrOabkNNZu/kd3ealGf75juvuX?=
 =?us-ascii?Q?2lfUPoM2gkpDePKL9d6veTvwceaNIeOab8Yixgz2RsWDOY/a7mPyGwvfJdpT?=
 =?us-ascii?Q?MsrGJhAK8/VPbUOiRdpHATDX0lw0yVE0hw7fcAZEXCEo8ImWEv8myoEhL5pa?=
 =?us-ascii?Q?xxjdppv0nF2iZFjiF5ipel5o8D3gGzyESPC7Ayxm6Kh4a9YxGm8OTUW3BRqZ?=
 =?us-ascii?Q?tHOfjNXjhLJ0TUx98Lg347I9xXDnZX8e0fJ3bkvnVil/NEyOmODy6sBbYhxV?=
 =?us-ascii?Q?dDHX5YIRfBNBMOMHF2Q13+hWta0/96VOmxU9KJ3PL9chCpcg5sr3YWr/H4L0?=
 =?us-ascii?Q?delVn2txC73UP1XJY0zqSJGIwz4DwGF1Q4GxuVkJdNGT/nWOtwO3eMdTBdA8?=
 =?us-ascii?Q?nuR41GRAHpxHpHGCj2Rs+119AmEN7YB0ZJB3ZWhqRgUN5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvfA/ljRgHIymOA9EuXKeUdo1HZCq7PbTmjFkPRCfZB5YKFrgW+C/p/ot7J+?=
 =?us-ascii?Q?cpbyGABK+XX5T8KNXyS4xhcuN3dqv7BNCuISl7jD9wkaO2AubFjCsCljaSwB?=
 =?us-ascii?Q?EK4NgVKnK7c264dopKIS6Dl6Ut68u2Xz/eQilil085IJ94s5kMcAhsV1j7iF?=
 =?us-ascii?Q?hkK3/YpFcRYBvVib8tueffUddl0I7P/9KqwISKBQP00/4RLLbREzhDVf9TXw?=
 =?us-ascii?Q?KNdxoP8kbaYps9J5bn54Lv0N/YwXUFYt8hxgtHv97QPKFSCPaAB5TCSvpOI1?=
 =?us-ascii?Q?cvXgfOJdtocWfjS48GJ4iXwlGBvGkwYDto1+2M5YUKFxN+piq7uzdnnGWDO/?=
 =?us-ascii?Q?s207F96bGnNOOecMNBekEkBKEVaGrGtyeXFP4qSo8SP4YxDxFVP/+ndo2bjh?=
 =?us-ascii?Q?YeJn6zwVljkDWX3lN0Kvz5WbYwagJThSNo9N/cqoHeiMp0YPaRs/cuU7PlG/?=
 =?us-ascii?Q?wuPmrE8mLsPyvgoU7A1KKqzS/NKyPamIYjLKWSiRBvT00pY/NqR3K1QIVEnM?=
 =?us-ascii?Q?G0VToWjCGEohIgTHvq6Gpqyjr9UCzaolmsu7ZNnmEmWF3HiZnCdRxdYRNEGL?=
 =?us-ascii?Q?q5CcKUt0+LVoCfQZjqzvILIwnaElTVM/UvAD/8FwRYGDvXRfhJkrndP6nHhQ?=
 =?us-ascii?Q?8DQlYYdTrcfDwEIm2bpMRITnZzRW/fN8ZFaeuQ5xNeakahfaIwZ025dfudwa?=
 =?us-ascii?Q?FYx0rLGP3gfyR5DS37yUhsRvLTKwyoizEo12l2Oc5UFKHkdchMzD2sVEVdzq?=
 =?us-ascii?Q?cMa2taLrwqHDzYJRcG2b4if+raZU9QYxHDvDJFBbHMh/DeZGEqpKlQYW+Q6r?=
 =?us-ascii?Q?J47Q+RBEJ3iDXmtj4YBYl+O+BalctYno9L3kSa/ag8k1KTq6gM6nZTkKMdXy?=
 =?us-ascii?Q?6IZkBYSSKdaoIKrkAQ0saQWKBKuN+O/Sh4Gl2Bs7oyPS5qC7yxvAUWaeGx8b?=
 =?us-ascii?Q?FwEFOlHOomsWoLZYTOecjJgsIxvLZT5Jhq/hVOb16UVpHHHUWd5Qamn4kqEP?=
 =?us-ascii?Q?q+miGLL/bBTjYDiLJzeaVdA3CkTnxZwCtkGDF5fC9plI6rF7gAOh0hxnxCqI?=
 =?us-ascii?Q?mA7ZFrY5CGsgJSdZz/r1sZ/qItyhB4gYh37eRfQfQF2rxstI9qXniYdzYH/J?=
 =?us-ascii?Q?1djr9k/+rhDK/nAsOw8TZZqBvp6yUjf0055iNNfjj87c1Bl3MC2zcFRMHDD1?=
 =?us-ascii?Q?6jDFfXstdNjbaCAWX+xj/O1FEhDGW7Yw+0/xq80JJsWPHDPyPNvW5Kx3x6p6?=
 =?us-ascii?Q?fvUrm5vpiAoRjNabnMR3Vd3FOh3mOkDgnwhXCdRiLgXU4vrDqORLILE0FJkt?=
 =?us-ascii?Q?wlHIVcXgoEPycvFfHvEtVVbheOpJhOP1E2Elo5lWfcsGNGsKjBc6OHS6bCXy?=
 =?us-ascii?Q?hlUUCbTCcO/iKc5N/Uc3NcOKxRk0TcongZx5rmtE9RE3HpotNJu4E9x98piB?=
 =?us-ascii?Q?RZip52V7ExFNk4ZvJh/+03TI8OqrZnF091Nc/TH8ljBJTYmVJApNDS8QKcPo?=
 =?us-ascii?Q?vbGjd3lH57BcbFO7VB306lqLgT0tL00JDeX8HZzb7kHgN7OXkhB9nACv5kVe?=
 =?us-ascii?Q?zj0AxBTWbbg1Bk/6gzhQhbR0Ops8DYUW+RZii20uArAkk+tY4tSMZ/AFuPIN?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f3cb4a-c20c-4508-c517-08dd67110db4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 18:08:30.0755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdUnnjNM7wY9/AB1tZATdoYcuIN3y0aMCHWl9gfBVSKNBsu1PX7THBqoBCneu+VhAshT9/GVcAwjycziD8VsccCJT3P9dLmjJoza1AdxjPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
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

On Wed, Mar 19, 2025 at 05:29:30PM +0000, Bruce Richardson wrote:
> A number of libs and drivers had special optimized AVX2 and AVX512 code
> paths for performance reasons, and these tended to have copy-pasted
> logic to build those files. Centralise that logic in the main
> drivers/ and lib/ meson.build files to avoid duplication.
> 
> v4: rebase on latest main branch
>     minor fixes following feedback
>     limit use of -march=skylake-avx512 to when we don't already have a
>       -march flag supporting AVX512.
> v3: add patch for event/dlb2 AVX512 handling.
>     add common code for libraries as well as drivers.
> v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
> 
A related follow-up to this patchset. Checking with "godbolt.org", it
appears that both clang 3.6[1] and gcc 5[2] (the minimum called out compiler
versions in our docs[1]) support the set of AVX-512 compiler flags we use.
Therefore, it seems we can simplify our code further by removing the
"cc_has_avx512" variable.

/Bruce

PS: I'd also note that these minimum versions look to be ~10-year old
versions of compilers. I would expect end users to actually be using more
modern releases that these. Maybe we should look to update our compiler
minimum versions....

[1] https://godbolt.org/z/Ys9K6axMf
[2] https://godbolt.org/z/v6WP7d6Pf
[3] https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#compilation-of-the-dpdk

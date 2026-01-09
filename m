Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4410D1A628
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 14:03:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C35402A7;
	Fri,  9 Jan 2026 15:03:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1EAA7400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 15:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767967409; x=1799503409;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IDcqi90mx/HROUJ8V9ZSuYNutUKLPyqXMA6P5Lo0dXs=;
 b=GDZaZvTTqPfyvSKk5vDfxrEeqejbhXNu4SSRLS33IbvSh6dhIuMsS8VZ
 ArHI/UBG2iVhRJyCzv3IryABtNW8DsbFI0RofiUsIzG+2wkJdG6mfTGhm
 yqbYgXDH/X8bsIkwEikA6wTWC5Y2/6LEBruThYncuPSq4Jv7JqE8kY49Y
 12pTsL5+aSUFYC9VETXeXbaywQQQ2GXsiIaixZ/pSHcIYK+gmEHt2+KmE
 vFvZtc2V+5i4cVFsjjznxU25OS4j1ockqKcH9MfDx87T50bFhFRK8F9Bu
 gTUHTFuTcYY6VNzgvOf9ySN8ZEcNvs9AQw/BMw9Uuh2RjVwAViIoncHH6 w==;
X-CSE-ConnectionGUID: 9E0p3+kmRhSmUBY6tPiFeg==
X-CSE-MsgGUID: HmFy91W8Sf+Htjh+e7VKZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="80799117"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="80799117"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:03:27 -0800
X-CSE-ConnectionGUID: ceIk8CMSSXGY8OWDFWVyHw==
X-CSE-MsgGUID: 5M2RJaQcT/WW/GK/n1ShEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="203497380"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:03:26 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:03:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 06:03:26 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:03:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkUq/72US+MSyow55m+eYw6h6yavBtqQKV09MMkaoTi13keJUxfFEpyFVa0rMTyNtll2ic3V54Xn5kHgdNALede/tAek9MKB4iVISzLT2ySb81KSHug97N714LBigr6mFc0EmDWQ871HhyJHtXjy/KSvLkciVaN/DQD77wZdGSX41JRAuOqRVKt/p+Fu52+UFn6D2nP+2smmxCVqF+OorKpCI0rou4c5oHDSppBVDYiMkNkmpxzf/mWypUkGZ0vFBUe/dZTUZbFZuL8u078YNJ08e/cCwvsP2eV9NSOfzNNIau1UT7ahT6LS/Y8TnPjyO1eUYdDk7aKKyFlHSCqlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VJ0/zAssxOHMwXY7eUhw51rq7+19zowyq+S+nV/V0o=;
 b=dF0AxvbMc6lgmI2O6MwaG5S1FcsryywB3HF0wMJ2Upms5x+r+ooJXQVVKIOvjWoKvPWt6Qu4ywkGGiI8f3GAxYqxGx7dTdzh7bPWxosP/d1NwtM4pGB09lD82q4uR4e0OkqGbTGLMHfIitlPXHetqBg0Y+DRo3rjpg7wTWkZuQ+NsyQCq67FbNVsKN7TUL/9rAhEYv+4b8IkSrOmdt76cb6tqfUYzpn0+XjCdEq9RrpKk8yATzstMxoVKEcAYMfRvnC+4rEyPCggrFiQkHXHvO117To116CTR3zM7Ov/sQsjcvZ6Dvj6geaB6mEYSQb2LvOHfMEflV7d0dy/CfO9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Fri, 9 Jan 2026 14:03:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:03:24 +0000
Date: Fri, 9 Jan 2026 14:03:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/5] Remove SSE Rx/Tx paths from some Intel drivers
Message-ID: <aWEKpG0eI3vkSYg5@bricha3-mobl1.ger.corp.intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20251217143223.3208830-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251217143223.3208830-1-ciara.loftus@intel.com>
X-ClientProxiedBy: VI1PR0102CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: d63feac4-af26-4f7e-6db4-08de4f87da86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nXvUMsxRlwCy0vtcVn8PTjsBhJ9NZI28kgv9GyubI1Q60qrd94Ph0wloE48a?=
 =?us-ascii?Q?VUSFtQsKHVcTXc0m7p4JdqCShql9WvXdhaCPAu37f/zNoW7nmhviOWWufOIG?=
 =?us-ascii?Q?T1jsU8FEsOJRfMPYrzwsxGTVyqYI+m7mX2BNJdCOUkxyikBEsSokojQOpmmW?=
 =?us-ascii?Q?GPpyuoMbv1zR2CjyxBzQX082DUAumbjO6uC5mR5NVft4VVsgYVd0Q9gdGHej?=
 =?us-ascii?Q?QWtQNzSHYIYwpmg5/lNA6G1uEyJlPrZdX5TZ9Wi0EVTaBQR9vmWvRK78hIXw?=
 =?us-ascii?Q?XxUHZA+Q26qVbxOAG1ETcTJR1yFSwkx6XkD4tusK839tqOBH+XfKBUmuh26X?=
 =?us-ascii?Q?0VwnLp3XGpY9oVWVJZnEX7Ll2wMcEPwdiuRYM0TXIQlJyiSpyBfVVKijv8CE?=
 =?us-ascii?Q?Xoj3luOA+PqWVNamW/iyyKMU04BUw/UR3vIWPFu28nkBIHQJNC+S9dlby4sl?=
 =?us-ascii?Q?R9mx/2fBwPipbZ65bDqg5xgZytAuAd8ZaDsD2dw3Q0gjxUFXNgiO3S4Qtl0g?=
 =?us-ascii?Q?kLMnX9aUQCRjtXFHh1z3UUu5UYCZWlJXoTWSt6nAAP2A8hdu8brTcCumJZA/?=
 =?us-ascii?Q?JBMqLLMcoy3ILdJhAUnavpOwk7gAHrVLf5axi2HFNcu6Sq2BXhLDB8hEW7iS?=
 =?us-ascii?Q?yMDNJKvtNnI89MgU22PisSrG/pEvgi0tPe2EH/URoeu2uT/FnSYZmyHOPvSm?=
 =?us-ascii?Q?PNKcBitGox2r4dFtH5vS/rjno2BVAnmUNbddJlLPyEhduFlkll/bzx/DWAsF?=
 =?us-ascii?Q?oUoAO7ujvlwnGpL6hkDXeV1n7AqkuhpEMfcS9/wd6AifAdbQ5eNKNVLxBJwW?=
 =?us-ascii?Q?wE+Fv9+W1UkZhEa1Zhv/inF0e3B2MBeLrKQEORA9JwF2l32FoKiTxpv6vd4u?=
 =?us-ascii?Q?YOg479DdX2/fU1crA9Vx0kTWERS9PqCZgYDgPxFv/bAkqI1ZBfDtI21D5wIT?=
 =?us-ascii?Q?r05pXkpZL9QlDUx+zNeYA/pl7vUa7tsJ5VNkbKno6J2Q7nWO5xICVj5mbBpn?=
 =?us-ascii?Q?aP8MN4QUS3gt1P76Qy7HIhxXNNLEsd5Qw7fimRDKUIki5cf6OGIBUdWp2YhB?=
 =?us-ascii?Q?9i7nOaIRq8FLbH3FFPRujXKNmDg4op3M9s/YCl5z7z59pI22Gwn1D9NnHlnz?=
 =?us-ascii?Q?IBYFhe0fle76GKM9Xq1atj7nWJmwgSaDiN1OXUJh89y/VPW9HWAPFiN7R7Ho?=
 =?us-ascii?Q?T8STjmLL5oeoxmEQHT9L3uUUWjdtgK9ac05nuj6rpY6S+0AdksoGXIpxZcS2?=
 =?us-ascii?Q?dAmPq5xFROulsM/4pKvJ5Ca+4UvJ4LZjTDszDYyzaGSWASj4XapyrCySwIsF?=
 =?us-ascii?Q?qqxIA5LWZKz6bJdJk+Vmqy+5wVddU0e2vYoUF7ynOq+ki0S6cmZQzMTPwq7F?=
 =?us-ascii?Q?TtZkH+qDmiDvUhBxDzkqeL6hv6jmDGiFaLGiceI2oMHyHEPYVew4T3/o+2FE?=
 =?us-ascii?Q?C3/RkmxPjUwGbJP2iTUmGU5FeyAyZHqg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61hggb4k0xCpnkx/x64LCjG8vwJds8TON81ygnlj2sfF5eTJ/fuLAHujbGX9?=
 =?us-ascii?Q?9ksDQLeaS0rSY9VcjyYF6V4bndwvkHVi0TYzZyxgAIiVBMKvziHHaV1tKH2j?=
 =?us-ascii?Q?hmQM8ZoYQ6cAbJP4mcC3+ZsDSmweFGR0uGoSDECQQEoVdzm46pQ3IvciuCGy?=
 =?us-ascii?Q?WVv67iko6t1jqVfj2yGIvcQgXkbhZ/9C6N+RHcQwQrpBhLs7QxiupLCAuMFo?=
 =?us-ascii?Q?H64NhD0U2WZ1xyCqcdmwyL2uLsvz6ZzX7f7m7jApGCVM8rXV14216p5dnAZQ?=
 =?us-ascii?Q?tbKWdhcN+P794z+D5fPhRvWyHYy+Paff7fxqrlCvL7IEyq/adAqth2qvTK5g?=
 =?us-ascii?Q?MtRvGQp9PxDYd8csUowBuc31JuTtWV4MVvN2iSq5PvWHNughZdko2y8M1cqF?=
 =?us-ascii?Q?W1vltO2Gc8ODRGqqkLPmqce+Ulk0G+hEQ0UQNU0i5T7x8FNnGlktqeo2sSaF?=
 =?us-ascii?Q?FUYyFVii/pGWf9AvCdq5fKLbLYyD7eR92V/hxRp2i1XJUgaa1JDOYZnkFhP+?=
 =?us-ascii?Q?yTx5QU1ncWV2BCXac+W9qcmx5cwitfwBpbUL6E+A/lGghQa4AU+if0BW6UYi?=
 =?us-ascii?Q?baVNyIRKyM3Qek3HEqy3Lzccta9IFR+mW+UJQ8KWsN7MP0jB47+H+aZeneaI?=
 =?us-ascii?Q?s3Xjrfhfs9G+nw+KozC3HYa88mYLM3/eIZv1PMpD5NhSjO2ddtDofPm5ceM7?=
 =?us-ascii?Q?/drTlVBlf4VMfoe73+owAbECCwfo8dsSl5ie/xh/AlVJG7U97S2v/Wx8PXIq?=
 =?us-ascii?Q?t8yobyproWZBl/5j47zPipePm6ZhZv3jSyB3ge+PM4hcMAzDK89d4/kqVpwz?=
 =?us-ascii?Q?wIynGoQytYFMXIzqCL/5L5e8wKPSDm4rn3UocYjgUHAAEWwpmx0CzRJGU5cY?=
 =?us-ascii?Q?k1Zd8Kfh//yJChHLcFJ0+/PYCI1GALX1lFogLyg359wDh3sLPIMG+MMbl7Cf?=
 =?us-ascii?Q?OhH3hhpv6lu50cEEA44wj/wb/Kvmdt0lcyhsd2iycAtQFOKM/PFGuKATg8I8?=
 =?us-ascii?Q?xvA4CNimfrM9JHsDgILfP5DHyF6uxBmfP16Cqec5QivLSwI6pzNsqptZUsEJ?=
 =?us-ascii?Q?pIJvDVFup86vSdGiOx25gh/TjD+1Jm+LFYmBwsYFo4wxEkv3XuMt0wnHguKC?=
 =?us-ascii?Q?Uf3BaQqkK3KyKuhusQd5pO8HQ0VK3yyFXvf76MEJtSx7VlO1b9aHXPyOxmED?=
 =?us-ascii?Q?qQxxEJjspHVWJPocKQ1ufiIQ+Yo/wfEBDc84+uFM2QRbQm6bKkFtXzIUORmN?=
 =?us-ascii?Q?6Se7OfijLj9f2WSHBrlVEyPVBtxCvhUegcQE3H2t8DfFSX1mvMFcT73NWeBl?=
 =?us-ascii?Q?P4cXDrPYfkzeol/rhH/Xdv3mMLykZQ7fEGO8QYmvborqoi4iOhV3SzKuw5Mf?=
 =?us-ascii?Q?gYsXJTWzAqFivUAVQfC9mQZl13O4hScIZdwvkNrP6xXnMGDLL5bYg3Ib+23V?=
 =?us-ascii?Q?feYj7PePAEspUAvzCvAPqKjb0/C8ZhrGPD80+ZHz37m0KNPh73qTje3bHXe+?=
 =?us-ascii?Q?Ewnwx+6DsYtOR76uhFjPzcN+9rVqlc3bmoAKes9hM1e+b1oUCaMv9ZjHRtxu?=
 =?us-ascii?Q?H+WAl3zr5XmNOFlT38Hl9WmNkPxiU3rNVMEoTYQu8sJjiD2GmnMQ3eqETeM/?=
 =?us-ascii?Q?bWMHIHuB9cAdPGCooADT5CI3K/upiphOnG3njKtydtDFPbjuRppbajMVZiPi?=
 =?us-ascii?Q?P3LO4wRj6IAApnbQgb/+1D9oXvPphP1784WBQ0aTMqiBrMlTXDHzGcM1DfAP?=
 =?us-ascii?Q?d0kq7pORfsVpRcfDs38qRDTmG2Y27GM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d63feac4-af26-4f7e-6db4-08de4f87da86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:03:24.0217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nRnYxE30mcoGJJL3PeTgEo+rSei7Jr3W6t1E/bhpdiY1MIc0UiRJlTw1mpxFj98qG+wXmzXXZ0vOtaPDJhIKhnufIjmWid3Gv3VAmT7I4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
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

On Wed, Dec 17, 2025 at 02:32:18PM +0000, Ciara Loftus wrote:
> This patch removes the SSE Rx and Tx paths from the i40e, iavf and ice
> drivers. Each of these drivers have faster vector paths (AVX2 and
> AVX-512) which have feature parity with the SSE paths. In
> environments where AVX2 or AVX-512 are not supported, the scalar path
> will still be used, which also has feature parity.
> 
> This series is intended for the next-net-intel tree.
> 
> v2:
> * Remove deprecation notice
> * Provide more detailed explanation in the release notes.
> * Usage of function type enum instead of pkt burst pointer in the
> supported_ptypes_get functions (simplify the logic by removing #ifdefs)
> * More renaming in iavf to remove all mentions of SSE
> * Removal of IAVF_REL_MBUFS_AVX512_VEC enum value as it's not used
> 
> Ciara Loftus (5):
>   net/i40e: remove SSE vector path
>   net/iavf: remove SSE vector path
>   net/ice: remove SSE vector path
>   doc: add release note entry for SSE removal
>   doc: remove deprecation notice of SSE in some Intel drivers
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patchset applied to dpdk-next-net-intel, with the last two doc patches
squashed into the code ones.

/Bruce

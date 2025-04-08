Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C515C369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 16:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3357240267;
	Tue,  8 Apr 2025 18:16:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A7C9F40264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 18:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744128981; x=1775664981;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CSQizHPSBA03H20+0y+XfFno/TpQ74vBXdMUY0Vm6ZE=;
 b=VG9KvpfqbokE0dMyOK1Jx3j0Rex31VbfFYmm1i5LUZPy/6wo8XE14BF7
 D1ZqEYpJiga3yVrCDf+SxpqnFZ9jLWuk2RFNS6oLLjEh8K1+AwDrSq8w6
 juXUwFxKI8oKZ3PG9pLXpLCN+SSkAGSMzPfgMrtIOHprRy4Fp2TIhXNiU
 bv5OXdgoh1+BqjvGJwbHjIOc7uT9VGEHfDhg+9xnHWeJsGgDA6OXreZ4J
 cq9EbYOzR1Rea6Y+/IFYCaMqYmeY0pPUuZvk9IpoB05wxGt9ZKHaTl4Uu
 2iyY/sKRhWi/WLHzjq2uDf1T5ULphs4reB+VXKGphCFgi4DKHlbusacDU g==;
X-CSE-ConnectionGUID: qX4lPABzR5iNMQ0I2e7Q9w==
X-CSE-MsgGUID: cemJv+LfTGeWgihutvqA5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56213607"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="56213607"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:16:20 -0700
X-CSE-ConnectionGUID: 0b3djUb+Sa+wwQyrbwcQyA==
X-CSE-MsgGUID: e9IVKBxHQyG2sdz1qvhAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128317164"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:16:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 09:16:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:16:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO6sjNJxJbSMy/yNYfvPCkfQzPXJJCApXHPqbsPy965D4WgDkv9+EAWZJ+FOZRn4MLFpdyGTbhpJpPoD7fcXY2XGLx+6I0fhooQv5coh3R6aRFnxiY0NjfZSsT1DNSFtXwXO5yqbgj0ovmLt9kUK6s1WJdsPLIzEhVk+kbMKBCaOYFK/yKxDAkDYQARVLHKj1zzaoJ4MPQGzgpanzk67r3zAgo78T7WdwTaKVzrNxL7R85DUKq9V47/ZR/LS7cCVIYCB38elKvryFGo9RMJjzjgxXUOUOLEkLRX55PiTYORRR2dK+tGBMaD5Rpt2m1nmoJ/rYSkz4KLUG7ajhzlc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU5zwgdpm1hDFEnsg6Cg/piUaDvGXqZ01Gjx2O6H3hw=;
 b=YxK1Gu9sX2EO0wsd4/5aCPrLGtakqBMxT6I220hv6tnZt4QqqS56aNWXJaxvm3+xpE46rZRJYcWAYQPGdZVXFi1C2A8oiViyW+hgvx0tFgndtyhnHRpmPRnRNqyjZqHFPMVcJUmVTiCzj2QpFul81+oXfut3GNaAgNJUJzO60ZYBWCpdJQ7ABtrQBe7kA0IKa53wZDbFFsjF/XU9OpqLf01du7yLgu0goNUPDj90zQZglQOsznwF8TtspbzhbF/rp51GBOwKVce0zEz7yqerZv2zN6YDXleG2sUxbjI05bL+aoRngG3khwx+vTMA0o2xCulNcw0WJmPpjT9KMYLYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:16:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:16:16 +0000
Date: Tue, 8 Apr 2025 17:16:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/cpfl: enable AVX2 for singleq Rx/Tx
Message-ID: <Z_VLy_b-7Ld4yidR@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155242.409854-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250312155242.409854-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB8PR06CA0029.eurprd06.prod.outlook.com
 (2603:10a6:10:100::42) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: bac81769-ffec-49a0-cf17-08dd76b8b06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yAZH89j6D6dsmjjm5siADCHyXPbLHdwx8ayNTW3ZINgpf/ZY9FzGEpmwG2Xj?=
 =?us-ascii?Q?7azxUmMkSuIDSho3yJuvj0VXwAXfKl0sRdWW3km+pDBD+eKYouo6XqahhGwQ?=
 =?us-ascii?Q?WKxQ/oFeZDC+hUPmOnM6n/b2Bq8h6T4Pbb+cdZanwSPVf+P1PxrcCGKGUelA?=
 =?us-ascii?Q?b6coo5RoyfV7UAPRKP1132dKL1pbchwyc5L+aJ5sJleBmf3oIzcwrY8XS54O?=
 =?us-ascii?Q?c/GYgQO2O6KFOCsmMjQagzXbLIrd5+87WfYn4w8CRUCJ+bhOfceiGhZPAbmD?=
 =?us-ascii?Q?PDHYCU9qXaf5yACEAD2porbZ6kFoPtZWgVW7St9Oq/ccotcCmJKW0zrdpA0b?=
 =?us-ascii?Q?TiqQAn+iLXksPzM24ZLmjQ5dT+h3KziEz4SkF0dUSlpIblnz5S6xgL5g6za8?=
 =?us-ascii?Q?c5FswvJm9h7XeGCIQikqAwwkAO0T5QxMqlUJimcMJ4SL9FYsHc3cdIb7YKws?=
 =?us-ascii?Q?4eKsDoC4FJ/b/nmiT7KPR68COeMOhh5bViU7yKUDA6mQlOI1mjhh+U4qCyK+?=
 =?us-ascii?Q?icbseKwiQ/XFvwH/cus8Xn3Cb1+gvBUy55/dYG6wf2a4+sIMF0V+eOewZhUg?=
 =?us-ascii?Q?6tzmN2yTRZnA5C5rYdMl1FtYT32RXV8avqnUDesABlwkJRO4fidJvK+01l9o?=
 =?us-ascii?Q?h2hurcHSivW53o8lg3jkvQwSdjBbZUemka17NyAsNwjAONG3m1xEhy0CvyTZ?=
 =?us-ascii?Q?U8zIdvBM3INb0BSQVU3lQtVZY2qvJvB7Xt30LEZywfhEuPf//DtknVCiWDkr?=
 =?us-ascii?Q?f8isarPT5JAXYJHiSa6LRE+zBH+nxVIUom16KQmJVuA4yWx9JCr03u6eUpcc?=
 =?us-ascii?Q?dl9nBrm1t31CdOpODcCRHNaMoK1CDABHLxGtFfoapNfKIGmX+nxPk7TMyhP1?=
 =?us-ascii?Q?T2OXoAPnCLn+7iGVa0S2DvnYB4x4lP1XTo9gBXoa3yalVAVQvVbJVEKtuZj6?=
 =?us-ascii?Q?YwxjKcASpMoQDivw1U4+X1S1QCVS/kpQ21WW4+BjvybDWXGQZRz/dQg7wRTq?=
 =?us-ascii?Q?FZOEIGco5c5lkJplGk7eSj9ZovPIvdHTF4QrSv6/MrRV2Tktx9TB+iXSJJsO?=
 =?us-ascii?Q?JZBPPW7/pEW9fpEnN61zvYAUPf7f0vh3jN6RRimOSTDeXujBrHNR87Jcap34?=
 =?us-ascii?Q?mMhN2DexgF+2lNCywsxWGLpraW1B1zpmU7kjdLvsLyDnzU5cAaLqjV42Yk2U?=
 =?us-ascii?Q?mKQizvGEEd4gld1x/Mt/F/d9WKjBVOOv/tiK4LUeXZLE4UJQSXiYy7n4Fydp?=
 =?us-ascii?Q?pZFE9PUU8qUmTGX+USkTGgdiphR12iNtNYMwYXgz+t5g4bU/iQAgKWzJT906?=
 =?us-ascii?Q?gUNHgOgdyx7CMd2ROrz7xp48CGbUuKw6tJGqTyViGSz4FYgjU8t5G1L63fnI?=
 =?us-ascii?Q?pz4hUeBf+U4jhAhx1hGk0VHMq8KW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLRBWddztdzxzCA9lhC642s9iLLqKv4NBizqkoBOSc1bRVe6vNZbNw4CnDoj?=
 =?us-ascii?Q?fv7CH+olqQ+JPQcBUJeeYw/QLDI2//wwt/1ysiHfdp+VM2lN5gC5Reo3Mx+0?=
 =?us-ascii?Q?vQOUmswgWGSsP7XSsAoeAzzyZTcg+ykchbww56KFhdOe1F5bDnIH5KwWF0Fk?=
 =?us-ascii?Q?nb4Oha1+7xDkQhKXRvOlACgzgqzFbsbRWh5+eV/UVGtcAGf+dPeWYnmBjNbI?=
 =?us-ascii?Q?4PPVYhMMk0LiPrtYPsyYKlnbzMIqZ/Ootc5V200wvqYPKq3pZO7iIekC7lnM?=
 =?us-ascii?Q?yBnRC9HfJTalpBj9mABSLIL4bCeXKZXMaL1JFLgXfilb69WFy0Avnd9iddF3?=
 =?us-ascii?Q?1JTlWVzAKBYwLMM/VsiEJ0f8D4azP5hUDEmeyq2zi6e90sG1ywWZMeYmgLZG?=
 =?us-ascii?Q?vWbzOH+xcHA4xdcbPkyma1dcAbvvX7Mv9MN5pGu3WUszPOh2R9jb0IuO560O?=
 =?us-ascii?Q?z657Z2GuBkVePhDuyr2CUrRxXa65fD/7Kp7Qe471SI01hm3Xnw26wkyW4wuc?=
 =?us-ascii?Q?+3B4cnXEggDQmOrDgWruoaR4OAC6VP8ynOnF40gGUIcOtjgPXlk07ssIHEKF?=
 =?us-ascii?Q?00TTTAiXS3bC/4RbGI/h4Mne1sTV6tdSSz7+wzZ3JykNSPTnNgEpcMOGalvN?=
 =?us-ascii?Q?16cUtB3mDy3VsnFP63z8dwitOdvLzAp0RGjjYMUW7FLwJLHxMozb+81Cx/1Z?=
 =?us-ascii?Q?0vj8CmON3olg1v0tXnOl+uhWB/kbjeM1q5NSYL/I6gB16VhqmXvXBXaBpZE4?=
 =?us-ascii?Q?uyxY9swVLCLG53Bl25GbjC4Kh0i3DIDBY8ruHDm9IoWMY6sUJnmb+/kYi2zy?=
 =?us-ascii?Q?NkfpbtTNYIxyn0cSuJAm6MX30plw6drhW+AWqjI8AGmCCaBoSOEsFKZJCXLw?=
 =?us-ascii?Q?yWyCwqSWqysPfE1/O4e+aGJO7NepNFBVzZrFT9kA6rqNzy17ioVWL3Vi2QI5?=
 =?us-ascii?Q?KW3WFWx9ZOxiKBTb2ucBynFrzUFuoeHUAU1MtFxHw17Z5ujjaopbDTIrHzrF?=
 =?us-ascii?Q?hwEubrgSohuR4R+wqpKDVOoB7/kqZSY8M83uMRhEj+1Ps4tdPdNi5Vr6U2/4?=
 =?us-ascii?Q?Tellar2b0BW764v3VV0nYLPx3Fx0m6VTwtp3jRRmfBbXDLSyUqcfxovDSim6?=
 =?us-ascii?Q?1bVuwMPj9LqB46VR8j5yvhgwjoxKHwWEZ2L/KL038w26YJ81sqYaoXs/dIq+?=
 =?us-ascii?Q?s58RRkE+whi8w55wFMpw+04TD5laGBC8QN8UqakTQwHHcudxkYZdEuLfHUWr?=
 =?us-ascii?Q?TaKYI6Kmj8Hfkj6Q4hreiXM5OHJ4z8QCxSi5GUvnPQYmkFRK9sWj8W0IdQtN?=
 =?us-ascii?Q?+cmPpSoTJ4YpFDumpatWkagVnj7TNEybHXm5sQLRZ7fFNf2vQysmtNj0t1/+?=
 =?us-ascii?Q?allQbpaExzGdA6zDFmvmxJ/VRS4+qylXnAOBQ7jBUoRA9yY+PvwUMr2vz7bR?=
 =?us-ascii?Q?MzB8dJS9W6HYiYnOzmi0qQgbpNFKjOvYHMq0l8Ka7GNxSXW0bDW9+xHTc8cW?=
 =?us-ascii?Q?zXzlCCg8jdGZa1oAtRq+Eu0vN76wj5+3hbusfP7m9HY1wNw/RZVDJCqRTjzG?=
 =?us-ascii?Q?wetQs7Zkoo0g3RmDBXscX2Vba3txk/ZD4JVDJK/5wZazEbC1fyxsL0ZVLiVa?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bac81769-ffec-49a0-cf17-08dd76b8b06f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:16:16.6112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQE4moAp2WSQS5/7bnyRsA9KgRvEECiOVMfMSiuc9EgXUW6cMv1E/O3/gbN0SdvBaUUDXrTjgg2XocIoVZsfKEymn7LKMba8nwoFijmCGJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
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

On Wed, Mar 12, 2025 at 09:22:42PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> The single queue model processes all packets in order while
> the split queue model separates packet data and metadata into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  doc/guides/nics/cpfl.rst           |  3 ++-
>  drivers/net/intel/cpfl/cpfl_rxtx.c | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
> index 154201e745..5d267ef667 100644
> --- a/doc/guides/nics/cpfl.rst
> +++ b/doc/guides/nics/cpfl.rst
> @@ -177,7 +177,8 @@ The paths are chosen based on 2 conditions:
>  
>    On the x86 platform, the driver checks if the CPU supports AVX512.
>    If the CPU supports AVX512 and EAL argument ``--force-max-simd-bitwidth``
> -  is set to 512, AVX512 paths will be chosen.
> +  is set to 512, AVX512 paths will be chosen. Otherwise, if --force-max-simd-bitwidth is set to 256,AVX2 paths will be chosen.
> +  (Note that 256 is the default bitwidth if no specific value is provided.)
>  

The word wrapping and spacing here looks wrong. Will fix on apply.

Otherwise
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


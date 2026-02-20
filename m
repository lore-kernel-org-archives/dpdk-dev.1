Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5761C55ABC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 12:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AAC74027B;
	Fri, 20 Feb 2026 13:13:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 158994026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 13:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771589631; x=1803125631;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ormuFV9eGDZ4X377F+xFbg5N9sOxBcHjVXhFguW8M28=;
 b=ew/5akIZz5TF+3I60OQ7TNyCUSzZyxXbcEAIXq7tsx8nCQSAJwkc5G/e
 HebRtUCNA70A9MfrB7YTdGoIE9eiopnDrJUPvveTNGddUu3c91s/lIXgR
 nytmuXyJbv+GiqJeaWZ4lukw66wr9WnOkKPpJ+nRF2fSnBUZWt7kjMmTp
 8nAR6lNYDB9eFDbonsgJFfHI0rXj5ZA+/NIzeg39DBfUgS+YNyZPYepNN
 A/Ah8Ex6J2yvkppfpeVvNQWuJBvS/X8xivoQS0UhaAveN6Pwsf8Oqf3z6
 KwiNZ2oy5b4OwqKzxtXb4UokxJ8QyUfiwa/tvzDs5IezaOeoMc7thvnIr Q==;
X-CSE-ConnectionGUID: 26WOGFTcTCexAfGzkwKLZw==
X-CSE-MsgGUID: Xs55pbyOSQWqOlXAWUMDSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71887536"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="71887536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 04:13:50 -0800
X-CSE-ConnectionGUID: gs0FkaaSRTCxOOaqwRwUnQ==
X-CSE-MsgGUID: p/wBC+ibRGqSEiHz0zFHVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="219335372"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 04:13:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 04:13:49 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 04:13:49 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 04:13:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWiMrez16htVn9FF5V9yjD8yKBbhyBQ0j5GMHbybZoDZWj0NCaT+8Th3dl45od6sz4ys72kPG8oN0Eu0a3QfP4tEXrE5466TqfKWsSrAzueHTuWD8zlgzQ0CB8O3CtresUzi3HCkSb+6qZSAL0Elcxl499YRiCtxXHt8glzsOjmmcNB1zu8t1nof19zycflwGKMAELskxZYVd0gkX0jnpK3vAXH3en3wX6DyWrcTKiCxl5DkfXdfqZFJ1MfqmhdP9JTrDyH7BWTcq5QHcKuqrHWdJFGqooyt345fUKJrGXG3TLTrv3Ovbir4qCp8MG9tFx7BOyLnW6qkPlWprZPF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UvJACtMPyTjPPLi/CB6wVMSbgIHee2jGdTMCKVvHz4=;
 b=ShQVISHG7K7kFSL1l1FOe+fiHLzLeIlEiufVo95Sby5EksyftFP9J5yb5vR9ArYYWxoNVzpsLEKApVLmkOC741ToQE9FkoQRrEIwHQRVTpMaVxj4qJ7fkvfeHGsNLLKy7NMNSmjKJqorxmBXgoYk3BjmQLZnigJ0lhR8fg7pz77KzqrGL1aDC1GbRJ61XsrMPL9+RYCXocKnYtXDPbBgG1wl6fj2KM70ghzo5UjrChTCYhG2+BXW0dCnEkzif+9NdljD0B5wxtUgyOLxBr52jVLT81ti6Ld6s7Ll8s5V9EsXzfVRAvgnEPBa31jcN82F3icCEeKOj9kl6axZu/aCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 12:13:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 12:13:46 +0000
Date: Fri, 20 Feb 2026 12:13:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/iavf: explicitly pass flags param to Tx context fns
Message-ID: <aZhP9Y9ZiQaYFDf6@bricha3-mobl1.ger.corp.intel.com>
References: <20260219160726.2117208-1-bruce.richardson@intel.com>
 <f7968228-7e26-46cf-8c91-01d8a007bb41@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7968228-7e26-46cf-8c91-01d8a007bb41@intel.com>
X-ClientProxiedBy: DUZPR01CA0253.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: ca306954-d6b2-42fd-0f81-08de70797f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RNGDf8+iBw0yhKEg6MaTukzOxUqYJw0/lZr/n85pLVKe5kmF+TVu1IkVYK5n?=
 =?us-ascii?Q?hTYoXuMmI5C624P/EAxoF4pP364q+VtU2/NjvGUAtJV8FBEOOJiCUHBDkXaW?=
 =?us-ascii?Q?o5r3OH0FbzdrP8gyyvn+dYFcpNdO8PrIjdICY0jZM7y3+CkYrKBkYAB62R0x?=
 =?us-ascii?Q?rj6Ih/NKizD2O+X5f3LfG9mwcepE/DSJ4A+daZMnLQxojFHImEYLWKN43mxn?=
 =?us-ascii?Q?rT4rVJM7JI48/TPMIRwd//LMd6z9niP2FSVcF5eQTlUUt83LNiSPYQgIll4x?=
 =?us-ascii?Q?Iyy8EF7a/Nb0if1ziyZBdeoNQ4zZ0dLjKJvHwh4Hq8bVBKCG3WBtbju6Dhh5?=
 =?us-ascii?Q?q/QWNX/hGpML8G9m7l/Yb9N2G73Cc10IqEDKm7rEN+qcp7D5Udd6NEG/Y2BG?=
 =?us-ascii?Q?Zj7qzEga3IBs8GgcWdLxmLx4lRhZq3JY4ELp1VcHDdj4oSGT/9NRBjDjn/s0?=
 =?us-ascii?Q?Tqy4iNRJ3QPodRQQ2z4Ns6TA6JruKo0GpKdioaSqeENtPRx7qNXebG+DtuJC?=
 =?us-ascii?Q?abaARrDyiqjiN5RJtlvLJiLpKicAboYFoNVMWFsUGDlluesY6SHOcqi8WhpX?=
 =?us-ascii?Q?cCydexFvZjOV30QPORVWHqhTTNupqiDlzgKhKqGyB2eAOxs1de4YSKrTXHSB?=
 =?us-ascii?Q?2oZK8o3LBoPIz2xDePGiDhI9IB4n3fUiffC1EcBSywTU/PRCnQmiUKNy/PTr?=
 =?us-ascii?Q?o5Av1YI5EOKU8vF2lnsdpH2I0Hvns6OCUTKHo+3CtbNWD6dlLJSgZdW7Z21G?=
 =?us-ascii?Q?gauVytc0moxYMJ70GEsu2k0tPFinSewIz4uSibFY91VfMmC28EjaC6n5yvuQ?=
 =?us-ascii?Q?iCRspOwOZlcrRCqZ8oCnUbYwmZMp5LzTVEqe6hpepDu5A4duIrVjoRHBOT1p?=
 =?us-ascii?Q?ky5mXIZWKAzwA1DmmP/Scw4q77FYdwmzFLvoUKvXUY7DMk8Q1+SD377QdQzz?=
 =?us-ascii?Q?rIlvOaBJ8+dAZoLeM5vVlzLlNXeomLWDwXN7R9hzQjupBUfU1FU8cwbweTln?=
 =?us-ascii?Q?HNFqtbHUsEpmaXkqxeBjIs2puwAmixMACvTg2pnO93zBJrVxzjEJFc50zw6u?=
 =?us-ascii?Q?HQ0QXJKsxutoMsRg75MhTFXhzmoowF21/CF986xU+WQ6mv7C6/nOBO+dKKg9?=
 =?us-ascii?Q?YHMjEQ6yIt0P8eAGqr4UsyLNQQUVVoBKQfa+dSUM+G2bjPPoHzJIEeEwHWtQ?=
 =?us-ascii?Q?sLFpHCtSF+Frsl5brK8tv0densWnEXQtFDW3ePSU4Vq/SXgUP2LZMjcHgzLX?=
 =?us-ascii?Q?PPMoodtNrWsD1wp0cOUGHvzuqiZzKxqFIMrIPXkqnRokH8xZg9uenGvjgtLf?=
 =?us-ascii?Q?2VDGZax274rVbJwBuRimXbu9+840/a2MtGiKk6vmfjQtMltaqlXOqKE4jSEd?=
 =?us-ascii?Q?R51Zb5ODoxIPdJD2OjP4p3JHUfLnPBDWxZP0TViCABsmFnrrWcwlrUP94dLv?=
 =?us-ascii?Q?sDb6szGT+xdi/JVyTh2a+K49aZmlpCwmoH3xRIOGU/C6znAUofzNl0SMbe4A?=
 =?us-ascii?Q?QAoUDJpykt+keOv07pWk+CIowAkMfYX2av4O9SoGchzdXFey+wiYYGU2KbrH?=
 =?us-ascii?Q?BIrScvz7+ZQfFhvlRew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cj+SZqJPlzcVYYPO9MOv79nyQsbCNd53j7wsoIrV37Ijm6sRDPhov1qr93fl?=
 =?us-ascii?Q?kiGOmJB6HytYloRp6pTa2cqxSSLGaZB55jG5E3tc81px8DUJ9YSn9JqZlCok?=
 =?us-ascii?Q?hS/ek4BOBjPe2YBt6aEIO02fs3otoA2ZFSumxl6/iSvEm9AcEBmkBw4Ze6BB?=
 =?us-ascii?Q?FGCYqIbHIgN4/dEUTd2f5kL1n4Y0wq3jcKfubrm/Z5JL2H4I+1kDN+NfkxYE?=
 =?us-ascii?Q?u0nsgp9cbvFb/BEz6IqOUTdn7bQWDpp52cPBx/yRVb2Ei1QzWJK2LnmLyn3H?=
 =?us-ascii?Q?J1SjQjb+NrqsujDaPWpGrCiiy3iKcaj4kANyXHZkQSWnd5UFGx8BsTiGvzM8?=
 =?us-ascii?Q?fvC7gl6Ba51jnnnuLVodKmTZ2wBUGbEXAC6VdroE4IkxSIb/4gDcj4RUEKzT?=
 =?us-ascii?Q?hl4H8IjrBbUqx0wIcwNtaboa7AeZpIRddhBq/SE0/zNdJ5M8DTj4IS2iD7SU?=
 =?us-ascii?Q?jQt1TbuBE9YaFAco8Q/ZKI14HzFzSOrWCpWPdpHLU3VI6B2WJ3jJy2ULMnFX?=
 =?us-ascii?Q?9kowTRAHwJ40ROXx/wIuHuySpJkeCasZiSL8vzTZVH2CntXBxA8+fcqfDdeH?=
 =?us-ascii?Q?gBsPTtNkGN29BGrHbu5DStod8Ib/VMuBjOGz6QnZMNUIrOJttE0ZMVaTt4vP?=
 =?us-ascii?Q?YA2S31WaF8tW54Tgskdm0aZ2IzLNYud6HtEkJdLKUgU3xaCpH4/XTHKyHHZT?=
 =?us-ascii?Q?3oXqVdAfmFjtKPtZBUxRRzSg57+lzNSXu2qeFz6oGE5fTdxoS5Y1J0ZRWgRf?=
 =?us-ascii?Q?XKI7K3/hv2sfGYHT9wtZ/hoSkmU8lseMnt5gfdlDsrGGkIeRV9fCwj1Xky9g?=
 =?us-ascii?Q?11rWOC74Nv+ACqnxiiFcJdWoFySYrr6uIb5NdWHcJKNtchjOMbS1ZL7qlMsP?=
 =?us-ascii?Q?+R9CyrC90REZy9QgOQ7rQQGX/zHAJ/Gbzpp1YLPSRKsQ4YjJXBaX/NGdr5Wv?=
 =?us-ascii?Q?MPoJWhVfxYkmrJH0U+VFnzuCgQZvgD0OXUSrAEgjRxD9Jcc9wTr7Hm2m5cxX?=
 =?us-ascii?Q?n3tCYO+i0kXt3qTJp6M/L+M5YCmwzm9gCv69iT2eKur3j4RL7OSFrJEGf5A2?=
 =?us-ascii?Q?SrRWEfUdxhgkCgNoTOk2Du3qTKNaEQqn3FQ+Jq1vfXRh8Icok18rauaJIjYI?=
 =?us-ascii?Q?m82lJdOBRx48v3WfIcrs1yt3TO4B1xJL0wbagT9Pk62VbvG90RwaX00PURL5?=
 =?us-ascii?Q?VI/6akM9UFdRAhT6ED3dj2GIkhcZIdpShIxFo9+83KKMrXd8yQBhqf71Ky4a?=
 =?us-ascii?Q?IjvFEERtkGxl6yizMRW+1fBeMSzcbxmbtMURD77p/Uy+qBakqayL9rk63nsf?=
 =?us-ascii?Q?mML53Z27Xwf25/KaZnUBBm7X0kQJZLLloIUDASUWXnw15R6zWgO+c10q0W0O?=
 =?us-ascii?Q?PwPHLN4sDpfx60PGKsG3xgpxEgq9yCwjOgNR93c7z3MfQ5xL4/VFdlNWlLyT?=
 =?us-ascii?Q?atkzzW6FGzzx4tlpMwQtrBtNTLMsx0/UQYihMq4rL60txWn1AJCrNoOGZ7kl?=
 =?us-ascii?Q?qbgTgAmW4Ih3PuVO1ilPjm2fBUGkyiDSz/bZzh5upH0dU0QYZh24MNUqDoUE?=
 =?us-ascii?Q?P9FthW2ehI0qEXzeopZWKhFTAoV3+u7aEY1QQzWDr30uNOQM9OdCNXY0fNOe?=
 =?us-ascii?Q?///QnU5rQXl+3wPLL+DKG7pU0BsPYcBlvrYPXP0dceDdWniPXC1nN2w5sV8j?=
 =?us-ascii?Q?r+hQpal7UPt9NPlgrptYpZKu88lPLXiPfy03ZcdTGZDKYku7W4MHu6t8Duo+?=
 =?us-ascii?Q?mGuKiyTwVoGDonxuEvBgA9ggRGcXw38=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca306954-d6b2-42fd-0f81-08de70797f0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 12:13:46.1759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTRqtzRj6OelyFMRUA2aL3DyqXQ+fAo/zcJ4Dbq3+oJ7ls8d+Kn121vrfJ/pGAQQLMFh51e4xyspM1yJo7feWhcJFvh0bq1RrVgNWfQ+rt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
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

On Thu, Feb 19, 2026 at 04:25:52PM +0000, Medvedkin, Vladimir wrote:
> 
> On 2/19/2026 4:07 PM, Bruce Richardson wrote:
> > The get_context_desc() function takes as an explicit parameter the
> > ol_flags from the packet, which saves re-reading them from the mbuf. The
> > subfunctions for creating the segmentation part of the descriptor or the
> > ipsec handling do not take this parameter though, and then re-read the
> > ol_flags from the mbuf. While essentially harmless, this does confuse
> > static analysis tools like converity which does not realise that
> > ol_flags and m->ol_flags are the same, leading to false positives
> > like [1].
> > 
> > Fix this and avoid coverity false positives by just passing the local
> > ol_flags variable so all code uses the same flags source and avoid
> > unnecessary mbuf reads.
> > 
> > [1] Coverity Issue: 501497
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> > NOTE: Not flagging this as a bugfix since there is no actual bug here,
> > just a code improvement to try and prevent false positives.
> > ---
> >   drivers/net/intel/iavf/iavf_rxtx.c | 20 ++++++++++----------
> >   1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied to dpdk-next-net-intel.

/Bruce

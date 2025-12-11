Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4384D41D61
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 16:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4B8D406FF;
	Thu, 11 Dec 2025 17:12:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 882B240151
 for <dev@dpdk.org>; Thu, 11 Dec 2025 17:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765469548; x=1797005548;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AnbH5p4drITlY4/cGcO8uk5mbI4V7TGcI8yfyhqqiRE=;
 b=XMz2DDURyGPLIV6MYagkKS5iSmwQ8pC466rzFgMBse2bts9jv58EGUkA
 WcUgxhDSzYK/3FJq+jNqEE05P1OmteRjy29EGv4L7INvphHjEjBURRJG+
 BUqU2n8rEPY6dRfJ/+JvhWsRKFnn0jACv3OlmLmYtkflFBJEne8G5zKYf
 +/DKYOnp6r4GPHtEEkMJDoaOiMUDkvVeRxoAnm3WYhmTsdT7WMwKGHKQi
 4HAIi+IAQ+sECtKyT525ewh4WHiGpSu2fWNbFU/ui6C5ihPFNS6XvgY/L
 z0hSntTqZH2SLOOayZhlpfgxc9htdKS9YD1XC2mfopoXFCpobaOC7iHGI g==;
X-CSE-ConnectionGUID: 1OU6qHVUQn28lPiV8wd/dQ==
X-CSE-MsgGUID: 2/JSMoyqRh+glczwYTxE9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78076017"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="78076017"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 08:12:27 -0800
X-CSE-ConnectionGUID: 7haNxgIISwyu5PfmmxJlfw==
X-CSE-MsgGUID: 94IRtxwbRgWvo7jpEs0QBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="197104870"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 08:12:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 08:12:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 08:12:26 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 08:12:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNqZOdVTIjqMN+TUENE0gkz2AHH7INrz4OCKKDiLS5Vr8Iaa4/gr6jeWwTYx4Fz/3pwFXURiOOoFRhYYl1HGWtmLIUWQ3xHckl7DRT0yklVZzx97ZH2vqaF0orxPn09jTMH/5G0DLQ1QcL0afICRs2XOXj6CSwh4fLRBoeY023n8ebsLRPqsYPcN23/Xop0z4qPM3hhF0WrlLZg5JmvL7Y9auaEDk0gAK5UzIb4xfOH1KmHAxVwwD7XCVpBjmtlClXwdqpEKzAc5DY0wtKbyxZHzwO2yWyZG6taPU3mrUPZzZBs4D+X72V00GE0nR1cncawT6Ul/eLz0XdgtzBZqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z069kIEm2hkis2q8YTauFhWugO6TRVnEn5VdPHpFXDA=;
 b=Qc+VQ3BKWkAmnbvl6d14dT40yah98mg4rzJyfeCmR6DvmD37tp1/qkc5gxGOi/MYl+yLT8rONc81RHYgcWvO3ChvW0cZctFCRc8TWStfbpPnfhgHHiO2xO6sMHegXmtGocn2zQieFFvEQk1Pr205qXHl49m7ygY6O04+igLs7x/UaebYsx4yE1difkUFCu/LnGI34q2Q2ylXrAKKSwrASAiGF3/JJrwpv93RNVM8YaNT+4OO4ONDnTw4lXVDMmBbGdM5UQyreWAj3NYsTlbTSZnV6zSokUGtJ+Fyz5UVJNRwEbfJP5z68Gf8jea6fWTY6Yn01Rrhu5iifq1CcyD4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 16:12:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 16:12:14 +0000
Date: Thu, 11 Dec 2025 16:12:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <rajesh.t.puttaswamy@intel.com>,
 <manjunathgouda.hosamani@intel.com>, <sadashiva.rao.pv@intel.com>
Subject: Re: [PATCH v1] doc/ice: Modify E830 recommended matching list
Message-ID: <aTrtWd-eQJ2DYQgm@bricha3-mobl1.ger.corp.intel.com>
References: <20251205070601.1155113-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205070601.1155113-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: be3fd43b-7319-473e-e307-08de38d00c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZFWxctY/tG9l0n3HN4HdUNbHO5QghK0QkZzTKSxt3wUusZdSfJFTgdoAuXgt?=
 =?us-ascii?Q?lFwRKo92u2Xr5Ekz2alnA1NmZ4uPRtLdZ/hw+H8LgIAizkNvEs7yDpxkWrfg?=
 =?us-ascii?Q?jk+Z3GTdUs9QMSYg7pUIDOunvVAPj8ZNHM7VRdkBgX3UkHQU/QrocSsZOMOV?=
 =?us-ascii?Q?8Q54jAs2yDUJezRsCPkRcNoE4tL9Hb+XFzqrWjASeyiVxdhxRYN/iUkJ7q9C?=
 =?us-ascii?Q?QznwhsoRC9yy78UAZC1dQT+RIL89owde9NGw2gvtmGZtcxxpMdXP1nuRZaHt?=
 =?us-ascii?Q?Kobtckw/trYLRW9T2z0uctRTY76JSnZZA+eMSk2LnTwveh/dj/sToLzhxOu1?=
 =?us-ascii?Q?mbQ3GSaREhiK5yMqACx1sp7+/sNVSbletK+F6S832usprTJyPPxpqNAGSkUq?=
 =?us-ascii?Q?rqeWCmCkVzTcxlk1L569460y3Y5JJougyH5JEbOv30jZPO1eK60s5Tx7AF6e?=
 =?us-ascii?Q?JtxR8dmKjxMZ9Ui6WyrrMGRu2JVnb1ZGLDVw/6Tq00qSbIHNoitY6HLaWkZo?=
 =?us-ascii?Q?glOBvCafgxV0hURNwxSv7W5MEHkI9AyM+2MaP7erVbkP1ER6rEO0BGt5wnVF?=
 =?us-ascii?Q?eaoCQ3ZkhAl4d0SBl6FNR6Eqk6/7GPwvCPi2q0QSnxAU8gbprFOS6IdSdUAQ?=
 =?us-ascii?Q?ETIwE3gxNT6Fg3HaOatM5fS5diVi6nOClwZOVAgut96LgQm8Xu+iWh+Q95hE?=
 =?us-ascii?Q?tnmEopBcsZQeT40Eg75LH7X3kaLhwyeJcv5MCpppy/yiRRg+2x4X+Uds2v2h?=
 =?us-ascii?Q?yHP3uZNzbgBOJyHWS2W5LN6CLeLAwhqmfwHbBEBzdbc98VR0H4V0Gpxz9GMF?=
 =?us-ascii?Q?zuwe47kmuaGqiVgZUhHXszVruRhdf5tNRtIdz+/HlZzSobUKFrUCORBcwOR3?=
 =?us-ascii?Q?qjMu1z1YZHe/HczguJq/oowrSC/BOx94zcyAw3fEBRm0rmc8EK/JCkNDcPoX?=
 =?us-ascii?Q?Dywc2TGVBaJCpgVc7nxzv2pyLlM2RP452gPubiFiZwmps/jkv71MBFR9borj?=
 =?us-ascii?Q?+Osljc/S3PdNz/yhhfdnNiISJLr4i8MvmWt6Bu5b4nTYRbAPB8c8Gory3jq1?=
 =?us-ascii?Q?I7oXyMUN1pMCbTrBEe1qt9blf5AV57HMGK52p2e33sm6D08LQNeL4jJfAYha?=
 =?us-ascii?Q?Qy9E+lXkoq8S6kNt/eoo6t5bQMSYV6U3kAOySOMHN96prpDhx25Gu4zlJsOW?=
 =?us-ascii?Q?SljSDhYGb2pbQSD7MIvEIy3qqcEvOnV4tT/hUixIlaKED1X5uyyn038XWJRM?=
 =?us-ascii?Q?0T3K5YU28FbTlFNgDLzPa8XyatNLmBPOcd05ufvMxyvkOZod7s0PZx/ONcct?=
 =?us-ascii?Q?5diMpjXJZjr/2HWgVm+BfqC2aViMGv/I8/1tsn7fpXKQ3YDQ6P6BM4HVDr3f?=
 =?us-ascii?Q?KxjiyC5Za/L1mG6r0R33qdJAB4flgw64pJOQVJ91aE/0xoC7BCagiIETI9pT?=
 =?us-ascii?Q?Kx/e0Ay9z0P7tx9YgJsmGWmobvs+y5g5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gc84/yhXvfLOf/2DeC+MjR7vGR1/119ZH7O9EadehwgiDxFXkaaMIdtM6cJk?=
 =?us-ascii?Q?++YaNPKL8t27kHRyoLW3t5egKWQD4loerWy7iiUX8rTbyUocXG9wdgXDclsX?=
 =?us-ascii?Q?HDzkgOH15mXbC+AcT5poi5tkIyFoJyBncQrYHNS1JO2UB6s6CqB8+d4fCj8h?=
 =?us-ascii?Q?PgVRu+/bUKA33FaAEd5P2qwYFxdjfgFpE54ilruc2RKjm89oinZwY44ylrPI?=
 =?us-ascii?Q?dMK92Hfn1M9yoRqAmvOiu4mKPxxN4bJjYgLZi2HwdvQWTiK/sxu1wb72L3QC?=
 =?us-ascii?Q?YOo7LC9UQaoLeRi4Qw5AZs+Bm+AtRiV/ayEUMcYpBfcqDozYCzHuiRtIW2sy?=
 =?us-ascii?Q?2UM7p1fAUHvWLvNNfSMhQYaumvhCW+4vTW5bPK+KxK9AZbThYmLenuq2kIJ/?=
 =?us-ascii?Q?NRBBA+4ixzFmLuz2S8Y3PSt0tbjNL9IYBYk2n/WvlIwO6WGcz+p1/T893c9w?=
 =?us-ascii?Q?blQKZwqhte4f2F6W9tH8pvGxdy2w9mCjhF25VUbG/R832aTG8/t6frduaD9r?=
 =?us-ascii?Q?nfmqW9mszf2eDcHIidkHjW/MIIfo9zsH5D6C2JV3KBsxMxoU4gdpQAYhRFbe?=
 =?us-ascii?Q?SnstoMcJA2pHLyxNO7Z6C9LXC9yTELr/Ws8CFei0o4hhs3Hi6F8II3jd/LcX?=
 =?us-ascii?Q?L30uygJAj0eHG9OEq2bHZLhO+oHXuOhKZP4V4nxxOiksO89rZB5t/c4Iw2d9?=
 =?us-ascii?Q?xbPaTvl5dRsAOLzz0m0K6L4LsypsEJU27xHgS+J/0gcqHr5h3+8Hd3RZOa4n?=
 =?us-ascii?Q?u/LGzq+l/lPHZocVJZkOZDuAEjikjGL3SBBbuBwwtaGMd/uLHDI4NlEPFJpC?=
 =?us-ascii?Q?M5mLTowQ/7lcYYhcExqL9KlPIkjh+go1k0rbWlUfD6w6FXJPb66uj3gQY5Cf?=
 =?us-ascii?Q?xoLrO6AIDnvFhUirg970FbJo+SZ8FNJb6Nz9fpv0noXEHHWfmW5TBlOkoD+q?=
 =?us-ascii?Q?JXTDFSorIdZHsd7FhRDgdo3SGOO2vwHO1UAk3qMSsTA0Z0eswgn4f4gCbxCr?=
 =?us-ascii?Q?fPSjUIcX98vq6YinPQrN9OSQJhyh761nidzDB8M13GoZr2os49yZ1wBcm8/5?=
 =?us-ascii?Q?bJxiZon5sAKsGsjCOKi0voHEfKEzTZGaPY9fbzw3E6WnVeUnxpO7pgTEjcob?=
 =?us-ascii?Q?TFUUbxU6rXl5WULVjL4K6i/YuKNzOBP7IKKSzzkIjijp1uDQtnJ7ZNwdz33Z?=
 =?us-ascii?Q?h9S0XBJ7CF+TXpj1asA0H0cDVp7Glmc5cA+8zNB0Wr8NyuGYSJqkhHW9C1he?=
 =?us-ascii?Q?IN2Lcae8fZg26gDTyYf1zSHo2tiGXzqW9UvhCvK6WXU2eCRY0PUjfOgBSLUG?=
 =?us-ascii?Q?l2UAfNpKkblGs6pAdqN3t2SykdMzH8dCoS+hTqKcMXgVt7vhYsbCmnRMer1z?=
 =?us-ascii?Q?9scw7/p9jfZijCHjRTRQJrKkjUeDQK9W3VMgS9NlPzGdJjtU5dbI1Pu/DexU?=
 =?us-ascii?Q?43ecKWUDeUK4IO70AiTKWQEV8fUG3ORhv3z71KxVYm95MyezMWnYnBG+jZuR?=
 =?us-ascii?Q?+6FWACBGvus3Ph2Bc5M2BcVVWmQ8jekeX0YE77LdsMvwOOlwHHzpVCIvNo6s?=
 =?us-ascii?Q?mPmPx31FgWucrnCkwaCDqgygUxnLnLgDT2A7kImUQFRipRFvKupeu1KPEpm8?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be3fd43b-7319-473e-e307-08de38d00c2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 16:12:14.4145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V0db7GuHfI79Y0sVZjczVERvTrst+xVcVdNashhV/KkLMFheJBad0wMu5e5WhesoBBw1MHO75irtk8FyEeCdSDGXixi2Rx2qrisrv8e+Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
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

On Fri, Dec 05, 2025 at 07:06:01AM +0000, hailinxx wrote:
> The firmware intel release version for E830 is 1.11, so modify the recommended version for E830.
> 
> Signed-off-by: hailinxx <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/ice.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index cde31a5694..216c79b6f2 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -97,7 +97,7 @@ For E830,
>     +===========+===============+=================+===========+==============+===========+
>     |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    1.0    |
>     +-----------+---------------+-----------------+-----------+--------------+-----------+
> -   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.2    |
> +   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.11   |
>     +-----------+---------------+-----------------+-----------+--------------+-----------+
>  
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel with fixline and CC stable@dpdk.org, since
this is a fix for 25.11.

/Bruce


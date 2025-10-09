Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B93CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 14:25:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB83F402A0;
	Thu,  9 Oct 2025 16:25:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3F4D740267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 16:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760019956; x=1791555956;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XgKFdeq2YVunlKqm4TwpxZPktUYxGeA9pJ5GjzLcuCU=;
 b=J+JjDDJNPOnrykmVV2MTJcXHHczbzG5/dUOVL8+ILug5/UYzGEXP9ry8
 TK1Foo9UoBq5VlXBGmNw9meyTsMt4+gb2SgftVp2vpNTF+rGgfI1ArkTv
 igW2izNwPRUHSOnwnw2T8HlGDni0OqvRZxULRR+WEH2Xz5IyFtSkK0jKL
 0t5iZyWZ7CSvfWmFNowmGMlrsqJKpGPtekCwuUfuLmhXj39HIBSRAsA0t
 jt8i3SQFvGE0Axs9pl/nGf1GjBXX4+41j2/zA0Hr8/afDVjT/Bx+uHxL5
 ju3ogXSLwQvlh6LmfjNgbrtXCpFXJ/duvmzszzGQTQowwew8YfW1E1lbH A==;
X-CSE-ConnectionGUID: pCPnt9r+QCyz/aqidL7IRA==
X-CSE-MsgGUID: oogFl8vSRRqU2JD/6F0Mog==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62273408"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="62273408"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 07:25:55 -0700
X-CSE-ConnectionGUID: yX8aS1RTSjC7Ig8bNsF4gw==
X-CSE-MsgGUID: umKGd1g9QEyEj7tIZysYhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="185854487"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 07:25:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:25:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 07:25:54 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDiyC6fBd5Ecc1ymWnowyOBdkd425lWWly6q/CU0jqZely54gnByvnS5Fg1kv6cKTbcfiaOoxHpzAi7gh/sMEgpKrE6qOi2OHA6E9Mr0HTRWNBSMt2tkPDNwSklwZCrAHQKmkcqih4PbWeOasmIZ/ewn5qf+d3DoYJZs99LNO7MfUfUwaI7eNSMHs1EudH4e5VSAtL2Su0qdjk8YHDyKNOJjH9C4I+y6pp5AAXGIHQ4FFahsgkn5nFMhocJZx9YVGffa6p/6YgvXzaGIkLGUQgVVuXLo9oGm4Ki5+YhVQk4OAvxmP+/GX4mvxNpXSxEdHTlGoAk/QxoU+DkzjhojYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkl0yi0bOXYrnpDdqXGCvAg9GHP4S1F5ExrGFFJUDDs=;
 b=cdb0RMCNvL4zP/Y44c8Vz2edBz7MnMyszzZD4Drj0Up1gtHHcilHeGf7Skv7Q+lhQBSbegUKJCWkH3FZs7jcz7NOG1luec5TRHyMyUU4NWkal8Z/ONp+ivqBUkuxCK70A4lJEuA7+oWbARRBmBpNGt+o2xQzLZxsOBZSO23CGVRWsaBH+D9U2qwvZ3El8lXGG5tOEcOT1//N2pTBkqyV2tPk5tjRygaguIfZCDfkp4L5LffLNBevVqCQdO7/lMTSNz3hxU7fqgtBwDzRcsXBVwWnYQJh4L5+UTYFqgpeNwNPIJf3nAW18HqnJfjHX2T9uQrvNhLUcdCI3kMOcLMghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 14:25:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:25:51 +0000
Date: Thu, 9 Oct 2025 15:25:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 2/2] net/idpf: enable AVX2 for split queue Tx
Message-ID: <aOfF6lYDICH2GsYE@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20251003094950.2818019-1-shaiq.wani@intel.com>
 <20251003094950.2818019-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251003094950.2818019-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZP191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbb315d-444f-4d2b-00d7-08de073fbf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GBl/F+IfKvOeTS7/p/i5oNtAtOEk+2zHtlmIp6zQcIqBCWB8m0vAXl0k62Cs?=
 =?us-ascii?Q?LAohpPtk8YsaDlMHKzuUUMJ45IhrQ1qkjjvgdkIcqAOSyda+OjZlSGr1hGuh?=
 =?us-ascii?Q?QT4FF/f6gqdfKzGkviD5EJHcDPDS++qpx9TnMWUmua7J2vHUm6DkSaxO6lw8?=
 =?us-ascii?Q?MXZPKrm1jNXf5qhzGGBGV0B6u3AqhBmuDdkMHsMXuJUYFI7WgT5ISyx4KIZn?=
 =?us-ascii?Q?XAg+Vm+sMA1rD3HdtFGW4ausj/FsiC+llws9HtwISPsgloKvm52GXBGVkZWB?=
 =?us-ascii?Q?rTFbWVouR3iS3i0g+rd6VaS/ODnb2oNr4RfhLm+MWwtHaTSnZ5z88SzsC1zb?=
 =?us-ascii?Q?v3/1FwO+PBsjh3oP2hvwiZ3cmTFa/5eRILVKt3e3SE2X2+an5a6BqpjTJ4LI?=
 =?us-ascii?Q?TV9adTUlfJQAmql/lgBKOEbl9nK5+fnCwpoRXzCmHiYMeDyaiEzlmmVZLq68?=
 =?us-ascii?Q?6DCsl4e3k5QoP7s9XoNVq/vjagNx50DceshfHuC2JSXm0+weX23nrGU8FGi1?=
 =?us-ascii?Q?Bv7W4H0GQgMZgvc4DZT+rxY5ARxQYkjpBESRXkNWC6xEOS0y+TLL3ma+riW3?=
 =?us-ascii?Q?KISlwenAkzb4ka6JwS13dB68ZhYCPKU4BNuJ48F9s1weEjuTZz6dEDlI6mSx?=
 =?us-ascii?Q?fU6dOszXQTKQIP/l67T5xonSl6hqctNqmpJvEipRGhBGlcE/GVl6g7jGTqNJ?=
 =?us-ascii?Q?s0Rzs31xjSsXq5pzHGtYPAqGx6A6JaFIcGPHhD6HpbIsaWNWPHPl6mtDF5wD?=
 =?us-ascii?Q?31TuevDa8hEDtqpOvBH1iakGBqn5ZhBAvftnyg4PRooZIHhP0QY4VzNgxNBB?=
 =?us-ascii?Q?tIcheWx8mui42Cmz0i+SYc3tO6thyBxsVlJKxPXI1v16zZs1Hht4SQUfq4Zi?=
 =?us-ascii?Q?+hdwd+m6ueVZkP5q/XmX8Xx1EQpORcHSaOXvoqfrhIiHAFWQIT/KOQcw1zuV?=
 =?us-ascii?Q?Jp0kQY2MbDnlIMLL9Gh8BayjFwOPfJtrjyESH2duOpb5KW1p8Zoahhs1j+aX?=
 =?us-ascii?Q?i4ypndMREXBk9C1RjvRKZXxILwR+trGV6D5y7FiZTEtgMnaFMWrVnnuGCGbD?=
 =?us-ascii?Q?hlNfkrOMWz36JpfzpGlFfoFg2df81BHqfmcGQ09VozIp5NDL9eGXIVeZ5zIB?=
 =?us-ascii?Q?pZxDPd4h1XbmwgzEO66ijplvMzndLIwveeFK3p4FFklWjHTs0tOI+jcGgTcR?=
 =?us-ascii?Q?Z4aGxkWBGuPqli6ykK7h+YK+OYEgxmtYEqE48tGy0xZYgBeEu5uyrKhrwn2u?=
 =?us-ascii?Q?DZjgkHRiv5DF/X3uOYLrkNvECFWmlglp5GqSTt7oGyHqWnvwey4AwU/ma2Ry?=
 =?us-ascii?Q?ZTRX/+18AsEE4ykPCb/GzZ7jK1o+GlmVF83lGdjK4A1ifTPuNMarvs3gT8Tf?=
 =?us-ascii?Q?29Ek1hbwPoMLn1Ma/ogWKu385zvPggraFWMYjy30asPmaIAEDn0p/t/kNXvq?=
 =?us-ascii?Q?ENRMh/LCAp/ZuAJkxGMciIgqDRu0W0Va?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W7WESseU5Q+4qNHGv/uQ/532RdailPlQdsANIZDahm5A4ArEGJDjaKzynl1i?=
 =?us-ascii?Q?b2ROAZk0P00LGAmNL68eLolShRB3JMpEsgKiXkF/PF1k9OVuNnLPy+CSiY9t?=
 =?us-ascii?Q?i3LbvIR5eZeHqicn2Z1Z7HA+ZgdoFlKYgyIo8VDTBj2GHNBdYHJL0Yc+ENZj?=
 =?us-ascii?Q?zmpy2Qd96fIoFmnOpttnGASoZbjtqXZ4EXXhnukIiXI9vKzITv1cZYwb81+x?=
 =?us-ascii?Q?IpQ9SSkCZ3A/1d8QpfRcbOEnlFfvtG5q7bw0Q83ukwvciDxTC0w5Fj+nsuqI?=
 =?us-ascii?Q?kjwsrSxeJ03j2n2VtWlmTy17g7vBnv1A0U7RfdYEhzXuUTzloOZA0xEw6Qh3?=
 =?us-ascii?Q?jBV8W76AZypUaNDZ9aqyNg8kk+XILpXDO4zQubgqvSl/SWKgb/9ey1l46/4x?=
 =?us-ascii?Q?ec6Zx9vY26Dytm/RYpbQ9H4iHJSU/2iniHNTQi813vxWFUZNKpM1LYPGIAFV?=
 =?us-ascii?Q?CzPZebEqZPMBXaEzz3tcVNH1krGsfddkcJudJ0oSoDSLqlr2cbEYbcqTBPPl?=
 =?us-ascii?Q?4O0xeSerRI9lWUIRvxs3bYrePnWd9nYOLBV7bWz8B/mZO7VM3Hg0lvlAvju9?=
 =?us-ascii?Q?60kcpI6VAZDBVMC6+Lyu1lENpRyUVqEVx//rmgXagxESBnO6zbIeRymkKRro?=
 =?us-ascii?Q?b/Sw9r/7gJjmWlbsqjVm9KMz5TEzitmj2vOqxdDir76jPz+4lE4Polm48kYW?=
 =?us-ascii?Q?Yu6iLIsIQmtSdvRFMyJbkjAGTe4T2/yM3WwkHPi2ZFrhVYUEQc4hxh8tBL4u?=
 =?us-ascii?Q?Ef20yQusdbofGyFP4hgNDu4B3Fba4j7jKFHXfq3kxQZLRkEpS63Tn/02tVwp?=
 =?us-ascii?Q?n4EtdQ0bBhHWvE08hlnF0SZF+6se2l81A4HrweX2GiGfj6gSZR5e03EJNZJ8?=
 =?us-ascii?Q?fgGShACT0j47qBO5GSZMbsrQtH/1wLVcSVNaD+wVEPaTlqDEPoVa3c9PiRrC?=
 =?us-ascii?Q?sNcW9I7apEhkYiktlLkasB7NJmpThw77bdNA7mtvDKBiyroomCGj+wO4d6I+?=
 =?us-ascii?Q?TTqo51Jk/9ez5hF/Jy5iCxHROzb6dz5+ZVEZEh1YUEBKUgk79+5uz4A5MxZN?=
 =?us-ascii?Q?hlM9AUbmJZBCkPXnNcapWe/OEcehYwDEmNq+t6FtTLHsD2+ut+27EYiVJjr6?=
 =?us-ascii?Q?Joqnjl0KLbPSYRMAbgCzg+M3N+REF66qTlSi9Yaf5OJ8TWokWe80E1cwJpXX?=
 =?us-ascii?Q?b6AIPRCFsoFV8skjpTGPOeAD5B441wezh3hWWtOWSteITtNmpYxVkNQxnd1b?=
 =?us-ascii?Q?t58BrYNWBHHWfZOcFegaJrl21A8VAX0kzglWOBz0hglGlxm0CDNa7ktdrvPT?=
 =?us-ascii?Q?B9SbQA8GNrsezphpYYCh/XCtBfGEpW9SRUByjhOmu9Xgt2lIlsFj1zazw/QH?=
 =?us-ascii?Q?yqvLaZKw+DNhwws8jt5gI9tuazI7boE98A32disjRXDfr5DSvDTf/J1O0v2n?=
 =?us-ascii?Q?sw1jIQHeBoatzzAGG7TxIF94YqckVLpw/0T/XLkhuYUf5zMMXu9skRhIKV5w?=
 =?us-ascii?Q?Z883Yo20OAbSz+OvEJwUpGJK/J9usolt1gVWERAZTficqr2yyMRZmZmrm187?=
 =?us-ascii?Q?HIcVA9WDE233vXjhharod6xSTmQt9/6P9VidnemorIOX9S9mHDHrxysqd4YO?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbb315d-444f-4d2b-00d7-08de073fbf95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:25:51.3749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/lcoIaf8XNluHykICbuzVAGJiuwS1kKAYSHDu2fzqXAM1uIFftCpgMSnVm+IeViVKRRH4pWimpn+jRvhuwfuT2rPoxrrpSbtnvWPRrW/cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
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

On Fri, Oct 03, 2025 at 03:19:50PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>

Hi,

review comments inline below. [Note, I reviewed from the bottom up because
that tends to be the way this code flows, so earlier comments may only make
sense in the light of other later comments further down!]

/Bruce

> ---
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   3 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 197 ++++++++++++++++++
>  drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
>  3 files changed, 209 insertions(+)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 87f6895c4c..3636d55272 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -264,6 +264,9 @@ uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
>  					struct rte_mbuf **rx_pkts,
>  					uint16_t nb_pkts);
>  __rte_internal
> +uint16_t idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +				       uint16_t nb_pkts);
> +__rte_internal
>  uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
>  					struct rte_mbuf **tx_pkts,
>  					uint16_t nb_pkts);
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index ae10ca981f..1d8f7dd0e3 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -800,3 +800,200 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  
>  	return nb_tx;
>  }
> +
> +static __rte_always_inline void
> +idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
> +{
> +	struct idpf_splitq_tx_compl_desc *compl_ring;
> +	struct ci_tx_queue *txq;
> +	uint16_t genid, txq_qid, cq_qid, i;
> +	uint8_t ctype;
> +
> +	cq_qid = cq->tx_tail;
> +
> +	for (i = 0; i < IDPD_TXQ_SCAN_CQ_THRESH; i++) {
> +		if (cq_qid == cq->nb_tx_desc) {
> +			cq_qid = 0;
> +			cq->expected_gen_id ^= 1;  /* toggle generation bit */
> +		}
> +
> +		compl_ring = &cq->compl_ring[cq_qid];
> +
> +		genid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
> +			 IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
> +
> +		if (genid != cq->expected_gen_id)
> +			break;
> +
> +		ctype = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
> +			 IDPF_TXD_COMPLQ_COMPL_TYPE_M) >> IDPF_TXD_COMPLQ_COMPL_TYPE_S;
> +
> +		txq_qid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
> +			   IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
> +
> +		txq = cq->txqs[txq_qid - cq->tx_start_qid];

Given that we have multiple Txq's working off the same completion queue, do
we need to handle the scenario where we have multiple threads sending on
multiple Tx queues at the same time, but using the same CQ?

> +		if (ctype == IDPF_TXD_COMPLT_RS)
> +			txq->rs_compl_count++;

According to what I see here, we increment the completion count packet by
packet, correct? And that matches what I see in the descriptor writing
function where I don't see a separate flag we set for reporting status. In
that case, why are we tracking the next_rs setting for the Tx ring, when
there is no specific RS bit to track?

> +
> +		cq_qid++;
> +	}
> +
> +	cq->tx_tail = cq_qid;
> +}
> +
> +static __rte_always_inline void
> +idpf_splitq_vtx1_avx2(struct idpf_flex_tx_sched_desc *txdp,
> +				struct rte_mbuf *pkt, uint64_t flags)
> +{
> +	uint64_t high_qw =
> +		IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |

Is this a typo in the original enum definition? Should it be ..._FLOW_SCHED?

> +		((uint64_t)flags) |
> +		((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +
> +	__m128i descriptor = _mm_set_epi64x(high_qw,
> +						pkt->buf_iova + pkt->data_off);
> +	_mm_storeu_si128((__m128i *)txdp, descriptor);
> +}
> +
> +static inline void
> +idpf_splitq_vtx_avx2(struct idpf_flex_tx_sched_desc *txdp,
> +				struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags)
> +{
> +	const uint64_t hi_qw_tmpl = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
> +		((uint64_t)flags);

Line doesn't need wrapping.

> +
> +	/* align if needed */
> +	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
> +		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
> +		txdp++, pkt++, nb_pkts--;
> +	}
> +
> +	for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP;
> +					txdp += IDPF_VPMD_DESCS_PER_LOOP,
> +					pkt += IDPF_VPMD_DESCS_PER_LOOP,
> +					nb_pkts -= IDPF_VPMD_DESCS_PER_LOOP) {

Over-indenting I think. Two tabs should be enough.

> +		uint64_t hi_qw3 = hi_qw_tmpl |
> +			((uint64_t)pkt[3]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw2 = hi_qw_tmpl |
> +			((uint64_t)pkt[2]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw1 = hi_qw_tmpl |
> +			((uint64_t)pkt[1]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw0 = hi_qw_tmpl |
> +			((uint64_t)pkt[0]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +
> +		__m256i desc2_3 = _mm256_set_epi64x(hi_qw3,
> +			pkt[3]->buf_iova + pkt[3]->data_off,
> +			hi_qw2,
> +			pkt[2]->buf_iova + pkt[2]->data_off);
> +
> +		__m256i desc0_1 = _mm256_set_epi64x(hi_qw1,
> +			pkt[1]->buf_iova + pkt[1]->data_off,
> +			hi_qw0,
> +			pkt[0]->buf_iova + pkt[0]->data_off);
> +
> +		_mm256_storeu_si256((__m256i *)(txdp + 2), desc2_3);
> +		_mm256_storeu_si256((__m256i *)txdp, desc0_1);

For Tx, there is no race condition to be aware of with the NIC, so there is
no need to build up and write the descriptors in reverse order. It's not
wrong to do so, but unnecessary.

> +	}
> +
> +	while (nb_pkts--) {
> +		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
> +		txdp++;
> +		pkt++;
> +	}
> +}
> +
> +static inline uint16_t
> +idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +						uint16_t nb_pkts)

More indentation than necessary here. Double-tab should be sufficient.
However, if we don't wrap the line it only reaches column 99, so no need to
wrap at all.

> +{
> +	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
> +	struct idpf_flex_tx_sched_desc *txdp;
> +	struct ci_tx_entry_vec *txep;
> +	uint16_t n, nb_commit, tx_id;
> +	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
> +
> +	tx_id = txq->tx_tail;
> +

Why not just assign the value when you define the variable?

> +	/* restrict to max burst size */
> +	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
> +

This was done before in the calling wrapper function. No need to do so
again.

> +	/* make sure we have enough free space */
> +	if (txq->nb_tx_free < txq->tx_free_thresh)
> +		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
> +

This looks wrong to me. From what I see idpf_tx_desc_done always returns
true when using the splitq model, which means that you need to check the
completion queue counts before freeing buffers. That is done in the wrapper
function below, but here you only compare the free count against threshold
meaning that you will free buffer without actually checking for completions
are not, right?

> +	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
> +	nb_pkts = nb_commit;
> +	if (unlikely(nb_pkts == 0))
> +		return 0;
> +
> +	txdp = (struct idpf_flex_tx_sched_desc *)&txq->desc_ring[tx_id];
> +	txep = (void *)txq->sw_ring;
> +	txep += tx_id;

Why the cast and using sw_ring rather than sw_ring_vec pointer. Also should
not need separate addition - can use the same style as when assigning txdp.
What about: "txep = &txq->sw_ring_vec[tx_id];" ?

> +
> +	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
> +
> +	n = (uint16_t)(txq->nb_tx_desc - tx_id);
> +	if (nb_commit >= n) {
> +		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
> +
> +		idpf_splitq_vtx_avx2(txdp, tx_pkts, n - 1, cmd_dtype);
> +		tx_pkts += (n - 1);
> +		txdp += (n - 1);
> +
> +		idpf_splitq_vtx1_avx2(txdp, *tx_pkts++, cmd_dtype);
> +

Is there a reason for writing n-1 entries in bulk and then writing the last
one individually? From what I see, the flags and all are the same for them.

> +		nb_commit = (uint16_t)(nb_commit - n);
> +
> +		tx_id = 0;
> +		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
> +
> +		txdp = &txq->desc_ring[tx_id];
> +		txep = (void *)txq->sw_ring;
> +		txep += tx_id;

Same comment as above, except that here we know that tx_id == 0 so, a
separate addition is definitely not necessary! :)

> +	}
> +
> +	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
> +
> +	idpf_splitq_vtx_avx2(txdp, tx_pkts, nb_commit, cmd_dtype);
> +
> +	tx_id = (uint16_t)(tx_id + nb_commit);
> +	if (tx_id > txq->tx_next_rs)
> +		txq->tx_next_rs =
> +		(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
> +

Watch indentation levels here. This looks like two code lines.

> +	txq->tx_tail = tx_id;
> +
> +	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
> +
> +	return nb_pkts;
> +}
> +
> +uint16_t
> +idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +					uint16_t nb_pkts)
> +{
> +	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
> +	uint16_t nb_tx = 0;
> +
> +	while (nb_pkts) {
> +		uint16_t ret, num;
> +		idpf_splitq_scan_cq_ring(txq->complq);
> +
> +		if (txq->rs_compl_count > txq->tx_free_thresh) {
> +			ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
> +			txq->rs_compl_count -= txq->tx_rs_thresh;
> +		}
> +
> +		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
> +		ret = idpf_splitq_xmit_fixed_burst_vec_avx2(tx_queue,
> +								&tx_pkts[nb_tx], num);

Line doesn't need that much indentation. It also doesn't need to be wrapped
as it's only 93 chars wide.

> +		nb_tx += ret;
> +		nb_pkts -= ret;
> +		if (ret < num)
> +			break;
> +	}
> +
> +	return nb_tx;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx2)
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
> index 1c725065df..6950fabb49 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -850,6 +850,15 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
>  				return;
>  			}
>  #endif /* CC_AVX512_SUPPORT */
> +			if (tx_simd_width == RTE_VECT_SIMD_256) {
> +				PMD_DRV_LOG(NOTICE,
> +					    "Using Split AVX2 Vector Tx (port %d).",
> +					    dev->data->port_id);
> +				dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts_avx2;
> +				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
> +				return;
> +			}
> +
>  		}
>  		PMD_DRV_LOG(NOTICE,
>  			    "Using Split Scalar Tx (port %d).",
> -- 
> 2.34.1
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AE6EFD20D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E37B5402E8;
	Wed, 25 Feb 2026 09:58:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 79EAF402E1;
 Wed, 25 Feb 2026 09:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772009935; x=1803545935;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kO9fJ8S97eZcEtWdfOJrDoIsB+/sgwfWilHj3gRcJ/0=;
 b=hleSOpSOeT8U8bL3Sgaj/zWM/FFzC3uvrzwUflSYQT7oVdrU07JIUW0e
 DHPWFUVYrJ8iOix0B6JBMnYqqUC+Yo1mpIrzcOm6bQWTS5YqmNSuuLN26
 FeQQXBZYjzoepoob5I7EdWjYJXichEWPT4YwXyIS3D/XGj76BD1mvCPOK
 81N0aVhFm71Zj+jVhEi6nfTAemio86er1XxmybEOPgYSSYMyGOtruP35Y
 YkYB1vRW2dSYuYD623P517FURFQp0cDvSo5xm4cIK9wqJHLNaRFCJct6c
 kIb6xTa2Py7cWTZhR3DpkXndj3UyiLaIsTAeLFIu/NCxpkc0XAMuzOoPk A==;
X-CSE-ConnectionGUID: ugQ5Ej/ETg+1Zy3SWIQkIA==
X-CSE-MsgGUID: XpEG78dPQaK3BcLuqJgG1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90621742"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="90621742"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 00:58:53 -0800
X-CSE-ConnectionGUID: /mOQP+lqTHKUBeWJQajYbQ==
X-CSE-MsgGUID: yDlSkgjUQ1SfWJduPj5WmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="214310965"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 00:58:53 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 00:58:52 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 00:58:52 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 00:58:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7GNN0xFyssrA01qQ2jvhTkBzZnv8/0i83T6/ezT6rUFUWTDpxxPsHq9cAE5irUm0+XqRzqkQ1O/NRqCZvUi4D8g3fwBtDQt9xOgsb/QXe/ouA8M2YHFQlnjNLYfETh8YLu/A949/Q47eInJTFAI7vgVp1/jNd/HETTYOUp92bvaUQLPByH4uCiV7a0J7Xpr0LKBYEk+WDttGDcTE8Vf4GcIf6j7ZS93z5QAQfDZsi2ce8tc4kPtND9RqkYXKS2sVL2YNh5KqIIzb4zUpAeQ48VIy/ARVoHYmyExeTe/dscJcaI5ZRW1L+faoFAhKZRz4ZpO34rLWlYdzZFdBHriCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaxdZI0gaEOiRZODF3/AycqpkVAg+3F43QhFvnJ5mtc=;
 b=YyV5dMkzLj/aHQT7KlmPxLT4JvPNFh5Gqcz+DapRXqAxKoqN5RnnEA2Fpts1YnhIInpD+u+lrnu0I6Cb7RoAqG98suRI8k64gJnfcYPCypkxaBTBxH77v3PuAXpTja7MvDxBfgrC9x9s9R9rE9TcZ1sU7gmFogbm1I+669/RLgYLF310J1T5OFzT3XxvJcPO7sxLtzJqVifggdyM8YJOabzfmtGGF0V61McWcD8pNod8zKll7Pg3SQgcCvmExqqnj4mJpHdbjmxhPDR416Z/XxG8SGFg3bRl1EoqQlVX6HYjsy4iZ4HqNcp/7lBuJa9S8adXEoVtRqYHcHjTwJN4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:58:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:58:51 +0000
Date: Wed, 25 Feb 2026 08:58:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Liangxing Wang <wangliangxing@hygon.cn>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 2/2] app: extend NUMA nodes limit
Message-ID: <aZ65xb371YCWGFmK@bricha3-mobl1.ger.corp.intel.com>
References: <20260225080532.727512-1-wangliangxing@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225080532.727512-1-wangliangxing@hygon.cn>
X-ClientProxiedBy: DU2PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:10:234::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: ef42b1fb-21e2-4122-27c6-08de744c1863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: B2+Flowe9pVAbEItiGm7x1zfw8VqhuhDXtc7z76xvS0THVeKzz3L7ykfh+NvZYSjMzvX88GmgN4Esvlk0ba+CjdhKrnitGwHQ1FaeRJBNe0TXfH94C42Qnqy3ukjVmaZRtXQw5lSrgTswqHESrAjFCZifbig48rNz6BDG2jWPUwOMYiMyatxYq0ikjhXwTPPfFAwk1ycHioxSahOxPFLj6jB7WzuGt6T9Q/hUmMsxOROTLIafSm8voY6xKmz7Q6R+zcWEwyPPedSV2UqGQ3oAG/a9QSlt1lbBE6I3G6bOzhHS2R8a5mnfHigTZorsvy209iLSQwkZMRyInsrpmsKsgGEa5WREjY80jM6FXc5Of8wR4SRvnKow/wl+SA8g/XJ76rzOS+qEDEsllrFXHJoFR5ZJfBwzBeEYKElYDinl0AmxwpVQBySk4yZ6Sep7bvfAwaddeTCvfwgfo2EHZI4hI5eINm0DdV5wYgkaH1KZBkSLQRa+zmMi/ceLlDwC0ot4PE+BalKRPcjcHo8hJxc5pWRHIsFzL/hUg4hqVGwJrWP3sI2Egr+abmfK3tZh5/kqWqZxfTgwxslRd+iodqD1tJvbsQb5C4JHBanAKjx/iwYM8og4SqYTpeTY3lgYkdis5biUeoSGxhuh5LXjCcBQKraNwh4hPapjHDupJXTHkB830zPUC0cP17ASlnd+03ogmOTZFrG0tQstWO5n1BxfGoXGJ9vpdEF7YgVgnzsjCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pdR8L7G7sfHMFiNigpuICQ+yT3nbBxiGQHWXaWfX1rN62HWIMK8tyujai5rZ?=
 =?us-ascii?Q?as0+ctxZ1M/ZTKjN0wuvJgmoh+l/nctH7PrOGWAu/m0RkBpsWg6CSgRRHqH2?=
 =?us-ascii?Q?YplLjk3VEsmzCD2H6lUy4kS4C3KyOC277TxN9Rw/DKefuPKOqnc3V4TZ9w9h?=
 =?us-ascii?Q?ixRsltiaB3fRmHtKIgumiSMPDjyAYP/StEO4hUkDDiNw4K0jgHoYJnhhmuTX?=
 =?us-ascii?Q?rvqajCfHgvu/vcPeby+NKxd3ak9AVHvc3Iuxy5SLhV81iOoTJPQr6tzEpv4G?=
 =?us-ascii?Q?fleu7A8AQIeBCmo+hpHzCcUTT+4NaKIRPBZwcWvGk5rzwqQE8GYas608G8tE?=
 =?us-ascii?Q?UVTuzhHKe3XeBcMuL9k3EXmR2GMyAbdGHfE7lsvH5jGxfyuvQRB8moidmMmt?=
 =?us-ascii?Q?OguZU/Ghc9Vu3Sw/vYV3wtp9mDFZx13BeHWf9fQZmbD7UEq0q7sgbrHexiJe?=
 =?us-ascii?Q?H5dUxYQbc5pdPBP9qT9KHYwEJiGjtfycbjIT/ApdWfAefr7Hf0AsBW240ICM?=
 =?us-ascii?Q?QW+TOixouq74o6pzg2tOlWxvorVD2TV9wUPlHO3vurrRTRBakp3xty0HHSeT?=
 =?us-ascii?Q?W10rjzfZwceWN4cyJ+USQkKa2JRmpOFugvCWPj9RYEV8Ty4VxL1bmx2X+MaS?=
 =?us-ascii?Q?ZY0dYwsk7Sh/tFPz70hva4pUH6XGZsonGDPms/5JPSRTBiH6qtpj9jwLg2zv?=
 =?us-ascii?Q?JekXf9TNiqFeCecVu7O39yVkv7wegt1eQObBQ0QqMPlSoP/R/V/mD6W5PxPP?=
 =?us-ascii?Q?O675GUAIBTqHdV1diI2YsMjQSc2G08XiSoc9UAhY66cZjqrbKzetA3UUiG0q?=
 =?us-ascii?Q?WFIfSbAKcAUh61Vce9Q0rYcCvGeq6uQeylftqaXT7hnvo/c/C55Vq+VBOSMG?=
 =?us-ascii?Q?BaBTVHcTTK0DwgydDuCpxQkjQg8wRpzZYuK1i8+Wxgpkdl6x2Bk/ZA9lckQu?=
 =?us-ascii?Q?P1achuv9Wdkpz0/H9NqiKlvtR+sfVEk7XBP6eHk0iNBJbXS4LDl9bGevBmgj?=
 =?us-ascii?Q?5o2QRFSCEZuxQPx3wLGXbsK2BfdeypBOocuy+ntG97XdaqAGFGSYm+UttLB0?=
 =?us-ascii?Q?kPNdOHMYnTDEjY8ulxgYSsSdweRqIQiZEO2L/Q25Ute6vxVSY/dxRy1nFqil?=
 =?us-ascii?Q?kdgV57hxVWinrFmrWrBRvpk6ymi5V912SnpW9lQUeMo3AgiwfrM8kDML26F3?=
 =?us-ascii?Q?RUSUhTtc8kNBL2q1+IEdNKg3LVS7KsakpFE9cJKxyE0BNFrOJru2aF6POcPd?=
 =?us-ascii?Q?KiImevStw8ikma1CPiZGt2gWuiWGWcGFa0/+GcqwTQupTVJ+KfCimlVvxt/F?=
 =?us-ascii?Q?kWxLJKGoPPIrS/UIIMeS68n2OvGBNN+x3B5ja+CM4QMSFl5Fl63Gk3RIUB7s?=
 =?us-ascii?Q?eGwe5ddv3pKKrqOJG3DQuPFjQ+yetfcMF99VohE4nHbHKZ/9fLoBhV3inZMz?=
 =?us-ascii?Q?vh+z8IvXB/Qo7kxGhNNurPeJG9nKMWi2uc7tKknJlWJb+fSZF0nTqPyjc1yZ?=
 =?us-ascii?Q?uV/MjR0gFEEeuMpQAHO/gYH21NSY/UyGuzqaz0ZKfoeFr+T/urwxVevXBFzi?=
 =?us-ascii?Q?HFU5MmDxJF1NNUn0B62FBPCrIqZQaarFZAP1c8hZC2il9x/OWmTBFH/BfcuY?=
 =?us-ascii?Q?fVuS6c+cVdHRQjNasgajOFZo6Vu+KNPrM+B1zIBTKGRf0ACXQLbkvOyWR2qI?=
 =?us-ascii?Q?pjTvuNZx5Wypxhx+Aq4ah+SYDi0Hl7fILSEc6UvVAiPkjIHld5RF22j4/tx0?=
 =?us-ascii?Q?zBTS6AJTK9+paWAmQDZ0A8yYNhwhx0k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef42b1fb-21e2-4122-27c6-08de744c1863
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:58:50.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtdl4lPj+qZKOOk8HIK7HPVbdFhHG8HS58+FUSxJISev7t6x8D2Qsnx1LzKdWs8GgW4qb+DOLVmBo6HW7PLVDpIZGIt8mybYMxh+EHWJO2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
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

On Wed, Feb 25, 2026 at 08:05:31AM +0000, Liangxing Wang wrote:
> Use RTE_MAX_NUMA_NODES instead of hardcoded 2 to extend NUMA nodes
> limit for pmd_perf_autotest.
> 
> Remove unused NB_SOCKETS macro for graph app.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
> ---
>  app/graph/ethdev_rx_priv.h | 1 -
>  app/test/test_pmd_perf.c   | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


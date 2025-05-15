Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC5C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 14:24:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1B0040E3E;
	Thu, 15 May 2025 16:24:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3E153402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 16:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747319079; x=1778855079;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GGabSH7ikC+Gku+Q6EHOSF7yy2+cfgx+N2id+obgTCk=;
 b=LSeEmKxTWPZFcfumITxUCQbFCkUb+edTOICp/4SGat2BteQjWa6FUJcl
 r7PPEeQLYPqsAN1etwHa2uDOQApavRgPADVBE5kV2RPPupwMz1lFPvoc/
 MAhnwo4y8mOrxfqQQm5xkPDoiirTV4ZHmC4e0rsHZgMc6M1TKKR6MsBxN
 yfw0fIhR6wVThX1Q1uivzvpiFOkOZEOxdOJIzJMfnjdWWrAtUTekLMnbA
 QcFNXowP/Ivp9/9yuDNGg/+xDu5kxjVbhLEJ2MC4ynla7KyA8PDRJGwPR
 Pzb3//KP2ObVHvWReahYfAzVLYNip9lDesqQ79PGT8jFdn0009N0PjLY4 g==;
X-CSE-ConnectionGUID: o1OCKUyIS5WX8cXIF+PMxg==
X-CSE-MsgGUID: gAlim/t7QLG6rAp1pzIsuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59892921"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="59892921"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 07:24:38 -0700
X-CSE-ConnectionGUID: JKoakD2vSLuCDxy989bR9A==
X-CSE-MsgGUID: 1cHkpNkmS/OoXQh092qABw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138434251"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 07:24:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 07:24:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 07:24:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 07:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPOZ0vBGDyhmBl2lt1tU7PyH1TJRyDrMheFK0MohDndoXRFmCp84OBbGtC2Fn191UDMkniOa4NMXgTEsmVpH1gLH4x2+zCO/1m8Wq4bZt8Dxnbe+Y2OU4cnrig1rmTtSzAAAfYJh9SxQIv8sbNvKQ4FNEuPvr9mCq8/1mQQMax0GwZZRa/JpTrCvGhi0xvKvg76GvaI7qq47mgLsJod8XYzmsz4b+O3SyX1l0PT3MmrrS8NhvDOXf1dqAifJoZjFAOcKoUr0A7OE8f+Lsr/aDQOLu0snh9ks7DnVBsBzGF+qa+vnNRRFFFghliF9eM2HjyzoH7pweHG66j/7c8660g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhyxRj48vq3vaDQ2S2GUcPFoz97zm7s3wcZ0aGfXZhY=;
 b=v6Zsmd+5eZVauSnSCcYa5G3V1pMUiSN0Yu4xngScIGM/t0znq5QjDMg/ih5vM6I9LOv2pN0/El0RJVvX9OmXpHt8i+nlxxLrKF/K/Sg3si9xAE3D0AQHW30G4hVtPcQ73mXnqhOnNK9GYr0Ub9KV80Awogjq/qO6NuJ8YifP+J5hYt9b5sNgXcc2O3vky2A4ygo+9sOIqtRI9FXUsA/sH4jqkwRSuOx5ami6cPGYv95e0zGqAMN0W6hTp0grtCQpcrKz4GZ4tdwQ3rS2+z1eLhN4AtzORx4iXJwdLeabMmQQcAByeU8R4YqYS9RlU8KletxPXMe9tYjn3QWgvAbFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 14:24:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:24:34 +0000
Date: Thu, 15 May 2025 15:24:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2] net/intel: reduce size of common Tx queue struct
Message-ID: <aCX5HAL9CpIa9SsO@bricha3-mobl1.ger.corp.intel.com>
References: <20250514125733.1364644-1-shaiq.wani@intel.com>
 <20250515062130.1396060-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515062130.1396060-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: e09e34eb-f96b-4583-5c01-08dd93bc36e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n7aYOVoYHcIGxFA8h+gs7LoXR1QWbI8KkDkfqmxkBAa5M1wlCinWz1YC3k6K?=
 =?us-ascii?Q?tVGRjrB5R8RDpNWkjT0A5vWgeef0xe+2ALrbMGZZWRvgkTju5grXKH2lUOCG?=
 =?us-ascii?Q?fUhTmmE/FEcPUwFdZK4ivSRdCLlULopBI37fTF3RJh6uLimwXHssRHngQOKH?=
 =?us-ascii?Q?epzzHp9NtbFZqwzgrISfOrSdSCy/lWh0H2jBxOE29UM/bQ7NsQLvcA7BkZzx?=
 =?us-ascii?Q?+v0ELPmQg3h5DhvKeHYFT7QNYYnkU3xyMvoF4YHyD/tZ+De5K3tfRgmIpVn5?=
 =?us-ascii?Q?zbHAUJ4YW6qb0j8jyu0iyPtCnJk3HOPQx5cgOPQR8XaJhrQnUm6545n9s4K6?=
 =?us-ascii?Q?iJIj39X/YnGxvH5JPlrgXYV418q7PGh9KdzdgAgT3SoNfZWbsdWq9eAi5mWr?=
 =?us-ascii?Q?wF4TcjEE9CYVasoJeqIe1wgVbu1M/TWDDjrfQidR5VkGFRz4L/mZagxW/ZWp?=
 =?us-ascii?Q?mUpJj6LpbiNGkTAM+1iPZwEaEC78S9qJCaju9ydBggZDBTPjkOLHi8UB16zD?=
 =?us-ascii?Q?U0EVRIl36zL2WHr64wkiEGwxUyhPYB5G19BtPGJ/ybOZ3cUv6ofZUzQUUWMo?=
 =?us-ascii?Q?dv+Q4B6UzXGeg6mHQ7G5LEZH/pyh3+Bcs0E99ZhiA1ZHMLWi7jhpzXrhcHH3?=
 =?us-ascii?Q?d9ejsMP95Z0u6vh4pxSjN8p48uGIv6SgsHM+VH5LLOCAwBE3E+LpAFTtiZaA?=
 =?us-ascii?Q?Yc45umu0sjKpqF4kcN0xY3vQv/gr//b2E4EUX/13j3icqOndadX0OT8vpsFQ?=
 =?us-ascii?Q?MH/A279eGiX99drlcoc8Iusx5vpKlR2AjdxtoRlym+tAOVnSKzRE/X+HGr/h?=
 =?us-ascii?Q?YWW3oqVdl5P/a56BKA9r+HtXPkkwL9Wy2rrdIrGJ5fcXSSIvRrKt8OstPIGV?=
 =?us-ascii?Q?d+mU7XcdjA2F/71tHe/QmmIEuMusdIqh6Vg5R4cD/lZIhPd4E6lMRRABmMbf?=
 =?us-ascii?Q?satlkpEzeGDDDrWbm9Mq58Q4AVRh5ZjEEMy4ou0cXDMfxtFqz7vYFFMM75mg?=
 =?us-ascii?Q?u1OPIz0xcE/cfWb1g/1nRP69eCk3JINP9l9PLHeGiEGa0udJTAiO/es698My?=
 =?us-ascii?Q?vcQRoLguDD9FPHjUSuxm/XfxbmruWH0eFTBMU2+TjyaCSRBLTWNXsOhZjIZR?=
 =?us-ascii?Q?kkihQuNiMZfV0qM3gwaFw0VIBagd6bNYmNOLZJNRR1Kse6GlW5rCEJdH5MaS?=
 =?us-ascii?Q?Yvs4SE8lCHAXhNykhTmcSw15OSndd+hJ2P0YTXmBkYLQ/KwiIb9aX9mVUbXT?=
 =?us-ascii?Q?euyxxSJBGlmEgrT0YUxtafzUAraChBcK1adFM5f6Rlk5WnR+SVl8zbW7rmf6?=
 =?us-ascii?Q?72PbUzWF7Bx4GaMT10g463aca7KHL4HT66MC3U67HfOXV4tULcV+calxFRaS?=
 =?us-ascii?Q?JvJgwsUM2MJlNA6MCvpsvyLboHcnMI+sju3ccWKrI8dbib+lffnJdMPVOkxm?=
 =?us-ascii?Q?vZNNAMNFUOk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7fxdodkIP3RSLzuBlwjXN3W64/Oux1iZ4bxGYUkbN758ifhXG3+uZSeaPdy?=
 =?us-ascii?Q?o60DuEVq/QCjAs/r175Ont1JGjAyMmjW3RQuIEGBG55+lyCM2ydA29z3zIz7?=
 =?us-ascii?Q?ox8wkHpyfyNHrK3YXNp+40RsxdO56Isahc7ilN3W6ectsbv8iQT2zSxAnxsx?=
 =?us-ascii?Q?EuFOmnMm5nNdmpmg/blaOTtv2llzgN2mFb+8WgHwHyw/FnCodyNWomEhhGbx?=
 =?us-ascii?Q?xEpSz3OAIUbxRRs/pz31bV/O79CozC1MBXrEwnmuSD4ddrju7nlNiDyFNoNH?=
 =?us-ascii?Q?1C/ink1k/GaVINUe59q7D2nDsEVdc50xTzmUg7jpwqvWbPpND2SRqDxtkCw2?=
 =?us-ascii?Q?e+OdoK8T5ux0fbjWQU1nqKu71PChdsnYb5pYgVy+F+grHrLzv0oi/bIVj0BD?=
 =?us-ascii?Q?QXpxu3L1XZZ94XVMT1UX/Ui80uSCitfzcmrAH1D2HTny8M4kIhWKl5k0EJan?=
 =?us-ascii?Q?4r1l9zKYxuGEPaVfr8uOAheJuPVM8MrQELbLPINq526V15E9L5mIQRtRxZ3E?=
 =?us-ascii?Q?b2GJaKxHaMxnLci89VCTW1FRi1VDJFQMtkwBtTLvrfU74H1q3pHlXjLbPQIb?=
 =?us-ascii?Q?qtj3gpTro50EOaw97uA9lgli2JwtCOfD9uK09pKasnzVoo5ggNtVQdHWDVXK?=
 =?us-ascii?Q?CkxZzBsKhcgd49CRTOrruNVj/yiULD6d6aH8/+ff+b9yRnRtodh3QL8nmtZa?=
 =?us-ascii?Q?zBhB8FWsLZoT74NVAb4fOMMQaeltQcr3FR+SG1Gk8tm6wCAY9uQd+lwWYMNG?=
 =?us-ascii?Q?vQTPuUjuJ8Xq45cRVEDvl2Pmjczj3EottfIQX8sZtFFnjBscgTLgZl0ytzaS?=
 =?us-ascii?Q?W8D67l+GnOXSxgmaEUZpXZ0r1juIIsiDW587P5NJAijKVdP8nkw3anp8pwB2?=
 =?us-ascii?Q?J0LXSZaGagJrlYAHFqXnFFv6ifJgC0/gWcMgpKAgN1Lcv3PCLNdiVYwmZpbw?=
 =?us-ascii?Q?Jlx4xSqZtVwpUEImxgvhpuYTcp1PCNohc1VqiujnGrHv697lhmLzAb9ULNtk?=
 =?us-ascii?Q?IGYac2D6knv0QJDveQCSGH1VsYYopFoeUTvn2XjG598fIR9zvI8QqQI3fR7X?=
 =?us-ascii?Q?kdsok+AnC7Jv2MDUUX731eds8fshjwRI65RGppsen0dzjHJ6YwlypYYtv2cM?=
 =?us-ascii?Q?gLq6wzktZrA8qMUlUXmB2Mhwx9HuPHDdKKxq1FY5CsSw4AztlzVgphMSzEYo?=
 =?us-ascii?Q?/kcSDtY7BFYtEi2ZRkL8cjmvF3+NNi+z0Kp6/X7baAdLp/scq0u5HSxfH5FW?=
 =?us-ascii?Q?fDvSRMa411rbYyTrK43SxkjaiSAOFEY1Udig5M0jjLkixzgpIgpMMY67RMtQ?=
 =?us-ascii?Q?vO/k+YxbmrYFlqJbPuaTVOUyLFLd8lCCK3JRZG4v2FZZZp5z4TM1sdjpUyWM?=
 =?us-ascii?Q?W+KfJ1i0e/TILRV7ibttwJfuGUxt4p/KSo5xtgLirgkNgMzYNJjnBRKY5DTL?=
 =?us-ascii?Q?vZ9TsVwUhEdNpnu8KBXBVsV7U9t4G3ndCGnrm7/c84jm/1a/uuB856QKln2Z?=
 =?us-ascii?Q?zYC0Q6LSXEoB6S8g++l6k0ERbPjUjpXClLYhjlTQHZ0Thjz1WJdfeMiYI2L7?=
 =?us-ascii?Q?XK0ueoxyyg/Vd3J1WZvJJpUigOkKr7G1YF5jL8M1ojHyqqEGWLpeOVw9MmFd?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e09e34eb-f96b-4583-5c01-08dd93bc36e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:24:34.3662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwZiaWNOhlhk+EJVTr2D8eZqGf2d/OFEHEofruSbfwcODP2jMeJPLo7XLIi8xwOoTDET7SnvT+ICi+SzdBInZMhRkKy7HjIKjGuRNuQFBT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
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

On Thu, May 15, 2025 at 11:51:30AM +0530, Shaiq Wani wrote:
> Removed redundant and unused fields from the idpf pmd specific field
> in common Tx queue structure to reduce its memory footprint.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h                 |  6 +--
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |  6 ---
>  drivers/net/intel/cpfl/cpfl_rxtx.c            | 13 +------
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 34 ++---------------
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |  7 ----
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 37 +++----------------
>  drivers/net/intel/idpf/idpf_rxtx.c            |  9 +----
>  7 files changed, 13 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index c99bd5420f..b0a68bae44 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -106,16 +106,12 @@ struct ci_tx_queue {
>  						struct idpf_flex_tx_sched_desc *desc_ring;
>  						struct idpf_splitq_tx_compl_desc *compl_ring;
>  				};
> -				const struct idpf_txq_ops *idpf_ops;
>  				struct ci_tx_queue *complq;
>  				void **txqs;   /*only valid for split queue mode*/
> -				bool q_started;   /* if tx queue has been started */
> -				/* only valid for split queue mode */
>  				uint32_t tx_start_qid;
>  				uint16_t sw_nb_desc;
>  				uint16_t sw_tail;
> -#define IDPF_TX_CTYPE_NUM	8
> -				uint16_t ctype[IDPF_TX_CTYPE_NUM];
> +				uint16_t rs_compl_count;
>  				uint8_t expected_gen_id;
>  		};
>  	};

Before:
	(gdb) print /d sizeof(struct ci_tx_queue)
	$1 = 160

After:
	(gdb) print /d sizeof(struct ci_tx_queue)
	$1 = 136

So a 15% saving, with a code size reduction of 86 lines too. Seems all good
to me!

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Pushed to dpdk-next-net-intel.
Thanks,

/Bruce

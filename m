Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B27C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 10:06:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 968A140E1B;
	Tue, 17 Jun 2025 12:06:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3F28B40E03
 for <dev@dpdk.org>; Tue, 17 Jun 2025 12:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750154765; x=1781690765;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/AzRZ4UB9UURNA9PRswG4VGY6PwHeZdA0156VoF+no4=;
 b=KLldAL3U+UEljOGNmNjXz+rxXwk7LNN9qO57yyCTwplI7fN9+dGdFlO3
 v42EBAuLhLbI6e6ViWjbJczPY2jU4X5D1eguX0VeoJqnwknrmGKy+2g3h
 WIPXIjtKFTiW02R6XWWFSqyKeN7YMiSf1a86QcU3onuu3fHLWkEYZB3Yh
 LGhnmLz9cMQrQV6nTZxs2GHQRpO4P0/VBPG63SgTbWXJVF2Gmau3beqSr
 Q2Myy/GonIu7S3yhEOftvp06dazvqkXA+Gs/0OGn5NunxtL/o/nlWoXcj
 HvdkPbRzGfyqLFAiRCVtDLlnZ2aUXkOLc8nx9kmoUX2ZCb7IR2G1JXZ8G w==;
X-CSE-ConnectionGUID: T9BaVdLpRXOj039utHNeQg==
X-CSE-MsgGUID: QiycP0E4TaeJ6gBuvDZpRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52305056"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52305056"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:06:04 -0700
X-CSE-ConnectionGUID: Ph1ETH69QImy4Z7lsQXh8w==
X-CSE-MsgGUID: JTYsUMLDQ8Gv/p92fdGSNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149099770"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:06:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:06:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 03:06:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlbAwL9VrJHvHUM5JDD8JzSvr1mA9a7m2PReF89MB4spx489yvuvUVfdtKzOin1ZQcuedIi2Rj7k2IyOY5M5A4NcEaFd6OkbYoK6wBQlsjkPEuFhfw/8xAVWbLIM0yreHfEl5WePGyk2oXP8mTzG7IWO7l24zaRb64sr6KZ9zEFR0k1Ohl6C9fWL9RV7wrHtLEmxcsUJxQC/Wvwu6KX70XWGZfdtqVStpjCgnOeQ4i0aPuEyN7KeXwQqu1r9xRzCl9wWxRqUxNkARhMFl6Z94Hn3mv9+rWyGeOrsFGovfqWJD3WkFHQlU6kc4O7sG+/RJcRryPbjzfR/izvioLPWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uglBICZjnUTm1HfPUWOVthBCHyjPuOBg0mhIqif1OQ=;
 b=AN8OyfgJCKfIFPNVKlCV5VJQW4mz37lZL1oSJDidcb6uNPKJzi2W30KuDKWDbRvOqmQrHr13SASk+tayCZme8Z+Vc++zOyYlG8VSz94aIEOm3ZEOghMO3zdDThRug9kY+Q1L2LSC19eYfFzd50qFw6JnixjmuwIx44umiwQK0gj7awMgkXjof9ZYaSB1uYiCs5wXP/RN2HqAv3jpSrVmtAmck2x6JHnN1D6EXZCE+Uj66tpAN6c5VT9S230NReG7R9SiBFVFvgyEoMVXY2ntgd5nRQa+FdSJZjj7mJmfKHGCcNnvNSxytNWiDY3744j5vz7tsHoGIEAeCbJ0C6uDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB8190.namprd11.prod.outlook.com (2603:10b6:610:188::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 10:06:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 10:06:00 +0000
Date: Tue, 17 Jun 2025 11:05:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v5 3/4] net/intel: add TxPP Support for E830
Message-ID: <aFE-Amrhnt8_RTZ0@bricha3-mobl1.ger.corp.intel.com>
References: <20250610131159.495566-2-soumyadeep.hore@intel.com>
 <20250617001429.551262-1-soumyadeep.hore@intel.com>
 <20250617001429.551262-4-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617001429.551262-4-soumyadeep.hore@intel.com>
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 93df7460-b71e-4215-6629-08ddad868fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OaIWUoLG7XXucRmuyGVasZc/o0MMOw3UW4yKLldqhOloUV8f7rffYuFvilH9?=
 =?us-ascii?Q?gKfUD2voCNjG6DL8FTofDR3OV5X3OBqAOUGTM2CtHP4s2lPrSldqn3BzeYNA?=
 =?us-ascii?Q?IzNIRYi23Vx3vPtg/TO/HC113g3GxC3xlq9INhSAc73ZDLtA1vGPbY+ylr1a?=
 =?us-ascii?Q?NjhkQ2vuouQ4JohCxVRPwumxaieZdHMtx3fkZOdZhAxWMNtFzzrgdkiDoxQA?=
 =?us-ascii?Q?Fx7Y9vt6t2kt92ZETYNlfTeAUjcYbQ5bYuIV82O1QP3nxPBvzivzGJ9FFD7v?=
 =?us-ascii?Q?u1lx3Ks28Oo6/VryXUyhn5bb2QppiN4Mus/X1IK7IzUmAjiiW81WB0uOBXKA?=
 =?us-ascii?Q?AeRwVWBsGT9dWo8oNLR1N4C77FS7Ewuvu6SnflRBAT2pn2RLBN5s7UFxBdrK?=
 =?us-ascii?Q?YQZ26SwGhiLMHx9XS486M8IikyzPk8aqW82MaeWu6oTB184HYD23Q6K9+I4Z?=
 =?us-ascii?Q?cHgzNiBDjrL1SDw1US0Tu6PtiEjkHgWlZ/+TjC/4KSv7p8RQgrQqPUxbhvlT?=
 =?us-ascii?Q?3ygyqDF3wQoEM47Tf4eJ7QXuHUliBlWT/4TdMLyclrNDF5byxSADxQ+3pzpN?=
 =?us-ascii?Q?+8B9AwoekAJpuRLhaonLV4S4b7tqo7W0YyZ5fbGo1QU0qhCiK1DNJY4rLln4?=
 =?us-ascii?Q?xP+giMMQKkIWCfPFR8hf4Cs0/kAPd2+qrO1g5pXFY7kcV7AgYJ98c4EJ4oXA?=
 =?us-ascii?Q?jhw/KzZmm3y5xZPQpFnKc5467LMLHBEg0xrpxo7In7bP14gxakdzlG5ebviq?=
 =?us-ascii?Q?QR9A7p2jmj+77KwR6BZq0ePDA8eucSllrw7DGF/lS1rU6T1OkGBMYYcurp3S?=
 =?us-ascii?Q?opH2/wsG3lkuDpnMWlhzCOF9/qcaVEG0c09fLKGLu+iMH76kCdmVBy69xYHu?=
 =?us-ascii?Q?QJQWHYqTtuWnPzBPWt54oQgpgNOCCem3U5bncPdiG2BPIpWPKOZwN67p3Qm5?=
 =?us-ascii?Q?rVNu16FPGW6FPTQaXt93uo3imxxUc9lHN6zmxgu+dRj2w3TlyESIZxH69hYC?=
 =?us-ascii?Q?NR4ju9eMV/wsWtQJXIuj2EqreJdiFkyOD8GQtcvJAB7LSHwp+fkGuA1rYhkn?=
 =?us-ascii?Q?6HHjpcTB2JeJIbbJYHpxR1AvckpiFx67Myg77r35k6TsE1XyiTRZCzs4mYiw?=
 =?us-ascii?Q?Ads6C/VCogQjoui67l8N5QoBi7mxZApyCMgAXeVI5ki7YsOnEyjwT0P5Wjc5?=
 =?us-ascii?Q?Uzx1bk58WqJge0XMfSGZjybzfGiIER0W0QQ7znzN3bmKChpStDxezdA6KB5t?=
 =?us-ascii?Q?kDJYjU45aAgz1zGsKFlLll5RlJFOQe7DejuB3iYpjFTLTewCtYc/R+Nsds8g?=
 =?us-ascii?Q?8SBv4aPFlisosfY7rRsBhEcBxrPFgHRpXSLBbFlpVlktSezsCRvo7HSPrKc+?=
 =?us-ascii?Q?0xLFyOVgEFSDbZIpEJLCxJszOx4qnzHx67cGCWx7Dj0NB/KYWZKwMcfNUZK3?=
 =?us-ascii?Q?keE8yn0AlEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqR+lcZbn+H7SXb3hkw7QTFuJv8vqvXClcByv50Sf2ozpmZABehOsMCQv4S8?=
 =?us-ascii?Q?ltJ6pepmw0vCjByLe8JzeK0DrBgcVrn9k5KwE/q2dO2od8olg++YI0DuHO8P?=
 =?us-ascii?Q?SbbBFR1RXc2gsNq1QbAvma1w7mdD+xN6jyacIfDmiNm7OcjFzJqeDxJ70/iS?=
 =?us-ascii?Q?AUG7fBuFxXr2buI1hz9/KyriZeABCdWJnf4DJpA283TMyqa2aSGSt6HicrQ7?=
 =?us-ascii?Q?t8AHUYrWH9A37lIQFxbalGOzizWfdnKuqIZXCSx0I8KCFTd2zMmaqPSg0kDM?=
 =?us-ascii?Q?BfZTerHHLG6s8+/x7XhiDgN2NNonlBY9IwtzKfEI/n8q3JmFipowpt4EsOMg?=
 =?us-ascii?Q?YLg4r77xySal6m8kzjU8Ava0mCJ8z8giCXIxqLSxn+1odF2r08Q71QSp5IUt?=
 =?us-ascii?Q?TA75lLGnegsYdhbvoch6Um+vzaXNlbwCToiHVCjmgqZOuZ+e7hgrT4Jex7YQ?=
 =?us-ascii?Q?n6MPxkS6v72wArFLy2UdjrfqgIC9G2OcYKO33LEg/buvRPSgbtJqG9jClKam?=
 =?us-ascii?Q?Ckqn/TRkhTF7MOAWTiBCS+Ynb4KAYhW5OzR2RoSSWGn8GJvJ/jh9PY5B+OWP?=
 =?us-ascii?Q?i/NwJMoilCLRTY9KzOPLeZdF0/XtL5ryvuL4Y9yXP7aMudyEp5PgrvLHLSG/?=
 =?us-ascii?Q?cvSM+vIMjsSttCcnpIF9MG00gl3ALXgo/WTP4IOY5kaITvSAW8waQlCUH2v2?=
 =?us-ascii?Q?dM17/ht4cTtneye5yLFKEiFGSnvHeNyWlj3Zv8CuAC0HyrUQoqifDpQ+9TH6?=
 =?us-ascii?Q?/DfMEltMUKG83E9xwH2xQqYJm0dnLqPz4ldU1wuVfX6umJLIRgJrlSYEY+i2?=
 =?us-ascii?Q?ye18UVou8IAT3+MyjCEqGPGi4HP8qccSi9wRaf8XaRivrLKteU7czjYAOcEC?=
 =?us-ascii?Q?O4f0YZdvP980Pj69lBqWgSjn/PfouvUWi2grOqf9D5E5M/hibP3Md0UjeBrn?=
 =?us-ascii?Q?mtLdkCa34lYFRoq1t1pDi+38WMkkH9b+OMxdTiujxahRn/lQD4V0vtT1JGQT?=
 =?us-ascii?Q?IfMo5942lrSrf8R+ArMYPGLci/7pthPfJ2Kz87s01KvJHdNP0JXDI8GvYR1f?=
 =?us-ascii?Q?0IVTyMJxQ7sUaZvVFkLPB5SwpSYP3TL9ZvBb3pSs2FCJtVDn5Pz6v7jeG1tY?=
 =?us-ascii?Q?+7mVXFZQCRacrfaOhrBdhqOjL4fv82ClBR+y4T5BxojEiMfap7OO9GPuEtmx?=
 =?us-ascii?Q?6885BRfNFCbXRpRMKfLQy0q4TG7zfRbf5rBdZyvY0APbaRsvXFOOzcYbXBPH?=
 =?us-ascii?Q?t6+bwZn4cDQHC6JeTFODhXZrYgYlqSUggbktLU/LX51Nw9HwxY20ucYQlP94?=
 =?us-ascii?Q?+ObhggCatSMpCr2lNY0ipsP5MDLRkLoal0HJFL+sQzxVpz3nXfozYI7/Skjr?=
 =?us-ascii?Q?3jn9Y9xmyPiaqs1VSJse79j/orW40RSBC08o4osNdUUsUjaCSLdB7ERhaO1T?=
 =?us-ascii?Q?CjkQ0+eHb+8aM+GiOgf/qEF+sAQANmR4LKZXRecYNS3KxQ7bunBuohL74HNE?=
 =?us-ascii?Q?su7UAESJ/ArxKfxxEtaGXiT5ZSv64rAZRBqcfmzkyPPGkGlM7/CFKLg1WwjV?=
 =?us-ascii?Q?UQmMoVeKVCyhBJxHDu4K4As/A3xIrv/vtzWfl7JbXTnwI0CTgOiZtbbFX5Q3?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93df7460-b71e-4215-6629-08ddad868fbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 10:06:00.8406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7DxEYNgCFyRPjmLm77S4xljvKilR12MUSoUmSU7l95ltfydC1/siyEtbRR30GO1fnvUaDqbPE46dDBwqbbtHoatvasECXlln9U0Ki8BOuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8190
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

On Tue, Jun 17, 2025 at 12:14:28AM +0000, Soumyadeep Hore wrote:
> Add support for Tx Time based queues. This is used to schedule
> packets based on Tx timestamp.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---

Hi Soumyadeep,

couple more comments inline below.

/Bruce

>  drivers/net/intel/common/tx.h              |   1 +
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
>  drivers/net/intel/ice/ice_ethdev.c         |   3 +-
>  drivers/net/intel/ice/ice_rxtx.c           | 250 ++++++++++++++++++++-
>  drivers/net/intel/ice/ice_rxtx.h           |  32 +++
>  5 files changed, 281 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index b0a68bae44..492cdb2f88 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -77,6 +77,7 @@ struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			struct ice_txtime *tsq; /* Tx Time based queue */
>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index f92382346f..cd02d2b4eb 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1278,6 +1278,8 @@ struct ice_ts_desc {
>  #define ICE_TXTIME_MAX_QUEUE		2047
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
> +#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
>  /* Tx Time queue context data
>   *
>   * The sizes of the variables may be larger than needed due to crossing byte
> @@ -1303,10 +1305,12 @@ struct ice_txtime_ctx {
>  	u8 drbell_mode_32;
>  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
>  	u8 ts_res;
> +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
>  	u8 ts_round_type;
>  	u8 ts_pacing_slot;
>  	u8 merging_ena;
>  	u8 ts_fetch_prof_id;
> +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
>  	u8 ts_fetch_cache_line_aln_thld;
>  	u8 tx_pipe_delay_mode;
>  	u8 int_q_state; /* width not needed - internal - DO NOT WRITE!!! */
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 588edbca2d..09e5052173 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> +			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
>  		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
>  	}
>  
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index ba1435b9de..38038c43d7 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -740,6 +740,50 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
>  	return 0;
>  }
>  
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @txq: The queue on which tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be enabled
> + */
> +static int
> +ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
> +{
> +	struct ice_vsi *vsi = txq->ice_vsi;
> +	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
> +
> +	txtime_ctx->base = txq->tsq->ts_mz->iova >> ICE_TX_CMPLTNQ_CTX_BASE_S;
> +
> +	/* Tx time Queue Length */
> +	txtime_ctx->qlen = txq->tsq->nb_ts_desc;
> +
> +	if (txtime_ena)
> +		txtime_ctx->txtime_ena_q = 1;
> +
> +	/* PF number */
> +	txtime_ctx->pf_num = hw->pf_id;
> +
> +	switch (vsi->type) {
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;
> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
> +				vsi->type);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure the context is associated with the right VSI */
> +	txtime_ctx->src_vsi = vsi->vsi_id;
> +
> +	txtime_ctx->ts_res = ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	txtime_ctx->drbell_mode_32 = ICE_TXTIME_CTX_DRBELL_MODE_32;
> +	txtime_ctx->ts_fetch_prof_id = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +
> +	return 0;
> +}
> +
>  int
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  {
> @@ -799,11 +843,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
>  		    ice_tlan_ctx_info);
>  
> -	txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> -
> -	/* Init the Tx tail register*/
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> -
>  	/* Fix me, we assume TC always 0 here */
>  	err = ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
>  			txq_elem, buf_len, NULL);
> @@ -826,6 +865,38 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	/* record what kind of descriptor cleanup we need on teardown */
>  	txq->vector_tx = ad->tx_vec_allowed;
>  
> +	if (txq->tsq->ts_flag > 0) {
> +		struct ice_aqc_set_txtime_qgrp *ts_elem;
> +		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx = { 0 };
> +
> +		ts_elem = ice_malloc(hw, ts_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx, true);
> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +				ts_elem->txtimeqs[0].txtime_ctx,
> +				ice_txtime_ctx_info);
> +
> +		txq->qtx_tail = hw->hw_addr +
> +				E830_GLQTX_TXTIME_DBELL_LSB(txq->reg_idx);
> +
> +		/* Init the Tx time tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +
> +		err = ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
> +				ts_buf_len, NULL);
> +		rte_free(ts_elem);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
> +			rte_free(txq_elem);
> +			return err;
> +		}
> +	} else {
> +		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> +
> +		/* Init the Tx tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +	}
> +
>  	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
>  
>  	rte_free(txq_elem);
> @@ -1046,6 +1117,20 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>  
>  	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
>  	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
> +
> +	if (txq->tsq->ts_flag > 0) {
> +		size = sizeof(struct ice_ts_desc) * txq->tsq->nb_ts_desc;
> +		for (i = 0; i < size; i++)
> +			((volatile char *)txq->tsq->ice_ts_ring)[i] = 0;
> +
> +		for (i = 0; i < txq->tsq->nb_ts_desc; i++) {
> +			volatile struct ice_ts_desc *tsd =
> +							&txq->tsq->ice_ts_ring[i];
> +			tsd->tx_desc_idx_tstamp = 0;
> +		}

Still doubly-initializing the ice_ts_ring here. As pointed out in previous
review, we need just one loop or the other, not both!

> +
> +		txq->tsq->ts_tail = 0;
> +	}
>  }
>  
>  int
> @@ -1080,6 +1165,17 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	q_ids[0] = txq->reg_idx;
>  	q_teids[0] = txq->q_teid;
>  
> +	if (txq->tsq->ts_flag > 0) {
> +		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
> +		dev->dev_ops->timesync_disable(dev);
> +		status = ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
> +					     &txtime_pg, NULL);
> +		if (status != ICE_SUCCESS) {
> +			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time queue");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	/* Fix me, we assume TC always 0 here */
>  	status = ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
>  				q_ids, q_teids, ICE_NO_RESET, 0, NULL);
> @@ -1166,6 +1262,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  		   struct rte_mempool *mp)
>  {
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_adapter *ad =
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_vsi *vsi = pf->main_vsi;
> @@ -1249,7 +1346,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  	rxq->xtr_field_offs = ad->devargs.xtr_field_offs;
>  
>  	/* Allocate the maximum number of RX ring hardware descriptor. */
> -	len = ICE_MAX_RING_DESC;
> +	len = ICE_MAX_NUM_DESC_BY_MAC(hw);
>  
>  	/**
>  	 * Allocating a little more memory because vectorized/bulk_alloc Rx
> @@ -1337,6 +1434,37 @@ ice_rx_queue_release(void *rxq)
>  	rte_free(q);
>  }
>  
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp descriptors
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors
> + */
> +static uint16_t
> +ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)
> +{
> +	u16 prof = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	u16 max_fetch_desc = 0;
> +	u16 fetch;
> +	u32 reg;
> +	u16 i;
> +
> +	for (i = 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg = rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch = FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
> +				  reg);
> +		max_fetch_desc = max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc = ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc = RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc;
> +}
> +
>  int
>  ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   uint16_t queue_idx,
> @@ -1345,6 +1473,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   const struct rte_eth_txconf *tx_conf)
>  {
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_vsi *vsi = pf->main_vsi;
>  	struct ci_tx_queue *txq;
>  	const struct rte_memzone *tz;
> @@ -1469,7 +1598,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
>  
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size = sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
> +	ring_size = sizeof(struct ice_tx_desc) *
> +				ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>  	tz = rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN,
> @@ -1507,6 +1637,58 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>  
> +	if (vsi->type == ICE_VSI_PF &&
> +		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)) {
> +		if (hw->phy_model != ICE_PHY_E830) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Tx Time Queue is not supported on "
> +							"this device");
> +			return -EINVAL;
> +		}
> +
> +		txq->tsq = rte_zmalloc_socket(NULL,
> +						sizeof(struct ice_txtime),
> +						RTE_CACHE_LINE_SIZE, socket_id);
> +		if (!txq->tsq) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to allocate memory for "
> +							"tx time queue structure");
> +			return -ENOMEM;
> +		}
> +
> +		int ret =
> +			rte_mbuf_dyn_tx_timestamp_register(&txq->tsq->ts_offset,
> +							 &txq->tsq->ts_flag);
> +		if (ret) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag "
> +							"for timestamp");
> +			return -EINVAL;
> +		}
> +		dev->dev_ops->timesync_enable(dev);
> +
> +		txq->tsq->nb_ts_desc =
> +				ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> +							txq->nb_tx_desc);
> +		ring_size = sizeof(struct ice_ts_desc) *
> +					txq->tsq->nb_ts_desc;
> +		ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> +		const struct rte_memzone *ts_z =
> +					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
> +					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!ts_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory "
> +							"for TX timestamp");
> +			return -ENOMEM;
> +		}
> +		txq->tsq->ts_mz = ts_z;
> +		txq->tsq->ice_ts_ring = ts_z->addr;
> +	} else {
> +		txq->tsq = NULL;
> +	}
> +
>  	ice_reset_tx_queue(txq);
>  	txq->q_set = true;
>  	dev->data->tx_queues[queue_idx] = txq;
> @@ -1539,6 +1721,10 @@ ice_tx_queue_release(void *txq)
>  
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	if (q->tsq) {
> +		rte_memzone_free(q->tsq->ts_mz);
> +		rte_free(q->tsq);
> +	}
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> @@ -2961,6 +3147,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  	struct rte_mbuf *m_seg;
>  	uint32_t cd_tunneling_params;
>  	uint16_t tx_id;
> +	uint16_t ts_id = -1;
>  	uint16_t nb_tx;
>  	uint16_t nb_used;
>  	uint16_t nb_ctx;
> @@ -2979,6 +3166,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  	tx_id = txq->tx_tail;
>  	txe = &sw_ring[tx_id];
>  
> +	if (txq->tsq->ts_flag > 0)
> +		ts_id = txq->tsq->ts_tail;
> +
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
>  		(void)ice_xmit_cleanup(txq);
> @@ -3166,10 +3356,54 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  		txd->cmd_type_offset_bsz |=
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->tsq->ts_flag > 0) {
> +			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
> +					txq->tsq->ts_offset, uint64_t *);
> +			uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >>
> +						ICE_TXTIME_CTX_RESOLUTION_128NS;
> +			if (tx_id == 0)
> +				txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +					rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +						tstamp));
> +			else
> +				txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +					rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));

Lots of duplicate calls to FIELD_PREP here and below. We can shorten all
this, because the descriptors written below are the same as those written
here.

	const uint32_t desc_tx_id = (tx_id == 0) ? txq->nb_tx_desc : tx_id;
	__le32 ts_desc = rte_cpu_to_le_32((FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M, desc_tx_id) |
			FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));

	txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp = ts_desc;

Then in the block loop below, you can similarly just loop through doing:

	if (ts_id == txq->tsq->nb_ts_desc) {
		uint16_t fetch = txq->tsq->nb_ts_desc - txq->nb_tx_desc;
		for (ts_id = 0; ts_id < fetch; ts_id++) 
			txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp = ts_desc;
	}


> +			ts_id++;
> +			/* To prevent an MDD, when wrapping the tstamp
> +			 * ring create additional TS descriptors equal
> +			 * to the number of the fetch TS descriptors
> +			 * value. HW will merge the TS descriptors with
> +			 * the same timestamp value into a single
> +			 * descriptor.
> +			 */
> +			if (ts_id == txq->tsq->nb_ts_desc) {
> +				uint16_t fetch = txq->tsq->nb_ts_desc - txq->nb_tx_desc;
> +				ts_id = 0;
> +				for (; ts_id < fetch; ts_id++) {
> +					if (tx_id == 0)
> +						txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +							rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +								txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +								tstamp));
> +					else
> +						txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +							rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +								tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +				}
> +			}
> +		}
>  	}
>  end_of_tx:
>  	/* update Tail register */
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> +	if (txq->tsq->ts_flag > 0) {
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, ts_id);
> +		txq->tsq->ts_tail = ts_id;
> +	} else {
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> +	}
>  	txq->tx_tail = tx_id;
>  
>  	return nb_tx;
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index 500d630679..1e917ed7fb 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -8,12 +8,32 @@
>  #include "../common/tx.h"
>  #include "ice_ethdev.h"
>  
> +#define FIELD_GET(_mask, _reg) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x = (_mask); \
> +		(typeof(_x))(((_reg) & (_x)) >> rte_bsf32(_x)); \
> +	}))
> +#define FIELD_PREP(_mask, _val) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x = (_mask); \
> +		((typeof(_x))(_val) << rte_bsf32(_x)) & (_x); \
> +	}))
> +
>  #define ICE_ALIGN_RING_DESC  32
>  #define ICE_MIN_RING_DESC    64
>  #define ICE_MAX_RING_DESC    (8192 - 32)
> +#define ICE_MAX_RING_DESC_E830	  8096
> +#define ICE_MAX_NUM_DESC_BY_MAC(hw) ((hw)->phy_model == \
> +					ICE_PHY_E830 ? \
> +				    ICE_MAX_RING_DESC_E830 : \
> +				    ICE_MAX_RING_DESC)
>  #define ICE_DMA_MEM_ALIGN    4096
>  #define ICE_RING_BASE_ALIGN  128
>  
> +#define ICE_TXTIME_TX_DESC_IDX_M	RTE_GENMASK32(12, 0)
> +#define ICE_TXTIME_STAMP_M		RTE_GENMASK32(31, 13)
> +#define ICE_REQ_DESC_MULTIPLE	32
> +
>  #define ICE_RX_MAX_BURST 32
>  #define ICE_TX_MAX_BURST 32
>  
> @@ -144,6 +164,18 @@ struct ice_rx_queue {
>  	uint64_t ts_flag; /* dynamic mbuf timestamp flag */
>  };
>  
> +/**
> + * Structure associated with Tx Time based queue
> + */
> +struct ice_txtime {
> +	volatile struct ice_ts_desc *ice_ts_ring; /* Tx time ring virtual address */
> +	uint16_t nb_ts_desc; /* number of Tx Time descriptors */
> +	uint16_t ts_tail; /* current value of tail register */
> +	int ts_offset; /* dynamic mbuf Tx timestamp field offset */
> +	uint64_t ts_flag; /* dynamic mbuf Tx timestamp flag */
> +	const struct rte_memzone *ts_mz;
> +};
> +
>  /* Offload features */
>  union ice_tx_offload {
>  	uint64_t data;
> -- 
> 2.43.0
> 

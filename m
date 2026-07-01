Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE71C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E595C402E0;
	Wed,  1 Jul 2026 10:45:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EB16040278;
 Wed,  1 Jul 2026 10:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782895511; x=1814431511;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BUa0WQisyAMccuJVecatdZqowdRg28oVn8XPAvvpdM4=;
 b=Rz3fgbPqt2tE1SJhhRpCTXda6bFx8qYYS2AP5t+dlVNv2NMOkBdxF1Ou
 ESiONu/p4MuLsqNtLMsUdSTne/dvpTcwdP+jaglWiFq3enCyRsovi2H8/
 yLCqmZ7ODpIhyOix+DEvW296YcEAGFKx6x+bX6S8lawpCQPTxTDEdmy2z
 rX/Szz79E1yCPerbQSjmJryeZyNI84kXZen40HExP/VHhcK/os9xvNiSN
 aw4MhSyo/IeaGJfo32dzR1fjdu5bglqIkboXV2w5Xhg46OLRPUdMl5cQS
 oYr/npvt28puJeS39NNtriXVnyZNj5PSFj9ej6AnwxsBJaxCwoFLycxo/ A==;
X-CSE-ConnectionGUID: rjEEKvhpQoi/c85UEc72iA==
X-CSE-MsgGUID: bPTDAVySQjqrOLpMBSPxxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82739353"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="82739353"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 01:45:10 -0700
X-CSE-ConnectionGUID: bKePUws5QwesgTvA40QVaA==
X-CSE-MsgGUID: rNyrCqnlQmW0f9Zhk908Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="282577907"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 01:45:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 01:45:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 01:45:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 01:45:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+/EOU+49XkKf+y9CduqBBbeyUZ2wVS5RKMMWUaHy0zRaGEbgUI8ITnJib7rmakRA5C+2PXABgom7i7q2Y+c7M/FdbBHQsPyyKVRxzxnbZyPH8IyZA2GMUs2ZbQS4iq/I6Ey5C3EV/fo+JngaF46Tlkpg4l69ew0sa8T9LaGlcRJdm8wH3O+6k3WnXYNDCkyQ88PHIOnUJzvhs7NPg+aiD4dFXkkjSXeG2D6/xrwREOfU8QjKFqLUKIN2JVYxKKnhJSj0Rs8sFwQaSeYztbhQ3kmdDfi/2eA/9KtjqHZ8xbhOkTqz+0bBipjPh5NLgPlWSlTswoAcnXbmKj2tHaO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L1ahjSK0ijjeoBVjkDyIm+sA2Q1uXkzPoMkfNql9HA=;
 b=ty9RgzaBxsEAQUW6YxRyyih6uOLYyYTt54iqB5SuBAhxM2sNJPGl4M6KyTsj+6AFlweRdqguQKw/5zBuEMNUuezB27zdc2OZ6fP3OHb1jtE9t967NKFBesnjgispt0lWjVZyg5AZUpfJOoi0VUHHLlRDSw5zMTexJIdRyRJVHks2HB2VcCbcxNvqrO1XRBfmhcrMe/OdoyxXV134vpVbCnl9awq15OGhstbNDFnoX1M9It4fXXOtIqCO2ajkOyTeProoppMiW3krOwksisbWmUnzfNxMrFo5X1teVXmzDE3rxL9g8iciwGXnrXVqdPzUNZ2mtcY7Gfozt29DbLf2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by BY1PR11MB8005.namprd11.prod.outlook.com (2603:10b6:a03:523::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 08:45:01 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 08:44:54 +0000
Message-ID: <838a36a9-654f-4b32-b3d4-3457dd024b58@intel.com>
Date: Wed, 1 Jul 2026 09:44:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/idpf: fix Tx of large mbuf segments
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20260626134440.2108591-1-bruce.richardson@intel.com>
 <20260701082337.3176970-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260701082337.3176970-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|BY1PR11MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b137c23-e8c3-44ec-cdb7-08ded74d0617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Zr5fr5J2qX1q32xQ4vGMysuDd5D7lBy/5ceVrfwYciSEm/Zfekwb6UHC+2xVeoEYlPwFqAhmKoZQ/HAp7JHm7Umng5DVtJVHh3n5bbQiT+CGTkLstuOx6OnRDktXi0T+aYe5tQ/LLeMZ9q6Y3d2mMwKPm1r3vj3fjoCiXZ0Gl6hsK8Q10zhiw7KG+gAhuD3X7WN34riXnqul4kuojDs0OB1MrBkFu+FxlfruSpFzOu106QjU7wJXf7h7DG8br6nTdoqAVJiuf75g50qszcnXJwGC15RkWK2Gi0Muk8WKt1YS9U4hQciw9fgnUd8e1JzP3YUGIzptvMJ8dGC7uHlQMkonBTyZFPxY3IGYOPZag1P9378PBUSRoPcMjR6jANlaMYVVwb8wVcwCW4QqPG1xb8yqJ7Uw3R3OS8gdBLcG7wD4+was03KMmUOZdjtXhgxRLn4pgg043TuLBGGnxEhsbWXtKq4I84gYCTtK4E2R3JmIJeyCusv1ZD1TA66Lycd8UhFlXvqaM8MjuicL9g1wssPa7V5CM+7OYWbnKqdcJ4fAHR3eYvHhOBr3PCTKcGPP5pSN0o0PBIvKwAAXjco2NDrZh77jmk+6JjX/5XWuArlU4kO8IfsKW3N+85SjwievOm1gCGhZkGC714L1ARwG4JCphES2eSjpnwAWASRUACs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFaTHlmNkMyaWg0U3kyWFU0KzZZOUJCWWhuREsyVHZ2aEhOZFNUWHYzMEZk?=
 =?utf-8?B?UE1RRzd2ZHZpdlVXb2pSblFuKzh4aEpQaThNWWFEMVg4UG5TbnlndmRrNHJu?=
 =?utf-8?B?WTJjbTdsQmpVMXF1dHI0ZGEramtsTDBBSC9KMzEzNjAwSElKVVZIZW9KNFFI?=
 =?utf-8?B?SkEyM3B6KzFEZllmMjJVbldNWDRzbVIzTmFjRENVQWtldkdlc1NHa25seFRG?=
 =?utf-8?B?bjkvbFdDMkh3K0ovWWZURGFYU20zbDNKUkRmUjJSRzhOVXN2LzV1Q2VFS29t?=
 =?utf-8?B?cW5oM1lKWU1pQlpudE13azBRT0JNUm8yL2F2eW1ZSUpCaXI2V0VnVEpYTWQ1?=
 =?utf-8?B?MFZhWXpyN3R2YVgrMHNCVnQ1cmtlekx0Tml2T1pEL3M5ZzZTVFdvVExDNmdV?=
 =?utf-8?B?ZVNIQzNIdS9aZGtsVXZpUXgzSGd2aWZwRW1oL2RuVE43S24rVE9VVHdCMEhk?=
 =?utf-8?B?cmdFWVZ1aWFadWF1cWo2MFpxUWViVHFWd2NtL2k5Y05sK1RxOGlFTjJ1T3Z2?=
 =?utf-8?B?MzBtMnprYkh6cjIzeDM4QWdrdm81ckJwUG5TZXA1NmtMdXlIWTlsVjNObGxm?=
 =?utf-8?B?L1pvai9FdU9qQzZzNFRjYnYwUGZXTzVaa0ZnbjJCUVA4dEZISVh0NlhzekVD?=
 =?utf-8?B?Z3NOd0NLUzVDZkpBRWZWdEdIZkxRekxFUjZNRlM2U3RldHZpeDNrOUhtNE0w?=
 =?utf-8?B?MzJ1aWRneE5acG1QcTJCRGtNV2hTZlArc1pGa0FRLzVDUGNCK2lVUmQwa21D?=
 =?utf-8?B?alhEOTZEclFmY3o3aDlOeTQxUHBEaFc1c1FtVlFiUHMvbTNiaXNPYnNBOTJH?=
 =?utf-8?B?azF4T0FINUU2U0pvSDU1V1lHQ0xOY280ZjlpbnJ2M2t1RTJPeTBvc2VLY0Ey?=
 =?utf-8?B?RnZWV2FTQ3pRdmozUTBPdjhiMjhBWmU3YVpHWGMxY0tQMFlpU1N5WVY5S2ZQ?=
 =?utf-8?B?cmFyOTMwSzJNcFVkdkk5eVJFdW5tOXRlT1dVMUFBQ2I1dndRdTM0QUFvWFEy?=
 =?utf-8?B?R1paR1pELys3VElSS0tQc3h5bmNGZDU0N3dNTW1XUERYV2UvOGNHdXZscmNi?=
 =?utf-8?B?UWpVUFJ3WmRNUndHUHNHVGhtVlc1WUF4VmFwSi93NDg3QWI0dzZFZ1cwV0xa?=
 =?utf-8?B?eWV2aHdNZ0xudjdMdVF0cHROTlF4djlzNzNJSThteGtSVlltbVNkQ2t5RFk0?=
 =?utf-8?B?L0pMVHFUMVo4dW5aSlVqdUp1L2x6Q2Zwd2ozQUdOYzNDenhpTWlnV3lpZHZX?=
 =?utf-8?B?WERJT29pb2dQaStGaHF3ZUNmaXU0V0VYM2tUaU5VTGdVV3IzNUp6ekxTdVZH?=
 =?utf-8?B?T3ZkOWlGYUtlRVpwWEpVZ0hXQ1F2VThaeUZIOGxIS2g2V001SkFldDI3MGFk?=
 =?utf-8?B?SGJOMHJTUmpSQXpCekkrQUVZR3VxVnljS3VPb3BRdE1jMk8vZkdnbmtFc2N0?=
 =?utf-8?B?V0d0YlM2cTVqTHluMWtrN2pQL0hjRFp1RS93TjVkVytFNmI1UFJURitBeFM2?=
 =?utf-8?B?VXlhVExSOGNkallSWWc1NnN3MXJPRGFJVXpySjdHSUtYcDBsNzBZODdVZncx?=
 =?utf-8?B?R1ZLa3VwNG9oeURBWjRUbnpVdVczRGNTd240dVhYV243TXY4QWVYZVZsZUpZ?=
 =?utf-8?B?R3B4UzZiMmNLNGg5K2V6M29HQkFVR0YwWFVnVG9BQmtmRHh2MmxyeXhra25z?=
 =?utf-8?B?MmRueTcwYnNHdHhoKzY1eGtHcC9rdmw4VHpXQ2J2YkQ4S3h6bEMzOXlidU9i?=
 =?utf-8?B?Sks5YjREKzk1RlRkcjVWR1UwaFhwV1A4VWRrcGIvSEk4bGIyMHFZNVRCblg5?=
 =?utf-8?B?aGRkVHJlSUlOTHVIZXZQM1lYVlpnWmtqcVFraU5GbXE4dU1HTlk4b1NNKzQ3?=
 =?utf-8?B?NUovWGw0V2FFS28ycDBCMzI3T2V6azR3cWRRWXBjdG1oMGhScFpqUEJMSUN4?=
 =?utf-8?B?WDN0S2lxaVYrQTZGTlg4a0ZyNTlkK0NNTDRSbE9RSGE2ZGVZeTRZVmsrSTRi?=
 =?utf-8?B?ZDJEaDE1Y0VYeUdVYWg3NjdBTW5BWEZkOVJuWHNUQlM0a1g5N25KTzRLeEND?=
 =?utf-8?B?dFd0YWo2SWEzaXEzK2M4RXJvMWhvbzBmcHJEdEdZa0JDT3gvWmpaZmZzQzJz?=
 =?utf-8?B?V3UzZGdsT0FScDRRRFY5Y2gza3ZIQi9MZ3QvWHR0VXNoRDYyRGthbVd1aE50?=
 =?utf-8?B?SUFBbkR2ZFlJT0J3YW0vcXBrRzEwamtKS2dQVWF6TUxWZU8xYzdRTmNpczh1?=
 =?utf-8?B?akdQWGFwRzVtL2p0Z0RMelpkK0FyZk1MNWRORFRHZjFDN2RIemF0Tkp0L2h2?=
 =?utf-8?B?elhla2dpNFZhUmNoL1gxZUIvekRDV2pPdzZKQmZKK1ZBaWlnZk1PWFJqaFgw?=
 =?utf-8?Q?al007JBmzf5q8JPU=3D?=
X-Exchange-RoutingPolicyChecked: DDkrtFp/4lef7Me7F9gdpegFtiysvaKZxRsWfZzeZNnTee5f0zkcmTWbcW4l4ZNVyR0oNb9L+pkl1/oDCybSp5VE8I4QYfBG9dyKfEC/wRTuBMnYJ3C246wXReOOdYGs4BvVqFkiXKLP8lQ96kbMYteQbMdO+QG9aY+W7Vvdp0CyTvXj9esyeAlhpNY5LNppHtJTsikwjoCA07D9cTVlXfiR+Bu8DZX6n+xl3WAx69AVGlw+zit9NO58GZ/4llmzEDYG1wNgjlAbkprbCjf1qsmruZYRDwZOW/9akAqHMujy3AXyBQ+jTl9LHONdnfa2TgEp2aCmxa/f0ba3+A3vcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b137c23-e8c3-44ec-cdb7-08ded74d0617
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:44:54.9338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sGwppTpYFWXbORWEgROEEGp3SU4ouXxCa0qXj26TeRlrTFaWghqc6f7Nh5yOPtRutq0EWxBB+y/RCJjuDkhxTjjT1eejtZAtomRrISn29c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8005
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 7/1/2026 9:23 AM, Bruce Richardson wrote:
> When TSO is enabled, and we get a packet to transmit where an individual
> mbuf segment is longer than 16k, we need to split that segment across
> multiple Tx descriptors. This support is present in the single-queue
> mode of idpf - since it shares common code with the other Intel drivers
> -  but was missing from the splitq path.
>
> This patch adds the proper data path handling. Previous work ensured
> that the descriptor count calculation took over-sized segments into
> account but the actual descriptor writing part was overlooked.
>
> Fixes: 770f4dfe0f79 ("net/idpf: support basic Tx data path")
> Fixes: 2904020f8313 ("net/intel: add common function to calculate needed descs")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> V2: change check for number of free descriptor slots to use the correct
>      count, rather than just the number of mbuf segments passed
> ---
>   drivers/net/intel/idpf/idpf_common_rxtx.c | 43 ++++++++++++++++++-----
>   1 file changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a123d969ee..2c87e02c98 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -952,9 +952,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   				idpf_split_tx_free(txq->complq);
>   		}
>   
> -		if (txq->nb_tx_free < tx_pkt->nb_segs)
> -			break;
> -
>   		cmd_dtype = 0;
>   		ol_flags = tx_pkt->ol_flags;
>   		tx_offload.l2_len = tx_pkt->l2_len;
> @@ -976,6 +973,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   		else
>   			nb_used = tx_pkt->nb_segs + nb_ctx;
>   
> +		if (txq->nb_tx_free < nb_used)
> +			break;
> +
>   		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
>   			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
>   
> @@ -994,16 +994,43 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   		uint16_t first_sw_id = sw_id;
>   
>   		do {
> +			uint16_t slen = tx_pkt->data_len;
> +			rte_iova_t buf_dma_addr = rte_mbuf_data_iova(tx_pkt);
> +
> +			/* Split segment across multiple descriptors if needed
> +			 * for TSO packets where segment exceeds max buf size.
> +			 */
> +			while ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
> +					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
> +				txd = &txr[tx_id];
> +				txn = &sw_ring[txe->next_id];
> +				txe->mbuf = NULL;
> +
> +				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
> +				txd->qw1.cmd_dtype = cmd_dtype |
> +					IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> +				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
> +				txd->qw1.compl_tag = sw_id;
> +
> +				buf_dma_addr += CI_MAX_DATA_PER_TXD;
> +				slen -= CI_MAX_DATA_PER_TXD;
> +
> +				tx_id++;
> +				if (tx_id == txq->nb_tx_desc)
> +					tx_id = 0;
> +				sw_id = txe->next_id;
> +				txe = txn;
> +			}
> +
>   			txd = &txr[tx_id];
>   			txn = &sw_ring[txe->next_id];
>   			txe->mbuf = tx_pkt;
>   
>   			/* Setup TX descriptor */
> -			txd->buf_addr =
> -				rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
> -			cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> -			txd->qw1.cmd_dtype = cmd_dtype;
> -			txd->qw1.rxr_bufsize = tx_pkt->data_len;
> +			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
> +			txd->qw1.cmd_dtype = cmd_dtype |
> +				IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> +			txd->qw1.rxr_bufsize = slen;
>   			txd->qw1.compl_tag = sw_id;
>   			tx_id++;
>   			if (tx_id == txq->nb_tx_desc)

-- 
Regards,
Vladimir


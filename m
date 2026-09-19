Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1649DC982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4655440B97;
	Sat, 19 Sep 2026 18:11:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B612D40DCB
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834318; x=1821370318;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=k+61LAza+F5ryuwrBg/pwqzavd3pF7Q7QfBkJOfnDkc=;
 b=ScSVV16CfCiZvgC/E8PXDknhY54oPrIDOEyCvehi1M4r+qPa0fy2NI+Y
 t1V4eTrbM/zCYMZAHnL383Bt1DLakMzRr0MYBD/+dbXwzIY5NkXdxS4QG
 6pKh7Zby9cHiZjVI2saFG9nbRtYTyzS/FxZ+gy+/zFrTv+NK73a16O4Su
 zQ9g+/gUGDlBcgCmLdebM7J+u0vScAIyxX/b4RdSKkVUWrQ+g761zsDep
 hI3+uAswS3C3oz9Af+ogq19VV02S/fVjgymTlOY1rFwW+cmnMzuxoH438
 +FplSipgzspvkZWvrO9WqmDlSKUopFUS0SDOoSFKiIbjAWYaOTz2/bpVr w==;
X-CSE-ConnectionGUID: kx9d5RFRSiy7gk1SA048sQ==
X-CSE-MsgGUID: /P1RvbqpTY2+0mr1Fq7w7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89287875"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89287875"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:57 -0700
X-CSE-ConnectionGUID: 1U9apRARQHa9bfza6potWg==
X-CSE-MsgGUID: B/tIFcBfQ1W5E7da/exs3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3326453"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:11:56 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXJzhmxZGffN7NXi0EFdqA3WlkeKICBZvUgn+gMYk24oG49h18mROcrCIREouqauipg63WYWYBfLRZnf4O8BDj5fyqXoyEfsP6y/z+lXeqmKVqnFC2P+2UPtK6D2rw6xZ7LSKCHAH8Necaz/CGyUO9LZMcAPOZAGPSAmsNczePiVkW2I5lDRcA1vA5nFJXA10Jw+i00TC25CKiQua8jZ6bjB2LLIQGTSUUklNEHSZ6OIOYeGa1vSB36TBzU1ThU1qbdO939Ku2iHyiLFz7VxjwfjEreaNEyV4UK1jcc38DA+vxd3mT2MdN180GQn8QcxIUvxrhiSS7lDVzj5qFTTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXtuz53A0fon2cMLLWPA7xVOq6KPd1QMACdK6q6fSJE=;
 b=mxn36DoVrvG8U3xd7MGDVcAcuwgv6Cf9rL3SOCAowFSJexyyB1lkGlIET9Ct4pUlFq7JsqrEz6HwdVLqNaM4skr/FDlqsRhhkO4kN5mmL+gENawZg+mb0EcDw1TRCYOKS3lDo0aYTmW5m45LTTAnn9Pg5R8KtgzQymT0OecfSN03F1qVB+RaASlAhZcEUqeowoQSbm+3eQtl928OMuLT1Mtg/N9IL89ZMy2NB6GM93Zf94OuIfgvIj9Tgjuqcn7NtWBAsuC8bOAWUZKtEwmXYQvV2MiTiLxF1cPry4zqnUWZ1rsx7Uv+JuVNEFNBsmAMP74XpoFWakgIP2c8BTzbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:11:54 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:11:54 +0000
Message-ID: <69ca2fa2-48c3-4d72-9ac0-36b81b7704cf@intel.com>
Date: Sat, 19 Sep 2026 17:11:52 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 12/19] net/ixgbe: advertise flow keep capability
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <2b8b1ef8b636d23db9a9741f38ece4e31bf3997a.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <2b8b1ef8b636d23db9a9741f38ece4e31bf3997a.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0004.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::9) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 789a9c7a-ec73-4e46-de3c-08df1668b90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CoHVYe1DBmXfSJtAuEqRpakfgKEt+aE/Kt7k00sgh91q62GNRofR31BeXdTeAFJXTxZlMbN8cWhmsOf6pnmvpqEi5tGE8mjzDXgXQwXsFKlJiAKw+TYliIyex7xS0afRjajKDlOPiV+hbUXYPau4ZvMVWVHCpWh0QuC3uY9nYmdX/uHF/eSI+NTXNBydNhn3+PisIMRf8RD1JhBY0Ht94/zcUybv6sC0+8q03V1xQWhFxboD9a1VwlJYqyz38J/WB43eo7QPhH1YxWAp9m99wyOfegJlxMy7l2KJQExVcAkvu4n6+OvCVkqpJFSEWdMzIS5R2y/ag2y5o8mcNbmnvGTcYpyXyzncba9PU5Egwdd4QaLluB2KdzdQh7qd9UCE46oMXnvpI6lRLBu0YopLiw7vMmufwtLsElXlQ1XyunWIKPHHdCcpbL5A/uidZaRDrPUUgmssZkA9SlIHfPLCqW4RwtdB9u+pe970XRiKEM+rS4vRc4mB1TI8ee+qR+pcTA6JmgXqwkTOuaArsjH4UDkaeifSp7lRzrpsGUuukmHoKd5g2aszUF9by9LgXGeAz0G1Xj515BAs1IzWVPVTreMgspmmCZ7n2koGwvJ8tN07O+h2zBLRuyDZaudTLYZLXeODhtHQZTwJnt2RcBeLEwI7RKs/pgGM960lHWkFFEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0lzL2pzRWlBblZHRTlFS203YlpYTlZvNEl3OUhIdHBmcEFkVXUxSDZ6WkJK?=
 =?utf-8?B?bW5FT1hWNjdMRExNRm9nR1pRRjJYa2prTEp4OWFPS1FXeVNpWkY4aHI3aytT?=
 =?utf-8?B?OWZJYUs4NXR4UU4rSkF3MHRGYlcwWlgvRlh4MkVSTkRzR1BXTVErVlJVNk12?=
 =?utf-8?B?OGRPTWQ1MFdTNXo1WlI5UFJZdWVxamg2cE9ONG9ETEpOM1hOSlRrdzZncUJw?=
 =?utf-8?B?bzB3anBHMXVmanlNU0RSdVIyY3Q3S3pZWGdscWRWM1B0eFVhSWJ1dDRTbTNV?=
 =?utf-8?B?WWJZYkJMTGh0Uy9IRlRkT25udm5MSkZXWDBDYVV6eXFveldFbXB3R0RyZFZP?=
 =?utf-8?B?d1I3NkFpaTFaV09wd3lqVVdXVEV5T3p4TXRxWExwWFBIUktNNm83aWJ5Ty9o?=
 =?utf-8?B?ZEpWNDRGcTcvdTVObnFGTldkWFFmTjdwYWlBWm9xc2Ftejk2Z0Q3TkpXS0ND?=
 =?utf-8?B?bm9VWmxWdnIrKzdBdFZQZ1ZKVkFWaWNGaGg3RmR3M1VBck9ydkdPNzBaenhM?=
 =?utf-8?B?OTRRRktZVWpMNG4vMkRiSEovN3BrWnpRaWNVbVp3SmNsLzdhSFBLY0JOb2ZR?=
 =?utf-8?B?STBBUXEwTEpQWi9SLzMxTEkrdXVZdWtjTmJ0RVU4OE9uaWJ5RDdiTFpVRUw3?=
 =?utf-8?B?S05KTjQ3Rm01c0JtaWpMNjF5TFFzcVdyOUE4S2lvYkFqNFJXdThGQnBoeVdX?=
 =?utf-8?B?WjRyWTVCL2VFQ25NY0tLY0VTakFnU2E2Z1o4S1dqYTNkVVc1cm9VVzIzMnhn?=
 =?utf-8?B?Umw1VExwd1ZvS0NXcGdFeGM0RytZaGVQYUlLVEpKQmlCTFNtTDJZa0U5eUYv?=
 =?utf-8?B?ZEdjelI0WXRQYldDV3hSUk04R3dxNDkwbjBGVVVmVnhlK3MxYU8rYThuL0V0?=
 =?utf-8?B?OUhhWmFJN1NuMTFkTkdmRU0vaEF1a3BybURFd2VsWUJlNkdkb2FmQnZDdU54?=
 =?utf-8?B?dmR4YXRaRktWenF4VmFCc1R5Nmo2a3pWUWN6YXI4OHNZQysvNHVEdlYxTG05?=
 =?utf-8?B?TTdEWDlwYzJTUnlvZGJNZXlzZjhONFo1bWhxcjQ4dExtaC9MR05IclBzb2Fp?=
 =?utf-8?B?WnFLVDVEbW5icUZhV1diQlFMRmhWS0RJcDFoc1kzUTBRVDBmVE5qVlhzT1Z0?=
 =?utf-8?B?M0JobEs2aGZ4c3NXdmlkMEVPcmR2UnFhdkxxc0JwZkFrN00yOGhDb0E4bzI1?=
 =?utf-8?B?eEw1NjlNQW42bDkzUVlyU2tLZGJ0VkxuVkQ4UVRpcEx1ekFKOHpWRWpNS2xT?=
 =?utf-8?B?emR2bFN6WmhGaE9TSHh1U3Q1dzlTMDlETVhRZmsvdjV3K2g2RVJlTXJXczQ3?=
 =?utf-8?B?d3lMTXVkRGN4TmR3dG11WUxUME9EZnJldFpDVHo5T1REbjJtMzVNU2JGS3Br?=
 =?utf-8?B?dTNuUlYrbUlmRHlZc1RPZ0t4R1lOemtGVDVQUVRwQzBWQWZKNVVKeDZuc05G?=
 =?utf-8?B?MEtJNGdiYytqQVppdzZvbkdzTXhndDJBYnJTU2ZwNXFFaTRpRFBDMHlzYTV1?=
 =?utf-8?B?eUkvK0Q4R2FJSjhqMTZXM0tBY09vc0pxVksyZ25aSFc0QmluU1VUcTlnaFBK?=
 =?utf-8?B?WE5EeEREdWVWdVFGT1VLc3k5czNSYkFCK2tHa1ZnVWZUMlkwWXVOOGlIelFj?=
 =?utf-8?B?SElTeHgwWFU4SlZmUGJabjgvZUlqcTNhMFdQdi90Z2FkU3ZYa0dXdjk4em5u?=
 =?utf-8?B?bjE4R28vOXYrOXFEcm5wQ2p2ckUzaGNtZnh4V2tEdmM4dXV6Zys5NDMyQ2pD?=
 =?utf-8?B?cUg4LzZKL0lEa0t0d2ZTTjExbzM0QW01akQ3eEtaR2xQaDhONmM5QmM5OFFo?=
 =?utf-8?B?TGFWTkNOZTJHSmRXYUhmMTZES2lFNWxaUTE5VmgzRmdKRVMrRDBOU2RyWnJz?=
 =?utf-8?B?MEU4cTl6b09PMlc0T1htVmsxdStoVS9YT0dFMjZwZXFOb3kwbXdzZnZ0Nm1U?=
 =?utf-8?B?QVp2czNkMFZNSmVlZjVaREQ5NW41R0pTa013Y09ObXZDK2xGVFdwVUxQSGVs?=
 =?utf-8?B?VTNWV3BNcklLaVJFOVpKRUNrbVN0ZzZnVnJld1pZUDluZloycXF3UEdRKy85?=
 =?utf-8?B?QWNVQ2s4eS8yNnRsSituTzIwd1VkbUZQL2drbEVpOVlNTUJBbklwTzRhUlpD?=
 =?utf-8?B?V2JYQmIxVE5UYkRrWHFDQUUyTDZnMEE3aDRYNWVFbTlWZWVwMnRnSUV2QWky?=
 =?utf-8?B?THpGYngxaU5GYi9Mb2NxaGFsRHQ1RkdyRm5QVUR1eUc4TzhWU0NReU4valMv?=
 =?utf-8?B?QWdnZDdGbXBzSEVJMmZkSE9IdlcvNFQ5MTE1ak5QTDU4S2xPcDVjak5ueDlO?=
 =?utf-8?B?MzRvSHNQcmJENWdnYmdjNVZIQ1A2a05KbGxOczUzTWowRS9oN0duU0w2WVpU?=
 =?utf-8?Q?3HQ/N3OhG0NBMWKQ=3D?=
X-Exchange-RoutingPolicyChecked: xN3pf4JqBPhFPDw/FiwNzXV9IxFY3VjVPv4C70yaTNd9BmFOHwnhGI0EXZGC0RRe3KaH2bh30qLuVUO097Zqia6nYwotX3NJvYuKFHnmQqkvYQ24lltLQTKlyRu/cWJZnARv3MsHpZ4sBZXzIc/DfEdZKaMt1UMImwKjK0OerV+Q7py/ej3QGvKUeeChtYFYdVsxmbaKcFiPUGYu6gygNHkz9jTJAWQnESO2sNf0DnxX6Sodfbq0REXVjUMBQIHC9p2j1UtY87qkdGfUyhxsNre6HPy12DDZbGwUf8i+pxG76SHxF15gXhoW6Gz/gGiavPPl8NC9a5AO2bQibeKZSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 789a9c7a-ec73-4e46-de3c-08df1668b90a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:11:54.8188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb+QRRRclDk2YjbUIFVQl0bamW9oRwfw5DqPZfXfZWTVAsDx3C1c7W9QWTwaeVluMXrpEUZk450MEsZzqES1WQV7tE/bbB6+RfJ3JNkBjrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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

consider reflecting this in release notes

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> The ixgbe driver's rte_flow implementation has always endeavored to keep
> flows across device restart, however it never advertised this capability.
> Advertise it explicitly.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 78f3ab57aea..48b1957ea94 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -4002,6 +4002,9 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>   	dev_info->reta_size = ixgbe_reta_size_get(hw->mac.type);
>   	dev_info->flow_type_rss_offloads = IXGBE_RSS_OFFLOAD_ALL;
>   
> +	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
> +	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
> +
>   	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G;
>   	if (hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T ||
>   			hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T_L)

-- 
Regards,
Vladimir


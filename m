Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77AAC982D7
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:16:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9AD340272;
	Sat, 19 Sep 2026 18:16:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 67E3D4026A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834585; x=1821370585;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Q7rUDVObUckkD9bZSGi5ij9p6zQNGpv9s75aEnrq4Aw=;
 b=c0e1TO9H2GIzYMTHINRaExi0B3agMCqs6+9neiqTUcwKdJpbsC3qxncZ
 59+Kt1/Q4GlTEx/VrjyfOTCRxRXsWFwwngXo4dyuMPFmUy0lzaWBDAGXv
 GufQgxj1oqSE35L5WwAzWumZof/rWCA2IZxnSZIVYvwSJzH4bc2sJZXu7
 mm9erBiPPAOqh+768debR/n59Y1t7c+Sh1mbK8le34Em44s80lYhYpMn1
 C1PT8SWI2f55lYYZ7/lMf10xI1E07fH97lVy7VyDUjEABr7AdkFCq+9HS
 GC0xRUoQnshAmho3k+5Z6/bcBSZiGWPf1MU0oSovMd8lGw9+FElJN79Hj Q==;
X-CSE-ConnectionGUID: 9SnyNnkERBqGh3AVVplEwg==
X-CSE-MsgGUID: gGi1HVToSs+p8/cZ/ZlIiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89491136"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89491136"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:16:25 -0700
X-CSE-ConnectionGUID: cqsdodQRTIeSRpk91zB3Qg==
X-CSE-MsgGUID: vDdihu1HTAeznpXzYGc6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="268546554"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:16:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:16:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:16:24 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1DFL7de8lIP1VvZVW5u+aFghUlcKgs+XC4a0syMQ4qbllPCwv7aPyX5cdLlFVCbLY2UmJw3uj2lz+pU5mrbgMstTxzmObIR22DVRrH8Pyl5fqSuxlRLMVe1m7MbA6jfU9moeCnZz0ksBMM1P1MRfbxnvVTzLhhz6rWk1bA6Q5Bu/0ybSnuF50ub8JmXU23FE0IJMS5vvUUl/j1TxFm1igmsA7ReRb2Mgcl4YlMwnXh342EFVkGwIemsDYeK3gnXitjJAZTFpy9RxW4wsfyWCmOZ5EdbmPEa9cd+lV1mpcCw/P3PByTCjB/DilNmNoMeeXptORl98S/dg4HRyuWKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/D5qdU0Tf24rwccpExHdi7A8RMoYgnS4LI+vv+E8Kk=;
 b=yzL7BuClnF82u4ici6RUJKippgfwZ4caAQG+QPVESYKrI+rcYV6cy1Ww9pCWqwNtCwBVzOv1P/JzcpNHDMY9T0cUJcJGlqMJ+NsQwEWxf/ATFLxODBAIftQd0Sf0AkJSc3sfIikugq2ZT65sDj4wBYV35EKzm7NUyX1FYXFnRym+YlTxfm9DRG+CzbfDvOy/FR9+BgJi81GVuxQRQwo8f4xnSPwQgs6Ak2GhzLrXciUy/I+ES6eKp3XpPwwhOhASqYpz/RmLlxvKn4vnyrTC3VqPz3wnnDFtxlhTLe3xItnwG64C9TWTUYqxKa1/3pN8Ak1DJPquJj8voBCDM3i65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:16:22 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:16:22 +0000
Message-ID: <71290157-e44a-45b2-9f40-393590c0e386@intel.com>
Date: Sat, 19 Sep 2026 17:16:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] net/i40e: advertise flow keep capability
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <3f39e844c2a4858092a67a4c79750d1048011e87.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <3f39e844c2a4858092a67a4c79750d1048011e87.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0186.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::11) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c96462-fa02-43c6-bccb-08df1669586d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 87kX8fGNYelRZxMfxhNvpfu4E0h2HOaMea9arfjl3vq8baTgB7Ul2bS+1ZoWrbflSqUU3s/POgm3BOddV1jLZfcNgP5OsEgtIXyNlxzeJpPorVEGiO+mJRE5Ym+w9UsmjPS/NWgkyV415ceT22kfUpA4ll4ek2B72B5JYBTVupBJ4rAU50VK5hhdHgVKd1ieJWMIC9wdTXMP/g5PCd/o+kmXgFSPjJVFPkcWWOj8PLnAns6DB0c8/MQQIZMSEdGkR+9xBYV2Gm/+rJsqI3hvpLTSzsFA1agjSCWbfw6dNp2zmdyovTjN2RSHPQlZRVxCX1lScvh+pIJS6uzxl+5bIb5cAt8mYNTr2OidhGQ7S83M9exJ4FjhHomKNr130CL9wiP2ad8RtwSCfDiwwhGpG1JJMP+PKyCrZRwrdoZkPxm8/OjoINN6zUn6ORW1ZGGlUxnDkrzqLDjeZkQnKxYJX6BT/0+ULuP9WVUxfviwh4WGVe5zh27SffWGTXlmYIEdQD3ffcofGJfK36C0Bmb7QhzxVXCsbJWckeFvuDMyWG+dg3fd/uIMltrN7xPGsO/l/pk/4QNhwyjavbMIjePPRmX/+qb8wiuDaPE0KXHQ0hpWHGI6KZMdHYZVy2eb8exyI9AN11M67B9RtMYvXHpqkyqDPKLVLjTiMjVEwf4URMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjMxNnpsTThWSHRGV3RIekNiMVVyanBKSkw1eS9pQ005eVZiUGhkYkQvandV?=
 =?utf-8?B?T3UzcXRSS1VvYTdOUVBRTWl3TmZjc3NGSVlTclRSMFFDSFl4ZmtiNFhUVkdD?=
 =?utf-8?B?eFhFbmxVVEp0RHdwVXpNWW1lRnUweGNhWFo0cWlWY0c2TWNTeVM4bXpwbTZS?=
 =?utf-8?B?YUhlOERMTitKLzQyYmV6Z2lSOG9XRlpNNTdhQmF6YXpXajhGY2Y3OTZSdENw?=
 =?utf-8?B?Mm96cWJ6dmE0bjU0MGNNTXdCa1cwbEZaY24xSkRUOExTbzhsQUowRkN2UUNp?=
 =?utf-8?B?MlY3dXlnbTVIQUk1Y2VmbWI3YTE3U1o5azRhLzQxeGszVUdKTWZlMk5taW1F?=
 =?utf-8?B?Mlpzd0Q2ZlkvRGdUQ0RQVkpnWGtvRnVMSVZoL3pqUXMxNkVUSCt5czFTTEN1?=
 =?utf-8?B?dlVNTk9RWjZIQWdkcHlvbVpETERYVko3WGVMODFBaE9hZHdOSFN5OUFIbWx6?=
 =?utf-8?B?Y1FBSVFKYkVGU1ZhY2p6WW1qbVJyY2lRdUN2WHYyTzRhb3hUMnpKalBIcjU2?=
 =?utf-8?B?Qk8xVUsrdzRRT3dXcEVzdmNKN2NZc2hSVmdsaDErTnpFSnl1Z3BCMDMvNDMw?=
 =?utf-8?B?R09uR3BOeDNTcWt3KzJyc1BjWmpHZ0FFM1NMZ3BnT0Joa1dCTEpzQzhYRmRR?=
 =?utf-8?B?dHdUT1lQSmV0SnY5eFVDTjZZS0JUVFhJeEhHeXlYT05MMFBZSGR2Z28ydWtT?=
 =?utf-8?B?dHQ0ZEtoQUNibzNJQ2JxKzBOcW5rZ29ReVlxaFFJN08rdmJKL3lUa1F1RkVy?=
 =?utf-8?B?M0JGTll0RktDQ0d3MGdmNmNtSFJDL0xpNSt4aVQvRkpabExXaFBFNTh0TXk1?=
 =?utf-8?B?U3I3eXArdkxVczhMcHhldzdUdTdYenRTZi9zenhHcGxWcTNQYkkydW5uRk45?=
 =?utf-8?B?aU8rSml2K3JEU1FucS94VlBRZ1Z2U3lGRHBsd2FURTZvdzJENVlsRktFNkor?=
 =?utf-8?B?cG54RUZjalBHQUh0eHA4Qy9LU0RjYTFKYVJqdUxidUpsdmQzWmFINDI5NnlR?=
 =?utf-8?B?cndUNEVWQldlWXV1QkZaNmo1VTM0dXJNSUNVb2s2SkJRTkFxQlZvS1phenhl?=
 =?utf-8?B?ejhvNHFnUVFWdmR2ckxJcTdJdjNlT2FScTBpZDErK2RJS2cwMzdsOUIxejRU?=
 =?utf-8?B?MHN0QWxYOEFPUUVudnJnM1dxQ2xjVUNhcXlYVWgweEZJNmdiWVVkRklJQnFs?=
 =?utf-8?B?aXhWRkdMU2pZcHVzOUFxTnVsL1hmZTNoTll4bEJpU2FlRDBMK3pJUDFNd2hW?=
 =?utf-8?B?Wmk2NXN2U1M0RHZPdUdxK0NKSEZDM3RPN2o3K094Z1ZCMitObElmayt5VXNU?=
 =?utf-8?B?dEFzVjcvbmhGOVZTM3E5MlB0UE80dDludzRJbU92Tm9hT0tjTVB4QTUrb1Ar?=
 =?utf-8?B?c01Dbm9zcDVHVkNLTXYyOUp2dmZ1MXVuUElLNEZnbEdXeXdlaUpyMkxiWVhR?=
 =?utf-8?B?WFZqVG1YR3BPdkFTQmtjWi9JVWxQR2VmV0x2Z3E1YzNSYmtHTHpaVVJoTXpU?=
 =?utf-8?B?eHRQdDZKR0RkYS9iOXdSQmhJVlA3M0I0U3BEL1lpbU5VNlBhMDU5NGNkUzR3?=
 =?utf-8?B?ZjB2eWRNaUJxZUgzSTFWTzNUYmEreDErbUdpVWhibVhCRG1LWVJLelNBTnlY?=
 =?utf-8?B?cGsxZDlXVGh4eGJOSFFVekVSMGVYaDhtRVZOUktIK2RaUk1jb2ZFZks2Q1Fm?=
 =?utf-8?B?MjBTZmpVRjQ5U0Z2cjIwa0xuMTdnVkZwTEViVEZrUXVoYlNpOWZHd29GQTNX?=
 =?utf-8?B?ZFBUV0dyN3F4dWErRWpFYjM1amxLcEk4dWk1VmdpaWg5ZFVDSVNuQ3JNeG9w?=
 =?utf-8?B?WUV3WTFSemVWUWsrOWxPWWE2bjNydXloVTkwTzlsN2NzcFBjeDhtcy9aL011?=
 =?utf-8?B?QkdSZXJad2RHekV0ZGU2bHRva0dVWnpPcTI3UkNpdVRMckNzK3RMRkxNZFgz?=
 =?utf-8?B?UzRRNWloKzRyRVhMajVSVGxvN2VmRW5rcnVxdDU4WmFtdTZFMHNjRlZYNUlS?=
 =?utf-8?B?NjBZU3NmNEN2azhBZlZQUy9icFpyY2Q5N0d6djBBNzZTSHVCUDJZOXlWVlVE?=
 =?utf-8?B?b3B0c0FxZHNTbmhTRWtGcmZ6OXFNNTkzNU1nMkRtNUYvdUROd2gyQWs0THNG?=
 =?utf-8?B?Y2pYd1cyVW1JR2hncXU2bzNEcVBEYXVhL1daZXRXYVJzOUtxQ0hLc0cvUkRF?=
 =?utf-8?B?V096VWRlVVJGQmNtUEJpOVZocldWczhmSnBDWElPdUdxcmdXRnNhSjg4cWJj?=
 =?utf-8?B?Zm1pZ1BmUkZWMFM1T2xvQit1ejRibW5HR0trQklaNXVaeUlsckFqWHdqMzFU?=
 =?utf-8?B?MFZFTmxGZWVMU2ozbXVUMzBFTmp2aXFrN0gwTE5iaEx5ZGtmenpWS2ZCbjRQ?=
 =?utf-8?Q?ecjywJCMwv2VVwIg=3D?=
X-Exchange-RoutingPolicyChecked: Ie1+h9YZz5dtj6K9Zh9Vr0rN7GUU95LRLKecMNfJrvaiRhYSx3s21tlgPKXlWUH80qGcqJJoBldVzExBjswb+TbfwLzMK5zZUwz91U6Ho2LoU3e1TcomRXujBv0N5BuU3JS59slqSYlGuVeGAopaUQQrPCqYp3kuFl8FplPwVWL/+VJoTqxGNbD257OJWJdkli92nW6DC2mB1csfg+drBs0mlvaI9kcvN8wtvNT54VgStuP/pRg5pt6kVptRkiRBMPLETuRlk5S+zk4r2Kc0HpJjEe/zAofhUA30QAMpLayjRok5WixHbK4QBoV2idJ0G1uSGokCMBBaFU9//lbekA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c96462-fa02-43c6-bccb-08df1669586d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:16:22.2425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sidv9vWMIss1jmJ5RprK5NquYLhMAmqaktQr47oanN1ew38rKk9DQCKTttuITRKme5VAAsG2cus5S3eBNAdwf06EUuD96J884PiHBnxl2uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
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

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> The i40e driver's rte_flow implementation has always endeavored to keep
> flows across device restart, however it never advertised this capability.
> Advertise it explicitly.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index cca60e2889f..4e8a6a83b15 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -3664,7 +3664,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>   	dev_info->dev_capa =
>   		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
>   		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
> -	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
> +	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
> +	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>   
>   	dev_info->hash_key_size = (I40E_PFQF_HKEY_MAX_INDEX + 1) *
>   						sizeof(uint32_t);

-- 
Regards,
Vladimir


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE302C982D7
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 18:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E59740647;
	Sat, 19 Sep 2026 20:03:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 84AC840272
 for <dev@dpdk.org>; Sat, 19 Sep 2026 20:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789841004; x=1821377004;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SasmyREIEi1Dmy972dtRZHNQasggC8GbaBwYl0NR9hY=;
 b=EoNu3lb/0Ft8qoucXBVpv8mKZ/aDks2VGanENjwjXv7yKvRDLbF4ABCL
 8cD4mJytv1EkWiO+asHeoZIPmWf9XYGTo49q59MCd73Swf4VNV4h3ouWy
 3Z0axH1CU6LTwsYe/Fw1eT56invw9jub9fBXDs/cVXhhu5JD1+tYQ9w4L
 9b5eQuaD+NTFpBkYBFzqs+g9Zx7xRe1FVkI6yUWo3fHcdmrydTUCzC9oh
 /PABu0JuZBGH7iUrjw9GO3ecOVjnnDCS5lMW6dkKnE7NizQreG1dRwip6
 Js7eRs1AECiVGCk8Ic9W0TQGHpjvT35AOAhr1pHJ2ADCH7HURg+f1gdog Q==;
X-CSE-ConnectionGUID: cp8O9ytBSv6GYy/69j7g1Q==
X-CSE-MsgGUID: OUQw+FS4TS2SHUg5crdWgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="100961329"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="100961329"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 11:03:22 -0700
X-CSE-ConnectionGUID: 3slOX08gT8WZ5wH50Df10Q==
X-CSE-MsgGUID: q/rwjGJiTQmopQY0xqXmvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3066858"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 11:03:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 11:03:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 11:03:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 11:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE2IQuic7/zBONoxhICcgVWQRAaKB6+AxysYjH0OUgNTViz6ieLbFSeef3Kf0ncjEAbSyjVxMyzjcVD/E1pMUooxrqjgEk2OgSG0O1TML7cO8Vl9kpHCSQOPAm91gCYIApgBfJu2eDZoN5R1AUyCkInGod0HWGaDsqo50iCQLFOdb4BCCO/1eDhP3u5Pblqb5G/6CroVIbEGf4zfvw524Z1NKu5pa5yDG4Je8PfzQLvdFFTTRf6S6cUl3t0h1HbfejK4fp5E8ATQQ0KxZIdFduCWYPVIahTaTAm0Xwl8tMPg/k81Et6Y6+9KVyVSmcGz9DH0K7f+uMzhz7J+v08r2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nXUT0cx0MI9Rx3dyVrPDZB9HRIIurdbFolt6U4uFkQ=;
 b=eN+p7u9NeAIG7ValgebM2RPipMZ2+IuThKODhxOJwqHxHXGvszZyAYQA2BXSPTm7HVcchr9rLritUqvBnJ4GifSVsWSj5GhGxoTjQsbLbCiuEQr5rOYd9RMX4LoNJPsu/sdqb/usHo3kcx1cwm8sisfE3uqjir8ruLmJvYyEdO1c2X8VUjZ0up+zRB/jb+0i6+fg7leXeZdrw6eLRquA4clrxSgtdMdzUrWaRcdPheX+UijJGsxhN5OeMrlQtvw3/I+RkNL3JFMHnKa+XZHTpVMq3883eeiX74zDAflG74V10KJTnRipclQTcHSQyKOjoN4GdSAM/3pfiT0iIzrEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3002.namprd11.prod.outlook.com (2603:10b6:5:6d::29) by
 SA1PR11MB8859.namprd11.prod.outlook.com (2603:10b6:806:469::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 18:03:19 +0000
Received: from DM6PR11MB3002.namprd11.prod.outlook.com
 ([fe80::f3b4:28e5:66ab:113d]) by DM6PR11MB3002.namprd11.prod.outlook.com
 ([fe80::f3b4:28e5:66ab:113d%5]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 18:03:18 +0000
Message-ID: <7adf76ed-13af-4fb3-9d41-1bbcd2364ebf@intel.com>
Date: Sat, 19 Sep 2026 19:03:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/intel: use rte_validate_tx_offload function correctly
 for i40e/iavf/ice drivers
To: Omar Munchaev <omarmunchaev@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Omar Munchaev <omar.munchaev@gmail.com>
References: <20260916141235.2074815-1-omar.munchaev@gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260916141235.2074815-1-omar.munchaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0065.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::6) To SN6PR11MB3008.namprd11.prod.outlook.com
 (2603:10b6:805:cf::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3002:EE_|SA1PR11MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7d7dcf-9dbd-4f42-3c26-08df16784857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: PLN+8Ik/q9S1Iiysbw+PFDyfbo/rSD9J/7RwhOU1r8GuWiDMdAzSjVmV16T7CpO2BVsZb/Ib+dq5DA3+9p0ImpKzwKJWB6Her4NgNxYwuCwroURCe/YIM6oxNY+ZBtWRPPCblG1qZBNwHsrmP3QkK4ihbGE4J4nknXVL6fX4SeJir2g32pCTcE9ZlWjW/v7vEFxZGsh8foAewk/F0dif4xb+8x8j1Y3fCn+PSu1E3RN+3iC1rdyvv3Od3spi8DSpZRfm+RnYKMK2ZQcY1vtLF2bGEGBpBYh/O4NkeOtZhvybN4nAYw5ygVmS/QFC0pexoPzwrCFdrJ/Lk6wSUf3V4PfwSK2cI0ylzw+ofwU3x4jfhtXZ6VG6qplwfuir0/WEWtqncFmwEpPsy/pY2h5nSlHHHehO2qbkf3RV7GrO4MhE5ciVCOGDfSIWmACfaa7RCdXo5tsDmV8bswSoyi2FARi4cXq5ETJ6wOCr6csUTDaNbBpll/neO/XZaZoljv3yto54eYVbK3LLnzl+8jotvQxgeFM/JyP8dKiy0sBAg9rvExdSNugUedZYJ/X7yjoTOedopba9OlQsRKAUgL+Q6B9EXpfwyYuSnt6U7kBxYlF37qILXCNc7DYJkYN3upfFYkGE3sS/n1HMw9HeyK3lie47gzJLMhgAjJ3hJZ8YenE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3002.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b04wUWMybG1xYmRzdkJ3dzYzZ0YvQ0pMRVJOU3k3UGp2cFJmREdOOUxQOThV?=
 =?utf-8?B?ZnpadTJoR0lGWkRtUldJaTRqenVKclZsa1M2cGFzWjlPOU1wbWFRNllKdnor?=
 =?utf-8?B?Vkl2NlhWcjBqNUMrRy9kdjdrSEVpODBmOHdVVlNNVEpQOG5ibUhOYUxRUTFQ?=
 =?utf-8?B?YWgwN3dZZnJOSG5LZTlBNWNEUUZmK2F5Q1djaHRrK0JaRXpvUG8vZEJ6U3dZ?=
 =?utf-8?B?QjR4L2JSQi9RKytqYjJNYVNWdUk1NDRDQ2ZkR2dUUkk0NzZFM3BvamRVQllX?=
 =?utf-8?B?d09IRko5b2RUek5ZeVRKWFRGV3VpMzNCSTFuS3AxQWhJNzd1dloyVGZsMUd4?=
 =?utf-8?B?KzdLaHdHU1luRWpTWUhIRng5UUlBa1FuNTVaaVNJNEMwM2p6cWxVMU5TZm9p?=
 =?utf-8?B?NXFlelQ1S0NadlZUR0xoc3ZrV09xaS8vYmpkZll2c3JOdVdhcGZxYWVzU1Uz?=
 =?utf-8?B?VkRYN0ttQTZBODRmSm1nOU9aRDdGNVl3Tjd0T2VyUnNWOVFYWDhybHlLY2xQ?=
 =?utf-8?B?aVN5a3dWM1JKQ3RuYmJKa3k4TitJM1k4WFhkQjBJbVdMcEFxNmNyQnZiRlox?=
 =?utf-8?B?Q3NZQWo5NnBjcGc1UWwzVFJlZEVkYmR1VW1CMzBHeWZqZUZicnkySmNNandl?=
 =?utf-8?B?enZ4YzRYNXJ3dnBlaCtrYXBBWFphRzhicTlPSWM3VmoreTlFdFBEVzErQ2Qz?=
 =?utf-8?B?dUo0T3gwQUtoamlUenkwVDRvUHdYQjVrcVkva1Y3VEtma09xdEVIU3JvK2lo?=
 =?utf-8?B?WVJ5T3lqYnFGM3MyNDVKaDJUcUx2bEd4ZEtDWjlJbTYzV1VPK0plUnNNdTk3?=
 =?utf-8?B?WFVOZytsREFnZnlPdWlPVkJvSWMzbitHRUVJVHR5VVgxay81RTFHZDhHdUJE?=
 =?utf-8?B?UDJHVWliRklTSVZkRkVHZDBDeVZyZzNZTU5DQlJmMTB1YXhrYW03M0JVdHJO?=
 =?utf-8?B?OGVlMGNESm1ObzVZK1FPQS9HSTlpSmxVZzZYSHdXZHl0TVQ1WkFzR0lNNFZ3?=
 =?utf-8?B?M1lwbklGN1lWM2d1dXVldXZqMmxraDY3dGc0VktvbFJwVWpwcTl1MWxlTVdp?=
 =?utf-8?B?WkdCdW81dFdGeG5PR095RFhyWmZZSE9sVGpRbXFLWGEyTVJJQUdKS0ozUUlP?=
 =?utf-8?B?d2tnQWNLZmlRK3FWVCtwLzdlUDVzczlVeXc2WXdyVXlVM0hJTXVHUG5DcElF?=
 =?utf-8?B?bWtRODJSaEVWK1dQU0JVamx0SU1FV1FPVEFtaGNUQ0JvMmFUOGgxZjE4Y1lz?=
 =?utf-8?B?UndrUnIvK1ZnMGNFdGUrdkRPZE1DdG9aNFNjR0psNlFzV09mL1dreGs0OGVh?=
 =?utf-8?B?ZXY1bTBQWGUxSXducjZxQ3B3T01RdkIyOHVzUDB6b0dJZExvQmo5RWMzbG05?=
 =?utf-8?B?QzYvTjYvNmZkWXVOQWtiS0VFajl1a3o2MEk5UlprampOc2Eyd3VGRHRIZElt?=
 =?utf-8?B?WE4rODFQb3c5QXpGZzBYS3pmcWhiT01Ba29hNkRWaEtmTmZtMmpnaVg1T2th?=
 =?utf-8?B?YUN4UzVWMnRrTlRpNU1TQ3lTaTVZUnZPMzFabXhDaUptVHplQmRTc1YyZUZ5?=
 =?utf-8?B?dStRdmh5c1dCanF3RFpsbnBGSC9UeHFISHo3OFYvUmZvb0QvUFFqWnllL0Fr?=
 =?utf-8?B?cm1PanYrVU55dXVLaHpVeXJ2S0lqblQwc1hpQ0tkWXBHSnltUkppWGtVb3pR?=
 =?utf-8?B?OWZ2eDg5d09ncmhMZmxiaDNKUjdLdlhweWFUVmU2MGsrV0s4S3lMNlFxMzlY?=
 =?utf-8?B?L2xSNXJIWWlPMUhDVCtoNEpRN09KSWd2ZHZwMWdFNEM1Tm04Vk42dktkSjI0?=
 =?utf-8?B?aVdKQTFwbWJKd3NJNkh6c0xqOW9TaEZmMkkzeFNwUEppL0svendTblNPQXRJ?=
 =?utf-8?B?NUZPL2w1L3NUY0U3Mm5qa0dMQXE3dUhMaXR3Rm9FdWxvL2pkQnhXa1NZakRr?=
 =?utf-8?B?ako5UDJ3YXhRYWxYS01mcUZaeDloUGNzSUp0c1JBZUdZWGNZL1ppVUpGUTNj?=
 =?utf-8?B?NG1aWlcwSXVwWjBJa2NDL3loOWk1OVkrcnU3ZURBMzkyQ2haSWpBY0p2RHcr?=
 =?utf-8?B?YUZnbkhqVW9RdWlRQXArdUo3L0Y2aVRKb3p1MjdFREF1end0WjZZOHJlVFJu?=
 =?utf-8?B?clZBYWhmRmNqOXVYaXR5enpmUUhoRE9wWmpjUHNsNEVLd0dRMFVKa3o5RkFq?=
 =?utf-8?B?S2wxRlFaNUdaNktxWlZDUmdkTlVvYmRnai9JUW41cU40M00ya3JHOFJGdFNL?=
 =?utf-8?B?a3JZNHRLbVlYeFRPZzRLVGxDRXhZaWpuYVRBTHB1Z3N6bE85cCtkU1BMUUc4?=
 =?utf-8?B?UTZKak1BN1hLWFlHOEZSQytRZE9Xb0F4N2UvNWdQN2lxNnk1d25RTG9uUkNq?=
 =?utf-8?Q?RzaQlJyBgLMP4SnM=3D?=
X-Exchange-RoutingPolicyChecked: AUG8PKGM9GvObffDkmKNMOZtFnD9GDXcwziaBEw4U0CHwZOIwSxiGLSqGybwvHYrt8wiIv+g97fbPu9E8JnHnd4JvUMQ679WCaUknyuX+vXhLRUeNtdxD5soHTrL/1mOo3U4AF1UvW1m5Ne6aScWG0g+1G47zPIWFDAdLBSfn7PJVIt6sN7sxj9CDxwPiUlNx89QKe5swa4yGCSAdJ4+c0FPmCWFzQX+Oas4duZ4qMoE5cps8TpD9ew3c0xsznGfDyRx7SbTisjegYSumPonOlNQmUHfb0P8jBPeIDx4+4q3v2HlZvh6fQpVLQqcWhJ+EQ5ZqPq0JIM+Av9h3ho3XQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7d7dcf-9dbd-4f42-3c26-08df16784857
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 18:03:18.5541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbEUuI1kf0tKB9CGligxDOw7B7f+ySOejPKYdBwmx0aEF0MklvgMqggJ0t//R6OenHHCCY60F2roGSyh7rpmfEN/0kPdI7att+8B8o4FyV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8859
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

On 9/16/2026 3:12 PM, Omar Munchaev wrote:
> rte_validate_tx_offload() returns 0 on success.
> The i40e, iavf and ice drivers treat any non-zero
> return as an error and drop the packet, causing valid packets to be
> dropped when Tx offload checking is enabled via EAL, e.g.:
>
>      -a 81:00.0,mbuf_check=offload
>
> Only reject the packet when the return value is not 0.
>
> Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
> ---
>   drivers/net/intel/i40e/i40e_rxtx.c | 2 +-
>   drivers/net/intel/iavf/iavf_rxtx.c | 2 +-
>   drivers/net/intel/ice/ice_rxtx.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index e29fcff661..ee70f7ce4f 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -1194,7 +1194,7 @@ i40e_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts
>   				break;
>   			}
>   
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>   				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>   				pkt_error = true;
>   				break;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4f2ffe6188..10d33660d9 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3813,7 +3813,7 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
>   				break;
>   			}
>   
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>   				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>   				pkt_error = true;
>   				break;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index c4b5454c53..3d98d821b2 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3669,7 +3669,7 @@ ice_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>   				break;
>   			}
>   
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>   				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>   				pkt_error = true;
>   				break;

-- 
Regards,
Vladimir


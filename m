Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C18BCA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 17:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E4F542DA6;
	Wed, 30 Sep 2026 19:13:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 416F242DCD
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790788381; x=1822324381;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=t//YCa6l2FzcvqZxhYyHrG+ifeTUWWn2QZOLpmvJu4k=;
 b=MqyXOpUSdYyqWReS4hV8XdqdwEUvCuzDT9EHzae8C6ks3o+nb/l3JMa6
 EbmJ9JqorQ7JqiiNV0RkAsk+nWQtu0cpQEZc96WXEb/uzw2nJD6CjJaAx
 YuuBxHnfVb1T9EiZT1Qn5OMMs8VWoLllvDZsgFDfEsl+URBJX4Op1uJxf
 YRT4T0jUfIFrNUB5AF5DwLNhvPML4WInkCT4tyt3gcmcWNMGl4/6cQjrG
 Snn6R37qdXffYt4eKoDfGcwF4Z8rDj+SGJ2T4SwOMK6TkZqoBdIfjBj2j
 FsWeaFbVo59r1qfeUaGUNXtMxHhGpxjpp3ZmcGQTARVprbEI8aGJvJ+p1 g==;
X-CSE-ConnectionGUID: MW//80OfTN+37hCXx97PaA==
X-CSE-MsgGUID: SQc4GSm4QO27ECW6cFrl0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90588951"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90588951"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 10:12:59 -0700
X-CSE-ConnectionGUID: jYkMlmSsRRy1+vFC9cedSA==
X-CSE-MsgGUID: plSetT5wQG6AuTPo+5r4JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="272190523"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 10:12:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 10:12:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 10:12:58 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 10:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVrhVDNBsUemhEVnTAQBGjGHzDEjTHDihBcEF8zHSMAhoG8CoX9srKqP5sgNihJ8tvCJQAF+1E5NdTeOdVKWGOp7MvYSuG6dGyu7xJM0WEx8RD79u4sh2Wmi2FTNX5una6Lpw1xIRsspI2AQzkkIXh+X/laWkqrM3sx0mLjKx6MExAGDFqUpQrXCiwn+bi5lC7x7v/URzAGCDQRLOxE0dTMFY0Ta4LyAQCbdZygOJR90GkvU5BKwohjgzHDBxiTPimU4/QKj3okCf60PV+Re4laaFKVjAKs2rQ0qN5T7x5kp8rTYOdrI7Z+F6CB5haWBFwIOnv6ZrGHgLLVyQf56RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP8Dglbdw4tkoVl2BsglHR2+NZDb1ZCbrbcAySfZpuw=;
 b=ZiPJcITPiwMsC7BCLwKIZoDBXxEaBOstfpKEhjBSYmaMpg5QG+wSZUeZ7ancGem1n0/2POWtsvCFXHYHUBV1DRQufqryZd+EsjipKq86Oif2D/BY5JJoqOVlFn3vKI0dkBlCu7PL0noK3o4xngTZYUcDkGjV+WFvcgJk+kJcfQZWDMTLq6hRgfQyBnfQq/Oyl7S4DoSaTlkI51zA7SWKBinQOADQFqRc4R5+YeRDSqTxY+iQ4KIHpFKPrq8ICf2DfCIBbq5+rt67H25Y04MJLA3D+aYOSVXsW2WiAvaYDrg1MEQ/AfTzxKoXLwySQnw0LfZhHr6HzADtYJTRD8iT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 17:12:53 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 17:12:53 +0000
Message-ID: <0d7b6397-3df9-4741-a052-fb8d06671307@intel.com>
Date: Wed, 30 Sep 2026 18:12:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk 1/2] rib: rename nxt flag parameter to mode
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20260518095900.29655-6-rjarry@redhat.com>
 <20260518095900.29655-7-rjarry@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260518095900.29655-7-rjarry@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::15) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ba20ac-2b63-4975-b3d0-08df1f161078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d+cJjH1TQRvihlyjP7yFQC1kQRP+k2ZrvK1JZWWkL5fRQdu2WnVBXuHJH3ksPz6A/GRJJzXDi3O/vnuHN2vlEWoPFdDHMpwPuRBbwShh8ydDO49MuTSblR6U3Nif5UnIX8KST7rG4x+TwJKmy2TCA0qb4FIgLxqw6KSr93QSIC7x5saFzfu1BkAbxEr8tQGl3oRnGrI/MwkUVUAuAN0Lq+E2gaLkqnpXRPxKuU7U7n5/abkSEwjbrkokviWfOFy+kBZzO2Wtwop0rDXi1AdJozQ5felayd+LA/cEhaErHnnzp1NQtEwe+/PPsB+sVJ6qdXP0c0H2kLCPa8844j+uIPaNPdn/J9Q+P/al+Z1txHxEEQN74pOUVknEHzLexWYS0RTW3uVLLvrSW40oQBEkclSH1R7Cvw5u/X4E9MLuhLyDS9SKEtrQ/wrmW68EiLX0fdZ1Rf+7zdGqygO/Sgrt9a0r/PJJ1r7zr/+dp5D0N0yamw7r1f7jvI50yxvoHGl1oPX+oJ6MvBRETOIE+0+32a1SU6MZznabLdlwZvsT9cQlu89yYAsKrLJKWW7QNS8vpvyZ5dvMLhZE8ZHuUWOjbsSNVimmOqijcNtoeN/x1V3ycl/+O2vSLoUdJh2woxsO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFdzZHRjVmZoUXNOaENIVVpSZjB0R2NDVHRucDQwbkVvVkFKVTJwOXd2cW1j?=
 =?utf-8?B?Tyt3M2UvR2JBQzJnclJJTUtZeUY4bEx3RUc2U0lCczdyVFg5NUdidnlZd081?=
 =?utf-8?B?VWNRT3h4UjQ1VHVWVTFUZHBibEY2d05DNnhUVlRRVy9zQk1uNGViY3U4elBz?=
 =?utf-8?B?ay8yRnoyMFN5ZjZwT0ZRb29GNk1TTk5RMm9iRUR4eGQra0pMcVZDdHpreVBH?=
 =?utf-8?B?RzRCdndiWUFOb2JTSS9JMlRsa1Boa0NacmVGQXpLUk9oTGRuUVhmRktXcFlX?=
 =?utf-8?B?dnd1OEVsYTJwSVFLUWJnZlVHaHQwWDNlMWwyd2tPNm14REJNdWxDUWU0bjZa?=
 =?utf-8?B?eUxKdXlZY24xL2NCdTkyZ2pGTlR2RW10NVFrbHpqaUY3eWVMSnRHNC9HUFlM?=
 =?utf-8?B?dE85Q1MrcjlsNFozdHNzQmJHNk94SXp3UW5SL1NDV3hDdnB1czFZWE5SVkhj?=
 =?utf-8?B?WTZmT3RGQzRXU2QraWNORWtGTGUyWkdOSTVrUEMwVlJpSnRRcHlqNHZQcmI1?=
 =?utf-8?B?UHdqc05CWXB6MWs3RGZ5ZG53YWN5dDJldjVPNEdQVGxRMUUxTEd5YXVHQWxq?=
 =?utf-8?B?Q21sTExlb0J5aVBQTDBYLzFQcGFKODloellzcitLV3N0UWRYNnNUbktMWFo5?=
 =?utf-8?B?Um9pWnEzbUM1ODZZV2xxSitYcW92SkVsamwrd0JmYVBLOXRoc1Y3R1BnWVM3?=
 =?utf-8?B?bGJLeW8xUjllbi82ckpvWkhSS1Q1TTc1T2I5T3VzYVlVdnMrR2NMVVY4Y2lh?=
 =?utf-8?B?TmMwd2UrSGhxeFR5UE9LNkJvMERmZ3lhTG9KTTdtRlYwRFhEd3o0M0ZtejZI?=
 =?utf-8?B?WnBrQmYxQ0dySjdXM2NjaFJRajhVOWdnMjFTbmlERWF0MzNNWUwwZDdFYnZ6?=
 =?utf-8?B?L1pHR251Rlh3OG0rSnhOV1V4QU9ESUZoeERXcWYwMkZ3OGprWVFqc0E1Ykd3?=
 =?utf-8?B?dDczL0ZLUWpqQXpPRDJ1WXpGSlZvRDVLVHVlelVrM1V5T09rdmFoWkdGeWI3?=
 =?utf-8?B?ekJUSTdURnF1QnNiditBZ3huSGtYdG55NWdZM2U1eEZ5UGE5ODgzOUpTcE1Z?=
 =?utf-8?B?TUw4aFFDN1hNMWpCTSttaGxPeXpnenloY0J2ZzZpeVYyWDJnTWlEOGdLRTgw?=
 =?utf-8?B?OWxlNEZsQTJZemV5dHg3OURxQnNmMVA0aTdzRlFjR0FaNHFNOGF5cG95eFo3?=
 =?utf-8?B?OEFvR0oyQ0hZZXNlT2hLV3h0UXhSc1A1RTJDOVdEbW92cDk4bEljS0plZFFC?=
 =?utf-8?B?cnB4em1kK3gwZ2prU20xWlVOVURjV0JFbjZpa01zWkJNQWFzNHkybkFzVzk4?=
 =?utf-8?B?MUNLNzRqZkRzRHdJcnAzSmxRdmwvR04zZzJxUHRteWpGbEl0K3k5eFYyenpB?=
 =?utf-8?B?cWRxM1A1cDkzWXJ6N2FOTUorS2p5Z1g3a0txMkxVdFNTWi9YSmNZTDJRYXVp?=
 =?utf-8?B?WDVORHZiRklXTHBScmhHZWtRclpiWGJqNVl0R29JZk8vTFJqT3FEemppUTNZ?=
 =?utf-8?B?aGlwM1U5aDlFT0VhNDE3ai9PV1h4bC8raDJlbWk2OVVpT01USHREbEwrWFBn?=
 =?utf-8?B?Lzl4M3NIdlFTeDhoNEIrZkUwSUk2SldmcFV4U1FBYjJJNllrdzJpRnozcWVP?=
 =?utf-8?B?SkRoR3JheEUyUzkyNkNWWkxsMXpqSmZhTDR4aXhUa1Q4dnhxVFdIVERrdGdM?=
 =?utf-8?B?cUZuaWNUa2Z0Um53U0tZbUltOW53NmpLUjRkNXR4bnozV1Vyd01pSEtxb0R6?=
 =?utf-8?B?Q3lkcEpCNUIrNTJQUENRbktsOUJxVEY5M3E0SSs4T3VJdHJxRkIrcHordHpX?=
 =?utf-8?B?enp5VDRoL1FqNFc3UmRINUNlR01saWIxNkxmL0U4a3NvM1VrQnptUDVWeTQz?=
 =?utf-8?B?MGdYZFdzSFdpUXkra0tEMnBIbEdyK09RMllldlJnNVhEeFBQNitZbmpEZFMy?=
 =?utf-8?B?WE4zM3RGRE8wL1FkQ0pQdXNlbDY4b211K1NkZ2FGa3Zhak0wNm4zMitoZTVF?=
 =?utf-8?B?RW1WTndya045MnBuSW9oNWFhelNjS1JwUWdnZjFLUjkxMVVMY0pFTHgxamZW?=
 =?utf-8?B?Y0tCekNwL2xSeTBrblhObUZrSnVRQkhoeEZxdy9QdGZCVGJxamtvSVZTeDZZ?=
 =?utf-8?B?ZmxQL01tV1EyMDc3S3VmT3J0ZXdmakxPa3NHRzRNdW9YQXY1WUt1b1REdnVF?=
 =?utf-8?B?U3E3ZUpQQ1Y4elA0OEl5UUE0aC9ObzlteTdteUpXak9YVk9INzgvZW9KSEZs?=
 =?utf-8?B?ajZmVVorb0dlUFRRVFJMek9DWWl6cUl4MlpJYlB4T1lhMDlDWXBlcVQvSEVE?=
 =?utf-8?B?VkNEajlFQmhSUUNmc3BjOC9NcDVza0ladW03N2ZJN2p3MVlGV1R0ZXVMRklC?=
 =?utf-8?Q?lH1Sd0Xs5urETM3Q=3D?=
X-Exchange-RoutingPolicyChecked: FTATsi+x/EqTeekhcXnALBQjkcIFMb70hUDLcCL9TI+RElKkoJNj0zj3tj8DD5hhWiC3aG11ExAqanBq6IVmO6+q0byYs5ITanDkYuXonzjvpikEVFdGJITa0o1C2bnmohPrhS5SeQWG6UMDw4pR1YJ+bL2fWr608IRctnSrYkm/6rOUBASuTXaIu6bV9EqgQ7b1lTzpSzVxnqrOVq3NgkHNqoYU0bxbdOzIvRdEUFmYcXr/DJB1R0sldIN6pes3DsCIY2rhSpti6QCOyL7z99a/GkE063Dt1rNLR8Y/FMRsUQaVuc7MS2s5om+RSasUAkOY32vSwe9hBqOIMKVsiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ba20ac-2b63-4975-b3d0-08df1f161078
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 17:12:53.7981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Okp4SaFtaEjcbeW41ZznE0pwgzdf11ec7ORtDq4+U/nnL8KgFpa07UcQpDNsV+wcfvVdMn0uZPDl8QqTz3XbjqCEcZD5UL8pamCR4pPP8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
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

Hi Robin,

As a general comment, do we really need these changes? ABI policy 
recommends not to do so

https://doc.dpdk.org/guides-26.07/contributing/abi_policy.html#abi-changes

" Change the API only for significant reasons, such as performance 
enhancements. Avoid API breakages due to changes such as reorganizing 
public structure fields for aesthetic or readability purposes."


On 5/18/2026 10:59 AM, Robin Jarry wrote:
> The flag parameter in rte_rib_get_nxt() and rte_rib6_get_nxt() is a
> plain int used as a typed enumeration. Give the anonymous enums proper
> names (rte_rib_nxt_mode, rte_rib6_nxt_mode) and rename the parameter
> from "flag" to "mode" to reflect its purpose.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>   lib/rib/rte_rib.c  |  4 ++--
>   lib/rib/rte_rib.h  | 12 ++++++------
>   lib/rib/rte_rib6.c |  4 ++--
>   lib/rib/rte_rib6.h | 14 +++++++-------
>   4 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
> index 046db131ca00..89061829a23c 100644
> --- a/lib/rib/rte_rib.c
> +++ b/lib/rib/rte_rib.c
> @@ -175,7 +175,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
>   struct rte_rib_node *
>   rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
> -	uint8_t depth, struct rte_rib_node *last, int flag)
> +	uint8_t depth, struct rte_rib_node *last, enum rte_rib_nxt_mode mode)
>   {
>   	struct rte_rib_node *tmp, *prev = NULL;
>   
> @@ -205,7 +205,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
>   				(is_covered(tmp->ip, ip, depth) &&
>   				(tmp->depth > depth))) {
>   			prev = tmp;
> -			if (flag == RTE_RIB_GET_NXT_COVER)
> +			if (mode == RTE_RIB_GET_NXT_COVER)
>   				return prev;
>   		}
>   		tmp = (tmp->left) ? tmp->left : tmp->right;
> diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
> index c325b3e3618c..0fabfb2a41a6 100644
> --- a/lib/rib/rte_rib.h
> +++ b/lib/rib/rte_rib.h
> @@ -26,11 +26,11 @@ extern "C" {
>   /**
>    * rte_rib_get_nxt() flags
mode instead of flags
>    */
> -enum {
> -	/** flag to get all subroutes in a RIB tree */
> +enum rte_rib_nxt_mode {
rte_rib_get_nxt_mode?
> +	/** get all subroutes in a RIB tree, excluding any exact match top-level route */
>   	RTE_RIB_GET_NXT_ALL,
> -	/** flag to get first matched subroutes in a RIB tree */
> -	RTE_RIB_GET_NXT_COVER
> +	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
> +	RTE_RIB_GET_NXT_COVER,
>   };
>   
>   struct rte_rib;
> @@ -120,7 +120,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth);
>    *   pointer to the last returned prefix to get next prefix
>    *   or
>    *   NULL to get first more specific prefix
> - * @param flag
> + * @param mode
>    *  -RTE_RIB_GET_NXT_ALL
>    *   get all prefixes from subtrie
>    *  -RTE_RIB_GET_NXT_COVER
> @@ -131,7 +131,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth);
>    */
>   struct rte_rib_node *
>   rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip, uint8_t depth,
> -	struct rte_rib_node *last, int flag);
> +	struct rte_rib_node *last, enum rte_rib_nxt_mode mode);
>   
>   /**
>    * Remove prefix from the RIB
> diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
> index ec8ff68e8700..c23881f6247e 100644
> --- a/lib/rib/rte_rib6.c
> +++ b/lib/rib/rte_rib6.c
> @@ -195,7 +195,7 @@ RTE_EXPORT_SYMBOL(rte_rib6_get_nxt)
>   struct rte_rib6_node *
>   rte_rib6_get_nxt(struct rte_rib6 *rib,
>   	const struct rte_ipv6_addr *ip,
> -	uint8_t depth, struct rte_rib6_node *last, int flag)
> +	uint8_t depth, struct rte_rib6_node *last, enum rte_rib6_nxt_mode mode)
>   {
>   	struct rte_rib6_node *tmp, *prev = NULL;
>   	struct rte_ipv6_addr tmp_ip;
> @@ -229,7 +229,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
>   				(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
>   				(tmp->depth > depth))) {
>   			prev = tmp;
> -			if (flag == RTE_RIB6_GET_NXT_COVER)
> +			if (mode == RTE_RIB6_GET_NXT_COVER)
>   				return prev;
>   		}
>   		tmp = (tmp->left != NULL) ? tmp->left : tmp->right;
> diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
> index d66d9e7c07c6..ed2761492bc8 100644
> --- a/lib/rib/rte_rib6.h
> +++ b/lib/rib/rte_rib6.h
> @@ -25,13 +25,13 @@ extern "C" {
>   #define RTE_RIB6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_RIB6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
>   
>   /**
> - * rte_rib6_get_nxt() flags
> + * rte_rib6_get_nxt() mode
>    */
> -enum {
> -	/** flag to get all subroutes in a RIB tree */
> +enum rte_rib6_nxt_mode {
rte_rib6_get_nxt_mode?
> +	/** get all subroutes in a RIB tree, excluding any exact match top-level route */
>   	RTE_RIB6_GET_NXT_ALL,
> -	/** flag to get first matched subroutes in a RIB tree */
> -	RTE_RIB6_GET_NXT_COVER
> +	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
> +	RTE_RIB6_GET_NXT_COVER,
>   };
>   
>   struct rte_rib6;
> @@ -179,7 +179,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
>    *   pointer to the last returned prefix to get next prefix
>    *   or
>    *   NULL to get first more specific prefix
> - * @param flag
> + * @param mode
>    *  -RTE_RIB6_GET_NXT_ALL
>    *   get all prefixes from subtrie
>    *  -RTE_RIB6_GET_NXT_COVER
> @@ -191,7 +191,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
>   struct rte_rib6_node *
>   rte_rib6_get_nxt(struct rte_rib6 *rib,
>   	const struct rte_ipv6_addr *ip,
> -	uint8_t depth, struct rte_rib6_node *last, int flag);
> +	uint8_t depth, struct rte_rib6_node *last, enum rte_rib6_nxt_mode mode);
>   
>   /**
>    * Remove prefix from the RIB

-- 
Regards,
Vladimir


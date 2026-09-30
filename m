Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17308CA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 17:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5729342DD6;
	Wed, 30 Sep 2026 19:13:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id EA21140E42
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:13:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790788393; x=1822324393;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=1M1jwRoF+a33LT/u8oqKLKHH3LvIBBzBpxn7gy3hlRQ=;
 b=QzOFFiDu+JIW/+EZrqlklkXL6XETNHYIwm3V3v+F7hM2sl/sqp+WRSdg
 IINBqyoTocn3+Ft9Bj8U5f0zwTdRfsthj1LQBYuUqANA6fQ6VFxkLODxr
 1148gW13Bo/0XII5NODkTJ+1XBY5RysXzPu/BpW831hduWev2Ajl7A0Cc
 baVWovzqhuHbJkWSvj9ViCN6ZbXa5hqomN6ZmZl8DLMHJz+ZFLy7nmiNh
 wCxw2IqSP2+3+QedKEXYHfUF7FG7rlbVJqjXBo4CWWy1/NbE+63dtCrYH
 tW1WE46lV00qB59T2JLDBZkoUoUczWUL382IVpxIXwBjlp1Ere1rc/Q/S w==;
X-CSE-ConnectionGUID: XNVwAGmPTFW9YGJsqcV52w==
X-CSE-MsgGUID: OyN1vc2gT2WTBfn6S9c4tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90588971"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90588971"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 10:13:10 -0700
X-CSE-ConnectionGUID: L63n31MbQRO82elTz/8b4A==
X-CSE-MsgGUID: gpUGjLPsTfqAa7szJpQ9wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="272190568"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 10:13:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 10:13:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 10:13:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 10:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M67qz1KyBH+qMj/uVpOxUAVRX1gWlpLsg/cUrZpTj9EDKLMHwjw1IaESxqWr5SJQkmBL9Rvmo3FksfamTa8wwP03fASZL370frjLdXRpnZMLuRavOKFPZ0zTBQRC7oIhDAZyvUkv7e9pajlI/qvPyxmNGR2G79kvhP4qtPXXeZopatUV01aEeIDHZMvKjG60xIrYRxBuQlvuOmc4Hd0xHxF/EmhT1zV4i38OMs5Zl9H6rw/M2AXPZCOTy/UmCiyT1vusyN2OiVZSXAt97gEbvmq4nwQGJsDq/wCx//cTBK5jyj7VIC/BYpg3G2mmngtfCspoKdDMZdFdRJ/vdmq5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6Jl2KZh6yBBTnPj4LDBb3eOeglcHaIP7fb12CkbI9o=;
 b=yz457+m7vbtQ81O7vd0keV9BwkrtorF4E3GLMYBGV4mR1QjAIHvhvdjEnTuLg+fysqqN78WZ4pHEi/oNoUjh6WhDuXNcxtenfJq9UnOWPDDx8g6NiBTX4bcj82IFYtZe0DGSy2xqjJpM8VK3EwT6HdJmVgh+28RDrOG1aOzZBShjKFDbmxPtw1QoYH0jSZj3xociCe4ajxMUKxGNCqEiXzhCqtOeuq0xVV8THIgFBmY03ZI4eqdFdISjhRFqFjttUAjOrHOVg+H832Rqk/ooWnzXZCSHsjjmHhqYblBQTvils1hI94qijJQyHs27ycj8y9In6gP6WxRWmkeZsfjNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 17:12:59 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 17:12:58 +0000
Message-ID: <f3fcf774-03fc-4693-986e-2684fb708bf8@intel.com>
Date: Wed, 30 Sep 2026 18:12:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk 2/2] rib: add mode to include top-level route in
 traversal
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20260518095900.29655-6-rjarry@redhat.com>
 <20260518095900.29655-8-rjarry@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260518095900.29655-8-rjarry@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::15) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d6c731-4c1d-460c-292d-08df1f161381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Och/1aGQDqt9F5aCLyLRYdePas1JmydziA44XNp+69iEgHqCnB4U5DBLlf07OuN+NpG+dDhrDfonOKyaz2L501/MlK2RMxdUjPnmxJfMC73+fhw7xZ6YxMASP2L6oaatlJ4Y8QEZPveUrIvf3gWwwH79voRdnw0PR9nrz1B2UQyugFbaOkatfij+zh8TwSInoWKjr//l2jNOFZiw2IRoft1/WyAqd5ROOUk+qjCx/5EK1VSHAQz6jGo64H50odCsNXDmdqiDWP+cvZSr/LLM1sCciscggGAxmk5cTtvlAxMxVrLatzX+F0GjemT9nrxFIICMip+g5YJX4GOgTiIFT+tAZPs13Q4w17Q6bfEfzPpqNZDY4/DfXo4IsHxlZfFEhLBcJwpQNICYI/xHbzu6sy/mTI0NmLx9GDrefXhnCmaJDy/hEE1GjGiKvwKmbBkQVaW0HAREZdEx6fLhgEVqQv+u9ClVt+sRxj7YkP8F/6VomMMSlN7mSOP2v9gErfASHTSfePVM7CKknMzVftLZFxtDwJ/PaffmuSZM9b8clONpn1dzjzl/dsalWloaLRCcw1LlgjYU4qq0bT6MKoTg0wuZz8mzU2v0ON1i+xopqP1qvJY5m/GRcc154MKJ5dAHmCnO+5YChFyhdwJ8Xx+pz5Z6mlbGNayETihoRCJmQBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NRUjZOcGpwbHNRUUNnUVpGNFVkNDFZdWxBV0x5aklXZFBCc2g1UFBOTkNr?=
 =?utf-8?B?Qk9nSGtyL054NG1aQXd2SHBnejZjcDg4dTFuUXg2VW5JNENWdlZESjNDVjRY?=
 =?utf-8?B?a3N5QWsvRzQydUZseEpaZ0ZvQ0gydjgwUEJ1NUdVTjh5WlAyVVJCUmd5SGxZ?=
 =?utf-8?B?Vkhqak82TUorM3hkNGtBSTUrUElBNWorYjlLODVJQUw2OEN1akpQUzdVWHVr?=
 =?utf-8?B?Z1ovVUorbjIvanVwWGtTT0FQbFU1bGFqM0xEdXVjZHg3eXBaOHRIdU51UmV4?=
 =?utf-8?B?MU5lV2Y4eHZ2aHcyQmxCZzBvQUlhRktoZXhEenVoemVnMURBYkpXM29ocmVP?=
 =?utf-8?B?YnROOXpheFpiNmRMckd2WCtjemRsN0h2RHdURFVPdWE2ekhvWElhclh1dWJM?=
 =?utf-8?B?N2ZGNUtHOU0wY0RoZnlnejNFRFQ5WEdDaXJIYng4NTFWN2g4NUtmR2Y1VmNN?=
 =?utf-8?B?TGVDeVQ3c3NyWjcxSnBrd1BKQXdiYk5XdnljT3FzelZTbUpoOGl4eEhkUFZE?=
 =?utf-8?B?em05VmNpLzdyaFQxbUw5OHJBbXYxRDNGL2NoSUVmRmJFZ1ZDd3NWR3ZFWU9I?=
 =?utf-8?B?R2o3cHBFazlBRGgzb1pTaS9Udk9XM2dOWkhmZ1lld2xGRWloWC95aVFxVUZF?=
 =?utf-8?B?QkJpTVJEazJrUmRnSjFrbExFRy8zMWhGMjNiSS9KMGFBYkowMEVjR0k4Yktk?=
 =?utf-8?B?REpCZ1Q3a2VsSUV3d1lBdUFsMTY4ZTVmWnhtM210QkFHNmRRNE5XOHdHUUQv?=
 =?utf-8?B?Nm90b1lxc3RUVmpycFc5V2V1Sy9YNTJGaFZZdTRMVmozdGNVSWxjSWFReTRK?=
 =?utf-8?B?YTZjelh1NE9QUHNDL3VrZzQvQktjTi9oN1lPUVhQWEE1S1hEV2tBVnB3QmNp?=
 =?utf-8?B?UmphZjkyaldQWWFERzJUNncvS2phcE9UTWZmaTloZ2xuR2U3ZEg1MzNhbndm?=
 =?utf-8?B?TzFtUU13OGs5SGdheXFsWXlqUEtoSG5MbFZnN1lZZUxRQWQvaHNyNm9UM0Y1?=
 =?utf-8?B?VDg4WGlIT2ZLRGFpbHhyY2J5QndYelQrV1Fqd0hMN2Z0QVBuVmV2NFJ4ZUU0?=
 =?utf-8?B?VnFtSUc4dHRJbE42UzBZbEtveG92RzhxMDJUdWlHM1dad24wODhtL3BPNXA2?=
 =?utf-8?B?SVo4bHcwVnIrRFRtSThzM1V5SG1MYWMzZlhVdHNzQ2puQzl3c2FPcldLL09n?=
 =?utf-8?B?NnV5SVBuUGhXSmhYaFh2TklDNmkxaHhtU0V0aFJ0NHFmc0lMVzR0Q0JJZjNM?=
 =?utf-8?B?Um4rdlJsY09Yaks0UkIzckZpOVY5STVsazJUcENYcHVhUzEyQ1hITm5xNmRm?=
 =?utf-8?B?VS9rUjkrVjZrSlFVNnBiMWV6YllpenF4QUhSZWo0WlArZWkzSG0raWcwOU9C?=
 =?utf-8?B?Rk41RnlVTWllQWlXUlIvTXZweC91UTFCV01nWFZPcUIrc1hOQVJ0UTBxU1RW?=
 =?utf-8?B?Y1d6VVlKYzBHdVVzeHhqRjhTdERqTHR6TklsblZiUGxxQzh4RFZvcGJJeDZw?=
 =?utf-8?B?ODMwckN5eEdaMVVVRG43RXJQWnlzVUVPZFZEeE1yaG5vNHBCUUducXRBelc1?=
 =?utf-8?B?d3BDcFhjVEk3d0haQ0FQcW5Xd21CcFdJQVp0aE9KYW1VVmRKbWY1dlBjNWV6?=
 =?utf-8?B?RE1GaUc1a0paSm1WWnFnQWFUc3pCOGcwWlp0Z2kzN3NZN0V1aldaVGw5MVVW?=
 =?utf-8?B?NjhWZVhtb2VQYWdMMFZNcXBOUjZvTUszMWt2VEc3ZDJTdlQxOURrU0drUFBm?=
 =?utf-8?B?MHpONXNKUGNqSnlTK1R6M3BEWHNuTUY5NDFiOHh6eDZqVzlkTmgwUUluZ0Vw?=
 =?utf-8?B?alNzbzdYMm1ZMFZvM0w1aktxcUx3T09waHVuTVlsY3AvTy9zVi9PV2Z0M0Nv?=
 =?utf-8?B?aTRQWHk0ckJRK0ZkSDFXUzRIQ3Q1OXF3YTBQYXB1Q3ZOcFVieStpejc4UFRD?=
 =?utf-8?B?NDE2VHhjYnJRcmxaMEI4ODdUOGJjc0hrTXZOKzZtK3hCckhWeUE0ZEV0ZDlk?=
 =?utf-8?B?QWRZR3BkNDlOamFDTUFKb2UvZ0lieXh2UGhucGI0RE9xeW9Nb0QrS1N2T1JT?=
 =?utf-8?B?Qjhvb2FPUmo4SGZoanYzektDekZjbG5oL2QwcDNzY0FHOXcwbzBYeUhsdGZH?=
 =?utf-8?B?TUt2cmdpTDZMbUxJcVJZaXAva3U0K0o3TUM1cWxIRytxNzdvWjNxYTJoUVlu?=
 =?utf-8?B?NXUrcVVlSHI0WDZkN1RNRDJ4RUtibU52cVFiVjdlYXNPUGRIYmJJaXJVLzlm?=
 =?utf-8?B?UXc5cjBHMzhCN2d1MFNrY05VWUVmZzVSZUZQOENHQlZhSnRON2k5YnVxVVVj?=
 =?utf-8?B?cUhUNFY2WkRDd1BoQS9URmZMK0pFQnZvMTY4Z083aVpMN25OK2gxVmFlUlNw?=
 =?utf-8?Q?325si5i4B20klHT0=3D?=
X-Exchange-RoutingPolicyChecked: AgVijps9XQyCPNVkxE/W/fC1qig1SgFhfrJGyOOMzlaJjPYKpUbXPuU7kwswZfHjY4UY6zWH0CVfwwJezP+65qnLZrcSqBs2A/MJMuNNBrFzZYTg/PqsVksEFVkoXDUnSdQ4V2w0ERT7bzeT7/ZgWtwBN+H5gOe6Nvdls1zxXMLZOuCNQVClsPX7YybIEyivbD9ntTNaKHLPfkWeBi9GfNJubLNh/RvGY6U8E3PSOYNKFOCXkU9iHwvh+dVi0nQiU0RtiEss62efHF/SVUZ0EdrdAGsLR4kyDPuf0q/VCoq5I0rI4+AuzKFz5YVtWWviLkruhQ29wQl7lSGhLL+7AQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d6c731-4c1d-460c-292d-08df1f161381
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 17:12:58.8848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2ek8+zAOfrSptrU5qq/NTmf7aTrT7KJwudUTIuL00fAmjV9JHjjFKp1WFU5ijaVbN8kKSkfQCN55ZMhEbj3MS2/uupn365+sWR9FmEShAM=
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

I'd suggest to reflect changes in release notes. Please find other 
comments inline.

On 5/18/2026 10:59 AM, Robin Jarry wrote:
> rte_rib_get_nxt() and rte_rib6_get_nxt() skip the exact match
> top-level route when iterating subroutes. This is the expected behavior
> in most cases but some users need the full subtree including the root.
>
> Add a RTE_RIB_GET_NXT_ALL_TOP (and RTE_RIB6_GET_NXT_ALL_TOP) mode
> that uses >= instead of > when comparing depths so that the top-level
> route is returned as well.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>   app/test/test_rib.c  | 16 ++++++++++++++++
>   app/test/test_rib6.c | 16 ++++++++++++++++
>   lib/rib/rte_rib.c    | 12 ++++++++++--
>   lib/rib/rte_rib.h    |  4 ++++
>   lib/rib/rte_rib6.c   | 12 ++++++++++--
>   lib/rib/rte_rib6.h   |  4 ++++
>   6 files changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/app/test/test_rib.c b/app/test/test_rib.c
> index a4a683140df3..f56490e67ec0 100644
> --- a/app/test/test_rib.c
> +++ b/app/test/test_rib.c
> @@ -300,6 +300,7 @@ test_tree_traversal(void)
>   	uint32_t ip1 = RTE_IPV4(10, 10, 10, 0);
>   	uint32_t ip2 = RTE_IPV4(10, 10, 130, 80);
>   	uint8_t depth = 30;
> +	unsigned int num;
>   
>   	config.max_nodes = MAX_RULES;
>   	config.ext_sz = 0;
> @@ -313,11 +314,26 @@ test_tree_traversal(void)
>   	node = rte_rib_insert(rib, ip2, depth);
>   	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
>   
> +	node = rte_rib_insert(rib, 0, 0);
> +	RTE_TEST_ASSERT(node != NULL, "Failed to insert default rule\n");
> +
>   	node = NULL;
>   	node = rte_rib_get_nxt(rib, RTE_IPV4(10, 10, 130, 0), 24, node,
>   			RTE_RIB_GET_NXT_ALL);
>   	RTE_TEST_ASSERT(node != NULL, "Failed to get rib_node\n");
>   
> +	num = 0;
> +	node = NULL;
> +	while ((node = rte_rib_get_nxt(rib, 0, 0, node, RTE_RIB_GET_NXT_ALL)) != NULL)
> +		num++;
> +	RTE_TEST_ASSERT(num == 2, "Invalid number of routes\n");
> +
> +	num = 0;
> +	node = NULL;
> +	while ((node = rte_rib_get_nxt(rib, 0, 0, node, RTE_RIB_GET_NXT_ALL_TOP)) != NULL)
> +		num++;
> +	RTE_TEST_ASSERT(num == 3, "Default route not returned by rte_rib_get_nxt\n");
> +
>   	rte_rib_free(rib);
>   
>   	return TEST_SUCCESS;
> diff --git a/app/test/test_rib6.c b/app/test/test_rib6.c
> index 0295a9640cfa..542c955eee8c 100644
> --- a/app/test/test_rib6.c
> +++ b/app/test/test_rib6.c
> @@ -300,7 +300,9 @@ test_tree_traversal(void)
>   	struct rte_ipv6_addr ip = RTE_IPV6(0x0a00, 0x0282, 0, 0, 0, 0, 0, 0);
>   	struct rte_ipv6_addr ip1 = RTE_IPV6(0x0a00, 0x0200, 0, 0, 0, 0, 0, 0);
>   	struct rte_ipv6_addr ip2 = RTE_IPV6(0x0a00, 0x0282, 0, 0, 0, 0, 0, 0x0050);
> +	struct rte_ipv6_addr unspec = RTE_IPV6(0, 0, 0, 0, 0, 0, 0, 0);
>   	uint8_t depth = 126;
> +	unsigned int num;
>   
>   	config.max_nodes = MAX_RULES;
>   	config.ext_sz = 0;
> @@ -312,11 +314,25 @@ test_tree_traversal(void)
>   	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
>   	node = rte_rib6_insert(rib, &ip2, depth);
>   	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
> +	node = rte_rib6_insert(rib, &unspec, 0);
> +	RTE_TEST_ASSERT(node != NULL, "Failed to insert default route\n");
>   
>   	node = NULL;
>   	node = rte_rib6_get_nxt(rib, &ip, 32, node, RTE_RIB6_GET_NXT_ALL);
>   	RTE_TEST_ASSERT(node != NULL, "Failed to get rib_node\n");
>   
> +	num = 0;
> +	node = NULL;
> +	while ((node = rte_rib6_get_nxt(rib, 0, 0, node, RTE_RIB6_GET_NXT_ALL)) != NULL)
second arg should be &unspec
> +		num++;
> +	RTE_TEST_ASSERT(num == 2, "Invalid number of routes\n");
> +
> +	num = 0;
> +	node = NULL;
> +	while ((node = rte_rib6_get_nxt(rib, 0, 0, node, RTE_RIB6_GET_NXT_ALL_TOP)) != NULL)
same here
> +		num++;
> +	RTE_TEST_ASSERT(num == 3, "Default route not returned by rte_rib6_get_nxt\n");
> +
>   	rte_rib6_free(rib);
>   
>   	return TEST_SUCCESS;
> diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
> index 89061829a23c..a3c287e215ec 100644
> --- a/lib/rib/rte_rib.c
> +++ b/lib/rib/rte_rib.c
> @@ -167,6 +167,14 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   	return __rib_lookup_exact(rib, ip, depth);
>   }
>   
> +static bool
> +depth_match(struct rte_rib_node *node, uint8_t depth, int flag)

3d arg enum rte_rib_nxt_mode mode?

> +{
> +	if (flag == RTE_RIB_GET_NXT_ALL_TOP)
> +		return node->depth >= depth;
> +	return node->depth > depth;
> +}
> +
>   /*
>    *  Traverses on subtree and retrieves more specific routes
>    *  for a given in args ip/depth prefix
> @@ -195,7 +203,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
>   			tmp = tmp->parent;
>   			if (is_valid_node(tmp) &&
>   					(is_covered(tmp->ip, ip, depth) &&
> -					(tmp->depth > depth)))
> +					(depth_match(tmp, depth, mode))))
extra parenthesis, same for v6
>   				return tmp;
>   		}
>   		tmp = (tmp->parent) ? tmp->parent->right : NULL;
> @@ -203,7 +211,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
>   	while (tmp) {
>   		if (is_valid_node(tmp) &&
>   				(is_covered(tmp->ip, ip, depth) &&
> -				(tmp->depth > depth))) {
> +				(depth_match(tmp, depth, mode)))) {
>   			prev = tmp;
>   			if (mode == RTE_RIB_GET_NXT_COVER)
>   				return prev;
> diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
> index 0fabfb2a41a6..5e72fa9273e2 100644
> --- a/lib/rib/rte_rib.h
> +++ b/lib/rib/rte_rib.h
> @@ -31,6 +31,8 @@ enum rte_rib_nxt_mode {
>   	RTE_RIB_GET_NXT_ALL,
>   	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
>   	RTE_RIB_GET_NXT_COVER,
> +	/** get all subroutes in a RIB tree, including the exact match top-level route, if any */
> +	RTE_RIB_GET_NXT_ALL_TOP,
>   };
>   
>   struct rte_rib;
> @@ -125,6 +127,8 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth);
>    *   get all prefixes from subtrie
>    *  -RTE_RIB_GET_NXT_COVER
>    *   get only first more specific prefix even if it have more specifics
> + *  -RTE_RIB_GET_NXT_ALL_TOP
> + *   get the top-level exact matching prefix, if any

RTE_RIB_GET_NXT_ALL_TOP is effectively RTE_RIB_GET_NXT_ALL + exact 
match. Better definition would be something like:

get all prefixes from the subtrie, including the ip/depth prefix itself 
if present. Top prefix is returned last.

>    * @return
>    *  pointer to the next more specific prefix
>    *  NULL if there is no prefixes left
> diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
> index c23881f6247e..5114fb522e3e 100644
> --- a/lib/rib/rte_rib6.c
> +++ b/lib/rib/rte_rib6.c
> @@ -186,6 +186,14 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
>   	return NULL;
>   }
>   
> +static bool
> +depth_match(struct rte_rib6_node *node, uint8_t depth, enum rte_rib6_nxt_mode mode)
> +{
> +	if (mode == RTE_RIB6_GET_NXT_ALL_TOP)
> +		return node->depth >= depth;
> +	return node->depth > depth;
> +}
> +
>   /*
>    *  Traverses on subtree and retrieves more specific routes
>    *  for a given in args ip/depth prefix
> @@ -219,7 +227,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
>   			tmp = tmp->parent;
>   			if (is_valid_node(tmp) &&
>   					(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
> -					(tmp->depth > depth)))
> +					(depth_match(tmp, depth, mode))))
>   				return tmp;
>   		}
>   		tmp = (tmp->parent != NULL) ? tmp->parent->right : NULL;
> @@ -227,7 +235,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
>   	while (tmp) {
>   		if (is_valid_node(tmp) &&
>   				(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
> -				(tmp->depth > depth))) {
> +				(depth_match(tmp, depth, mode)))) {
>   			prev = tmp;
>   			if (mode == RTE_RIB6_GET_NXT_COVER)
>   				return prev;
> diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
> index ed2761492bc8..1d8b56b89b13 100644
> --- a/lib/rib/rte_rib6.h
> +++ b/lib/rib/rte_rib6.h
> @@ -32,6 +32,8 @@ enum rte_rib6_nxt_mode {
>   	RTE_RIB6_GET_NXT_ALL,
>   	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
>   	RTE_RIB6_GET_NXT_COVER,
> +	/** get all subroutes in a RIB tree, including the exact match top-level route, if any */
> +	RTE_RIB6_GET_NXT_ALL_TOP,
>   };
>   
>   struct rte_rib6;
> @@ -184,6 +186,8 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
>    *   get all prefixes from subtrie
>    *  -RTE_RIB6_GET_NXT_COVER
>    *   get only first more specific prefix even if it have more specifics
> + *  -RTE_RIB6_GET_NXT_ALL_TOP
> + *   get the top-level exact matching prefix, if any
>    * @return
>    *  pointer to the next more specific prefix
>    *  NULL if there is no prefixes left

-- 
Regards,
Vladimir


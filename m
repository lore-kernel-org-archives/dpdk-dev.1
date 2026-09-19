Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDBAC982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22FD140684;
	Sat, 19 Sep 2026 18:10:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id 5D1BD4069F
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834204; x=1821370204;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=El9R6VcAISeNATlgr0ox4WNUFAkSNzhuq+TK203ed8I=;
 b=eiaBsLpVi26EKIEKMoPtHjwnjjK0OSIkoYf8YhdYJQhpKaHflSOOQnKj
 nv50bwdSxrEhoS5U1sukoolN31GZha9z6QPvzH7B1baam3dmgm2ZmhN1L
 D6Z2/dKgswzkEPNET2ZO10rrVsrVUEyhtYkG7xFxmqA7KSBZLx3Z0sdYz
 0oCpXfVp3pknxJwrdx4daTEu59HJiBD2bDeCYoyEoRupj+W5FIKb0/GPX
 KWOoB/eCROIX2oFPhwSoiBdbtH0J+wcf+xbKDW63qG8ByR3UdXviD+sui
 A+G/ToHlEGigKs+lbSQeozyPuPMpviuvM+VREQpnefE7PLsDjG+msjyIc g==;
X-CSE-ConnectionGUID: Z/iP6v/kSkuz/5HeSs+/Cw==
X-CSE-MsgGUID: 1p4sQdMJTH++gAfm7etQuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="861512"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="861512"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:03 -0700
X-CSE-ConnectionGUID: 0ZWslcTpQ/KhguqD3cE5Tw==
X-CSE-MsgGUID: mW58G/gGROOjDhsh1clhVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3062264"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:10:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGItJGeFrRdZNqf1iSKIxbp0rB929WTNEWmRnlQ35WY7r3u17gIDciNf+zh+fMq/RWechOuAegFeaaIqzp1zDW+GamJdaUWhLS/ci3TPWSisKcLcPseHouZqLfhwxA/U72zvOHgjXoDY57WmsTWvPnTcfh5kC/HcHNICM+DNAWrmxHbYWzJZakcR4AKQYgtQOYsmweD62IlXAEcZF/RHnQndhZmCDUPTqI5G510jrjauwyTIOdrIM6oLBHtoVGAfMrqH8JFITTx+EgPPBs3w9WpNHCYAeoOzVo/hYyjg4KUq8niVVSE66FruoBJwCWycqyHEA8lqxfCZhZtkLAEIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eve5DUMWQDJngcgQC/oIZfFvzhiCWcgLaBCzUOJSYIQ=;
 b=tcb24ugNl55AakGcNRk/02DGJul2O6IF8svvDQLM+dAT/ymOWVGF0X4i1G+CAbzhTDfNfXW2Tqt1I1H2Y1VLCCn2ep96x47yw+P/LPCTJRKFlEk1MP6QOe04TlZXY94OEqmAaR6oME6xR8YXTgcfp0YHe9qMh7pSVHH4t7TRxTGzJCu3nUT8OxvpzHcLU7lHP6fzoYYERahzz81kpcj8U2udq2fyAVWfF6EMXvXivBmnf3T0YiENbHnMnQ2oJFIgLUZAlYyoHRu6uHMXuaevHfdCKOduWTJh3rYPbxCVb/VOIrkf/gEXEf5TnHzY3ctoOUrZMfmGPJ1GjZ3YYOEg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:09:59 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:09:59 +0000
Message-ID: <d5816959-01bf-4204-ade8-45eb9a0790df@intel.com>
Date: Sat, 19 Sep 2026 17:09:57 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 04/19] net/ixgbe: add support for common flow parsing
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <59c9c34e52af32f061d747086d301cf01f091c58.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <59c9c34e52af32f061d747086d301cf01f091c58.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::16) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: d5df88bc-c9f6-4dd9-b13b-08df1668744c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qAxAKkzX/wO8OZ0OW5c8dUBduYMPrPFnWd4geW7YfEoQInbabL4Q5tllGNYX6TvIyqjwh0zPwH2MkzSiG3pgvJ8TXxql4dJ465Y8+VLkVHaAkbJijwxY6a63PWG4jTQSEBh44hTdrCIFoFlFE5Mfy/iWQTIc2ite3yvUJyntjvtOWb4SN+ctHnREiCGtCliiHD63Ph9wVTJoZjbWTDZEi8x6LZTRnE8dKwvWP9ccW00EaGC0moqxFfeOVuhpdp2kockWHzIsH2eXuDyw5arTRnWLZoNLOBp6iAPwgJVfmQhF7Z/eknjwu/p8hjjvxpCpGiQGLfWijMwoJ1W86CggD7PwGfrtsZ6J/vb3WVAtyq0V4bBLWwhLnb0/FIws6g7zVnPH4yZm+27/FCuJYmhF+6W6BnCaJZ+8wU7PeSoTCPkKdNq2ZRPsSEFisAVsvSJG4Cvl1F+ANSW2CusC+YeJaeKtZFK1htOYoiPdB3oyKVz0MC0kgNYzlrQDd9jT4sGSqkKwORMml9aAedaeYhq7yxgLgezYy8PFrd+TC/lRP9L0Choh1srGquad3cagt3PiSMiibjPSOjIj9fBau1gksa1BgMs75+m3NMcW/yj+KuPwJNWv/fmBpsLgoGD/XYRe9QoD9EI4n9LhQh0nXzjgs6S1nuF4y5Ptgvq/hhzbU3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNSc055MXNKdkJPQk4zdVBQYitXMmcxYmtlcnU3WEYzR3BiWkRyV0VNSDQw?=
 =?utf-8?B?aWFEUW1takV3R21mMGlGYlR4U3R3WXFMUUMzQzdWQ25mNTR5U0RLOTFnSjZY?=
 =?utf-8?B?SkxSQlhBRU9GTExxU2JWeGkwTTNZNHppZjdFaWZIamh2RW93VUs0MStYbWRP?=
 =?utf-8?B?K1FubWVTa2lXdGlSTUM1Uk1SNERSL1pIQ0w5T3liQXBUSG1JMVhVMk92NlhD?=
 =?utf-8?B?ZkJDQjhNU1o0VU1wQkFZNnNzUUtlYXFuVzdSZ0RDcnAyYXJSem0vZk9wRkw3?=
 =?utf-8?B?VmdlSm11cDJxVmk4VVl3QURTTjYvVmRZQVZjQ0tMVGk3RjdFejVsZjNMR0Ux?=
 =?utf-8?B?NS93SHA4Rm5DY3kzL3R2aHFSQy9RM2xwcEVYZmN6ZW1SaGc5THFKalFNdkFM?=
 =?utf-8?B?WjZzVEVVUGJETkVJRHV3ZS9OMjFoTnRZdGFSYTEwb1AzcE5FLzJ6Yk00Ym43?=
 =?utf-8?B?ZlhGTVRvNmpBUkI4SlFqcnB0NGxHaVRJUDh3RUZ1ZEtiQW1udjFEcHhoWUhW?=
 =?utf-8?B?Q0Jma0VQRm85TFJCbEl2VVIxcmhSQjQwK3ppcXNjNExUVmM4THFCU3FUWW1x?=
 =?utf-8?B?d2UwMENEaEUxaTEvR2ZPMjVVU0wxZ0hOMmliU2hJQ1M4ZElwQ3BpY3F5Qzd6?=
 =?utf-8?B?MGptdS92Z3VVbmZHcjhscG8yME1RY0JTaFJGS0NHRnViM3NRQUJzWlgrbXlp?=
 =?utf-8?B?V1dJR0srRitKWnlkU3ZCSnFzZTQwb1BXaWpSMDBvMlR2aitLUjFsR29Xa29t?=
 =?utf-8?B?REZuR1hsQTBtcVlGSFRYMVdLT2QweHl2UDh3dEhZM1VSbWVwelF3ajFVU0ZH?=
 =?utf-8?B?YXZnNHNlUENVK0E0Q2VwUnFsZWpxcEJzaTRwL05vdVZ0NHg1em8xOFk1RUF5?=
 =?utf-8?B?RHB2VzdnaUF3aVlKeGNLMjhDSUVXRExPTTBQbGVuZS9jdlUrNnUzQzJrRDd2?=
 =?utf-8?B?Yk11V2p5UmtUOGNCL3liTEhGcHVBRUtkRTE5cllsRnYwWiswbDVrK2R6bEl0?=
 =?utf-8?B?eXZwanZtcVFjRHl2Y3FDYmdwNEpGUHF6MzZkbFJNTXNTbnVKcjRqV0pQSlNJ?=
 =?utf-8?B?RnYwcWRvWUxrNmVJVVVLUVhQTGtmUjR4bm5HUCtvR2NSOWtOM1dpS3VoQnFl?=
 =?utf-8?B?eDdubVl1SnZJWVhpTThSa0N6LzdYdzhZdkVlejVpZzdGRThPdUpic0V2OVM0?=
 =?utf-8?B?c0lqMGYvMjNqSk5NWkdkNlNFTTRiU0xqL09nRitLdWJVaGJyUTRBTTJaZE5n?=
 =?utf-8?B?L0l5VUdYZmswdExVVk10RGhGYUh0VnM5RzNoQ09HUkI1bEROTklES1Z0eU5I?=
 =?utf-8?B?Y1paVkdiRW5MaUp6QU91RmRJWFJxaEVsVkJld1R5Nk92VG5NRW9kNGthTlNh?=
 =?utf-8?B?TEpmYXFXaTJiYzlXNTRjbnRyVGVWWUtVd1VERlBMcWJpdTRVOHg1WmowQWJU?=
 =?utf-8?B?TG5zWFBEMWpiTXJRRnl6SlhSVXMwSUFMcFJOdFprVDFIYXNzS2J2RnV6bkwx?=
 =?utf-8?B?WTZLcTkwOHRGZlRXOTQwdEJiTHdGWWJGTGdGZnF6VGZpNkh1eUVDNGJDVzI0?=
 =?utf-8?B?NGVHVm8wUWFVWWRKdmRxNGxIMmdxNEhvODRMVno4ZDh0UlRidDlicTQvbDFL?=
 =?utf-8?B?bzc3aXhvdGVqakVkNDYvRmI0REl3ZUxoeUFUeUtIODROZ2QxTTF4eVRDV0cz?=
 =?utf-8?B?Vnc5Z21yd0VwZGlCampPWkVoU25zTzdUNVp2MThIQzJtcjdnYitLOUVHN2Rs?=
 =?utf-8?B?S1JxNVkwUlM5WjNBMzJNMkdhWHlGZTd1bHEwVVJETExwTEY0a0dvUEpZQk5t?=
 =?utf-8?B?NHdmVzEyNDFQaC9YTEFOWWlhOFcyRDlDOVoxUWl3cDBxRVRwRWJFejQxVXBL?=
 =?utf-8?B?eUVQRTBQdFg2MjljcnZRZkRJK2s1TkpmRk1kK0JqQS9Xc1pBWmU2N3NpU01o?=
 =?utf-8?B?ZjZtSFU0WDZMcHRUNUdVNlI3Zk5SR2cwWVBlWkVjbGFtTlhIMlh1M0dHOU0v?=
 =?utf-8?B?QlNEckg3eDR6a3JPSnhnVFZnZWZkRnFJUFpjejNWb2x2YTU2SGN1LzB6T0tX?=
 =?utf-8?B?V0t1SGU3N25QRytVWDlyYlY0UVp6N3ZGOUVMV3p0WmNLZmVSU3g0SklZYXJF?=
 =?utf-8?B?eUVwVFFYVzJ3ZE9VNWxBVCtiWWZLMlJzbFZlQUttUG03VzhjeGh4T0k2TGNC?=
 =?utf-8?B?WHFqeW81TUtPREk4MndUYzZRVnJOcWpQYlJPYnZVSVVpYTFvR0w1cnNvQTg5?=
 =?utf-8?B?eCs4RkxWMS9Ob3Y4b0VFRGNFUm90NG56RE8za1EvSlFyMGtvVUN4R0Q4THhC?=
 =?utf-8?B?a3ZyK1NOKzcrclpIQ0xKVWZRd1pNMUZtUEV6M3owTVo0a0lzdnBWeFM0ZXhX?=
 =?utf-8?Q?2Pmz3R+ug0qLRcVU=3D?=
X-Exchange-RoutingPolicyChecked: udpLIb+n/sTOh1WezFfCs+Eb1vvqcBPeFxcvC6O0ImyU7VYvZblk9rD/er+mdvwZTZ+wWsoh5YMcJpvc8zMjGkv1+AFWhR65k8VjIjikSmg/O+W22S+WVrrJ5+e9HvNn3kKAoGuqSbpABf4T+82FC1wul0Wk+teVspr/pKInm5sb2DNpU9b2krumzUI9BkrDdgE13WyIzUKJIqqUZoK67FwsOp/RBn0Ep8u7UpoiJzRJji5xUuMOQ3aWzjA95oY1AugnpxMOGvVxuDIdsVCLRAezUxqF2yCHFZkrvv36hvF10VBbUYwORgEPadcMV9YPFfQzu9TR2d2yEkxw+lBFiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5df88bc-c9f6-4dd9-b13b-08df1668744c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:09:59.4931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L77dwJom3Ab/txoPYDZImjOnJRe0cus1Ptx85WtGRb7UzJsRn1dRbe3jRGjVhGoFdpVLpWolyYCl3fBxuO9Btb9WZAqGhE37AzLwx9IngRw=
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Implement support for common flow parsing infrastructure in preparation for
> migration of flow engines. The following features are enabled:
>
> - Conf init on dev_init
> - Conf uninit on dev_close
> - Flow cleanup on dev_close
> - Flow replay on dev_start
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_ethdev.c | 22 ++++++++++-
>   drivers/net/intel/ixgbe/ixgbe_ethdev.h |  5 +++
>   drivers/net/intel/ixgbe/ixgbe_flow.c   | 54 +++++++++++++++++++++++++-
>   drivers/net/intel/ixgbe/ixgbe_flow.h   | 12 ++++++
>   4 files changed, 90 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow.h
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index fc3a02c7d98..48cf608aebb 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -46,6 +46,7 @@
>   #include "base/ixgbe_phy.h"
>   #include "ixgbe_osdep.h"
>   #include "ixgbe_regs.h"
> +#include "ixgbe_flow.h"
>   
>   /*
>    * High threshold controlling when to start sending XOFF frames. Must be at
> @@ -1373,6 +1374,12 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
>   	if (ret)
>   		goto err_l2_tn_filter_init;
>   
> +	/* initialize flow engine configuration */
> +	ret = ci_flow_engine_conf_init(&ad->flow_engine_conf,
> +			&ixgbe_flow_engine_list, eth_dev->data);
> +	if (ret)
> +		goto err_flow_engine_conf_init;
> +
>   	/* initialize flow filter lists */
>   	ixgbe_filterlist_init(eth_dev);
>   
> @@ -1384,6 +1391,8 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
>   
>   	return 0;
>   
> +err_flow_engine_conf_init:
> +	ixgbe_l2_tn_filter_uninit(eth_dev);
>   err_l2_tn_filter_init:
>   	ixgbe_fdir_filter_uninit(eth_dev);
>   err_fdir_filter_init:
> @@ -2949,6 +2958,9 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
>   	if (macsec_setting->offload_en)
>   		ixgbe_dev_macsec_register_enable(dev, macsec_setting);
>   
> +	/* re-install kept flows to hardware */
> +	ci_flow_replay(&adapter->flow_engine_conf);
> +
>   	return 0;
>   
>   error:
> @@ -3128,8 +3140,8 @@ ixgbe_dev_set_link_down(struct rte_eth_dev *dev)
>   static int
>   ixgbe_dev_close(struct rte_eth_dev *dev)
>   {
> -	struct ixgbe_hw *hw =
> -		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	struct ixgbe_adapter *ad = dev->data->dev_private;
> +	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ad);
>   	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
>   	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
>   	int retries = 0;
> @@ -3196,6 +3208,12 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
>   	rte_free(dev->security_ctx);
>   	dev->security_ctx = NULL;
>   
> +	/* drop all flows */
> +	ci_flow_cleanup(&ad->flow_engine_conf);
> +
> +	/* reset flow engines */
> +	ci_flow_engine_conf_reset(&ad->flow_engine_conf);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> index fd3236fda24..fe3790b9f49 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> @@ -22,6 +22,8 @@
>   #include <bus_pci_driver.h>
>   #include <rte_tm_driver.h>
>   
> +#include "../common/flow_engine.h"
> +
>   /* need update link, bit flag */
>   #define IXGBE_FLAG_NEED_LINK_UPDATE (uint32_t)(1 << 0)
>   #define IXGBE_FLAG_MAILBOX          (uint32_t)(1 << 1)
> @@ -346,6 +348,7 @@ struct ixgbe_l2_tn_info {
>   };
>   
>   struct rte_flow {
> +	struct ci_flow flow;
>   	enum rte_filter_type filter_type;
>   	/* security flows are not rte_filter_type */
>   	bool is_security;
> @@ -492,6 +495,8 @@ struct ixgbe_adapter {
>   	struct rte_timecounter      tx_tstamp_tc;
>    	struct ixgbe_tm_conf        tm_conf;
>   
> +	struct ci_flow_engine_conf flow_engine_conf;
> +
>   	/* For RSS reta table update */
>   	uint8_t rss_reta_updated;
>   
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 80d9147acf4..6c2f7d591e4 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -47,7 +47,8 @@
>   #include "rte_pmd_ixgbe.h"
>   
>   #include "../common/flow_check.h"
> -
> +#include "../common/flow_engine.h"
> +#include "ixgbe_flow.h"
>   
>   #define IXGBE_MIN_N_TUPLE_PRIO 1
>   #define IXGBE_MAX_N_TUPLE_PRIO 7
> @@ -93,6 +94,8 @@ struct ixgbe_flow_mem {
>   	struct rte_flow *flow;
>   };
>   
> +const struct ci_flow_engine_list ixgbe_flow_engine_list = {0};
> +
>   /**
>    * Endless loop will never happen with below assumption
>    * 1. there is at least one no-void item(END)
> @@ -2832,6 +2835,13 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
>   	struct ixgbe_rss_conf_ele *rss_filter_ptr;
>   	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
>   
> +	/* try the new flow engine first */
> +	flow = ci_flow_create(&adapter->flow_engine_conf, attr, pattern, actions, error);
> +	if (flow != NULL)
> +		return flow;
> +
> +	/* fall back to legacy flow engines */
> +
>   	flow = rte_zmalloc("ixgbe_rte_flow", sizeof(struct rte_flow), 0);
>   	if (!flow) {
>   		PMD_DRV_LOG(ERR, "failed to allocate memory");
> @@ -3015,6 +3025,7 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
>   		const struct rte_flow_action actions[],
>   		struct rte_flow_error *error)
>   {
> +	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>   	struct rte_eth_ntuple_filter ntuple_filter;
>   	struct rte_eth_ethertype_filter ethertype_filter;
>   	struct rte_eth_syn_filter syn_filter;
> @@ -3023,6 +3034,13 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
>   	struct ixgbe_rte_flow_rss_conf rss_conf;
>   	int ret;
>   
> +	/* try the new flow engine first */
> +	ret = ci_flow_validate(&ad->flow_engine_conf, attr, pattern, actions, error);
> +	if (ret == 0)
> +		return ret;
> +
> +	/* fall back to legacy engines */
> +
>   	/**
>   	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
>   	 */
> @@ -3094,6 +3112,13 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
>   	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
>   	struct ixgbe_rss_conf_ele *rss_filter_ptr;
>   
> +	/* try the new flow engine first */
> +	ret = ci_flow_destroy(&adapter->flow_engine_conf, flow, error);
> +	if (ret == 0)
> +		return 0;
> +
> +	/* fall back to legacy engines */
> +
>   	/* Validate ownership before touching HW/SW state. */
>   	TAILQ_FOREACH(flow_mem_base, &adapter->flow_list, entries) {
>   		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
> @@ -3197,8 +3222,16 @@ static int
>   ixgbe_flow_flush(struct rte_eth_dev *dev,
>   		struct rte_flow_error *error)
>   {
> +	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>   	int ret = 0;
>   
> +	/* flush all flows from the new flow engine */
> +	ret = ci_flow_flush(&ad->flow_engine_conf, error);
> +	if (ret) {
> +		PMD_DRV_LOG(ERR, "Failed to flush flow");
> +		return ret;
> +	}
> +
>   	ixgbe_clear_all_ntuple_filter(dev);
>   	ixgbe_clear_all_ethertype_filter(dev);
>   	ixgbe_clear_syn_filter(dev);
> @@ -3318,6 +3351,25 @@ ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
>   	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>   	struct ixgbe_filter_ele_base *flow_mem_base;
>   	bool found = false;
> +	int ret;
> +
> +	/* try the new flow engine first */
> +	ret = ci_flow_dump(&ad->flow_engine_conf, flow, file, error);
> +
> +	/*
> +	 * There are multiple possible situations here:
> +	 *
> +	 * - User requested to dump all flows
> +	 * - User requested to dump a specific flow
> +	 *
> +	 * For the first case, we keep going because legacy engines might still
> +	 * have flows we want to dump.
> +	 *
> +	 * For the second case, we only stop if the flow we were asked to dump
> +	 * was found in the new engines, otherwise we keep looking.
> +	 */
> +	if (flow != NULL && ret == 0)
> +		return 0;
>   
>   	TAILQ_FOREACH(flow_mem_base, &ad->flow_list, entries) {
>   		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
> new file mode 100644
> index 00000000000..5e68c9886c1
> --- /dev/null
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Intel Corporation
> + */
> +
> +#ifndef _IXGBE_FLOW_H_
> +#define _IXGBE_FLOW_H_
> +
> +#include "../common/flow_engine.h"
> +
> +extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
> +
> +#endif /*  _IXGBE_FLOW_H_ */

-- 
Regards,
Vladimir


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB0CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4759040612;
	Sat, 10 Oct 2026 20:33:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4E224400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657184; x=1823193184;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=JKj0MHyE2VaMsjtz9DpJrQemtaQl7jPmzvZXvmBSSrs=;
 b=hqv+B5hLUEDY+AnxKo80/ewQe10ojeazxaEOCjsuiwldyVhFf6ERPj+B
 d6H5b4wb+wNLEDJChipQMwFlq97oyOWiIE3iNrMz1ntf1lyA+UIaZPEXo
 6RYAxwlqB6+UD6P/l9tOkV66unHfF6/907gYw5oZLxRcKVuZd6dRVldXv
 iTruwa3K99SBKzS6xgX0ZjVrEzP25a8qinOYSdOBLm6YuS5JVVUELIu0x
 812ROcKweUnMBnu33A0Yp31iJHoq/c7qEb4mxlDsxdjFIEiwyjLPv6xh/
 cqSaRhrYirtXhT/NtQQX2p5foRUsdbszGK1j/gsWjvOMVpopnIbK3P2Lu Q==;
X-CSE-ConnectionGUID: sqfum6A0RTal0UJ/vRxv4Q==
X-CSE-MsgGUID: AHi6FEeZTQmL4pabsErn2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="305079"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="305079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:33:03 -0700
X-CSE-ConnectionGUID: FFrw2PnmS6WkFlh+bDprNg==
X-CSE-MsgGUID: E+zUV0+hS/KsSPAWoNFfUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="557759"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:33:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:33:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:33:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsPvewwpbT1QYxPeC05oluTRv8ArQPWLnLH8EiYfXt7Z4RnRZimqukYwaMFPtNi1yZi32TLemGFIDaCn1n0+N7eRZqFl/4/PO4Zs6j8txujaZTO2mO0YudzVFHgCwQAV3zxVFvMt/O95a0wNBtkmugv5DjnWivYfwirh7EFtq7zjUsQ69DowyXQTMdV8ZJK99FF5YFaRhIxiy7T5sLpDZy0ozn9GLR2+Rsha+ZX70UhXvSuHvDcU2htCSdPGamPmcK5D7+5do4NZBrpGW7hpu2Aeo9XGwaD+oFAKxXYQXsIzZahkVOguUKXw+X57zQcXudVAnNowXIdEryj4oBXWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTAUy1lEpD6+1cnoVISMBMQzm7S1Ryjg2/KW3gWSrnY=;
 b=ccVzVYWhIy+xePIscnEziiNhe247AQmIXQzAzbwJtzRD063OBUaTpmSIz0cYGrm3XEKzd1xyMQZf7P9QE+qGyxwEQXb36+NZEnss6z9Qber8knqPVem8UkUjfC2k4TNW++NvRxHPWXuEsv79i7bAOxXjx9QwnB7H+LSdIbyE8E+KSptEsSU0BrYYkFvoQyiHsg4IByLkmp1HH+Cfz5T/OmynJRIRrPPNeICTXbGSOdYw0LIRTS8MI03oVqnpYd5q3bi0p/Ddqu3CB5JXRSbvpXHXBrmD3jtFsakmd4ixxpkpvhEDF3H3sqgmowzObTMHpzzGRDnysNUu4BTwuq+qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:32:55 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:32:55 +0000
Message-ID: <907cf5f3-1cfb-4332-a45d-9d0621534f90@intel.com>
Date: Sat, 10 Oct 2026 19:32:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/25] net/ixgbe: fix ntuple filter priority
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Wei Zhao
 <wei.zhao1@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Dai
 <wei.dai@picocom.com>, Beilei Xing <beilei.xing@intel.com>
References: <d0461c5320d098e1582c22fc8e9d38dbe3c31533.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <d0461c5320d098e1582c22fc8e9d38dbe3c31533.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0280.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::26) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 06842259-27c1-4922-1d35-08df26fce6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wCWpvw2d0vgLEW34BqyZy45CPC0zc9KqEQCAS5XGQ3qfbO5z0MQtXdBbbyrzpwt0/Czb3Tme3y+rFYFDQ9VYXNXrWWbcxD8LUn5ofzUdM34wmMHd3ymaJNxfRlnqe198QFWXJ/1o9Zofujt3rCv6VBOWgz/4H7juztHaZAtqElLmNien7unl0gBazKivQbtH5cBaQ46pMEvFgFSw4y4liba1M31ofI2MCndglDWIv6GUbFf14RbVJir7T2WbTvfge/ZPsa74ErUjHeQmee/r/2YThi1URSJiBN1jGjPiJD6YRzzu64XoQ0NXJt1Z0jTxKy3PO5bZ0hYwMSY5Rw5Q7TtxS1757CvzVNKxiqBQ76FeTAUCYP+2YCQb0hIxajshm50irRXLXqiXAfg8ed7mymAjbdIBNFXaLHlcXMW7fmzHAzl0xytpWnuDV9ZieKFIch441O4mOhZJrS8/nSJrYMk2Gj22ZsgoCPljy7nF+xGr+PXgq0Fui4LuoeZVQEwU7lFgSJoOfdDqa3C8kAam6l/5U3D5M/uUa6btlYgDUhxMjoUgY52eGiJQvJh8Y0w6eGqJcONktYr2bIcZgUsnPMpdtPcsMLDOYBXnyUv/Blhb1/kqwCppj7id8IMYJ1ygDMhdy9SjCR1FfRi3bWZ9p6kAcwx4z6Xb8O99g4AEyDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTlxRFVoZ3ZDdkZDQUhVVUF6ZTFaSjI3cjl2bUdnY3ZDbzQwVTFFZXYxZ21L?=
 =?utf-8?B?SEF3N0xqSFZrcGVSTVdIVnU1bjRXdGp5c1l6bTlyOFVWQXE3b1VrRWxoZGxx?=
 =?utf-8?B?emZnM2xEeVRpRVM0VFFTRlA3NTh3ZVdvRmtWSERxcjNwekM0V25MV1NWeTNT?=
 =?utf-8?B?KzZRSWNqMDh0MnRZMTdpNmxjZjY0eldaV2h1dHN3OFJCNmM3WUpJUmQ0bk9J?=
 =?utf-8?B?UjV6RUlpRC83WlltZlpXLzhTRVZiUDhKNGxMZitlUktRQmRaMllEYmpJdFlR?=
 =?utf-8?B?Rm1vQkdKSHJFNjh4VHo3a3dNZVhEeUx5NXU1NnMwRmt1VFhGQnZuUi9LSWdZ?=
 =?utf-8?B?YnFUWXF4QlpkZWc3ZWd6T2sxMXJNV3ZUT3Q4Rld6WEZhYjFPN3JhQjRxWnps?=
 =?utf-8?B?R3BCYWw0STNEUTRCeUJBaGtVbkI3anFGbkNaV3pITDBuQnBnSE5ZcnlkNlVZ?=
 =?utf-8?B?VlpCQnlzUXkxcVNuMWtuZUJDSG9hQlh0cmdsWUNabERaSmwyLzgxUjZiaUFR?=
 =?utf-8?B?M3dtck00VUI1dllQSGsyR0hha010NDBiM21nY3JHNWZYRTBjdjJLV04vNU5n?=
 =?utf-8?B?UFh4ak9ScGxGeWlKS2xvTDVoTFRBcStmaDQ1by9CNWYvcFRWdmZvdGZJQmtG?=
 =?utf-8?B?MENMT1I0LzR4WFVWZXFrRHhOc1hwOTZabzhBaDRYWExOd2N0OGxYYUVMT2g4?=
 =?utf-8?B?RXNWL0JCVFdWeW80S0liRjlPSDk0bnBYS0dteTArdVk3MXZyTlpXSFhQVkRY?=
 =?utf-8?B?QmR0Q05jOVllWjdsOTRUaXNFNUdLOWtOUFF3UVF2RTQ5Vk5pWGRwU29Bd0Zi?=
 =?utf-8?B?UzUzeitmMzZtS3BCcHZXem5BeWIxSjhnSVd4c1E0WTJHU3JyU2lXeU9jSm4v?=
 =?utf-8?B?OGZDaFBwSVFsTmpwb0FPbmlqdDUweEozTitKMEo0akJmem52ZFhsV2lDd1dG?=
 =?utf-8?B?T2w3REx1eTRMWFI3QTBjVEV1SEprUzg4Y2NPb01jQ3ZPbnRWNjc3S2gvaGhN?=
 =?utf-8?B?dHpSUW5FR3R1dlFMVHdSY01pb2lteUgzU2xEeTMwL0MraHB6NFdiUkhJODBJ?=
 =?utf-8?B?NjViSUYraHdERCtVMnRmdU40dEFLbVNOWXVwY0tsdVpMczVla3d3NjVtelNP?=
 =?utf-8?B?WEpHdEVhRjVteHcrOHVEUTRzYmlmZFBHaCtlazJuRm1pb2VLWndlcGU0bjZM?=
 =?utf-8?B?WUhhYzVXc001dU53KzlDaEdDTHpUT29VaXFYVE14UWwvekJZdjA4REpkTmNy?=
 =?utf-8?B?VGZIZERmNWg3ZXdQQXpac3hkZFJXUEhxYVRSTWtiaDExM0h6SDB6d05Oc1hh?=
 =?utf-8?B?MmxTYllPTG93WHZybXJWVysyQ2lHMmlVR2tPNDZ1VU9nY3Z4bGdhSHQ1YzhD?=
 =?utf-8?B?L2JBQjRrL0pKNzdZRXE2V2F3WFBBdDB5VVhPbG9kT0paVFQralJlRVcyM1Ew?=
 =?utf-8?B?ZDFseXNJS2ljamFKMXhTZStxL2NWUXZjTFpNbnUwSkJTRnNKaVVkZnBOcm5m?=
 =?utf-8?B?Ym8xRWNnbGdpZDljTHVqZ1RXdkJQRm1HcmdhRHIzUmRSRVdWaDdwZkVVVmt0?=
 =?utf-8?B?TlU2WGdwSWJHUzZHWFF2anUyZ2pOQXFTWjJmV0QvUEVta1NWdU5XalBzTThx?=
 =?utf-8?B?MERMUkE0eTExaW1iZGZZeUZQYjBlUU8xVDgxMnpMQlJtTE9vTTMyNEVQZjd0?=
 =?utf-8?B?WXlkRTVab3d6WGtENW40QUowSEJRdDRmbjNGbXQzSmtLYis4aTA0UzZRSlpX?=
 =?utf-8?B?aTVIWi9Gb0I1c3hNL09Lb3R2VGNCRWFzWXFqK0prRDh0TkpPQVZLNGQzS05B?=
 =?utf-8?B?MnZuTTFRdTB3bGEyTGtyQTN4OTluODJucjFNUm5IVnIyalRpaXVIc2NUS2xj?=
 =?utf-8?B?T0F3eGxVemZxUTBnZGdvWFJiUnlaZUF5bHdrZGdRTENwSUU4ajRZWFdodFRD?=
 =?utf-8?B?SjFCV1lYUnljZ1dRS0RMd0VheDNYTkcweGFjS1JudXo2ZzB0YTBFSW9DTWh6?=
 =?utf-8?B?MUg3M01zTkQ2N3EzKzQyVVMreE1Zc3diRlJSbjNkU2VydDVFU0laU2hGMzRF?=
 =?utf-8?B?elRId3VtVlh5VStSRzRYQnltY3Q2VmgrVHVJU0xnN1JrZkVqdjR6ZkZnL0Jk?=
 =?utf-8?B?REFrYXcvaXRVbTBzeHFxeGZNK1dVSHpxSGFyZlZVbDNMWDU4ZzFCc2UwRE4w?=
 =?utf-8?B?ektGNnk5NE14TmIveFppMTBmUzlPSkprc0pRZ0VrcnZjbnpEZlRJc054dWRR?=
 =?utf-8?B?QnpTQVZPZXJRcW14b0tQcHNrd2xYQ0ZZZk9meFdUdjRqT3NmM3AwT1JwZmxl?=
 =?utf-8?B?bXovWnBPNGx3UFBTQ283VzllaFZSQzZhR0tyR2toSVFhRE1kSnpXRFJDczk5?=
 =?utf-8?Q?oWCcAdCf3SXxdJSQ=3D?=
X-Exchange-RoutingPolicyChecked: aycaWqo4eGe2jeM1TsuI8bHJiIFrOIIdiZBg16iDGtFoxcxUrR7Gqolzs1QgEXd0cll/zHV1I2GwMen4O1EtlqSC6wjIAG6ICz0FgVMy2UrhW4bRm0K9XBZ4JS9T9ogFbiq+Brfw4WP2Vmi6R5Jad3QfJOl7Ca8I3qWLGMBj+jSeK3Ez3ECuAxkOCJlKcNthiubjljOf2u28UBmbcsJo8pWl/+Hgw2pwJAGcTb6hhVCK1h0VhspGlFylNu6zoi/EBfb3b8hizEXxnUYyiZnWcIO3oMplFgczSZ4JOU9hgBmSLYa9gNxpeysVsng2/lX0nqfD57CsnNxghB4OH6QaCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06842259-27c1-4922-1d35-08df26fce6ca
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:32:55.7240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aweCSCUQoermFqVkzMBeHajriarDmMzg1U3GYbbVbmNfSBAYXVpz7O9uW950arPnHMicILhITQdMOxXNzbkEcW/7IMZdJCJ8ehP8bXFqrlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Currently, handling of ntuple filter priority is incorrect: it directly
> translates values inside the valid range (001b-111b), and clamps all
> invalid to 1. This leads to equivalence between rte_flow highest priority
> value (0), and rte_flow lower priority values (8+), both of which are
> mapped to 1 (lowest priority), while the 1-7 range is reversed (in ntuple,
> 111b is highest priority, but in rte_flow it is the lowest).
>
> Fix the calculation by
>
> - Translating highest rte_flow priority to highest ntuple priority
> - Only clamping low priority values to 1 (lowest priority)
> - Reversing the 1-7 mapping to preserve semantic meaning
>
> Fixes: 672be56d76a2 ("net/ixgbe: parse n-tuple filter")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_flow.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 76eec33839b..547c6621d3e 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -209,6 +209,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>   	const struct rte_flow_item_vlan *vlan_mask;
>   	struct rte_flow_item_eth eth_null;
>   	struct rte_flow_item_vlan vlan_null;
> +	uint16_t priority;
>   
>   	/* Priority must be 16-bit */
>   	if (attr->priority > UINT16_MAX) {
> @@ -503,9 +504,21 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>   
>   	filter->queue = q_act->index;
>   
> -	filter->priority = (uint16_t)attr->priority;
> -	if (attr->priority < IXGBE_MIN_N_TUPLE_PRIO || attr->priority > IXGBE_MAX_N_TUPLE_PRIO)
> -		filter->priority = 1;
> +	/*
> +	 * rte_flow priority: 0 through UINT32_MAX, 0 is highest
> +	 *
> +	 * ntuple priority: 001b through 111b, 111b is highest
> +	 *
> +	 * which means we need to transform priority from rte_flow to ntuple:
> +	 *
> +	 * 1) clamp max value
> +	 * 2) reverse
> +	 * 3) add min value
> +	 */
> +	priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO - 1, (uint16_t)attr->priority);
> +	priority = IXGBE_MAX_N_TUPLE_PRIO - 1 - priority;
> +	priority += IXGBE_MIN_N_TUPLE_PRIO;
> +	filter->priority = priority;
>   
>   	return 0;
>   }

-- 
Regards,
Vladimir


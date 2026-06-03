Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26099CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 08:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33517402B6;
	Wed,  3 Jun 2026 10:28:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9720B402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 10:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780475324; x=1812011324;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YUUXk0o5Znsr8RblnJo7eGhrWTybJuVPHecPEsOW14I=;
 b=AhvtGKrtABTd+al+ywaBDoc8xgBoY+SwMUP0dSaTkZrokyfdU2pvZkMx
 4bn4LBBBByUt4DLFnS+ui4/8wX9bdHZhk1k/fAQLDa1AJarAICxv7snFy
 tiYB8VTCXQ2s1vAzEveu8I28qwPi6pGKnu6NiGC1u936Bt82tw4Ann/yr
 qkrb9tr8uMTlvKtCXH1KLTd4A8vGQiMIiHCBZkRheIuKZUAz96hZZCmYH
 O2lbCVLk0L42vobD1+6v2TKHiFwSqJUzTe6RgfuXuQhqdLOLfO2mjgRWk
 acKP5NZ39JEejqZ2WfPrBIsEgbEssWYM6BbZ5upYzAgcIvyJQiF/41ceg w==;
X-CSE-ConnectionGUID: PLAgABBiSVe2VPsPJ5PXGg==
X-CSE-MsgGUID: e+dKYj2LQlCFEIcWOszrJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92654192"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="92654192"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 01:28:43 -0700
X-CSE-ConnectionGUID: R5Yb3iNtSKeLyZKukKMuiQ==
X-CSE-MsgGUID: d8Ju/2p9QPayONWj+e8mHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="241665160"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 01:28:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 01:28:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 01:28:42 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 01:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcwe/RobCiUm2qg1TD00NOf7crK7Sz9rqMBDcv3bLvX5E1Zozw9zKkXriFegHIcL57un9t6C3HLuVr0KXTlgdhKpDT41vwDKvLBxdpI2YhNXLZEryjH2UaAgt8eRA4Bw1N7gpXv4LfGlO5VfZM81Jl8viq/njp8XIMhsfySKSPbEOdIyU0Lml9IS/lS1mIIJBbqUOdUNt69TOTcHj0KDUl79B+S344g1X1csocHahfc3TGKcXkoEowf2ztYeFkmJbmQOJ47oicMTGI3JimuW11Rg0/DJrH0MESWYyRBYFTxtATJFbf0tKQZNcwMCS0wa1hbeNdYNwFEIyMQsK2FHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKOV8QuVo8mrKmnhc+747J92oq4D4Beswe7028XkVeA=;
 b=b4nOglDgXXmbg6Ecqb4TLP8W8tAR9ddCI40gIsxYS0Hzwcrdc1U+XUZL7ttLoH4C+dGdOyranEnAsfoZhVU8ZtAxosXL1Z3TW/RE6ePyWGUxvZ2L/wnsaG+UIrXH5LTV8xvUYsIu9mgYoJH755jsFc3EbhANxw0t9RBNx/EsMWMbTJC7oYCPl56xe1GJ9bG1ueIg7c2wuw0lWMeQSySL8EbYfpsNk+E1tMVDFhLH/eU5QBqqdbfdp2KyQi7HA/I6ztOmsZJsFoFI6cTtugUDJYZv7aD0G6Xs7GQFGkFQWdFPNuemOuNEwgsKXumnBqI2QwtZTCxL/U622OOOUJCrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 08:28:39 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 08:28:39 +0000
Message-ID: <3673c24e-6d32-4087-bf84-4636a0c9a9f5@intel.com>
Date: Wed, 3 Jun 2026 10:28:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] eal: fix async IPC resource leaks on partial
 failure
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Jianfeng Tan <jianfeng.tan@intel.com>
References: <eea1925f6fb24f0f92a2a57d45e9a9c824d353c0.1780068382.git.anatoly.burakov@intel.com>
 <68rC0bdETzqwIkoItqSb_Q@monjalon.net>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <68rC0bdETzqwIkoItqSb_Q@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CO1PR11MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c26571b-0c15-4bf4-e99a-08dec14a1d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|11063799006|4143699003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: cU8KwG69Zmb+2Q3MIEHbqJ1ie2PIGfRu2rIBjC2rSaD72TuImM8itkYxBDLLFpR2FApjEchebqHKPMspHW3yIpAdkT1klaUriQy9J4H+Ww8MVuzLhNCoB8EKnGqLPf+AtYsOLJV85KrU08IxIYdGfPn+xAyx+VnWyFNPoE5FVjg0BNSgUNhFqycmHcmg8pxBNc2+DZ8Uj5P6BnSudRagpuhCDpOSE901gwZ+T1JWAy1raWKma3RtDvJdN7bPCTBH1G3ZgWsTB04ldctrMdbbof975gb4U5d8TKiAm4YDTW+hRIF0Udc53JFMYiTVaxfu1e9TTRMlQvMIinPX8waEJW22Ct2XUwa8tN+BdFC82xwzWICnca42N4alWa9fGVy0e5+krHUHoJSdEvMMTlVdT0KlGCt2xnz8xL+W3sVnm4fsRcm6tYg2NBw7IFm5UYNkUDuz3c37gxeVakALg9AKlvb10wnF9jtPjLSzl8ok+z6VfL/lblCvXbo10w7J6FkSxsl9aU2CMkDuXSy5u4VEtiMxL/0BVd8mJCh4Z+1LJsnlq45lZ7wAdtuGCqSR/FirWq0AbvDyyHkeWRAP/Sk4/PKuGwmvEHn38RJnw3tMPt20/15XAWMG3YXevCctvVH2PCvFnaTPExsLSIiY7tAWFnxwjUvKT1ertiq3s9kvO1vFgbPr77NnHc7W1Y7OS6Xa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(11063799006)(4143699003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk4xdWRBWmFTYVVXR3BRQVF3RFE1cVZoRW94cTh6K2dwSmRJRFhZMERMMnk2?=
 =?utf-8?B?bTVyRVh2S1Y2QjNQNmowekNBZEc3SjdXdjU3SEtpUWpVMXpTTzl0dks1TnZS?=
 =?utf-8?B?ektVWkhrQnltOXNBVUZjQ0pBWkRySHgvVURSMG1XemF3dVYyT0NxTS8yMjZa?=
 =?utf-8?B?U0dqQklYVkxoLzNwU2c0OXZLRmgrU0l6TStFaHp6S2NhZURMN08rY2FSTGEv?=
 =?utf-8?B?RXp0VEtWWEtadjcyV3RpcStDRVJwRGNuekZKR1B3dDlWRTM2UTAxMzNsU3NX?=
 =?utf-8?B?MC9qUUUyUjFCVTVFMkxzRXZjYzErQThHeVNKYVA2VXg1R0krSTMrKzY1Ti9i?=
 =?utf-8?B?R29ONWNoVTBnRHB4akRqcnhvT0Y1N0p6emFwZlF0cEM0TGlndmVVdlIrYzkx?=
 =?utf-8?B?RytIMVpSQ002L29OcERQS0xtWnMzR1ZkQk5lcHJzSlBhYW5zTnRVN01Jd1Uz?=
 =?utf-8?B?dEt4b252QWtqTXFyalRNaktPOElTbVU3NkxTVnZMWUswOTFVai9iNk1rajRW?=
 =?utf-8?B?cEFxakpIT3cyUzFGTVUxQnBvYUlDNExtTFNSbWpDbjRPYWN4WXVmNVpObU9x?=
 =?utf-8?B?NG91Z1hHeStVYzJ5Y3NVY282amlqbUJ6a2E2Qld4bzc0ajdndFl1Tk9DRk53?=
 =?utf-8?B?YVFUcUx5d2lHbkpSdTZPS0lNK1oyVHpXRWgvMFJrU05EOHRWc1IxODZUMXB5?=
 =?utf-8?B?OTJRcXZZemI0cG1kUnBNNTcrSlJ3U2JXcXFJcXorQ1EvNkkxejZaRms5dG8y?=
 =?utf-8?B?VHVNbUJEUnBsTEd2R0JSR04yN0NLZHVQWHRpdEI1Zm5IOTNDK0VTUE1DRkJB?=
 =?utf-8?B?Z1o3aHR0OUVYRi9wUGlIV1ZLUEFxOUxSUHRxZy9sTmgrWWkydk1VM2x6dk9I?=
 =?utf-8?B?UmR6cnJaZ0drK01xeDhRZlNlakRNcUhGQkR5aWMwZTBQMjR5aS9zcGhCNnlS?=
 =?utf-8?B?Y29zMVlvcFBVVVoraVM0YVB6RVN6RXlNaVgyTEdXMVUyc1AzTGFRVk5ObVZS?=
 =?utf-8?B?WlkrSld2Q2xLVlh1VDg0VnZNeUQ1a1BCdGxFNW1yNlh6QUdOWFVBcFhjOU1O?=
 =?utf-8?B?YVFZS2ZTd0cvSkdydDhMN0oxd1ZVeVBnU2FiYm1tbC91RFBOK1hEY3Uxdlhi?=
 =?utf-8?B?NjRzNlkzUy9uZ1NxZ0lROXFQeCtGTFRpeCs2TldXN3V5QzIybWFwYzUvTmF4?=
 =?utf-8?B?aTVnK3FLSnU0ZFNDTUdJT2YvWDZkQ040ZUQ3TFNRaWdaSTBiMkZucDVwbmUv?=
 =?utf-8?B?ODdxSDh2QVpRd1FlQ0IrbVYzZ1oyaGt0cjlrSzBIekh3WFNWVjhsNVVQd05Y?=
 =?utf-8?B?RGEvUElTZzdKMVpSWG11WUFRS1F5YTdHRTJtWWpJd1NtZUx1SFVMMmxxZHda?=
 =?utf-8?B?czZTeExYZWVZa05rSUpwMXQ0dmlaTzJUS3lpbEJZUVdYUDNEd0g0ckwrOS9o?=
 =?utf-8?B?LzZrTW9rUk1WWVRpSU5LR08vNDI3eElBYTN5c2dpNk5rUW8vbDNRTFRrRlJa?=
 =?utf-8?B?Ny9kaWtSZGFqVFlQZ1VONjFZNDhLWUc5cWZ3Q3ZQMVNlc3lXREl3QTZaemNL?=
 =?utf-8?B?c0YvMnltVGU3WDZHL3E3UFpxSThnaVhoVk5lQWJ3aFIwUUdmYmEzU0FteG9K?=
 =?utf-8?B?K2VsRWU3K01WLzZQa004cjVMTDgrakZ5Ri9YN2dqdXBqVFVJNHg4Y3E3Y2dz?=
 =?utf-8?B?SGMrWmppQThFOUd5NFJVOFFuK2UzU3Rtb0JXdzM5Z1BuMlNCcTBDeUc0Qnhj?=
 =?utf-8?B?aVUyQVNLUHZSWC9DZVAzMTJPRWRwTjd2Mzh6UnJGSENZRU9OQU1Vczh4U3NH?=
 =?utf-8?B?T1EwSGVuS1NEVnpGcW13QUpDNVNWRThqRzNESGxyYnFLcWFqR3IwWWRXaFVV?=
 =?utf-8?B?Mzllc0ZDTlZFU3JXMmwvTElMT2hXMmtNZE51SjFIZTNGNkxiQ0tGMTFtUVRO?=
 =?utf-8?B?ZWxLSTJkM0U3dVoyYThiMUlEQ0FydDUrejNKaGVOa1lyYW9HK21tYmVOZThi?=
 =?utf-8?B?K08wcmNaM05nV0VKOExRMFVSMGtaNGd6cnZvaFFYNVRUaUxxWXp1NGtVcGg2?=
 =?utf-8?B?VGhrQlgyYVZxUmpYS3RhRUlyUEdtQk5JLzFVWWd1NHQ3NmhJQUFwUldxMStr?=
 =?utf-8?B?OEpvOU5RdEJMdS92TGpmREZDb2FhMUc4Z0FKL3c1L1A3WW41R01HRG4yZS9i?=
 =?utf-8?B?K3oxQ0VieVd1aU1CdXZtWlZUZ3pYeTlsQnBvZSs2eWRSTFBLTEduRVZJOTV0?=
 =?utf-8?B?OGRIOWRuN1Zlb1NvNWwvSnF4bEtrck5XWHRTdmtjc041bFh2Vnk5TElINGF1?=
 =?utf-8?B?NzdxaUZEdkJ1dDFCWTJGVDBTTE4vdm82TVVRRXloVGpic3ZUY3JPWUFyY2dM?=
 =?utf-8?Q?1pvd3o8ePwtitFlc=3D?=
X-Exchange-RoutingPolicyChecked: Zw6cz3JQNZ/aC6s4/OjYIsCuFqPA+s/RPuySXrxGuHDVvl+Xjd2JreKzxpfnqC83/D5uc1aqPFx4FTmVONlm80gtaVAQaA4e1gPtWHhQNFQ38PSeNeR6SesJxWAo6HrptcyuXKsV54jquEu6Lm8TlULiD3JnhtDzx/6GqBMvh/K6mhnbgqO0ZVSCVP0Xsr//Texj8LjPmND6v25RDMWt3N65dmfQ+gmRVbo/z6pfi4gV9Ori2v3IB8dfVoZkk7l9ahDDkFQY2V4en6O3H8n+fp3des1UAk+k4ygU/zG56VfmTIJHzX/JKt4z1eHkibHX6brGDLUu1sp1c1iikfcwGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c26571b-0c15-4bf4-e99a-08dec14a1d2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:28:39.5801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NvsVKCcf0yrCT8sp1qn0Xl79/xswFtH+s9yNSDysPhCsQjR6Xn6cqnT7V4PjDnPvRxWyrwPYRnV9StjIlgL8Jnnovl/nloMyzi0enjEO7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
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

On 6/1/2026 2:16 PM, Thomas Monjalon wrote:
> 29/05/2026 17:26, Anatoly Burakov:
>> Use a numeric request ID for alarm callback lookup so stale callbacks
>> from rolled-back requests become harmless no-ops.
> [...]
>> +static struct pending_request *
>> +find_pending_request_by_id(unsigned long id)
>> +{
>> +	struct pending_request *r;
>> +
>> +	TAILQ_FOREACH(r, &pending_requests.requests, next) {
>> +		if (r->id == id)
>> +			return r;
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> This function is supposed to find only async requests?
> What will happen if id wraparound and becomes 0,
> matching sync requests?
> 
> I feel we should filter with r->type == REQUEST_TYPE_ASYNC
> 
> 

I mean it could happen if you submit `unsigned long` worth of IPC 
requests, but I didn't think it was a problem that needed solving. But 
sure, we can add an additional check.

-- 
Thanks,
Anatoly

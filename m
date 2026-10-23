Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C517606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DhUchTAu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D715D40B8D;
	Fri, 23 Oct 2026 15:49:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id EC7164068A
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763383; x=1824299383;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Qgkd1lPjapMclJe+HLP/QTQppWvTTsb/HzbeDwdUaP8=;
 b=DhUchTAuJfawIwL163rbznJJ/pFYAdTj9ELP5/YwpLC4oEZlhPLUX5Z/
 fMycs7UzBV6ljBwEZ2B9Iav03ddY28RLRZJFPtKF3TCs7HFukaUBeaDCK
 SxOi/Qby3f7XErW8Bs7MFS8UvZi+hD/OMB/p9oC5YyBEuZ6Blkb+MCOws
 qhvtcVUAwQ5/zfuhghLsqLF9Qf95x7pgHCfkja747Fr8ayXWp5Hi3H6Zb
 khK6ySZvUPIEnZV4l6I1y8a8ZPSFr+kYsfdE8ICqWES99RfoSm7bMK/AI
 XhPFboL4fYkekHv+q1xV5DFyuMR4WppZRbZAFEKHK4QyIM5DBKPGmR/jb A==;
X-CSE-ConnectionGUID: LC29Sai/RjCwRQUdJ0AkRQ==
X-CSE-MsgGUID: hExyXJyuQTGtYmDKLElqjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1414234"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1414234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:49:42 -0700
X-CSE-ConnectionGUID: 9LbOFR7nQiK4HLlCldbu3w==
X-CSE-MsgGUID: M3knvrmLQRG2xO/zCdPf5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3632623"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:49:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:49:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 06:49:41 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqe+gLC29/TcXLDf2uBZXSU6G35pPr1CST0Aci3ndQS63I7MMLIkFRjcApS97P1FUUCCDFGmSDWxRiOMX/y56ABtDD7zJeuVVWHl7DBxnvwB9giF+czyTuZ5FUMwpC3+9AiXyr0tmv0d+M9uz/oBmpM9+hTF7jUahSpPNyJwmi87hXfrBS6n4u1bWMCJs7Bvs02sZqJiTZ4HO6tMVwqBa2eynewcRmrqcCocfGQXt/FkXdUNsBiJAfJoiR7QFVafit2OWqKVpjd0182J9csEmghyPcNhEPzy+feN9BFYvzTnmbzAGrQd2BNQ2SzeC9asVlAT8sKAQQ4jEDADcwVGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veaGxgH49vBjBQNC3jf2/RGVe67yTmmqCQ9xPk42A9Y=;
 b=m8FYjsQEClM+G6UmXZGQYLi2zDpyihxOAJCzH7PewDYCuyhG7PcichlpN4aQEYv1IcjjDsmb96bmv5yjUbq4q3RyVhI8GtBG1ELfn58D3iFvksDlYINmfotY/QXDc7tfZ9DYrK2xFTQKJCBvNXwdYJnQkjS2rvB5XTblorR1vDxojrLF/sOKe2cI039NAvgEcYfLEkJiNeYalugfZqjwb1bzymVe625J6tA5GJtMzeMKxHItQpQkcVuXAtF5X7o1OxZ9sf3LtvXGmmuX9vUcKBzkkgc4DR13DGFNwt0jz4iUv/ijSLxS3tda7sgshdn+7R77PY5knCPkhnD+RqApmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB6826.namprd11.prod.outlook.com (2603:10b6:806:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:49:38 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 13:49:37 +0000
Message-ID: <9b77587f-0b8c-477d-af32-7d69752b8a67@intel.com>
Date: Fri, 23 Oct 2026 15:49:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] bus/pci: fix leaked device FD warning on VFIO unmap
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, David Marchand <david.marchand@redhat.com>, "Thomas
 Monjalon" <thomas@monjalon.net>
References: <cc295d28b94c6b041c6dbecf0c2c963067bbce90.1792762746.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cc295d28b94c6b041c6dbecf0c2c963067bbce90.1792762746.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 954f6b56-4600-42da-5b3f-08df310c7a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AMSZ+SFKSSIZT6ah7mxnpnep/3eSQVCzhq6/H0MdbYtCcvhPmHYWIPuXXWdcqx9QyEV/vQughC3OMLmbVx2DE7IGyL1fYY4Zan9FqHEy/Q9gU35V/bBwWcEXdfaCCLFD3RmyofcvtX0sNUs/uirFKC6QQ3jmpxTmpeafPzJ0fmaBRwcvRXZ7aDMxT4cCZSNABwCgSDuLjwbT7s/NifzNTVSRBVewDUxAF5ycNL0yuX7Jl1+7/h29EOU4oxrhC84riSDAP3uoH1Yzr23lhtK0VFZSq9ZECKVkQseNfQVxxiAHpbK8N56rgANiut6cFUPYdffsxDFzIQUTHT2IC7nRmC1albg/5mMr9XL4HkN2nF3uBaQF/gGRL6lHHJ0jxEF4dUoBkZSyjjlgUk4+NOtNjPob+oYDAY2+ahXLeddWkox6YxCGMZjk5qyxbxO2rgnzHmdFlkclgcmr7pctsCkZyulUlOmosDAEYUKA9OH7cPk7KZcmHZN0dw8KPjrCPdDUKaqYHtpK4S4GD5SOQLAzoD4nwM5B5DUaPRHEFfFI7YKGIFzakKb64jOFM7M0OV0q04XRuEZNehXaJQ4e4a5Q5m60f5p3ANgrNqOHzlHb6SUHhzivH5vsLew/sGldjZx3piJgLT/E46escIQmdUrYxvPPCIiUNRZANCgaAdMTEEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStrRGFYZ3REVGFZSnBKQXBPTFI2R1dKQzBBS2Q0M25XdkhSUWFUZFIyOXVz?=
 =?utf-8?B?WXdRRkpHZ2ViSkxtZnJWUG9lb0dqN08xNW1jM0ZRcThDL0FDN0FPV0VuZTQw?=
 =?utf-8?B?SnppVDQxNHI4K1REWDJQWnAzbUYySmQyaVpMUjJDR2xURDZVWVI2cVBRU3Q2?=
 =?utf-8?B?NXVVeDA0WjFRZTl1d0wrMm1ZcXF6djRhUlc5aDNZYTdlU3BCYW1VUjJUdEYw?=
 =?utf-8?B?cVpObUMvVDR2WktoaGFreWVML2szN01YK0JMa0xqcnN3dzMyQUgxMWMvcFNq?=
 =?utf-8?B?Q01CLzNMZU9OeXRta1h2OXlNVjNDeTVpN2FZZTRMTVhGYWtLOGVHaERObDdL?=
 =?utf-8?B?UVdhaDBGZldlMjlvTDF4MlRHbUNVVkRzMXlLbFpUMW91Mm1GdVNSU3BPcmNo?=
 =?utf-8?B?TDhHT2c2ODVxNE1weXZVTkVlaHcyMWpLd282MHg5YUkyUmQ4enJuWktzUG5S?=
 =?utf-8?B?ZW52M21xaEVzc1pRM2ZUcnZCOVM2eDZ6cmZ6K245NW1XRjdLK3M0SzR6QmUz?=
 =?utf-8?B?d2FEWEVxdExrK3doK1h5bGdqZEFHVmZpUXp4czdXV0ZYVVRKOXlPZGRiUG0w?=
 =?utf-8?B?ZGVDd3NLSjl6RmFWTEJjT1RnSWQweitQSmNGcmJwQTNGMVNsOW9XQW9VRFJu?=
 =?utf-8?B?MG1UY1pENERWdnJib2FPS2trQWNPSXhPZkdsbXY5aDdRbytPbXp3WkEvZktp?=
 =?utf-8?B?TFJnOWZFdy9qMVpnaE1vazVQQ0dZREJUZDg2bVVuMmpteFZkZ0l6UEVCNjhM?=
 =?utf-8?B?SU5MT3JUYTVBZi9XYVVIaC9ST2x2eVJ3OVZIYWRUZ2dmeUxhWURrYVJMSWw5?=
 =?utf-8?B?ckhCeEF3cCszNStYSlB1c2pEc21YZXkwVUF3Z0k5ZHFVRDlrdDIvclpoVEVD?=
 =?utf-8?B?RWYwbGlheHR0bnFWUkRGcGNPSlhyTlZORjhkeW9vUnM0VTZVVkdjNEwvSFhv?=
 =?utf-8?B?Ly9HZVJVYnFxd2s3UStyT3piamk2K1N2cHpTNEhpV1dxMHkzeWFlMFFSbHpi?=
 =?utf-8?B?SlhGeHM0UTdMY0h4WnZwZFpoQm95UDNhR3hZNHdNQ2EzYUJFOVlrN0JPY281?=
 =?utf-8?B?MCtncy9rOWY1a1VlTHhLZWkrdzAzMCtiekZOSkFHSytnMXlLb2pQODFKSmI2?=
 =?utf-8?B?T2VPRVN3QkdLL1ZKM28rT1hCUklYV29iOEJDZ2tWRy9WUC9nUkkvNkVleHVt?=
 =?utf-8?B?eVRhWlZuc1N5RlE4Q284QnYxNlhmclY4dUh6QWJtams1ZGpXMXFFdm1MUnZl?=
 =?utf-8?B?RUJmZ2gwNE9kQUo2eXluajZwbHJZbmFzcnQ4enRlWENRWDMwaTZ3ek9WWlJO?=
 =?utf-8?B?L3hxcFk0UnJmdmRwT2c5emR5RFM0RThFRG5rSGNzRjl0VTNFcjEvNThzVjMr?=
 =?utf-8?B?ZURNNUlRMytwVlR6YjkvaDI0dzZUUE52SFBNTEtwM3F5TkRKRTJ2ZUhIZXAx?=
 =?utf-8?B?YUpEeUxPZDRZREtyVkdxVDZma3A2bFdKUEplTE9YRTNRMnBvcmJvUS95ME1i?=
 =?utf-8?B?QUFFd0VTTGxOUk4vRnNzeHdBenJFenVCZHI4V2hTVmJidVJ5QTZiSjIzdTh4?=
 =?utf-8?B?QXVxdjJYbVlWSStyYmFSbEtSS1poS3Q1SlFhZG4rdXBzTCtRaFNPVHBWUDRN?=
 =?utf-8?B?WnFXdHJQZ0pUYW1tTG96N3Y4ZHd6OEVwMFk1YWtpeTIwM2JQSjRiZmV2R2RW?=
 =?utf-8?B?c2hpQmNDVjZSa0xnRUxlZFE3SXRWais3UWRLOFBaQysraEtKZVc3YURuVTEw?=
 =?utf-8?B?eTdzaWNLNHRHK0ZmejFTR3BmWWFkQm8ycms4cXVwZjJQOGZDdlFQVzEyZXJX?=
 =?utf-8?B?eGMvQmpuYkNzVFcrYk5UTDBzNXhRZnI5K3lmWnBma1Rmd3F5TllkcnVZaldJ?=
 =?utf-8?B?b0dpeSs0ZDJNN0haakRMSDNkdUNEYWJtSzVNZnJBR1RCTC9JRTZiQlBTVm01?=
 =?utf-8?B?QU5EWjNleVR6WVRRSVVGRE53NjJmWWF1RnpVNVNKSDcxbmJFaUtISlludTdp?=
 =?utf-8?B?cGZyUFlJUmd2bjFUVmVHYjhtMVZjZGp3MW12Q05EQWlSaHlTa2Y3OEZOaWVk?=
 =?utf-8?B?bENGN2NtNk9IazQ1RUpSYmsyRUFNOGZiL1pqdmJDZkNCUFU3WTJCb1dUM2VL?=
 =?utf-8?B?U1RFckpTeVZyRGllUk9pb3FKNXZGMTNQbk5zR1Jud2hjN1ZTRmZRSFNGNTFn?=
 =?utf-8?B?dndQd055TGs2dkJIbXlkUU9DdlhpTlN3VFlncjRvVG05Y2FrK2V3dGQwaEhF?=
 =?utf-8?B?TVhUV1NVOFd6ZnZ2bWlROTJJTDlPMldsUVIrNVU4d0lkaDdWazY2a1JuWkpM?=
 =?utf-8?B?NUtEQzZISHhYbHlzbXdFbnp5b3pGaXppeWplamx1RWpaWGtydUhQYlhtMlBt?=
 =?utf-8?Q?VcRAVx/RjVT0IhBk=3D?=
X-Exchange-RoutingPolicyChecked: Lo7m9/dw5pYoCNUwbI29ORZYKqtj/c/HK2AOWcHoccmGE3U5Gsiw6b0uC2amx4VxesghOkqYqbadZEebz3VH7ZtFRZ5PKj24wfmsp33Yvb1q5CGedycakIfjXedTfEpWSIozLkePCGAbhSQaQT45mkejhJQIE4jbM1rsndfMdNPSZq95RhZTlHGN3KegAB+ZUvfsan/3rnvUGAiuFsxWcxAf7NAxgrMDqBnCxncrz+Xm0oME3Dwd+GU+bm8miZ1GSGe7SeUTFlInA407kTy1a+qcU9BkL8mUQptnAEOtEdeaOG9dcF6YHIwgXAHjL8Z07JDb072HZnf1eQ4xpzNU4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 954f6b56-4600-42da-5b3f-08df310c7a34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:49:37.0908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEwtuQ0SOB+YHUIWXbclKUHk/pb2lTx49FHwdnsj9VAL/U/0aGJQaN/zdhhPg4IOe+MNfBIfNQ11f/2mCsgP0ulQoXaR/E0wVit+GfYSyxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6826
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 3:39 PM, Anatoly Burakov wrote:
> When unmapping a VFIO device, the interrupt handle FD is closed but the
> reference to the VFIO device FD is left in the handle. The device FD is
> owned by the VFIO layer and released separately, so freeing the handle
> later reports it as leaked.
> 
> Clear the reference once the device FD has been retrieved, as is already
> done for the request notifier handle.
> 
> Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/bus/pci/linux/pci_vfio.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
> index fb35bc1d491..1116603f43f 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -1091,6 +1091,8 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
>   	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
>   	if (vfio_dev_fd < 0)
>   		return -1;
> +	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
> +	rte_intr_dev_fd_set(dev->intr_handle, -1);
>   
>   	if (rte_pci_set_bus_master(dev, false)) {
>   		PCI_LOG(ERR, "%s cannot unset bus mastering for PCI device!", pci_addr);
> @@ -1135,6 +1137,8 @@ pci_vfio_unmap_resource_secondary(struct rte_pci_device *dev)
>   	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
>   	if (vfio_dev_fd < 0)
>   		return -1;
> +	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
> +	rte_intr_dev_fd_set(dev->intr_handle, -1);
>   
>   	ret = dev_vfio_release_device(rte_pci_get_sysfs_path(), pci_addr,
>   				      vfio_dev_fd);

Those intr_dev_fd_set's should've been put after the 
dev_vfio_device_release. I'll send a v4 fixing that.

-- 
Thanks,
Anatoly

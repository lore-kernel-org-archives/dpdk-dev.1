Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0820CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 08:35:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2B5C4028A;
	Wed, 27 May 2026 10:35:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E692B40285
 for <dev@dpdk.org>; Wed, 27 May 2026 10:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779870920; x=1811406920;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ywan9QND2QvXELRPU0v3q5Tvwc0lSCjeeDM9SWf5CWk=;
 b=levhPsz1xOe9MwDrbj/CSmTW+Rbhr2n0bF1qpJdwUIpwwM00Bk2Hepb5
 FKWZJCIWB5Gb2ICJpZgchpJiCXeWH87MFzz1NXhGh2/lmSM6X6tq53DG/
 9koBODKla9CLyRgRTn05fCFVgEyCedZcSfOhCwFJ3LovP9KcyMZaZMxOJ
 opRfOms6gEsBr9sy8mIG1hNotJJAlPsSH7V7zhkQqKih3Kgy8vKl5UZRO
 fYMTQd6SkJ9Ep6MubCFMv7N8tLs8pZtnWsDDXt/kJT+iZQ+3qQLT2KhMb
 AFEl0pXI/u9XHfJ5xmEO86TfKPqgXxgy5WjDKCkhFDn1zMolVvPfDZPXm Q==;
X-CSE-ConnectionGUID: shhXZrV6RRqpLO5tO+T2Sw==
X-CSE-MsgGUID: GRV2FpIySSO4ZICBBjI8Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80664629"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80664629"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 01:35:19 -0700
X-CSE-ConnectionGUID: mXPruKlfR5OgimNujxL6fA==
X-CSE-MsgGUID: AP+uSd/CQruz3rtZReKfjA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 01:35:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 01:35:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 01:35:18 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 01:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqI6/DUyYfOE/qjBtHU4fwWhbcqZuNlFPqI/q/yIA9uLsfbcwvHnuT/avtR3Ep3pjKPwQDxq7xu6UX1S7/V4D2BOigmLhjrBXfQsS6W76jPL5NGjv2suNgaikdVP6f+c3aPeftKVqp7aOfI1fp2S5B4Y1q2w13e0L3UIWdjlIwSt9CTrd3URg1B8O8nJkps80VuHpnKed2Sm88wjzs18zQwM+BDusXmnCUgKugdnrZKNCWOnZltMJe6RZHPFlkeIOT8/4kZr070QwD6srNEPeoWUdX7DRbrOLZ/Ep4N9Twm07wIS9mBiylsDxuMk6A0R7KMJranZxoFol/jtc/LGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZ5FOeExDLHY+oZo2/uy8rAMf0sCTeymNKo7kjjJSEo=;
 b=cB33C3kdYoFGc5DJ4dwtOFQBV/z3b74io1MQ8rIUTrclzrkwYIBuxdIco6rnshkmSz4KRRrAR2uy5T6Y0PaD/+UCjjH1N9PDCm5oYTYAcoOdoWmaYS/qdLCIIMc8ssOU6Y2rJZf09eYFlFOduybkRh9YlKtKMTjkcO0nTG3f/l2oo0/4Og4EXLZs1FlTqzOPrslHf1ODqlHE8cPY4a6rcxe3w5UJgzpuiOZQT8dpor+5mODTxrDHaH7+INQxoHh7s5E7f3UuCwe8BIZC0GyAKdQJAHLPc2hsazMrm4ll42ldK1ZbwLczi0YzWU2QWPQB7jZTlnS+XMA6Nfo5XYgBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:35:15 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:35:15 +0000
Message-ID: <2ce0e4a2-b682-4ac3-a0f2-d69ded1babe8@intel.com>
Date: Wed, 27 May 2026 10:35:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] eal/memory: get rid of global VA space limits
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <1f0e3755ed80dd3dfa98d35002afde053e0d23b9.1773417833.git.anatoly.burakov@intel.com>
 <ahXEJslh20SWaq3E@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <ahXEJslh20SWaq3E@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: af2f4f7f-9635-49af-5b00-08debbcae02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|3023799007|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +kHsJmqX4r6dgKGQHQUJHVfLT8b5V3iV9uD7Hl3Pf1dt/Q2WjuBtXJmu5eFlqWc4hSALyp+WWP/GXSFu+5vjlCdA/TWxxqf+DFEV77BGKpaljd1ybudmjBA9fZ1+8tO0EvhSLzhHoE9JT6pORMEDYYOjMSEwkxHErrXMX7P685o8S9Pz2kyBZLTlvqwvx6XfYI1r/ZV2Hvjp7s3q1+eIezF2UMxsvcc9nV+smniP9Ciub1fcyoc8xezrxZJDzHZYOOZwGNm7QzHFZrIS3X7jGI24NLjWChgq5MvaawLme61qhQGlaxj8I5cqgKiev2jnAe2/KagQmkgX9ow+bxZZEP4j1+bWP+Kge4gxNaGKRysA4+zDkRP5j5247DKUqM0dBEdYmDZhhCAWsqH54zsMHRCUn5FFsGgizKj/u/x1hp1qQoNtgINgDBoY3dfT2FUk4MvX4HRLaOz7LuRz75C5YalCuII/9tB07pFjkP3AZ0g60H3ESrvEejL/OJXSi9TtRkE3YjhbMGl5My8y9iYpQhqMd0r8DSULRLhklOFiBp23qOzRMg8oAM2BBRhYSlrqNVMlDVHdvE7Gi2W4x+VPxsLUs5kNCZMCtubMtGsbGj2XB6Zmkiku8MLSrs+o7tJhsr8ey8B3fPMcbkzeHubRMtQVonvxC2zlYKy4ynLngNr0DZ5xEaxE9kPxogKh9+5l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(3023799007)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5DSHo3Q3BIODI2bWx5eVRvK3I5L0pHQkxsMVlZVVY0cUdvRHJOeGFhN2dF?=
 =?utf-8?B?UUtJZGNyR2ZVVzVNc1kxOGFYRENYUVp0aTdSajhPaDhTcCtnc3Y0S0NNOHBQ?=
 =?utf-8?B?VnlDZHgySnN1Z2prU0syd3J2QXJRWnZuaTMwbEgxdG9MT3ljdTBzMUR0dkg2?=
 =?utf-8?B?TllFSVFWNExjVlQweVhWRitqdjJSK3ZaeWR2dUFmNUhvdGJJZWlYVGk1VDFU?=
 =?utf-8?B?RDVmVmNPeFgwOFFZODZNeGwzb2NNOGVET09VRFU0Sm9rZW9wZk1Gc280MzFQ?=
 =?utf-8?B?K1NHK2dlOUViMlhLOEgrWnpGS3Fvb1FDcnNScVVRNytGNDZheDltRCsrRUMw?=
 =?utf-8?B?bUNpdElSdFd3YmJBRnhKRmdIRytWa202eC92bmZ2ckF5L3hwMmhaUHB2UVNP?=
 =?utf-8?B?bWI3ZU9nejc3emZDSmtVYWpwajNFOWtyZ0M5YUsySy9HZ3lSY3NEQjFxL3Jx?=
 =?utf-8?B?aVVOME9SY0JDZk5YYlphUzFkenF3K05tRHlPeFhTUXZFNWd0UTRCaXBuYmQr?=
 =?utf-8?B?SitNQXNIK0FJeFhrQmdmV3FIZVN5dkwwZ0JVZmszRHZPTHI3VytxdjVDdjkx?=
 =?utf-8?B?VU5yVHZ2QUFXUitwb2trVWlMUkljQVBwdXFMaFZrZzlwZzM4RTYzWHNiRWQr?=
 =?utf-8?B?Vkg2MElyWitYdnpvbGh0cjVIOVl2b1lQRkx6SmZkNWhmNEhsNU5EUlZaRmdn?=
 =?utf-8?B?MFRUQUNEU1I0V3BiTWJ5YjBhNzZlemhtRlN2WGE4QklNc29rQ2Y5enhoQXp0?=
 =?utf-8?B?M0VKdjRBRjQreUhpOE8rTDJqOGd0ZDgzZkFwRUlOVEVpS09iTGllSllDd05Z?=
 =?utf-8?B?UUlhSVkvc0FMcXY2cC9WVHdjNGYzQjdubjJZbEdmdkpTbHltU1RyNFdqTWpz?=
 =?utf-8?B?YWdvQmxIbHE5VjJLaU5mSVE3cU5pc0JZdmx0Rm8wbGxsVjROdXBZTDBPUUw2?=
 =?utf-8?B?WHhCdHpPa2pRTitWbHhGMFgzTGVOVUV6cW41dlJOT3R4MTUzZ0JiWGFydlVk?=
 =?utf-8?B?R3RiY0N1alRDQkVGZW1PVjhoV1ZyY2JlQVd6RGlEalQxc25KUlVKOFBrTTFK?=
 =?utf-8?B?NWFQS2REc2hENVNqckFId1Q0cjN1UTdyUDNBNUEwQkh5eTNRT1hJU1drQ29x?=
 =?utf-8?B?bGdDaG84L1lHSXpCQmcyelNBbUhxa3pIeUU1TTdKdEM1WHp2bjZIUW44QnlJ?=
 =?utf-8?B?NjdGek93alZKWGs2RHNGcjdVa0UyekUxUnJub1djcXNKaTBBcy94R21LUzNH?=
 =?utf-8?B?TUlZQThqSFlLcFZjVkh6eUJiY25zWVUzK3ZUdWtyQ2RaUU1jdEd4cEozRExY?=
 =?utf-8?B?REhmNXpHUWxZSUltQlNKU1NUM2JpTzVsYVdPVnNic0xEczZ3VzhqZG5aR1la?=
 =?utf-8?B?NEV4ZjNhVVNPZ2s1eWdvTUFJcDV0S3ZwME5OVi9mQTRLWDRYZTBJSkptWitB?=
 =?utf-8?B?bTNNcVBsTU1nOGk4TGRFWFhsd01mMzZzK0tWSkNyYkZ5NkIxVEtUT2pJZnBr?=
 =?utf-8?B?SWVOd25JdnBsY0xhNVFTK05MUmJXTE1OOGRCaGgxcWppN0J2S2YyUElNRGpj?=
 =?utf-8?B?ZUVYb3hNelZBeTVXMmVDWFVHVnNXbU1yVjJPTjh0aTFkbTBTbmZwaXRpTkY5?=
 =?utf-8?B?MVl1bVpHdjVqcG5KM2VTYVNCNTBIZlc0VzBsK0lxR2p6eW52Yk13VmhXcVNU?=
 =?utf-8?B?SFB3M0Jydk5oa0RJU1ZRT0RPMlh6MnBQOHFrS2tGbjlTaFhOZnpvelF3VzNk?=
 =?utf-8?B?a2JSbDBBVnkxZW1sU0d5NG9oVW11N0N5ZzFjWHUrb09ZbEY0UUhaUlE5emgr?=
 =?utf-8?B?R2RSdVBrWUdPeGxxK0VaN0N6SWwwcm5McG5YU3MwSm9HQkY2TTVwVGRtaVFQ?=
 =?utf-8?B?aGJJMFVuSXpzbnZDUHF6cEtKWm5ONUhEMW1WRmt5amNKUkZjZ05ncXFDS3li?=
 =?utf-8?B?SkEzZy84eWJRMzNHVW9oV0dldkdtNUF0OUtjOU5xZ1FxVFhSNXhwVmNEMDlz?=
 =?utf-8?B?SDVqOGg2U0J2MnE3RU9wQXRKenFIQmNQalV5VWlEMTZWSkI3NjRDeE1aYUlR?=
 =?utf-8?B?dlhxdis1bUxEQVJwVVdzbWNpaXRjbnFwUng0dWhldlk1emp5Y2JsYU1UZmdq?=
 =?utf-8?B?TnhGM015enN6b2tkNXAyeWN6YnppU3NuaFBiclBma0RWemZobWpFdzlYeDU4?=
 =?utf-8?B?NGYyalNhN013eVhoZ1FYRzk3Y1YxZ2VnNERuQVo5dXVNT2VvL1ZEQzM0dzFH?=
 =?utf-8?B?SnhRWjV6Qi9ra2dwMUl0NG53SEVUc2ZuU2x3U0NycnRya1NNMVJBWFE0WS9R?=
 =?utf-8?B?cURtUVMwalpQN1ZidDJmK3pEakg5NnBsL1cxeHhrZHRrZmFBYlZacDRJVkNK?=
 =?utf-8?Q?PTXRp+Q2bVDO/suQ=3D?=
X-Exchange-RoutingPolicyChecked: YSTZ8eZVs6Eqw+HnsaGgz4HyUBnmVwnGVW0AC5ROg6huDCQ42bppe6s0tAuaYBZ+2mdSd1kGl1t63FDaZJ1XrZ5MPfTREgajoUaxNHtyfRbdSWTSjbqLyVR8G8r9xk7yG4SC4pWYFpU7R6Tb4UigSmOCWe9frEerLAnw1shli/t4/VdZKG9XiB0jbYl/lDWZina5aFFnTKnHYkWJrLMvYRmCrpUP/hNjVGwsqOVg1of7+kLdfPix1053P8IQdix2QS2PmSeM+65u1qFUPz4S/3XOCJm3wm+ZC8PwKYp0T6Z58ZxTTBmKorecWTVAJsEeNboKHNuyb7k2cgPLBWIOYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: af2f4f7f-9635-49af-5b00-08debbcae02a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:35:15.3111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+o/ZccmCIhApmF70GT4HQz9bF7CGV5pHuUpQdr5YB1LREeIBQXDZ6jwSPupKAZuSQniO2H2JfeVJU0FcamZCHrUzLf3vdJ1HkU+Fgu4w94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
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

On 5/26/2026 6:02 PM, Bruce Richardson wrote:
> On Fri, Mar 13, 2026 at 04:06:35PM +0000, Anatoly Burakov wrote:
>> Currently, all VA space reservations take into account global memory limit.
>> The original intent was to limit memory allocations to however many NUMA
>> nodes the machine had taking into the account that socket ID's may be
>> discontiguous. Since we have had "socket count" API for while and it gives
>> us correct NUMA node count, taking discontiguousness into account, we can
>> relax the total limits and remove the restrictions, and let VA space usage
>> scale with NUMA nodes.
>>
>> The only place where we actually require a hard limit is in 32-bit code,
>> where we cannot allocate more than 2G of VA space.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Asking AI about this patch flags an issue whereby the contigmem driver does
> not guarantee the number of buffers is >0, which can cause issues. However,
> that's better fixed in contigmem.
> 
> One additional comment inline below.
> 

<snip>

>> diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
>> index 04368a3950..63e0568afa 100644
>> --- a/doc/guides/prog_guide/env_abstraction_layer.rst
>> +++ b/doc/guides/prog_guide/env_abstraction_layer.rst
>> @@ -208,8 +208,6 @@ variables:
>>     can have (where "type" is defined as "page size + NUMA node" combination)
> 
> Is the RTE_MAX_MEMSEG_PER_TYPE value still necessary?

Yes, the "per list" values are gone, but "per type" values stay as they 
provide the defaults.

> 
>>   * ``RTE_MAX_MEM_MB_PER_TYPE`` controls how much megabytes of memory each
>>     memory type can address
>> -* ``RTE_MAX_MEM_MB`` places a global maximum on the amount of memory
>> -  DPDK can reserve
>>
> <snip>


-- 
Thanks,
Anatoly

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BAFEA3F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 09:14:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 095F3402B5;
	Wed, 11 Feb 2026 10:14:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BF70D4026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 10:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770801254; x=1802337254;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tpCHEs1kiR/hj1E3gAjgBtO4l8OwmCeby3Nh9GvGdP8=;
 b=OSBEzBU5kuOowYx/GZqOxl6ZWBAVEjvS2XQu5gqNGo98VeeAVryHRohH
 xyLT9q0H19rpO3/QVDIkdh6cwYqoisEs3xHkYnAWjnyQ79yuNyPWcQSEA
 ljQX2traiJM+RV5V9GkmCWjYjAYauVEKIrEldF67Oc3fpzAFm+kUOrF5d
 kG6/7/8HQKA7D6Q+SD9tHa3QKoDC1Lifu3AURkk50G7GXADNZDuIfDZPz
 0rx0OTlUAktzltpy4Cyty7sNvdSwf2uSv0HJrcmd5Le7XMU2DiFtMrhFt
 h3aw3ECUYXcOH20xkrj5C95HRK8/VjlYgskFakYy+TQy82Yq9m6Ln07zp w==;
X-CSE-ConnectionGUID: Ia2bTht0TXKprxM4OXfOqg==
X-CSE-MsgGUID: yInITJ6CTcKcMwwA3KLuzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72019881"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72019881"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:14:13 -0800
X-CSE-ConnectionGUID: 0GG195NHS9e3GJYD800uyw==
X-CSE-MsgGUID: OMs+Hr04TnykGUvfVMlm3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212224027"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:14:13 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:14:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 01:14:12 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:14:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqDvbDJb2OtlDBFJsQscLHMZf9dG8jkCaWNINXqqqtG8Fucj2YNQoUFygoqJo9yX4pUTxpPDWWmMHH8N4b7y+5TH6SjUE82FmofWu5Ydj0eLlXPt7dRNx/d23TG3sVsmDgvEfvR6UwzJ4hUJCGAcXjjzNtgNPgP6M8BsxABsUBpAlO42WeAOGUgXqVitGRKvnGvDqa3XIKhlc/mlqRSfzGyecZ8IRFwUUXiaEjJ7yvaA9NFNGSXvuytWPEqNCqc+XUH2k0tYYsyFsSgWyshnwjqJESAvrI6b0qDhqVtOxzX5wwY7ZF77Ya5y0467dcx/45E7DmthLvg0Mhg82kNCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AxQ9yqqb4XO0inpeQS9IQwWh90OZq1wCMmhdsXLYzY=;
 b=lQp4vVlOmJNii9lQ4oTHj9VMXHzO829c2PevYy1NpgUOwwWdbHiWE56psD97IA9+nCTK7fJ1vNYUiUjwfv/tihB+X2jZ1WNo/mRlAeIqKB5I3O/6pwEizu2Llwxn3a9AQuwMqSPN5wg+oB0n7qpdbxq2jTz6tzrOFFBhuu6m0rTfAhYP1UE6JE1NgsQskAuSXY2nv9WoeUMJWw+EfHOSXogEKRiiCkp0GJ0WSwTBqXulMnsM3Ig0rjfSGg/D4dLzo8EOEaAC/F9qSQGjY2wngftJRqPRiD0em60RloJufvcx//RVACPYEerfp/9XQOF5Lm1QLsFs3RnRcWadCvnAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 09:14:09 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:14:09 +0000
Message-ID: <7f66b67d-6b68-41d9-82d8-33346ac52b97@intel.com>
Date: Wed, 11 Feb 2026 10:14:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/35] net/intel: add common fn to calculate needed
 descriptors
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-6-bruce.richardson@intel.com>
 <cab7ff8b-b260-4339-b0d7-8a139b617ba7@intel.com>
 <aYs73tmg3YBlSXLB@bricha3-mobl1.ger.corp.intel.com>
 <1518516a-5c1a-4bd0-9c8d-f071ae33a8c6@intel.com>
 <aYtqFdNmhwGWc3pW@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aYtqFdNmhwGWc3pW@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f26153-48e1-4a60-a67a-08de694dea15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDRaL3F6ZC9qb0J5SUtUeTZOU2pVQTBhVFhaK1Z1dHZnc1g3bVRNUzIraE9a?=
 =?utf-8?B?eXNBbGhJWXFQbkxpVHVERCtLMzhpS2dad1JuSWdZSE9ibDJmRUZUbGZRSEhQ?=
 =?utf-8?B?dTZNQ0lpb0ErQjZLRHowYnZFeG9yY2xBeENzNWF1S3loUGJMTFhnVVV0UUZj?=
 =?utf-8?B?QlA2L20yTFR1UW01cDBXSmhuU1FtZ29ZMUN3VWp6TFF4b3ZDckQ2clhZRUdh?=
 =?utf-8?B?dVc2VXlVdUJYckszWnRyV1UyVGE0bGNJZEFobTJHdzhwdEJKUGp5anJwNU1o?=
 =?utf-8?B?SlJGdS9jcGRRcUxaZFFLVHFFc2JtVmR0Y2c5U243WGpsQmNCdTNTVy9UNUM1?=
 =?utf-8?B?Yk1RUTRNcVRkU1E2TEV4L1Z6QmhsVmhZTFJiMTVEMXhQZjNXT1Nzek1TTzB6?=
 =?utf-8?B?KzVqS0owdDgwbTNFYkxPRXJGT1JhamxyUWxSSUZ0VFZtQWJkdm9HVFMvSmMy?=
 =?utf-8?B?VUhUT1lPYTNwWEFPQ25XWjNKWVJrWHA1QlBYUXlka2xlUEowcVNRR0U4am5B?=
 =?utf-8?B?UGRRRkRYcytFeUp0bWpXM3F4UmlIdXZlMldPR0w4dWNoWHhSZ3JjNUFjSi9R?=
 =?utf-8?B?NTBUR3RXNXhMemRtOHZSbmtwNmN6MXFzbmdjbzhFVXdEdExLMVR2NXpQNEtR?=
 =?utf-8?B?b2dveGtIRGpLSVFYSCsrdmtRRzF3TUxlOUZlM1VMbWV0ZDVCSFhtSThxcWE5?=
 =?utf-8?B?d1VJR0ZsZnNiY1pJbHJKZ1E1M1JxeU9TamZrZW1mUWxIUjhaaElMd1BXRFRi?=
 =?utf-8?B?aGZDNldleDZsdkZtYjExb2ZIT0Z1WkR5WGNyMUt2WHd2eTNCM1ZUS0hlWTdr?=
 =?utf-8?B?bUUxY0pleUdQUjZOZFdKeHJRT3QyZDV4Smx0Ymd6NDhPa1orMENmUEJBZnpj?=
 =?utf-8?B?RUUrVWNwUlgyc2FRY0luYTJZMGgyMkNhYlJxK1VPTGhvcGpvVTNtTE1ZakdG?=
 =?utf-8?B?emNjTFRoQ0J1dHhJRUUzR0xHTjhpTjB4dTZiekcvWS80N2NLdlRweFZhbW5p?=
 =?utf-8?B?Mmk3V3Bva0VVdng4SXpoV2VvMytnQXp2enRVMkw5eEFQbDNvNkFsUWFiWC9k?=
 =?utf-8?B?NVFhd1VLbHpVQ3RieEVQSUFQZHh1Znh0MmR6RmhlZDErcThBUTlobzkzeVZn?=
 =?utf-8?B?d1krUGRUSHFVTVpvelZSdGlvNi9vTGRqNmtlcWVGY21HTEhCT0NEdURaVGlh?=
 =?utf-8?B?NzloMURDVnI5MHNiQm1CWDBySFZKTk96WlFaNEJJeXNRSmt6Nmp3TVdrdksz?=
 =?utf-8?B?dTZYbmF4Q05zbFphQlhwTzdvK1pBRVhZditvUk5xb21ZczVmQmQ0QUNsbmd3?=
 =?utf-8?B?Nm52OERYU2JHVm02NVdCS3VvVFlnSEREYkhaNWdac1R2RlpRZlRoTDZRWkVr?=
 =?utf-8?B?R2w1RlF6aHRyMTZUdmpRNXV4K2F2Nm16TlBOajRHbnFxaXpxMXRvNXVKT2Jl?=
 =?utf-8?B?N1U4SnVQZ0Y4Q3ltT3Vucm9pZlJoQXRVQXdJbTRSVEFuZXgxYnplRWNNMU1C?=
 =?utf-8?B?dWhVczAwNmNpOXVKT0E2RHFhZ2REVXJRbmlrbGNpcXhNU21TL0RUOTkvWm9I?=
 =?utf-8?B?WFI0MldMd0Q5eUM4OW9FTktqRUgvemFablV3S1dzWWcyN0hjVENuTFMrZW1L?=
 =?utf-8?B?eXQ1VSt0VnVCb21TelBSOE9IaUNRZkFmL0JnL0sxMDRyQlRuSytEOUNhdysr?=
 =?utf-8?B?VS8vVy84NWhkVy81QUYrL1VKazY4WndVWEY3YjN2WVlNWmJTNlRRMW5oQ0RN?=
 =?utf-8?B?TDFDM0lUUmZRNVI2aGEwa3J5Z0pCQ2xSc1E5YjdSa0Yxc1JnVEErZDgydlhm?=
 =?utf-8?B?alBwOGNNUDR3YTYyT0lTMzZZd0tCcHZmak0zQU11cUtQMXUyamorR3djdmgy?=
 =?utf-8?B?dUhCL2hRSnU0Z0M4bHo5Z1I3Y0VaTjg3aTBEOHBuREhnVmxQdVB6NzNtalBZ?=
 =?utf-8?B?KzdSRU9ESG55Q1cvbk1xRk9NajBDNm53NVY5MkhCWVVjbFdGZDdPUitEV2hO?=
 =?utf-8?B?Ky9pRHJGcThGRi8zblJUc04rNFA1bmU5WHZkbHZjbFYzMGpoMkpUS3BZekY1?=
 =?utf-8?B?TXFRNDdMcjBKa0tUbWRBeEprOGhTNkhHYmR5VTNYR0M1d0htNHczeVJ3Y3Bo?=
 =?utf-8?Q?i0I0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elc0M0lZQmxiTFNDdWh6T1gza29VMVM0ZzAxei9iMUlzaS85TVhNeXQwRk1I?=
 =?utf-8?B?TFMrRWRCVmlvN3c2cDZ1akFZN3YyVks0V0tvMTBBODlJdmY3R214R0grRFcw?=
 =?utf-8?B?bWdhZUdXKzh3R0hJUXRtWERIdUlBQ0VCVFRWUHlibWdLcHN0bTZBa1FWaXBz?=
 =?utf-8?B?TFBOUUpWZXh6VzVybmxEN3BaYmh0OUJXSjlqM3pMVnpIS3Y0aHgvdXpUM2wy?=
 =?utf-8?B?UUZaMksvY3dlRU5qbXZuQzJJNnN3bkxwZng2SHhQLzdTVHM3cXovVmxvd2lq?=
 =?utf-8?B?MkpmQlh2ZVMzc25TR2F3d2w2eHlCenpYMzhCVlg4cE4xWnBQeEdaYktMakZa?=
 =?utf-8?B?Z1dlMjRrOTRneUZCQjFBWEpISVRDblZTaTg3enJuUDB4Nk1BckxqWW5mM0c3?=
 =?utf-8?B?NDByTWhTU2ZnejZjQS9QbDFkcXphVU91QjNUMTFHNmR1Kyt4eVlRYk5KRlI0?=
 =?utf-8?B?dGEwdEZtQ1VIdzRiZitnQm80MkUzbUNZWEFaVVRXY1hYVEhUOTNKRUMwYTVU?=
 =?utf-8?B?Vk1FNDNVL09oRHJrNlhFYUJvWnZKYXNxaCt0c1dzVXduRlJlYTFUZFhYdXVN?=
 =?utf-8?B?V1VpSVkxdmNid2ZwQWNWRndtT1pGTGtmQVQrOW16cEMvdDRHaVhrYURZV3Rt?=
 =?utf-8?B?RzhPTkNDWlIyWlJudDBvVE9PNlhtOUU5MndMN1JoWnhXUFVVUEI5SC90Ty9n?=
 =?utf-8?B?MzFDK1NKNDJadGk3alY1bTNNTzk3Y3puSkZlK3VrN1ROMFl2ZmkvZGtDbFlx?=
 =?utf-8?B?Ymc3ZmNkdmJ1Q0NzMDZiS0N3cmxZY0g3ekFiYVM0WnRUUHYrWEJkd3JYRjBH?=
 =?utf-8?B?M2ZyYy9DY3VtVnBRZTQyTzlqdkYyUjFXZW5oMnYwNE9zWGNWeHZRSUxoenlY?=
 =?utf-8?B?WDhMYnp6QmtJU1UrVWFaeE1qdkFtdGQ1eWdjMC9IUGRZeFNyeGZnYVUrYUhT?=
 =?utf-8?B?Y0lLYU5hL2NzaC9wVUlkT0E1UWhTVVRqZGZCUjRpNDNNSjRyWklrS2kyYm50?=
 =?utf-8?B?OTF0SnoxdnlkY1ZhMXlOVVZwbmt0QVFSUUhjRmg2YW1URVlXWEpJN29QSHd3?=
 =?utf-8?B?OGE1ZVJ0Z1pXbndYN1ZDYlhsc2ljc2RpZVdxakNQaTlJdE9TWDhPWkRrZEpq?=
 =?utf-8?B?YVFxUUE3ZlV0YmFVUVBOMkw4eGJQS2g2YkU0WHNpQUFOeUJZVXEvRDJuTDky?=
 =?utf-8?B?SkVtNTRGMktwT05QRjk5a3pxU3F3UVkwSlRHUFlmK1JoamMyNVVXQXg0U3Yx?=
 =?utf-8?B?RUxGWE5Lam12MWQ0a1hHTUdLd0pxUDVFaWFUUzRCd1krSWVQclM3VGliNVY4?=
 =?utf-8?B?YUNBTXVpQmI1MnlEZzBPaGRTcml5djR3djlFbzlKc0NTSkk1N1Jxd01hY0ts?=
 =?utf-8?B?b2E2MHdzQUZBdmROYUNpVXVVSzlxY29EVUk1TjN3NWZmaDVHRHcvREVvS0Vk?=
 =?utf-8?B?UjBpMDJ1K01lS0REZXJyeGtxVU8wNVlOTlZPYWZ0M0w4S2NqaVFTNzZVVlJY?=
 =?utf-8?B?aHVpc29DTlZ2MnBjTE5oZE9DZXZlRmE4WnpqbDMzQy83VE1HeWgrWXUwMnM3?=
 =?utf-8?B?a0tvWThMTlZ5WU9MSEw2MElvZDJCOVJvZDh6UjZ2eUxWalFNODJrb1crWk9w?=
 =?utf-8?B?VDdWalVlbWRUQ1VxVzVBY1FQVHl6Ykg4S0FoY2dmWjRnTXRQZ0RlMVZMVHQx?=
 =?utf-8?B?ZkpIaHRUTm9ydHJydlExZXJtYkVicVVGU1p1aFQ1SDN3T0tlK291dzIwWnQ1?=
 =?utf-8?B?RzJzb2pNdkY2b0RJdnhTMDNSVksvUFdGclczdDJmZjlWNGxNdzM2eUlNcFFM?=
 =?utf-8?B?Ri83K1dCOXNVNEpqRnFzcUFhRlJIMmJqUGVmRjRSRnc4VGR4ZkRHcUVodzZl?=
 =?utf-8?B?NW5EOC94N1QxVXlYaFU0NTBDYWlBWUtKaGtoVGdyL2VORUlnZ3FKRDVGUEMv?=
 =?utf-8?B?VWF6em5IaE1RcXIzOE5mSG5jZXJkQmt1NWF6V09MTUdmaEdQQXpmL0xDV2lr?=
 =?utf-8?B?TS83R3lyZm5oL2xTeTkyUTg0QUVKU3c5TTFSa09YUGlGZERxdkRqSlc2aG1R?=
 =?utf-8?B?VWxtc3IzbjlpT24wbGxacGdQdGdmWVkyTWJBdFM2ZUFlQTRsN2tKNDU4MnNm?=
 =?utf-8?B?S2ZSWTVGSTQ4R0tOcU51U1JXUHdQMkJ5c2JHYlFFd2E0dW1zbTJibksxMTd4?=
 =?utf-8?B?RUdDd0VqcjBMSUFMNkFEL2g1Z2N4eVpocC9tQ3Z2blNlcmVkNVdCa2ZlVXUw?=
 =?utf-8?B?eUI4ZC8yQ1FBUG1lSkVFQUgvaE42UmY4ekl0NmxvNi8xWStKQUlDQkN1RzJF?=
 =?utf-8?B?MGwwVWtHcjdNNHhialgzVklEVXNzS0JpSDlxK1cwUmF4N1VXVWxZbXZKck5a?=
 =?utf-8?Q?uDUff9PXgpd1I9TA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f26153-48e1-4a60-a67a-08de694dea15
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:14:09.6367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv29QBBZ1iw16Z1ULuA7mN1oFmDPbqlLBYWwZF/T3/cOwdQYI6DAR4IY+3q/iXo1Dnz20go33kK3q3tPCxOkq/gddUiSq23rn323h66+fes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
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

On 2/10/2026 6:25 PM, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 03:17:32PM +0100, Burakov, Anatoly wrote:
>> On 2/10/2026 3:08 PM, Bruce Richardson wrote:
>>> On Tue, Feb 10, 2026 at 01:29:48PM +0100, Burakov, Anatoly wrote:
>>>> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
>>>>> Multiple drivers used the same logic to calculate how many Tx data
>>>>> descriptors were needed. Move that calculation to common code. In the
>>>>> process of updating drivers, fix idpf driver calculation for the TSO
>>>>> case.
>>>>>
>>>>
>>>> "Fix TSO for idpf" sounds like a bugfix? Can it be backported to stable?
>>>>
>>> Yes, it is a bug fix for a particular edge case. However, as done here, the
>>> fix is implied by the code changes in the consolidation, and depends upon
>>> them. Any fix for backport would need to be a different, standalone patch,
>>> based on this.
>>>
>>> /Bruce
>>
>> So the original code didn't have TSO at all? I.e. this can't be fixed as a
>> prerequisite patch to this patchset?
>>
> Original code did have TSO, it just didn't support the case where a single
> mbuf segment had more data than the max allowed to be described by a single
> descriptor, i.e. where we had multiple descriptors for one mbuf segment, so
> that "nb_descs != mbuf->nb_segs + ctx_descs". The other drivers all solve
> this by having a separate function that iterated through the descriptors,
> and to fix this in older releases would be to add such a function to this
> driver. There is little point adding that function in this series just to
> delete it later here, so I think for 26.03 the fix here is best and for
> earlier releases the best fix is to just put the necessary code directly
> into idpf driver. I've noted this down to do a backported patch after this
> series goes in.
> 
> /Bruce

Got it, thanks!

-- 
Thanks,
Anatoly

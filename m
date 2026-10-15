Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F5ECC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EDC5402DF;
	Thu, 15 Oct 2026 17:29:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1D895402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792078162; x=1823614162;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n0D6NW8clMFxyeYM/z/QjrNZAlYpSq9OcwWGcIu7QdU=;
 b=NrUWQmTolOSUJPLWyXbkuTGyu2aNXBJ7vKgtb3Z8aQmbuGEklzyV95vS
 Ck1kib3qiSHBCBRgqEsltEwTymXg+ypuc0T7bhWc/jZ2lAAJm3TKa+h+i
 i3rz4QT2Ji6GlmVBMCscVnCcpHvYAmswM8CXvwzps+LoWXQ1idJ3LAVYF
 it+gor3s2kwfcrWXQr/hnJ4qGpUNOiRxpRINvs9QmSgXGhCoi/W3ugQLy
 u0eAhZC8McKTd4MR9NYygQwWrVW/M8Hwf91X+Love/h5g3cBwIISrx6Lz
 HhAUjg+XnwJOWGkmYBaqAMxkZlYY4HCvzezeYKcI8aPjGcOFSHy23m/4S w==;
X-CSE-ConnectionGUID: Gt1Lds0NS6+UNhpss4+YhQ==
X-CSE-MsgGUID: o7OLi6h4T8CIRZcKZsfqvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="853676"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="853676"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 08:29:21 -0700
X-CSE-ConnectionGUID: 8CsULq8bQja5JnxBT0ynxA==
X-CSE-MsgGUID: /of1qPlbQAmRgRVNjla/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1602329"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 08:29:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:29:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:29:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6XbLp5trl+mKsfYZaSsxfvaHDwbKJQIeVNp3wCmlD7KwprQtweTXzjfP8diI/sD3SBI7CsQ0s21Ud48bkBA5MGO/cgJouy8JGYarTWckoFNF6RczHNKMgxICN4AxSPea6/jAhna4AJlLWMlJFcss0198LVcyW8x756OflieAluH/GTdrWakXFXdccdpZN7ChxKYAL975UcxGQpCBTnNzlKNDRoZy6pYgMfoKTEubLisdoqkEu8PYgl0KniNYM9nvgTAZ40l1HNjj2HCyoiFYeUU4D9hmD5PRboN4AnsxbpgdWVQ9wjioMeQO/DPgSvvHUEWflKYUtbgsYq+3EWfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf782K1QtSnrwKXeF3D1tvMLuPvS9PRKThVSbA9ICJ0=;
 b=nB2JbR5k8D8yDmW3SenyP52nlKCrklLFEkuMhmUdycETkqHAV4QZEblmjq01+m49EeV3n0sTKr/JIIHEkZnjauR2m8/ZaiUoUNsm+jArfCNJTQYar1+7tzW2EgVcxxL00tNMLYxKAn/pmZY5Ar97WpoiLdPVNq6vs17S5pAeqXdSkmnNxyA8B6e0tKIQXSRXa345kxUVHOyALYOkrbLaPdqE4cWQj1dSO64gqHzs7/6h/hg+7OiOFlhB9gUjmkIaLWuctZtDDohbLknzY1mi6gbc2YZOhbIKLM9LLTgDtiH7ONHYT/oDsaUwj6ve0/Ly3fuwt+tx186+FH2sSlst9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CY2PR11MB590615.namprd11.prod.outlook.com (2603:10b6:930:111::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 15:29:14 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 15:29:14 +0000
Message-ID: <6e4042c1-3aa8-46d8-b931-ef6bdb714f12@intel.com>
Date: Thu, 15 Oct 2026 17:29:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 Kevin Liu <kevinx.liu@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
References: <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
 <46e98c80-f44a-4c69-93fb-050ccc864c4b@intel.com>
 <ef450e1d-34ca-4876-b94c-6a3dcd885f19@intel.com>
 <atDvZiRddrDI_mJD@bricha3-mobl1.ger.corp.intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <atDvZiRddrDI_mJD@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CY2PR11MB590615:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5c3188-0f4d-48be-1313-08df2ad11168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: iCcJWLw+aA8KWQYhMPEYOQjOad+Ec8IxzoY72L15qB+uVaTFH7uj+DB7GnWT9nsyC77IBwFbV6PP1RGAu8TceethYObAax8jjxDtTxOl4pxy/jMDPoavTR1rFy2tlEz+ZRXbOhLMlU3h1IgWJR+vcQyf/drjfc6FCoyQnjgNZeJf+phw7BhYQezN6lEvb/ptxonAdlLH8qnE6O5Nr3//n1M1dqCfnOrXVH+RR0m0sXnRFv+k42PcJhanuRbWe3sc6QzRDx27sYt+U8O88/jAWmBFqDpBPzr3dKQiO/+8/XrB7S4jpcySHynsLukymGulo8a5svFq5Df19eIOznd25VgaiaXg2XoCGCNoWlyFH41I1KbV6D8bAhjfxCpCfpRzv914ZtC/GptDQiHwncx/Ra4FfvGiUu594S/y920xzQP+8HgEng2HqTYU4xbQgUHf82y+nvPNjcpHW4974kUAUD40IASj/YnS81sCtvGE8mBfRhfz0VK/mA5xBmn648k5+oY3vfd5Kmz0WEauyJbkIZUDNJRnofyOEky2gmjud/MInGdBmiz3BYpHGbljHvy+vzXrUxZWf5ebHS74I0n2ldtOZkiHVbzp5Ta//e/lPUpQVgb9Qd9V63EquggaFye/YPk1L3O077TbelXtHeG8Q2PxLc8tmJCW2K68PwIXUeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mlo3amRKT0YxWFNQR21ialVWN2NvQlVBZzBUeVRXVjlyV3BJMnoySnFjM3dP?=
 =?utf-8?B?QkVjTWxXcnc1QVJYVzNsc0hTK0FNR1BiUHN2amozWUNSOE5GTHJMZkp1QXhX?=
 =?utf-8?B?UFZuRk4ySDl3RjFhczI3ckJNK05wM1NjeFZtSVlsc2ttZW0xMnNqUU5RNGhM?=
 =?utf-8?B?NDJVLzBIODZVbHlYY1p2Q3QwU0g4SDFEdkMxMmxvSVhSelVLZkk5UkdzeGZn?=
 =?utf-8?B?dUdscitkczY0S2VYSnhTZ25RZTZtMUZyMFpTcXAvZXRBVDZHREhIVnFzb2Zh?=
 =?utf-8?B?RjI3UTNCbDNTdSsrSDJHQ1FFRmd4cEh6RCs4MzczdmNBbWxKS1JwMU8zRml6?=
 =?utf-8?B?V3dqaW5adzlOVU9jRlhGTW9xN3dlSU5RZ0xxZHk5ZUtlSy9mZ3ZxZVh6L080?=
 =?utf-8?B?NklTSDhhdEJOalFzRUM4TzFPTXlZMFRjMU44TktkbkFWMTFxYkVIRUUzV1FY?=
 =?utf-8?B?ODAvQWxSQk45NWFGUEFFY2VUcmVDK1FkWjdoNEVhNnZPWlNLdG1jaHRDcXZI?=
 =?utf-8?B?eTFjcktTdlp6UWxLNFloRUtSejMwT0U1WkRaZDVyeS9ycjl4U2NLc2xMNWwz?=
 =?utf-8?B?ZTBCbXV4U3ZkQjQ4NFptYXRORnhHYTl5a1lCeGg4S0p2cEVMamI0ejVtS1JE?=
 =?utf-8?B?dDdEc09tNXVON0pSTjBZYWYvbEFuZXRwV09yYm5GWStjVFN1bmhqSHh3eFor?=
 =?utf-8?B?b3hSeGM2RzlmVjNtZ25TNVhYNlZrQ0kzcXNLdkN6L0ZoY3hQK1dlQmtvV0pp?=
 =?utf-8?B?d3p6L0dGSi9PeTNaVTNwOXhKN1FTUWgxWFcyTHEraXpuRlMwZVVnc3RyL0k2?=
 =?utf-8?B?OTB2SUxOdi9YQ3hrTUtWM0NmeVBUQ2taclhRU25DRS9jbDZQNDMzYVVvYlJV?=
 =?utf-8?B?eUtoOHVmU2RZRzh0b1dockpOWHZJejEybHhEQzdjNElMMmNHNjJFaHlFQXNq?=
 =?utf-8?B?VTZKZG4yU3hPaDJ3d0ZaZkR4aU1BcnEwQ3RTelR6MGRCVVl6WG4vbmROUkxT?=
 =?utf-8?B?aU1lQ2NOVTdQS1VwZkNXeGJ3S3hsZ1UvR0VKQWtWd0h6Vm1Xanh2NjhZejZr?=
 =?utf-8?B?RnVHRytHL1h2V0Y2RzViQ0RtUUdzRmF2bUxhREdYSWlUYWI1MW5xVHk1QmJ0?=
 =?utf-8?B?Uk1mWHFnR1lGNk1qM2pnRGV4ZXIxVksweHFLbGN1d1dDcHZVOFkrNi9Gcklr?=
 =?utf-8?B?cjNsTEIzMlhJY2Y5eUtEZ3dKMHhORXdySFJZT1czYjJ0d2w5d3VrREtWVE9h?=
 =?utf-8?B?dkp3eER6VWhDa3BFekszeFcwZitzNVlBTVJiN3VBYXJTaFlxZ1NZZTA1eUJz?=
 =?utf-8?B?TTJUM2w4aXZNMG1YbFJuNWs3Vk9sV0hmYTZaaGxZNEx1RDVHYlpyVDA4N1FM?=
 =?utf-8?B?c2Z6c1doYlJSdlpqcmZXdmxaQ1c4dEN5UW1lVGVKKzBzQVExS0pCL3pUdklG?=
 =?utf-8?B?eHJ4bXBNcm1MbEQ3c29GMGhmQlcrZjhwU0RLcTh6d2E1NkZzbzNJTzIxSUIv?=
 =?utf-8?B?aDE4UlhVTTZaTldpV3E5Q0NnUU9lNmlhUXN3VXU3NWQ4YXdwT2xCQXRsL0R0?=
 =?utf-8?B?WHRhdVNLYSttZ2J5cVo2MXR3alNJSG9EY0RPY1hpejM1QjZXRWlORUowa3FT?=
 =?utf-8?B?eTZQY2tUSFJ5OXBUdllCUU40TE9nWEI2a3FJT2trK21ZT1JIMG85WGZBd3Rq?=
 =?utf-8?B?MHcwc3dpT29XYStrQmIxMm1JMTFkV0VaVWRyRm0waFp6UDAvSWJvZkc5VVhm?=
 =?utf-8?B?N1h0U1h5SFVSbkhySVBwNjFFR3FwZlZCQVEwUEloTWdUVHEzTWVxblZkVTJC?=
 =?utf-8?B?TlpmTWVxUFpPSXJYNDZEOXhMYXBIYkxrMzRjeldkUDg2NVRCZ0Vrdk5tM2pj?=
 =?utf-8?B?WHRLejFQOENqL1huZzJ3MTFMQTRqUExycXp3dEEvMnBSczhJR1BIUmlNTlR3?=
 =?utf-8?B?WjNiR2k0U3RjNU5MRXE5QmkyZFpFVnZ2WlY0SlRzUmNZNVppbHh1MTFaZnZi?=
 =?utf-8?B?WEdtV0F5Sll6OXc1S2FGdzJhWWQ5eGR5aEdEalFHajU1TUNFVzdEOFlQd3Ux?=
 =?utf-8?B?RXFkK1BzMU52QTFUZStJRjIwUmJSM2kySXBwS2Q5THNXTjNKVGhERnRGWXFM?=
 =?utf-8?B?QmxLdVNQYTZsQXVjL2FGUlM5RVlyNThXRjhrUE9uZE85ajNrOStQVTBkblFx?=
 =?utf-8?B?bTRkR0xuTFBFTWtISGtaNFoyS05lZms0UmFQUkxISmpMN2ZYM3JzVFBpTjcx?=
 =?utf-8?B?NHpuTjJKdEIwZFpiWGdOUjdmYTZJRGl6Z2VUemNnazVaNTR3YnlVc1FQWWlY?=
 =?utf-8?B?cnlKU3E1L1VFUzhGQnN1UU8rUEJ5S0NVbnRaTHA5RDUyLzlpcDh3YXhGRExj?=
 =?utf-8?Q?nx6Zo1CetWHIe8aA=3D?=
X-Exchange-RoutingPolicyChecked: S07CYpQk3MufZyHCkuVrJaklfqwqqrhBR1KYYtUQ5QjD0szXRuFx67GnvY4I7DL2bTqnhME9+UhxjUE34v/tTFn4h4+CGn5/HaNr2sohwfn1MXY6VyYt+D3VIIK0Qlz2qHZgDm0vO2KQhndMBL9rVi1bmfiEDEtgSRnM7pMGW8v96JIrm4W5sSYRBscipSX1kUSvX6Hjcj1GjjtziRs0v7vnddp70AjoG/noaRYsEW1qFW7AGzKu12BxomzdEAhaD3NOkzwPCxH46ZZJHWXm+/EIQvhjo+wLmZ3aDgKUVGNuQeUIFJcgs6cgPjtZ00IXZBnFfYfN4iynRyoqOyH3zw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5c3188-0f4d-48be-1313-08df2ad11168
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:29:13.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RECN+daE7lzH8Rv83ZGLIaiCIttU1R6IpiDMRXuvnFUaWZG+gihgdDoeuYtoqvWbar/oUgCySERt/nQm61f1xjZY2QqM4o+lEFDGBjnPxzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB590615
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

On 10/15/2026 5:21 PM, Bruce Richardson wrote:
> On Thu, Oct 15, 2026 at 05:00:38PM +0200, Burakov, Anatoly wrote:
>> On 10/15/2026 4:52 PM, Medvedkin, Vladimir wrote:
>>> Hi Anatoly,
>>>
>>> One nit: the buffer must be allocated with malloc, could you please
>>> reflect this information in doxygen comments?
>>
>> @Bruce
>>
>> Perhaps this can be fixed on apply?
>>
>> diff --git a/drivers/net/intel/ice/rte_pmd_ice.h
>> b/drivers/net/intel/ice/rte_pmd_ice.h
>> index dccfdcd5f4..881dc4cc56 100644
>> --- a/drivers/net/intel/ice/rte_pmd_ice.h
>> +++ b/drivers/net/intel/ice/rte_pmd_ice.h
>> @@ -27,8 +27,9 @@ extern "C" {
>>    * @param port
>>    *   The port identifier of the Ethernet device.
>>    * @param buff
>> - *   Pointer to an allocated buffer. On success, it may be replaced by a
>> - *   newly allocated buffer; the caller must free the resulting buffer.
>> + *   Pointer to a `malloc()`-allocated buffer. On success, it will be freed
>> by
>> + *   `free()` and replaced by a newly `malloc()`-allocated buffer; the
>> caller
>> + *   must free the resulting buffer.
> 
> That is very strange behaviour! That looks like something a future patch
> should fix, but ok to change the documentation on apply here.
> 
> /Bruce

Agreed. My best guess is that the intention was to return success even 
if the buffer was too small, by passing pointer-to-pointer so that we 
can reallocate buffer of an appropriate size (as opposed to introducing 
a "size" API...). We will address this later.

-- 
Thanks,
Anatoly

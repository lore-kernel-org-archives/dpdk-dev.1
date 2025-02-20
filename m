Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB0C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 12:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3538F40041;
	Thu, 20 Feb 2025 13:31:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5AAC74003C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:31:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740054713; x=1771590713;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2IsnIolWrLlWTbw9ab6dwaw43sX4RcF93Y4BklXBRlA=;
 b=kak4lhE02uubfcNos18dqXSXFqZtkkPzeOQjQii3P1T4lq0RFYNCdsPV
 v+7cHRVWxVsoxX7ieyyZeJfG0l0fQGTBGyI2m0sMdWd9NUI/SSYxITBQh
 xQmKD+DH7AWVef3doYSttY0NeH1SU79JXNwel9hxzTjt32ag+9q4YlWfN
 RTFDFVV3qDU7+WFahovPUPcSRytpt5iC1hoc+rWmfhwqjY42ITlNTO5Gb
 VAvJgjCzYQhnk5SXOKhJtoRd7TBBE3Xg+EtmGwIJ3u7MLUgC2XeqEXAP+
 ZXVhhyccwA324c5bxi+S9di6lYahqIuVrlXuymnESH3uwpL771zfY1Nc3 w==;
X-CSE-ConnectionGUID: cVZczW3NTW+Y8U4OymN0iQ==
X-CSE-MsgGUID: 5c38YHa2QQyodegA4KEaRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41087044"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="41087044"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 04:31:52 -0800
X-CSE-ConnectionGUID: mSUZkUxUT8Smd5tCPWK3tQ==
X-CSE-MsgGUID: tu4OWitTSuqTbuX2A4pmMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="114760151"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2025 04:31:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 04:31:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 04:31:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 04:31:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydX+PjcGMZhsFwUyr0ba/qEONTVT4aqRQBYazexAIYN50EGc1p+CnLyFttMDXkUToJ0wylSHeMIMnM4xlpD4CcesVTuI5gpkBY5OsCQU+f48ATtzgsvtwaxNZi40rrKY58uEEeJKsvVaROVRNORDHxJKpdthMVH2PlHkqEwnyiQUweJ+m96XiKZYismsFqvYVgObEcMswcB9vdIO4J4weKBTvGwQF5Dv8/sIsLSJreTKWsBfaul9cgvTXwy5fnOUhfwRpYmGKAA2jG6BLQ3oth6gZsXEHAJ9/5Xyt4P4eEppc3NF7hOL3r+iDPtkVJkZLnffG4loSHcdfedpcMCH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdWTZc9DNj4Iu2eAD5gE0QlwPGUbbIXlB6LMVyUM/yY=;
 b=B1ftwWRjhelBFyHWAifh7BOJoUMAvNbjLiVPXxoZ3fkWMW4Uui6phjnTllG8It1IyvTocoOlX13SWAxxa6SfmkTkV/jx81skY4YjvgiVLKo3FGzZSu3mGXE5KOWG8GW2w/x25/+XEB8ZbrWXs5FsYm+Gws7g1Nn6h4GzVPzUfLCfQ/jThTzGFr4RXHZl6c4Gow//ku+LLLn1tP1OoCgmBVKCvNBiwRpN19cALfQIx5HCAk4V4kSCQ4kI4zHRbHPQniQ64EbeWeWNGKSsEe5XhS7FjLHFn2SBQAkSODg0BqQ0xEOj+bO61DN1XKNuhzPtjLnc9h0FZECrnIVlOr1whA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Thu, 20 Feb 2025 12:31:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 12:31:50 +0000
Message-ID: <c6f992dd-aa1a-4894-83e7-b912c7dfe33e@intel.com>
Date: Thu, 20 Feb 2025 13:31:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/17] eal: add new secure free function
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
 <20250216170110.7230-6-stephen@networkplumber.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250216170110.7230-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM6PR11MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: caf42e66-b80a-4ed7-d402-08dd51aa8c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVZ0NFp4djZuU0U2WHVZMlpPKy9uUTZOY3lSOGp5SDdTSzRCaWtmbWhGb0ZX?=
 =?utf-8?B?RDJnV1NvbVNwM2N2NjM1S01Dd0lzUnZHY2pVWURiUkw4Nkp1MUVhUjhMSGUy?=
 =?utf-8?B?cHhmQnQ2bjZhVjVBVDdyd3VPaVVMVkdveEVOOUdmOFVtcFNSd0FrZDBWVzlS?=
 =?utf-8?B?cUNYOSs2VXFOVUhRRm1HVzFEMGVBTmlkTFhjZ2pub2YxNWJpZFdvMGEwM3F5?=
 =?utf-8?B?eGJ4M2ZqS08yVHVuN2kvamt4dTQ4LzZLZzc4eWRyVFIxOVRDU1oxRlJzSWtB?=
 =?utf-8?B?WURQRXhEZmo1ekVlVm15c3dYRFBDWTgzdnFTaU9FSVlGa0hzRHJHWldKbitL?=
 =?utf-8?B?aDQydzVIV0hIRkY0engrOEhxL1JpZit2RlZQR2hxTm9WM0M1SU95amhqMk1G?=
 =?utf-8?B?RGxtcGZxaVowQkd4SGdaSU42dGhONTFXYmNOczYwVm9QZzBVN2xsYlAxYk8v?=
 =?utf-8?B?SHlCRFViNmJUOWQxNVVtOUM1MW9OeFo5aUs2SWVqRStacERvUGFybWZ6OGxm?=
 =?utf-8?B?TWRjM3RKckl2ZHplQ1MrbFB5UE5lcXRzZVM3OEcyakgrRDBad3NpYXBBOTFF?=
 =?utf-8?B?Ry83S2x0WTJidVFIT24wcGxNMEdIRjVFSTdFV0lBYXZ0UWVoRlJzaUpGWVI5?=
 =?utf-8?B?NDdhL0hNbTc4QUZ1cEJtNTFEeTBXaW8yY2xiWEtZWTlpMEZ1MjZoV3NYZlVy?=
 =?utf-8?B?M1JoOUVWc21OMyt5cUdGaGhKOTYrb1FQMkkzbHcvdVlUNHJxYlZqbUFoRjc2?=
 =?utf-8?B?NGtLaVlISlV5R084VGdOVmZCK0g3VjhPVmRuZjNUc1RLbVk3c3c3K2duMGlj?=
 =?utf-8?B?eXp0U3ptamxtYzAzYkVtYnRMUHlRK0loRHhNVE5XK1E0MUhPd0pCZmRRSWNR?=
 =?utf-8?B?SDV3M2ZPdTRPV0xEZHFxbUdpdHIyTkltSFF2QVoxTG9qaHlXMHFjVHVkdFY3?=
 =?utf-8?B?M1dUM0lLclJqZUpaS3lWRThNK0Y1S2Y0Z2tvUmxqMWFiTmovbjhtNU5WUldz?=
 =?utf-8?B?S0U0V3gxWk5HaXUvcHpqdVNPdDRaSmhycGtkMzE5OWVnWjdlTkt1SE9EV25u?=
 =?utf-8?B?RkpvaUVoN3ZZSkJzVExxUFBCM085NVFTNjkzb3dwSU00L21VQktuYVQzR1Yw?=
 =?utf-8?B?RDlxcWtaWlNVeCtxWHkzMjR4bGtRYm10TWRIUFhqUHFoWllaR3BKK1hhOWhi?=
 =?utf-8?B?N3ZHZ09KS0F1dldqbU9tOUhIb3VmSjNOaTZIMlhyV3c0djlzMEpWVldQbjNt?=
 =?utf-8?B?SlpCdHBGK1RoSzM1emdhNlJsOHh3NVhDMlpIbWxXdEtyR0d4TUNzUWllTFJl?=
 =?utf-8?B?UldUbnFIbFF0TUltMDFlOC9aVUdHcWxINnovc3BaZXVSZ0lNL25kZnlRcTJM?=
 =?utf-8?B?NXAycEsySnp5amtBNjNuYnB0elFZQnpUZE1teFZ3R1Q3clBSUVp6SHZmQmI1?=
 =?utf-8?B?VDJLc0pjQU16ZUNRR0NnemNDR2x2b0V5eWFUTEk3Nlk3ZnBHQTlZWDhGS2tS?=
 =?utf-8?B?K2JQSzg3dVgrUUJlMGVaVHN6S2lFTDVTS2JDN1hVNlJhVHgxalNBWlk1SjFa?=
 =?utf-8?B?cTNRV053WE5EdWZqcllIMnFmZzkxVGdQMG5yY2o2REkzM3ZlZHJaOG9GRzdQ?=
 =?utf-8?B?V1FQeFl3SkJSYk5kenNBRS9IbWNJeFpRK3B3SGVBbXhna083ZjVnVUMwUUNP?=
 =?utf-8?B?Nlk5a0c4SWlzS0RlREltSUtGaUlNb1gyTi9sU1BzTlVtNzFtVU5QTzdESGIy?=
 =?utf-8?B?dnpQUytDOGZKSzQxUUNBVGhKNlpSamZRekNnVDdSdk9JNG94VkkvdnduZUh5?=
 =?utf-8?B?Nlh5b1BTTHBrWm1ReHkxb3BJY2sranlaMlBEaS9kQ3ljRnpFd0ZML25iZnpo?=
 =?utf-8?Q?zsNXvqMhE5v0y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azEyblRVUklpUDhRVmVtSlJnejJ0cGY0ZG5KR0sranBySlJwZUthK0tiNUVw?=
 =?utf-8?B?N1ZTT3NUT1ozMFM4U3FjYVMrS09zdFZCcXJ4UnQ5ekxCckhsSjFDU1gxQ3l1?=
 =?utf-8?B?ODhUNCtubVVWejV2dENya2lrNEVIMWM0UzFGbHdmUTB3QlZ4aUVKUVlmWnF0?=
 =?utf-8?B?b3ZhN1BVeUtqaURhODQvekxpbisvT0JIOWRhMmxUZjIzclA0YXZiZHhVaUJu?=
 =?utf-8?B?Yll0dzBkSFhhbTRIaENFWHZpSEpNOVJwUzU3VE5sL2crT0xNR1pXaWFIdU1S?=
 =?utf-8?B?bzZqSW1XaDB1RUVlN2RyV2Q5UjJ5MzZVRmkzNmM4cDk1RDJTY2VtWDM4SE9j?=
 =?utf-8?B?aEdUT2N4Zm4vSTcvZm9rT0xQUXJLMHVXMWFOd0ZxY25ROGNXMFh6OE8ySUlS?=
 =?utf-8?B?Vk5sOXE4dWRRWG5YNnNMdUo5djNma2tDRXEydng4WmE5c0VTWjhjcG51R0NN?=
 =?utf-8?B?eEpXYnZoZzFnSUxrcmZpanc1U2xtRVBQLzJLTThUQ2E3MGJMWE5wNnkrTCtn?=
 =?utf-8?B?c2tEclgwWEY3R3luNzAvNjljU2NhMVlZT2RVRnBPVk5Pc0tuRWlSQ2JBN3Zn?=
 =?utf-8?B?R0RYRE9oWDhkempZeXU0a1dIRWZGdk9ZcEcvbWsxdUtjNkRWZjlGNjVCdGpz?=
 =?utf-8?B?YW9JRmdiaFZHbWVzWk02QzNGV3hFRmVuejRIVDJHZDAwWE15QjZtTDdiZGNW?=
 =?utf-8?B?MmRsWm9zeXFPaklDWmpLQVpsTDBPQzBaYzBaSUh3Z20xK044M1pUUVRZc3Ry?=
 =?utf-8?B?SlRIczhrZlVrbTFNbFFPcitxUUk5T2JPbVUxSzZ4Y0VsQ3NCV043UXdmNnox?=
 =?utf-8?B?a0FqQjlMT1JQd01JVXZKZWNRajlCRitKVjZ6SHVMQmU3dDhmbUpwaUUxQkZ0?=
 =?utf-8?B?eGJQSlhLSGpibXZtMWs5T1Y5SE1kaUpkZHBRVmxSRGQ2a1VZWnFoNjhZWEJr?=
 =?utf-8?B?VVErbUNDMnpoTk9JSzdPVzFHRTNKZWhqQmhSd3huclhXM1dUZWcrT1VPSFhr?=
 =?utf-8?B?K0JtVmNZNGh4UkpaRENiNzNjTmhIUGRxUFhGeUhmOTdnekFIMUdzUnlrYzlu?=
 =?utf-8?B?MDlabC9TSnFoSVlVNFZTS0J0RFY0dFVpSG95SFJUN0hta1dTUk9WRlEyOG1I?=
 =?utf-8?B?NTVPaXVsR0VSNHZNY2FNSGxQb0JuWE1LOFhON0VqSmFGR013WTVHVFpxQ2NX?=
 =?utf-8?B?eDNKUExadmpEOFJxb2oxdXpySy9sNXZuZHEyZCt1KytxUE56akhYVWtmUDB0?=
 =?utf-8?B?ZHZRbmt3Z0RseHFsaitEb28waFdpREFuNk5FWmEvMFR4OGt6QlgrQmtJaUlD?=
 =?utf-8?B?YWpyRkUyQlBoemtKTHJQVXpVVzQ3MUhPQ0t5T3FDRGYyQ0xzckFvTURxUHlU?=
 =?utf-8?B?ZUVCTkFhQXRBSlR2UVNxU0MxWldrM2VEYjh0UldPV2wrSmx0bFRLRHUzaEZ4?=
 =?utf-8?B?NUk3L0drQ2RWYzVDWWs2Y0dlc1NNUmJjdWVSNkNteURwc3dLUzFpcVdGVVE5?=
 =?utf-8?B?VzJWWUdFenhCV1d6UjJNTnZmZzlaaGxrTndPTzVVRm02YWY3Tmo2bjluOHV1?=
 =?utf-8?B?VXRJRWwyQytzT2NhdEJaMDlLWStiNTU2aVJ1M0dCQnRSQ2xwWVlrWGY4Snlj?=
 =?utf-8?B?SVFsb2hmaCt5MHNtRnE3ZWVrdTlxelNmdEVnV0E3cys4dDFWMGFudDl5aHJX?=
 =?utf-8?B?Y0ZwNVBLUVFXS2lqSU1yQ0tzYzRuRWJ6OFVEUk1ybEJjTnZ4cGQ4Rjl0Z0J5?=
 =?utf-8?B?SzloRlRha3JONGp0RURPTWtWSUFWNlI5S3V0NDNaaWs4SVYxN1g2Q3dqejFC?=
 =?utf-8?B?Y29yWnBQRG1ZUWo5WW9XdkVubEkyeHorVjhRbENTN3dPQjAvKzhncW1QYVBD?=
 =?utf-8?B?RXRWUno3YlNHalFmVE1qUjlaRkVuQm1jSlZWa25Wc294dFRHREFrS0QzUk1h?=
 =?utf-8?B?djdEa01ZQU40Z05CaWg5TzVFWkJhS3BKaDE4RlB3bk84VFJiOXUreXJxQ3hI?=
 =?utf-8?B?ZWlMbjdZajNTbDhvVVprVTlyUkZMK1A5bXVBakFOaDJFa2tVUU9SVC9Eb2Vo?=
 =?utf-8?B?NndhWlNxbmF6Tkx4WXNuV1ZNeVBuNTNkWm00azliQlpWMWp2QytNK3lJRDkv?=
 =?utf-8?B?cHBHUXhUSW1RVmduSjZCVkFvQlFCSk5nNFVqRDVDMUsvZnhRaVNheEYvYVNF?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caf42e66-b80a-4ed7-d402-08dd51aa8c61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:31:50.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt43n1p93l4Qyt45OAqlRmdp5hClymkXjbw6lPC/8dtmFM550pswbJlx+UNgvuLlsM3j5m0MQOYwuKUo98XpUvlzuWub3UmUsuOGJngmVtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
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

On 16/02/2025 17:53, Stephen Hemminger wrote:
> Although internally rte_free does poison the buffer in most
> cases, it is useful to have function that explicitly does
> this to avoid any security issues.
> 
> Name of new API is chosen to be similar to Linux kernel
> kfree_sensitive() to make porting drivers easier.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly

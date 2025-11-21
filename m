Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40328CFC269
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 12:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F78402A6;
	Fri, 21 Nov 2025 13:06:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1370C4026F
 for <dev@dpdk.org>; Fri, 21 Nov 2025 13:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763726772; x=1795262772;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=PALmUecdfVzqGoS+Tx8gWA14CIwGcGGk39iTcgLzB+k=;
 b=k7DS8eBwo9GXxLBTiNZiwjX26wUJQrOEFgwiqQTaNW3l4imR7Ya0KlW1
 gjhXMZPBu5YYFyAj5gwJ827v3CmRjTa4RvqjbBqwEa5qmq+1YGhww0WPS
 xtCmCQL7LRAtUDgCtOciZDPYmy4jt8cC0BhalM0t2eUoweZ2tMbO7g77f
 rEbAmZL8CLkAAQAZpaoELsAmMGWkDrlly5huuvrQqr6FsS1SnfH95k5YW
 6rM9fZZSGPk7ZTbUaj5FpORiVz5eqdDWO9NZOthJQK6z0exznzn/aSh2J
 jd+uF71esfViq8sIvBHbWaFaysokMqV2VUYTaa3HvscGokrjTwi49+uaM A==;
X-CSE-ConnectionGUID: +XDuHEuaTeOr16fR654BTw==
X-CSE-MsgGUID: I33e79y4Rgq6gg1FkwCP4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="83208906"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="83208906"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:06:11 -0800
X-CSE-ConnectionGUID: B6g/jTgsRui2r+CvCX4rWQ==
X-CSE-MsgGUID: jVjXg8I9RuuRITbPr8XCqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="191556779"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:06:10 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:06:10 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 04:06:10 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:06:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDny1FN7S3FaSDd0pu+06XlmGGe9RiPpmVSNlFXm5wXDewJrPpcFQV9YJ/7shBq1vS44pnxxJO2LBrC7LF1NOfV/8rnmJpm6qDElwRHEDLqiYVFqUYZW88VCoYMqFp0QzrgP1EVCcfQfCLQR/zbA+0eB9BuyPmxUE3X7cGt8JbaO68xv+m+SqU7d0j+kTx8wYikhmyCzD+83UxSfkcg48gqRw5Pxpkqg874+HR49to5z1L4I+YmH1mNczkB1/RpnscGAE7OUQPzNVn9m4aa6JHBurIg0aMxIjzv61SCnCtl0dK0ypN2hE4H7O/gzdYOu6V0s8OR/rA3BbUuOCY7CeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3YRx6vCkn3tDaTKkAuFuyXVD7u6J1yin44kXvxMg8o=;
 b=FCHNjZFYan8IMN1ebkvpwVQ5fb7bbNasUW19E/jq026DqCjlXJtl6KT2rt7lVTxtN34Zddux3pxqWu4f34eWcPVc1EPiqVIrXVMneVA6voFckBhS9QdOnVXbBZX9VTC4UFvfVVDfejrRlf6ZMus1NqNMby5ksm+FX0n3L9FcW/XKyNSUZm5zblH5+vNeu9J/aCLW+KnOls7eliD7ZsvMyre30RPns+LTNkyUuDtHnx+QiCxAypA3qPiWG4MYoCGXfq5PXSLoWdoUmeaYLt04XdE1M/7Zigg96f4gHS4buDdrpjBuUND7aXEQpyPhUWCyUHullt32stf5Rc9FZFLGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH2PR11MB8833.namprd11.prod.outlook.com (2603:10b6:610:282::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.11; Fri, 21 Nov 2025 12:06:08 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 12:06:08 +0000
Message-ID: <21dbee1a-bde4-4682-9f46-e41498a9c1e3@intel.com>
Date: Fri, 21 Nov 2025 13:06:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] test: use unit test runner for eal flags
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
 <20251120165713.120238-5-stephen@networkplumber.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20251120165713.120238-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH2PR11MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 678a49f5-2a01-4c34-5a7d-08de28f65a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnFrVllBak8vSVkwcWQ3VnFzQlBQckFjajR4VVBsaS9kQTBvQ3h4R014UzZB?=
 =?utf-8?B?a1pTRlpGMy9iemk2ZGpkcEZkenRPVHBIcGVDSnZ2b21KNjZFS0JoRXRvVXVV?=
 =?utf-8?B?OWtDVGtub0U4Qys4UGs2c29UMEl5NFJUaDZSQldQRURzZUVWZ2hIRitDak1Z?=
 =?utf-8?B?SUFoOEh0OHNtNWZTbzNpc0EyZWhML3lwdy9pRjFNVnd3R0xFazJpM1FJRnky?=
 =?utf-8?B?eERnem5WbUxxOWpRSWM3SjlpUitVT3R3VERiZzh0UlBMNXE0Z2dXMzJZUnp3?=
 =?utf-8?B?NXV3MHphNXNXYllJSkdQejlkU05ZcTVVQ1FreGtwOGQwcml1UlJJV0p6bTlB?=
 =?utf-8?B?eVJPb3Z4MlN6ZEhUMmRjUkhSWUI1Tjk2ODJiVWhnbExpUW5wZkFHbzB2dTQ3?=
 =?utf-8?B?bS9HaXpaZTJwR1pGUWd4dEhjMVE2SVFvQVZySXBObkpWaGx1TWNuQ2NsK1pS?=
 =?utf-8?B?UE9qSGo1dTJzLzFCRU9kOVpLMUZnZFhlQkFMRWxTVlIvMC9iQ3N1RHV6NUMy?=
 =?utf-8?B?NE5MVlFYSzg0UXdWQmR0eCsyR1E4ak4vdEg5cUV5bE15TklLcDcyN3BvWWlN?=
 =?utf-8?B?bkpLTXdlTmpqbTJJUE5LOEc0SkQ5dGFlbFVwYVZITkxCcWJObVJTTWpnTWRL?=
 =?utf-8?B?d1laT2l5ZFBhcTlxOXlUVXNRd3dpc3F1cG5scWwzNXo1SDh2U0ErNExxUGZU?=
 =?utf-8?B?aDVtVWc3TGN1dkNTMWg3eXFNQTYvdUZublBaY0hnRzNHaDA1RDc5Z0ZnSWZV?=
 =?utf-8?B?dW1lai92aGpiSURFcGtvUmpOd2UvNE5rRnZMS2dxa0xQbnZSbVNFVkcrajMz?=
 =?utf-8?B?NEVpMkRNYUg0MlVaZlVRc2RlQXpYaFMzR3hYU3g5c0pRdEZvdXhQMFNLeXpX?=
 =?utf-8?B?eldsOWIvdWRKMGt5YnJ0VUZmSzdXVUsyaThuZitDNVVOM3BvWk1jenpETS9U?=
 =?utf-8?B?d1J1QjlPQTdacmJKL00zYTdSYWlFaUJlQ3NrNlRiMUpIUUoyRWxETGhYYzl6?=
 =?utf-8?B?blRPMkpFWkxjeEUzWEhUK2JoT1J6MzdkenYxaVFpcnhsc1QwemNGN1dqcDR6?=
 =?utf-8?B?L2F0aGFPUWZXYVlBV05UUkJqejVyamdYYS85YXV6MXF4UWJDUVV2ZG1IU1Mr?=
 =?utf-8?B?NG1scEdFME16M3FGT0JDbGtBRVdUcmVTd0dqRzFpK2JrbnhIVW5Hb2JqYTdr?=
 =?utf-8?B?eU43aTlzejhVMmxkT3Z5eXQ5VXBhZUdKRzZwWC9BK0wwUFNSdWovL3RBRDJl?=
 =?utf-8?B?QzJXdmk5TWV6QkJLUmNvdWVEYjN0Zks1STljM3k4VXAzQm16WG1hVmx1VSs3?=
 =?utf-8?B?WW9ZYlY0TWdnVVNaR2xQZEdCWURBbDNnNFc1c2FlOEFPMHR6TjN1WW04Yllj?=
 =?utf-8?B?dGQrYm1lbDR0Sm1uRm5GQ2RGNnpLMTRnUjZQMmE2NXVIbjhid1hIRCtOWjlR?=
 =?utf-8?B?NEMvL1FaczFwem9GWjhSUGdiTkRmNUpuOVY1YmV3NGUzZmtTSmpqNG9MOVJV?=
 =?utf-8?B?RVo5UkgrOVJJdmFCOGtRNC9yNTcrY1E1YWtMS29Oa1p0Wnp4WW5yMHhCMEJ3?=
 =?utf-8?B?K01ibzNIVFovRE5SaHJsaGhHQmthSWJYR284K2ZzQXdaWk1aOHdXMmFBekpJ?=
 =?utf-8?B?aHFNUE16Njl4NFNtUHhGbXBnYUN0SVNVQXFsb2llNXhqSTJhOTJKcWg4eUoz?=
 =?utf-8?B?OTJuYmRmTnAvdVlXcWxmTndyTjdUSE1hazlaQTJYbVovVUNuK1AyU1pXMHV0?=
 =?utf-8?B?b0locmJaR1NXSHRwLzFwOCtSNVRkSVpVNkNCTGgyY3dNQmJqWFI5ZXpSVVlt?=
 =?utf-8?B?WEx3WDBBVk1qNklrQS92MGNGcmtpNm9GbWhZelVaaUtacXVoY2s5RVZYZTFz?=
 =?utf-8?B?YnRWZWgveTJhTHRPaWsrZmJqUTFVbmphaW9zdUd5TnMrY0JCbUtCdktyOWRp?=
 =?utf-8?Q?eIT2an0c+MG5g0ZINegwK1//juvnmos0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNKMkRTYS9JSWk1MDJRUU1MQU1Cb0pQYnZ6amtlVWVPRXh3NEdKU3QxeThN?=
 =?utf-8?B?OTR2M3FjUjN0VlFCMld4K0dZYlorYVQzSTZaay9VWFdPTVA5QUtpelIxMXRV?=
 =?utf-8?B?Z1oxVlVKU25NN2t3RlZTNVk3RnJkSy85U2REbU16Y1g3Q01JYjRRMzZvSmJx?=
 =?utf-8?B?VXdGb0xNdTVCdlpnM3ZtQ0JudzR6cVFjT3BIcmlOQ3JmTFRRcDVUWWJsT095?=
 =?utf-8?B?d0VxUEJUT3JaajFpU1I4WGlZYVFPb0p0Ymp3cXFsNGZoTTl2S3JWRU42dHZL?=
 =?utf-8?B?MHArWnhTalpvKzFOWnlyRDZNZkJMM0paOUU5WnJBWEsydE1EV1FzQ1BQSE1t?=
 =?utf-8?B?Y2Y1WFRaWXZ1TVdQQzdtaDJFWitOTU5vUm13ZENicWg1Q3RCZmtSRGxGTzJR?=
 =?utf-8?B?OTJXTjk2N2dacDZHT1dZQXpIMHMya3pCTDFBbDlHNXh0ZDFSaHFZMmF4T3VE?=
 =?utf-8?B?SEM5OG1qTlBEWjVUOHpZdGVaWGwvdVhqTjZnWFNQTTJSZGppc0tYUWhXbTVw?=
 =?utf-8?B?WW9rYVNNQUNFTWwxYXNITTM4MWErY2MyeHBQMkc4QTMzTU9wTERzWld2TURU?=
 =?utf-8?B?dFpuaGw3SDJSVWJJSGNoeXFSL2owb0NCZk5PT2Roc3dXeVN6WXl1UVNkciti?=
 =?utf-8?B?R2U2emhPZElFUHpucmZTTWhXWk1QMFk4RmNERGJtcTdMOXRlSXZpQmtDTTd5?=
 =?utf-8?B?TWxFZVJFZ2FnY2tZcE5QdC9LZGZlRGRCVndISGdKVnM0THFsY0ZpeXUrQWtM?=
 =?utf-8?B?b3BqN1lKMUE0V3dENUtleFBDNUl3UlRCUVV5UGVDVkFsVGxZdUEyQWdZcS96?=
 =?utf-8?B?TEVPTU9LMjVFTUlCYlVGdDdMVXBzZEVyai80S2U2WTZtVG1seGZhRmFoNzFv?=
 =?utf-8?B?MU5iRnVJbnhvT2F2OHFid1pHOUYwUk1VSE9QZ2lxaDNjMjVPZ2h4NnFUZjRq?=
 =?utf-8?B?RE5LaDhOWEJmcUhJRFE5MERPMStobXNHeVVsSGxUREhDQVdiaEU1VFlDWmVu?=
 =?utf-8?B?bDVCRE1MaXgvbVRyaW02WkhuWE4zMWdwOCtCQTI4bjFqRmFUZHBuZnVVTnQr?=
 =?utf-8?B?Q09aTUNHdDM4Um9TWUM4UjdoTGttdFVQa0lJSm9SNDJUOTE4N0FSZ3U1QS94?=
 =?utf-8?B?Wmd6VC9IZ00xTHdtMzNGYWJ2VHNYbWZoRGhEZkJUV3Fackp2VEtjVjlWSmto?=
 =?utf-8?B?QXdsOFZNYWZhT1d3bDgyUVRBeGxIZ29iNHVXK21YUXhwaWhOL041UnRnaUd5?=
 =?utf-8?B?Zll2ZUcvMGJTcnJDOUdQRVk4MG1Ed0ZNbzJVcEl5MkwyNk54NHlORHh3THow?=
 =?utf-8?B?LzhtVkdPaGMxb0RORzlqa3lETUhYNW1jYW1RZ1RzNVRpWGFwbzdaTWVkSmJx?=
 =?utf-8?B?Vm53Qml5bXlKRENpTjYzOUZFby9kZXNHRHpVUSsySUZtQllmTXBWYnpyK2Zh?=
 =?utf-8?B?UFJzVDFma1J2b0Y1MHVPM3ErbGRydkJNSlRmeEFmbVAzSUV6MUZYYTVwT2hN?=
 =?utf-8?B?VFdNSzd0dWptaGVERzVUdURoenE0NnkrZ3QvcGwrUmJSRVdPNlNlRkFjSVkv?=
 =?utf-8?B?Z3VNZllFQ09rRWRJR2hibzdEQU1NOWpEaTBsOXlFVEhtaEp2OXFwMUFFRmJv?=
 =?utf-8?B?d1ppMy9Kcm0rRHpqWGZRK1g5ZTRnVHVjSWxKbzllZnpLZTFSdWFEUGlmeWx6?=
 =?utf-8?B?NjF4emdxS2lza2s5aWRBMFRDWVp5QVBFTzRzM3VNV2F4cjJqL2xzTy82SnFi?=
 =?utf-8?B?SDhNNWJDMUsra0VXQmNRbXVWQ1VyM0pwZTh5bm45OHVnMEdXMlQwbjVpTEF4?=
 =?utf-8?B?QTJuUTNaM1FZOGZZa0dmVG82eFZidm8vTkZIMWlhUzl0dHp5US9iL1ZQNlNv?=
 =?utf-8?B?ZTJNb1orS0Rac2RlM0hxdEJuNGh6L3ptRWNkdVdJQmhyTWg2Wi9BWFlFS0JG?=
 =?utf-8?B?ZGhEV1ZNTWwxckFTT09keERlcUhrM1Q2U0c3YUhGUW5SS2JVQlFUKzNRdXc3?=
 =?utf-8?B?L1Q2azUvbFdOaGxGMk9mL3dWaVpMbFFQRG5DaWthbkVLb0VhSk16NnNGQWVl?=
 =?utf-8?B?aUFwNmJJUlF1ZWlubFdkM01MTU5UMFhRdGJ5K0g3dElRS2VCL1Q4SkdYYzcw?=
 =?utf-8?B?b3I2bmpMbDBZMEQxSC9TNXNCRGROc294ODNjWXM2WmpndlJlTEFvemJxTDRI?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 678a49f5-2a01-4c34-5a7d-08de28f65a99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:06:08.3979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp1V8IDEZ1CFB6DLnT9rxAOtqOrTDIOm0YIfdQvfcIO8v5MmsiBknbBO0y2v7+Up28tAejCJreIBgDxpyHHR0j/VQpicUwmyqWjOEnRpZ6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8833
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

On 11/20/2025 5:55 PM, Stephen Hemminger wrote:
> Make the sub tests in eal flags suite into a group
> so that they are not individual tests.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly

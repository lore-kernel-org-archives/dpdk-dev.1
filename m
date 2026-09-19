Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD2C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:09:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A149240655;
	Sat, 19 Sep 2026 18:09:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id 5B4874064A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834173; x=1821370173;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=UxgXFCdBS8I2CkQISGLUpAJFIfsA4WfYzwOgYSQffB8=;
 b=KmCEhK26qBat0qxF8tNBoMKCVQeg0Ku80QG/BALMF2LeZ2ivXgUkYJio
 405R6GQwHoh1xTb9l4fABGslKF+w6eI8a9sZzQvlHELTVSp9ESviKanAr
 /I13HBOS8T827Ov5lEtXZQxZEX09ilZEgo7EcsWhuCDFI3IwjA6Z4U1k4
 uyQe6uCgo7uo2q6K7PgiBFbZn+WM9vmJVQ9QbqRTinpuRFH54kLifxSaF
 m0zSsfx/6pql1OlU5/Kx0YhXcmw8U/WAMI04tWJex6ay4D0WQRqq/m3P2
 +ih2/807ys+uJ+85kDU370An52IEsv5dCJEylC5JXOOcyX+ANz0YSUNFM g==;
X-CSE-ConnectionGUID: U/kOb1M9RHCIBufmubooIw==
X-CSE-MsgGUID: rsNZuG26ScaQ3cF1f/LsAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="861480"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="861480"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:09:32 -0700
X-CSE-ConnectionGUID: P/KV7TkZTJWQQWC149dOSA==
X-CSE-MsgGUID: 3U/AmtMuTaS5BMgvt5tFfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3062024"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:09:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:09:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:09:31 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPK13uXPbyFvNpoCg8OSPG32FR3JEbgwDQxymEERRALXZD6AGOpV5Iv99t7CGqSIjMziXDk/vEwot2H6lqaRM6UUX5YceY+7Kpo3Wt6k19FUwAcj6KZ/GVQ2zb3lcUC0BqBulPTne1LlwsJniyIWWm1xVc4kcXPFpv2KcaemsKm272CTT4/P7fVrIOP3bmN0BTtEhk3Iga1XdvxO1hIp3XWm/MuWCBFmINVG7t1s1UtM1Qxmb773UadhrGUnffx91Uavt0CtWyUoE956CeGPC4ci+zrysgtwkliTV7ZwPBbFAOKqbGHxLfYaaDsA6QpeyxNdrhC9UFL4ZSj65cw1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br1/ayfWGtZKocM1b1IO/PuM9SrysTTnaXnLJ8e+n/Y=;
 b=yKpe7j/+bBA2ZcdoC571XlIkgoiuHw69EAfPEgqD1kJP0hyIWngXtSys228vnc74pdVEf4Azlenp/+5mgbFrAmUZQ27t+hB5b5dRrYGFT2EwN9qa93BNmS19DkvRAItn7TDPq1dYt8LlPimB1cABqP1b/m/EL7KKh4wiIh5PYPd1Asg8o7IoO80fvhyqPNs7qTa0n+IKIknuZBzPYNV6ZJcOatMFv87MCXv6qwn1uuBcHBp5g8OKk0dT116kXnKBq3SgpGGrrdTywZQgMWuzbhB59g/yIXEog5VWNa8PTW2Xp48w4C+J6TbnFLvoBSOosqCUQDHluk1mKRAlh8yxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:09:26 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:09:26 +0000
Message-ID: <cabd590e-46ba-40fa-803d-fb0c559fd655@intel.com>
Date: Sat, 19 Sep 2026 17:09:23 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 02/19] net/intel/common: add flow engines infrastructure
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <63c3a0cb245f38af6da4d14547aaac9a4789c850.1789560944.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <63c3a0cb245f38af6da4d14547aaac9a4789c850.1789560944.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::10) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0eb334-20bf-4ced-d031-08df166860a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TPSWAY5txyXTHDOI8+L8wnrRLdooyaBJuUzBhPTXrVgld/79sLg8VnqIK5pSBiOt0XzQKirRmZ57Lu4nT9lXpKzShzzGBNNqbhQIuvvqhqRcuZgNTxuPjnFm5AiWBvcdd9xB3VATpsvwCKqhT6xyYQpO9VN3IvpGwZfPE8L0tW2KBwtAGViWEO/7N6PYLCtPMYhyZ5riBx48MO8Q3bb5LGfKSiCifkie9ggL9/I9m7QJ+Haixcf4zrEBip6c43hM+Y8snL+Pt/cei6+DOv27jIPINQ4DvHzOTbCl2LO+/gbB35ueNwLaIKZ2qaUr+dZphmfplVYf4xJNANczgfegunvQazvFbt+OqlqoREVTq2lJrJlKaXFa+dAjwnTk+9AMBO0YO95ALAF7VvHRBdpPFLiCOjTa3TQFOJBnMSsRKl+RWb+tylEqq8KYP5mZWFglC27u3L6y9QHm1rI5gNeu0kYL8sMvozNtSXdCUXAF6iKSYsDjH8k6DXwnqoePVxZWjfPudFtzpVtHWBqs4KbjIc3fN78/tNITqytLlEqLTpCtauZljHaUfRDhdwHCaHhA1q6zB7ClkHYSLEHzu6ysKaAuM/boDGiTPVo3H9ipFEX7PKsDsR74oIODx5qBgFkUzT1IBzcPah1hGbg2Rd3f2pPxyu9aShj66XX6DlkN3uM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1kSlRQNXNOdjhXcG9mYmRaRitaamVtN1FqYmJiVmRDY1BDVGRCY2FNaWps?=
 =?utf-8?B?Um9rVTQrU2VqSVAyUWxaUmVON3p6TkRIbnVIUExhN2Y1QXRacW52TUYwTlJl?=
 =?utf-8?B?QSt5S01SajN2QjFaWnBLdXBaQzVaVldVQ21mSUFIQ09QVHM2NTUvcUdUcjdV?=
 =?utf-8?B?QmpFWlBiaUp4S203eDRXZXNHU21wSXRDMXMxMzRSQWNBUHJMSldJUnVkMy9U?=
 =?utf-8?B?UG5nZXJkSFhtbGx3clVHV0FBK3l2bnNtZnBWMllHUUpZSEUzL1E5cVB2bGdu?=
 =?utf-8?B?cDJmUmNJVjNzSGl1Vm9ORnd3OXRMdzVtNGtLSnpMWDJQTGpXZm5kVVJ1RnpS?=
 =?utf-8?B?dSs1L0k5QTVuaTNYaXh2Mjhqc1JLTGJTa21wU1E5SGVJYkZFajE5ako0Q2Vx?=
 =?utf-8?B?d21YRVZ5d1RCK0tmY3ZyWExvL3pkdkhxNVAydEJHZXRFRis4UkJIQmpRQTY1?=
 =?utf-8?B?UCtDU2R4czNSMDVsNzBzckJvME1jdUZkT2o4dTRyUTM5Zmhjck5tUCtXRDNh?=
 =?utf-8?B?YWJhcFVKNzVXZHFIVVhtSTNtbDcvRGJnQUE0V3hYR05GVno4bDR6UE1QMndx?=
 =?utf-8?B?YnBpZmVndWRuZVF6QjAxZzFCSUMvcFozTnM4TS9DR3RwRGtNNWZOQVBlNnRy?=
 =?utf-8?B?WlhwRjhYTDB0ejlDbW9GOWU4MUdRZGZVTEk3K2lqOGVRVkpYV09OQUF1UGhR?=
 =?utf-8?B?VVdlVnZTaXdpdWQrVmZ1MGswT2RJc2E1WDJTdzBzV05LSTB4bFRLTjZQVG1v?=
 =?utf-8?B?cjNrT2I3M3ZGZVp6TCt0U1MzYXlvRVNmdEwrcjBNa2pVOTExQysvaDlTUm4y?=
 =?utf-8?B?ZUVoM2JsS0hmaHV6VzVKL1RuTU5MTkVFZEE0TnNVaWgvbnIvQmVDT1JIeWpE?=
 =?utf-8?B?d1N4OGo4K2pkMjhhMHYzdFV1cHBQZXdpaEl6bVZ0bTB5UnMwQ1VwY3N2WTVD?=
 =?utf-8?B?SkZtOUZvRkgwWnhkeUFZSGtZem94WkVhZS9oVUF1blBTNXZpUVQyOHNDUGlw?=
 =?utf-8?B?dHVTK2d3MkptUlM3YkNmQk5CQS9GRy9JbU1kNFVkSzloV3pZRFlKT1JwaTNF?=
 =?utf-8?B?WUJkc2ZPWUg2N0VXR2gzT0M1WFhZTkZSVTY2NVN0S2YwWHc5U3lUczd6Z0JK?=
 =?utf-8?B?YlZFOUJmQmwrVjYvVXNyeWwxejRVZ1BJOWZrd3FGNkFjaE5yNk05eEdodXln?=
 =?utf-8?B?bS9tRXFnRE5jRjBOeXJ6SFJReVkzQWNqZHBER2c4NHEwbzB6NHpla1FYT3Zh?=
 =?utf-8?B?U2pZOTJKMkpUM1YvSmdIU00vZyt1a0trWmFyVGtCMzFnMlFma2UzUVN0MGta?=
 =?utf-8?B?aG5YWHVMRnl6ZVpOa0N5WjlsYlg3TisyZHlGRGxGKzZkbzZRbkw4bEc4RTZG?=
 =?utf-8?B?c3pleDdnN1VRUzY3aWpaSUtlM016K1BDTTkveGM1cXZxdUFYc3VOUXZ0T0Rx?=
 =?utf-8?B?SG1rRVBJcGRtSVZlTmhhYWVaRHZUMXRKVWNvUTNLQ1RrbHhXWitpNnhjSTN5?=
 =?utf-8?B?d2xLMDZNclp1VUYvTFB2dkNhRlpVNDJKdnNiU2trQUt6SVhJTFFpOFU2eTFn?=
 =?utf-8?B?UXNtVG5ESWk2cm12U1h4c042dTFFR3lUc09lSVdIZlBxdm5vL21RU2Jrd2tS?=
 =?utf-8?B?NmU4S2FwYS85SlE3MkdRazh5ZmJQNzkxbmo4d3FNay9EMHZ5endBKzBvYzZm?=
 =?utf-8?B?Q1dyZURCMm9Oc1NEUzE2SEJqSFQ3ZC9KcEphdHlGNnlTM0VoRlYzaGZ4SjBo?=
 =?utf-8?B?SzNGdTE0RW8rNGM0dHFacG1ra25CRTY3blEzUDk2Zll1YXZ5d2RNSlB0RUhr?=
 =?utf-8?B?SDZRZzY4R1BnUEg2ZmMrUXhFR0w1MFI4WE91UWk5T1cxNW4xcXIwM2NNWUp1?=
 =?utf-8?B?TDI3dVFSNmJjTm8zbTNzc1BUZlJvQ0xaNlFvSyt3VWpjOU9GZ1VKOUppcElB?=
 =?utf-8?B?QXQ0WUk3TW1obmZDRFhKcmZqNFhTcllibHlTWU1vSDNyd3ZReGc0MmhUWlJQ?=
 =?utf-8?B?WitIMEdxV0grL04xcmpDOUpUZWN0bGJGZ2lyM2UvVmt6SUVJT1NONzRYLzUw?=
 =?utf-8?B?c3huWmxiOUVxVVd4SVVrY21wYW5BSFRSN0J0NEQ2bnpjc3JGTEZDRTkvZjlF?=
 =?utf-8?B?SklHWlFPbkhQNVE2aUtFcFg1MW0yYmpTRkttdWVXNmVwMXZTR1VNcWsrQmFT?=
 =?utf-8?B?R0NYOWRyb0dRNjFGVTFadGVOalpvMG5JK01VVmZoOHNObTR0bVNuWXk2UTN4?=
 =?utf-8?B?QVlMMG1HYlFWbDlqMVVLUHF4NUlIV3hpNWQ3eGNvcTd3N2RteHFRb1phYXha?=
 =?utf-8?B?cWQraytYM2M3TWlKd3hUZXVvYUxxazZIVmNqVUE3Q0VTMkgzOU1VcitQcEhw?=
 =?utf-8?Q?yFmZeq+RzC4oN+lc=3D?=
X-Exchange-RoutingPolicyChecked: FGWKlQ1UHERO58xDANYydKHy01T1+mTafp4fEw1g+yWrQSmQmKNnWKf5Son6Q9vEdjO5UqRvNXoqnu8qQUXQDb+MI/iPup1NEJACkuGfja2mWLsGZUxXHsmxKrfgVdzvYK9LZih+TpF5ds7jbmzETKIcVN9Z08HubXJYBrXzDJfSE0+8N/v7ekBQ6nrmh6lXTuDITGXRZJa1YI9E76/J2vhPKHgG5Ba8y6TefVlo499QHOdl5XYyrtnVzUJiRmrsV82bEl/ZD2Iq+n1shjPTNyX67cdjflSJBRDxszqxCrBCr9NAbVcMiIUosJG6HLgTytAWwOYobDV+Ci1q1iWysw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0eb334-20bf-4ced-d031-08df166860a4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:09:26.5255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgQbv0snqdWGUitcMXiy/cLzJetLXj9cQR9z58+x76sNdNj0n8+c76xVPb6Q7qRQabrNU2KC1tl9oEye3BGCAbsgIiZ7T3lt2Gle/xPckbA=
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Current implementation of flow engines in various drivers have a few issues
> that need to be corrected.
>
> For one, some of the
seems like a missed word?
> are fundamentally incompatible with secondary
> processes, because the flow engine registration and creation will
> allocate structures in shared memory but use process-local pointers to
> point to flow engines and pattern tables.
>
> For another, a lot of them are needlessly complicated and rely on a
> separation between patterns and parsing that is hard to reason about and
> maintain: they do not define memory ownership model, they do not define the
> way in which we approach parameter and pattern parsing, and they
> occasionally do weird things like passing around pointers-to-void-pointers
> or even using pointers as integer values.
>
> Another common problem is extremely convoluted internal tracking, flow
> installation, flow replay, and cleanup code. This infrastructure is usually
> done in an ad-hoc manner that has a lot of boilerplate.
>
> These issues can be corrected, but because of how much code there is to the
> current infrastructure and how tightly coupled it is, it would be easier to
> just build new one from scratch, and gradually migrate all engines to use
> it. This patch is intended as a first step towards that goal, and defines
> both common data types to be used by all rte_flow parsers, as well as the
> interaction model that is to be followed by all drivers.
>
> We define a set of structures that will represent:
>
> - Defined rte_flow parsing interaction model and code flow (ops struct)
> - Defined memory allocation and ownership model for all engines
> - Scratch space format for all engines (variably allocated typed struct)
> - Flow rule format for all engines (variably allocated typed struct)
> - Engine definitions that are compatible with secondary process model
> - Implementations of common rte_flow operations
> - Various supporting infrastructure for parser customization, e.g. hooks
> - Support for using custom allocation (e.g. for mempool-based alloc)
> - Support for replaying all flows to restore HW state
> - Support for removing all flows without modifying HW state
>
> The design intent is heavily documented right inside the header and is to
> be considered authoritative design document for how to build rte_flow
> parsers for Intel Ethernet drivers going forward.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +/* enable all engines for a specific driver instance - caller must serialize initialization */
> +static inline int
> +ci_flow_engine_conf_init(struct ci_flow_engine_conf *engine_conf,
> +		const struct ci_flow_engine_list *engine_list,
> +		struct rte_eth_dev_data *dev_data)
> +{
> +	struct ci_flow_engine_ref engine_ref;
> +
> +	/* reject invalid configuration */
> +	if (engine_conf == NULL || engine_list == NULL || dev_data == NULL)
> +		return -1;
return -EINVAL?
> +
> +	/* init the lock */
> +	rte_rwlock_init(&engine_conf->config_lock);
> +
<snip>
> +/* parse a flow using a specific engine - caller must hold config lock */
> +static inline int
> +ci_flow_parse(const struct ci_flow_engine_conf *engine_conf,
> +		const struct ci_flow_engine *engine,
> +		const struct rte_flow_attr *attr,
> +		const struct rte_flow_item pattern[],
> +		const struct rte_flow_action actions[],
> +		struct ci_flow *flow,
> +		struct rte_flow_error *error)
> +{
> +	enum ci_match_type match_type;
> +	struct ci_flow_engine_ctx *ctx;
> +	int ret = 0;
> +
> +	/*
> +	 * Determine the type of matching we are going to perform based on the
> +	 * presence of pattern graph and pattern_parse callback. The logic is as
> +	 * follows:
> +	 *
> +	 * - if graph but no callback, match against graph
> +	 *
> +	 * Expected default case: pattern matching is graph based, no special
> +	 * handling for any pattern items.
> +	 *
> +	 * - if both graph and callback, match against callback + graph
> +	 *
> +	 * Preprocessor case, i.e. preprocess the pattern with the callback
> +	 * before handling the matching to the graph engine. The assumption is
> +	 * that the graph will be set up with a proper ignore list to skip over
> +	 * nodes that weren't meant for the graph processing.
> +	 *
> +	 * - if no graph but callback, match against callback
> +	 *
> +	 * Fully custom pattern parsing case.
> +	 *
> +	 * - if no graph and no callback, match against empty graph
> +	 *
> +	 * "Pattern is not meaningful" case, for engines that do not care about
> +	 * the pattern at all. A default matching behavior against empty
> +	 * patterns is provided (i.e. allow NULL pattern, and allow END or ANY
> +	 * -> END patterns). Note that this is not the same as ignoring pattern
> +	 * entirely: the engine will still reject patterns that are not empty.
> +	 */
> +	match_type = engine->graph == NULL ?
> +		(engine->ops->pattern_parse == NULL ? CI_MATCH_EMPTY : CI_MATCH_CALLBACK) :
> +		(engine->ops->pattern_parse == NULL ? CI_MATCH_GRAPH : CI_MATCH_ALL);
> +
> +	CI_DRV_LOG(DEBUG, "engine '%s': parsing flow", engine->name);
> +
> +	/* allocate context */
> +	ctx = (struct ci_flow_engine_ctx *)calloc(1,
> +			RTE_MAX(engine->ctx_size, sizeof(struct ci_flow_engine_ctx)));
> +	if (ctx == NULL) {
> +		return rte_flow_error_set(error, ENOMEM,
> +				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +				"Failed to allocate memory for rule engine context");
> +	}
> +	ctx->dev_data = engine_conf->dev_data;
> +	ctx->attr = attr;
> +	ctx->pattern = pattern;
> +	ctx->actions = actions;
> +	flow->dev_data = engine_conf->dev_data;
it was set in ci_flow_alloc()
> +
> +	/* parse flow parameters */
> +	ret = engine->ops->ctx_init(actions, attr, ctx, error);
<snip>
> +
> +	/* no engine could handle this flow */
> +	CI_DRV_LOG(DEBUG, "no engine accepted the flow");
> +	flow = NULL;
> +	rte_flow_error_set(error, ENOTSUP,
> +			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +			"No flow engine could handle the requested flow");
This unconditionally rewrites error string, don't we want to keep the 
last reason why flow wasn't created? Same is applied for validate.
> +unlock:
> +	rte_rwlock_write_unlock(&engine_conf->config_lock);
> +
> +	return (struct rte_flow *)flow;
> +}
> +
<snip>

-- 
Regards,
Vladimir


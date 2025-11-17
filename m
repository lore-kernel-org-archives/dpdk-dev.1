Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE24DCEBF93
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2C6E4026A;
	Mon, 17 Nov 2025 18:00:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6CD5B40262
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763398840; x=1794934840;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6DH9bi6iytBDKpToK5E91wQEhfauOpjqXjsXvfM4LUs=;
 b=eWvROuWytumDIUVf4l17tZYlHKaydYrnXsvN80BYSGtTUfM/ou6p018/
 yiHqSIyOD4lYnlpskmBqqI8YMP5QSyhv5oGmlFht3vEEK+O0csQE/qxxm
 txT2R+uQVoDEk0cvkhD/OHNNxGTUmetu84hDT4YgaFlBHZAFbPOXJnxtn
 OgJVhkNGqwK6nZm57+rNxzlMoCNQF2R3BJ1Y/dNM1f9ZmAH56x5TsXuiE
 WSTrMdB5bcdFRZ9QB10Ayg9hcFo0N4Z+RgvaxCGAdu8h5B/zyp+niVkyw
 QDJ14QvoM7Ax4ycPkncNoZlgfwuatOVJTIMS+O+tnqTwS9e4WiC9XmugJ w==;
X-CSE-ConnectionGUID: cC4avBqhSQCQ0ERs1prLzg==
X-CSE-MsgGUID: 3LNl4D1uS2KQHuK/iG3cyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69025248"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; d="scan'208";a="69025248"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 09:00:39 -0800
X-CSE-ConnectionGUID: yTpyz9arQa+oRZ798GfIWg==
X-CSE-MsgGUID: ziSciCR/RP6j78QgTHHgIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; d="scan'208";a="190522869"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 09:00:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 09:00:39 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 09:00:39 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 09:00:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5qx64kBhTmvp1RG/ZDNX30ulhETz9dIR1+/QRcLTv/RvWyMLaSenCqpfLH7Hd3nWBMt1rC0wULTPWuTV2qEPsAdWLV3UKU6c/o4xDifLLbLP1ADlNHb8/Vetz7Pz4n9F5JOpnmxRu7UUtbqfKW4lOzakIr0WvBGozPEFtt0jTqXBa2k33+9XHXX92Xk+LAjFhLoCxu0nmkVTnoAACnrPOnCph3qwWGVSlQxlsogTJnSZDbSMJJV8OCOJlL9MpQPx4RatHvowVfKLwMcEy3XOrYWkkW2XAsszLQ7KXQ3WKhERhObf9u8Sr+hAB+lM4RKIG1sdz//WUXWE7OXUvRlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lab9dBi6RNRboxaAlIBuQqNXy5dM1PD4PazpI5qwBuo=;
 b=WdlLXSTA+MSysSZMok9+bJ9vPFr+8ZWBMRANzHLjThPm1pOzhvVVVR2NxB//wGd52BRUF9xCD/SL+pfbvRuh6aNdmsK9AxSm9kwcGRUA1wePGLWS+SIXZlkHs1DiLpuRGVrvyvmYMtuqlQ68ofYdwb4jdrjQIHjl7dkOuqHQV9OMPeGhmnCXplER0HOvsoF1TDwM3MLzac/Jt+NkHQ8Cox9HSt5vez73FnZytSLDXKYhtWxy30PDKxNa8Rno3uXF/7ub/ZOUI75uqJ67qe/NCePqz1dZs+Nr7hKEL2xo0Ot/1Txf9OfbjdC8ndyJK9fakmMO7OqLIa2ATSAJAQ2lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by IA4PR11MB9321.namprd11.prod.outlook.com (2603:10b6:208:566::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 17:00:31 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 17:00:31 +0000
Message-ID: <d89c471c-e5c9-44ed-b2f1-4c87ec916886@intel.com>
Date: Mon, 17 Nov 2025 17:00:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] app/testpmd: support multi-cores process one TC
To: Chengwen Feng <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251111091303.39491-1-fengchengwen@huawei.com>
 <20251111091303.39491-3-fengchengwen@huawei.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20251111091303.39491-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::26) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|IA4PR11MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ce64d9-0e5f-4933-b5dc-08de25fad0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUJvOFpmczhUS2RLSGJ4ZVBvaW1GSkIvRVVlSEJwNzVVR3Niajd5Z1NNd1Rp?=
 =?utf-8?B?RU05MEhRbWFqRXppSmFvTDNucEJBcXplVTVIVi94b1gzdEpJWWxSdUFKMHZh?=
 =?utf-8?B?UUhDWllSc0k1N3k2dlFjaU1kWGJRWHg2TEpNdXZPNFFLeDdUdC9HT2txMWRz?=
 =?utf-8?B?UkNWVUk0dFNTYk0zQ2h1anhXL0g5RXAzaE05dnBqa0U4a1JpNGJ4eUQzeG1N?=
 =?utf-8?B?RHQzQmF6bzA1Q042dE5aRGM5WitlUXA0amNPSTA3NTFJZ0E5MDlDV2dNSUtS?=
 =?utf-8?B?dVNyeGNJZlFPa0Vibnk0MVMwWnFaM2N6eDV4TmpFS2YzNUxPUXdNVk9icnB0?=
 =?utf-8?B?QjZSM3hnaWNlMS95dWtjeit5K2c1dGwvL3Ntbk1JOFNxTlh4Z1JGZlpvaHhx?=
 =?utf-8?B?a3YvZzZkSkNJeW0zMVBCR2JtaFF4V3NYQU5NU3NZWk9VbjFFZVNCQ1QyU0Jk?=
 =?utf-8?B?d1ZRNWFLOXBIck5QNXA0ckF3Smc4cVZSK0RIR1dIN0xvcHd5c245TGJEaUt1?=
 =?utf-8?B?SE5BTCs2UkViVWFpRytqMjgrcDcra3hmQS8rVFpHYUlQYUhaVUtFK1h5Z2o0?=
 =?utf-8?B?UEYyRld2dWpHUmlxL1VXL09jUTluNjJoYVJuMTB5UnVMS2l5TllHQUw1Wk1t?=
 =?utf-8?B?R1JPZU9EZFZkam5hQmFNc2ZCaExGMmZXVHRqNU5Zb1BCN21TSmNZK2RSVFEx?=
 =?utf-8?B?RVVqa3pEaHhuRjcvaEgzUVNjRnNaVEYzNGFYVE9qeS9SaWI2T1ExQ08xdTVi?=
 =?utf-8?B?b1QwOHE2eVlCZmhzd0FkampUc2lNUmpUYUZjNm5jUWV4T1I5VlFWZkQyWkE0?=
 =?utf-8?B?ZHczVTFJbVh2ZkdrWHJqd1A4ckdkSUUrNmYrcjZlNzBLY1dxUmh5RFBWZnlm?=
 =?utf-8?B?dzZ2cjVYd29MZE1ETS9JdlFSenFuMHhjbHl0NDFzdW45bUROZkxUTDhoVEQ0?=
 =?utf-8?B?c3pGWWdFZEJlNkVxajlRMWM1WGwzMFdoTXh0ZE1pYm53OEZKUXlydUZhWDRR?=
 =?utf-8?B?N0NaR1E3bHhsM1JvTkhFcG4vRVh5dGJpcjZLdEpnTEYyMzJxRUFIbmxjZmxX?=
 =?utf-8?B?WUh6cUFPKzlTVmU1Nm5aTmlqKzV2SHRkV3FJOGQ4ZVh2dzBxRTZiWjd2THBP?=
 =?utf-8?B?V0hUZ0JNZzk4eENKRzFOaVdDMnlsdURNZTVOM001dVhLdyt5SHN6a29pZFNz?=
 =?utf-8?B?WkVKWGt2bWZxdHJZY2dody92MG01UzVMVXh2b1hybmt1akpVTHUxM24veEUw?=
 =?utf-8?B?cE1lQ3JRdi9zeW1rZW9TYW5lV2VGbkFLRGVmV0dpQS91d0U5Z29TR0V0eVpD?=
 =?utf-8?B?ZWhxKytBT09ObDJmMHhhbnh6OFkrZDJiUzBIMGF6MVJ3L05DYUovb0pKVXFm?=
 =?utf-8?B?V1lsTzVYRXIwdklIeTNZM0Y5b1diMmxXSE44UFU5enFoVDgydXRmbUNuYnhw?=
 =?utf-8?B?anZENVZPdHNIU21iWEd3OVdrY1Z1a0JBUmVuWExMTDlvRlBNaEdKRXNVL1dV?=
 =?utf-8?B?YmZEYkVjVThacFNZdTdKdUNwQ2Z6RkZmalNVM3hwb3Fqc0RERk8rV1RMNVJ5?=
 =?utf-8?B?THAwc0Q5MGNaOGp6QjJaNFhSMU9lR3JJYnRib3Y3Q3FDV2tiWE5ZUTNnSG1R?=
 =?utf-8?B?V3BRN1lweU1mUHdIbU5ncTFqUEJIYmVrMWdTZ1hNMXBBdDFKNldZdUdFMGZz?=
 =?utf-8?B?aWlWTExscnZDc3UwdTV5am5udXJWNTBvZFE3c1ZqRWZMS2ZTczdPWkZ2elIy?=
 =?utf-8?B?Z2d4RlY1TnlOS0Nxa212Qm0zdWJqeU96Ni83Q01JdENMdGlUUkFDMElVSGha?=
 =?utf-8?B?NytWWFNyOWRoVUV1b2tralhRNXA1NE9lelF5MFJ0cmJxSktmdzQ4a1p2UFQ3?=
 =?utf-8?B?Q3ViekFpeUg5N2VGK0YzR0I0ZlVtdHJqeUdBUUc2WlY4WHczTituUE43bXNI?=
 =?utf-8?Q?i7rBe1VKPAPfz2E7V4sMkZItoOmN+RPW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RnRXV0ekpERHRrUVBXY2hiWGVLbS94MXNiNlROUGN0cndYL0FtU2h1Wjdx?=
 =?utf-8?B?OFFrMnZHSXFueTJJeTd3UlQrTzh4T3pidDQ0YVdlb2pKMlZVQUZvd0N5Yy9Y?=
 =?utf-8?B?SFc5SnhqMUhVdEYxMlJsOVg0Q0h5MGlLOGtYemJBcU1TMEdPb2p1b0xCR3B4?=
 =?utf-8?B?TldKTXpvR1VpMFVoUjVlby9wdUZpLzExYmR1VkJ2T0dVNkRaNVd0UzhMQ0Fs?=
 =?utf-8?B?Tm9qVkcwQW8wRW13YXU4ZHFjZE1IMFVMM3ltOThUVEtBNFZ4UGhMNXMwZXk4?=
 =?utf-8?B?NzVGSXZKcFkyY0FkVi90UE9ndjl0SE51RWtBNDhhSmZLdDdjaVJBM2txTXB2?=
 =?utf-8?B?M0psdXNhSm9LOU9qWFBwVjc0VGpLNFlEWjBKdkMwc3ltS0U5Y1FadStUeEhT?=
 =?utf-8?B?OE8xUWw2UXlJVmFHN0pFZGZ2QURqaVJ6emd1VHMwcnpyREhEakZIWmxmQmk4?=
 =?utf-8?B?aWoyMlZLRHkxc2NNcUswUGNQRmZYUEQvblkzVGFiRFN3M05BcmhRRnVlZWVY?=
 =?utf-8?B?dzhSb2M1MTI1UTU4dEQ0U0hqQzJRYjdxTDdqNytHcko1NGk5eUpTR2hDbGxJ?=
 =?utf-8?B?cURFNUxoUEcxbWlHeXRZVlZQQU9sNGdlQzI0SW9ENU45ay9NSElORkQyNk1W?=
 =?utf-8?B?VHQyMnpxMDZQV1M5Zk96L3BHYitIRDRORVMzSnBTaWhPYXdIU2JKQ1kwcHN4?=
 =?utf-8?B?TGNjeUhyZWpOb0Zaa084SDE2RmdpWWdQWjZLc1JLdHZaM3RUSElhSnpYcjhP?=
 =?utf-8?B?amxtRWtsWlZaUmM3OUMyU2s5dEFoRlFBRC9nZmZOaGhDVjNXRWU5UG9hWm5G?=
 =?utf-8?B?TkNCL1E1K2lKdDBEckV3QzRQN0srOVgraWlybEpnNklUTjFva3dCbHBNLzRP?=
 =?utf-8?B?alN6MUlOZVZhU2hiSXJqcVJTRXM3S0FLY1gwbVNGL1ZqTkJwS3kzczhYdE1o?=
 =?utf-8?B?eW42NU02MkxqSXZEOTg1RVNxUkp1ci95b1M1SStkM3BTUzhGRnlkR01HUCtr?=
 =?utf-8?B?UmNUTE5QSTI3THhGbFUyYitLTDdYSXBDUG41WCtDbVZpdzMvM3Fhck9JMmwv?=
 =?utf-8?B?Vy83bmJvN2NnQVcwMkJkSHhrcmNoTXdZV1M0K25oVGVyenJtOEpnR043WTlE?=
 =?utf-8?B?eW4zVXpHRkpKa2JyY1phQzcrMlpsRFpzZUtGalR2OEcyWUVmbzl0ZHlRV3Zw?=
 =?utf-8?B?dGFlSEJ4NjNKQWpzakJicUFWNk5oVi9rYWxWVVFhOElKeXd2ajVYdUNJNDdk?=
 =?utf-8?B?QjdnWWgvRzFyNDNaS3YvN3Q0aldXcjhubHpNZXJMb21LVkIxVDYvUk5hZEYx?=
 =?utf-8?B?YXZuZkRPM21kZFlkVTZmN0xuOElGbDZRcDlXT2lSclNJdDdFS3d3RkNoMmJo?=
 =?utf-8?B?Qkt4cGhFSkI1R1BnUWFtNDRqQm5wdGFzbXFhYUNUeFJLZXpIV0lVN2k4TStn?=
 =?utf-8?B?MENZbnRUSldsazIvc2tkR04xWHY1ZDJsekJwY0Fneno4M3RZb244TCtxNk5y?=
 =?utf-8?B?QXFDV0tKZ3lUQ0R4MVVGYklZdm5zcmxLRFhMaWxmRDUrKzB1MTV3K21uTWc0?=
 =?utf-8?B?VEd6S3d6Tkp4TGU5QnB1MmtUWjJrZldxWlVicDl4V2pyV3JUcTcvUXlsb2lP?=
 =?utf-8?B?ZitkTHA0eW5qM1FhZnltUEhVY3lFaTFSRFRtRzlUeXZoNXJNK3VkRkNrS1B6?=
 =?utf-8?B?dlNXRkJXOFdMYXRSeGFKSnB6RldqRGljKzhVM2crcVo5TFYvU081M1NnZk1E?=
 =?utf-8?B?bzB6OEdkd0tMMjVvL1I5WXRMajFpbEx1TENWeTJFOW9pRjRvWmJYK0kvRVpL?=
 =?utf-8?B?aE43NlRGbzhuZnAwYU9UOVlzeTRTZ0w3Ullkb3laVHE5NFJkMHAxNUpmZ3Vh?=
 =?utf-8?B?UnNwbWJFdzNabmI4RWpJK3dpT3JNbUFZRGhUaXdQY2gyTlNaWnlIM3I5eTFn?=
 =?utf-8?B?WU9IK2w5K3BFckRjMHAySW5lUUtEVTkvUDlhSW1DVUVVbHdTQkJ0M1Jpdk9q?=
 =?utf-8?B?TGk2ZDVJZTcxckZjSXpnVDlJQ0JVdnJPL3A5QzJNTlhwY2VpZDByK3dUZFFZ?=
 =?utf-8?B?RzZqQXBDWUw0K2cxODRUaTJkMWVrS041c3VhMmtaTUU4QUs3cEZCd28wZDBF?=
 =?utf-8?B?S2dvYmMxVFdmVzRsMXBWdlFjNGREZUZQY0N4OEFZcXJ6aVRGMnQvcE5SamVP?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce64d9-0e5f-4933-b5dc-08de25fad0d0
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 17:00:31.0370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysrSd2XHTyHGtf91Bt+sofk8XRLehzZIqV/K7xOrFicL3PfBm28Xx4OiM3i7dKMBryE5amN3m71x/wxAqwpgRn1XGb7qhcd9tC2+uwSS4KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9321
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

Reviewed-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 11/11/2025 9:13 AM, Chengwen Feng wrote:
> Currently, one TC can be processed by only one core, when there are a
> large number of small packets, this core becomes a bottleneck.
>
> This commit supports multi-cores process one TC, the command:
>
>    set dcb fwd_tc_cores (tc_cores)
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>   app/test-pmd/cmdline.c                      | 48 ++++++++++++
>   app/test-pmd/config.c                       | 85 ++++++++++++++++-----
>   app/test-pmd/testpmd.c                      |  9 +++
>   app/test-pmd/testpmd.h                      |  1 +
>   doc/guides/testpmd_app_ug/testpmd_funcs.rst |  8 ++
>   5 files changed, 134 insertions(+), 17 deletions(-)
>
<snip>
>   

-- 
Regards,
Vladimir


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4047C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 12:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7196F402C1;
	Fri, 28 Mar 2025 13:54:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C537640269;
 Fri, 28 Mar 2025 13:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743166468; x=1774702468;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5RC0cYSZnT1ydVH0wxwOyA5ih3B/8hR8ed3WDMyr6iQ=;
 b=S82EmMNiSVZ70bNlLBkEexQK1d8znxqc2ITdVgSHdmP1n9S/T0njgqL1
 nu97iKOWkWGjPuUYOsfh+T0uDdolF/dnVb8gFJpayeNZ414e3KcK2EhvK
 n6Xat+4IYD5Qvwj6cYe8xrBP+YekXguYpLUgWYqmu5m1ET3jvjbFDEGaS
 RdVRaAttryX6PliWbDlMKqlAc/vGMnV0w7tmR1qAwTD24p+jqmb2XytfA
 1/ZPPMcYXUDz65jzd7Z4uhKY4sarz6y8MnFubYEa5t0pHIufOBEumiAP8
 OgkYybwA0MRCV97NkOhBlJzRHZJy8bflKUXyof4jWDfzgEc7reQ6Nn53H w==;
X-CSE-ConnectionGUID: Cc2Tp8ZpSK2RYpgNEv24ng==
X-CSE-MsgGUID: 4q73LnXVSRCayoFV54rLdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44708526"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44708526"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 05:54:27 -0700
X-CSE-ConnectionGUID: EQms09ExQBeHlGpxkvqlww==
X-CSE-MsgGUID: 1Ky29aaUQHWEE1UmBiAwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125950424"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 05:54:27 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Mar 2025 05:54:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Mar 2025 05:54:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 05:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTfStPGe7sSMKl1/lamzNFdyY1cDKbNonZlmD9n6NG5OyL2lSa8Q56U4YUBsRm49v0YUFipY0Qb2qtr75enAcIhCMUQ0DNF0P+lL8xJ56KZj3pIPcCkUaslrSjYEsojLRPQK9Y5RT+soDGhngCFFxFkQr5+WwZrGsitw2xZKjA45NCheRoMi9/hgiznO4D03Kef9rqNAjz2+y5A0DwWcsxqi+ptWDLi2X4/TAsLq4bR4YkH7HEFn73wngFymZrXaehZO2hxhMb7A0COpHOsxcZ5i2CiPtghjEaCp7n7C6VnAFcI1+TVhVWvkvuoxvgbb0q2WRSBsH8nzOONjXrBHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WOO4YDnv/PBx7/LDrbWMVVDzlpEkGqGeXFIIpWfHzY=;
 b=fvv+nNEH62bMVUMiedw9a6EKWnHLLiKY/Mp9cXTqQSFQNUgEseIVfmjpU6LWyjJP3Jus4fgmmhFMPWPafLx0QkRdl2NDDx29e1AYlXa8Ygs428OFknuqAHUSDbMEHw9Nit7nh47+NnzQKb7hTj4geiTvtpyJgEB4EmSexjDVN9+i7K6drcz/vLF4VHM9qCBJeQjv4+jZDRcpIehQraX9Hs6EA9oDerEdF/h7YcjFawCgYNgbM0kIFiUS26QeI5GAfuvf1chOs2GmxDUaD7zbuMLgxlvkau53YZJqnKEY2Pqfc41KzxJBEBbJo0+w9905+kgpwLO4vzxUM4iMVs56Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.49; Fri, 28 Mar 2025 12:53:55 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 12:53:55 +0000
Message-ID: <fa25de96-927d-4a70-9c2d-6899b2b5e22e@intel.com>
Date: Fri, 28 Mar 2025 13:53:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] net/fm10k/base: fix compilation warnings
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-2-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH8PR11MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 475dcb01-9ab6-4818-6356-08dd6df7991c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anZ2MGtjWWppREZQUWFVaWFqbG9vL2tJZXZtcFVFSFhYWURCT0lTN1B0M1pD?=
 =?utf-8?B?QjUyUXNQN3pOck9UWFBvZXVJYXlUWHZsamt4bi83YkU5OFpoTWRCY05BcFZP?=
 =?utf-8?B?amhSeVhkMk1SUkZtb2JUSnBmNGQrdytqTHFEQVVqWWFCOExuWDE1Zzl6cTlJ?=
 =?utf-8?B?eG9JcWVIN1BCRVdZeXF4RnVkWDFxenRubHBjZDdNT0RHRGloNUtqUVFMQW0x?=
 =?utf-8?B?S0d0WFc2eWdSbkNZMTJNWndqM2JLMnlWMy9UZ1d4V3BzVlBkd2Y4bUZ5NnZI?=
 =?utf-8?B?ZTdUZGtYNlBsaXJiVDdYNytYSWk4ZVVSaWFVdStadkZTVHNoY3Rvck05dGY0?=
 =?utf-8?B?ZjQwM2t6cm55WDFvMlFHREp2anBOdWdJTk9xNU50UlBreHVyUi83cnkycS9Y?=
 =?utf-8?B?Q1pwdnVKcDJ2R2dta3lIZWh2V2FVaFlGcVByWFFkcTBxcEQ5RC9FUFJiZWFn?=
 =?utf-8?B?VUpqNlVkVERGWHViZ0piOGVUZVlkRmxqYkFJa1FZRUQyd01OVnpRaVJNYnQr?=
 =?utf-8?B?Z1BUeVQrNzJwd3gzb3RPTjdiK0FEK3k0VlkzNldxcERUQVRlVE90SW5sT3l3?=
 =?utf-8?B?NEtrN21VdU04SFJKeEwxZEVWN2Q1QnJaTk84a0lOaU5SRWxsd3JKUUVxdkk4?=
 =?utf-8?B?Mk5TbHlrano1dWZFcG9XZ2NpMVdMS2NiNzVBNEt3YTJRNlIvTk9jNTJFTGdF?=
 =?utf-8?B?citlcFd1NnAvcGlRSXBKaGJhU1MxbzRhdkY5d0F4S29KanExU1pQR2tMam9o?=
 =?utf-8?B?bFpSVlg2alhzV0lJMVV6M2ZDVTNkdDJRcDVVcTBvMjRCWFJYVFFMblFqd2xm?=
 =?utf-8?B?VThsL2cvT1l6cUd2UUE1M0YwdVBDbW9mdGFEb1hEVUxJNVRySkk3ZjNIVktY?=
 =?utf-8?B?ZFV0TXo0M3JnMHVSWVlhMDdUNEZ3RC9aaHBadE5lS3FORFBlTkJOWlo4clQ1?=
 =?utf-8?B?N29wUlVwcmJpcHlLODRvUEdTZ2pYeUIrYjV2ai9QcDJGbkd5dDU3NmN0Sk1k?=
 =?utf-8?B?RFBmN1RnTHUwM3F6QlVqKzdNMjRqcDlhQUJCVHNGWGJ6VjFYWitrL1hJMEM5?=
 =?utf-8?B?TzZKRlN3WXQyOHRwdm1ZU09jbXF1N2RDY0VteDJSMGQzNTNwMU5aK3c5L3hH?=
 =?utf-8?B?eEp0d0t1K0dGc21NbFcyQXhneDhwQitjUkZ2T0pOWkkrWlhwclp5eDVFc3NC?=
 =?utf-8?B?dFU3TllNdUhnSWxiTEJuNW9yVmxYN0xzcC91NVBJd1lhQjdyMnJkUklneEYx?=
 =?utf-8?B?bDVqbVhGU0JuYWVod1F0Sm93UlczR2lNd3BoQWUwSzBYbUlDMFIrYmd4cTJh?=
 =?utf-8?B?eGd5MUw0TlhldGx4Rm43VEk5SFpWRGZVN2Z2SDVSTjRUejNuUzE4bUZ4Z3Jw?=
 =?utf-8?B?R1BOWGF5QnhIVjcwZ0xDcTJWUzVLSERFYVZycHcyVDBwYjVDelF0UFN5cW11?=
 =?utf-8?B?V3diaFQ3d2JHZllYdUhzV051V0tLTHVBTyt1SGhUL096WVF4Q25zcUJLeG5U?=
 =?utf-8?B?TGhVdGtsNEZPQWZvVVhLcitNSGI2eDFVaGtHYkJXdjJMdDVURzVTRkhBR1Fz?=
 =?utf-8?B?OE8rUmo5cFpRMTNjNksvL1EzV05FNTlWSmNQK1RDMmFLWUxraWxBY3lqOHF1?=
 =?utf-8?B?Uk9kZEVmSFY2TzR5dWUwTmFERnl2MzBINlVnNTd3QzF4R3pCMTM2ODFiZDhK?=
 =?utf-8?B?UVBPV2xwZHY5d1NNbGN0cjh1V0lpdWhzT1YyS0hpZlM1eDhDaE1wS2I3NmhZ?=
 =?utf-8?B?SDVMNmtiQWlTaGkxWjVzbjk3Z0k1QkxCcFFxY21rWVoyaHFBTGFBUDhSdlFJ?=
 =?utf-8?B?Mm5wZW5tT202RDdpdHpjMTFlZ3VRUW1WT2t2YThkOXFEUVhEajJYUDFSSGlK?=
 =?utf-8?Q?6xC32CJcYc3zw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1VKZFJoVEVMQ1JUamViajNUZHpBUklvZGtia1EyeUx0VE5peU1mVXpWN1U1?=
 =?utf-8?B?d09vTlZXY0c4dzZaNTM0a1hIS2EyT2VHbUlNOXpQWjJyVnJ4TlB2VTEvREFl?=
 =?utf-8?B?UCtGc3BPSWF0enR1U2ZKOFQ3VXhXNXlob2FPUHdUR2t3WVZ0OEE3T3RWMEJz?=
 =?utf-8?B?MVlucWNRcUN3YkhBbnJjdVo3MTBYTDhaWHREZkM5S1laMFhkOWVTYUZ0MnBY?=
 =?utf-8?B?MVhiaURvN2tIVGlBbVg2alNOUW9nYXk3WHJtaUhMZW1TMFVORFNNMzNqU3Nn?=
 =?utf-8?B?aVVhU2s4K0FhaVovcVEybE1iRTZrUXM3ODh5RnlNREprNzcwMnVQZ2xobVNm?=
 =?utf-8?B?OTBaK09JRit1b1pKQ1YzSXYwQkdQSk9SU0xHcjBzNWlEdytCWWJuMU1hY0hi?=
 =?utf-8?B?K2dHdUd2Z1dnNHlZYjJ4ekJLQ0dYM3ZzL1pkS0kwNEpIalF0RHA5SWRJWjNH?=
 =?utf-8?B?bTIyRkZGRXVSM2RXaHBKNlovVTljeTlRR3FqOEszT1hDaG83SlNlaEl2NzVR?=
 =?utf-8?B?d2RYTThLRVBBcUVvcDVTdkZwMUJMQ0VjSmFFelp1RWUyZkR0Y1MyNDdtQjJR?=
 =?utf-8?B?VlA2eWw5eFB6T0tFSTF0ZEwwMXJGaTkxUTVZUk1jNCtJU2FhWEI4SEtDMXow?=
 =?utf-8?B?VEZxRmY4cUFKeW00c2tFZ3p6Z0RBbzk0UTN2L3k1YjkybUdDZ255bFU2Y2VE?=
 =?utf-8?B?VUU4RmxsSzcyUDNDeVh1N1BCOFM4cVJRWDZYdE9RRFM5T3RhL1ZTTzYzSkZr?=
 =?utf-8?B?OW9wY2tPRVVnU00rWk16VCt6TFRZUm9WWTdtL24vc1BJN0c1NjZuNlVnT1VD?=
 =?utf-8?B?MHl2M1RhNTNHQXpxT0pTN2JycFBFcjd5ZUdudXpmMHl0cnNGejMrMmZ0QUcz?=
 =?utf-8?B?elBlYXh1dENML0dYajR6UlNDSloxTXkwbDRvbWVpMEJzNnNJUnlIbnBzL09i?=
 =?utf-8?B?T3RUYkdpYzNTa1VDZFFBOTNZd0JwRkxmWERERE5yYzRYVE5uVEROOHBDNVk1?=
 =?utf-8?B?NVpyYjNGbEw0ZVhBSGNwdyt2em1qcnRhT0dRSzkyVmpzcnVnQmk0SHRMTjNm?=
 =?utf-8?B?YWhrNlYzM1kydnpLVnVPbTc4ZUxaQ1RaYzRqZ1duR3hXTTVMeFZKdnBJSm9V?=
 =?utf-8?B?Tk9ZT1RjdG0xazdmSUdmRFR4YVBXaTJuM2dGMjR6N21pS1VnSWIvNDNzZjJO?=
 =?utf-8?B?c3NrUzIzdUdSREM2TThJclNkdlRGaFJ1em1aQ2FzeXd4K3dIKytPcXNqeXhG?=
 =?utf-8?B?N0d1RXMva3k0SklaUHNMTm53cmxpbnJEeDI0QzFCSVpGNEhHcmI2Vmx1Q24r?=
 =?utf-8?B?WHBHL2hBbnNFbXM0ZGVWdllkL3dac3h5aVZBSG1zT3ZZVTlHamxCQ3RoWk5W?=
 =?utf-8?B?VEsxdW1hZ1BTZHhiaUhOTnRJT3lhdWdVREhhNnlYVXMwUXdJa28wUlhVTGl0?=
 =?utf-8?B?em5OK1BTVWJ2WDRBdHNuTXAzalMyK3Ftcmt0cTQzVW1tcGh2T05JUGNUcTVr?=
 =?utf-8?B?UnF6SnEwSGpLRTYwaURINWM1azZCS1BZYjBYTEd3K0RjZlJwUjdpQnFCRTJn?=
 =?utf-8?B?TW53MU9RNGp6NHVaVTZLVGxNMWhMRkFKNExKSmZmdW5HNXFUKzFzODhMK2dT?=
 =?utf-8?B?dlZlWDJWUGZjdlBjcW9IOG94QUhuQy9vcUYwTEZLMUJYbWVMWTFJb3BGbGhR?=
 =?utf-8?B?dWxHbWdHVkZQM3kyMnZYVzJGK3VQYlJ2dHhBcFpncUJIQ3JSV2NiS1BQRnBH?=
 =?utf-8?B?RDNiWFZOeTNJNDMrNXZkN0ZvODJpQzd2MEhSRDNSVFlGZ25ncjNEaTVMelJP?=
 =?utf-8?B?TEIwYm5DTjJCL29KeS9aL3pORTRmcXRMb0lRMkNrbVBha2hubkcwZWNIVzdF?=
 =?utf-8?B?bmo2a3ZnR1MreTJaMThHR0NTaGdkSVM0bFNuY1k5cGw5QTJaeklOem5TYjN2?=
 =?utf-8?B?RGg3TWd4UmFrM3dnTE5GdGdpTHNrSVNSenh6MW51MVE2R2k3K0JzR05RempO?=
 =?utf-8?B?L0dEaWdRa01kSDBHeUtmRjQzYmNZRVhsWEM3WC9PN3ArdmpDRmtNa2tLNzBn?=
 =?utf-8?B?Unh6Z0psVks1bXRiK1NSUi9ha1puL1Qwa0NicFNxMnFOUml0N0R4eVA1UnBE?=
 =?utf-8?B?UzdhS3F5d0wvdDlMdWlDSHNZUkpsQkQ2M0twS2xBZmRxNmlwYjVYY0hhYXJx?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 475dcb01-9ab6-4818-6356-08dd6df7991c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 12:53:55.1845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4IulxRIcgJAJFL9Dzh9TN1mdnnOpIflpsxbCHYuJ3lLic+1PWsvXM3nR3ZpJCYb6dfo1WAUhEIx45xTU7yacN3moQ+o4y5HmBCVIPM6QZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> The fixes required to re-enable warnings in the fm10k base code are
> trivial, so let's make the changes and get a clean compile without any
> warning disable flags.
> 
> * provide definitions for the UNREFERENCED_PARAMETER macros
> * fix the spelling of the work "fallthrough" in comments
> * provide a definition of FM10K_READ_PCI_WORD in os_dep.h that marks the
>    parameters as used.
> 
> Fixes: 7223d200c227 ("fm10k: add base driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly

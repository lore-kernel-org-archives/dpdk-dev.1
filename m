Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AABCA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 11:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 217B140684;
	Wed, 30 Sep 2026 13:58:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id CC47F40278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 13:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790769527; x=1822305527;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iC2k8L+cVwjQikYSAOwe7suBIyaTVsLbRVaSdxwQZPs=;
 b=HqU7qH53/H64HlokU/2Shbo5rvRps5vgtJbxFAcwl8gG3gXVJvECerHP
 IrSqvxxMOcjzR+684WQwo8nFYWu+XTpzoPG40eHLalicy+spSCXOPdyrE
 fhKh8vWFwpzaPzMUgkkht51CL9LGB+Krjhtrye2xiBp+Df2/6IUM8FcLv
 UK4LA+NNEM45sAVaUuemrSfaQv5fGHsseAsxsVyjrNERi0baC1o5sJiwo
 oZvaEPX/B3FSKyB97Si1CHYSog5KPwExwIvVF6J2uJagyEuFvSGjo0RzJ
 oMb9dbqPPHdOBPe7juoPVoou8taJaqlkz2sWYSh0XOdkytt086Ej7F14c Q==;
X-CSE-ConnectionGUID: A6lgi9psRAqaw5aYesKuNQ==
X-CSE-MsgGUID: ggWh18jPTWG93VZV1Shf7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102179327"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="102179327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 04:58:45 -0700
X-CSE-ConnectionGUID: GEKTWDmKT/CB8tZzbh9LKg==
X-CSE-MsgGUID: Cx8P93h8RaKC+5dZm2R0eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="274793217"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 04:58:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:58:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 04:58:44 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 04:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bdkx9pkHV8ZdN2Ui+IP7lGJV39rg1a2XcQ2RJ26+jguhrGD542TRQBjTWdHQ9FyIMY15DDbA1EDVVeZgmhRJVyKubu7JDG0bouGVYDAJbZnURtOQhScjpmlEsY3VxSqDnREONTSjEc29t5x7J5xlEDC0etTS138X9CAPkEhj+MUnKer+lP1+pzGRflvMwmTLg3aOhsRNhNsw5C7Bo8TBJtpFd+Uusccvbe3noXSCfmqEZIIgSpwWHeZR2lpsgGdQFR1kh2h7HJzkxth7a1S85ZOnDW/SF/8KGAKI7YlJ7fzW5Fh0tPgdJCcq1K9g4LIGz7wHnRvzZoP17ApcGsNciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC2k8L+cVwjQikYSAOwe7suBIyaTVsLbRVaSdxwQZPs=;
 b=pQmGxRqDavs4Fdl/sNVnqgpxFwCXxCmp0CqpQLYLnq01IdDdULdW0GFlNnMZm2LZs6dJq4lBQ7Bt+gkTTr+WoRNGHLqhiBOnBN/OP1bVL+zqiqm9aMnsLS8nRvjr9AZljtSJ2H9xgCgFmRefTNnx1MLYEig+Mpvo+or1lhiFJFNvh0HTkjl/UQyMBOSJAl+KyFft9PEJxOhjzHcAWm+XyngzcwYK/VO8lkjEEsz9gvBuCXFBw27GhGT0qPuvoKVIbgZz0QHUe6DnsNdFmUJg57vbvSEYQJcnBs5GhQnFuWNzDsg80/j8Awhv6quO/cP0Uwm4wBQ38TECmEJvKyMAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5)
 by LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:58:11 +0000
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::1aec:2e09:893c:ebc8]) by SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::1aec:2e09:893c:ebc8%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 11:58:11 +0000
Message-ID: <64d81a94-4578-4362-920d-a049e0207c68@intel.com>
Date: Wed, 30 Sep 2026 12:58:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] app/crypto-perf: support mldsa Sign-Iteration
To: Pratik Senapati <psenapati@marvell.com>, <dev@dpdk.org>
CC: <gakhil@marvell.com>, <gmuthukrishn@marvell.com>, <kai.ji@intel.com>
References: <20260929105851.1305127-1-psenapati@marvell.com>
 <20260929122044.1344518-1-psenapati@marvell.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260929122044.1344518-1-psenapati@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:10:234::7) To SJ0PR11MB5661.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5661:EE_|LV8PR11MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: f1530b5c-d7c0-432c-5f56-08df1eea1986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AGtMkQxjETlphqqF19Am4OmcY7gXlkCECMPwhmhXvY4bdjEf5vslsKWn0raOeJlVUIDR09XfC0CM4Qz+eKULnLteJ1KJwU3YkFqJwyVchI6DXhbILAr4ClvZfpu9iMMj7CVrgRXtlBQuyVVu6IjInIoInFQSbXbR8RV+IP/Q4TQJeD9WysXottgJ/bUlKJ1aQ8oOmXzhjrsz8nrnMfktzWUFdLM8oYBu4PrY8f55grFtxQ0wRjajcO/Crn7KO+eDh5dhUekZ89sHf/AFuFg+KX/W+f9ighwKjRRBdZ7c0RF4oviOZCSC61L+iTJDMZQmGjhb+Sz8r0MtlApPN5hWjZc3cIZAvcyDTJ1k7mvAT3thZXlku/EmtddF9mqWAuEaQBr4USftSsnI1naowp4od99ElaL7ynXWARTD1Xxb+X86dGEgslUppwBTdDge9fn1v7c/MzF3+U+mdsKeH9cZEnZON82b/LjXb7/Yfr4Qjpfm3hMGWj3Bxta5N08RT4RFY76iqt/AM0Y2arBVZ9GXv7y2YC45Aw9sOuX0hcssFvAFZgu0kJUKhRXRC1YCkhK4BzRRSPbU70uKXmES2ZD1YIrfC+nYbcX+bAzpI+nbyt0zya+MPBJtSJi+Reo/8JV6FWNmdOEk8rVlBZES+7MC67JHDRwTvZqGUres9VI/evI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5661.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0pwY3RLQ0l3OVM4c1VlWHdSM3dzUjAxM1hzcGtsT21UanlLOUMzenFJT3RY?=
 =?utf-8?B?ZjZpYUNsVTgvTmJlVjhyYmJpYm1rRDZISUVyYmZmKzRwQ3hYYkZpQjdkNW5x?=
 =?utf-8?B?Z004dTNBeFJGenN4bGhiR0h1cVZ5ais4RmtvTzZmZXlpWDVya0tHejdRSkVn?=
 =?utf-8?B?eDNHZ0VFQUI2dTZHWWV1RmI2bU40aHpRK1g4Umw1dStBQ2NlcGQyVzJSUjUw?=
 =?utf-8?B?Lzd1WVZHRjdXbFRlQ29SUEI2ZURPM0t2OUZtVXVnVXQ3OUxJMFhSMzduOHpL?=
 =?utf-8?B?Q2xvQkEyOEVhSWYwMmtxdFdYMUMrS1E4NzhDczhjMlFNemlja1pBb1Rqd2Jl?=
 =?utf-8?B?YS9Ya2UwMVZic0ZZYkhwbldBajRoUkRHcWdsWW90UHhUSzg4TWF2RzZucEJB?=
 =?utf-8?B?MlhDbHNKUkZBU1lFMnQzRnI3SFI3M0FVRjhyNVl0bmtsdFE4T0FUb2dWQmVJ?=
 =?utf-8?B?MFMyT2hCTE9HVFh5d0NnZEd1Y2hsak5qMkpnZnYzWWZ0Mjkvc1RVQW9nT2NR?=
 =?utf-8?B?YXArQnRBT1UwY1ZOTzlvODRlSHgvOVFFazRQdjRJRDFYY1FsVkFncXZFbnJ5?=
 =?utf-8?B?N291V0ptZXZYQVlIanNYS0FaNUJSdG04anF3dXFpT0gvU0xLNXJSVEZXY2Fq?=
 =?utf-8?B?eGpWUStDdXVWS2p3all1bVdjb0I3ODBsV1B0SDI4ZUYyOG4xN1piOFhxaE93?=
 =?utf-8?B?S1dNQlVwdGkvNHhqVlVQeGN0NysrOWljcXptdS9mODArdlEvMnF1cXBPTDV3?=
 =?utf-8?B?N29HZEZaUU9jK2ZYaHVEb1BONE9ZclFFS3Jkc2txOGhMZW9BcjFyMjZXR1F5?=
 =?utf-8?B?ZzRBbzc1RGZIL3N1L0hXckZUQitzdk5KWXhVckl0Z3QrZUpNM0NmN1RiblZI?=
 =?utf-8?B?K1Z6YnM2eVJSM3BWUHhmeHBmeW8yNENJUUU1N2dqQkI1RWcxVkhrazFFTFhB?=
 =?utf-8?B?Ri9NVFlKQlc1aytLVnlMUUUzYlkvOEFRL3ZSSlpPNkh3Smk1bm9Ub0piVFhK?=
 =?utf-8?B?TmtCa0RJc1h5cWxFbkd1djR2MktLRXFJako1UVA5WFUrUDhXU0MrSldqZzgz?=
 =?utf-8?B?T0FjS1YrMHpGRTYrSE9jQ2tEMWI0OVZqR0grU2J6YnN5d1lzZ1VWVXRoa0Rl?=
 =?utf-8?B?ZmRrdzNrZzQvUVZSOUlrV05KUUpRNUNleHdhcXpQQTZoQlk2ZWd1N1dFWEZa?=
 =?utf-8?B?bWdTbkJBc09HUEJuYllkeTRxQ21jZWlnVkRIT0NhVXoyOGJBMkppK1dzUkJO?=
 =?utf-8?B?VzZwSldZVDRrOStEakZXakE2Vng4RHdrd3M0cHBhVHhidmF3SjZiaHdiZmV4?=
 =?utf-8?B?RERLUWIxSGpQRlNTazBWd25TYXdUZGs2bGQzQ2ZBb2NMM2h1cmh3ZlFpbFhx?=
 =?utf-8?B?RzRTTG9kS09OZmZ3cE9mMFBvQjRQT0pUZTJ0UlBlNjNPRE8xUERaTk91bGU4?=
 =?utf-8?B?TE9KUlZ5NGZBUHJ6Q01CU3ZhVEpQK1hiYnlqSlJZTkpJTHJqc1ZaK29ySGQv?=
 =?utf-8?B?OGtuUkNWQmlOSVA0dVNlRlNaOVUwbFhpcEFMSmVlWEZMTXRWR2d6WTBNdWxH?=
 =?utf-8?B?VU9kblpJcUtXMjg4WE5EdzhObnRjUENkL0dyNVRsNkNFbDY3Z0RRdjNlb3BI?=
 =?utf-8?B?MGN3SkpWaEJQZit5THU0Njg0NUNVbDlsaXJzaVJ5MHZ1bUdSMGI4QllLbWJh?=
 =?utf-8?B?ZGoyeG5BTDU4emw4a1gyRXo2aHBPZ0xWUjRRZmh3MExJdXpxbWhEbEFIbnl1?=
 =?utf-8?B?K0lRamxiQXR6Q1lwWjQyak1JbFNmZU5VMUZsbTNPKzUrV0VUMWU4NTRuMDI0?=
 =?utf-8?B?b1lQRmE4bUxsRDI5NVFTYU93OHU4bVl0TTQ2RWZsa21JOW1GbUsrTDRqaFIv?=
 =?utf-8?B?bzluWERMeG9nNHpoa1Zlb3V2dTJHMWZjMEwwTDYxSURZUjd1NDltN25ZWlRH?=
 =?utf-8?B?MUhWNzF6S2hWUUJjOUdORnBqeXFDWElXWXVFQ2xiNUFZZllQRW5CTTY5NmlU?=
 =?utf-8?B?V1I3SFBkdkUzYXhvL0huYTR1U1BpWmhqK1lleVh6MjlueWExYVprNHl0Vk9V?=
 =?utf-8?B?c2twS09KL0QvK3NqNkdyR2d5Z3BPWmt3SjNoTXAvNGEyK3dKSE1XRDFMUXVM?=
 =?utf-8?B?YU0veUNyajY0OVdaaHdXN1Q4OEo5TGpNdlh5UlFHUDV0bVVBdVRlbGJ0dFlK?=
 =?utf-8?B?NENDTjE4elg2NnZMcHdrTHk0L1hIVHQwdXNEN0FvdVJVSkJONEc2YVBxWEs1?=
 =?utf-8?B?WWlPZllvMHYwRldxTStnc0ZxUkJnVHlEVXo0RVdINlRDL0tFUlFHV3FPSmVS?=
 =?utf-8?B?eGlYV3haSzJRL1UrME1veVJzRlp5Q0tUN2R2bS9rSFFzbDBreHdKUT09?=
X-Exchange-RoutingPolicyChecked: W3Fz6/QHU6k7asQe5rQSX6pu6BMUjJN1bF4wFcjuFTUqTb6KGMqghbd5unJpay5Lc/594yOcjkgmOM4TdzUM8TR6V6m+m2dF4W4o3d00jnQ6KJk4rnCDckzJ1vpjHoxGq0jGXXoHV9bWSunQu1LszzX3/4ZZdm8H0+1A4j1zh7mw84qxr62FY5nHX5GBxfF7sDWIGYjpy07ap1pnjCkc9QZYKislxFyZOlGHbML05eT89j3vO+J49Ax8mlVdxo2t6Znd8PIFwcng3+zFO+I+joyPv6m84qNfbqGutF4IPbRqYCvw37fdmqoBkGNoZmwLwG9sUK1cXegcmudo4uZmfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1530b5c-d7c0-432c-5f56-08df1eea1986
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5661.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:58:11.7349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omTuYoyDWdysMwxarU+HdaOvL9sDeMYJXd+OBvhRGX7JJ45Q6wwmRpbbKhWWeTsIzrLNutRhUWAHHikMcyufLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
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


On 29-Sep-26 1:20 PM, Pratik Senapati wrote:
> Add ML-DSA44 Sign-Iteration based test support for
> 1, 5 and 10 iterations to test-crypto-perf.
>
> Signed-off-by: Pratik Senapati <psenapati@marvell.com>
> ---

Series-tested-by: Radu Nicolau <radu.nicolau@intel.com>



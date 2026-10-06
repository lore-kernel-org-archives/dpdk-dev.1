Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68476CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 142EE402A2;
	Tue,  6 Oct 2026 12:28:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 98F3240270
 for <dev@dpdk.org>; Tue,  6 Oct 2026 12:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791282521; x=1822818521;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xPS4jSALyzbL4KNDIicij5lx7X8MmA2yx/uNNgamjPk=;
 b=MLP5my9lbsMLSmhSTofI6+OKbHorM4GNcKlE/NKvDUGD9NQtY7tpLSSL
 s7G6/nReQSDmdfpWT+a2SOUPbmGQSPlSoAWqn5hXloaLEqi3JWK7ONt26
 q0Z2FzI5doLOBBQ30d9S8VUKWzrpPiTDSrJvxK8PSIC48xalnag6mzIkb
 Vrzsfi2lc3OVn5DpFyTE5TX3+cbr8Ab6l6LquRVJFQZKAX65wL4zXaIeQ
 FqO6pEEi+jCwYjLFo40FCg9W2iuZeUx+B4Ofr70siqW5GA1oO17ZSXA/W
 EANyV2J0XcR3BUEOwd0n3GBk/vBkfpkA8l04ChuURGpe/HzIIrm0cNqqB Q==;
X-CSE-ConnectionGUID: Es4cevpFQDKyTS5Dw1uMDw==
X-CSE-MsgGUID: U4sV22bGQ3m4tY9uAhhGhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102487244"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="102487244"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:28:40 -0700
X-CSE-ConnectionGUID: JM3nBHjMSMixf0Of3yoHMQ==
X-CSE-MsgGUID: ofkbRXbXQySArtYXfphgFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277225191"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:28:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:28:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 03:28:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYJfdQaRxK0G/LcrVW3bpcAg32CGWxt27IYYMUNbLfLUKDKrABWW6bMSpd1hDDFwecGB0M18bJoXwvlTjJF2XGXSrx//Httry9BsC/HI3A0dkDiyWcTMB8Qs17vaaTWNH99YTg93+/3XsixBFehsbBzxD5KwFnxa7oci2LacVnyi3nhGHpMi1/ziKcsBWERpZxAE4lPMTcglTK+9bbSl93JAlAR7AWu3sGnN7W+jpr0bo+5+MmvsKzSO2lcTz4YpwHDeW3m9agb0EX9mRsYqkyEutT3M0E60utjGYC3ioh+sN9SMHnvvz4hW4lmpegUsAFslkpkEDk2+f+mwGrK91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIhLF93BSoLqQaUe+i1GGdWOdE+2bq/nKpmoINM3NLc=;
 b=AKGF7s6wIwcK+nywycilkN90pWCLnbQ0uf6y61T2u1Fn3Jx2cyRjwj0V3Yef/8FuHmv7l9VFzJWnd3W24N1qyL0oNBJFfGzbivvKd/JZ6jLmtkLDPacZiQ/S3YhqCsvMcQwowYfhhRMw7bPi3XMYHnt7HqoQeJpKLM23EJXNFX8sSY6jp32P2596Hmwkxoj0LvRoYr5y3ehJALuMKHkhPBNuMlDH/4PQoWtsgWXJcI3thKIlUPI5g/zymRY/cABj8aoS1D3v4FE+kFKZ3gBik6nqDljH81UqyuNxx5K7fmsQGJ39ozS8hjEE2is9L80NZUY3EnkFbBDZYLqABCQUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by SJ5PPF64191BB3C.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 10:28:36 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 10:28:36 +0000
Message-ID: <7624cfc9-c624-43e2-a046-250d332abe7e@intel.com>
Date: Tue, 6 Oct 2026 15:58:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/5] ethdev: add Tx timestamp slot APIs
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
To: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <andrew.rybchenko@oktetlabs.ru>, <aman.deep.singh@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260908073206.1236372-1-rajesh3.kumar@intel.com>
 <11be03b9-2f3c-4665-9a89-3fce0dabeb33@intel.com>
Content-Language: en-US
In-Reply-To: <11be03b9-2f3c-4665-9a89-3fce0dabeb33@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::7) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|SJ5PPF64191BB3C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4baeeba6-583a-47d7-a149-08df23949471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SKHv4BxjG2APHTJFhRvARtXxDX4pQqE1lSBDzYtz6ziAXDQiIOjcrO8XbKmBzsAvApOBsjm1QLbq871bSNTf1jjfRN4aufkrh+cFW3Tau4eWG3qvGlSR/XWYUyjkEMDOdxjO81erSAnmDVaXsv10PllJkT5e678QHvi8ysLw/CP+uh0JJuWKcZV33w+FvAd+i04RfXufGW283RjIQM6bi8yiJiXl37EWVcV+tt8Diaz4DSxMT369rGMuqkp3Ax5zzzC596UgHLJNeLpSGuA9S31BDgapMGNjNZi1kVLsZDOeuZR+1rHyY+lRChBfeNULDKgXuxU/TRxtk5eNF1/GmPkmmbGfH/mA97ErshTqtnsQvQR/QA3ZDlyo9njrBdBp+tiVvQ5Y/ZMdQZ2dzx5gEssEpGjH4nlRBodMa0ktxcOjTtk3nG/erHdkVKIbSKbCTwY73pz7PFQ5R/0zZx8IVF3uFC1X1aS6XyzMitHOteyswVITVs2UFIeCGSDLTvPmLW8cHcIz6hF8DplSB5LcRsHzIHGB8A9oWahktkegT1TBkWuBXu96b6e7GRMIKWbZ20ToFzFpOraQt80F82Ena4GhXnostsXlLnj6/PLajDvOGU39jL0Wu6WIJenTeadkmm97iX8+ijo65CYbKK+ZaEIAYf4yHc7ueHnepIfgXT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJiT3M2VmYzN0hyUmlOV1JCbzJRYk5xV25PMVdFSHNScEFPNE1BMFNRS2VR?=
 =?utf-8?B?dTA2YXpxdUJlNER4cVVCanh3dDdaK1V0dWlmcWtSb0x3MHdsRCtZd3hRNGpm?=
 =?utf-8?B?VjdMMHhhOG9YcWRJWmZLWnY0YWpLWXlXUGlXR3JOVVRMUGVlUkFhdHlWaEJ0?=
 =?utf-8?B?b2xpOE1BT2JvMEdBdndaaS9FQm0vT3dEcDdWQWJtUjFxRDU4aHU1ZFoxV0ND?=
 =?utf-8?B?UlUzYkFkaEwyalMvQUYyU3ZHUXI0ZGtMbVBWSVd6bStWVTRpVzN6cjU1T3ls?=
 =?utf-8?B?QWRLWFJ3TGw2TGFnK0NFWGZCZ2NWWnhPN1NLZUdRcm4rcWIrampQRmRJNlY0?=
 =?utf-8?B?emxsa2tiUmpGcVE4b0U0bFp6MGNvaWdDSmh2bnI1OG9tSlhNelVVQ3VzeVla?=
 =?utf-8?B?MWNxejBpZC80aE1aUTlIN3pxWHoxYnRjekZXdk0vZE0zSFNrbVJuam1QdjNm?=
 =?utf-8?B?TUZyMitGcUlKeFYvRWZyRVkwdzZmU2lVQ0hkK3pWNXdFTWUyRzE3WHlBUzE4?=
 =?utf-8?B?d3NPaWo2RG96Sk16UnJsOVJ0OVVOR0Nyc1M4anhFeHNBd0lXMG1OVmVmSzVD?=
 =?utf-8?B?MjNEaHJHeTQzVVBsZGtKTm5TdzRCcEZGNmIzaUgrVDFnZDlhZEhvZnluOUh0?=
 =?utf-8?B?bW85OEt2SmdHTmxYb1ovdzRScFFGQmpHdjlNVllWNGRPOWdTUVZVVWhkYWlu?=
 =?utf-8?B?Z1RZWDBMNHhTYVVMdTZUeE1HanhQQzgrV1YybFQ3U0FWSzNVNytYOEQ3aTh5?=
 =?utf-8?B?L2F4YVpGcVJoaTBFeWNwamFRcjRKZDdTUzlnaTJUeC9uRWFtaG5LdSt4dUl1?=
 =?utf-8?B?TzFiTTNSQndLbzh1d01DMTNuRDlmYlNLSGlKOGFDR2dXcVk0dTBTT2JpRXNk?=
 =?utf-8?B?UVFWaTFaQ0NZSzVKN0F3c2R0SlA1OFpRUUVuZE5ibitSMC91MFBNYm5EQnQy?=
 =?utf-8?B?L1ErdDZ4L084eGJGdmxkVWovNmhPYnh1TFV6ZHVHdmduakRtVUViaktHcGhv?=
 =?utf-8?B?bUJCcWhZMlQ1NHE0MmZndzQwNW9HSmpCSHRHRjBIUk15QTV3aEIzQmp4THhZ?=
 =?utf-8?B?eHVlQW81V0pBZEJYT2lUWG5xaHlmWTFPUENCUXJSWlpTS1htTElNRCtTZkh1?=
 =?utf-8?B?Q2FkYUpFRXBFV0ZPb0NDaWlrMEVaUmhVM1pLN2lPWC93QzlybHZRdWY2NUJV?=
 =?utf-8?B?Sm9QaDl3T1RiWG4rOU4xRHkvdjhTdzVvVm5HUkprNUdkdnNrOGpBNlRmN0p4?=
 =?utf-8?B?M2FUcWRKTmdHb2dGL2RkaTl0aFIxS21kN2JzY2QvejVPVmc2UVYvTDBoVDlK?=
 =?utf-8?B?QVV4U0FyL0hQYStsZkVtUHlNbm14QzlFK3ZFSEJkcnppeXB0c0JlTWJGZGNy?=
 =?utf-8?B?T1czcUp2dHlyMnYzVkdMSzRPUW82N1c4U0lBSi94Z2FTc2t3MEJld25LQVRn?=
 =?utf-8?B?eHFnbmY4QnpkSW1UOWRxSTc4WjhISk5RWmo0eUtVWlJ0bW5MaC9ZSjRTSjVK?=
 =?utf-8?B?R3dSQUo3L0lJbzZHanJQN2xGcU1wTndRVkpyK1hYVnZLYnpoc3pzRUFpZE5K?=
 =?utf-8?B?VHIzWWhFMFNyeEttVmZ1SURuMHhLd3kvZytDM0VENGl1WkFrQmJqVVRqNTNB?=
 =?utf-8?B?SmtrcXdBOHowUjBxTUdoaE80RXdFREk3eEU5dlg1VFhJU3M2d0wwckJnVFhM?=
 =?utf-8?B?WkFxd1hjMVZZMThOejhQSU01TU9nTDRPcFFFTXkvRFR1RHJncndMZVB5QUlX?=
 =?utf-8?B?dmlZaW00bkJMa0tRdDJVVzJnR0dRd20xbVFWc2ZqakJNSXdqK0ZSZk9vcDdZ?=
 =?utf-8?B?WTRYK3E4aWRpZmdUbmlNbjltWjk5Y0dpUHVVVDhZK01Ic2tZWVoyS0JYRnhP?=
 =?utf-8?B?UTJYUW9wRHFQMUpIcThsU2R6bEdqRGVHZno4OTJFdmExS041UXRhclZjcklt?=
 =?utf-8?B?RjdlbWl2c3Jua1Y5K081QUFUVUMwczlONDZsanBDN3lNMzBXZ0ZDOHZrUUJw?=
 =?utf-8?B?RUFaQXlmY0JPYkZ3N3VPWjBzbnZKM3ROVzk4enZZL1NhZWxrOWxid0doYTEx?=
 =?utf-8?B?YWltU2ZDL2VVTW9kVHdrWWxpSFpzVitZbExrMys2NDBJeGJBVFhKQlZod3pJ?=
 =?utf-8?B?SWF2ZEYwQ2l2V1BMK3JFWVFqR1gzMXRQdFlMMVNobG5sQ1NUL0JmR2hzeW5i?=
 =?utf-8?B?ejlqVFBkM2VGVnI2c21OUElubnBsTCswT0RpTmJkUkxNWHNWSm0rUmEzRGFD?=
 =?utf-8?B?ZUpxN3ZQT3RWS2JLZ1ZhSlpMcTdwQno3eUp6eERnckNxdXpiYlBZQzhKNnNs?=
 =?utf-8?B?MnNLd2hoS3ZlemJKZnAxL05kWUNqUjE2RWRjYmwyakY2dzhLNlY5UT09?=
X-Exchange-RoutingPolicyChecked: pORcudT8Hk8Rbeq0z4HDAuv+SJb1r563EX+0Qc4O1OZLcr4SkyUqJTNMnVzZNvLfsleUzbnQMW8tFy1GSb3+/iFY/zQGvfer6As5TESndlGFOy9atunqaQMLNAihU5qURiGWwq8f8qgV6HsItScAbnI5WqQp3Hf1b85giZcgKBbellezwBhnMqJSWyYAenJj6Lz7bH9m+dhp3EixF7Gu6OAQ8H/xGVeqaCCx11muWu5A0u41NMYPP2Ml/tPqTQdWE59vFgCM793j9TyZrym6Lk2I07cf/Ng/IrSZ8OhFEWyENVyIIGuLQD76f0rPOS72N1nGQ/3+8Qn8uCv0p1b94Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baeeba6-583a-47d7-a149-08df23949471
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:28:36.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OELicRoYiHB3NxTmD0mp2nZsdVWDKIXOrgbLJg8sA2XvHl/FfGdG62n73H7CEdAZPVYCATTz0vbwzbznWZD92g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF64191BB3C
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

Hi Stephen,
I wanted to quickly check if you have any further comments or feedback 
on this v5 series?
If you are satisfied with the current changes, we can move forward to 
the next steps for this patch.

Regards,

Rajesh

On 21-09-2026 08:30 pm, Kumar, Rajesh wrote:
> Hi all,
>
> This is a gentle reminder to review RFC patch series v5 ("ethdev: add 
> Tx timestamp slot APIs").
>
> Regards,
> Rajesh
>
> On 08-09-2026 01:02 pm, Rajesh Kumar wrote:
>> The ethdev timesync API currently exposes Tx timestamps through a shared
>> hardware register. This requires applications to serialize timestamped
>> packets and does not allow correlation when multiple packets are in
>> flight.
>>
>> This RFC proposes an ethdev interface for hardware with independent Tx
>> timestamp slots. The interface reports the supported timestamping
>> mechanism, provides a port-global slot lifecycle, and lets applications
>> poll each slot asynchronously after transmission.
>>
>> The proposal includes the following components:
>>
>> * Capability reporting for shared-register and per-packet timestamping.
>> * Slot allocation, asynchronous timestamp retrieval, and slot release.
>> * A dual-domain timestamp structure for adjusted PHC and raw hardware
>>    time.
>> * Mbuf dynamic field and dynflag support for passing slot handles to Tx,
>>    with a helper that stamps a slot handle onto an mbuf.
>> * Registration and process-local reset of the cached dynfield state.
>> * An ice PMD implementation using the 64 per-port PHY timestamp slots.
>> * A testpmd command to report the slot capabilities of a port.
>> * Programming guide documentation, split into a patch describing the
>>    pre-existing clock/Rx timesync API and a patch describing the new Tx
>>    timestamp slot feature.
>>
>> The legacy rte_eth_timesync_read_tx_timestamp() API remains available on
>> devices using a shared timestamp register.
>>
>> Changes since v4:
>>
>> * Fixed review comments and AI observation.
>> * Consolidated the Tx timestamp slot API naming onto a single
>>    rte_eth_timesync_tx_slot_{caps,alloc,read,release,stamp} prefix,
>>    replacing the previous mix of tx_timestamp_slot_*, tx_ts_*, and
>>    tx_slot_* spellings across the public API, PMD ops, and the ice
>>    implementation.
>> * Dropped the per-port cached slot-info array in favor of a single
>>    process-local dynfield offset/dynflag pair.
>> * Split the programming guide documentation out of the ethdev patch
>>    into two dedicated patches: one documenting the pre-existing
>>    clock/Rx timesync API, and one documenting the new Tx timestamp slot
>>    feature, so review of the new functionality is not mixed with review
>>    of already-existing behavior.
>> * Fixed inconsistent TX/Tx casing in comments, log messages, and
>>    documentation to consistently use "Tx".
>>
>> Comments and suggestions on the interface and the ice implementation are
>> welcome.
>>
>> Rajesh Kumar (5):
>>    ethdev: add Tx timestamp slot management APIs
>>    doc: describe ethdev timesync clock and Rx timestamp API
>>    doc: describe ethdev Tx timestamp slot API
>>    net/ice: support per-packet Tx timestamp slots
>>    app/testpmd: add Tx timestamp capabilities command
>>
>>   app/test-pmd/cmdline.c                    |  79 ++++++++
>>   doc/guides/nics/features.rst              |  15 +-
>>   doc/guides/prog_guide/ethdev/index.rst    |   1 +
>>   doc/guides/prog_guide/ethdev/timesync.rst | 219 +++++++++++++++++++++
>>   doc/guides/rel_notes/release_26_11.rst    |   7 +
>>   drivers/net/intel/ice/ice_ethdev.c        | 211 ++++++++++++++++++++-
>>   drivers/net/intel/ice/ice_ethdev.h        |   2 +
>>   drivers/net/intel/ice/ice_rxtx.c          |   9 +-
>>   lib/ethdev/ethdev_driver.h                |  28 +++
>>   lib/ethdev/rte_ethdev.c                   | 151 ++++++++++++++-
>>   lib/ethdev/rte_ethdev.h                   | 220 ++++++++++++++++++++++
>>   11 files changed, 933 insertions(+), 9 deletions(-)
>>   create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst
>>

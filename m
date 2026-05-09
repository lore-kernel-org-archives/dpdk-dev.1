Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B868CD3445
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 17:58:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9C3A40269;
	Sat,  9 May 2026 19:58:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 339E340151
 for <dev@dpdk.org>; Sat,  9 May 2026 19:58:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778349506; x=1809885506;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0Ok8qPVbL+y4Cj/M9SPHimHyPGGxawk0nM9N3G1yAZY=;
 b=WvSQE5BEd0uV4gwV9wyLZN3NCC0Nqbr8NHpt0HriYqQ28eK2MmC4H2Bz
 dPq7F24wQgF8Q+2Bm2YzpEUe1VI0dVQ3M05MRhoQach5cuVxNzPBmYvOu
 0mx8dwupFgO4/mmMI7mODfXHmiJ4pasAs1hmMiMSsHzzSGzkDYERxkGRd
 9GDrAjsUq82VIDWZNvctU8u9jskzJnesXJGlbPfcquHOrjOf3dEfpp2fv
 2noOul56rtAeS1SSAttx8glhTLFutdUL1P9ydx2UuxG+n0AYdI2P763kI
 G/8Rqdm1X1Yc0WddF1z+YitnZYUYOJ4M3zWKHUBiZkMsSY6BpSumCmCSY w==;
X-CSE-ConnectionGUID: /6YM1aIPQIWc8DigsNB/9Q==
X-CSE-MsgGUID: rPHbkNRPTp+VkQzYhmPg5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="66829925"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="66829925"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2026 10:58:24 -0700
X-CSE-ConnectionGUID: SoBBpeKZRTSiVOCBsKYVtw==
X-CSE-MsgGUID: DmZVg+cwRSmFAw9hncpstg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="232554235"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2026 10:58:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 9 May 2026 10:58:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 9 May 2026 10:58:23 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 9 May 2026 10:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqcucn5Qa9jfWKfSIki0V5TJ8FiJth0ShKLubTiSHCvU6Ke9QIfTQvXz+/Desm3bX6/5MsBcZtnideTODBECds+XWxNDFDRa/PQeFsuISteBT25b18/coFW5+bcM+8RbKkPbgUQurf6bZgYNMt2nUnZ2K1lYniNjs0MbQQDDbN4BgvlAxgPOzGac+fZOHYmmSTCH/8a2kLE0At8sbzUc5dy2/Vs8DRscfcaFjlipSDt9JtOmv7NKMKaDKovc3aLwsqXqt6LcI1/iXBVFFHpPRaCSo+YqttJtS8ZVzaSDhSgspdcqQeUxMl+MXa9q1da/teYN5KfBXYF5mLg8blI2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9wbCIEXSk6kPVMLpx29MMXm+4ocj/6M9pnrzLLCENM=;
 b=ka89kVANC1KLsU3P43DcYTJ5cxDRvLX5FVSK6Todgu4itMUR02z9A2xn4SA2AAxiNNKVz81Dm3Bt4HswhyJxmpeso44nL7wSi5i2ms/OSmkhk40SmzYOrWMtBJhZ+/P4W75/iLA8eIgAQ6J9LqYWibC0IX9MW4v6j+PdnSm9vdFmJq/0RiZ4mgLNlmKaLlCUvry8om/x1qsPCIDUYAjiXzoldRu8/qIEst7Bg/CsQi3P7Id5oR/FWXaOwvZWMy1KR9R44omoYdayUlvB3NS7Y2fPV/BwymzMHKH1gTmI7A/GHeyKMtJlx9T8uWNYuKPmAladLoU2apEtyRwtEJy10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 17:58:11 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%6]) with mapi id 15.20.9891.020; Sat, 9 May 2026
 17:58:11 +0000
Message-ID: <2df3e521-871f-49df-9eed-e682b5125c13@intel.com>
Date: Sat, 9 May 2026 23:27:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] lib/net: add IEEE 1588 PTP v2 protocol header
 definitions
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>,
 <stephen@networkplumber.org>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260507134529.2573300-1-rajesh3.kumar@intel.com>
 <20260507134529.2573300-2-rajesh3.kumar@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6585C@smartserver.smartshare.dk>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6585C@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::13) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 364070d1-c2c1-4756-6549-08deadf48898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|3023799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4CHQ/SQe9g1ho+vnUbG7hPjuMz+LDkhcfA5qwQgs9cECU3zbNBoPIahWeIhAGWr7FSkbVJOVadmIi8kHLTS4aExe7Y6Wk0VHnU9G9XlxiyJujUI4BF7bIPVJSAGQ4h5dTLssBt+fJYyGPxdG6znAvap2CjHRbXf3F6La7/b+eeTY+BHqBOMPmr+5rUSozoBoZyrRbFm1UQm8/Q+ag0i6534yHg5rb4s2mO58huKPkSHrO9XeJkEx/4zUchrkhTLF+ZfeqaOtkjY3B3nZZKGriaH8ccXl8azOzZRljv2Czt8NOTdNW7voiv/kTT4apMCxFr+FzGZ1PhOixSsnUxzk62nhz9qmBPtiAj8ClLQPnTliifrXSW4VzSSnz4dzB8jpt6edqNEnjBdR0QW+OKCx0HRgOwQA3aprgOLsSzg+Imv+bU5SJVuqn57CZ3WyPawevzUloPkmvhV8LsOtVnSsTU3XbKzXLGjST8BnkFUttDKScKPxqM8uf9D+u1xDH/EstCR4z73iQoQtjkjwz6VMejEb/87/hF6yf2hSeevRb5gVE9aA07iZwJkBPdDgxaXCTcDZC996gkLY6tVF2xpr9pa3sEm1QP2x3jCuSzaD/d52rc4B4CAEwWUoecdiyRJCii/ct6h8gB2tWMfXIY5M2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(3023799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NuU3FXdVFEakNGclppMTNYVHdIM3M4S3dQV25vUlB0a2RUT01LaVNvUkpE?=
 =?utf-8?B?TG9Ob0ZqQ0Z3L0lTREp1eDFmbmtuY3RVS2gzdlRZOERtcmdrNHhZRThMamE1?=
 =?utf-8?B?N2c1TWlraHIxWVFROWk2eUVIMXcrK1NrQnlDNnAyQU5uMU1DbCtmbGtlejZi?=
 =?utf-8?B?cU1DMHkweVd1VHhoYUl3ZitUa2VkeTM0QnIxRVd6SXFobTZTdk1rQjV5czIr?=
 =?utf-8?B?b3V5V0NNOEZZT0taS3ZtZ2szbEZ3ZUVSNVBnMG9IVkJsWWtxQklET1Bkckw1?=
 =?utf-8?B?a1lTVVF3aUY0Qk94aXk4Snk0OXlraGh6WmhaWTl2ZVNyRHJSRENnYkR3QWgr?=
 =?utf-8?B?WVhPcERRU1p2ZHpZcGRQTjVZRlhpbWd5T2NTaHM0RHNUemgyTWRweHhnc24x?=
 =?utf-8?B?OU1XLzZYM3NPZmdjeEpTMlRCSFArelg3U0VMc0xZWUVMVVZQb0pMUjdQcTk1?=
 =?utf-8?B?L0xraEpHaEY2emRzM2x4ZlhLdHBmeDhmQWpOcExSMVRKNlRMUzlCQ3UyUzh3?=
 =?utf-8?B?cG1RcmZZWmxlWVQzWUtEM1hYZEg0VTNlM01FWTJqNXVMamlzR2x4RVpXcHdM?=
 =?utf-8?B?OHJWTTU4czVjTTNsTFlldUFPTGM1WkUwTHRDTGgvR2FPZDBqa0RRS0QwbXVq?=
 =?utf-8?B?aUI1Y0hhOU9hcVUyQktWMklZNW1aL1lNT25oSUQyR2w2UVBkd2crMkgwQkdv?=
 =?utf-8?B?Z3NKMUh1WUJnWnpRZkhleWRENE1La0FFR3pDN1g2Y0ZKcDFsV3JwOXkzS2FF?=
 =?utf-8?B?R1hJNU5tbHc1MG53UUo3TGlIdTNid2JSODJTN3ptcVNGMERWSlVJVEp0cEtL?=
 =?utf-8?B?ODBlNlNIVDZUN1UxYU5ZWUdHd0dtLzUyNFdKQ01vb3NtUnZpK0NlcFRjNDQy?=
 =?utf-8?B?NnhRRlRwd1pVYUJjNXpDOUVncEg3elptaU9lYy8rekVDcW1aWlZzM1BjM1lJ?=
 =?utf-8?B?aFF0bXUwYzNGR2R4Q1lzOC9wdkQzelRPTkt3S2QvN2ZBdENvNnFMSFJJUEdo?=
 =?utf-8?B?WEJjMFFINGljK2JreDVrc09laEcyNFBxZDVOSHorbTRTb3ZjOEhNcGlueFZp?=
 =?utf-8?B?aUN4cWEwaEpBME9tU2xOOHFuaGRUMmhDYkUrRUhTZGhJalkyS0tMWTJwSTlo?=
 =?utf-8?B?VkMwWVZwVFJJK241R3Ftd2dXWkQ0aTF1aWI2Y2xNY2JhSWIvQjdWeEdXQkhu?=
 =?utf-8?B?aytpdFNIWXdnOXhYRGZpY2pTaHdNZXhlUnRDYlVPa3Z2blF5L0JRL0E5cktI?=
 =?utf-8?B?b2ZNZGV5NjlzblZ2M2JqVElLaW5XQmRvb3cwWDBxOFZFRGZRT3BZNW5kRjYr?=
 =?utf-8?B?ZWFCMXpxdjZwc1dOM1cvaGhGR2dqY0taNjRFQS9wQUJqd0ZRNzFLTDhsMkRk?=
 =?utf-8?B?TS94ak1QRkZzZHJtNlp5U2pjV1JSMkx0MnF4NkV0RkRIbW9xV0tiSkdYNmFi?=
 =?utf-8?B?ZGlGUldSOUxjTk5TTDJLVDNnN004bjBRN3NIRmVaTkVEODlZY1RudUtWYTBk?=
 =?utf-8?B?cURZSi9sSGpZdXEvcnRwbG9aR3hSWTNQVGdBMTRCelhzMDUwTTZIOWw1N1RP?=
 =?utf-8?B?b0dSZGtCSGh5ZGtUL3FLa2xLR3FYMGl1c25FWHBFM21UMFdWODQzMlgrdDFW?=
 =?utf-8?B?dkFhM0RKdlBrQUhYWEs0NHl2UStNMnBXb29hZTFQT2NlaDhaUTlpNHM4cXBT?=
 =?utf-8?B?ci9pQ205RFdJeEkxdGhzUnV1VWlCUDZEL3dKUHdNS1dzelNWQUgybXNyOUha?=
 =?utf-8?B?emFhdkR4dmtlTDM3bUNzVGpsd2xJemd1WHZoZmdHbmlweWU4eStURmdMZDR2?=
 =?utf-8?B?OUhEQVVmY1ZTVXZveEpPVi9vNFNDUVp2VFF2M3lEdWZPYTY5R2V2dzVFNG5Y?=
 =?utf-8?B?MXJ1N3B6Tmo4bXFHSklMd2Vwbm94YmFlSytTUHRKS2FTSktmSXhMZlo1M2tr?=
 =?utf-8?B?SkVaVmRaM0JLZEN0Nkh6QTdJM2NMOHFLZ09pM0RQTmNwdEF6azluTStuejJ6?=
 =?utf-8?B?ZnFRTjFodENjaWcyTXNqWG5WVGlwa2VRNTRPSjA5UEoySmtEc0RaVGlKbXQ1?=
 =?utf-8?B?MGtPR29QVHhGL2ZWeXRaOHBjK1dzWTc4THA2MWY4cmdsbzlseTJkUXprTXNW?=
 =?utf-8?B?SGlGQXI0cE4rYTJiTTc5VUJaZVEyRGc3TnM1Sk13eXFQYUlKeXFZVW9GZTV5?=
 =?utf-8?B?VDY3aVJDRFEyY01scExTWWM3L3Z2R0RBSFlLRFRoS1hScVN1UWZFRXRuY0ww?=
 =?utf-8?B?UmdDdVd4dzJyZzNERk1nSTFXYnFZaE5mVkkvZk9laHhGRUQrczM4UENFOHVq?=
 =?utf-8?B?OExhUWF3NDIyVTIwUWhXdjVlcWR3Y3ZFZE9GK1VUZ0F6NXAxNUR0dTIrR2pX?=
 =?utf-8?Q?Mi3tm3sO66yO+AXs=3D?=
X-Exchange-RoutingPolicyChecked: wQqYEjboC+4hhRssMhPRG40SjykA7H32bSdUELHAaBHPH8BFXJZnvn+T9oQVsIxom8UiWmyrTweiXImogJny+bB3pFRnVvsdoBPVU4aPLuv8C1lHT1zVXMxIOiTj28ba8RjpWEE5LDc+eepWprqXPBtJBKcybd4fpFORkC1gbqvXq+AP+psJBXHruWqQ0ExASumJMDE/D76MV3tAz4XUAHF/KEpoZqpR8UdfBgwacryys3+Hqhf0oAYBYsBqXuOQAhJC0Fzq6FOxmJiyOxPfBgrm7XlXasQO92qNFYn195xjc/VW4oyfcC9Kc9lxwUkmeu4YhFqYTHrFZC5DsQOR4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 364070d1-c2c1-4756-6549-08deadf48898
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 17:58:11.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8z4LvbdJ0Khn0X+Bs/cuM83555jE5yQZic1rvfEL5da7bcBObzawBJNRMR6MwHvi3mTe+xJpZBgU5TKVqr/fVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
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


On 07-05-2026 08:57 pm, Morten Brørup wrote:
>> From: Rajesh Kumar [mailto:rajesh3.kumar@intel.com]
>> Sent: Thursday, 7 May 2026 15.45
>> To: dev@dpdk.org
>>
>> Add PTP (Precision Time Protocol) header structures and inline helper
>> functions to lib/net following DPDK conventions for protocol libraries
>> (similar to rte_tcp.h, rte_ip.h).
>>
>> Provides wire-format structures with endian-annotated types:
>>    - rte_ptp_port_id: 10-byte port identity with EUI-64 clock ID
>>    - rte_ptp_hdr: 34-byte common message header with correctionField
>>    - rte_ptp_timestamp: 10-byte nanosecond-precision timestamp
>>
>> PTP message type constants for all IEEE 1588-2019 message types
>> (Sync, Delay_Req, Announce, Management, etc.) and flag field bits
>> (two-step, unicast, leap indicator).
>>
>> Inline accessor and utility functions for performance:
>>    - rte_ptp_msg_type(), rte_ptp_version(), rte_ptp_domain()
>>    - rte_ptp_seq_id(), rte_ptp_is_event(), rte_ptp_is_two_step()
>>    - rte_ptp_correction_ns(), rte_ptp_add_correction()
>>    - rte_ptp_timestamp_to_ns() for timestamp conversion
>>
>> Supports all PTP encapsulations: L2 (EtherType 0x88F7), VLAN/QinQ,
>> UDP/IPv4, and UDP/IPv6 (ports 319/320).
>>
>> All inline functions — zero function call overhead, suitable for
>> real-time packet processing.
>>
>> Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
> Great progress.
>
> My next wave of comments inline below. :-)
Appreciate your time and feedback :-)
>
>> ---
>>   MAINTAINERS         |   6 +
>>   lib/net/meson.build |   1 +
>>   lib/net/rte_ptp.h   | 264 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 271 insertions(+)
>>   create mode 100644 lib/net/rte_ptp.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0f5539f851..da31ada871 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1665,6 +1665,12 @@ F: doc/guides/prog_guide/ipsec_lib.rst
>>   M: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>>   F: app/test-sad/
>>
>> +PTP - lib/net
> Please remove lib/net from this headline.
> Intead, suggest:
> PTP (IEEE 1588 Precision Time Protocol)
Done. Changed to PTP (IEEE 1588 Precision Time Protocol)
>
>> +M: Rajesh Kumar <rajesh3.kumar@intel.com>
>> +F: lib/net/rte_ptp.h
>> +F: examples/ptp_tap_relay_sw/
>> +F: doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
>> +
>>   PDCP - EXPERIMENTAL
>>   M: Anoob Joseph <anoobj@marvell.com>
>>   M: Volodymyr Fialko <vfialko@marvell.com>
>> diff --git a/lib/net/meson.build b/lib/net/meson.build
>> index 3fad5edc5b..63d13719f3 100644
>> --- a/lib/net/meson.build
>> +++ b/lib/net/meson.build
>> @@ -28,6 +28,7 @@ headers = files(
>>           'rte_geneve.h',
>>           'rte_l2tpv2.h',
>>           'rte_ppp.h',
>> +        'rte_ptp.h',
>>           'rte_ib.h',
>>   )
>>
>> diff --git a/lib/net/rte_ptp.h b/lib/net/rte_ptp.h
>> new file mode 100644
>> index 0000000000..649b944d29
>> --- /dev/null
>> +++ b/lib/net/rte_ptp.h
>> @@ -0,0 +1,264 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause
>> + * Copyright(c) 2026 Intel Corporation
>> + */
>> +
>> +#ifndef _RTE_PTP_H_
>> +#define _RTE_PTP_H_
>> +
>> +/**
>> + * @file
>> + *
>> + * PTP (IEEE 1588) protocol definitions
>> + */
>> +
>> +#include <stdint.h>
>> +#include <stdbool.h>
>> +
>> +#include <rte_byteorder.h>
>> +#include <rte_common.h>
>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +/*
>> + * PTP Constants
>> + */
>> +
>> +/** PTP over UDP event port (Sync, Delay_Req, PDelay_Req,
>> PDelay_Resp). */
>> +#define RTE_PTP_EVENT_PORT        319
>> +
>> +/** PTP over UDP general port (Follow_Up, Delay_Resp, Announce, etc.).
>> */
>> +#define RTE_PTP_GENERAL_PORT      320
> The libc header <netinet/in.h> defines IPPORT_xxx.
> We should use something similar:
> #define RTE_IPPORT_PTP_EVENT and RTE_IPPORT_PTP_GENERAL
Done. Renamed RTE_PTP_EVENT_PORT → RTE_IPPORT_PTP_EVENT and 
RTE_PTP_GENERAL_PORT → RTE_IPPORT_PTP_GENERAL. Updated all usages in 
ptp_parse.h (IPv4 and IPv6 sections).
>> +
>> +/** PTP multicast MAC address: 01:1B:19:00:00:00. */
>> +#define RTE_PTP_MULTICAST_MAC     { 0x01, 0x1B, 0x19, 0x00, 0x00, 0x00
>> }
>> +
>> +/** PTP peer delay multicast MAC: 01:80:C2:00:00:0E. */
>> +#define RTE_PTP_PDELAY_MULTICAST_MAC { 0x01, 0x80, 0xC2, 0x00, 0x00,
>> 0x0E }
> Similarly here; we should establish a convention for MAC addresses,
> like RTE_ETHER_TYPE_xxx in DPDK <lib/net/rte_ether.h>.
> Suggest:
> RTE_ETHER_ADDR_PTP_MULTICAST and RTE_ETHER_ADDR_PTP_MULTICAST_PDELAY
>
> This also follows the general naming convention of having the broadest scope is first and the narrowest scope last.
Done. Renamed to RTE_ETHER_ADDR_PTP_MULTICAST and 
RTE_ETHER_ADDR_PTP_MULTICAST_PDELAY.
>
>> +
>> +/*
>> + * PTP Message Types (IEEE 1588-2019 Table 36)
>> + */
>> +
>> +#define RTE_PTP_MSGTYPE_SYNC            0x0  /**< Sync (event). */
>> +#define RTE_PTP_MSGTYPE_DELAY_REQ       0x1  /**< Delay_Req (event).
>> */
>> +#define RTE_PTP_MSGTYPE_PDELAY_REQ      0x2  /**< Peer_Delay_Req
>> (event). */
>> +#define RTE_PTP_MSGTYPE_PDELAY_RESP     0x3  /**< Peer_Delay_Resp
>> (event). */
>> +#define RTE_PTP_MSGTYPE_FOLLOW_UP       0x8  /**< Follow_Up (general).
>> */
>> +#define RTE_PTP_MSGTYPE_DELAY_RESP      0x9  /**< Delay_Resp
>> (general). */
>> +#define RTE_PTP_MSGTYPE_PDELAY_RESP_FU  0xA  /**<
>> Peer_Delay_Resp_Follow_Up. */
> Missing in the description: (general)
Done. Changed to Peer_Delay_Resp_Follow_Up (general).
>
> For consistency, consider renaming RTE_PTP_MSGTYPE_FOLLOW_UP to RTE_PTP_MSGTYPE_FU.
Done. Renamed RTE_PTP_MSGTYPE_FOLLOW_UP to RTE_PTP_MSGTYPE_FU.
>
>> +#define RTE_PTP_MSGTYPE_ANNOUNCE        0xB  /**< Announce (general).
>> */
>> +#define RTE_PTP_MSGTYPE_SIGNALING       0xC  /**< Signaling (general).
>> */
>> +#define RTE_PTP_MSGTYPE_MANAGEMENT      0xD  /**< Management
>> (general). */
>> +
>> +/*
>> + * PTP Flag Field Bits (IEEE 1588-2019 Table 37)
>> + *
>> + * These constants are for use after rte_be_to_cpu_16(hdr->flags).
>> + * flagField[0] (octet 6) maps to host bits 8-15.
>> + * flagField[1] (octet 7) maps to host bits 0-7.
>> + */
>> +
>> +#define RTE_PTP_FLAG_TWO_STEP    (1 << 9)   /**< Two-step flag. */
>> +#define RTE_PTP_FLAG_UNICAST     (1 << 10)  /**< Unicast flag. */
>> +#define RTE_PTP_FLAG_LI_61       (1 << 0)   /**< Leap indicator 61. */
>> +#define RTE_PTP_FLAG_LI_59       (1 << 1)   /**< Leap indicator 59. */
> We don't have a RTE_BIT16() macro like the RTE_BIT32/64() macros, so maybe use:
>
> #define RTE_PTP_FLAG_TWO_STEP    (UINT16_C(1) << 9)   /**< Two-step flag. */
> #define RTE_PTP_FLAG_UNICAST     (UINT16_C(1) << 10)  /**< Unicast flag. */
> #define RTE_PTP_FLAG_LI_61       (UINT16_C(1) << 0)   /**< Leap indicator 61. */
> #define RTE_PTP_FLAG_LI_59       (UINT16_C(1) << 1)   /**< Leap indicator 59. */
Done. All four flag macros now use (UINT16_C(1) << N).
>> +
>> +/*
>> + * PTP Header Structures (IEEE 1588-2019)
>> + */
>> +
>> +/**
>> + * PTP Port Identity (10 bytes).
>> + */
>> +struct __rte_packed_begin rte_ptp_port_id {
>> +	uint8_t    clock_id[8]; /**< clockIdentity (EUI-64). */
>> +	rte_be16_t port_number; /**< portNumber. */
>> +} __rte_packed_end;
>> +
>> +/**
>> + * PTP Common Message Header (34 bytes).
>> + */
>> +struct __rte_packed_begin rte_ptp_hdr {
>> +	uint8_t    msg_type;       /**< transportSpecific (4) |
>> messageType (4). */
>> +	uint8_t    version;        /**< minorVersionPTP (4) | versionPTP
>> (4). */
> The two fields above should be split into their nibbles, for direct access, like the version_ihl field in the IPv4 header:
> https://elixir.bootlin.com/dpdk/v26.03/source/lib/net/rte_ip4.h#L43
>
> E.g.:
>
> 	__extension__
> 	union {
> 		uint8_t ts_msgtype;     /**< Message type */
> 		struct {
> #if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
> 			uint8_t msg_type:4; /**< messageType */
> 			uint8_t ts:4;       /**< transportSpecific */
> #elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
> 			uint8_t ts:4;       /**< transportSpecific */
> 			uint8_t msg_type:4; /**< messageType */
> #endif
> 		};
> 	};
>
> Warning: I'm not sure I got the nibble order right. Make sure you do! :-)
Done. Used __extension__ union { uint8_t ts_msgtype; struct { uint8_t 
msg_type:4; uint8_t ts:4; }; }; with RTE_BYTE_ORDER conditional for 
endianness, matching rte_ipv4_hdr convention.
>
>> +	rte_be16_t msg_length;     /**< Total message length in bytes. */
>> +	uint8_t    domain_number;  /**< PTP domain (0-255). */
>> +	uint8_t    minor_sdo_id;   /**< minorSdoId (IEEE 1588-2019). */
>> +	rte_be16_t flags;          /**< Flag field (see RTE_PTP_FLAG_*).
>> */
>> +	rte_be64_t correction;     /**< correctionField (scaled ns, 48.16
>> fixed). */
>> +	rte_be32_t msg_type_specific; /**< messageTypeSpecific. */
>> +	struct rte_ptp_port_id source_port_id; /**< sourcePortIdentity.
>> */
>> +	rte_be16_t sequence_id;    /**< sequenceId. */
>> +	uint8_t    control;        /**< controlField (deprecated in 1588-
>> 2019). */
>> +	int8_t     log_msg_interval; /**< logMessageInterval. */
>> +} __rte_packed_end;
>> +
>> +/**
>> + * PTP Timestamp (10 bytes, used in Sync/Delay_Req/Follow_Up bodies).
> The PTP timestamp origo should be mentioned here.
> E.g. the UNIX time_t origo is Jan 1st 00:00:00 1970.
Done. Added Seconds since PTP epoch (1 January 1970 00:00:00 TAI) to 
struct docstring.
>
>> + */
>> +struct __rte_packed_begin rte_ptp_timestamp {
>> +	rte_be16_t seconds_hi;   /**< Upper 16 bits of seconds. */
>> +	rte_be32_t seconds_lo;   /**< Lower 32 bits of seconds. */
>> +	rte_be32_t nanoseconds;  /**< Nanoseconds (0-999999999). */
>> +} __rte_packed_end;
>> +
>> +/*
>> + * Inline Helpers
>> + */
>> +
>> +/**
>> + * Extract PTP message type from header.
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header.
>> + * @return
>> + *   Message type (0x0-0xF).
>> + */
>> +static inline uint8_t
>> +rte_ptp_msg_type(const struct rte_ptp_hdr *hdr)
>> +{
>> +	return hdr->msg_type & 0x0F;
>> +}
>> +
>> +/**
>> + * Extract transport-specific field from header.
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header.
>> + * @return
>> + *   Transport-specific value (upper nibble, 0x0-0xF).
>> + */
>> +static inline uint8_t
>> +rte_ptp_transport_specific(const struct rte_ptp_hdr *hdr)
>> +{
>> +	return (hdr->msg_type >> 4) & 0x0F;
>> +}
>> +
>> +/**
>> + * Extract PTP version from header.
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header.
>> + * @return
>> + *   PTP version number (typically 2).
>> + */
>> +static inline uint8_t
>> +rte_ptp_version(const struct rte_ptp_hdr *hdr)
>> +{
>> +	return hdr->version & 0x0F;
>> +}
>> +
>> +/**
>> + * Get sequence ID from PTP header (host byte order).
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header.
>> + * @return
>> + *   Sequence ID in host byte order.
>> + */
>> +static inline uint16_t
>> +rte_ptp_seq_id(const struct rte_ptp_hdr *hdr)
>> +{
>> +	return rte_be_to_cpu_16(hdr->sequence_id);
>> +}
>> +
>> +/**
>> + * Get PTP domain number.
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header.
>> + * @return
>> + *   Domain number (0-255).
>> + */
>> +static inline uint8_t
>> +rte_ptp_domain(const struct rte_ptp_hdr *hdr)
>> +{
>> +	return hdr->domain_number;
>> +}
> The above "get" accessor functions are superfluous. Please remove:
> rte_ptp_msg_type()
> rte_ptp_transport_specific()
> rte_ptp_version()
> rte_ptp_seq_id()
> rte_ptp_domain()
Done. All five removed. Callers updated to use direct field access: 
hdr->msg_type, hdr->version, hdr->domain_number, 
rte_be_to_cpu_16(hdr->sequence_id), etc.
>
>> +
>> +/**
>> + * Check if PTP message type is an event message.
>> + * Event messages (msg_type 0x0-0x3) require timestamps.
>> + *
>> + * @param msg_type
>> + *   PTP message type value (0x0-0xF).
>> + * @return
>> + *   true if event message, false otherwise.
>> + */
>> +static inline bool
>> +rte_ptp_is_event(int msg_type)
>> +{
>> +	return msg_type >= 0 && msg_type <= RTE_PTP_MSGTYPE_PDELAY_RESP;
>> +}
> Suggest passing the parameter as const struct rte_ptp_hdr *hdr, like in rte_ptp_is_two_step() below.
Done. Parameter changed from int msg_type to const struct rte_ptp_hdr 
*hdr. Body uses hdr->msg_type. All callers updated.
>> +
>> +/**
>> + * Check if the two-step flag is set in a PTP header.
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header.
>> + * @return
>> + *   true if two-step flag is set.
>> + */
>> +static inline bool
>> +rte_ptp_is_two_step(const struct rte_ptp_hdr *hdr)
>> +{
>> +	return (rte_be_to_cpu_16(hdr->flags) & RTE_PTP_FLAG_TWO_STEP) !=
>> 0;
> Faster way:
> return (hdr->flags & RTE_BE16(RTE_PTP_FLAG_TWO_STEP)) != 0;
Done. Uses hdr->flags & RTE_BE16(RTE_PTP_FLAG_TWO_STEP) for compile-time 
constant comparison.
>
>> +}
>> +
>> +/**
>> + * Get correctionField value in nanoseconds (from 48.16 fixed-point).
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header.
>> + * @return
>> + *   Correction value in nanoseconds.
>> + */
>> +static inline int64_t
>> +rte_ptp_correction_ns(const struct rte_ptp_hdr *hdr)
>> +{
>> +	return (int64_t)rte_be_to_cpu_64(hdr->correction) >> 16;
>> +}
> This "get" accessor function is superfluous. Please remove:
> rte_ptp_correction_ns()
>
> The "correction" field in the PTP header structure should sufficiently describe the field's fixed-point encoding.
>
>> +
>> +/**
>> + * Add a residence time (in nanoseconds) to the correctionField.
>> + * Used by Transparent Clocks to account for relay transit delay.
>> + * The correctionField uses IEEE 1588 scaled nanoseconds (48.16 fixed-
>> point).
>> + *
>> + * @param hdr
>> + *   Pointer to PTP header (will be modified in-place).
>> + * @param residence_ns
>> + *   Residence time in nanoseconds to add.
>> + */
>> +static inline void
>> +rte_ptp_add_correction(struct rte_ptp_hdr *hdr, int64_t residence_ns)
>> +{
>> +	int64_t cf = (int64_t)rte_be_to_cpu_64(hdr->correction);
>> +
>> +	cf += (int64_t)((uint64_t)residence_ns << 16);
>> +	hdr->correction = rte_cpu_to_be_64(cf);
>> +}
> I don't think negative time can be added, so please use uint64_t instead of int64_t for the parameter and inside the function.
>
> Note to reviewers: "residence time" is the term in the standard. "sojourn time" is not used.
Done. Parameter changed from int64_t residence_ns to uint64_t residence_ns.
>
>> +
>> +/**
>> + * Convert a PTP timestamp structure to nanoseconds since epoch.
>> + *
>> + * @param ts
>> + *   Pointer to PTP timestamp.
>> + * @return
>> + *   Time in nanoseconds since epoch.
>> + */
>> +static inline uint64_t
>> +rte_ptp_timestamp_to_ns(const struct rte_ptp_timestamp *ts)
>> +{
>> +	uint64_t sec = ((uint64_t)rte_be_to_cpu_16(ts->seconds_hi) << 32)
>> |
>> +		       rte_be_to_cpu_32(ts->seconds_lo);
>> +
>> +	return sec * 1000000000ULL + rte_be_to_cpu_32(ts->nanoseconds);
>> +}
> 1000000000ULL -> UINT64_C(1000000000)
Done. Changed 1000000000ULL -> UINT64_C(1000000000).
>
>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif /* _RTE_PTP_H_ */
>> --
>> 2.53.0

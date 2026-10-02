Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26485CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 11:00:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D580C4026C;
	Fri,  2 Oct 2026 13:00:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 791A04003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 13:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790938855; x=1822474855;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FAYTI7FoVEH4e5LElIr9HqMz6aKBwMVsRAD/kTcCp2M=;
 b=FpxRUr2i34PVQZmXT9v8LsZgfmEXK+7fa+SI9e0N5faYJgAFEdHc9Y/r
 Dk54NLxKcprYfIPMs7lzP0TP1wqBYErcSlv0jY6ECQ2MiJtkypC/Er2Sf
 /wQPr1H1Rahucrq7Nl9N8ajerKWglw9aVZCK7S1zfxEobSRCpHjo2N9J0
 wcYjF9ElPw6HSwHy3Dzn0G8YUVMStDh5C+G6BNvepiI+q++oUHeRvh7l1
 7GziyFu4pgAoZTxS35tOJh2d0QHExQn/VkQ0ByBnXHdWzpvktQgFOLTto
 ri34a9oIQuT4SFUyWMTRVDEtQdYoixbytpxqiAI9I0eVFwHL0ADvx/zmi w==;
X-CSE-ConnectionGUID: jJROELqiSweP16fPs7Wesw==
X-CSE-MsgGUID: lIWIgJE2T++1kOaybWh3pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94191558"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="94191558"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:00:54 -0700
X-CSE-ConnectionGUID: ovgtYdVOTdW7BgF4jAvhdw==
X-CSE-MsgGUID: DJdBcMvARouIpavAfeL5aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="274315492"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:00:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 04:00:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 04:00:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 04:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWSvD+KukmglaZQzaQ0MxhS7RrQZJmrohb4kkpnhpnP0V89dKHs1ktSo5JRGZ6vvWCTo6GymD04Kn5KO9b3TAwW7GEKrtHFvrY41n2XHHGln2HivZwMhvPKBjlofe57RPXzd8X2ZL6NBoG76C09vCcv0P4wNGRLy0K8TDqeiZ+sIZRYHnHF4npRBKpw5hwIAXzgP1z+PCZwIyKnRJPr4jgS3mKbfCRJIwuP4LDB2TCFgeUPfsBxDNYpURHQqWKu/71uI6igvRko8kFlINPZSqrQz1tMHzw3mLvuTckg81q8AVtzlP7xxwiOEWmSUQqhBzvQfFLiSWLR8xaTt7itH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7135sxUsW7NUtRAWP/hpppMw+HQIADKVc7xnAtpy5Q=;
 b=FBps/C5BqHHEq3OQoqfYAGXOtU5plRT3kFDajTYxE1dxmk/hxND7b+WwEjDxr+Qc+hRvSOvWzkbrZzRjd9F0wSTztIv1MB8Fv4jtpuU6QEFO74GPkmMkTJB7gj8lAdJHHTJ/hiuw25Jh0BUd1OKsaHAEaODJRluhc2dTaAGLvZshLNQfCqjvb49EezxX7jKdk0AX89rfXTcYsIiKXSK13hzKQNkQnLxayXGwxzdt+HeHu3kyXTNluIkyi1FoYjkp6lGwVM3dHg5GFDBPzmCogkwKDzcVGCOf/x1BDuA1Pl3A16EHV1g1sUml8vMUn3owCjyJDupIEZ8FM1jv2hZJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Fri, 2 Oct 2026 11:00:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 11:00:49 +0000
Message-ID: <e98fa358-0c2f-48c0-b142-ce6c6a6a52bd@intel.com>
Date: Fri, 2 Oct 2026 13:00:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] ethdev: add flow graph API
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
References: <cover.1789560943.git.anatoly.burakov@intel.com>
 <b1982ff795e9db6f7fa34992573f7bad0294f77a.1789560944.git.anatoly.burakov@intel.com>
 <20260916172134.4a6e37e3@phoenix.local>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260916172134.4a6e37e3@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0016.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::21) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: ef44b8bb-b483-4d72-248f-08df20746b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|56012099006|11063799006|10067099003|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dE89NxsadHqXTZmy99ySZdEgCntEGuo1NgMmYtDNNBVDcDeUISPyRLDvK6tG8yUARtA7LuNh/KZzOpdyZQPshK+KqW+45DVsi8ZllJXuhaC33l4iJ6J0BKEmRfd6KnA8cNhmatMT7V3ngKzbUArd+QTxRQBTPBYOLwM3vl9LzCik9+bj0GUTGK3vz08TIHIG8Kmn4y4ZbH89wH41/h8SaatUTr+yrt737KV7D8JufU3nHpE/MxR05bK4pYjoIh212abp/JCJwpcGeFnGVDPi5oRCFx7IA8hg0VZsXTULFdMcLUu+68lVexacFDveR6V5wlgOEtUR83SUkny+B26er2bzVOelT0hRTA1co1e9LFdjwYs7BwT9SZdVoXHCc3icnu1lozAQOpfIMmtSK5BUp2MnBGVUPbW6bI7EWTSTFKzqI5qUTJxcppxC7Pujk62kK6auvvox1d4v5Wd5uiLHrIe2PkZ9dGicgqF11FBBMScK//eY/BwfuIq/GkY+oew/8nc8pbu2CV6FXqVH8oVOk10fh0m74B5ydBbNt3Ks2FmBVBGUgQZEG55WjALEJ32so2sDM9vErvFroL1w5+O2aBbL+Wa5nMnRE6yjaQQ1KRNX86Esxsj+lPXDQamnakGcMX5XakLKO0uhoEmJTFaiTH39HOpr9ZDDEq2ajsir/oM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(10063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEIvZ3JzdW5aL0Z0aTd4aGZSMnVsUEF4dTkvSWJPZlNuSm1FaFNzazV4STgx?=
 =?utf-8?B?NU5lTk1EYm5WNVpGMU9Dd3pVaksrS1ZQa3pvbGdpSDVDZUVteTRGZ0FXVTBp?=
 =?utf-8?B?WGZ3aUxhd21UNzdRcDNyUzRUWGlvT2FmSzJ6d3NldXlKdmN1U0h4Q1VMUzRi?=
 =?utf-8?B?Q2ptcU1JUlFiTnJhVktBUXdHS3pndjlNZ3RNUWhmTWRTOU9zYTRvOUhmUnZD?=
 =?utf-8?B?eGFEN0dTa21JWWZjK3hOU1pGNWNHNWdJYTZpWWQ2NE1tWFp6WnlTWWJ3S3dJ?=
 =?utf-8?B?N1JZV2FpVXNjYnc1ZWFGRGxEWnA4Y1hzeU9NUU1XTFZCd0JpczhGVmdUdTl4?=
 =?utf-8?B?ZStuNVYvMHdaclIyQU9SYml4ZnNrYTBoN3o4ajkzSjJ1eC9MaU5uN05QWG5o?=
 =?utf-8?B?TDFNZ0NoclBBa1ZqVmNXSzgvK0FKbElIcyt4b2ZUNFBMUE51bldXeXNPSURk?=
 =?utf-8?B?dERySkhvOFc1TDV3c1ZVYXFHc0EvazFkU3pFSzJOenJKUFRlbXdSM1dJMUlj?=
 =?utf-8?B?WjcvYnRIRldnRGZtRGY3SWgyczRYMEFmdDRhOWN0UjZxMUdLUEY2NUJjZnVs?=
 =?utf-8?B?N0hmZEV1cy9MUk11TUtEdmJCNEVPdVNaTWlWRHJXTGFONVI1WXhiTUFhZGpM?=
 =?utf-8?B?dFBpREd5cGpmNjZQcEo0NFVEYS9TQVMxMHg5akF4ZVg0dWJmYWRqV0N5RUts?=
 =?utf-8?B?K05uSHNqUy9XLzhEVm1YdzBEY2p2Qmd3aEd2VDNwQjhwcGRHYTVITEpta3Rw?=
 =?utf-8?B?MHUzYzNzVXZ2SlJGS2Vac3Q0NkllTE1PY0IySFhJR0RQaG1iOWNGeWRQZ3lu?=
 =?utf-8?B?UUk5eVNVVFlmT1JXck9oMlNpcERqZWd5dWpqWjNLVktFcEdPYzVmZitqbXhV?=
 =?utf-8?B?SUhwaFNhVGM5N0JyK2xJSTdxeTFacWs4TXNCL2h5TUpwSWV6SDNjOTA2blkv?=
 =?utf-8?B?Y1pHSXQzVFp2TGZhSXBTT2YwcFRjbkFVWDZrZWdrczdNYmR4WEJhdjZqOE9J?=
 =?utf-8?B?bm93RVhqd0tZZ1dzNng3d0VMQ3M2U2RHNXliUUdVUGh2ZzNFMENsRERvdmNs?=
 =?utf-8?B?SDdCZU4zOFRvYUZJQzFWWWFNSGtsNi8zTDdBdXlCbTJRS3hjcG4yV05jamw2?=
 =?utf-8?B?NzlzUE5RRnBXM09ENVJjVnhrdmNFaGVTMEx2dEYrOXdaNkcxbm5xY25yV1oz?=
 =?utf-8?B?ZXpVZzd4Q3dQektqaU1CK2hFb0pnOVNBR2JNTklqU2VITXBTQ3lFdUVtYmcw?=
 =?utf-8?B?c05QWERkeFNWYTJTeThvaXRsUE51ODR2LzIyRmZiL0lGSmpLVnd3VFp5OTVH?=
 =?utf-8?B?TUcvNzl0blQ1bDJyazJZekt2dGpzcHlqQURvNGZxYU9zZEFWNVBxS0Q2WjhD?=
 =?utf-8?B?dEJubWpHTE5KUTVvQlBhQlQvd2hXMzBmdGx1SW5DOE56dmxPM0VQNnFQTXFC?=
 =?utf-8?B?S1p0eWNXU05qMHBJcDVxVHZzRlYvQzhjZHQ3Y2ZoVjBLVzR3d3hUcGdILzFs?=
 =?utf-8?B?K0lnVHJJWDdSMnV3WkJlN2tSdS9tOHBVaEN0RkI0YkRWUzZ2NDZQZ2VOMWtn?=
 =?utf-8?B?RHJlOUEycWZocDhsTW1nWVA3Z01zWCswWjdhYWdLTG15M3Z1L1VHbXhxNUVt?=
 =?utf-8?B?MlRJTTk3VUIrTVBFTWh3ckJyb1pwOWVwYnVpOS9EMkhpVWZPT3hUS0lDcHdL?=
 =?utf-8?B?S1h5WlVDUnJBVmMxYmU3Q2cxQ0V6WkhnZFhPcjhuNnYvMHRvcC94d2Q1Y0Fp?=
 =?utf-8?B?RWMyWjI2NmRzcHhnbWk2a1BKd3oyendqYjU0SGlTWDF6ZEVsdU9DOVlBeXlC?=
 =?utf-8?B?djRZdTFOcXFtTnVucnRSbWU5UHF0eE9KT210UTJ3ZTEwZHpLbmo4WVdMVlNL?=
 =?utf-8?B?ejVPTzl6ck54TWtTb1NpaUpQR1BhcXVWUVgvRmpNUHQ0Z3U5dUVEdk1oYXg1?=
 =?utf-8?B?aFMyY3p0S1hXQ0tnTEQ2N0pZaHNvZTFoS2Z0b1lPcHB5cW8wd0RaSDdWd1Zr?=
 =?utf-8?B?QnVyTUxSQTNZL1JWQVcrYXNwZmVrVzAvQWVaYzBiSmk2bWx1dzJKSVluWGVK?=
 =?utf-8?B?UisyZFFMZmM0MkxUWFM3c0lMQkhHWUxreDc2ZjJ3YWZYbzM4K2JTeWtiTnhv?=
 =?utf-8?B?UGoxYnhWaDZmK2RTRWZCUE5aREhvcHNpUGNJNHVUYVFsSkxUMHpTQXFFdzhy?=
 =?utf-8?B?M2ptbXNqWE5RSjk0bXA1NXVvZHBnY2lyVEpBZldIQTVBazhqeGxPWlNIc0tr?=
 =?utf-8?B?OTRuUDNHcmdrQTFST0FwSE9vQjJVaWZEcmlVSk5SLzRaTk1CNjhuSVBaa1M2?=
 =?utf-8?B?NTRNaTBEMDA3WDNlNlprVzBrRDhLZHdCcWljd21MRlZSZ1JidHhuVGNpMGxS?=
 =?utf-8?Q?4Zw6e+y5KlzpQpZM=3D?=
X-Exchange-RoutingPolicyChecked: Q7N2jMaQKTiBuLAv6DmmGDkxw6ERJmWn2Svl88SIdVDiYD7O+Qm9tt79FO/Xsy1v0mZFdJ+Q4AN5Mh6xucv5lWhxugf6CvSSY5LHtsy486UQ4+wHhrQ7aArNJV9pr4zRo6RPi2UAyFY9GZXzsI3wpu7j9VoLZ5UfWgvgmY1QigbVzx0+Ta2BSPXbxb0ed83E5D6wg7tLMHkThcSKm/9+P7NNGQBZsXnVEzMFbz1ooo42BTpFcFB+0fHkjtkRcWQIXfCCET0VsxlTjzox86+ZigjXX5k2c3IQiW6mnnt23ybw2jB1k7jHCNrulQtukX61RINLZEHNp0UeiG1iyxtpzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef44b8bb-b483-4d72-248f-08df20746b16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:00:49.6997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/XXuAcLmOpTKSW9W0XNxNWyjI6MKjNQhpa0lt9/Yoo3SfwtIz78XNWOiEX1+7xL9fCY/gunc6Y+D5Ddq2uKyiFh3NpY4VU0XxSTP4vGW30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
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

On 9/17/2026 2:21 AM, Stephen Hemminger wrote:
> On Wed, 16 Sep 2026 13:18:07 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> +static inline const char *
>> +flow_graph_item_type_to_str(enum rte_flow_item_type type)
>> +{
> 
> None of this is critical path, it should not need to be static inline
> and include. Build it once as part of ethdev.

There is nowhere to put it, this is a header library with no compilation 
units. The only place this could be moved to is the rte_flow 
implementation itself which I guess kind of works but will look like a 
less flexible version of rte_flow_conv.

-- 
Thanks,
Anatoly

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA24C61DC7
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 07:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D66C40150;
	Thu, 27 Aug 2026 09:58:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A5E804003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 09:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787817512; x=1819353512;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j+qt2pMzx0Kqjh6sxoTTa9IvmnUgOVWJmRBOmlTeOy0=;
 b=RD8ldjHcyVPFM3OIY+CkLJ6U1TSTILlrUTgtApwwFI1e7qFrL4tmRcCX
 4N4WVJW4jxIhatHuzgzyViE+nOJUppdmY9CyvRxOuZ5qUMZ3BcCPyh1Lf
 lORK2Z9wz1Kr1oTn0LFCQ6l+Yqd3f6iQ6ik5HpFXcEKgNcfg2+PCfpKgX
 +ntkvAWv8hNu2U2W80Qoa1AMqEGBk1oecgbu7dupDoYg5awNVzZkwPGGH
 jd6AnYApDQUnM3MP2OyBev7jivFY5XqILMku+/ECWEt6bVURYr7tsuAdW
 HUsLpdFwqJAmKJ4a9IKS5akcdr8wCEKFUZigzyMA/GHZNql2vpbqp6eEZ A==;
X-CSE-ConnectionGUID: fpcgv6zOR3iRNEI9NI2hGA==
X-CSE-MsgGUID: XBF6xRirSsKgN8fEz366og==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="90820573"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="90820573"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 00:58:30 -0700
X-CSE-ConnectionGUID: rxzWD0x9SVaTxV9KbvZPhQ==
X-CSE-MsgGUID: jP+oZTrCQ9OnJi7Rh1C5xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="271606084"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 00:58:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 00:58:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 00:58:29 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 00:58:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqDP/pVt8lUdOj9l4IH0Me6/hOckulkAJ0R0uct3jQumaa3TFCVIfLOCcObYFEOHU2ke6ZIkwTEHW/L+hbSbFI8V97I/4K4TJ4Sy15DdYyKKE8IyVsB0W4zb7JO4n2e8d2g58ZIElLlbne9fxjceXYrD+OVy9Pb4tzCTc4A4TvikqqQhaumaitsvGO5RSBkrCqyBrpxfP68d4sEm2zJDcc1YmQ2e9O09bJkQzokAVJI7JkCLZGpfYFmx5pfA33Nhq9DpjsuihZrgJ2L14n3jlZOV9mNBKpn1MYTDX5VvZHcmE5uVvMco+Xtl+NHugUhpU5v2xi3XJMt7BZYxFNmW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMaP9yVvuLEYoMwdf4oI8xxYGuEGKN6Cy/srAUvHSxs=;
 b=hevueRXj4miTMBtiQLXJ8oTaSvfJUUQTLnZS+JMheMrwd8ikHHWBXy+340BYWtdmYJwzLjFfwVLOxLcBQg7mMm1idAzIGHUFC0QB7RheLImU9NUstFjrFtsPJzob9klparp476MGQSZ43X6tiBLrLCi9C/uKkXzPFuHvSjXa95b9JUoKNvbf8Sn/ekhCmY6EkEta1qDyHzXXAO/B8hPzTI8uEuqDigRfi3Db6V++d4ZLzavpmnqC4Sjuthv+NjB2/HyMJdmyFZ1diVTWPQSzVedwkSjHZc2pdSKHOMKqbM/hf6aad0kIVqASE5TSFZZ4IeVYx1z9StrE8xrGVapWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:58:22 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 07:58:22 +0000
Message-ID: <4be95b58-6327-471e-bac6-57b7d6e5b37e@intel.com>
Date: Thu, 27 Aug 2026 09:58:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Ori Kam <orika@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
 <nA_0NtHGRc2CE05D7MYfOw@monjalon.net>
 <64e2bbcc-b77e-4b2c-9997-c99553486d0a@intel.com>
 <IR-o-Ca4RH6Rr1n8j2NshA@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <IR-o-Ca4RH6Rr1n8j2NshA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0017.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ1PR11MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd9bffa-aef9-4de8-dbf6-08df0410f716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|3023799007|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E/4ON7u9KmLlTvujfjlgxtFvHSKEbGiKbi7wRukVvKg/sLoXrG7fpa0CHzWSO36WfyByD967aHwFC/WvMT/VXEoWHxT4GSlpYCiBWh0DkCyEj7man3x6ItdvQzAkt524AUmCaW7XDSxEmMq7ClqA8UBQHTy2WhjY8QkpGb4PXUO9fBbN9h7DY3xZ4VWEXTKxLGpYu3KR88EaTKFXiF6tO0IO9OgTEHVzZ4WFNOwn5bR4GUgepV5G0jsMDgjlR6z5coU4a9u4mpQW8AN11qDxqPbevUxuq6yNZ4GMB3KYizGObrkXeIdlNNlVGqXIEz3jKADmtVN/L67kduLUWG2ij5wLsYX5wCNzEexmVCsqPH9s1H80niC3jJNfUTop7LfVnyL/J4EKhkR0M/zILipIIhjKhVQgfmpWDx9igCUK4NC5ymEuRvWCenpEzp4180ukzOo/IhhWFLyXNF2fo7Bnp1wCtLomhrL1jqvqeNj5VLn5F6lREfklpSj4tSaICBhiwAiZRcxQPqgoJcU7cH6TLoRifsPZ+VjGLwoPBZD3aRYXB4e94M1xqm7M0jn/D0I7hY6vp1w6X6naY2JQX0jhB+UkyNh9V3a0UiOW1YwM+3CyA2m5KTdOX18QrAQJz8CppEZtOD3MlgJkD5SobXl3IZBzt+MaTr4kqichydjZe0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QklFT2VIUDJzTy9hMm8rbG1TSXZnOFBJaCtRNnhJMDlEejB1ZFRSSHJHV0F1?=
 =?utf-8?B?TlQxSlJ3REdGNmRyUnFRUFEwSWhzSU9pZ3Z5YzNtWVU1MWUvYjFOMmYzaDJt?=
 =?utf-8?B?eXVDQk5ranpOOGZvNEFMM2NqTGVhczM3MURoam9WbTlwcDhKMkl2N3E1WFJh?=
 =?utf-8?B?SW5mNEhFY2FZbEU2R3BJZzlXd2xHQjhXZmtmdzY1b0VPLzh6RGhnSUxWU0xH?=
 =?utf-8?B?SmVPTTB2Vm5QcWpuOVJpYi9vaWFTejJ0MkVkRjIrOUhEM015RWR4TTVjSDc0?=
 =?utf-8?B?S2Z3dGhvU0ZaRFA0UlpQeE1EUWR0eVE2SUplUndueGlobHBiaUNRTDlNL0Iw?=
 =?utf-8?B?OE16dHZFbStmRGw4a25VOER1RTh5S2Q4cFRaWE1TRGFBWE5YY0cvSFdnWWEw?=
 =?utf-8?B?Y0dJRzZsYUFmTnhFdUR6aXNSemdnRW9xQ1g4Y2pNRUJDWTZibGhJNXNpZzg4?=
 =?utf-8?B?NWYycUhqVEZ3dkUvV0oxZUgySGhjKzBQVG40T3RObzdNUnZaQzVlZWZROFRZ?=
 =?utf-8?B?YmZCd3o4S215RXZoVjRiU1RnYXQ2UGZQTzhwZTBOZFEvT2grWDJjOXdxd3VC?=
 =?utf-8?B?TE1kc2xKclBHTTZOdkZLQ3BCbjhXQVptdWZpYURySCtYU3NZMEJ3elpEajdC?=
 =?utf-8?B?SkRrTi9CQWUyeXBmeW42VWxnZnM3WUpmZmdrdUVNNTdlZVZybE9aOU9mVXY5?=
 =?utf-8?B?Y2NqWjJ1UEV5NGh0QjB3SlZ6dnVkWUxxL241bjZrdUdXYnRxOENLZFJKNklj?=
 =?utf-8?B?MjBPdmZTckUveWZhWi9tRUJhQyt0aG9jdnhmM1dVTkIwV0paWnVWQXQzV1li?=
 =?utf-8?B?U1pDc0IwMkNqYkFLMUhyTzR6TExDam5ObWNqamo3Ujd5K1NSSnlLWDVyeEZJ?=
 =?utf-8?B?Z1paUVFTbjVUY3FtZkQ0L28xK0xSZklMaG9BOHdmdnZabGdmcVp1ZGlrUGUx?=
 =?utf-8?B?WTlvcUFsYndzaHpZQlZIckd3RGY1VUoycnJJQlpBN0JLUnZRUVJEdHVBbzJs?=
 =?utf-8?B?cWRNT2plb3lYdTl2YUFWUStYRDBpOEd5dVpVNW1XSkNCVUoraHZuVWNsZ05z?=
 =?utf-8?B?N1g0eTN3UW1WRXM1Y3phcUNpYjRYcGRmOSs4SmZTQjF4WlhGZkp0OTF4MHRQ?=
 =?utf-8?B?a0NtZFJVTUFhTkRSeEdNbk8rSDU2NmVlUER5ZlFINmwxSnhnZGJOVGtoNWpK?=
 =?utf-8?B?NnV1NFYvUG13WjBHYkVnZHQzRjhaQ2dYeGY2WEQyZ0RaU3RnQk9Ncnh6M0NZ?=
 =?utf-8?B?NUJDamZDTFJxR01GNFZqSE1YbE9TMGtDWVR5ZjFBbkptRUw4K3ZyT09FaktN?=
 =?utf-8?B?cWRweTZjK3V1bmVTWUYwOTJFbEFHcC9nai90WXNCcm9NS3FVQ1dRTzBiVHhk?=
 =?utf-8?B?cGhhdlVON0tvTmJaSTFUditSeGJkMGdKcjBDaElyN0xxQWN2M21tRUdoZnFV?=
 =?utf-8?B?cy9DUXM3aHNIMXhSNUY2OUZRK0tFUThFcDYrVDFtT0dKc3E4eXJXRVRQTmFO?=
 =?utf-8?B?Q2MwVGZVakE2QnI0UkljWitWMGpRQ3c0NzdsVm9HL0ZsSnlBVUVjOGlrV1Rj?=
 =?utf-8?B?emRxNE14WlF2N1JTSzRHWmQzQXRsL2lLYXI2Z1hFRi9oZUNLUkM3YUd2dWR3?=
 =?utf-8?B?aitYOUVKS2F3S3dtY2JRVTljdS81NHFUNm9KK0VvZU1rbkNnVHdobzVGOTY5?=
 =?utf-8?B?akV5eVgxMDRKUlQ0OGIwcWNsNkwxRXdEOVZ2UWpvZktTODNGcExPdGtWOE5X?=
 =?utf-8?B?a3BRQ1hEbFcweVN6VXREUHdTMUx0SzhWKzUwYy9QaE1LVGVibVBVQVA4cjRJ?=
 =?utf-8?B?S3FOdWxONkhnbXh6NU5STzhORmErRHpxZk1FK0N2bDVXQmlxOVFxaHR1Zi9F?=
 =?utf-8?B?N2hPL1JQek8rd2ZpNWZUK0xNc2hoWmE3aFd4dy92dXlZeTVvN2QwTzVpNWlC?=
 =?utf-8?B?SG5VTmExMFp4emsyYWFJRCs4MGR4UUE0RG5JbzlpTndJc2ZZd1lJUzBhbWxi?=
 =?utf-8?B?M3JvVDgzNGRGRTJWMzRUaDFWckNWTG11Ni9PRnNnRjYrRllEUHo2a21EUTZU?=
 =?utf-8?B?YW5xeXV1VlpvUDE4WEFGTEpqcjN3VW1tdXdWK2FUbnBEUjFkam5MTnJaeFNV?=
 =?utf-8?B?UUJuTkUzTnh5ZXhzR3BPQ20yUVQyeGVTbjUzTEcrdktjK1dLYktzbk5PODRN?=
 =?utf-8?B?blZndndDc1ZCaHEzNElNZ25Tazg3bTluQU5MZitJKzAwQWUzU2ZQVlIwYWMx?=
 =?utf-8?B?N2pRUVFSVWE0YS9yVlhnU3JxM3BPdGlLYTQ0anByd1I0WGNIZUVzQ1VWSDJx?=
 =?utf-8?B?TUxJMkt1bUdSaGpCbXhVREFLUlBPSXUvZzlxK0VCZmVBVE5OcUpuU05nelEw?=
 =?utf-8?Q?t/IUQ+rxRmmePN2o=3D?=
X-Exchange-RoutingPolicyChecked: yLm+j0guPh5+qc5hVsD0v76Nd/7kYh8HiXzZMgR/XuWpR9Xc33KD1vp68CNdM8I82EvPEVqQv3gpYKySD6uAPau1zzjXgj5dL30qbRqsQsyU5i/GH720pIodKY/x4iP/Og7fqCEE1vnFbYRE7ArnUz1XF1/SY34LsD1Ttz0OjvvNFgi+tG+OXmR/zUJt7zlonaE0NPiXokmzgLsic6MBhukt00hxkYlKhqrKLH9qkR18QMDcVOCPahn6HDp6g3IwN/rk3WxqXBdeJtTbx0WXC6970jkyE9jN6PVP+LqsWKEFdpfWKKvra66K5F0sdbOKnpjuMvSCTSQOHmDEu/ehcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd9bffa-aef9-4de8-dbf6-08df0410f716
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:58:22.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2y6ud82Q/QOREerE+9Hj5c4nbgbLDIcIs+46rkSXGWxtmPwQmb25hca6FS2twFBcTckDUkpkhD2pO8DSo3TQcrnQCw0bsuwPvj4XZei3xMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
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

On 8/26/2026 4:46 PM, Thomas Monjalon wrote:
> 26/08/2026 12:20, Burakov, Anatoly:
>> On 8/26/2026 11:21 AM, Thomas Monjalon wrote:
>>> 26/08/2026 10:58, Burakov, Anatoly:
>>>> On 8/25/2026 3:55 PM, Thomas Monjalon wrote:
>>>>> 20/08/2026 16:00, Anatoly Burakov:
>>>>>> This commit adds a flow graph parsing API. This is a helper API intended to
>>>>>> help ethdev drivers implement rte_flow parsers, as common usages map to
>>>>>> graph traversal problem very well.
>>>>>>
>>>>>> Features provided by the API:
>>>>>> - Flow graph, edge, and node definitions
>>>>>> - Graph traversal logic
>>>>>> - Declarative validation against common flow item types
>>>>>> - Per-node validation and state processing callbacks
>>>>> [...]
>>>>>>     lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++
>>>>>
>>>>> Are we sure about the name? Why not "parsing" instead of "graph"?
>>>>>
>>>>
>>>> Because it is intended to help build *protocol graphs*, not *generic
>>>> flow parsing*. I.e. only things that lend themselves to be represented
>>>> by a graph would work with this - things like conntrack wouldn't. So, I
>>>> feel like "graph" is a more accurate name for this, because this is only
>>>> for enabling the protocol graph walk, not for full flow parsing.
>>>
>>> OK
>>>
>>>>> Is it only for drivers? In this case, no need to make it a public API.
>>>>
>>>> Yes, it is for drivers. It is not a public API, it is not installed into
>>>> public headers. If there is anything I forgot to do to remove it from
>>>> being public, please let me know.
>>>
>>> You should not use the rte_ prefix for files which are not public.
>>> I know this convention is not well followed for historical reason,
>>> like rte_flow_driver.h should be flow_driver.h
>>>
>>>
>>
>> The fact that it didn't look like there was no convention was why I
>> picked rte_ prefix. I'll happily use a non-rte prefix for these. Maybe
>> use eth_ prefix for both flow_graph and flow_driver? Or does flow_graph
>> work fine?
> 
> I don't think adding eth prefix is needed.
> 
>> [on a separate note: should rte_vfio follow suit and be renamed? it is
>> no longer a public API following my patchset. renaming it to `vfio`
>> would probably cause conflicts with Linux headers, so maybe something
>> like vfio_driver like flow_driver?]
> 
> Yes vfio_driver looks fine.
> 
> 

Actually, on second thought, "vfio_driver" is too similar to 
"bus_driver" and "dev_driver" which kind of implies that "vfio_driver" 
is for writing vfio drivers. Maybe dev_vfio would be better?

(flow_driver sits in lib/ethdev which is a driver subsystem, but vfio 
sits in EAL which is not, so for flow_driver I think "flow_driver" is 
OK, but vfio header is in common include together with bus_driver and 
dev_driver, I think vfio_driver would be confusing)

-- 
Thanks,
Anatoly

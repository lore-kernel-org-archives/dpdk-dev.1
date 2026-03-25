Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55E6103A9BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:10:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 942F8402CE;
	Wed, 25 Mar 2026 15:10:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4D9494028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 15:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774447805; x=1805983805;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HERG18v+EJsOqPUue0gF/30hqoRiZJ3knY401nU33V0=;
 b=cY4Qs5Gq86uTeNDCAJbjf+G+T2gMuhx03uRA5kJofdBJIEygXHn3/X7n
 x9Dsy3FoEY2rQ1aGa98PRY8pvponTxVuE/5R8T/Z3m1pFDyMLMqKbbIws
 KbB1RUZ7EfCUN46yX7+ATmLuU4PRFbiDbUMLlNmceoaT9BSDqeTTpqsMT
 ZbDp3pAYn4HvIw7H6+QcqpafTJaarwKUrgzGIthNWMmbTAsaMNEAgslHB
 eB5/F3Ny4l/3hrwzwl6U28OTc1kuLopUtQkcysEZSKMiVkNGuf+r5dMXu
 tqws0oHh4d+ozdTaa6PZCoy3fro3Id1taH7xmrILLvkDrOXAm2XGNlUfj Q==;
X-CSE-ConnectionGUID: wzBFCBzHQ1KcWCSJRO8YXg==
X-CSE-MsgGUID: TylfwcxPSl6ndzZ6wsTs1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86564505"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="86564505"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 07:09:57 -0700
X-CSE-ConnectionGUID: G/Mkj1HbRSewAg+n4MQvUg==
X-CSE-MsgGUID: QbEASBBjQJ6inMqhNhyIcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="247726440"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 07:09:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 07:09:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 07:09:56 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 07:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP+J+hqBidDTcxGg4Knf2LS/GdxTkW9378/omAmNXS4xoC9y8gefTxNXSLcctW8Osy8am94gTPIFA/zfdQPCkFPYLMXZmLwnO3ryC7yvq2JTSL6sC6Vp8W2QUOHTCZIsdBWMdq1HcGC7zfJgbQZJdDTLCYMM9m3C3bXWzv0GMkFfqXpBfQgqNwg0H2cK/VR4A06GjQH6UbkcYmOgmxfj+cuViwVzEomb5dmtvBl+MgOtkz7WHMvyEfnKfutyMdrXSvLzQHYgg9Zm9aCA4bHZfG18iRQh2auNHqOimaYc+X95O7SSKJTrL0LDP+qiVOinBfgFb3yA8mABw/Q3wdnPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbdAYDxgM2/Fh3+2WayhmANAe0w2fi4OLLTRvwZ7h9Q=;
 b=A8vkzAqq2Hai47Xe8zrc+9B+5uic89t8ZTCeAfZxWVzUHpYwDntLbvDPsVTJmkB9KLK9aKm7crHaDM2NLpYuy+70Gz+nvVdM2pR5lzd2s1tqyhQGh8zNA1opbnwDR+g0TNI3IghW8pByhi8ifWbW/gIlJf70fYnT2kd3Cb54GiXKwLMCPkZemy16TfBeI6j9DAYK6s5dlv/zetqtqwDwz866XDHiGyPEYCt5+KHCUSWCULXh5Doar2PV9kQhCijMxH+59nkWTBeHmqUKrk2yohPolE6uQ0x1+YHVHn7aC7ga4gNZM/GS+UWdUkGLgJIKCl+ujfTIHFkBxu0/2Hw5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:09:48 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 14:09:48 +0000
Message-ID: <688998df-fdeb-4748-8821-6cc0ed49ffd0@intel.com>
Date: Wed, 25 Mar 2026 14:09:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] fib: add multi-VRF support
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "rjarry@redhat.com" <rjarry@redhat.com>, "nsaxena16@gmail.com"
 <nsaxena16@gmail.com>, "mb@smartsharesystems.com" <mb@smartsharesystems.com>, 
 "adwivedi@marvell.com" <adwivedi@marvell.com>, "jerinjacobk@gmail.com"
 <jerinjacobk@gmail.com>, Maxime Leroy <maxime@leroys.fr>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322154215.3686528-2-vladimir.medvedkin@intel.com>
 <a97747eac5c242359b959e24f284bf5b@huawei.com>
 <5ef5dc7b-0048-4e1e-be1c-d94b5b8f3caf@intel.com>
 <8127950263884375b935be30eb39da9b@huawei.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <8127950263884375b935be30eb39da9b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::23) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SN7PR11MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5f5041-800b-4ccf-2860-08de8a782c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: NE/RhFqUYrIwpr2+EkIICdsjiadfGuGCMFQhyr3AHdyCAsRUb5TJzV6pRgEoAt1ZbmJRuvLQkrxCuiX14pYPp9fH0fEPkxncRGCEDCEnHaahM35tgoE77Xu1kXTN2kwQMkYOO+U2WA/LNHIdoVkhXr9768HLcPwn/8YgnHcX52cnhGatNIi6fBHYW4oE8Mf9qCMoO9Eb8Jwl7XgF6Pyhsz8PWURPb7FmaRF2Xoi7oSISsGY3f3NdJ/yNC3dg+tYgA1TJNyiHM8zW90qoH0+BpC4cVtASIAZ9YFEsRzb4iueM+P5bVrrgBQZUwFnHkYlJ8ncz/4xtNi1cRYwaQvKLiGe+iBcTbSy3BiRO8vfnmllOchsuOb35RN/ZmV0tIo2sBprbAmlnILijk4L3Osb3aoCIkgTX2/pYCZO1QkfIvWHJhJdWgsUiqsXzBtXO38n28rbo9sxpMGDRJYMKGAoHBkXO6iRFsUfPD7C+VANCc+0xlB/Gx7+JgmPRoFq+02lERxg1FkxjzIc/o0nsyYC8/NJz5m1++XwwUL9ne2szz53Gudb9FGS5unS9lHbUSDfrHUoyQ2KRlyPnVAOBo7+4QTRkaNLXuPe6BzYdOj9UVSjBhM9LoiivV0mKHr5cuQD8fTQi0pvX+lgZZET5U33grdzerFL6nOS7/9IdZTxXpgIINOPzxxI/ySZmEcytLySfksULI1KGIfMdkQpcI0bjUCQUoC7/EeOSLCCq1sFGeTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm9GSG5wajhhV1ZkdUxYaStKZXdXT3FqWTN4VVpuTjMvbjE3OFhmMWhsbHFM?=
 =?utf-8?B?aDFMU0cxOXphbjZ4Y09rb05NMFlXbG5QVTFyek51WFFUNWl5OVM1R3grcHQy?=
 =?utf-8?B?QzFSUXhBUzFWR2xaelRWdDVnUk9LREErUGVzZmhhZUV3V1drME1BcWs5cUVr?=
 =?utf-8?B?RE5zdmVpNnBxb0JzMkpDVDJxR2h0VU8reVMyL1JFVFdkaGpDQzMvTytFeWVB?=
 =?utf-8?B?NnBzRHJyRis1bHpmMGtWWm4wTk9sOUxlTGFyS3FtdGM4Z0xMdmRrdXYvWWpQ?=
 =?utf-8?B?ZTNjWkJzQkVDVVJKcjNKeUlHN0hiQlNaTWlaTjdkOEppclBrMno2aG5wc2Jk?=
 =?utf-8?B?bmttTG9Idk1OaG9BbmQxQ1U5MU56M2t0WjlpWDZSWGp6YzllQzhjaWR0dENr?=
 =?utf-8?B?cjNhMDdRQ2Q3SXdiUWthbjI1dFYxQlhaVzZsMjFrWTdzaDV3bmJkVFFVTWlr?=
 =?utf-8?B?RlUwdE54eUFQeUdnOU8zMHhydGhBaHNHMDhlVWx3TXdhbHJTa094U09udGlO?=
 =?utf-8?B?dndqSmM1Zzd5RXRIc0hxb25FaURhZksrVTRZZXNVVDE2SXAyOHBHM2ZiL0xZ?=
 =?utf-8?B?czgwN1FhanlrMzhTNDR1cVpRTnV4ODBMdm1UdG9kQ3VJREsyVFdyRVowL3Q3?=
 =?utf-8?B?czh6Q1JPaFBtZ2pWNnN0aHFLUmJvNDZQTkJXNFgzVFFVSDl2bGNJSmYvTmlk?=
 =?utf-8?B?ckdyVE03M1MvQTg2MkJ2cUVhdys4cDY0K2RubXlRWHRPT3l0Vi9nY29YaFpP?=
 =?utf-8?B?REVTYzFGQjdHdEh6V2NDN3dPdmVTeWkrTHhKNGFaQnBlTEx1TDYranBZTEg3?=
 =?utf-8?B?SVB1cFdiVFd5ZVdReXBxSVIydlluOHBsK293SDliT3h5RlBXTWlmZGpydGJy?=
 =?utf-8?B?elJjWVJ0bDI0QWJlSHIvZGc0eXlJMjF1MkhoU281a2ZjVHJoRnhIb0x0OUVv?=
 =?utf-8?B?clNhVUM3RUhkZ0VKSmtTZlZCcE1lMU02OEdIRXF6Y3RnbmxlK25BMEtQajZS?=
 =?utf-8?B?aW5LdkxPam00WHJWVy8zQUx0UTB1REFOc2NSK2FZK0R4UFhNaXVpSW15MUVZ?=
 =?utf-8?B?OVM3SzdpL3E3dHYwbDlqd0tnWEgwY0lKYkZzTDJockxXandKaEFlNy9MazZG?=
 =?utf-8?B?amFDd3AzN215V2owV1ZnMncvano5QzE5OWJKcmliZnBkYXEzMlB4b2p6VGxL?=
 =?utf-8?B?dFFPN2hldEV4bVpob0hhNVEzQjgxV1BaMzdKencvVnU4SXlJNGlxS0hTT3lS?=
 =?utf-8?B?SFp2VnZ5RG93T0pQd09VZlErdnFETnI0eWwvTWFkb1JGNCtRSHdoWnBYZmFk?=
 =?utf-8?B?dERxRUJyb3lId2FiMDZucFNuUmRMcFZuandXZVM2VkpzdThaZEs4QmtyRmdy?=
 =?utf-8?B?UTZXb1FYR1JEK1pQTjlUTXBQVHd2L2FmWlJYOEJnclV4aXdXaTRtdFJ4eU9G?=
 =?utf-8?B?dXhHUWtBMkZtR0dIRU4wTzlvMzZpd3RNVFQwaDdoZVhYeWI1eXpWRzc4T2xH?=
 =?utf-8?B?UzQ5cW5jV3VnLzRheXdSZkZNTWd3ODdHdVljYmkrZ1lHN21KYzRxWmxnYlA4?=
 =?utf-8?B?NWxJcEpoWGFNTGc4ZWl4cytDaUpBZEp6cHJRUHAvMldMN0NxMXRRL2ZWSWRl?=
 =?utf-8?B?aDlxSDNIZ3ZVK1JDNUZQTnM1TFNpb1o3aXFWNnhGN1NZRlIyWFVOMTZYRWhR?=
 =?utf-8?B?bElIUHdDRno4bHdUN2lxNitTeE9POU13bWNPYllHRWlQMWpMajc0MjlvMmtx?=
 =?utf-8?B?cEtjeXZwOGhMYzhvV3lVMXNtaUU1Si80aXZoejZ2cTZNb2pJOVBtMmV1Zk9y?=
 =?utf-8?B?ajMzRjlyRy9aVlZGOGxPd1BBZUtLZ0k3Zmw1UzRwVjdKSUlFN3Zvdm9Hc0Qz?=
 =?utf-8?B?MlVtaHFsam5HYkpWeHN4Ui9vd05RSS9aSkhRN2hUaWc4a3dCMjJ3N3RpUGI4?=
 =?utf-8?B?aGlsTXpzN2VYQnlDVzFMaEc4amZTUmM0eTVwTmRINXNHY3BIT2JPNSs2MWY1?=
 =?utf-8?B?cUtIaVNlcGM1dFVyZnlWNUZDTFJtRjNNQkRCSWNCdUVjOWlOdlNibXdnc1JD?=
 =?utf-8?B?c3lBTU9RUzZLT0E5QUNVVno1RDgvZTBhZTB4NUJBQncwYnp3R2xiczZUb3R0?=
 =?utf-8?B?Z01mVGpwNlhVcStPV1VFbDh4WTd3cWZMZ3hGR01lZ20rRnc1dkJoMWFkeTJH?=
 =?utf-8?B?WERsTVFtYmEyOVhLZXdhakI3VWVvSEFHQ0lDalNnbjhMUEQxbUhvdlYzY295?=
 =?utf-8?B?K2prRzVCZDJJRlNIVno4Wkh0ZVVBWGlFS1h1OEQ3SDR3cVUxR2Z1Z2xOMHNp?=
 =?utf-8?B?N0Z6b3dCb01wYnBLcHNPRFFZd1lDbmtIVDI0VHl2RkVTbUNBZHp5SnF2YUJC?=
 =?utf-8?Q?WkTv5RKsiGBd4cOM=3D?=
X-Exchange-RoutingPolicyChecked: UpUokX6PtLetnxYohm60wIbytCTmjzTAL7LxXu6bqV8Wu7ncgE94CSV2/7Ey9nirqLpr7zK7pRihNsi86HXi1QIdTAQzoCu4Rey69rfUrarONgxswIokg5rvD9Ii/TfApZXkM358VetUaNkZuPlrWt00PZvHYbsFFU5wTFee/cPMOqZQlvI7aDn+h62zg5iDgwIWtUbSusOXGnjzlvOoY4Oc9JzHBJbnn9S90Yw7LlM414O8hWsgADULPUcdS9oWw8Pux9Y92O/GlRFxbtK1QLque1kFdHt+rHOkWegBWJ0/WdPfnUqDyqeeX5Gdc9BnL30JPwpbneFiz3DfEtAGQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5f5041-800b-4ccf-2860-08de8a782c5d
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:09:48.0619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0goZBBkdOGpxQxCicwmftfdtWwUufh2D1rM1O7lhfKatHYon7q+z7oPIjxMAG1fyXFpLI3TxIvIa8qYraBz56t/+j/iOg2sJyqJW1cqlXJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
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


On 3/23/2026 10:22 PM, Konstantin Ananyev wrote:
>>>> Add VRF (Virtual Routing and Forwarding) support to the IPv4
>>>> FIB library, allowing multiple independent routing tables
>>>> within a single FIB instance.
>>>>
>>>> Introduce max_vrfs and vrf_default_nh fields in rte_fib_conf
>>>> to configure the number of VRFs and per-VRF default nexthops.
>>> Thanks Vladimir, allowing multiple VRFs per same LPM table will
>>> definitely be a useful thing to have.
>>> Though, I have the same concern as Maxime:
>>> memory requirements are just overwhelming.
>>> Stupid q - why just not to store a pointer to a vector of next-hops
>>> within the table entry?
>> Am I understand correctly, a vector with max_number_of_vrfs entries and
>> use vrf id to address a nexthop?
> Yes.

Here I can see 2 problems:

1. tbl entries must be the size of a pointer, so no way to use smaller sizes

2. those vectors will be sparsely populated and, depending on the 
runtime configuration, may consume a lot of memory too (as Robin 
mentioned they may have 1024 VRFs)

>
>> Yes, this may work.
>> But, if we are going to do an extra memory access, I'd better to
>> maintain an internal hash table with 5 byte keys {24_bits_from_LPM,
>> 16_bits_vrf_id} to retrieve a nexthop.
> Hmm... and what to do with entries in tbl8, I mean what will be the key for them?
> Or you don't plan to put entries from tbl8 to that hash table?

The idea is to have a single LPM struct with a join superset of all 
prefixes existing in all VRFs. Each prefix in this LPM struct has its 
own unique "nexthop", which is not the final next hop, but an 
intermediate metadata defining this unique prefix. Then, the following 
search is performed with the key containing this intermediate metadata + 
vrf_id in some exact match database like hash table. This approach is 
the most memory friendly, since there is only one LPM data struct (which 
scales well with number of prefixes it has) with intermediate entries 
only 4b long.
On the other hand it requires an extra search, so lookup will be slower. 
Also, some current LPM optimizations, like tbl8 collapsing if all tbl8 
entries have a similar value, will be gone.


>
>>> And we can provide to the user with ability to specify custom
>>> alloc/free function for these vectors.
>>> That would help to avoid allocating huge chunks of memory at startup.
>>> I understand that it will be one extra memory dereference,
>>> but probably it will be not that critical in terms of performance .
>>> Again for bulk function  we might be able to pipeline lookups and
>>> de-references and hide that extra load latency.
>>>
>>>> Add four new experimental APIs:
>>>> - rte_fib_vrf_add() and rte_fib_vrf_delete() to manage routes
>>>>     per VRF
>>>> - rte_fib_vrf_lookup_bulk() for multi-VRF bulk lookups
>>>> - rte_fib_vrf_get_rib() to retrieve a per-VRF RIB handle
>>>>
>>>> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>>>> ---
>>>>    lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>>>>    lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>>>>    lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>>>>    lib/fib/dir24_8_avx512.h |  80 +++++++-
>>>>    lib/fib/rte_fib.c        | 158 ++++++++++++---
>>>>    lib/fib/rte_fib.h        |  94 ++++++++-
>>>>    6 files changed, 988 insertions(+), 260 deletions(-)
>>>>
>> <snip>
>>
>> --
>> Regards,
>> Vladimir
>>
-- 
Regards,
Vladimir


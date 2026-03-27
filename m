Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC07010F2865
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 18:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD0240E49;
	Fri, 27 Mar 2026 19:32:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id DC059402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 19:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774636378; x=1806172378;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7Umvfqs8U+8n3urXIFD3Ys2Ak0VNlZj2ZrcsUEc1AQs=;
 b=jLCYRSnuIV2RGhkWazCt4Z2Ju1J3vLAtCyOtV+XN7C+6jDG8bv/Dzu8A
 Yhpzhx9b8C4U62+7dmxiKhHX1M1aQNxkihOixKySHgUTNsy8ignrJNZCR
 MuDF0vljFfxWW52gqha2Dr3RFtBGZSFJjwg/dUh3sb6KU5bYog3VP4I9J
 SV5bWIh4Z2Whl2fj5dgo0/VvkQhfFNnrHFIGUWVcll8PKPpUCTO4DY8u/
 LJhdYWbC2LcP39MSNqCnXy52bEv9v1UAV6yZ7nKuXE+kzorARrAwJBpSr
 q0TiOidpJQxMrSgo2uWeg/atEO0aFPIN0j62tPzS4DmVt0fjFawnguJtM g==;
X-CSE-ConnectionGUID: 5+81l/BJSqeHnjK5Jk0BKA==
X-CSE-MsgGUID: SjmCjmD5QEGEwP8l/LGxaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86022121"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="86022121"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 11:32:54 -0700
X-CSE-ConnectionGUID: 2yuGo2mlRL68FkcKzJFGiw==
X-CSE-MsgGUID: sBuSkME0T1CbXgIsACX+uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="225304147"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 11:32:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 11:32:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 11:32:52 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 11:32:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvR1jli398JRcKSg/WR1YHa9A0pvP6hDjvy6Q2cW90aVVb1OWt5NUPXLBkfsa/C4JwrzRQM/Q0PuM1bzwy2HyeyfJm68gvD7n3+Woggeu2G+et6w28PVDNc7Vxukm5KGrDK3J8/VJMo9umy80OEgHXv9DyF75H2MG445O4Y9UmJwAMojj5xhLRNztQ3zmBKJuXy5fJrv9iHjtpQiRi6ZRdRCtR4I6CZjwz1Yz0dNbuNu6HKeb2Sn1i/H6NvlvypLJ6zTLVS4pSop64+3d2ZoW8qXf23NdqEFw1MrFz+eAztu87ljMmrH1YsaJrWjJhe+9/Iy9r+G8eoGNsltN4Jh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37yNGijKV0+ryuXBVQ3NOdv9FmxWVAB+CnwLsiLKO00=;
 b=QJPCAgBoN0p6HskajV2J+9KUC/He2qSn6xOFm+UtylgJqk4zsxlaw/RHgX+6mEWFtHcZkgpmMHAjaEc5mWzMxrNpRUDdaVdtb89Vl1moV27Xda2EzYMsJfcWFEWrPBLyOGisGBdCyqMQL6LtGBCIay9+WybvkKzgFT3D3a3Tlv7kXENtvZ3aTImt6TvsKi9YYo8ScFhpVoQu2AQxBMbLZ3U2x9SCbwIMmnm8I+H9MwoXK8OzRtzaYwuRRPODS8/CpkAMfdVOY3kzJe+nICxwukqDJF4cGIshAi5gvRSDnJsmr2R2jmN5UbcKgpZRPLw/inR2LbrNVLVQU8m554hQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Fri, 27 Mar
 2026 18:32:44 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 18:32:44 +0000
Message-ID: <165a7482-5fcb-44bb-befb-a0bde1cb4ec1@intel.com>
Date: Fri, 27 Mar 2026 18:32:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] fib: add multi-VRF support
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "rjarry@redhat.com" <rjarry@redhat.com>, "nsaxena16@gmail.com"
 <nsaxena16@gmail.com>, "mb@smartsharesystems.com" <mb@smartsharesystems.com>, 
 "adwivedi@marvell.com" <adwivedi@marvell.com>, "jerinjacobk@gmail.com"
 <jerinjacobk@gmail.com>, Maxime Leroy <maxime@leroys.fr>, Vladimir Medvedkin
 <medvedkinv@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322154215.3686528-2-vladimir.medvedkin@intel.com>
 <a97747eac5c242359b959e24f284bf5b@huawei.com>
 <5ef5dc7b-0048-4e1e-be1c-d94b5b8f3caf@intel.com>
 <8127950263884375b935be30eb39da9b@huawei.com>
 <688998df-fdeb-4748-8821-6cc0ed49ffd0@intel.com>
 <11250ee33c514310aa034c0f7ae0d8e5@huawei.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <11250ee33c514310aa034c0f7ae0d8e5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0197.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::11) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|BL3PR11MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cc44f0-5700-47d7-e34b-08de8c2f3c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: tDTKW+1Z/ny4prb++ds5pzV3+Oaxu6l2JBzBQlUVHWUu3/FvcVZ+wDsVItTZ67bQOAP/+Q6CAk1OxcA2sqicgja8C6gxGboWeKGU3tRUXZOvVBqvTwFENI1TGFWNvKnT+i8sUVIbXwSliJQpIemDejCd9SrFXhzGyWh4arsyt5/fOsNUFOIcPAx8kToU3n5COhMr/pM0CplGZ0uZoQ9VlumdrrNgDzGwjGZMubbatTra/UO375x1WahQhPqinK5oM8qekfG/irVuWDJnchbYuIBS0WXEEaq11Gd+bQhI3soj5bE7/GxFBZEPdzlfxLPGx5aCWZZ6k05MLf8iUDOgKasultBtdNn0F/DWMRfLCNEb5PBnVmKq7KZD4Oo2y70OkN1BYJ+GsLYflauQ0zG2vM+Mc98Bc6CxhfkuUJzx/IlBHQ4dIPJlzcCYWaq8cGrhGUj4brYha9TDsXUfI7fE4zVHtFFDNnHLp2Hl0SeKreCXBPAVpiyBQ2AuD5hn03mfVUgp7OCXi60i4/hb7WISwkPNLqYvjLc1wpmM+LuHkGi4TLwjN1+n9JzDickNsUqZ/Ft1fUM1utm2JXpPgNN8qUlCCe2EKv4r6lkMox1obcoV2g5m3L53CQX4GbN8vHcgx9Z1QdFWwjN+vG27BzbtcjJnDxEc7AyxSE6Mc6GYi5ZeoLuaCfW/zUzDb0rTe8QFjoYgnoiy483YMhuJjNCAWNsHcuP5k78TrTkQEtzPh2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXpYM0ZrZksxOVlDdFMwWTM1NUdSUGx2QVk1R0pTcFh2WjVTcUNmNktEOWRC?=
 =?utf-8?B?Nm85MWdweXNyeTdVVWhwREhuanRnZEgzSGpRYXlSdkpWeFhUVExqbFhXcnpY?=
 =?utf-8?B?S052SkJ0VFQrWUQ4OExJNzgweVNxY1dSRmJjaDMxMG9zRldMNFdjZXJZektR?=
 =?utf-8?B?cGlxTmd6T3hBQVFoVDdpSTRGbUJTalVmcnI3WFdSdUU2enM0VElCU1BUYklF?=
 =?utf-8?B?alhhREtuZUZJV3dtSU96ZmtLcDV6UXRoQmQ4WHVCU2dESzZKeUhXZXV5ZjhG?=
 =?utf-8?B?am0rTDAySDgxLzBwYkh3amc4RklXSWdSdFdCbFNmdldqZEFjOERUUEViZENO?=
 =?utf-8?B?RHA2SDNyMmcvdkhDbi9yZHRsUkJDOE44c3BJNEZVOW4yajhFcGQwUnEwNXV6?=
 =?utf-8?B?enFYZGt6ZllIT3VSTXN6Y2RiYU1uQmpkOHdzb0h1WHIvMHRLTndFYmVhRCtF?=
 =?utf-8?B?Y3MyTi8wMXIvQ2RGM253ZzFZdHVXd2tBVDFIV2JSdWxSNTVxN0szUjlscDF1?=
 =?utf-8?B?MnVjMDIxL0hnZ3ZYbFFpcUFwKzc5dXBGa3JyWmdCdE5rTGtGS0Z2THRlTHlD?=
 =?utf-8?B?K25Ldi82S0Z1Mmw3MUZhZmt5OGdmemF3a0RmZHFBbjBONU1Fc25GT3JZcXRx?=
 =?utf-8?B?Q0VsSnYrK0prMmYwbDNKeTdJL25GTXdLZE92QVJrQVk1ZkljNzNlK3gyMEJm?=
 =?utf-8?B?dVN6dHNTKy9rbDJDWUJHUzQ3RHJpU2swV29DUlBwNFFndmpnZTJVWUFub2FU?=
 =?utf-8?B?MXdmd2ZkMnpJeWg1QmUyNlhTYm9NdFFIVkczeHA4Z21ubWZJazBWR1cwc2ha?=
 =?utf-8?B?TTdEdXRmYnBRSEp5bWtGeThnWVp2em1vRVFCejQzVnZDVTZORGlUcDJhRFRs?=
 =?utf-8?B?R0tvTW0xZk4wK3dkeVJtdWl3K3FIenVqaDE1ZGQyS09STXdBZjdpTERuZURw?=
 =?utf-8?B?WENLeGVUeXYwaUFxMDlvdnd4Q1pFNkRpR3BOZW9KNmhFSDFvbXdlWC94bk5O?=
 =?utf-8?B?bUZJZFYvY0dPaGgvWnpBT1FxSWx1MUhKK1NzcDRKYW5ocVd1aDl2aXRvZXhH?=
 =?utf-8?B?QmFQdUNzeENaRUttY2RRbTRPVm43UzBSNUZvWW4zWXVzcXVnU3BRSXdrQ1Vo?=
 =?utf-8?B?dEtuSWxCWm9HMkczNUxreXV3M3RsdlYyUXJGeWRiV3pxKzFEMklZeURlUExS?=
 =?utf-8?B?eE81Z01raU8zY0Rnc01SUkZZd1FpcXh3SWVpZ3R1bHFvWXI0bTNwSU5aOXNa?=
 =?utf-8?B?aDU2cnE0eG5vYVU3RUFoM2RZOW9iTU9yOVFKL0RncnNvRTk4K0Vocy82S1dZ?=
 =?utf-8?B?TEVEV0xvUDhUWU1oY1ZaREdsKy9xT0JJOWxJMHRpMVQzR24waVA0cWhqd0lw?=
 =?utf-8?B?WHpvMWFweDRDcGZvbWRiSFVlQkxrYnp2bjMwaFI0UFlhTGNtbXdjSXpsaTdN?=
 =?utf-8?B?bHBkODVTZzkrbkVpNEYwMGN1RUdrdzY3WlpCWUVxZU41bVVKbWRCMS90RHFm?=
 =?utf-8?B?NkcvL1YzRWdvOVFYZk02SmpKRkpCbTd5TEExUmx0ckNRaFlvUHFDbklMWC9a?=
 =?utf-8?B?bi81Z1hCMUpTQTlpUWJqSkJsamVIRTFheDRhYzBrTlNzUXh2WXltODVBbkFG?=
 =?utf-8?B?Mm0rTmtybElmcVlaZWhuNmo4bTM3SmtxdVZuS2ZoMGRTZzgvVS93d1k2Q1Ru?=
 =?utf-8?B?ZVRwMWhMOVdla1ZGa0Y2TUJVOWhNR0ZsUC9RSjAyR3VmVlA3cnR5Y3F0aml2?=
 =?utf-8?B?S1l0Zi9tbjd2ZkYyTmpPdWhWUXJOTWxnZFltTmFLMFpuaHh6VkV2R1hwdFNS?=
 =?utf-8?B?RnlaSCtSY1JURzI2QnVNdDRIbWZIRjhoMHZBUGowaGI2RERUdU9kVEtXaFZC?=
 =?utf-8?B?TDd3VHNPM2YvR2dPb2NPcVllUjZ1WXovOFQxSlI5amdLVExMTm42clFRSVhy?=
 =?utf-8?B?UG95TmYwR01CY1pzZXVzeE5OaEFxTGNRMVFDd1FYTzRPUVVCK1hpY0ZBSDlT?=
 =?utf-8?B?Uzg5UzVZdjNZelJOZW4ramMzZEdoa0FlUHAwWU52RmFiSUFmVHVNRkx6WVEx?=
 =?utf-8?B?bWU2RGxOWUV2Y05LRHRHajdxRVVXZ1BZRzU5L2NlbENrcUR6ZklpVDFqVmpK?=
 =?utf-8?B?YjRCd2p3YVFjbjB2RzVjRDh2U0hYbEp2WC8yenUrQmgzSjhQZDhkbjZWQ3ho?=
 =?utf-8?B?eVZnbi9tT1VRRFNmVUxXckc2aCtXalVKdXRnTzRhNEtIRmlrUnV6dlBFNVhI?=
 =?utf-8?B?TnAxTm40dTVjck5ESW5ZUVNXQ2YydGIvdWhjamtra3VDaEdwMkVybHRlTkQ2?=
 =?utf-8?B?SE5PQW5xbHFjWXc3ZlE3ak0xYjJiT1FjdVRmbjJicE9PUFFFNE5yZndWSk9r?=
 =?utf-8?Q?PJsXBjWbbhhrr5KQ=3D?=
X-Exchange-RoutingPolicyChecked: uM7HCw4fzjpYRVhMAmJeu9x0GBdSDnYtTtCwp1+CfzNKTeXrpR+lY0RYd9P2JsAOaS+bWD2Laeh4+ZWHEiMjPHVrHe9Dn37bIQHaDH3km21XiyBy4YwG2gIlKrlyCgHnwbjJE3rPX7z5ZZmFfgB4s+WGpLEhsE5Pvq7SG1u1bMCVInqbcWXVSwSmJOgz3lVQp3DxBD6JpAE0SOl5sKlq7aHwFU3DwswVG5gzd+Urvol64CAQuG8HX10L3LnBfQZuKTut3OIGRlL28u2mpWqC7/MeM8bYnVcb4isFfjy66miAjMykF54nkCOgYf5C2sIH4TCxKpcPA4YLU8bgnGJBjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cc44f0-5700-47d7-e34b-08de8c2f3c9b
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:32:44.2702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7X+Cxb8uKs6KsY2C+SClnrsKugZ56GPUyMEFydkw0ObMPpBTLUjt4u3i/ppEitJAJv/b89FMgSR1eKUe14+MRG3Lo8X8xKSMro8ALlSk0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
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


On 3/26/2026 10:13 AM, Konstantin Ananyev wrote:
>
>>>>>> Add VRF (Virtual Routing and Forwarding) support to the IPv4
>>>>>> FIB library, allowing multiple independent routing tables
>>>>>> within a single FIB instance.
>>>>>>
>>>>>> Introduce max_vrfs and vrf_default_nh fields in rte_fib_conf
>>>>>> to configure the number of VRFs and per-VRF default nexthops.
>>>>> Thanks Vladimir, allowing multiple VRFs per same LPM table will
>>>>> definitely be a useful thing to have.
>>>>> Though, I have the same concern as Maxime:
>>>>> memory requirements are just overwhelming.
>>>>> Stupid q - why just not to store a pointer to a vector of next-hops
>>>>> within the table entry?
>>>> Am I understand correctly, a vector with max_number_of_vrfs entries and
>>>> use vrf id to address a nexthop?
>>> Yes.
>> Here I can see 2 problems:
>>
>> 1. tbl entries must be the size of a pointer, so no way to use smaller sizes
> Yes, but as we are talking about storing nexthops for multiple VRFs anyway,
> I don't think it is a big deal.
>
>> 2. those vectors will be sparsely populated and, depending on the
>> runtime configuration, may consume a lot of memory too (as Robin
>> mentioned they may have 1024 VRFs)
> Yeas, each VRF vector can become really sparse and we waste a lot of memory.
> If that's an issue, we probably can think about something smarter
> then simple flat array indexed by vrf-id: something like 2-level B-tree or so.
> The main positives that I see in that approach:
> - low extra overhead at lookup  - one/two extra pointer de-refernces.
I'm afraidtheoverheadwillbe 
comparativelylargejustbecausethecurrentimplementationis fastandmost 
likely hit with a single memory access. However, for a low number of 
VRFs, B-tree may be a good solution
> - it allows CP to allocate/free space for each such vecto separately,
>    so we don't need to pre-allocate memory for max possible entries at startup.
>
>>>> Yes, this may work.
>>>> But, if we are going to do an extra memory access, I'd better to
>>>> maintain an internal hash table with 5 byte keys {24_bits_from_LPM,
>>>> 16_bits_vrf_id} to retrieve a nexthop.
>>> Hmm... and what to do with entries in tbl8, I mean what will be the key for
>> them?
>>> Or you don't plan to put entries from tbl8 to that hash table?
>> The idea is to have a single LPM struct with a join superset of all
>> prefixes existing in all VRFs. Each prefix in this LPM struct has its
>> own unique "nexthop", which is not the final next hop, but an
>> intermediate metadata defining this unique prefix. Then, the following
>> search is performed with the key containing this intermediate metadata +
>> vrf_id in some exact match database like hash table. This approach is
>> the most memory friendly, since there is only one LPM data struct (which
>> scales well with number of prefixes it has) with intermediate entries
>> only 4b long.
>> On the other hand it requires an extra search, so lookup will be slower.
>> Also, some current LPM optimizations, like tbl8 collapsing if all tbl8
>> entries have a similar value, will be gone.
> Yes, and yes :)
> Yes it would help to save memory, and yes lookup will most likely be slower.
> The other thing that I consider as a possible drawback here - with current rte_hash
> implementation we still need to allocate space for all possible max entries at startup.
I don't think this is a big problem, since the size of this memory will 
be reasonable and will not grow linearly with the number of VRFs. So I 
agree it is an acceptable trade-off
> But that's not new in DPDK, and for most cases it is considered as acceptable trade-off.
> Overall, it seems like a possible approach to me, I suppose the main question is:
> what will be the price of that extra hash-lookup here.
And this is the key problem. I don't think rte_hash is well suitable 
here, at best we need some kind of a perfect hash. I have a few ideas on 
this, stay tuned :)
>   
> Again there is a bulk version of hash lookup and in theory it might be it can be
> improved further (avx512 version on x86?).
>
>>>>> And we can provide to the user with ability to specify custom
>>>>> alloc/free function for these vectors.
>>>>> That would help to avoid allocating huge chunks of memory at startup.
>>>>> I understand that it will be one extra memory dereference,
>>>>> but probably it will be not that critical in terms of performance .
>>>>> Again for bulk function  we might be able to pipeline lookups and
>>>>> de-references and hide that extra load latency.
>>>>>
>>>>>> Add four new experimental APIs:
>>>>>> - rte_fib_vrf_add() and rte_fib_vrf_delete() to manage routes
>>>>>>      per VRF
>>>>>> - rte_fib_vrf_lookup_bulk() for multi-VRF bulk lookups
>>>>>> - rte_fib_vrf_get_rib() to retrieve a per-VRF RIB handle
>>>>>>
>>>>>> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>>>>>> ---
>>>>>>     lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>>>>>>     lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>>>>>>     lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>>>>>>     lib/fib/dir24_8_avx512.h |  80 +++++++-
>>>>>>     lib/fib/rte_fib.c        | 158 ++++++++++++---
>>>>>>     lib/fib/rte_fib.h        |  94 ++++++++-
>>>>>>     6 files changed, 988 insertions(+), 260 deletions(-)
>>>>>>
>>>> <snip>
>>>>
>>>> --
>>>> Regards,
>>>> Vladimir
>>>>
>> --
>> Regards,
>> Vladimir
>>
-- 
Regards,
Vladimir


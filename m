Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44969F483E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B1BE402D6;
	Mon, 23 Mar 2026 20:06:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 66A9240268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:06:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774292805; x=1805828805;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=O+wHl2iH7FKunDaZ20knp75jM6L7GRFseYNacILA1zM=;
 b=cc41WYOdpezzoln98cQ6s4hroJ5Zf/SgUQim2sRrLFuQD6/u0fZ03L88
 pzje5+GwS533NY5ebqVnTLP6PqGUOCD/GtJfCjF6P04V3CxBwAQpx48y2
 i8V0BEKSSfRUQ/jRnyzgmY+SPeceomqJTE5EbkwP79SLznolZMsfOchRU
 zgl8OrfKHx21oWNNflu8T0Fe+hVdV5w/P2FWqvMKAIUe0vJL8GP+vaIIx
 Hc6vdB36PD75CbPO8/j0oiJk1Q1ZltcoWtqNnsjpWy4kM3jHYJ3DPzrQH
 TxSJerEY5Nnslz976nNg2R5+9BRhN0R1c6YpAu/CfSz4jOZLt5L51Xq2n Q==;
X-CSE-ConnectionGUID: JjntB+8qQCmg45Gc6B7s9Q==
X-CSE-MsgGUID: ZOMhftzIR9++rAWwtLsm/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75011693"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75011693"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 12:06:42 -0700
X-CSE-ConnectionGUID: VvmolkQmQrmRpVopGFGRpg==
X-CSE-MsgGUID: ArvpCHD2QdSvnbynieuHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="228185346"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 12:06:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 12:06:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 12:06:40 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 12:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpyohyLqS+sPM++SJhrucRCmpIFNa5XcmIsrTNhn4fsjdOxQbbNwTVHP0jcLazuOSpf1rIwlRkOegJ9LNoz6B72SHU4iJxfEuHNtp7SrPuLK3K9C7T5GnuvNicxC9S985Qo8hGO2p6A+DufdAmGwUmQxsHz4Lq/UWK/pJlP+qnJK1M+m/BjF4HA3v+WzWKaAbeM4zdw29Y3W0Qo+vzwnEwMgUI2SbsPWbPW2JXewB2iEdwkVVpx3adPr6k71+sk+/tWEiVygXSu52TJaoG46hlYo2cknp2zhSBEZMCdFCGLGwI4t7D83HYgX4CJ1J76M9XK4uCA97oX8VWb9xhssjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crCU5EYkFE1ogykA6itmQlNczC59mGPjLzaPh8ZMFdg=;
 b=G5+p9sxkBKsOiAriImAE8jlZdKnsCTgydX+otk+2tKEwkTJ4HPdiQJa/AovJuBeNTpvQ6py0tTGdvkZ7/jNfmd6I0WBc95NohtPIB8NwhiIKaK/2ggVZLYUpDhpZBta6FFfTQoyywieBotcl59Z/muNVtMOdnDw5Fe66CXAvWTNxF5Gzz+R41bccIEy+nlf/0sdS8nHX8fUlFHDIWnccdopyGrgpL7ntnAly+y6OcedloS6BdoOv1U7USRnf0bjfIXVlrK18x3HT0UXjKBv8gn7UwVC0jVbyt2BNleEMxBrv5SfIiwbCklc2BjgE2dHfv4AHylAsyC1sv15FVecv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 19:06:38 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 19:06:38 +0000
Message-ID: <5ef5dc7b-0048-4e1e-be1c-d94b5b8f3caf@intel.com>
Date: Mon, 23 Mar 2026 19:06:35 +0000
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
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <a97747eac5c242359b959e24f284bf5b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::19) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2aae28-bc26-4089-c226-08de890f4f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: lzuCoSahJqyzumNbSux6MEydEWdCgG9SNQ5M/e2l8By4wPyh43ZH9YOo7LNXwH5Uus4/bT1HToh+i16Gtx7VGmf7KnsJcrZdt77+GfxjZ1b5LG9DuGlWx/LJarlHy21QzCO1qzdnzQeQfV1NMaRPax2f1rESW+FaM+p7c2C5y1rLyxOiXMTKnRlJ3SExNSmx5YSIp9eaomTWFPtJXXTvkcJTwLp2GQeisoVukv2eL9uNl0gi2Uv2MfQSGNeK38Ul8OKgN2AGr9FElrOHzCS5itr191G+fFrNmDGpzHAW+xpZvHw86l5qkeIWZCBk0YxRU1K+mGf9JouTQPVYEu9xuDkmNyrtQ6v8yTygrl364+zsbnW3hT4fN3BdP2PXQfW+vpTEZD4hDdlY9Bu5mMa3XNzvcAOY4BNEGOm5LaR8GqIdXoB/HKTleXOZCeiS2MTm+WkEQ/WCu+XjA+H6XiqsFONFY2thPcHWEMlfP2KOD2YEkhUVsy2EfXmK8R985wVxLLPXgqQ6BtOTH0or0nP0rmH1QPjwuosUTvT6W+Eo53m2rIPbClYoIZ0cbZmiuvjeoVMAyHdzXjS8osEMiZ+rD+5Tb0wX7GjPUoCgM8rpzAdoXZFpW4ln5LiHUMqwnXYZUkc7I8QKqIeIAEUkxTxhkVeyjle88d55XewXKkX5h4Svo1IDy7G/nhSvcjYeTNqtQv+ghopyoJNOPNfdv+woncYJ17DP1TnC5oskFCPWT3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzh0TlVROGduZmZ2a0gwY1A2bVlLNG9Mc0xwa3pSdDZVQlNIeGswSlN6UUxP?=
 =?utf-8?B?bzlNUnpuS3MybEN6ckVwQWI3aE0xdVpsQU1DWGd4VWUxbXlVUG52L0F4UUg1?=
 =?utf-8?B?Tmw2dzF6UUk1a0tnNzhyT1pqZkNNMFRtTTEzblVoSk1JcUlCaWtMcmxNckFO?=
 =?utf-8?B?RHdRZ0VTZm91MytVRU5IUmdyUHgxeUNnUVNVdmcrOW1hQXVvZW83czNFbHlh?=
 =?utf-8?B?TXo3YzlWcmt5REVXUEFQWEJIR0hlU0dwbzBXbndsOW9wRjdRUEFFdUdPVDRE?=
 =?utf-8?B?R3ZsMk4rS1hwYnVIcW54M20yNEJxM1hwNHRwKzBFbXhkWDJTdEYyMjk3MGZq?=
 =?utf-8?B?WkU2ci85Y3lxZ0lPenFrV0lZL3hHdUdqWFFhVFpKdlF4cVozbXQvYlMxQmhi?=
 =?utf-8?B?VlZCQmIzaktCWUFHbHUwM2lWVHRkMnZkM0NSdVNuQ3M5TGRwaHpBOUNlRjl3?=
 =?utf-8?B?K29HOHFndjF1dmtMVFA5MmdUQUtqdFA1bllYdjFwUlByZHN1V25lcTdsWUs4?=
 =?utf-8?B?bjN5anQrN05YeVNCV0JVQklJcDNONGRRakJDS29oWWVaY3BQV3hkT3JnUXN1?=
 =?utf-8?B?Wm1MMFpFVjdqemNYOFVEV2VJaWwrcE5UQkxiQ2hGdWJ1TDVNMFRHVTVFZHJG?=
 =?utf-8?B?eVZmNFZtZEFRWTdEUU5hbUc3U3d0a3NXTVhtQXlFelpnNThzUFhUbnJPUXRp?=
 =?utf-8?B?eGpWQkh4anBzYnMyZkdmMldwcng3VE1nRzV3YkhPWUVhRDJMVlAxVUJPSGdS?=
 =?utf-8?B?TEFXUkNXbXVSdnZlL2UySEtKL1pPTW5ORnU5MThhWTl0aDgxOVVHalVNWjBk?=
 =?utf-8?B?ZCtvVUpYN2xTZkVvT2Jyd082WHhnYk9SSUVyaUtDWUNoOUxHKzFpZmJQVWxV?=
 =?utf-8?B?SWVqZ1p1a2lXaFZ5Y2JuK2xScWpxRHU3OTZUZnJ3cXNkc1hDRzFrSzlYVW53?=
 =?utf-8?B?cUMrTXZMcUo2V0dDZ05RamhQbytqcytHaWU1UldGa1RKZkMzV3ZRbW5kS3N0?=
 =?utf-8?B?d3FqUnRPaXg5TGVBSENKRUhtNTg4aVpkdGR3MHJwSndiV3hlQjNPbTFzZ3JW?=
 =?utf-8?B?NHpQT2pVUTlvWTNqV3FDbmJ4S1l4aGowbktuQTNzQkJBdDBuMTVOK0t0OWFC?=
 =?utf-8?B?SGtTUGFuVGREcXBXdkhSM3J0WkJVT0htYnJaZnJxUlBvZklFRm1Kckl3V3p2?=
 =?utf-8?B?aG5xMkN6dmp0ZlB6MmVKSFNqb2pNek9PblRWdmZCc2pXK0lDYlh3N0Q1REpp?=
 =?utf-8?B?djUrd1J2NjN5OHh4TWV4aWpxMkY2cmIwQUQ1NStlZ3JEbXhVQUs4cDJLVjl3?=
 =?utf-8?B?dE0wQkRDQ3NXajY0RU5jejBRNjNOTGY4UE42RUNCMkpzbjMwb0lOZTE2VHg3?=
 =?utf-8?B?enNYVjBzdDdZWG1rWUVEbG8zU3F5NnJFVDZ5YkhPT3hOWWY3cVQvNzVzMUZp?=
 =?utf-8?B?M2IvajNoeXR4VENWaEtIUFlLVGU4WnRBTjBsN3VGbmY3ZTlZdjVKQWpsQnF6?=
 =?utf-8?B?Y1A5UG5Qak5vckp1RWE0TUlEdHdDaXI3ZHNZRmJpL05mU1FxYjAxdXZkUGRl?=
 =?utf-8?B?VEZQSThnYitZajhmNUlUU3YrYVQrc1BZVkNvYUozK3dCTXRKdTE1a0RQZ0Qv?=
 =?utf-8?B?MkxtSWJ0MFNuM2ViWWlnUUhjK0h0SHFtZ3JMUnVGUDllUno4WklWR01GSEh4?=
 =?utf-8?B?dUNEaEhvRXhxZHdiRjZnZFNlV2JzTnVqbEVQeS9QWFNBSEZPRWlkM0ZzbnlU?=
 =?utf-8?B?aDNZMklWK1lDYnJtWnp6cWRqZjE4VE5IYW1VeHkwWXRyUTIrZ3NyQWgrTUlm?=
 =?utf-8?B?WTlTY20wWEtzR3lFRU9zMzRiRVZuK01HUWs5WmthRGIrTjZHVUVUd0JrUGhw?=
 =?utf-8?B?dGwwb29lTWh4QUtWaEx5Vnk3OFlMQkIrOGo1UFZhWXpPR2szR3NDSkJCZ2pC?=
 =?utf-8?B?b2dVa21aV0h3c0FBVWpiZ1A5VVBHUGVFN1RGQnFjZ05UVENFczMzeU8yOFR1?=
 =?utf-8?B?SmIzN0p1ZkpzekxDUDdGbmxEOXFsTTVJNWxmbjAxMHArT25oUGprT3FCWHFJ?=
 =?utf-8?B?VlB4WVVoNHd6MUU3eXNmVVNjb1ZMajFkd3N0czF3U2poOS9vN2l0VEh4V3BJ?=
 =?utf-8?B?cVZ5d2hTYjBKYzNhWVJ4RjRGczl4QXNHd3djN2hraldTV3V6VTBaems2WmRK?=
 =?utf-8?B?dDlxa0x1ZVBMUzl0dnlNLyt3U3lVMmlrSlNYeFNpQ1RkVityK2xwbUVZamR1?=
 =?utf-8?B?QmtKbFJISTNRMFpBNHNNWlIvNEZ5dWpnWFpmOTNwMmx2UURzUHVNc3dQVWpY?=
 =?utf-8?B?Tno2ZklKemVMaFYxUHh0VnRQbU1ETzVJVWx3VjZkaVdIM0JPNDN1aDF2cXdV?=
 =?utf-8?Q?X3CAYgpDv7LcgVvY=3D?=
X-Exchange-RoutingPolicyChecked: jMi5cs00eI4wM8fvAtAP05d8HcC3SDZcUvWci/FgYtmfOfrBhfdHRWiUPokecXERfatfEy6aHDxkZqrpZxvOVIRJC52QVg/6HsB+Eb0l0+Tjcu71iy9/zxiNbC2//YbNYvHYymfqSQwiZjaWNg/JkwUv4T1wqCNSPIsL42Fh9a6r9eqs9vTpmAdUkMUzatTZpJjmrKIVjDX/hJTFgdv1LBKS5TQfOe8daTpeKrmPhPf76WOFbEbpl9CdqL5bAvbglCHizTAKaKVFLp03jgEDHdhjKli/95I8ikpEYdYowzgZ5sg9c7oPIG6c3puYedEC0UtPb3ucBDHswPZtTj4I4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2aae28-bc26-4089-c226-08de890f4f64
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:06:38.5019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQt8jNDUV996uJqVN25uoMSiWpUd6dXbwwfjf9L/e4KWKW7M5McVxTJuo0nkTpygaPePBFhEDJ/8FyFCt6ShkOZcKlf0S1HDtHmoeuFYZW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
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

Hi Konstantin,

On 3/23/2026 3:48 PM, Konstantin Ananyev wrote:
>
>> Add VRF (Virtual Routing and Forwarding) support to the IPv4
>> FIB library, allowing multiple independent routing tables
>> within a single FIB instance.
>>
>> Introduce max_vrfs and vrf_default_nh fields in rte_fib_conf
>> to configure the number of VRFs and per-VRF default nexthops.
> Thanks Vladimir, allowing multiple VRFs per same LPM table will
> definitely be a useful thing to have.
> Though, I have the same concern as Maxime:
> memory requirements are just overwhelming.
> Stupid q - why just not to store a pointer to a vector of next-hops
> within the table entry?

Am I understand correctly, a vector with max_number_of_vrfs entries and 
use vrf id to address a nexthop?
Yes, this may work.
But, if we are going to do an extra memory access, I'd better to 
maintain an internal hash table with 5 byte keys {24_bits_from_LPM, 
16_bits_vrf_id} to retrieve a nexthop.

> And we can provide to the user with ability to specify custom
> alloc/free function for these vectors.
> That would help to avoid allocating huge chunks of memory at startup.
> I understand that it will be one extra memory dereference,
> but probably it will be not that critical in terms of performance .
> Again for bulk function  we might be able to pipeline lookups and
> de-references and hide that extra load latency.
>
>> Add four new experimental APIs:
>> - rte_fib_vrf_add() and rte_fib_vrf_delete() to manage routes
>>    per VRF
>> - rte_fib_vrf_lookup_bulk() for multi-VRF bulk lookups
>> - rte_fib_vrf_get_rib() to retrieve a per-VRF RIB handle
>>
>> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>> ---
>>   lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>>   lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>>   lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>>   lib/fib/dir24_8_avx512.h |  80 +++++++-
>>   lib/fib/rte_fib.c        | 158 ++++++++++++---
>>   lib/fib/rte_fib.h        |  94 ++++++++-
>>   6 files changed, 988 insertions(+), 260 deletions(-)
>>
<snip>

-- 
Regards,
Vladimir


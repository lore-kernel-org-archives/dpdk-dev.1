Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7225DCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A654B402EB;
	Mon,  5 Oct 2026 17:45:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 29DD64028E
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791215154; x=1822751154;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=x9eci7n+TauQF0102obwp3A41BWhARrv2DsosJh2vvk=;
 b=ZIo3AybOtbOuBGW/ucNpZgw0VXj7i1DsiWehZXlrEEQfY8EGrG+4S/u2
 4Egmqnp9dHqbppbWbVISU88r1PDSd2iFxuzaQ+pfAUJoLGuZx8syXp2+p
 jIPAhWLQ2RXe5lbo9aXSgZmtjvBiH91nPzjcqmUr2mNGpx+Kz03CPrPpn
 H/dhlrGnklSCGB9FYHZ0wbFliY1UKGnVDIC8+4zMAc5dbSDLAkA8haHD8
 ZL0FrRG+2DoencptCQvTUEHdm5TmHA0y4+5UaaP41AsCIjO9G+FMeI+Nr
 d0Zrauo1vFsrES2xX/pw2zwwZO4R7XV4jX4vVe5z4fX5ey6c+KNQGgrld g==;
X-CSE-ConnectionGUID: ekECHb+dRwqwA/dOnha9SQ==
X-CSE-MsgGUID: 8yShkaJ/Tk6kIWv9q72Izw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109380149"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="109380149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:45:52 -0700
X-CSE-ConnectionGUID: 6IB9lH8dSEGFFjtDD/nPMA==
X-CSE-MsgGUID: Av85/dgZQTa7xkqmoBhIbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="284734414"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:45:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:45:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:45:51 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOOsx+GB4mKt+BdDMttOHYQ0D1te0oyPyug77wd6Jtz66umHM/jKyvjk2LEE/W08uAGFpb8egBF4LhHc0Di/8xg1Z+RGIErSQQfVCzDDPkLn/VucHEdwymu7WcK9EC7LEASGdmokvehw0byXq+MS099Z/Lppp1hTc+bq1shwrbMk/AeWkaxFwF3Hvx3W7zrBcC7QJ5dZ2uxA1bfgcyxOzqAWeQA2MfJIJw4SUS7/M4IAtCTQHR33bpdK+WAXwCiSnFx/hnpHJeX8QduaciSNA4utmy6EE7Dd/sBpTs9RTtQXCuzuJrfLof7PQXAo6a+wIdpZhQlT3aAT4KycWDEH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYJP3O46xguqRcLl3NVYPwBRAqN6CZaxCuUrfCdgGqo=;
 b=T6TOaVxxkdMaGIHX2UnHCiQOuaeIZC/kCGVdHtmDJJYNdHWG6nJgLazwecHNsFbcEC5sUNahzMoEDyAuCqGzhkHyhw52KbF11w4Z2Q/FJoqqfUhETm9Cm7HXrOQYhm+KPvejcHcXJAuEkdxqqcOcF52A7fgfQfR0lTs7SXQSTktSJYNl8/AX1At9t92cyqodcfDkQzxSF/o1bxymqJtLtT/uzP7MSdM7tWcHeMSx4L/KqIhxJ4GiZ6RMx4+VQrOsACzvK4Udt82idyOeoUsGamvzgjhFWIr0bVawtSpvo/Y7U2+dTlQLTPzHJhbCiuGBLnrXShyWDchHPiX0orYCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LVXPR11MB9708.namprd11.prod.outlook.com (2603:10b6:408:388::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Mon, 5 Oct 2026 15:45:48 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:45:48 +0000
Message-ID: <c6f308e9-f603-413c-8ad9-4976db6ffb32@intel.com>
Date: Mon, 5 Oct 2026 17:45:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/19] net/i40e: reimplement tunnel parsers
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <9049334630046d6bfc240a79bdfa68ab1085de6d.1789560946.git.anatoly.burakov@intel.com>
 <158025d4-00d8-462c-8c68-6e23c432361f@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <158025d4-00d8-462c-8c68-6e23c432361f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::34) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LVXPR11MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 727a94df-c82f-41f5-ea1e-08df22f7b9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Pqv6UkaPBoiSTGTsU4ouUzW5FTuqA7IXuGqpZXKTKV7e56+KCSpmIUYhXXPd8ZrzK9hKsgjepLE5AQ9dEc3v/gXy8mHgJP3MUsbCGkjfTZQMCSWqFd+6MPYfEEZDHprxVls3HEJQNm4jc6r17L2DeHHp4tD6AZWDKvoDpiO7hKbeQyCD+MtD1t4fXihHn4fy67lnz0SCoEny9OZEL9/4Js877OSaqvh5p9Hz3KHgZMfGMiODzN0XyQDqhCCsWQuzd+vzzuBtxF7L/TEZN1ImF4iETTuT59dcJs9nEpQRZZ0KXS73k4hLYzbH/wzzj734VovYcu2+qUr/Iio9CvGDixWm5dlYGP9aZtCTfb3jytX36lNAEG9IXmTQbLk5G549VVRPb/mUqPJLJ+7+bTr3XDJPdLimaafUPxc1Yl1K0mPDRcxuU4FriDJt3u5jUC/Ij0M4NKMTgETcWxq1mCPRJwVt6kbo0z2iOJ5tQZXazgLd+cMDT6mLgxSUcv/Hr2GMuHu8Tu6XPrSP7/YxVxvjvyikp6SXAWJqQwShLmQEi9zmRTakBxmr3IEa30b0Fm/xmfKInvZnoABmq3SXEe9sCBVhPKGszuGvWnDEid+hZdHlFd3YrKCAd7rMfhRu/9Ya16xfUZbOGdM5EO64JKHwv1mIZNI7oQEiCqDtnW/sWHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly96Zkt5NzFEUTN6MUZNZVRUNEhZbFdxNVJRa0l6OUdLSy9nUFkxN3RvZHla?=
 =?utf-8?B?RkdSTTZaR256SnROeGZYbUllVEcxQW92UUpRRG80RTgzVjZ2eHliVDlKbnNv?=
 =?utf-8?B?QlpzaVNuNDY3OWZ5UE5EVDI1RVRMc0VWWk0vNEhGQm9EMHlnUmtQNTQwVlZG?=
 =?utf-8?B?QVM2aUpuMlR2VDM4djN3VXpYeC9QV05pZnJZVXUyeDFTYjhSdWFKRXllVURq?=
 =?utf-8?B?QXcyMTJrZUdCUERJektWU0U4SEw2Qm5DV21DQmkyZjNqYk8vZm1Ia05Rd3Z1?=
 =?utf-8?B?b0Frd09BUGZvWEZIU2xCRXFmMitZOUl5aFk5Y01zZVNvT2ZMTVh4b2hCZmZS?=
 =?utf-8?B?bnhzQXRCT2ZGZjRGcm02UXV4akw0NWhpY1BIRnlPTWUyeFdxeWxPOHNmN2hk?=
 =?utf-8?B?U0FsTGtVZ3VrTVhjZ3BBS3hxQnB4dlNzN3o0SlRwVzRBTmpzRG54UXJwUUhE?=
 =?utf-8?B?RmpvZ0NDMDA0K2ZpcDc2czJFSXhhOWw3UzcrTG1sNHRiOUliNU9uWmc2ZFA1?=
 =?utf-8?B?R2xDTldpYUZoZU1WaXVrQ3hiemhHMnplaHBBcFkydnp1T24rZGlGM1RZcmdL?=
 =?utf-8?B?bnJQQU53bWh4OWRVQlRHVmRpaC9GV0JBQkRqZzVUQk9QdnhqVHY3cXA4V215?=
 =?utf-8?B?N0hKcENyclNONWFQUWtyTXJTRU9IZWlTWHZVZzBXSUxDQStPR3RaNFhQcWJV?=
 =?utf-8?B?OUFlSnpSYXlBMXVoc2RFWWprVzE3d3NkL1BqTXV1aTBkOEhKM291R1E3WDlq?=
 =?utf-8?B?ajVKdDE2TFgwSzR5aEwycWFQSWplMkpHNWN3WlMxNUh3bjRIbkp2RTRiM1Va?=
 =?utf-8?B?a01IR1VUV2s4cE83YUlacjBKNzB1VjV0R05odTJCK0pZYlozeE9ndjROdUNR?=
 =?utf-8?B?amxrSklNYkg5cjU2TVdtcW9FTkM3U3V0eVEyejhscWZ6cEw1eEpEOVlZZ3Bx?=
 =?utf-8?B?dzI2bmhKRDRJVTU1QWtzaXR4ek1jQUJsOEhQa1pSTFBvTVgvUTBWYmlobHM3?=
 =?utf-8?B?V280UmtseW0rU0pQaVhpdW1YRFQwN01TZTZjd3ltby9uYW0wUmlYV3RMazAr?=
 =?utf-8?B?WnFXVjk5eDBZakkweG8zZDhvUDEydHZObWExWHdUclZHYzBoNm5SMDBMME13?=
 =?utf-8?B?MkFlRjVHazJGbjhWVDdhMTd6SitkdEdMZkxOWm5wdGpaRzFzV3lmNVZrb3k4?=
 =?utf-8?B?cnFnQ1pPNzVHUFc4V0IwS2hWbDIrRHRFU0dXNmhwUWx2OTc0VEtyNGc5d2l4?=
 =?utf-8?B?WTRkOUs3V1laYno2Uzc2ZzdqaENub2hFdUZVK0pLZkI2dmE2QkNlUmppRllq?=
 =?utf-8?B?Vjk2WjlLVUlXZHpwSnV3YitZVUlDZlJNUzN3NUlwNTlBMnJzVHNaSTB6SUpV?=
 =?utf-8?B?S0J2MWtEWTBlZXBDWXJLdXZXL0ZCT0JoL3c3TVVKTnlVYmFsTWhrWHY4K0hm?=
 =?utf-8?B?Ykx0dFQrWGo2Y0hlKzRkL3J1NW1tRGlrNVRQa2FtLzBCVTErN041c2ZERFZ4?=
 =?utf-8?B?QlJDaWM4Z3dxY1BORWgzS25uSVljUzJka2tCSzMvUDRhUXJoVW9CTWoxODly?=
 =?utf-8?B?ei9NQlFWRDJtSVBpM2g1SVpZTnlMa240ZkpEYjU3WVRvSENweHQ5SXVNdjdT?=
 =?utf-8?B?djZodnUyWE55dk1iUlQ0QVJMemgvWGFpaUd1SFhHMEk5b054SmhlMEFNaU1r?=
 =?utf-8?B?Nk5waFZUSnFWTkx6YzVHQ1VQdDhtM2pQNXNGVWluLzFGRXNhOVM4cysvbVJU?=
 =?utf-8?B?cS9uZ2paTjBqZHpnU2p6ejUyTUlYaHY2SEQxVWRVSlBBUWtTekduL3dCZk1W?=
 =?utf-8?B?NzYxUk1jdE9XMHpjVUg5N0ZBeVBIWGVoVzAzZk5wV2xpV2JTMzRHMm9lbUN0?=
 =?utf-8?B?NzB0bDgyOTNTdEtCbnJQM0NMQTdFMWZxU3JmNklCeDducFNyOFcyZEtxL0o3?=
 =?utf-8?B?ZDhhenNsaktjVlkyelJJeHlyVzZOMlp0N2VEWmdSRmIyOVhvWjdqc05PanN6?=
 =?utf-8?B?MndBT2REVzRUNElBN0xWV3YrMVJVVlFhamlLcWxER1NaNWRwc212QWdpNkNi?=
 =?utf-8?B?QTlLRG5heWRTMTBpUUwyVDkzazI4dk9kRXZ0c3UyYU5MZ2dzMEFXa3phWUJN?=
 =?utf-8?B?bWFEakxXa2l2TE5LdHRPOWIrYWxoaWJmMWRndDFYd1NsbXlQSkxWdmcyeXZ1?=
 =?utf-8?B?Ryt1QzAzNW9SNy9qUEZ1TWdNKzlvS0JsU2xxd24wVGp0ZVVraEl5SVRyVkd3?=
 =?utf-8?B?TDc2eGg2QmVZZUJFSmRJNHFUZ210WXJLcHM5RTd6cUFUUGh1WUpTdjBuRWpO?=
 =?utf-8?B?SXlOWGtOVkZZZFQ2RERzd1N0YkFmcmlvMHdWaFloS1NoWWJ5UnpQR1hUTUJO?=
 =?utf-8?Q?UYImfsHUOO3MTcA8=3D?=
X-Exchange-RoutingPolicyChecked: WN0bTdeuRdKRatHWpYo3//y/A0l79+VCTX+/kqc5fAu9wHB9OtW1MBs9WC1L4iSuH7KR7TmcBch5I4MXakeG4bO0XvFAdkrcrHm7SLkpj89r86XQB4l2jOFD3F4pqTmd2wX3w5DtQMVfHqXbijY6gX3g51VB9//776E03/lVXsOJRtulwFAozMQjqYHfRbjFeMUGGnBN/7NCrqOw4wXAqeKeM7SQiaeiBXxbRnnkY3u6jniIKbcq2W48unmWlSE9Wr99FphXP0Y6jqlP+xfb7ECfcp1bHyCADwQx4FWxgShq9sUZOXPDa4Pw7ZkqQLtOuaaoLwjecbBo5K4f7YD6nQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 727a94df-c82f-41f5-ea1e-08df22f7b9fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:45:48.4599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjUoNT8tIrkcEHQj5nzCxmBuy5nQO+X8rJhFZ5UpXZVnzSnR3rEvWMyHFFKj9y5o4cA1EEF/A5l+fr+dqe8Bwdq8MAC7/4QoKIFyAgATyio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9708
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

On 9/19/2026 6:14 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Use the new flow graph API and the common parsing framework to implement
>> flow parser for tunnel filters: QinQ, VXLAN, NVGRE, MPLS, GTP, and L4.
>>
>> As a result of transitioning to more formalized validation, some
>> checks have become more stringent:
>>
>> - VLAN TCI mask is now required to be fully masked (all-ones); previously
>>    the mask was only checked for eth_proto and any non-zero vlan_tci mask
>>    value was silently accepted
>>
>> In addition to using the new graph infrastructure, some of the checks 
>> were
>> made more stringent and/or more correct. In particular:
>>
>> - old code did not check for whether fields other than ports are masked
>>    (they are now rejected)
>> - old code did not check for whether src/ports are fully masked (masks
>>    other than full are now rejected)
>> - old code used spec to decide which port to copy (as a result, it was 
>> not
>>    possible to match port 0 - this is now allowed)
>>
>> Tunnel engine now also share a refcounted global state, and track all
>> flows and do deduplication inside the engine.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---
> <snip>
>> +static int
>> +i40e_tunnel_node_vlan_validate(const void *ctx __rte_unused, const 
>> struct rte_flow_item *item,
>> +        struct rte_flow_error *error)
>> +{
>> +    const struct rte_flow_item_vlan *vlan_mask = item->mask;
>> +
>> +    /* matching eth proto not supported */
>> +    if (vlan_mask->hdr.eth_proto) {
>> +        return rte_flow_error_set(error, EINVAL,
>> +                RTE_FLOW_ERROR_TYPE_ITEM, item,
>> +                "Invalid VLAN mask");
>> +    }
>> +
>> +    /* VLAN TCI must be fully masked */
>> +    if (!CI_FIELD_IS_MASKED(&vlan_mask->hdr.vlan_tci)) {
> isn't VLAN TCI optional?
>> +        return rte_flow_error_set(error, EINVAL,
>> +                RTE_FLOW_ERROR_TYPE_ITEM, item,
>> +                "Invalid VLAN mask");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
> <snip>
>> +static int
>> +i40e_tunnel_node_tcp_process(void *ctx, const struct rte_flow_item 
>> *item,
>> +        struct rte_flow_error *error __rte_unused)
>> +{
>> +    struct i40e_tunnel_ctx *tunnel_ctx = ctx;
>> +    struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
>> +    const struct rte_flow_item_tcp *tcp_spec = item->spec;
>> +    const struct rte_flow_item_tcp *tcp_mask = item->mask;
>> +
>> +    if (tcp_mask->hdr.src_port) {
>> +        tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_SRC;
>> +        tunnel_filter->tenant_id = rte_be_to_cpu_32(tcp_spec- 
>> >hdr.src_port);
> nit: just as a thought for future improvement: here and for some other 
> protocols, use rte_be_to_cpu_16 instead of _32 and fix 
> i40e_tunnel_filter_convert_conf?

Maybe for future improvement, I'm not going to touch this now.

-- 
Thanks,
Anatoly

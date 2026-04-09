Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED81EA3C55
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 12:18:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75E174028F;
	Thu,  9 Apr 2026 14:18:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3192340276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 14:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775737116; x=1807273116;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=b/w/zpIrxmQvs9fUqD5M/ssJ3f42WO7whm8W28BWjpk=;
 b=AvX5CdG3yBwkl6DDy0Fhm4eB4lEp+UYfnwFEWdDrzBeh13BPwC3fsNFS
 3M7vNr89oQP+3OyVDQnjqpM0M/Q21XCNsZHVwaDV0gBgEBtFBoKOJQAQl
 64Q9YHJesz34/nm2r21OCECIQKFSdj0xGTJrtPKzaTGZiMn4ahiqkI411
 Ms1t3otzTsks4XcF/gcTuDzfyJHBY9Oghtg5cfwIHMaxrNygZz7CWR4FN
 Wa9DZDVNCrLBY3NmBPK5WBx0diS7zZDnXL2IK3QQ3l3Pzgr1fe5uxFJOB
 11M/dzahhB8g6xwJnR9tiq5KYsWCSA4QLS7LpZYmuMu4iinrpi4yTvyxK g==;
X-CSE-ConnectionGUID: ng8btt4AQTCpI60h/Mhpyw==
X-CSE-MsgGUID: n9ycPe5tRFGkf2dZkiCrmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87364062"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="87364062"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:18:35 -0700
X-CSE-ConnectionGUID: WmTi+sc1QyiVHa6NREYKfA==
X-CSE-MsgGUID: 3pdRIxSyTPGp9t/9gkmiKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="266731026"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:18:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 05:18:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 05:18:34 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 05:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX0WF8o5gyLoEpzAkGfFTF1I4FuV6za2l3/61yQVbdW0dX7GmOSbDuE/o1HWLnW+l5a+UdulRY7QE0TqimmBPS1XGMsX/o8iXW35ylOnAJahC+snbBhKKwzwhJYyn61bdhpepDq5ZpZ/jV3/GwACJ7T+DOP7snXG7O6/S/SUiLte01BL0DgC1b4im59WzlPzuZT/Mhbp9o6+VNRuIcvkJny1x89ASqEUSD9cZUksydaIbjJj92i+Ldagw2xp+e8qwP1ecpAHieX2ey8mTo5yGrb3iUNeeeIIoljgu58RPxbaB9IqV6pupdk1LsxiqJ5QXxFuirZeSTxvaWd3f7Pj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F++xlYqClHV85sN1/BdT1sxJX9R6s8H5opuZzyHyvC8=;
 b=UDd8/8nZN6uJUVhe6xnPRiu95APXfU0ZNHJD7S17KR7fhhJ61/Gw2DhfTyr9snVg9TcHKUsPWHGjXF1qkayf8H7gNC/sCr1OVEEQqjDFozx9qX20Ol5gSZgXLzBHAFcmKOrW01/a4u0myFkdm4jP0WpZ4wdcI52FInSc43Di62JM2u/8xYMCY6AAjrwfcgEjwbmQAgaWnn8ucIFE1uXj/tAUBZtS8BGP3gEN4h7tGU26/fGXPHEtIUPyzedhlJKwGdPNJbVPo29cS/ltDoUopBAJtuHFo8TA/o6i+/o46aRrQxaPMANqXlKsWsBNSFICpjoY//Lr3MkHlZoRd3CqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Thu, 9 Apr 2026 12:18:30 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:18:30 +0000
Message-ID: <105e86f9-0f2b-46d4-bea3-4b55bf5ed92a@intel.com>
Date: Thu, 9 Apr 2026 14:18:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: shrink size of context index
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260408154804.1596060-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260408154804.1596060-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::34) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4a02ba-3fc1-4768-0b1c-08de96321c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: A0NcZJ7LYyVQ7c4Ke85xI/F+e66R316Orj26y31opUcLHXybnLpVzWO+unE+jJba+68gf15mhDZUUZUwlRAYRxz2eSoz9kQpnt8DPIXoT8URUlR39vAK5wW12o7NC4xXaVEPuB9x9RNoF07tKzNDyXC+oLqgxzj6Ck409Wzmbts7ZoGTZ2ZevufJWwnq9DdqUnmCEPNN9m2ZNRKX47PzjTqG4uQns+G5Xsc7oK2AOw7PbqDsQJ1sdm0vRRUDKBGxcTKZLA5AH/a7Hvm8ATPvsMg7kjh5hqjt6cfYs80TCB1wREKLEowvFskw4ER22TDj9iE7g2JUeu5edcS8b5C6kI4Sj31jhQytGvQK8BRBUD2MH9tK/aF1Fi3e+rB2USzzy3woA+8DoyC4WoI5BAzG24BFZohp1rERjXQ74lCpJLdTOqrIBAhdQc++ANUfmnvhF4M/eFqaF7RBbsvrd5HEjrTOBouOryTWl4JZofImipxoG02vfSb2QhuqiMi0utuwzkCK+WX1qJLi/QHtzcl2Gw053MFjLOwZnCpWF5cv31VAOHDiWZ1+syrMMH9SrhHhxAXdaI8XCUfiND8MZr30jXYAA8x7V4sMplu77YHga9CntFKSOZmraV+abmeh1lOZi8pkZIB6oa/z25ny6h6wQtYWIjtyCZ9RfaWOHw9/TyfIXimACnlLeafizrTu+5D1EPkppuMdMcdOjtGDQMrPiALwp6nhuaOCd7shhjJN33A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lpUUhHNTlHZWNSU0pUR2hNd21sVC93UktydnJnS29RaXAxR3pqZnM0WDd4?=
 =?utf-8?B?NGZyeEczd09ha2xBa1pBUTl2NW1mSUtQL2FIbmJnUFZ2SE1uR09JV2VNMU1u?=
 =?utf-8?B?bURhcTVBUEVhSkMxcUxEWWxMcVNLWUdHR0tEYzE2RlNERzhqS29UUlpDZ0Q0?=
 =?utf-8?B?a0F5OFllKzhWcU9OK0dKRG9vU2dXTDFBdGk0Z2tPM0hEZU9WODdpcGtlL25p?=
 =?utf-8?B?WWNyOFBCZmkzK0pTRkVOcnVZNm14Q0FNMDBScEtNQUsxdGIyVzlKem1zWUhl?=
 =?utf-8?B?MERmMkg3R3FWR24vbFRMdFlRcU02NWcvcFJpZ1N5TElVaFUyR3B2cWxadUNm?=
 =?utf-8?B?bG5jRDk1WWxhUjZxVGZiS2gwOVpud01iOU52b0Jwa2N6eURtc21BU3BTeGVt?=
 =?utf-8?B?S09BaXhNaVlNV1RXV2Urd3BicFB2RnJyaDBBSDdwWk90NlplZSt6UlBIcERu?=
 =?utf-8?B?N094L2RkUjcyenhnbE5yZzVnME50dFIzTGpEcEhmakp0bkxxcytrTVdLcWtx?=
 =?utf-8?B?dS8ySFdDM2RaVFU4d2d6a3lOdUFLMFN2UTFmSm9XVGhmRktSUXdMRGlNT3ZJ?=
 =?utf-8?B?S0Q0T294L3JGOHN5YnFGWWZLUFhoSExEVkJ2R21PaEwrNTFVU1dxRXlaQjF3?=
 =?utf-8?B?WUZHMXY3ME9mWEtjeHNpaXp0VEZmbUhQd0lxK0h3QzMvT093UTQ2ZGU0ZXZx?=
 =?utf-8?B?RlE3b09WV2M1Rlh3UU1nbGFSUU9nWG5uWXZ4K1QzYlBqMnJIT2F1RUc2Nk9i?=
 =?utf-8?B?aTl2VTdUT25kZStDMVJWWFlPMHl5eFJzdUFSUjJMNmxnbEZoTVYyY0NWSURG?=
 =?utf-8?B?QTlqQXBmeUlEMVYrVWhXWUdXbnVYSG1BdzRsa3RpcXN5MTZZeWFFRTlNRXdq?=
 =?utf-8?B?ZGxGYnh6YjVUQXRoaE9ONUQwRlozNG9Bc3VCcGlSZENxWGNkdDFtTGR5M0Nu?=
 =?utf-8?B?ejdqMEU0aHJONkJXNWJRWm1CMHlBcXU5S2tsY2JleFJsOXZwMzJvMG5oTDdS?=
 =?utf-8?B?c0xoamJJWHBnQ1F3cDlqREdxVXZzelVPTW5OR0FZYTRwWWdWRDR1cExtRlRh?=
 =?utf-8?B?MFRHVndVVHpHTFNnalhPQ0tKaWJpbnJjUjg5U1VrNnpzK2xuUjRSK1RKR1dl?=
 =?utf-8?B?Nk1NT0xUYk1nZWVhUTR1QXRpNlRobHFjMWU5NHFaUDdzQVllNHQ2ZEQ0V2ZH?=
 =?utf-8?B?bDFhODdDUnlrRm5TbEd3UmZaYi9IbU5RaWVzUHMzdXo0eUkyUExiWm00b09G?=
 =?utf-8?B?Smpwc2RpZ1FYWFd4ejJ6N3pGMnp3OVNCa2REWml4cDlpS1RXaHB4UE1lWlBj?=
 =?utf-8?B?L21XclhIK3Z4eFFzRjRWMkdUeGJNOVNOQ3p5aTJDRzNUb2ozcmRFMVhEdUl2?=
 =?utf-8?B?Ym9sWkxRbGlvdTdXUThzYUxERjNIWlJweGl5MFdySllZazk4MXhDcVVsK2Ja?=
 =?utf-8?B?Y0grSzR2NlNKT1FhUXh4bW42Y0NrRVhMVjNQaWxtS1Y4YzRKSlRGeWJzcVpm?=
 =?utf-8?B?cy9oZVdITGdlU3lwT2gxUllFR3VRMHBIQ0JrWTloYmt3ejR0MU9tSnc2YlBZ?=
 =?utf-8?B?TzUyR3JBeUFWMGlVOUV6NGNTVFhEN3YrZ0JBcW5uR3M4QlQ4aEpySGs1Qit3?=
 =?utf-8?B?RlY5cmhocmNHS3BCZHhlUjNJaEVpMnpJYnVoZXZ5RXlaQlBKd2U4Q2YyRHhm?=
 =?utf-8?B?cXlaNUFyZ1FEbFYrd0lsck1RRjI1VlRBUlBST09xdEQrdDVvRW1xSUZhYWpO?=
 =?utf-8?B?aE9uaGU1aFVUY3JtYUtraXlFMnhzeDBkd2UxN2tRSU9kVjRLM2NRVHhqeDZB?=
 =?utf-8?B?YmN2T05OMytTTTlWb2VCSUJSSXRKMzRJMnRIVWlmNi9QWTA4RjV1Ti9XYjdI?=
 =?utf-8?B?Vk1QZit3T2ZhazJTMUxrWkNmWForTHZCZ0xuOHlnT0VOMXhBWmdBVWhpNGNw?=
 =?utf-8?B?cXdPb1VoZFhmV00xVWJiZWI0YTN0UG5lNFlkeGU0NCtVY2F4ckcrVTN6VGZ6?=
 =?utf-8?B?S0tYeVdhN1lINU41WEdLYmxKcWRCWmlQdnBKZ2owZWdoRzZXMVN1cjVGSlVY?=
 =?utf-8?B?N2k4YlVvdVBMUVg1RFBVVElURUZ1VERMcFRUZWVZeThsYzBsZU9peEU5WjFJ?=
 =?utf-8?B?aTVYdVhyRmI3Qnp5a2puZmZTK1JZZk45RWpLN3RrL1FTMU1STjJvK21JZG1h?=
 =?utf-8?B?b093dVpZM2pkdkhUMW9FSTZWQ2NPSnV0VjhkNTYrUzR5a2NTcU51MlZRMStl?=
 =?utf-8?B?U0kxbVBjdWw5NU45MnVMZlI0K2cxN3ROVnUxV0xOejUxa1VoamdYYUY4RERG?=
 =?utf-8?B?U0pjeEdZVEw3RHJOZTR3MUYrbUZWczlHQTU1bVFCZDlxdFkxdmtoZTlPUFFR?=
 =?utf-8?Q?Et/zOh2yUZ/cqdbQ=3D?=
X-Exchange-RoutingPolicyChecked: VRo5aswB8xk0fGToOtdxorHlb+FUDFv+dBsdvJxeYdz9a6QMFSdxgwJDo1HXoNShgcykOfT94S2inA2mzDQ162Z+FhBuLJDkjYpLE4ESxHLaQEcSnGcckRCzWBntqRvWE+Lg2Jw4/4xvFh0t/rA80cm69aqTtmSTpo60dnukGgBT+8ih3dbT85j8PCeoKyTZMCFXDQXlnPg4cZWbL6TpniusUpSakoGYHSamWT7olydqERsNyfR3xk7riTA+MleNa1JjYz9tkYEx/j8toXWQc+y3rfrmDtj4TRhzesW/tp/Blu4GgrlI+MzIQdbTQbymvy+NjFoj9sVhpeuiHRAtWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4a02ba-3fc1-4768-0b1c-08de96321c58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:18:30.4317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLelp18j++78RbPe7WsFG947KjN0Eq3h3MJPLsjIgPc6y2v+TWSc8yz6rA3GZQ2vW3kw+RPtiP2vVTYUa+JiDSbr3ziAn6a6qv07IZ+jtv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
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

On 4/8/2026 5:48 PM, Bruce Richardson wrote:
> The ixgbe driver only supports two contexts, so using uint32_t for the
> context index is excessive. Reducing this to uint8_t shrinks the ixgbe
> part of the union from 32 bytes to 24. Although it does not in itself
> shrink the space for the whole struct, it is worth doing as ixgbe is the
> second-largest block in the union, so may become relevant if other
> rework shrinks the idpf-specific block.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly

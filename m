Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636DECA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62C0D40274;
	Sat, 10 Oct 2026 20:28:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4A7604026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791656914; x=1823192914;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=BLSNAZyY0VBuH6s1Y9SXYYJOtGjbBSh0D14yEuQRAnY=;
 b=G9mpgPS/CsKUVoHR12GfpWLXKKbUPK/GPw5aRQ+ueDFZ4FPC3fJTmYHl
 SyGbL47v7beDC3T5qcz98n++T0vlWmIyJsLucW9AKu3BPPFLQJBvhy8LO
 Vn1mPN44wfdqx4Q9zrh8/y2yGciXAMVh6dprOLXWTzh0WqX/KSXSRT5el
 EvoqO2Y0hDHNIjs+1dnupuHUVqW2f58xyagOeLUhNb3zE4vSAaIa4Rwd6
 3z5IviwwUcp7g7jPA2Nh9Ah3uW9ZZ7eBgSz/DruYflxZ/wRBSlignpCcu
 627z+llEIHE6aEd4TLpFVQefoqN5vTm/OYwr81EzB27wwoNqa7cQ9iH5Y A==;
X-CSE-ConnectionGUID: 12Dd0iNGQ5OOtx01dRvuyw==
X-CSE-MsgGUID: 21YbYqInSFWDS4inCecdMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="312268"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="312268"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:28:33 -0700
X-CSE-ConnectionGUID: jMeG6J4dQg2I7s7mlOEGBA==
X-CSE-MsgGUID: /CxTCslPQVifjlWpfZud6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="486603"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:28:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:28:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:28:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdQs6fQqRf2WqtgAu3z6BArqUfr74Nz8j73Kcr5A6NtWqR4V1xvv34gWMVmoAtgg6F92tYvOVurAnoBOan4gmnGBpMRTb13D2WzJffSVUSTLTFM8U2WAJfg01wOAtW9L3syfzDvK3jsKPVnaAZ1Bi20c5ndexYchCYvikye9EOUXNG2YjxAh217xp8sS/ZaSupmsaGkXFAZAAOgK8JoTaUNcSbj/p9zE+EN7QVfa4+pZ89h3qMi/qaJlDnoMYvsAM19in+moI66i4qaWim3Nc9p9GbQyM5sp2Qxs1/u3oIRekqb1SfweWwDgWGXMYQvm52UlTlYLt2AGEjD9+rUn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFTAmr7Olz+tRtMgkmDpIAOo+qxhx8YbXQro+89IEX0=;
 b=wYVfXCtDttbL4DLalmdXTQHk5+DirlM1nxRq6HzgVh5UHpC8sEWz+sqvwEvhhexEke+tiGn4afjm7g7rbohBR56jSJUcF4+QzPgLpNBbaAp88KQ0WK1TVbqhjOUcVwGAScVyUaVwBGVzxk1YixO59AjCYEeUFeOoCXmYWqQFjwhgkgmbrfDbqitxr6KBkr1DidLT4Fj4sZgUN45PkrwPfRNZbQKfdzA+lani+KqS0UsOFbYmSBNxeRI3I1JUA5VdX8d/7p3x7eN8MWysHduEnJRvW8XbQR9BrXRIFK4uQebN7+Fdp+m2KIqUBtm0nsFaZMMQgZCKAO64V7NJzYAEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:27:53 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:27:52 +0000
Message-ID: <512af7f1-2327-483a-b39c-71a99f6525eb@intel.com>
Date: Sat, 10 Oct 2026 19:27:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/25] ethdev: add flow graph API
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
References: <e268ba869b9bdb319d3fd104c3e811f5235cda8f.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <e268ba869b9bdb319d3fd104c3e811f5235cda8f.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::16) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: e2afc1b7-7958-478d-1b57-08df26fc3253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yJ3A3kZx4xPhWarjovlPdHA7NDlUzEu9w5IM00bR02HqmuneVqm/FtFloNgJJcE5W6LjQdxNntDs6WwAFw+P1Etwzg0SXsgnw0KXNgK6D7xNDHSOmGhfCTzEsBInjXDdkDZlT+Q2xXUAMBlO8A6mYf8fTC8no2oPPJmkTQSX/SyS2vukJjmG9fgs8O7pnjSNSN+mvaB5SmGNjQuX68BJEzZR3bzhJXoBYQ0D/MsawbLbwG0goNVjWPtPxODeKZ+HQ6vJe8W3YOhQldvwAPp3bMU8IuYVgG7GRtiAob231an8d8eQ/S198Y5UedlteJ+Grj6nLdRdEzELsV97CFFq37MnhTSnG7bCkHGW5rsCoGJFIibvx0ihnJ1RTkNgzAyiqxByvF1nIlgug+hUGqvexGTTmArcbqDKqFawWfdAavpGaEVnpN0+pDrwiugaJzU2PXmLn59tveZMofbaV3eEgSOpROm0m+KUIRccUMShQaRvRr/JTCDUSy8RFfopEzgp3f1l0OZuE+/5knU7+BFz+G21RnB+AKM41oz60CcpoEKjs5CV2tkrHGcIlAyviZsyY9uzDxx71sh4yIiGD9u2cUF6TYsTh7q8jIMbkIcExDUBIziWqVrA4pxObiU6yGmfwK9T1v172YwXgvqtn3bGOUSU92wTHJ/iAP4B/sUT/J4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJRU3ZMNUE1U1JUb3hFa2ptMzdJaVF2bzFmbWk4OUM2TzR5V0dQcmNGa2Ix?=
 =?utf-8?B?anU3akgyeDY4N3lkNHNQR21FT21pbUpTUnd5VE5rTTRaM2NCaExnSkNVY0Mr?=
 =?utf-8?B?alovTFZ2bW01NDF5b1RxMmtqQ0RBZXU1anJKQXp3NGFIR0RJNHBmeFlwT1dz?=
 =?utf-8?B?SFlwNnRLeVZoencvQU1LSEhPRjMwbHhaK2VUNnczU3JrcGVoWWhkbWZpK0Fl?=
 =?utf-8?B?RUYzM2Z1K1h2c0Z5SWNFa2dLaENMdU5xb0R4clpjcmJTSjFKTlExTkVQc1NW?=
 =?utf-8?B?WDlpdWhQUXhVa1VLUU1GQStmS25QN1N0b2hwcVk2eHhxOHQxbzVWVVVWcUVs?=
 =?utf-8?B?MkFRbTNjaTZHaFZodDZqT0lRaU8rSTZxcmdUYnNoSzVRU0xCWENUVFJTci9j?=
 =?utf-8?B?blBOcnYwNlp4aExjVVIrZTVXWmpFRmFlKzJmVEYvVGhIYWUwWUpvbkV5dWg5?=
 =?utf-8?B?anIrZmZUc2NicnIwTENxU3hBT0VoL01mWkt3QUVlUlFkbk9MTWVTQy9ITVk5?=
 =?utf-8?B?OGJJWjdycCsxU2p0bktQbmhEUUxiZ1JDZzl3a2o2QWVLWG1pMmtnckpDRWlH?=
 =?utf-8?B?MmxwbTQrY041TDlreUdVMGNEVklEQUdKbXpZQVpyNHpFZkxybjI1T2NUYkdi?=
 =?utf-8?B?UU00eDVPY3ZKK3lnaWxkRmpNL1VRdFc3TDQ0cDVQemw2emx3VVNuNTdqVWxN?=
 =?utf-8?B?MmNESVptNThtS21ZaXhLcmJER2NMdm81eitVWHdETFZScHdhNm1CcWpKSThN?=
 =?utf-8?B?TzYvNTU0R2wrNlNZVHB6TS9iclA3bjJZYy96Q0pocW90aW1zcnhrNHh3L29B?=
 =?utf-8?B?REVHcFFDdmFzZ0pMaWlxc3o2OFI2N045dHEyNW94UEV5NHFpd2Jia3F6WFk1?=
 =?utf-8?B?TmVSRlE1OVYxOGQ0NVA5Uy9nQ2x6VkFZQkF2U2I4NTRSY2dsSTJTUm4yc0s1?=
 =?utf-8?B?NW9HZ3VPWS9lOHY3YUFBWVRicW9GNWxTaG0ya3hlekVPL3QvZEVvNmE5Nk15?=
 =?utf-8?B?cnk1UzVUc3graVFsMGIwRlBLeWRpbGZTcFVic0VRdVJJSU16TkM4a205V2Ju?=
 =?utf-8?B?NnhsR2lIVXF6dmhFWjJsdHg1bVVwKzBlT2F5SHVWdGxqZVA5TU1RSG5KWTk3?=
 =?utf-8?B?QXJSYkxDMEVQVmZSZlVUY1Z4Q0FCKzUwelM4eUhYalJGdkVEeGR5VmhiR01E?=
 =?utf-8?B?OXdWSjRRaG5hK0t5MGpBM3kvaEd1enZkdHlKQnpjbTk3QVhnYTFxekFIOXNw?=
 =?utf-8?B?aCtTeDdBK1plSk1IbzNQVWZZZjJCUEN6TnVaaVFxWm9QekdnVEl0QkRzM0Fu?=
 =?utf-8?B?bXBmTmgxcE1sQ3BxYVB4ZmkxS3BoaVlIYWwxN0hxS21UK3pCTGJEcTZOelho?=
 =?utf-8?B?N1BZUEZRZ2NNMS91blVJT2l3N0NHdkd1bjdaWkw3c2lSRktPamMwaldhYVlJ?=
 =?utf-8?B?eXhqTGxDNjVnQjZSRGd4ak0xbVI3T1lpZjZrSzdtQXBkekNiT01QZUQreStR?=
 =?utf-8?B?dFhnblVLRnBhRTl3RmV0WnRYeUtvNnk2cEZCa1NkTVhGV0VzZkMvRWdvN3Mv?=
 =?utf-8?B?YWgwTGxXVWtkd1dnV3VPTTlEMFJwU2dSMXBORVA4RVpLTFRDc01TMlJ2SnMv?=
 =?utf-8?B?L0x2K3RLRmRodFZDaHpxcGdjNjVab1ZaNkF6OS9zbVJjVmJqSVcvM2hYN0Vt?=
 =?utf-8?B?c0gvdGJIZHczekJUdm1iQVJ0N3lUZUR2ZlBNZDdFQmN5bGJLR0NvdjRQL0RH?=
 =?utf-8?B?MlVLSUY2ckQzN3A0WFBjS3JpY1hYQU1wTW12eklleUJuZHFzYVdIVTFsZUNt?=
 =?utf-8?B?dEw4eFBqdkQwRkt5aU81VzNBYjJzSTBJbWZSMGkrNlAyOXpZWDlTSk9XdDhK?=
 =?utf-8?B?Y2FBQ2YxVkx4c2hneksxNitqWlJvWHYxRWVWSm5WM0ViVnpVb25xU2tOUXM3?=
 =?utf-8?B?czJQYTg2bDhWdmNxRjRRQTQ1cG9ONDVaNUVTWHNiNVNPT294eDh5RVlWOE5a?=
 =?utf-8?B?dGdtR2pGRlpCVHlncEJYelpZd1E4Ry96SVVrV1lEOUs2aWRGYU9hZmZIK2dV?=
 =?utf-8?B?R1BCeW0yWmxXTlpEdXR4ZWFoN29GaDJ4cFpNM2d5VVhhYXphVGRyQTROMTJK?=
 =?utf-8?B?MmpnQjhRamlUdlZDd1FuL2N3R25hWjlZMFVKWjg5OHg0VVVtcmxTY2J0SVQ1?=
 =?utf-8?B?MlFoQUtMM3lRcWVvQnNCY3RBMnNjbkNBa2NaRVlXSEVXTXhoZmlENjBrZ2Zv?=
 =?utf-8?B?d2JtUDNvNUdtQ2d3MmZNeTR0cW1XbWdJYnRqZWJUUzVLLzQyZU55ZVRGVmpt?=
 =?utf-8?B?Sk8zWGhvTWRDQzlmK0crQzhSZmF6Wm92MkE4U0orVlVBZkNMQVdGZDZSOVVR?=
 =?utf-8?Q?ebcBL1HRnHLuWUjw=3D?=
X-Exchange-RoutingPolicyChecked: U4cJgHeMfUI3FA7/hNjfasYBX+CL+3HjWJ/HtxpvUBKZmWZoEGbGgyNUR0uNvDwM9Bt8yzU0H6B9l/Rm1OJF2S3Zqkgp+lnsWeIeaARP808atQF2EMhmk46rrCtQpdWndQQBdJTy3cAM7c5hm/n9LiUF3RkuGhKLzTYbub+RrXSE4JpKtXk36MJjSwK6tb34q9m8bPd/W8wyVuujLVbhD7Gnzo3sMQKtufqDbn5YGoZYBw3BRTHpEvNzJCeJdC/MKgWwFmVXg+Mi63xTWco85zkMqUdxqZ7TbvKuxp8+6+TTyhoxWvsI57mDZtt9407TexU9siq59W8z2AVjiwh68g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2afc1b7-7958-478d-1b57-08df26fc3253
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:27:52.9706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvsTiiQD0m4n6K0Ixn8GdrJA0eEz72NLArxh+FV0XHsS3qUq+oKOtoiT8sFpyrDD2s7UCiSGEUj+dsf0nDVLTsNsfYfzz70wbr4JmZMOU94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> This commit adds a flow graph parsing API. This is a helper API intended to
> aid ethdev drivers in implementing rte_flow parsers, as common usages map
> to graph traversal problem very well.
>
> Features provided by the API:
> - Flow graph, edge, and node definitions
> - Graph traversal logic
> - Declarative validation against common flow item types
> - Per-node validation and state processing callbacks
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir


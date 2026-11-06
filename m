Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD91606A32E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FFGIXrtA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2901402D1;
	Fri,  6 Nov 2026 13:06:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 688C4402B8;
 Fri,  6 Nov 2026 13:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793966788; x=1825502788;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iRPknoAcU3JYgzIcOrh0Ckc83h5Wsc6aqRGWhNORx+s=;
 b=FFGIXrtA+inf+XI/eLwhkQjfkNLNJtuY46265Ld8Y0FgAydiqUIYepbA
 VZJL/Oo3UGIDl1SmB11kIwvCrbd921ylJWLWKSNeQ04N9/uOiKAOEC+JZ
 Gbo2DSZZRMnAhITISsyYwBXIPOpfDyx3j2w+lAWdKXFA5FrbSkhixT7mG
 eMlHmxl3bqMrT692/hV6Q595N9DYDHHo1bqHWwDCWOQeLTym6fw5XEgO6
 s7CdlelvnCDdKHCcmcw43u7adisQhEpiw0QccBdjH+ienxVL5aP7rSNRM
 Xp9eY5EB00ZN149lDNEoMgVYTu/iq6GOcRX7CbrJHMKSAfF2/NjECbPjM A==;
X-CSE-ConnectionGUID: 9yhPmE1ZSKOMQJbrvAIc0g==
X-CSE-MsgGUID: 9e0ByT0ESzOTyAz8sEqy0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2646790"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2646790"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:06:26 -0800
X-CSE-ConnectionGUID: 8FZqDBnkReCUA1cpJeyKXg==
X-CSE-MsgGUID: tCaEsgNzSDqdpsIz+7eYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7311917"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:06:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:06:25 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 04:06:24 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:06:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiTr78tDfnRLxmQJQ8RqFWY1OSeqy+mHVmCbf/dFaPHXXrGuuzLlnxvcd4PKIMTHVfy6xx85Qkkdwolnb3tmNU9kwIUUYBwWICe+kxMjadiqpYd+AH2KKSy0HXp3GLjTFeQJj0VlNwRPyhcp7S8pkvdsYrOEf58QrfB2BB3+pdv5qCoXizOrlaA5ziG+hN9zPr/v3U04nJ3BpUnHS6A9X+pw34llF8sovHXEVqs5ATNZRSB3zadKqz8rBand6SCp7UYbpWN6yCBOD0V3Dm2UIk7b7vIJryxJKaQzkPC6OaVBoEg4YjUn2q8l3D+NdRhA0U0PYGRZ1JC56gkUHHb+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5dCgBq8ywCYtQH0yTvnr/eVWbRAAZdIxKqnrUJtir8=;
 b=k1TLIeG8aC5HDNJO9MrGHszHohV4BAJ+gn0BWrLgs8YiFuOBsncnksh6/kPLKO4DLNVMRRBVMmZiETEruFQq1mPf5XbQB1aL2sTYYoGluiKJHU+KSnguhjxCfpmFofF+B32s7U6XawphkUUDk1LE5DhktwK2zMxj0bQkvYV5R7BliidR/kQ8RBBfFFWeJVr+3ToVn/yLbDPQ1DIb7F6GqoIxOuodpK9vXCgHMDwPN5XivCZRLi9gyqaPks56wK4N6SGWqGKN2DIqMPHCb2h5oSCcGILoB8h28kwtonW/HpxGFL59KCYYG99964WVGmE17K/8QcWYmVTeXgzJVJcSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 12:06:22 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:06:22 +0000
Date: Fri, 6 Nov 2026 12:06:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 5/8] net/ice: fix DCF QoS bandwidth replay config leak
Message-ID: <au3CuSKAH8h11GhI@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <af5fbafe6cfc167e80b3a69b2080b20b431ac166.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af5fbafe6cfc167e80b3a69b2080b20b431ac166.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0351.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a84b761-64a9-45a6-23a4-08df3bfe5faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: baE417+HD+LMNwpMli5bTXupwtsPEv+E2Vkv4PBaTNqGp/8feLSQ6ct1Yb3YvWadsLvew8SzUr71XE39ZzmYfYK4wNfzQvTY3FBNMNIL0mLpSeKj700p81eZ7uD9pMDJ3aHg6905B/mwWMlAWhHWQqccAgqAnkOf7rQBTqiMu1wIsGDSV4rX3tKbIzsXGTBCSlj58+npOkfG9dDMAktqfyS17Gy45voH7wA76u61m/GAHBRjEFFb3ROCzJoglW9eUwglGNND64nivvt54s8dRqpn5kgNAKCHC+d369lkPuf4MBqDpPALOssOFXbHcfsQXywowF1ohpmizZW5iPrAQrlD55YZvIaAFrpKS0g9TIdxZ8o7c66CyXyAncUg7il8sPNebY/O/P0uFI6lGdvUkjGAkO78sSva/V3SL9e6V7GStKfv8zPz5jhMIlYPnXLXY0PIDn+xqtQ65OZ99ETJqU+QATLOYL38xXY9n7dHObHeBGbfbjzPqsS535L2cfWFjYVytZ+v+4OACpYtgv1Ac7o6l4wrUCtd3b6DNWa15/6au9mhoQksDwXap5G/pvCkw65PFCbp91wToDkGfoC3IQd2pk7ezWXxADuHLmE8BYz9nrgwmLyC0y9MzcWqyS2538gymwtNvuWXhSF9z9yF1hET/2S1JEp+mIUeYDQw8eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2gzNStPVVlNZXRad1NjQklIVXM5b21SVnNpOWhoejIzN05iQk1YNFdCZzZ1?=
 =?utf-8?B?ZHlDWkhhZEpWTm5HWjc0VnlaZmZGK1VTOTVLQ0pmcFVyZzNHU09nenpWMDQ4?=
 =?utf-8?B?cmI2TkQ4MlJKQldrYWxyanowY2xhVTBaSVd2d2pza0RHd0YxUG5zNjZxYktR?=
 =?utf-8?B?R0Y3ZWFJaE5zZ0JNUnVoN3RiNGdvWWpIWHVsQmd2ZkhGSWRHRDViTmMraDFU?=
 =?utf-8?B?VTdIc3JxdlZaeFByeVJQall2c3BHNFQ2SEZ1L3RRK00vaWIzeHRzalFNTk1n?=
 =?utf-8?B?OTIrRmo5a28vOXdvV3lLK09Wdm5KZ01CZGZJTzdqNXNOSEpPc1dnSnd5a2t1?=
 =?utf-8?B?VEFEYVZHK00vdGx2MWtLQXpXOElkaEJZZVExVTJlNmppU0puTHViZVlSSlNS?=
 =?utf-8?B?NFF1MTJJa2srZ3lIN28rOWxDN2xlSnFwTm1CVk4xOVpvZ2pOcGFjZHNtNXdt?=
 =?utf-8?B?dGx1UzROaUhYM1lFR0xpNFJlZVFja01NaitjdVYrSUY4U2JER1NIRy84U2gw?=
 =?utf-8?B?MUlwNERHekJlaW43Yk1OU2FqQ3NEakI3cWhCVzdsb3NFR3BsQ2JvTEhZckFl?=
 =?utf-8?B?RWVjK2NIWmRoOTFZZUt5VEpNQzNoR1c1Mjl3V0VVMUpQN0Yxb0dyL3F2UGhF?=
 =?utf-8?B?UWRvckQvejZ3SG5MUFV3MmxOY1VoR3JNL0x2U3M5L1V0bGlGS0JpMFBZcUdT?=
 =?utf-8?B?Zjg5SCtnNXVrVEZYVFVGYUJwMWZoT2lkZTJ5V3hDNEt1TUhrK1JXM1EvTkZJ?=
 =?utf-8?B?bE52ZzhwaEFGc0dNTXE3R2VHVExFS2h1M0Z0bWJHNUZaWWp4cFhhOEhiT0Zm?=
 =?utf-8?B?Qzd0TnRkUyt3QlE3Y3Z3ZTRZWHltVEJUUklTMGpVaFBzRzQ4MEFjQS9HOG5Q?=
 =?utf-8?B?YnJDbzZ4WXRJVjQra0haUFNOdzFMZis4eEhTajl4enZFdW9OTjd1Ymk0UTJ1?=
 =?utf-8?B?WVZKbWhzWThEMWUyUDE3VUJBZjl6THBpaXBDOGlVOVhUV0U4NzR1NzdNbjRR?=
 =?utf-8?B?ZklESGtkMytNV1E4bmE4YytDeVpPcG5QaW5ROWx1T1V3VG9hYWEvdlg1cjlo?=
 =?utf-8?B?cVI5OEpxYkp2cko0LzF0YTRDQ2k0S2NYWTBjYlVNNEVpRkNRcUZ5Q0JWTEh5?=
 =?utf-8?B?NWJFL2U2YUJKVmtzd3BnbDFmdVRnYUgwbEx3bkdrQUZMSXdOemFLQkM0WHdE?=
 =?utf-8?B?VjhVUDB5TGIxWWllWUtLWUJNVUw4eDE1czRpVGxVOHV2UldXWWNXa0owSENG?=
 =?utf-8?B?bHRIQmdsSkhvZDYzangxS2xxcGV6bEMxcmk5Ync1WFVObnptenhVZ0hXWG55?=
 =?utf-8?B?VFI5R3l4Tit0ZEtseW1vcDBDNVlmMDNseWZtSWp0OFhEVmV2bWw2M2NVVXg1?=
 =?utf-8?B?UGpUTWJNeXJQc2VyNnhUSWxsWGsvYjBSOEpjYkdGOHY5czZZbFRmY3RBTENY?=
 =?utf-8?B?TDlvNzY1Nm1yWUtEWHNXNzlwZVJ3a0Y3KzhlbnVZRFZWU0RiR0ljRFgxaTV5?=
 =?utf-8?B?YWhZVzhrclNDYmFESVprU3lHWkZoSkduaVVwWDNTQkNJc1JmWk1mWEkwekJP?=
 =?utf-8?B?VTJkUFplYmRxbWVEcW5tb3dsYWJZc0xhWGhtNktZdlZiV0hZWWJpRHA2a2FB?=
 =?utf-8?B?Znl4MFBsemJWSGM5d1ZtaXhySWRJaVpIUVhYZnV5QUFtUGJrUVdMMzduVmNz?=
 =?utf-8?B?YVltZmtqMGNLUW9wZFBBSHFMSkJveit4ZFFMSllyR2ZJVFZFRnRrZEM1SWxn?=
 =?utf-8?B?VG1ZSXkzaXR5a0NRSmFpVTRLUE9YYVpyZ1pqaXV1Szc1alhmWDc1NUprSmNX?=
 =?utf-8?B?ZGlHcjFvVENPQmEwNGU0VDJZa1hucDdtb2VKQkE1OVVrcWhYM1VIcFJGWTll?=
 =?utf-8?B?UWpMMWhFeHQreWJnaTlvV0NqbXZGVHlnS0pOamh5OCtKWnp2ZzcwOWpUMkh6?=
 =?utf-8?B?eXc3WXJyU1ptRHZGZm1EdmRCZHRuR0YyUEZKK3lXdDlua1V0bDk2V2dSZWQ4?=
 =?utf-8?B?S0UzQjdyTExaNEdYUjJ5ZHZEMWxTWEl0NVYwS2d4UWdCdXl3OVk3bThObWxB?=
 =?utf-8?B?UTJMdTlXSnZGUE5SOURCSTdQMDk2blZCQ2dLakVxdGc0YnQxb1duSStvK2M0?=
 =?utf-8?B?VXBYMnpmNzV2Vm1FWEtadU85TlcvdHhodVhoZTdNZkhZbWNrVlp1SnpyM29R?=
 =?utf-8?B?azlHdU9mRjhUa04xT05hb2JDU1pZYzVEYnNRQTY5bjVVV1RUUHpsNVl2ZWZC?=
 =?utf-8?B?SVVYWm5DSkNra1lGMXNxMFBUQVljc1Y5UXNYMHZjOSs1c05RcDhFYXhvek5G?=
 =?utf-8?B?WXUwcEc1bVh6MGxsOGtxK0NWN0JrL3pkcU5Ka1ZJcjdWYnNBVkVrbVA2cTRl?=
 =?utf-8?Q?c3Z47x8If9xgI7yI=3D?=
X-Exchange-RoutingPolicyChecked: viMSwVcqbYMheSKfAQZTDEQJu+7v3/ALuTvs1SIofQAn8XxFKaK7Ixk19sNCtOuzk+Wm5Fza1gRWsSpXQAfo4HK8uUqxZLuyKtIRFDLGDt5tmO3t8ZSnnN+s0gp6EX6tNnPjqPp4LKf2cStXGMM84mM7SIm3cGqq1xNKAxekAA7sXzfNcAElFDf2x8SN2kCca4HKGMRRXcchu8m9SH3yKkg7ww9BuRZzaV9ogymx8aj6TZ1KhCu7noaWzMUsCAZEW3TFXF5wvh0CJoL12tUKSXYRF5KtGG8eWhE711OuiBoPGyKA7JRUC7A5P3q4ggj3eQ0W8cNXUbRqJDOL/e/gMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a84b761-64a9-45a6-23a4-08df3bfe5faf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:06:22.4955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYL0LnQa4a8lIznO3/Fgzlsq+oL1LMIlDanvkm3Ro1Efhcc4JmGNkGmuPejHhTmRoMFdwspgzrjYFKVDkgBSnE9I/iTZM6rpnrHTmeWukCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 09:47:22AM +0000, Anurag Mandal wrote:
> ice_dcf_hierarchy_commit() keeps a copy of the bandwidth config
> of each VF, and of the TC nodes, in qos_bw_cfg[] to replay it
> after a VF reset.
> Each commit allocates new copies without freeing the old ones,
> and ice_dcf_uninit_hw() frees the array but not the copies, so
> they also leak on close and reset.
> 
> Free the old copy before allocating a new one, and free all copies
> in ice_dcf_uninit_hw().
> 
> Fixes: 931ee54072b1 ("net/ice: support QoS bandwidth config after VF reset in DCF")
> Fixes: 775a25a372f5 ("net/ice: clear QoS bandwidth on DCF close")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf.c       | 6 ++++++
>  drivers/net/intel/ice/ice_dcf_sched.c | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
> index 09fcf6454f..c2b557d0da 100644
> --- a/drivers/net/intel/ice/ice_dcf.c
> +++ b/drivers/net/intel/ice/ice_dcf.c
> @@ -884,6 +884,7 @@ ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
>  {
>  	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
>  	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
> +	uint16_t i;
>  
>  	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
>  		if (hw->tm_conf.committed) {
> @@ -919,6 +920,11 @@ ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
>  	rte_free(hw->rss_key);
>  	hw->rss_key = NULL;
>  
> +	if (hw->qos_bw_cfg != NULL) {
> +		for (i = 0; i < hw->num_vfs; i++)
> +			rte_free(hw->qos_bw_cfg[i]);
> +	}
> +
>  	rte_free(hw->qos_bw_cfg);
>  	hw->qos_bw_cfg = NULL;
>  
> diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
> index de28019c5b..f8755c7dcb 100644
> --- a/drivers/net/intel/ice/ice_dcf_sched.c
> +++ b/drivers/net/intel/ice/ice_dcf_sched.c
> @@ -813,6 +813,7 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
>  		if (ret_val)
>  			goto fail_clear;
>  
> +		rte_free(hw->qos_bw_cfg[vf_id]);
>  		hw->qos_bw_cfg[vf_id] = rte_zmalloc("vf_bw_cfg", size, 0);
>  		if (!hw->qos_bw_cfg[vf_id]) {
>  			ret_val = ICE_ERR_NO_MEMORY;
> @@ -840,6 +841,7 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
>  		goto fail_clear;
>  
>  	/* store TC node bw configuration */
> +	rte_free(hw->qos_bw_cfg[ICE_DCF_VFID]);
>  	hw->qos_bw_cfg[ICE_DCF_VFID] = rte_zmalloc("tc_bw_cfg", size, 0);
>  	if (!hw->qos_bw_cfg[ICE_DCF_VFID]) {
>  		ret_val = ICE_ERR_NO_MEMORY;
> -- 
> 2.25.1
> 

AI review flags this:

The new free can race with VF-reset replay and cause a use-after-free. The
reset worker calls ice_dcf_parent.c:152-153, which passes the cached buffer
to the virtchnl command (ice_dcf_sched.c:681-686); meanwhile the hierarchy
commit frees and replaces that buffer (ice_dcf_sched.c:816-823). The reset
worker’s vsi_update_lock does not protect the commit path. Serialize
replacement with replay, or copy the replay data while holding a shared
lock.

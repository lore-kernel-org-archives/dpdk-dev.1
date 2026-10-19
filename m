Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3267609A55F
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aTYJVFTn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23E2A40297;
	Mon, 19 Oct 2026 17:13:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 47A264028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422796; x=1823958796;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=So9NRaESo3iVQsigLPViiIcyUKW+4fqL5MRRBSGDIzc=;
 b=aTYJVFTnDemmvEmrPNUOeS5TLnEImV5TEwuBw4qz+cYoeKFVAKXQuy9J
 0jnvMQ07E9eGQxa8i6IYHdhBzHaZzJY6Fy4k7ZnpGCoj9INzYQvLJ/sG2
 qicZaX1zEulVltFu0O2dkXJQkg3ffcKkcgxYqCldmrpVwU4TnKk4Q5WlJ
 zJ5an9YEGnV0/uPTeMZtL9Rjm7iy0LkvJSumhFkszRvzBgRb5pI5MVjz0
 0CukbOVRZvlXip1cNHm29x6+J6euqFhz1hOAtmEzimdJB+UAX9gFarGPx
 N5PfhkalN0B1c5qGpbOreV6cenq7msLOp9Ji9WJhIXGXfaE2+J/kRjKSk A==;
X-CSE-ConnectionGUID: 3C2LoiZdTpWeRqxZ/nKfLg==
X-CSE-MsgGUID: +MAKodQYQ6e8Wc3Iqolg5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1001157"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1001157"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:13:15 -0700
X-CSE-ConnectionGUID: sZIqiSDxQOCkFmci9nk7jg==
X-CSE-MsgGUID: UqHuBupRQD2HiRq4wnwp3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2611215"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:13:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 08:13:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 08:13:13 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 08:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLKhnJfkvoPcifd8D7kBozL/y1t7dgyJTshII0z+V6BRyYprI7fYgtH+mqSlnjTP5LuiYIlKM6FZpRNburcnMe8ZuhApTp5Thi/ARDyi8ytRs6gY/czwtQ+GTxwnwWUDnqtv758K/8nCHBCo1ULW418jUh085Ql+Rja4++aex31mKpWPtK/TJLBgIU1pXUNmAnxEoafZ1oYqAw5vnD0VkKl3sHalBHBPMCQYUxdAIMOWnTspjOU5t742Tp8LxXFJqdpBVXlcqo9juiz7MA/eU+ZmSMaKcNBCZe78sMqMsFNxyXzbeyhUZWm0OYV70qnpZCQc28a4JlfQIVzqy/yPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gl+xXTOAMg+547zdVLxt5s8IA/LUX3eQlA3Gsuhs7I=;
 b=QMKlSjrEbVtVDpFitFj+1H7s5CBwldEoZg/zkZfQCmLboK/H7kj+khjaYK0xmxHYg755BsAxH5DG7nhJodX8evFhIwvZcoLKWyD6d4pRC0tlWdtT1Xhaf3RWfbqPFpo9Xmp3oWUjGi0I+T3g7HMdIys6qlFeubl0SdKw1QGsdcvUH3fSk00gPEe6aK4AHtvvQLcf1NsZgu67lPfkP+PbHVT746/k82fJziaaxeut7YdpezW0y2HTzN7ESDY554pMd+/gf7ptIom/aP7S0oYTjplYUfIYPjbE3ONHlGuRo+ICBymdIbVuXxLwwwgkfspo6NksCxGgwSIbaG3aEed+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 15:13:11 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:13:11 +0000
Message-ID: <21b6e6d3-18ce-4f84-85e3-27a4abac550e@intel.com>
Date: Mon, 19 Oct 2026 17:13:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] net/iavf: fix memory leak in raw pattern parsing
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Qi
 Zhang" <qi.z.zhang@intel.com>, Ting Xu <ting.xu@intel.com>
References: <188036eb92e560f7960d8038233dc04ee40a6092.1792422213.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <188036eb92e560f7960d8038233dc04ee40a6092.1792422213.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0002.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 57038a8a-e5ac-43cd-634b-08df2df37d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: uN5nCxt99fee2ShSDvp9TtEpXd/3xxHlycWLhOJ73QO9teQKiRrF6wA9ipAXEGbZGwMKhEOINOMSYmbl5sgs+Un2jeGdcmtDDvteMwkQr2ZoaSatNFDbEH7By1zGqmOtGHs3SWZ/KNHT6V/hYvkLW1hQfKDOrCJtrOJAgl91/6/DDWuWjl6yNPPeXzfpYgsCC8WHEgaQto7946bXHUFSmiNA4J/6aZewFfNde77DmfwG9Ey9tEnDOYCH9rQawwDeT/R+XbmFIU0ZOJKrxzE824qSquzdiOdeY1Imb6+NwGmdDCAJ/vHMeiu6afF6CDrcHsuaqYGYjgCqMDW+uj5NbkL+mHRAnIesI0MB2L9ve6XNt2moork71u2JFAX5O/reQbwqiIvFroeYwTzfd+cRNXgl/qMqzzcPyJExELwMsKxnT2EeN86lxgJgn8ihxqD2Ss/0FWA0HuQTy2gkrr3Tp9qw6wLoLcDJDjEoE5nWZGVUq42e8JAv/gbTJrKD2/XkK5xUqYLq2bzPNsOjVu9d0XkKXgfdfLzGiRGMBM41px1K9lL50HiA8JPdtEvi+b3lweJd4LWEXy3y+5rRn77+xafLU5TXjD6zByCC/Z9d8PDnECUmaAei5ly9fx89FlOvDqwA2lkib7ayw6e1ZrRwgt24C4NsEQamJy7Ovamk5r8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmlRdkNNUEFwV29WdVhFeFIwa3IzdkNYZWJtYVlSNUp2Q3VCN3dOOWw0eW15?=
 =?utf-8?B?dTJkSDVtSUxCQXBnZUgydlpmaXQ5cnc2ckg4VVZXbFJPdWFpWEhia1N0VU5v?=
 =?utf-8?B?UUI0aStvbERhWkNud3dtTVVvdkRoOUlKY2puM0VvOTdVTW9ZZkt4VENzT1hU?=
 =?utf-8?B?c0xZNXQ4MFNHMTlSbkh3SG5qZHZmZFRZOTBHKyszcGFyeXliZlBjYWR3U04r?=
 =?utf-8?B?ejVRN3dYYjJvdHdwVkVRZDZTd0tBWm5Ic0xqVitGOFJXbnhOa1oweFltVEM1?=
 =?utf-8?B?ZmQ0RWxMZWZZUy9yczFVVU40OFJPNktRMk0vN1RINmpwb00ybVZhSkZ1QnVl?=
 =?utf-8?B?SVF5M3d3SGhLTDhIcUI1NzdFNkI5ZDhYK2VPcGQxWTlUVEJvRWJUazN1aDJB?=
 =?utf-8?B?M25RaWFwemRjMmp1cjhvRU50ZUc4akNPcHd0cXA0NXVCVU9BNkRJdlFwTWc1?=
 =?utf-8?B?MWc3ODdKRGZhVUpZbTlOTzJmYVZWcFhuY01Nc3RzcU4yZnZWM2dOOHRPU2ov?=
 =?utf-8?B?VzFnV0pEV1JWSEtNNUtQak5lV3F5dHhwSytFZkM5U25Hdk00SmxSdlpvU3ZF?=
 =?utf-8?B?b29ZWWZuQWdiZjV2djZtenF0dmdoS1NmM0svZ3VDUlVLZktkZjdubStRaFBB?=
 =?utf-8?B?OHV3RDBwbHZjUTQ3aGUzMXZKOTVSU3poaFFsWGVka3ROcGlTZEpvdGtlYmVC?=
 =?utf-8?B?QXpUcjl6WmY1dVowdU9nZ2VvTkZVMlJPa3JXUlNCS0x0WG1SMGNhNElXZ09x?=
 =?utf-8?B?UFlPY25lSndBR2VsdjZtMGNYSEtsM3lNTUcrcksxeVlEdjVVaHVvSXNRRE9K?=
 =?utf-8?B?MFZMZnlIbS9Ec00vM2ErOWhsU1dMWTdRV1AyQUtyZmtPVkxEQktoa0NqWTRU?=
 =?utf-8?B?bHNSZ2dOdGRWYWZBTnpWUUUzT3VTWDU1cG4xNXJmb0I5dkVIS3NUaGZDMlZl?=
 =?utf-8?B?NXhtc0crYzVzVC82T1hEWnlGemdjeERzTzZyUzF2Uy9NMW1pZCtFTXRNdjdE?=
 =?utf-8?B?RGprK0prczJqNFgwTEJpT1hxWWVHZmlkRjVzMXJzdUVyc2VyUXFCTFVuQ1VW?=
 =?utf-8?B?MDVDNEg3d1huYzM0aG1yZXVRMjRHTW45bkpkbGRDaHpnNmNIdXh2TE5XZCsy?=
 =?utf-8?B?QXRvN1JXVlN0Z3oxWWw4Z1lNNTRZcUd3VVBtc3krRXY4Ujcza212UGFtcngw?=
 =?utf-8?B?c3pnaGVoRkRiVW1pd2JDSlk3TUpoZU83RHZuQXJRS3ZkYWtTeFF5MnNMSDEz?=
 =?utf-8?B?RC94L09RTVdiN0dqSjdhNVMrbWZZT0g3bm5HcFJFMkhRK21JR3VKSFY2aXBC?=
 =?utf-8?B?ZnFmMTlQUjFyTXQxTWU5enpkNXgzc0NMZU9CNVlUMFRRanJHY1hQbHdPYTIr?=
 =?utf-8?B?TmY3Unphc3ZxcG5FT3dVQ3RZMS8raWJKUzJKSzE5eVNJcWNiWlhFd3JjUUJS?=
 =?utf-8?B?Z09uYjZxUG9lNE81QzJCM2N3Y3hqVHdtdE9oN0htYnhrQ1JnS0JSQ2pXT2Nw?=
 =?utf-8?B?aUN0TkhCZDFqZWh2eC9CR0FLMXBIV01iNGxFeFI2Q2g3M0t0NG1vVFV1K08r?=
 =?utf-8?B?SWE4MFk1c2EvMjMyVldaV0UvRDhSV1hwTGN5VUhYNWJiM2VLZ2J3dzJYM3BN?=
 =?utf-8?B?bEJkWk9QT2creW9ScVgwUGNvdW9YVDlGL2FuNHlJZklETmZFUWVKeTBubFRl?=
 =?utf-8?B?OU1sYUdhb1QyQnkxMlZJWG9DYVRpRUFYY1lqMjdjY2NWY2NQK1UvTk1sVmpq?=
 =?utf-8?B?VFJ4eFRpNEJoMUhmU1VHVnRncmRkMzRuVitIYnNOTlhVR09VR043RUJmMEhL?=
 =?utf-8?B?bVFVTHQ2V2dSOHRYUjFDWFQxSnRLNjM3a0s3WHpuc1Avd05ndGVEUVpiZjNL?=
 =?utf-8?B?NXcybjVseDR0UUc0RUZyY1hNNmR5cDJNeFQwNUpJRExLSXFrSVhsNzlQczNv?=
 =?utf-8?B?YVpKR3N1NDR2TUpqVHhpWkNyT3NKSi9EQWJhTlkyY0Z2dElIN2Nyc3ViTmRw?=
 =?utf-8?B?Q0ZJeGQ2SXA3cTZBdjRBcGh2S3cxdUZ2U3dHT0pDMDJQMDlTUkpQT3V3dWor?=
 =?utf-8?B?aHJUUTFZbmNpT1VQSG9GU2lZVzRVYUVBVUpCanlGTjZUZ20rT0tXd3hTd0JS?=
 =?utf-8?B?SnFDL3dScm5hei96TStZbGt6TysxcmxmQk9KVjRwdS8wWldqY3RicTY2OStq?=
 =?utf-8?B?RmlGT3EwM2ROSkR5aWFDNlBCc3k0cUpUdHpmWVZqeVpvNENIeVJoZzB0NUt5?=
 =?utf-8?B?ZkpkV3lvSzVvZk5nSEhOSW4rMTIzM083OHV5RVl6SE9abjFpWnV3L2NDeHRS?=
 =?utf-8?B?Z1dDWnFGR1h1N2VpZnQrTmFIdWtZUDFqbDArekk2dlVyUkF0S0FMT053clFZ?=
 =?utf-8?Q?PcQ7i7s+OXWdNEbA=3D?=
X-Exchange-RoutingPolicyChecked: K2GvHKjRQNYLUWgklW14vCLr20J3TsJF5F5FJvsyYHVyidci3dgNCQtfaLTbzWqjrIUdQ0MAk20h3keshAfE64/Z4gFMkA77y9Ey5Wh6QGRT/qtlWPLW0MHHpIaVhjX2tMmh8/OVNY9d916JgUXqsA1FGRbjQ7aa1uCDLqESuEgFKIMKhSLaOGsDmR/YvMT8Dq9Vco9ORAIMWp3trtJloFviZTSNC/ilpqjXkTo9IcflQdAyrzD86Qy49xxfzEJZqdmjtGkymTC7edUT2uSL4chXiLwL4glfeVl2rRVuV90ygOVAYXRNFou+4GSpUr+TTxYQcM1VcleouVp4lMqAnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57038a8a-e5ac-43cd-634b-08df2df37d30
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:13:11.4456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hpIsXXhlTSTg4LvGTRN6hEJytRZQEL4dVA02zC6J/3eSGIE/ysIEH3l1iEG9le4krqMUTyZb8+8U3fq39hwYsOVfkjhzjpTnHgR/iOolaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 5:06 PM, Anatoly Burakov wrote:
> The API was removed in 92ef4b8f1688 ("ethdev: remove deprecated shared 
> counter attribute") However, it may not be reasonable to pin a Fixline 
> on that commit because that would imply that it *should have*updated ice 
> driver's plubmbing to not support shared counters any more, which I do 
> not believe is reasonable. I'm leaving this note for posterity and in 
> case it is determined that the Fixline is needed after all.

This was accidentally included. It belongs in a different patch in a 
different driver, but `git notes` doesn't handle rebases very well...

-- 
Thanks,
Anatoly

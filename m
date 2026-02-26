Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1100FD8FE1
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 17:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0302402B2;
	Thu, 26 Feb 2026 18:24:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 28F8F4028F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 18:24:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772126648; x=1803662648;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+FBsNEjUHjAEoFwh8JO+A2spRwWAi49I43deyXYPUkA=;
 b=SgmXQhynwJM4Lxe+mOTxvNKh3sQIVUC4SvC18qZak58CYcJBzarUoAgR
 kml6PyHKgCYZz98fa52wLIYTsiWoUD+CMCVYf0L/AF3UmOf236mvimu23
 fF4zy/4IxK0+SaqDk2H19qqJhW+AeuNNbO53glnX45Gs+O135VH/ElLBF
 nUVSH3PuP1r0+zm3qSYAGYmNSQzBaT4pm2Sfx7tKHCdI2X8tsEmPH8pOE
 bG8aoWcFuVJZOf09lLySQJwbsEwE5ZxOWqfB510rSmGc+uwJQl53MiljV
 eUQbgt8czNxdocwOZYKmRjLcehBBrEKVdZYe2UDU4lSzXse0i2D/aN8ij w==;
X-CSE-ConnectionGUID: 7VgwuEC1Rqit3wwdHRn+8A==
X-CSE-MsgGUID: 7xp9QyNBT3eyzt/KnPa0RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72896967"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="72896967"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 09:24:07 -0800
X-CSE-ConnectionGUID: EXcJ0floSRePr2w6xMsysw==
X-CSE-MsgGUID: OzJHniN8TOSPb517E/89jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216759134"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 09:24:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 09:24:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 09:24:06 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 09:24:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0kQFFF4gBShb/XeV3xWREoHPkXuJCXWw2ChqboqWXYtoEqNF8IzdWUrjhflc0JQyUxgL3XuYifAa9e7a1gb0pw3w5TaJGhA+d5jGrnrilnAwvR7d0D4Cw2qQSdbFmuavifYCW/YvI3PKyPiTDX+OcytsGHHoRT3h3ucX5ugY9S2izGLmdsG9ppqGnUKo3o6JAxQS13hVzbGuwtGKgaGjzgS0+HMwNpoymNnRwzu4A8pnSuSgkFCkChAkXa11R5D219WBoQLOyJLtHvpkvArwrHQyO/NahWWYmcWcLi9yc/+tcN703iz365hXatFCoWOjiPJ7E0QmiAY+FxJjFSU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xc6eRlg/s1T66HxCCHTlAlbbjNd1zCtN7QtB4DXQMU=;
 b=oO/BEt3xRNWV57Leg5xYXbemG3VGY6L4901Q1DXXkFiWQGAVvYjlRWW7t6uQaNPkGEZo645AfoJPHxb2qE8r1s/BYVY2h1+4KPnN+9rsZYHEGW6arX3RKeDCi4bd0Q6fcfTPQ0061eObCzpk0STJgU3T50w1eA5v6BJgAsPLADEp6YGEuAivjd1JXLITXXsXIhvgQH10EG59LvObpdg8HTxbEzXPeuYnrky+Kfo7/AgP5OUbhP68goDsIEMxHZzAeWoYEjzDeZiL3XK3/vq7izMyoti1ztoGsdJuXJZHrnmj2ZJ5rUdkLHsXjL2VZmTyVvXPjtJtc7SLmNH6Yoyb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 17:24:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 17:24:04 +0000
Date: Thu, 26 Feb 2026 17:23:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v12 1/3] cmdline: use C standard library as number parser
Message-ID: <aaCBr2xw0PBAJz7S@bricha3-mobl1.ger.corp.intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: b00bb730-2e1a-45d4-d157-08de755bd712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: HhVa+3jAottbHU8NfEPTDYlOMYmBlEFr4ZHE3bVyjS2ZXKYta/+nBb0VR/HP9/spfZSyWq4fTKO1svxVFJ7JkxsNt+FBZYWgbBhimFUD6zfikwTNuAmbHl8m/TqOYfAMpwJrDIAzmA8BkydukHKIm2XGx8V4p64WqhniKf9vGGdHy8tx5e39q3OWaWF3xkLZrllYu4BPlYGn+PyOYlnvpC1uwxXxzTreBzw0DnOPKVOK7SaExcGi6G3iOvT5v3zbKlgFr+2OGFv+FyE1Lbqg0+6C3f+mnW0ONEMqS63YXJ2SkI7cWKjQpw3zRuQ/71aQ4tvX7Xnh4NC6XQH36N8kuCizASpzYMgBbJD0OmmWs7jFb1H0GH55PMnJDFwd8cC5H2E32pEqJEozK6geO5yZwO7XYYgYK+jug/j94D8HN+31C6nsZ7E8s8HHHTJNM5YA/hax6KGep1JiMnl4b5Z4BpYREvlhp7gtRQnAESqrPO8c5yuSFYqhtuj06Py866M0ukZ6X3cfVuWMY2xJkv/dqNSnqEnTkRw+kFt/21OH2Y62UmYMGhFn9RjyCrS7U1upgFKXCnnWwLiRF0tsX/04lP1KudKBdx9g3kZc+9juIJ/3RzBbUeV5Ry3J0mTwYMxg9JuxfkD2WpCFYOuyz4U3u30E2FwB8YqNxcHnc9630K9f4N2ulCz9Qfs661+esk3IBMeGMrJ1pa1vE2LYpzsB3dBgwk1Yi8/b/oZmK75vKCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLSvwZgEwGCrgheGtybGnUnqVHV+ojtuRu3fBXU2LX/lG680vXV6w3ldGgc1?=
 =?us-ascii?Q?IZXlhL0XilGfgz7iPeF9hz4khpeSpiWViyWqE2B2AR6BWLlc4m6u/62kKi1b?=
 =?us-ascii?Q?oo2UPyyWbw1sQtsVFRtMwCMfHbpGZ42Yc8l8uP8F7/GfYvuwzlStkJ3fp4Sw?=
 =?us-ascii?Q?TY8nUHGLLbFPZ8ZcRGRRJjJtVVd+uJ1Xf7UJluBYQg24k5QSccRhsjH4DYP1?=
 =?us-ascii?Q?Vot6nt1orwIzqez9uarvd73YSCE4zH2tWwjYKd6EygYdo26dvE9kiKwHjbDZ?=
 =?us-ascii?Q?U+Te2IKBrAQVlPgZqR59kiFzxZOWAfFTXbZyhFEb5g1oQboO3kN7lopmRovP?=
 =?us-ascii?Q?74ro6LeNJlgmxX8Felz6cc22SvPPSFYoTnzSWQgLWGhXnWHYVUECy5uEJjZj?=
 =?us-ascii?Q?eMR14EGuaL3GO7bWfVJ+XD8Z67SsCfwoddBy9SSzc8F2kuoDO6J60b4OyNqs?=
 =?us-ascii?Q?0jzrDv5sur9cDQsNuSsohaHXjF1PtzH+4AkDJLff027IAGbnR5QM+nks8VZz?=
 =?us-ascii?Q?+GE6cLdmckdrLvTm6vc6p7hvBgzimiFK+cem28VijIteyP4z0/C1hMV+xYLu?=
 =?us-ascii?Q?FWQZvEnXlXP6rsPyjli0C96L4oHBdeM884I8sVv/ifRB9koYeV8P/IPqyNRp?=
 =?us-ascii?Q?dmC3ruoD2IB3ZyTQWBHH9AXc50+Edg0/YBrcJ2TYxQw7v7rXWDbMRf2KzX45?=
 =?us-ascii?Q?TKZrwAGJFuEu0/H4P83dwmIDlh/v9BC4js0xY5n0PxoW5KycAsir78rOHYLm?=
 =?us-ascii?Q?wAnb+W9Dzu87VnZbpiPuIiLKaRcdiEx+ugJXkLSdkykdc6q3+r+baWVHiD4I?=
 =?us-ascii?Q?on6USmJ/FXf5BcV/nLTrotYUEY24wDP3u5Fz2mSyl0+FuHnKQ8qH+3HrIRFt?=
 =?us-ascii?Q?Pbetf+72GBXci1oYPC34qScSzNHBpa7QR0DavEFbTmQ197LKdVnFFhcfnb9D?=
 =?us-ascii?Q?TowEE7FyRaVFgRayzlaTcWPCEfcJwsClQ+or0tSuJNoQp6JJ7CmUaRJRDvhf?=
 =?us-ascii?Q?1ewzxJUw2qGx6gdKRRtNcPjr1xJtk1EBHNOKjyXE9Xl9yhh1hnrACmUeBdNE?=
 =?us-ascii?Q?K1EE5Gp2yEvkSdJRP+P4U2wh8OMfSZNZH/3IVRXX8LPP4zyE1zRUt/I4toPd?=
 =?us-ascii?Q?AXVvqdculsLmrFdLLrW6FpEj1GH9LyA98tSmXOCmoLlswEUdlXtuDERH4gy3?=
 =?us-ascii?Q?Q0SydorKuRHYmyqa9fislufA5KOJlaY/8VxJjVJkJhgYw6mK41+4v9xSvYMN?=
 =?us-ascii?Q?9wkwi1XAirPzcyP/qbVHrysktSaNHjKWKrxfhk4GCnUuWgvi86KHUvIU+jH8?=
 =?us-ascii?Q?nSxGC1Wo8APmq+sZ4Bii7DWm3ABZAh7hcqxPhQxNgVr/U13vsjCh5WznVZER?=
 =?us-ascii?Q?5quObUIB8Bfe0PtwDrXSxYmv66ixhF3aSUHMSYVH48FMRgSWmuGN9dhwY7VC?=
 =?us-ascii?Q?yJ8HW8e88vNHzpWsxy+q2zKGLVdijzQS9zYeO38xKKemwoVj5yjn8dt/nv8D?=
 =?us-ascii?Q?jFC8lNqj8tGYMptVQvA/dN6R6uFTBHy/zDf6f55IyvztImmdJKComlHS2dYt?=
 =?us-ascii?Q?If+sieB/1/WBomDo+ngvoOmPG6/uRQZ3ucVc3PVNSsO/cT7tpXd2piWR4U33?=
 =?us-ascii?Q?c+BimmF1Q8/FHMtk/h36koU+VyzvitJ4elVgHP2cTf3FGH1rfg6ukr8btv//?=
 =?us-ascii?Q?U1ixRVW89IY4Vu1oimmjQvRyT9/N/5FmMBwHxjeqEgNfVqitSWaJ4tGQ0Su4?=
 =?us-ascii?Q?Lib0Yq6EWG5kX5mCNbZA1uZzp3L05G0=3D?=
X-Exchange-RoutingPolicyChecked: Eo9nzEYVUyoInTWFPB4Wk/8T9ua/lGp/Ngb8kOVA/kYoVVTStBnMP88B+ry2RhC6wdIZG4fq7kP03poZUsjGaMgJkdXsi3mlgQgQqvQgnlClOXmN3n9uGHszvKTlut8PI0004yiQzj0JLjgAT8L3umNN21XG6zqSfNrQTeULSh83z9DX3R0DOMv25cr9vsXNNVIre+oV+Ug++j/8DjvLZ5agjvT7wzi4Jut/0lVviS6Bz9P0h60xnyu7kUbm8COeQi5zbET6eTMRGLYqrcd1enpq8MIlf1dh7A3ioQYxvW1zco0wqUUJHmhvfnVtL3ScXDX0hIU2doIvByeXKD8Swg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b00bb730-2e1a-45d4-d157-08de755bd712
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 17:24:04.5853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owK/PFlJoMLhhy/UrZSiJF4ymN/978esXHtDd2HrNgsB2xCem4vWIV72c9MRT9faLY6azVkxUL1Y+3PfOhUirWpbpTz75DOS2GqAwmAEC50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
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

On Thu, Feb 26, 2026 at 04:44:48PM +0000, Anatoly Burakov wrote:
> Remove custom number parser and use C standard library instead. In order to
> keep compatibility with earlier versions of the parser, we have to take
> into account a couple of quirks:
> 
> - We did not consider "negative" numbers to be valid for anything other
>   than base-10 numbers, whereas C standard library does. Adjust the tests
>   to match the new behavior.
> - We did not consider numbers such as "+4" to be valid, whereas C
>   standard library does. Adjust the tests to match the new behavior.
> - C standard library's strtoull does not do range checks on negative
>   numbers, so we have to parse knowingly-negative numbers as signed.
> - Some C standard library versions do not support binary numbers, so we
>   keep around the relevant parts of the custom parser in place to support
>   them. However, since those libc versions that do support them also
>   support them being negative, allow negative binary in our parser as well.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v10 -> v11:
>     - Fixed all checkpatch warnings
>     
>     v9 -> v10:
>     - Fixed commit message not reflecting changes for v9
>     - Reworked enum range check to avoid compile issues on some platforms
>     
>     v8 -> v9:
>     - glibc 2.38 supports binary formats (0bxxxx and -0bxxxx) under certain conditions,
>       so in order to ensure the same functionality on all glic versions, add support for
>       positive and negative binary formats, and adjust tests accordingly
>     
>     v7 -> v8:
>     - Added the commented-out out-of-bounds check back
>     - Replaced debug print messages to ensure they don't attempt to
>       index the num_help[] array (should fix compile errors)
>     
>     v5 -> v6:
>     - Allowed more negative numbers (such as negative octals or hex)
>     - Updated unit tests to check new cases
>     - Small refactoring of code to reduce amount of noise
>     - More verbose debug output
>     
>     v4 -> v5:
>     - Added this commit
> 
>  app/test/test_cmdline_num.c     |  34 ++-
>  lib/cmdline/cmdline_parse_num.c | 421 ++++++++++++++++----------------
>  2 files changed, 248 insertions(+), 207 deletions(-)
> 

While I realise there is some additional test content here, I'm surprised
that replacing a custom number parser with the standard one doesn't
actually result in any code saving. The code is as long as before!

However, code size is no reason not to accept this, so:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


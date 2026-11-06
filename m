Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA42606D806
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDohNgBC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCCC0427E4;
	Fri,  6 Nov 2026 13:10:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id E2EE3402B8;
 Fri,  6 Nov 2026 13:10:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793967004; x=1825503004;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uDwOAsjWn1ncbo5zxfBdITRKZ8J9WTbX3zqFLo2fOV0=;
 b=VDohNgBCsVYs3PSqz7u4bWuxtehlDWwPKnp1TNEI54tMzZ6OSF+KbGgw
 vLE0s2nMLYOsdPdyRb3hIeN+SGtQN6LND3n5tuYg3Mjc34GUo/MVjHPFH
 lKVARf2UPXwTMcvpUgtepXiNfkKcgp5GrAZfeUnOlBvTfjxQrkfGTSFZ6
 +Xrm1jBmAtu8hVA68Lt5V9NDoeQSfDq2+pmjPHeXJzYZDIcU289kf7g6D
 VtABqY+CkAH3c0NL/BhFmXzVGYOYTZgI1M5yfrq0+dyj3yuChdi+HzSI6
 ADb4TjLUphc0Q32sbQxDDEZuUlo2oYtboqE/zagTDDYHAx21LfLTIku1B Q==;
X-CSE-ConnectionGUID: S0lytddHRfyH6ukH8RTuZw==
X-CSE-MsgGUID: 8OjHb4QVQwalGbIueY+cZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2666090"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2666090"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:10:02 -0800
X-CSE-ConnectionGUID: IGC8VWmgTlu02okh+CNaqA==
X-CSE-MsgGUID: yBqwoCVmTFmL3vYgXhlOtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9015323"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:10:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:10:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 04:10:00 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:10:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0+nPHywS3NpTX9o50xJO7ppFmaRjZD3Iv/7KdQkXQiO/m5KL2ymjLODMCInjo53UCxHkyzjjsHwhjE1IcOfNgoeLTjLxrigj3w/CevV7y5IVpoD7wHFtV2cCV7qnDNY/IJlDElDNOjSV6YuOcafWERGdaLZplDQWtJu0YshnbMmgWShBAikNB7sjTQOIWPEUeyTj8Ul8wtJNhiFCvxy5nA/ZZi+lmvUZSU624cC1vfgm0j360bdCZujGv2D7sMjR88O0Z9kAqJQA7+tuVK7t54h+TYAgIB3InJjdBwnqdlyL7aOVg//Cx5vDC01HgiHwfpYI5iiOM3dgJK+78o+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QT8a9EgLw9iOoyWvHZY+cZoPmcVzSVoZOLM3mTc9bU=;
 b=i6uS+Hz5Y6dgbWlwkHv7G7ZuTCWw4iOWwJJNEJ9mylHtW+kYe2BsspSBjBbxVsF2L5xY/2OWmnkSK1lRhqbemR79KjroryE0lhS/2UxT7TnEGBnh9maDxckBqQQmTk/1xTo6mPVnsJ0oomEhDhb0Ga7V3ekZQbcoZNYB/IFpO905owGyKaZ/A2tI6N27Ss3gqpLjbvh1zV3UvAHRQ81ha9I7ewr87Qqpgf3xwBj1JvDlF1uaLZypVxCgxZfSG8xOPW/Cvchq+RRLSPT0aljegFKfoadHgdTTbxFKnKRn3+09V9M0j5lWk9wzQXOwO/TmUnnGgwCW+udJYOLkQJ2p8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPF691668CDD.namprd11.prod.outlook.com (2603:10b6:f:fc02::2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 12:02:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:02:53 +0000
Date: Fri, 6 Nov 2026 12:02:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 4/8] net/ice: fix DCF QoS buffer leak on commit
Message-ID: <au3B6EplzDaouOsb@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <60f664e30d258546613eb746fb81f67e897a852c.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60f664e30d258546613eb746fb81f67e897a852c.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU2P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPF691668CDD:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eaaa2c6-e903-4aa7-e21b-08df3bfde2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|4143699003|11063799006|261102123227099003|261021121427099003|261022113327099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: pCxlbE3j9PGrEUc/iBW5OBWu96z3wkaKw3IKCn+Vlz7DcYEMhBfncXVW5chOQFvPU3WRQbJaYywNad/ZoVbLsZXwAqGJ7J8tI1uMWLlCmxz3Omi+fQuCSti8ar6J46Bap5vU9AdK1VkcfTiova3H0EwcksXSK2RaadHVa7oiAwk1qojDbhGenG8zHZXA1EoHTE0NFhkUydR7vnpHF2NRWrSGJtJEU+JJc8Jd+Z/V2Bai21rtnIgntFSu3Ijd183cf9ZFd6BL3YSCn7IHD8SeQ/ZEKOtrfW46NIzzIEy+R3wlZPBpr7WPlwBfQP/rlhH3if4A3wkB/TKgIg7kuYw+e2uiP5S5z9aPSjHS1NxLF58OsYqYGHUspDDr89Wq1sfTeUjbrWSO0O/OeRf5i6lz4SPx4YbxOoyI0AITJMNAjP9QseUUbffR/uagsSACla/Dw3pu3/PBfy545c6XcKkCcQEc++sLeqvwFcYvWxJkHHzF/n5fBpKzeFDcsOJGbANWUWaAcbmrItFM45BV5aocGotxn2TUR41lf2E/EFiJFPcVfBjS6kwHxE4pEUDBXIKDZxyJfrvaxtDOjIcWk/AIrNVrn+pCmgP0nA/t1+IcimPHRi/TJle78hgPD8rxdm73rMAFD2Vjzuj8TYvx4ZRHvoenwyIoyBL9EEOhWjEqN1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261021121427099003)(261022113327099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4uzE2RCBkeYm6zU5MVu+CKPCIhIN3c7TJq7wg2Em+cmTfyCzJZwsPy+dZv41?=
 =?us-ascii?Q?DV0LcxQJkR7gjnbcu/eerTtgZ6iFLorYrIgpYsa3ysHw6QYYXxOJSmfbcQDU?=
 =?us-ascii?Q?blzXFpSX3WxdgnltQhM7wyMzWnkaJGhzi9u+lxIDvJXuqpl+WsBAY8NIG7Eg?=
 =?us-ascii?Q?sUNyFDwIqOtKYbJtmci0X0Vh3uuCAUl8QoYxj5iDWRTb/VlqWOdwvU7HqYZn?=
 =?us-ascii?Q?4CKGY9mK6ZFI6Kc/orLpYMAtRP0maMnOzCfIR7ycfBHGEvp0JfP6Idjy3t6J?=
 =?us-ascii?Q?DWuTZ+QRghJmvL/T9f/R6vYuYQSnmOR/b9sbORH97cqkbs+ifaP2NY8soT3b?=
 =?us-ascii?Q?aS22bkrXZ/98fhIPiDFAYDL20iNbd8FCN8C10H2FSBLF0GG1C8mo1nWEP63x?=
 =?us-ascii?Q?Mgv+81acXpd4YOsm23HP3ozSSfNyGFuxEh0Nwz0Dw4Qk98103HX9dGH/gXcE?=
 =?us-ascii?Q?IBma8pVaHNmCWa+M7JWqX4FjaBc9eJb6TALrpCDXZwZ3eV1oBH52LjnixrOM?=
 =?us-ascii?Q?5t7b3YGHkPthuYBuuQvTA/4GlmbdCiZqm+SXly5WCQtZt2/mu7q2O0/izTKo?=
 =?us-ascii?Q?J5sGxmH94AyA8Go1d+M9Y5Gw6WDw5AV8vagibdzbtoDPpyOGjnB6GFdqqcvl?=
 =?us-ascii?Q?3BsxIcr2cdUG9AH3putT3Q+8sfs0ZhjAkwl3fE9wSCKg0A6nsN/6FwWWa4ut?=
 =?us-ascii?Q?u8PQSDfh0hffIZ6ZdNxhCV/mMbKYuhmQ4oSQebnEqHhtvkU57sWT/r6X7XFg?=
 =?us-ascii?Q?EmwNtPjAVBLyhNll+0NsuuRxUM7z92Jp1Q4hNP99j0EqfBOHGys1u1C4/NsP?=
 =?us-ascii?Q?HTSefji6Q4OvQB0K1N1K7IGziayCs21jR4TzTZWS84Fd38ae90W7YxhLP1iu?=
 =?us-ascii?Q?59mAZ+rKDNlP/VUGd1LZU2GpQn4h65DfvEO6tPXkjL6v3G0B1OkTEjK/j/a6?=
 =?us-ascii?Q?QzxHc48pXVVx4AY17AEiOHvuyhXKIdyI9hINiu0rAUcayS4XHBBDBJEIbgm8?=
 =?us-ascii?Q?ELvF/PdweMcarq8tUQPdJDvDS/mTnjgKRhVbgQHlWGjkCxawDCQZ3Irahhil?=
 =?us-ascii?Q?FMRvyab8MLRyt4tXm+pp9oFuAY+zt4+m8ljdpyJyo6GaZSP55E9Y2owZVFZa?=
 =?us-ascii?Q?Tk4lIy7CWgmKTf8q6GAlFYo+OMqa0bmPqJsoDokVWHFabv5tCtHURg6N7Zka?=
 =?us-ascii?Q?N8i0dHNT4GbJ1te5EM6rgsmbCB4QT4Nm3GE29lSmyocrlXI8NcjC4W4jTgnp?=
 =?us-ascii?Q?q2pSDxpawXOBJR5AQsgJvT9FB1mr7pLS9DKAyuZ+hHBbjPKRXLTcsCFHZgO7?=
 =?us-ascii?Q?6+nNervkx6zPvbSejdqrowR1B2PVaB9JHyNFVzfNHzT13ThTvSw46RaLfWVf?=
 =?us-ascii?Q?VHNP0nAMt+LLSeJFRwwLDM/dTFWX9itzsRSZZOcDshmgYrtPKqSBurLzPPTV?=
 =?us-ascii?Q?vIwbgpZxVOFmaVQOWKh6CoxYVqtNQmoAcCK8rYD9+rbxZS4jH84XCDGmMvSq?=
 =?us-ascii?Q?kQ+UiGf8o7oN07GMUgQmBNLyDhiNBB/gd2L4oXen5AfLIf8pM7rx0wQvfP7W?=
 =?us-ascii?Q?B2+7RcJWs7y6XpdXYgymXvi9jkKM7Ra9Lv52GQNHxKYSvI5tluUI71If7QBX?=
 =?us-ascii?Q?3rFCb/iLd4lLNzQYzH1OnwFxhALcqcE8RvthyfpMAm1cORGy+uKrEbkSfd1L?=
 =?us-ascii?Q?C6Wfwdn+Q45eGB6U6W8X6lMAL3SN8m1DumhT+j7Wzp3QYNGKn3f/dSxlVRMW?=
 =?us-ascii?Q?4qoEqZN12dbVyhqWXwmqkzXtDrw38rc=3D?=
X-Exchange-RoutingPolicyChecked: Zq3OkTK+2wMCoR3EA6sGQsHsw3pw+K7i/IZ2ant0NblqE8HIo4hdEwJAZmOOV+AtvbhQjRy3BAjSM/4w3/IARyvpHh7g1vV/I77SGic2eDqxHWgi3aOd5ZsiDJI0TQ/Z9FsLZZqdMExCQbw7sS74G629JyknSqY+9+qb2Cg1Ai8RunQLrFyUc3HIa50Qfp5QGz3/h0dekWgw9lxmua/lfjzwBDsNw75tZfWaIaumYwhNYWuSr1SXMEaxJEVNIiJLenaT8YEcGtIFOicNUGYDk4W8MG7MofTGFlhEijS18zn3Zqke7E9RnbGOgfVx5xkGQAXF1bgiaLwA6VylxqRH+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaaa2c6-e903-4aa7-e21b-08df3bfde2fa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:02:53.1972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5SaBU5rQPpsZM5Q9sbXULA5dc6dHb7pjWQ0UbdJCATU3Mj8ZPoWQAGyoibE014JctaXAjMb4cQAXaum5pUy7A2APq4E37wSPwwakfqN9+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF691668CDD
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

On Thu, Nov 05, 2026 at 09:47:21AM +0000, Anurag Mandal wrote:
> ice_dcf_hierarchy_commit() frees its temporary VF
> and TC bandwidth buffers only on the error path,
> so every successful commit still leaks them.
> 
> Free them on success as well.
> 
> Fixes: efd5d15a886b ("net/ice: fix memory leak in DCF QoS bandwidth config")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf_sched.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

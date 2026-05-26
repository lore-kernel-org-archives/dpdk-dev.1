Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF694CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 09:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E97A4402E1;
	Tue, 26 May 2026 11:41:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3E4D0402D7
 for <dev@dpdk.org>; Tue, 26 May 2026 11:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779788497; x=1811324497;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j30dnSU4UGaYgNEvocbVACdvc5papAD5uKcMX9DqZvY=;
 b=lNNuCwTPOpYs9UBo0snycQdGDE1UvOGGyLUk7Zjd4q1pegA08SLCmP+a
 hRgjqjFZxPxVCSb1nCeCXNBQzbJeOLWJbW/m0cnRrCa/Z5hIgQtiFNlxn
 +uVcOPiFe9fObpuwACK3M+SkOS3hgaDDg5ZrvLkQIyujSaQNQtHBMCKq0
 J8RMLb+m0YwnhD5UBST+b7bAUI23kK2CLBQJ1pXNHA1MrmjQY78ticObg
 6XnieAAZ2uZ1wn2a1/oGwz3UuggRHEpao1KlmownLxDrK2uUxeWF60Gby
 b4ob7tJXlegl8I+TMjOn8IBZF4YiRpjRpaBEicY6Ou9qFg+6Khah+xA07 g==;
X-CSE-ConnectionGUID: LF6+JfnIRNGWj6nf6Uq/Ng==
X-CSE-MsgGUID: 24e5iHCLT5SMTx6GVEIgSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84484229"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="84484229"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:41:35 -0700
X-CSE-ConnectionGUID: D8Zz5Be8SHqC/bGWqtpY5A==
X-CSE-MsgGUID: eElLVDjFRWaVJXDahBiCEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="241721406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:41:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:41:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 02:41:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICTJ3NBAL5fSaMEhbHEVkWL3yEx4IQd3HXyKGsnWk5LuUn2qhsIifesTTCsGsU+MEb0vS0eQ3kdqOsPNXd8NYgLshC+Geio8V604TN/8G+eHSvk0yVC5Wj1ZD+MSBW2YGerq4Zb4IIEsrpWbZjdUGp+dJKR0MuOF+tE2BHM6RxGHX4568VgRkxVcFcxCkymKQ1d/vLM+0sMsWJvphECpBVdWwD0CKE94vKsMiM3+qq5LHoJJiUcOc7SjkIbQkVPrHvtxaS1ZQX2MlcFWzx/qy3LsvJnMOrCKIGZFYtoBrAUPPLYf0Eb0LsSkgwqmhUaQzf1HOsu2IJs3njEHGg9mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoLN5ULm1cXT/YJPh4WErXSFVcEByS7XHruIDQ6+Esw=;
 b=Bf8+eEHBGEfiGTukOJkI67nnOgTi7ctFh067BxNPhRN9/TbUeOSbU7+hM6gy8EX34G40ry/IHFS3MUHn8P0kAvNNe1BxpObaZ/e7AD9EydsqY5hjjRL5QyWIrzMl3PL/OVMU8PRmXEqJQg97SlzCbucDb6ObTTlzIIJVThhztjDlXKXLJ0lJTtKu7zj02YJhEuyBKzhxpjgVEnW70SOtPoOkV+TSZbgrg/xdoCodpKwJnuLuUPNK+e7ATUNMcSlZ2yt4RND9sCEAjgtX/FJ7dBXr3gDK8B+DyYaUAI/LXiDxJHA7PIxwwM8kIVkMgZf7JkVz0D45l329lkavyFQF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 09:41:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:41:27 +0000
Date: Tue, 26 May 2026 10:41:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 "Kevin Laatz" <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 04/25] dma/idxd: clear device at scan
Message-ID: <ahVqwhJhu9MMMdog@bricha3-mobl1.ger.corp.intel.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
 <20260526084212.3145685-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526084212.3145685-5-david.marchand@redhat.com>
X-ClientProxiedBy: DB7PR05CA0017.eurprd05.prod.outlook.com
 (2603:10a6:10:36::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 372e59b9-1749-4661-2e1f-08debb0af57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: he3jpLPi1g2MdLOXSJS+BWijoWEoam72SwygHlIdrcP99fo44YP7athMD/Q6X4MIzUsdUUQZXYAPtg9+IuliyN8AggmhP+WzOrHM97XUaZIYR+/jiM/CvmCfTTVRnYqfOPmdFc8aq01g8wOcJntDztT3xtfAFqAY+8i/oyM/yN4LKiB9I6P+W0uctEeJXY5mXnLUTWRuyXkyUxFy2FGdpH1KEIQcfgoVw96W7AcIEAF4NugkV4Vur+Ynh3ORqO2h832+8+gsTku/6Uz+LpjpcHzmWEfk22CIoh8BB/587mOjGdhIK9PLSdoiWk3YnEwd9tlvh1IEIBzzSQ3pfQM+fdRS+biGm3Zh/kZpI26ZBILKTlvz/rLZ3H4+lo+5N+vLv+eoxYD5652mKQUpGImtSdoY3N1QLOWILI5/nBh8w2TQ9aLx77t6Hwta6KxaP2PZXqbWmH935ULJjZ4kXGxphr2fgjMYZyttHTgGVqf2KxQid/URRSIT/K2h7u2L7U1kR8ntyCui/CxyPeAG1dnvmoBDTrdfpFgxddY3vIEsK5OK/q96CMJWOcgzUYpgAzLy/evcJT7EZGVVv9i1nZvsFyzG6uCsfH1H5v/ku4Qo1HfPHiSsw9+f00ipalHPYQbqSPCaX7T4qVcOIFjYJSjRUT254+Mz8+VVruYB78e1HQw5ElWYVZBCFc79Z+tw5lEL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IUTl3e4izwl+Py3f8EXemAmnU6JrUHeh9D5OBhoFJyCK5UKbdpiAE79LY7K?=
 =?us-ascii?Q?WJngL2KFYMc5rgQxAVDGin3NjX7mxJl/mKRSSrvDzRNxOzY/QXKva4Xz8wcC?=
 =?us-ascii?Q?GU6ph3YKDoPE2oL7iR24ad+oLck8fJjhwV4o9dcw28OByPkgv0+4N5Lv+54D?=
 =?us-ascii?Q?DiBjaKd9p8SxofusL9wFiOzysb8AEFG+Y+p0/jA+LxR0Bi3rGXnzpXqe9SRb?=
 =?us-ascii?Q?eZFVJP7KztiJxqEtbGfA/tt0fm+QfYDWcOZmpJlLohjG/WyxoetGVgrlWZRK?=
 =?us-ascii?Q?Mhjm6eVGEJ3OfljH3BZ2UyrW87l9uj9ZAYjghO2b2SiOJJQ96qnhnxCZqr6q?=
 =?us-ascii?Q?ahqWACa2L/VRfiGtUBFPj89nhQluCf/sqgO8ODkvHO24So7WC1I7IXlZg0QY?=
 =?us-ascii?Q?IdQOibMY1Dni66/Kc5NzDMGsSTwL012jGBIawlqyuwffMFHZJ8yMridDkqIM?=
 =?us-ascii?Q?uphUhqyw4XzShzPF487NSFjSBzDlG4Zy9DtAbeSgtRzE/gU3KlxFEsO6qsE4?=
 =?us-ascii?Q?kbS+2NtWOK/5jSfUbjTA2MIRgWon27UXA5OFGJibz6HiCXotaYNxTucft/qQ?=
 =?us-ascii?Q?HGB18FX8zqHqC32E2sgGlGD1IdheVjx5n0ULOaCF/GdNjUCGUb7ztyH3+7O6?=
 =?us-ascii?Q?VlMDCbWwVEeRguDZltuCaJDb4rm9jAowcaYJy+FYSF12zWHlAGptgy+I4CD7?=
 =?us-ascii?Q?PIkad4pdZ81JW8Z1pE3xx9ceN/nejvhBGshfpKBluwvV7rJDb2QYqA/TMBBP?=
 =?us-ascii?Q?Iu8vxpKx9rhUv2Tpye/oF5t5JifYNuerJ/s+YRVOWxjQQ9SBi1dL3Dt++TbD?=
 =?us-ascii?Q?Er1G47XfL6xI3r1oU0bI4Y9OWG5CiQPr9Yh+ugucy+6nX+J7nCYdIvfgTBLa?=
 =?us-ascii?Q?nO5UVLIGMuNQkNLynwA7icoXG1G4hOTaJC1qDb3RvxzRi0paPCRtQSi0gGdW?=
 =?us-ascii?Q?dFywh+UADQzf4oVG7fihV61VIbVK2zxEzygoFblvpGuOYoIl3GrCO/AgiiqX?=
 =?us-ascii?Q?MuTwMgC6T9lvYQUkQZffuBPf76Ha3agdfr6VyK/wQ+/6UBZYgeSumbvTwYf9?=
 =?us-ascii?Q?AlTLWT0a0NlZE7hpVfVmLJRv9y1gHUSW8JRaL0mTUSrEs61iiN60UWJBnL74?=
 =?us-ascii?Q?gJH2BKwCg1VeISFdDXUCeevzkI9M2V4lT/bfyqqW7uZlZRU2ZiGJYnyc0NdM?=
 =?us-ascii?Q?vlwobLFPRzsHP32BV/XNj3/S50c60Ls1CEsSUd0kkJnr3/DyOQ3Rq6hNNWQM?=
 =?us-ascii?Q?iePpieT4UqwG7mJlZA5pFpXyIQQ85qQID0BGNyds+b42uWlSdyo//awysiYc?=
 =?us-ascii?Q?maw8MMH8V+bdxxAOdXT/tLwQScITZJ9sh9Y+xv0Nn4VZrLcTtyIFa6xLsGcN?=
 =?us-ascii?Q?s8Ex7J8U9VLdwvcI71DHM7/nuT/EW3hbDvN0kumsWdvXerz6lopt3moYwYbb?=
 =?us-ascii?Q?mxlk6NSmnC+Z1Dz50I4BkVMNpvqZjFyJVHZGno07RtlyhP4t90KXZdhwz/Dd?=
 =?us-ascii?Q?OaQf/7L1idBF35BCEuMC6QjNIQ10jKY8pdeXg8LjIoeT0m5FkAJ553+AN6kA?=
 =?us-ascii?Q?gyR4J7CtuAtEfTR5vgnNrOsFmQehMHg1xe8eXRoFOVWT+fGE3XKHMxVZoNJy?=
 =?us-ascii?Q?nt7qvUQq74duaHNBaoyCpbTZX0anHjkBNk9hkXnYaSREfn4CdB2GtyO8AR7P?=
 =?us-ascii?Q?+jYt0rDcWOYXs1FiIdxhRDuMS2cpFnAAnTUUsr/P4tvqV+W3HMgD3UaiMGed?=
 =?us-ascii?Q?kzEuMK2969h8QxgigH900T2Iqnltxjs=3D?=
X-Exchange-RoutingPolicyChecked: IHBDTkjJfMhSCT7MUB3oMh90hoCe4jEbcJ0/9hh2icCdyoM0915136/5vy2zJP2pnymWY+CdQmSct4MIp61yevpXWrOG/7FpFj3uFEPnZasxrGsMXZgolqFjhi+LFVCAD/q7cUDtgXR+5X45RfwQis0rYJngAH0jFaOBRkKOiRm5ab0zM6Xvs/3hAx5PoOKe1BdgrDeDAOVVMWm7FD/sLORup2HgzeI/GOktC8d4WMIwVyPhSV+fNiapRoM+m6UG63TmhbrBLqExPly+tHu5iHl1ehJaRrP22WQT2LMT8UQagGWRB84ZoUJe1RhL0XF/qnbw7mtJpzC5brRskfB2Vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 372e59b9-1749-4661-2e1f-08debb0af57b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:41:27.6379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4Q+MWCtV9NAXk5F2gzDNDqB3oOn6cvJDix85X5ZVS80gxEWDHiUN0ZQkzyO4B+G+DrAbviWx2SIYhdHwy5bosIpAmOebeT6NtUzv3k2kRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
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

On Tue, May 26, 2026 at 10:41:44AM +0200, David Marchand wrote:
> Currently, the device object is only manipulated by the dma/idxd bus
> callbacks and EAL is not looking too much into this object.
> 
> However, in the next refactoring, EAL will expect a clean object, like
> when checking that the device has been already probed
> (iow dev->driver != NULL).
> 
> Request a 0'd object when allocating.
> 
> Reported-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/dma/idxd/idxd_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
> index 291cd6c707..f267c20a59 100644
> --- a/drivers/dma/idxd/idxd_bus.c
> +++ b/drivers/dma/idxd/idxd_bus.c
> @@ -322,7 +322,7 @@ dsa_scan(void)
>  		}
>  		IDXD_PMD_DEBUG("%s(): found %s/%s", __func__, path, wq->d_name);
>  
> -		dev = malloc(sizeof(*dev));
> +		dev = calloc(1, sizeof(*dev));
>  		if (dev == NULL) {
>  			closedir(dev_dir);
>  			return -ENOMEM;
> -- 
> 2.53.0
> 

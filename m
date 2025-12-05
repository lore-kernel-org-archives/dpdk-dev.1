Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39995D2E038
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 08:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E1AC40156;
	Fri,  5 Dec 2025 09:29:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A05EE40144;
 Fri,  5 Dec 2025 09:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764923393; x=1796459393;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=c30uNR3hHSJdNfQ0j+uQlcxi2PT1EIyQqoz34jy3U7k=;
 b=TDkV37aL6L8UNgPkxgUvZdtHHi6yU6aLgmFMYzGu2SrtLAMEEqqQz8gt
 cZIRXFacVM90YYA7EsSzM3gxM5cCDzsJSXQ36oRGXAv4geri5qQiBpdt3
 2WjN6E2Tc1FKITN+zK2IgNlGfzoM/ySbwtNRePYdcsPRdHzBhpYhIYNjs
 cdgoW/VT0PdoV7/7lR+g+WhX3glQE0a0bPzvxeObYqEpRmc7ERkl/Thl7
 6Yg4YGQ3bHfp+yPV4RwSvK2Y/ynpUc4dNbaDt+2saGigwvL/S/Yty5qHP
 +Cq2cjw1UzrP2KqKTO12ckibUggFJ74yqS+gyaeDNMiisWBFHNkODi+64 w==;
X-CSE-ConnectionGUID: 5ghrE7vdSRuQWTE2vPJGlA==
X-CSE-MsgGUID: nw7njahHTQWDDxQVHlHeFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78420434"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="78420434"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:29:51 -0800
X-CSE-ConnectionGUID: on928dSWT2u56fUDD+Xtfg==
X-CSE-MsgGUID: aX7RXCwZTmiNaRVMDSSM6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="195674460"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:29:51 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:29:51 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 00:29:51 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:29:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iICy82OwDHZl8zb8k/okOJd80011FlQveRB8xHa67GYzsM2SqQzqzyDSaC4vH+1cQ9m5xxuyT/XEjg638G31ZFqJFFehWKyivBnYTnTHtsBsYdQbYWukgByPVTUL531Iv85Gr2QIXqW2zIsTiA0IAi501yeIO+D5HZiP/uKQxLUya3MP97wiOBJwmhHyR9P9xW2IIS3fKE+yrcGQ0oKUOt5Whlf2UevD4P8+NuVQdOnpBVF+L2axwzQfqbMJGH9n8tE6RSfzdNyECJFt2gn6SSt07VG/iVZL9u/bdobXp13XxnpaoFNloyRth8y20UAc6gSV8/IHoRrq3xSnWlBb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5/TOTki5GdiyxcXrukhWEP3IFZfhpkJeIaogQRvAJs=;
 b=XzQqVsW7TirqWcB4aWu7LgxNO4MEgAKGGfKTnGPNLCwwHclaPxBL0/uvxhNCPil6rrHTSDY1nhDgSWh5XmKuOvKsWnFwg4aRaau3iU9w6GrFMh/02PUO4oDD2SWuF6/UswA6+xh2bweKrQcjC264Z+3T6MNaytg3qcjD5Exg2y2xCrS6y9msfl4iH5Xf4fMp6OdSSqr6g1xRofesoa4qyoAK3DM0v95I37/xjaI2I8yhaK/WIT9or3RT4jkdffJdIbE8Se0AH9WHwl9kZxfN03vlrT/k/9PIYv/dAhP/BB/SjzJ+sRDSwA9nawwN6jQca04aWK2HlptUMhrHwF3+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9232.namprd11.prod.outlook.com (2603:10b6:208:56e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 08:29:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 08:29:44 +0000
Date: Fri, 5 Dec 2025 08:29:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFC v2 02/14] test: avoid long hash names
Message-ID: <aTKX8x0W3mU6BsC-@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205022948.327743-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205022948.327743-3-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0352.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: b7da8dda-1f95-4d30-9c14-08de33d87152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vM0LPOIsFXIvPH6eM0cLy7kiHR2AM5KdQ8VwIfpefwByOhn3MXuLegQ1eUzs?=
 =?us-ascii?Q?/fquMNGKI7xFJDF/bCnUteDxIZWVLoEMMl/WK+TsMpX9o8NLfno/IVzDey9E?=
 =?us-ascii?Q?E6UlY6BFTEl2UvpiZUmxerbu3BVY86+SOTl3L0gLE5/o3IOcbQpSUp0zlRrg?=
 =?us-ascii?Q?l6LiHZOySx52DgCYUmESoST5TlYor077XanHib2NrYlKIpmXtVIzjt1otD+T?=
 =?us-ascii?Q?3bJkNQdCtVOoXHhYSxRuc6Y1gcxg6H84fhqQUKQBhjSwwUg2azDn3802QUsi?=
 =?us-ascii?Q?rNlBN2LlHB2GtE0AFBnWfsCQmUFCqKFjnBhqz9GTS0anytIePt83Inp+bzYc?=
 =?us-ascii?Q?WEfnX6tTNJSwlO/TA/CSTvW+tFPdqZU9T+OjUERDOIpOLY54xP/9J23kFkJ0?=
 =?us-ascii?Q?v6TNBT0LIi71WcfZdPCDaqr2PuEWP6vrnJlhbesHDnYHJOBdFu/sFO435HxC?=
 =?us-ascii?Q?xwjrbhCGPqHo5+eY+zInJ0JQ3l4vpeuV7PPeCVf1q7ALgAhcrbZPTDVLgl87?=
 =?us-ascii?Q?e7NphfN7mw38ZFlzSe1d6jtUjr0EUZv5wKXxI8q4+9jjKLj5Y9gNng87RIED?=
 =?us-ascii?Q?0OPDeyvMv28x6et2HY8HeJE7FDdHAsGL7G6WW8uIApUODXNa36gmE+3P33Tt?=
 =?us-ascii?Q?qDRDmR74HMCQAvvFLooMQRzAdc/QRPifesBa+SULQsExTJbuHxKuhGtcp2tM?=
 =?us-ascii?Q?ATOy2kLl85efQmnyeFkS6R6YJ57fgiEUyCdaUDvBEKpzwdp4Ax/paxvrmlEo?=
 =?us-ascii?Q?aGVoleZbCAkKze00HffhqM4nsFZeeXGzGLsCMazcLBK4rlux0AcPVdeXqxhb?=
 =?us-ascii?Q?0HSUvx2LrBwZ9i7CiWrIcqcnVNXkUtwW0KFs+RQ/mZYTFvRUvQhxtIeqMBGf?=
 =?us-ascii?Q?OVl9U2p5V2AYlZUOHen/xLKGdg//B/lvmTgBx+Fwr9lnryYanFn4X3497qVb?=
 =?us-ascii?Q?pGvo+ZPd5rVfinHjLzUw5P5Ttx1Jk3lIyBbMUUJKtl1k5bKc7+Bl7Sm/H650?=
 =?us-ascii?Q?DQNrIwls4QQrx3trbmuxfjtsm5eieV7NrzP4F+alVG/jMCK5U41YVwNrJMRw?=
 =?us-ascii?Q?eRAksnKiR892GVSrNEVqeYde7RVlGsw8KQpApuTJwaUod6pSy19b/KbPE18w?=
 =?us-ascii?Q?VGECLl0c+oPZR+e2ErKSNSGGGj3esCpQ0EPZDNd2RA9ufIoEKQbiG8+qeFdo?=
 =?us-ascii?Q?pDkVGypMtauw+CtJnTrFc2A9ycV6dFm6qLuQU6Foy0QR15XFmk22iXjkxffX?=
 =?us-ascii?Q?EZ25Zbgt6jk5DGdMy6fXqTCWJnXHmRA8foecJPIf4d4bMI/kUdXCc7qlB9Xt?=
 =?us-ascii?Q?XOEc9VGXo6fCM5GWZNgx+Tfzxq3oJ9mjMI89XQgAnT1I8BvwtiScZPeTULHc?=
 =?us-ascii?Q?VwYoHKkLLjqE6gzAKqD384s408aBs7GdDjl6weTqSnSSkr102SFvHwwqUqye?=
 =?us-ascii?Q?chNRr7VP+rZIhRGVR9NbHHdHPHzUnaiy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?elMPbWyxJyXIKWKQLJXYazopIluhhaS7lxzQ0YiTWVVyoUoej+rrM672JASw?=
 =?us-ascii?Q?GbDsKJj5rjbAOBPzo4QmEVrDxHqD7+8I/eOdDkAh1fi323lXiZ93jQn7s6d7?=
 =?us-ascii?Q?CvkaTrhicT+GAzKxLK+7ckUAISQQgP9GP7VfsarHzksjStHehhlxNsXI57fx?=
 =?us-ascii?Q?RR0VYnoU8IJ1fx9jtunkDXznzAhUiTBZq8L8EBigTbJd/XkIkRsJ9p7+ywIb?=
 =?us-ascii?Q?PTLEQ/Hcei6AZKFZvyznEviYcm7pOJXfBib5r5GK44zwypm0Mfpl3v9TIZUx?=
 =?us-ascii?Q?sfie9nX+Igb9o/B4GbcVYfoyl9QRJpsGGFt28EZbtyFPnKxSFYObo9IIFgxs?=
 =?us-ascii?Q?QIaPoCjU8rB8CoR5rKTC6bhkY4nQ4+5g6LsiHJ1mXZjm/fm1AS5tTnxfbZvM?=
 =?us-ascii?Q?U5QOqnt/3Cra/sd9PXashBinKKJI0a8d9eFLX2NwhzorHixGYeW4kXVOrGKa?=
 =?us-ascii?Q?ZR2zCUZuerAbKYC6NdlbsnBOvlcULpLaE94MIZ+mVTtAgXUmlKC6rtWjEZ6Q?=
 =?us-ascii?Q?ikYd152h6MSd2rmDlQaFmF2nGGZ+7GXndXYqndT5kf1zeecWT0y/+ogCGjdA?=
 =?us-ascii?Q?K6AgttPGIlkjMgBhkA36VOfgmQ7zQAx9/ILa7wUQsQJVbcAu+h+nkY6zyCLA?=
 =?us-ascii?Q?dtTy2W3TdS0H8AKro+FJb2+bRctmwsQw2ErKF351Kzmt4ejcglKlyzjWyg/I?=
 =?us-ascii?Q?tVmx2YCxeTCUbmfALGg4pREZiIC8KXPE0o7KZU/NTx9uAc4XEjynP08oBHtB?=
 =?us-ascii?Q?PRx2hhuYx+aAI7gv/kPwQjHvtNrNVRmMsEm7K+49gonPdLa4+HrZsekmbugT?=
 =?us-ascii?Q?s4WpQy0gXrYotEj5r0oXlbgfSrJDLuHCB08JQgLfGgYBk6t5WuVGXzOWApFV?=
 =?us-ascii?Q?3SR1Dejb7cUZGREzU5S2o6JIh05TwvLpfBEvVJ1kpG7PqYAIguEPSUogv1FC?=
 =?us-ascii?Q?auHegxgTEC0Xm3M/j+LnoMHFDnzFIgFvBrcs0aCvLZPucktGD9khNMkuP2zb?=
 =?us-ascii?Q?w9mHYpmvD+D0HlnIsamkf9A6TX/XTzFkrRO+2LDsNczhTeoPsghOo0t3tG2F?=
 =?us-ascii?Q?WbJ8q79opoGv8GapLmeNXQRBb8oCV+o9b3p1slSFckW4fGrRptkPvCf0v5VZ?=
 =?us-ascii?Q?YWZA2GNPDjSCGcWoqMQ9J7dmXxwZJvNe9v+UIgMGtgGliDvIyAVtL2ucajGM?=
 =?us-ascii?Q?kpzqLiW83eb3V6Fosku4oNb0IP2xMDQ+xg57baRdH/QBg1c2aICqgyuyvSpt?=
 =?us-ascii?Q?oCBh6rXfm2krkCQsdEHw4hwVYbS+GfPRNAipPXIlrhcabF2ZUC5UeNL0zyE4?=
 =?us-ascii?Q?1duBi9LLjNDp82EUQ0wyktJDf1JhkMnJMGzM5OMc6bnW5cPtVTWg2jLQRX+B?=
 =?us-ascii?Q?2ToMlLq5zobMBUhQ2oDYfAd4BeJ/Rfq3vfJbnz5ZbbPg7CmlKCqXh2vJFu1c?=
 =?us-ascii?Q?TpIxaJ0BEkNxU+FkH54H0Jy7uztIXlwZLEk3STCJj3CSFy8o9cBFVXBkpLTw?=
 =?us-ascii?Q?NF2Wabd94p48Xn9bFoBLrr6ydQizif7yh8OF8ckdGkcObgbciT9VE+FKQ/bD?=
 =?us-ascii?Q?D6ufeM1DNQpfD3P0yhjKHSAF8OVV8bfDkRP+92uZISdB07wiqhV4tIaxbRij?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7da8dda-1f95-4d30-9c14-08de33d87152
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:29:44.2523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+v4WdpIYO3/ghNgZWyoF56CoBGjlzceIHQE5ItymWgzB/d+DTVLp4T6+sEvVsC00w0sYb08Smv8u6dtLsy02H/bdAq0ieHZyRjSO6Ezvo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9232
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

On Thu, Dec 04, 2025 at 06:28:11PM -0800, Stephen Hemminger wrote:
> The test was using hash table names which were too long and
> would break if the hash library was checking the parameters.
> 
> Fixes: af75078fece3 ("first public release")
> Fixes: 9c7d8eed1a45 ("test/hash: add RCU tests")
> Fixes: 567bb951716f ("hash: reclaim RCU defer queue")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_hash.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/app/test/test_hash.c b/app/test/test_hash.c
> index 5791fd7f4c..8cecc28d11 100644
> --- a/app/test/test_hash.c
> +++ b/app/test/test_hash.c
> @@ -1399,8 +1399,16 @@ static int test_hash_creation_with_bad_parameters(void)
>  		return -1;
>  	}
>  
> -	memcpy(&params, &ut_params, sizeof(params));
> -	params.name = "creation_with_bad_parameters_0";
> +	params = ut_params;
> +	params.name = "really_long_name_of_22";
> +	handle = rte_hash_create(&params);
> +	if (handle != NULL) {
> +		rte_hash_free(handle);
> +		printf("Impossible creating hash successfully with excessively long name\n");
> +		return -1;
> +	}
> +

I'm not sure about this behaviour, for something like the hash name. I'd
tend more towards having the hash library just truncate the name rather
than returning an error if it was too long.

Also, I worry that this could break end-applications which were relying on
previous behaviour of ignoring long names.

What do you/others think?

/Bruce

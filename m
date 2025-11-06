Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 16:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62BD8402C4;
	Thu,  6 Nov 2025 17:34:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 36B464013F;
 Thu,  6 Nov 2025 17:34:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762446840; x=1793982840;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5Ot7dXnweLH8/OQspgGMyqKAAVmoFQfl8Nf2w3D0ryc=;
 b=VCvjee4okmBlO3jqraP4Dk0NpONmp+G5clGO7U4j8JnnC2vcNmx9fu7y
 NfDeWY2voc8MEoaeq/9up/XeFZLVZJMvLjicjiRHyiLDTzgvNKwbDr7xG
 XqSJA73mjjsa2p+JNq/J6VZocgpiHHz+BbtfLvGJ+J4ePhQK9hNuxrYPv
 X+R3+VGBf47R/aiX3o0Bo/ZWhHmHFvFvXKMhtn4XWWlG/LL9ktqkqQ2Y1
 Erb0g4gasqlS2r+xpmwJQslBagAMwdhk/lLGa+sF3G3d7YJf/wAkl+zWE
 6enReVjnXsBGFhFVJ8x1KEnPp77R++iA+9edfd09c4esyRQu/G6gbS9hz Q==;
X-CSE-ConnectionGUID: WaFvm/t8SBiD2ZjTS22Hkw==
X-CSE-MsgGUID: 1PTqzN0+RAaRwgnyu9I/Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67201015"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67201015"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 08:33:59 -0800
X-CSE-ConnectionGUID: 7q62+gVoSTm4P5Oo82XB5A==
X-CSE-MsgGUID: lM/KZiEHSRubqnYvHIPO2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187745811"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 08:33:59 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 08:33:58 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 08:33:58 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 08:33:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPcn2P01NvxKBuRE3CZcivxRmx53YAzz2ODkVIFmGbFgk5TSUbwQCe56TUOnS3cssfrct9ZINq+x1RnqmM23Paj8WroVTT9zOjfGUfnT2cU80KRPHn8my6Mhz8fwpkgxHja1P49J14Cyo5dKtKjDmbKYdDGw/QdF+eoSzj23ldpAfzEjwqQDgGCMVdxeVIPylc3m2fiLaYGsqGdFplumBevz7W2EhZk/dQXYDMOyWLr8FXg9pYkwq7Z+oerbicZhSHwst1ki76BhiVKOair06MOb9dj+iPjWv9ppP83TkkXe5uWhwWSKXMHKWkp6XVGUP00NEMXyYCiyCvOs6/ssZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8Tcpj99Qqv3hRhFlwHosPuwTeQEnj8rdt/B+Pf/nfs=;
 b=wIWV+QvRAGMJPXaJCmDbWsJlrdliu8bSHZ6VvnqmwJXjz+9qZAXRLv2STjkUQ2Xt0ev9YjJsHRKq8veSOXg9rUwLH/c1OkY/s0rXAcvknhdQIOkhYHaaOEeCu+B1gINUG+F7G80VLisuw9eEPDK/x+lMUIAW22O6TUhUl3UUqR2Y8Hf/wZMWV7IUFGlaspDP8DP56Vfye8EQubN3ItS37leX6Vs8vjSfmle7bcn0xxFADHo2frVtJ7YnKTl84UtvREsFo8XiALCb/fuhFdSSg4ww5jwnJxe1skNs28zkZH2ztgREOLzdBQB6zHP+qB30DQW2LjNQHTDGDck3dOf3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:33:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 16:33:50 +0000
Date: Thu, 6 Nov 2025 16:33:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFC PATCH 05/19] graph: fix variable shadowing errors
Message-ID: <aQzN6dALek8vzauC@bricha3-mobl1.ger.corp.intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251106140948.2894678-6-bruce.richardson@intel.com>
 <20251106075013.2912d155@phoenix>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106075013.2912d155@phoenix>
X-ClientProxiedBy: DB8PR06CA0046.eurprd06.prod.outlook.com
 (2603:10a6:10:120::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: c0211661-7734-4895-9c8f-08de1d52443e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ng5px/FMTeA1ePREXUoAZ2w14gVIKh4RNtNTBwQD3NyDqmA27rGEMX4m4IOs?=
 =?us-ascii?Q?yyaYh5y/yzjPJLl59IC1e6wLKI9Kskn4FJVKaS1QXwsbMx4GySEkr8G8tExG?=
 =?us-ascii?Q?ZiXujKUOGXwpTXZSGOP0IDnk98yEeojFR8hDScdiN7sWl8XyIshEXfJaHusI?=
 =?us-ascii?Q?2mZlGmxEWle+59tCt7VIVM1XixftnPtSyktBCM9tSTYKS9rt35yAvd92bEFQ?=
 =?us-ascii?Q?zm4LBoxuC5S+nAMPjC0Sn3+WK4RKU98gCaWVzQTE16LQKFE5BcERML4fkVND?=
 =?us-ascii?Q?B/9VDVAFYwlF1pgwdu/khGvLtiEUDknWQVJoSvVelr6r5ZfJ0ycwvpWjnycj?=
 =?us-ascii?Q?4aMnPDes18iPRZ5mcY9E2FSAkyqbYvrPnMMsk3F7/6hUT2U9lMRK0oKEkSgm?=
 =?us-ascii?Q?mm6lsLT6f/RXlY+in+q2jv/UsOGdCaC4SsOxaKyDaZLrMQmKu9c8VTgOl/Oy?=
 =?us-ascii?Q?wEix4a9+KvrksjhcQ4OTLGa+N2t0mzNcm0xBJVL7zqru8DqN6YDcmuKmzGav?=
 =?us-ascii?Q?nk7yQkghYAFyJwXbLJE3TCDKeokhtDCz4jFxdDeQ8hBPvmPX9MWik9Y20p//?=
 =?us-ascii?Q?lpev42DzsA/B5kV3JYNxZPqSAQ4QvBGvo/yJHBAu6IV9JPaJHFNaSwdjuyok?=
 =?us-ascii?Q?HcletRy7R9oavhGNxrh2FrsFj8PYhDvP/u8dXOPwUwIXPBCVRq/vM1WiR2ab?=
 =?us-ascii?Q?NMMk+lpbbnpJyDKYX7DoXcF7IppTg52KefIS2zkI4jaoIl+3/maZAEupL879?=
 =?us-ascii?Q?p9H0/U9ySEBn6kUd0Ssa2rCc/wCuIM0Sn8+VPVxb21W/3tIdB5FTKlHyCchS?=
 =?us-ascii?Q?hLSZgunEqq/Z45Z5DgXlZvl6itbLzWs7TFKYmc/4LoGpb3xeWf9xY/Oe+K12?=
 =?us-ascii?Q?c8ETpi/oS+cHsM1SFfQUzNgpbKPbaZ1u3yP0756QgkjlNBYnN2yT/TaDj3QW?=
 =?us-ascii?Q?Ve2AezU1LB0+x7wy/hEhBLWZk5+JUQxaWzpyJbLInlS0yGtMU1IM2Yv2LV8p?=
 =?us-ascii?Q?oskfs5ILCEIStjU41ERAgDSHphtfJbtXseSCxOt9ScMzPYrVehtSj7JEYULu?=
 =?us-ascii?Q?PnTeuNxHotFeLAD/IpCxOFmoce1+8YDcm3anWYzDWQqAPndm/wgphthq/opo?=
 =?us-ascii?Q?3fiwqEkpmDGnXp6bBJnAxHNGX+ecFBMJofi057FlYd3vT1ULTCTJzVmpKx1C?=
 =?us-ascii?Q?H8hetYh7WwxH4Xr9Cm3Tc66nt/nLDBUvsoOo8bB5NHSnrcPWQQcUmadG/+1o?=
 =?us-ascii?Q?gswtac8kNgX0npxKcuhBvbejuOCQWHg25KU64rW1Rc40UtQ2Q5oT7fd8SCwp?=
 =?us-ascii?Q?q1d00m2QUOoO8JYMhYt43zx/stLApC/+iQBQsPXC0t+nNxsP2ICBE8aSFCgb?=
 =?us-ascii?Q?Fqq4tNbXaLyTWiTihsDfmIvX9oTwDhqmvSkX+/trJB1rA7a7CK4ncN9+XCO5?=
 =?us-ascii?Q?4hMTgIhdl+6ir1M7UjEM4QIzbUqy5L89?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tCu7sXfoG190tyXBH69FL/XXomWhjlCRe2tXuqcwVyfiqcYjwqABaO9eEugs?=
 =?us-ascii?Q?nDUN4DO6fg/8tNBXrBli82ree71Ap6t+om5rEka1gYXokgiFF4NO8PkY9qpI?=
 =?us-ascii?Q?xAogwH9BUv8/H5KysK99u+Qn6j92BIHRRvG2KBcI4ynBGyFwMQcXjC3QLwXb?=
 =?us-ascii?Q?UoTvP2h9SPMs/BcPj3eoGtqoytCK4QhPndV1ysOEyGVGi2zrgclvZ67g8E3V?=
 =?us-ascii?Q?0r98042k6mIRv+TQ9Y4X2GcB436sWyo/XjoLUKGlPW3WnN5JAoCharvU9dEH?=
 =?us-ascii?Q?ruM7KkispJDnwVMsvkxMkmyW7Qzss2325H8A0wgH2M1HKwqtFCbrfXtMKdUu?=
 =?us-ascii?Q?qbEd3MfykhTgCKIzkWzcy9F2xOuqpo7a5dhiLTOra15Ub6jCVjV7eS/TkrPL?=
 =?us-ascii?Q?qCti+SYwyoPTo0ON9yTI69L+0cDnsnhqGqmugJUY/Fm59S1xx7XhCfEXfP+V?=
 =?us-ascii?Q?4YZuFK4hRwoOPewh+xQvUT6cieifiYB2n725EHpir2OxHLLpDh8m3EeEp4M2?=
 =?us-ascii?Q?WqSeSz1M40HFEknt1NjVt831wAnz29/lYKSq6a+sfUZXWGYlIM7ngfXcRWlW?=
 =?us-ascii?Q?GdGlOxslL8b9/2k/kPVR6EsDxX4GUtmbPfOYp4zdKX3XWrqZbkA1z9GGJPH1?=
 =?us-ascii?Q?rKl6IzyyAITa7W7s7MX9G0YBFt0qOoNHXG6TYLQo8FqV7gO1v7dgJWTa3vrr?=
 =?us-ascii?Q?mvcxmwxk0jlyLdvIqZoGWqoQVV0bSq0TE8NQsp96KTcKWYtqF3W9UAm54ETB?=
 =?us-ascii?Q?eP267+1F7CMcOQO2rckYE5Qi+mH5XLy+a+7E8YeGONfXydTa+2Lfpuisf9NJ?=
 =?us-ascii?Q?1AkPOe4rsAjZ9pJhleNjUHV5J7aJvtiFV+ZJian1GwLOvwHtOW2FrWoJAT0J?=
 =?us-ascii?Q?tUoBE33Do0c3oC97cxuW6lHxCyvtpmWQ1a5L7sBb9U8ZoQ+Vkj4O5T7Z85Ij?=
 =?us-ascii?Q?rruoYNNmqDuWtpYiBC6uXtqqfnLe9xVbLtDk4U3PtLsqVD/w71KoqqsHR6NB?=
 =?us-ascii?Q?fdskVa8Ew7NplHa50Ddnuj42SzKMx7UviVEuPztL+2nRCGQLREv6OFSVa8qY?=
 =?us-ascii?Q?jHfPkZ4l+UrlS8YwAEDwnqHWTkGJVnbgu6y4q6i0fcHoB0oQOxdNYtrO7gv9?=
 =?us-ascii?Q?pFhL0FIkZePBifYBzKUst4NnsLLh+BhhKmM4i91emcUwbTU9F0cFVAyAeJ6E?=
 =?us-ascii?Q?VyRI/zDuwNiEXWxwAP6Re8sW5N8TK81zLc4rM4uVobTWder7GfA5X5Hw4JAA?=
 =?us-ascii?Q?nysRlYdnoYDBUEZSYdJ5e+yZRsWacWkfKkC64aSllWlSxOPogdY3aWrVT9tH?=
 =?us-ascii?Q?0kD9ZtqriIrMQn45yJt8AIktkFVbhnLtNrgWAfQ5oHHkBMIm7TzuIrfhT2Z0?=
 =?us-ascii?Q?KTdAa+d3DSlkMjRPld/NL/sW9tugHQrIQVgU/RVnyAnzA6LWn6c8DDMHSqLj?=
 =?us-ascii?Q?hBXQUvzPvsZmCE9Jf7325NrfHZaIBXWzbQpHIzdxvswfkrg4u8KAJ0yyjjdq?=
 =?us-ascii?Q?cue9ugfE8oYW2+QSdv1qtoo//M/kaLYhWMcdqrAPZDtngMkStxB0EHRxtU7O?=
 =?us-ascii?Q?2CAaMTT0rya5i95r/j6TV359El8lbn7BaDYO82J/0LM9w+9VbFxm6A+She1O?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0211661-7734-4895-9c8f-08de1d52443e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:33:50.4344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMikZu0mkfFDFhEgEI8CXRAHHN7IZ4/XwrkJIjExn1SyHm3DtJlSu9E3biXYvfdS888M84Iwqy2THhMIFL249tlMUiQndoq17OaCkd/76N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
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

On Thu, Nov 06, 2025 at 07:50:13AM -0800, Stephen Hemminger wrote:
> On Thu,  6 Nov 2025 14:09:34 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > The nested use of MIN/MAX macros causes shadowing due to the use of the
> > hard-coded temporary variable names in the macros. We can fix this in
> > graph library by using MIN_T/MAX_T macros instead, which actually makes
> > more sense in some circumstances:
> > 
> > * when defining SZ, use of RTE_MIN_T makes sense as the comments says it
> >   is defined to be usable for compile-time evaluation.
> > * for the size calculations, RTE_MAX_T is also useful as it explicitly
> >   encodes the type, making it clear that we are evaluating the size
> >   variables as "int" type, larger than the uin16_t size is defined as.
> > 
> > Fixes: b6ef3794b866 ("graph: move node clone name func into private as common")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I had a patch series (not sent) for lots of these.
> This is how I addressed min/max
> 
> From 5c8d69c734f90a774f83aaf47bc6c61bb19f411e Mon Sep 17 00:00:00 2001
> From: Stephen Hemminger <stephen@networkplumber.org>
> Date: Thu, 28 Aug 2025 09:24:54 -0700
> Subject: [PATCH 06/13] eal: add more min/max helpers
> 
> Add RTE_MIN3() to handle case of RTE_MIN(RTE_MIN(...)).
> Change name of local temporary variables in RTE_MAX()
> to allow for combinations of RTE_MIN(RTE_MAX(...)) without
> causing shadow declaration warnings.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Yep, since sending the set, I similarly changed the variables in the MAX
call to _x and _y, similar to you. I was also considering the MIN3 / MAX3
change too, but had not implemented it.

I'll roll your patch below into my set in next version, for 26.03.

/Bruce

> ---
>  lib/eal/include/rte_common.h | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 9e7d84f929..1f0edef73f 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -799,6 +799,19 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
>  		_a < _b ? _a : _b; \
>  	})
>  
> +/**
> + * Macro to return the minimum of three numbers
> + */
> +#define RTE_MIN3(a, b, c)			\
> +	__extension__ ({			\
> +		typeof (a) _a = (a);		\
> +		typeof (b) _b = (b);		\
> +		typeof (c) _c = (c);		\
> +		_a < _b ? (_a < _c ? _a : _c)	\
> +			: (_b < _c ? _b : _c);	\
> +	})
> +
> +
>  /**
>   * Macro to return the minimum of two numbers
>   *
> @@ -814,9 +827,9 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
>   */
>  #define RTE_MAX(a, b) \
>  	__extension__ ({ \
> -		typeof (a) _a = (a); \
> -		typeof (b) _b = (b); \
> -		_a > _b ? _a : _b; \
> +		typeof (a) _ax = (a); \
> +		typeof (b) _bx = (b); \
> +		_ax > _bx ? _ax : _bx; \
>  	})
>  
>  /**
> -- 
> 2.51.0
> 

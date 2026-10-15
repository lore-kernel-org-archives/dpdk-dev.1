Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13617CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16DA8402F0;
	Thu, 15 Oct 2026 17:21:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 429514027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792077681; x=1823613681;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=e+NmkjIwO9ILCHkuo4mPvbvVVrlnno6FVGpN+S/z8vQ=;
 b=kSNFA9hqfeqoJJrYo9YwP/z2V38nLhVP/mjTXZPXqzHYUJQzrje/pwcq
 oSjrenvdsSPkndAHBmjfb4LZWuHW+/mkTe4HUjQ/23ffuHPr8wlq1LrGO
 pSELOHZtFMiJEvypk582gPKUuEjFGxc1+YsVruCZkmdf4jFNDIqbRLfc1
 xR8KP0MY+65FMsaoBLMD/yr9DMZPMlf/AM1SHR2075tHoONwnCUB1Gj2Q
 5bHpdaDGkfbdJfhx9Ns5t1Hlkagg5K06luQ39H2AexjdB0/J2qPUPEFqG
 mwMDFEjzvT42bwO/RR0lW+ZeREKbX9iQ7PcTv6HO2FUHGYDLBZ0ZUemCz Q==;
X-CSE-ConnectionGUID: 0tLoL5DbSVGaYPMQxwn0Xw==
X-CSE-MsgGUID: EiRUbWTlSea6xK8HVjtI7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="955092"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="955092"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 08:21:20 -0700
X-CSE-ConnectionGUID: eF0avccYT5WAuA8mgDmIOw==
X-CSE-MsgGUID: 5rr18YSrQLKkmiYWYXSAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1733711"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 08:21:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:21:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:21:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:21:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niPRwXZm/vd095nFWxp5jCFkgz/2acRUjnZ/Fp2awNrpTR9BpPXtHi+AHi1kAOiWhQhue7sX242a0X9Ny4RyOFXtS1r/bdBV4TO3BShDI/T6mJ58d0SyA93eoCeuKMazILjjxyWKEytDPreCjhUmCAyHoGKIt+ox0uJvacwG456AnydW1Qp/JrHA08WduDDRHo4/EMreojH1mgELQM2GZijTCJN0h9duNWjPGyTnZWt2BNDAyR1X1/JVDhp0vKhd79k/CCQxs7CHNbpCz6y1IpdWHJH4dFDGJF0NUNQIM2dx4q5KrvFM87y6IOZUhvTC1/FJAzf8KeP0bfgchnqyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAR3BtRixwaxQcdbsYOsc/4HqlqTgRCRPxtB8pF1y6Y=;
 b=QcKm8A41ulIFmikvI1x+u4I5PiNUXoLYmTB736VliK1wmMAdI6LocMvmpVECurO1qoz8PW8CE0qmKMPadnLo+SGs9zOHeh89famd30agSIELeNMsPlxu3cj6Jh5qgqb/nVgXeRKwDOYxQaKyWJX2Y1e0UJqulPXkl+isl/h/H6C5ZyLQ8+EwF3vzsNGhQY/JLpjIhuSf5Erie2+EyvKCX+f2A0myGlJbRiCmshpTG/xTGJGbBfn0Cm9p0z5JzrPSPYQNRc9P7z+d6FTAziN++4TmW6LlT5VVwxR97qPKhHLPIKbxJZcGCZDeCJUFSU8qqwnkjLWxnfmlGAtW8zgayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 15:21:15 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:21:15 +0000
Date: Thu, 15 Oct 2026 16:21:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 Kevin Liu <kevinx.liu@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
Message-ID: <atDvZiRddrDI_mJD@bricha3-mobl1.ger.corp.intel.com>
References: <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
 <46e98c80-f44a-4c69-93fb-050ccc864c4b@intel.com>
 <ef450e1d-34ca-4876-b94c-6a3dcd885f19@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef450e1d-34ca-4876-b94c-6a3dcd885f19@intel.com>
X-ClientProxiedBy: DUZPR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 57929c55-17d0-4754-500f-08df2acff40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: lD0HfhDOdjmaXJOABMiNdsyyyUXRU5uT1btidXU/368XkjU30jyMD0L5mqXfE83PHOV0RI2QGf3w3G3SDDAH7ksua/P/jpgrPR9T84+3yHgGq+K0d6yTAHYZfFVyZe3YbiFiTY6aC2K/t5coGheaa2LN2oe4E7m/SrylqPzNcIK/00KjuQPc0lZLKSM0/hiDvJ4GsfgvRAQOzEjUPrgM2VUz3Mv0hSFD1HgvIp2t9dAAGmnxUwWIdKwyhXttMzQH9o/eGJZ0I45CpeAYX4iOF7HEY8SdH4C/CyP7fA9BsIbsoq5ITuoU6lmgkcOllWFawPIi5HYRX2UrWp3B/rZapni/a4DcP1wkAIGRJYs8wPLU4OqvYCgdpJFRDU5LxRbp0ZruJIyAFG8Wdk5CW8Hbn6EfH8/ZAZXa3yRaoOh+wjhrXfz6wMC3XU77rYmqA4fiaJcvy67d6TZ0N92KzT3NeAXV6OUErIulVqrQWeaxCfdGiurFIJys23MwqekVyPW3nLM043cWz1ch5RSHHBlJbD+HaIsZnnw1XygByjEwottO5QAnMCQDAssnnkx2tbx4ZJ4O42VO/QVzAHJNSG5kVAXGwYhEQetLvhr0MbqzB5YmeCshTlOsfu+pnLNz30uqzoZguhCAzyFkP66dsYimkjj4n7BQMK+aAxQXpEXg2KY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yPyl/xiDJzoBVcy9g2bBClhpb7zzrEvuoGdETlHBK69BMruEUZN+OdfC0nRM?=
 =?us-ascii?Q?UG4dsHR7o252yMULXovr5xTqbpOQCMNoN5+TlPdT1oQGq1MTFH7F8aykjT4A?=
 =?us-ascii?Q?JkXXc2vvWo3COi8UbegyhzgZqEGIx9eVh3mHx7cr/JXhd70jq9/Y01FjLs+Z?=
 =?us-ascii?Q?Tz7A81AVAM9AXkfCHwbNNvYb/28FDtD0HBEkhsmZbYP+FS1papKCBbs4q+mm?=
 =?us-ascii?Q?hysFlwKhapEkeQtsVXbR9QEnSWit8FePDKesGuK/AdWQ/ghMK68hxOS9lLMV?=
 =?us-ascii?Q?0uaIwKSfHoPJxxmxT8XxXEbvbnEQsD0pastxsEaipqMp80zKf6NoGp2fBdSt?=
 =?us-ascii?Q?n6S9q5sieJvpFDJk5xOPuDSDf5bj+cVdG9oLAYSTKFeyLohN1MQvL0uf+m+C?=
 =?us-ascii?Q?dRKGfS1MNUW7HHPdwKsJiupgwG+rnJdMVp+QLm6KSalI7P7FINKZCDyNNmcY?=
 =?us-ascii?Q?E8XmVspdVGNM+JcDuAVrkJ5DKHySd/tPq5sVi9ddoEzAdcpMcGlyyWshb8IP?=
 =?us-ascii?Q?TuJNl8tm6a5DYmuco5bqM4jZjYx/PKD+pEhh7gzrBxByYJ9qX3TS9o558W57?=
 =?us-ascii?Q?j3cHb0gDNd6xRjY08X0t6GGaPUjxOc46NnYYuk7n29r8Wsk6Uqf0mqqEYziD?=
 =?us-ascii?Q?CAx5gAQIyIvMJWsnHXTkXwDrVs21lM+NDcoOrFP5f5oArZ/Fi3j/9AdZP/iC?=
 =?us-ascii?Q?k0uzbmzFeW6PmX8IYADKaj4Gg8lTy3K87XAtnWDH08shzYqAR/1b1FZHLI+l?=
 =?us-ascii?Q?y0sVSDETihvmLm5wJ81cZ8xudy71viWmZAfGXegWitS1to8GCKfcAvVHCGIE?=
 =?us-ascii?Q?E29KF0xPrr3sozIfzSIZMMv+ehFIMXAOU+RPFgwtlkj5zC6BGQCBm/1wB3MN?=
 =?us-ascii?Q?xByxBeJblTYo0YF7v9y1fWjGXY/x7b7X8vezNpU8dXgRsRX/m7qBMpE8jr/e?=
 =?us-ascii?Q?6GosrWjFbS848sqvAu+vMy+Wk69F/06nhR5AjFpvzlpcZt+MQPiB4NhxXDMI?=
 =?us-ascii?Q?b7Ude4556NI9W0hbXUSGRPhpzIfD3L+R0rqjjL7DFk52Xbc1fmGO2B2ptNv1?=
 =?us-ascii?Q?rNumHOfDFw0/AlyXehU96TvLmPVea/a2naBSka5k138Q1FN0HLU6bRix7OAz?=
 =?us-ascii?Q?jTzy5wNj0yyhM2YDYNea4WdBMSw9uShGrQNEFbgf5w1aj4B8y+EfE14V/EjN?=
 =?us-ascii?Q?kz6/4JnRsdYohqGuE4vHP/CRB3Ck0M1gQ0cZMqJQ0nUA8cjpfl5JQ4a91Hwd?=
 =?us-ascii?Q?YshANad1aBjXIy3GVTvIQORUbJ24/BxWBZy+4VFFnh6TUf8wlFJuPkHsaiW+?=
 =?us-ascii?Q?95aWAwHfYG79dEEAFgU8ekI4zU80M/Qle6eAWuZmobcEdG5piqPdvfR4Frfd?=
 =?us-ascii?Q?2s5cjF1Ti7LHWDJjlmms2KDnpLEyc/gPRPyQISAX4KNYEpyp9ge87AkyzqQo?=
 =?us-ascii?Q?YILFdx4IoIoL+ThpaAgUIFo1E/3lgj9HkLhlchuu+E5+GJl/Gg2/U0MIPGBD?=
 =?us-ascii?Q?nBIT02qLRz1M/+9BnLlLzrLSi2O6fY0grJuUq+IqcmoV7MPjI99RbIsJmqN2?=
 =?us-ascii?Q?O6njsGOoFzbVwbVarEqMYOw7I+ke3zuiDpGxrEm1qdhPbOXwVmg97evSjm0H?=
 =?us-ascii?Q?/1BnxixTAwFYN1tW6YYt5/uJjh3BVGfwipPyi7qz0K071fHXaskUZPV87qZA?=
 =?us-ascii?Q?rIPUnWwGLNK9VQBnOY2aMYJwO+ub3SelSrpQLngT/YW8JS/tf4A2JVlHajBI?=
 =?us-ascii?Q?eeGkRfOwYV5NSbf0JoLs0Q7kGdXlg08=3D?=
X-Exchange-RoutingPolicyChecked: lv/6Flj9XfUJzljXhTJgzAj512QNu2HXzWQICPZwn/4gTJj7WRJypa3/PKjSC3PqL/zIa/IXiD9ws5Lbuprj7D+TBqjJqcCVYqZgD2ZqdlA7QwfvHbyzNxzTcu3ypBCEjPfZ5OOcHCoc6aQNjGHrhypVrG5GAxxOHg/GcG2m1Iklb5E9UPi/NMbNHJHJRCKDT3ds13IoigE3wxxUzqjZRPMjW2AK2HhYEbSlJPCp8Hu7iE2887OzHRRXSvOX4BMBUMjMjlbcvTFL5GjjtX7PAvRqA4wWD1EXJuyuKQYNm8mkgq7JqaiWa3B1UuHnHtBguEKm0EALPiWVLBCBzPUmAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57929c55-17d0-4754-500f-08df2acff40d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:21:15.3616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F3h+bDYSIgeDYx5MKJ/Lr08JdJP1i1U9oGZUVvH6ukAffkSRrr4M4oE6AriTMHjzJWfglSpbwWuGUVws8p8Uat0BDsN9SNQw2PxZpcVPeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
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

On Thu, Oct 15, 2026 at 05:00:38PM +0200, Burakov, Anatoly wrote:
> On 10/15/2026 4:52 PM, Medvedkin, Vladimir wrote:
> > Hi Anatoly,
> > 
> > One nit: the buffer must be allocated with malloc, could you please
> > reflect this information in doxygen comments?
> 
> @Bruce
> 
> Perhaps this can be fixed on apply?
> 
> diff --git a/drivers/net/intel/ice/rte_pmd_ice.h
> b/drivers/net/intel/ice/rte_pmd_ice.h
> index dccfdcd5f4..881dc4cc56 100644
> --- a/drivers/net/intel/ice/rte_pmd_ice.h
> +++ b/drivers/net/intel/ice/rte_pmd_ice.h
> @@ -27,8 +27,9 @@ extern "C" {
>   * @param port
>   *   The port identifier of the Ethernet device.
>   * @param buff
> - *   Pointer to an allocated buffer. On success, it may be replaced by a
> - *   newly allocated buffer; the caller must free the resulting buffer.
> + *   Pointer to a `malloc()`-allocated buffer. On success, it will be freed
> by
> + *   `free()` and replaced by a newly `malloc()`-allocated buffer; the
> caller
> + *   must free the resulting buffer.

That is very strange behaviour! That looks like something a future patch
should fix, but ok to change the documentation on apply here.

/Bruce

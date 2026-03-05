Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA4F3D33A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:33:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 692244029D;
	Thu,  5 Mar 2026 18:33:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5D74F40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772732016; x=1804268016;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gIksJTSuBMhqYYTfeEy0oHF8qC7Tn15AaTJ15wog1SM=;
 b=V2dlm6DNWcp/xTpGIiQKf4A78OqAFDTFK2R2JRwfCxoCnMVUGo1Akg1Z
 fOp2/EG0WMLASEThy4rUHeZsiiZ1odfUsi2xg97tIF4pnqYkiG2NCidyF
 RQEddrJ7nqa2kJu49CaLdCIHukZh+VSPh1i1oJnqmHtx5KPwA2Qiwex3s
 sm9YWiEImu5IUfpi47Ci/7actK+z+LKXct5h8PJHzMozsnXW8Fqs/EZKw
 FVjCEzEasf9tv27m6JBDVY+TbKBLaN65XV9SH4AmJfmvZSRxjATU4zg6m
 g60NTj0R7oyqhCx5o0Yi4QGBL49eCycUKmToNYvgPvm4zpGNohbGEMhak A==;
X-CSE-ConnectionGUID: 457DpVCYTQWW8UYtxH2nPA==
X-CSE-MsgGUID: hN9fHCCuS2S/aNO4WqGeOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91402627"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="91402627"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 09:33:35 -0800
X-CSE-ConnectionGUID: 1p8dM/MWQDiIb2912JZA2g==
X-CSE-MsgGUID: XGEq3EYsS2Wr7WSIXoH39A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="215953622"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 09:33:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 09:33:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 09:33:33 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 09:33:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLnh88oGS1LVFPctmqsksRbaUZ2/zG4u5yQuZ4ZD9EqAXPxzWuP/4HQH/HIs6eWbooeibq/oXOvv9f1pQK4/6ZtHSRAK/BojNrrENzm0sr5WzR9+G6hMvngUx8LwDbQbneS5H4J8OeBuQcYh5UNpP717qA1sLntaKYKiQrN3nxk9h2QRjUS/kWXP9XHJeuZbrG6Sco91GIAMtKiSBJRT7NvQ+TrwN5nzta+BHy+cw6U5axyYTpOI0kTUQR3hZr1R1My/xXssbKpQzzaDRSIJ/MahG+CVCb2kNgePU40EXOLgEXz4RM8lA5Blv4PbzDrgW8kAcazSc2h2xdxFzPsEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThIMbGYDNazGaEGivWd0DzXv+Uq8X0LC8fAAF8PVRLE=;
 b=s02xOSDJO5G4Tkv9SrJ+/o2m6qW6ytmo824Z2aCpmbYgrwFWPh8ASQJVW16dyy0JKeHxcDgwa4iFQiEIyaWt1+xr8EAWyREzc3ymTNOF4mcleWHh0nq6LFz2yM07137Gw3fUgDD+qzBNOBU6Pm9PeeCdkGgcsvFyH2Qe1ETqAjqwMb2XaQT+NEXE3UHhWy4ZVqK1tZI+iFR2Zs3iQ/9w8p1guXd4GD/4EcY16LKdRVz+cqlGJ1bZV2a1xX1El9C0MeZE+tJEQs4QRYSUxJudzEhojsqhCiG2oFiZ/0zg7AuTB2oaUNkxnbLVZXDbwz2aB49UvEY8A4QqWDzCOzyTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8669.namprd11.prod.outlook.com (2603:10b6:0:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Thu, 5 Mar 2026 17:33:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 17:33:31 +0000
Date: Thu, 5 Mar 2026 17:33:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC v3 7/7] eal: configure initial device probing
Message-ID: <aam-Z7Yqjast3gBU@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-8-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260305164550.2067453-8-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 90711df8-0c4a-449b-fe85-08de7add51c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 07VydcAARHBR+ox8Vg+EC+fWmt6arDe4TDGLGl5X6nSZoilN5zOzDzzmoQkavFG8EvGX+BOQLsz0SzT16+DMXeIHhPvuGLKTpXRMNO9iwV3fGpyID60fViE3I1co/fVx/FL4pceU8210pi0e/BZlI34nYt/1Qhg3ifHrWjQiHAhauPhbEb285lPve5GYBI66Uw6C28Jf8mwIH8Gc+GKiTqN8MtTvdA/9MQW6FNR7obtFJmKlvR3dcNpDkPeauqisCP6CHozdY15MVVKNyDobbfCFTGkaZmSXJgMitPWtr4D6jeovq7gchgAoGFAJjta0fRaOeMTYBGlaeKZxlp9HasRE/WEDfS96tHO6hOvMrWFY9voa8ulUvcPsdtDuRuyf9JTe9qlMaPjtDkhF4E1qB8RS++bsah01JLz9yIVE7iqBsvIe/PM1EyoDrrBbnbQ9ZFOKUddu/1a9Auan9CkPPzrg5xpJqJNX5FEt6yvCafkpdlx4BoPWsLCg2/A7qBJiBNMv2rvSAeilM2oVGpUr4AU++On21OcgZoy2oFHEu/yw++tcOPmh6RBxW7PpIpSB6bKAxnet83JAfAxDlNxmrKVNRGfkpwCGyAefY5f0ZG02IJCkuszrDB7SicOt7ypQBJFgQZH7P6WV826zv0h8Eylm+fqvc4IHxfibDtDLCsJN7xzxAHSiz2fhgJqq4OSO9EC5DPfpGvY+4K7fMeGouxaUFwSPMZ6VO1wbYCE+TPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lj3xL5uO+FnoCpHPxl7hMTXNCtNPJP/IylgZJBEMHQJXxIWhwyD2zzQLOIKD?=
 =?us-ascii?Q?OKtX3DAGzBztwmSUx3h8HncjkrWSPjezL9TPh6+q96HAZXrFCfzftkw1aqj2?=
 =?us-ascii?Q?a/wafcpvGM4udjcV9i63hSef6xVdwWQSyX1VF7VxhJGGS9Kk54MAc25KYjBm?=
 =?us-ascii?Q?MFj8zyuAyMDTt9/GxYCvFZrWvNEkyRo3WOmzH6eOJGB3dVYAe/25iaScaSjW?=
 =?us-ascii?Q?fketVKxSUhdbUaiu5B2YIysYe0x++cJgfvYjn4MTrjIRY7YSTHaYDKRW40ym?=
 =?us-ascii?Q?gKaNkJ8OcDGCoz86hQBgpWrPUsie5zdXZ91sq7bqe8/wGRa6eUxJcb4Ssize?=
 =?us-ascii?Q?4QOPuiUHrOwTPtcyvahbGN684MwcXukehQ0RpCXNuAMyjQ4KU7gQ5EgjPy26?=
 =?us-ascii?Q?cqjnY/eMS5GPrCsC/oDuqhZLY1RUULw6CH2vcK4RJCcC6FuKlltk6xte7GU1?=
 =?us-ascii?Q?ufKkklfHvNpLB73oEmP0z9M95GoF5/jn9ojM3LMuuqEPdQPhtPnvkQow3U4y?=
 =?us-ascii?Q?U7IzO0jwpSq4xIAukGb2TyO9ZLZTD/l8TH6UhhroJRgGFQxNhaSbDKLZOwNa?=
 =?us-ascii?Q?W2CB1noI87XD2AEBe6G+lDRcyFE7bh4j13UCfUDzhKLbgq1ZmsAYMRXNy28i?=
 =?us-ascii?Q?wUWPIrxVMz99RxPrA/2naKJu/SaJ0gY4eu0qXPpsU1pirTbL/TZhFjFdvzyw?=
 =?us-ascii?Q?pdYDeWoAkTKI7gnAgn+bx+80SHTE5kfG/HX6dLaI/NQpeJAmz6NpybgzpZiq?=
 =?us-ascii?Q?Wj4WulCQ9v7fy7Npr+BqW4nwPjavye8G3PLI021atTyMscsfYThekqhU0680?=
 =?us-ascii?Q?yB1+VR3LMVxzimrxQUZjholqInmzYsaI1MabYOWU+ke6AXidDmVlRvRQdw51?=
 =?us-ascii?Q?h4dcWPP536R53tsgY7/mixh3dUMicfeWOVgiJ4+sk4g3DAFIgAiBznKtz579?=
 =?us-ascii?Q?3cRad7qZugzuht5r02XKPmzclAH4+eyYRJuLEwj+b//TiY1ff3dNBgTr+Gef?=
 =?us-ascii?Q?kubY5/AiVfefPSPi+mhQGN7SKEgCCwZoVKFJOpa77Mmrs5OncwXloALSf24I?=
 =?us-ascii?Q?AGE0JpzrI3qnvm1aSecgZmYf8s7qnV5px9znG2qJrCgTJgp27ftXsRl+D2cf?=
 =?us-ascii?Q?MT8oQkOgLGfsx+L9e7x6A56N9CMXI0aeUZF2gVi+v6AgK4uBC0xnB/FodX4X?=
 =?us-ascii?Q?0saaQ4cM48BadWSl3AQTMxCfU6lmMtyaZ0Vyu5D5+do34Kg+4UFL1yKmy0h5?=
 =?us-ascii?Q?uVsTFx5ochm3OTPrl3SpYUC/oH18jKc7zwuOrNFZXfv8leMizu0zhs0yWGWY?=
 =?us-ascii?Q?5atTRCW/q7YUDTyEiyhzsStEFWJdW7cPtE1tIefWu54Nm4SWkSj+Zp4nh1CM?=
 =?us-ascii?Q?qHOIJHE7SoD/ZB4iR2ujHx38hCss2XVQjjEW0OXlTBIBCKlysKHrh+VhMBi7?=
 =?us-ascii?Q?epsBvtS43emALpjDERUD1ylMuSJ5a+rvZkFVpvLw0bA/bLypusIrEXqGGKYr?=
 =?us-ascii?Q?A6YRUK9lS5hEFqF0wBorphKHLLJZQqp6KQijSzuRXNUFUIg1EDaiikY0/VTb?=
 =?us-ascii?Q?7rXoIDTgSWnNlRXyXHJHfpAvzMg78ggTSZK3POXlET4kX9jge/2Z2Kt1EfGD?=
 =?us-ascii?Q?gOdiKr3qeB/e1DRJyfXdpv8kar70rmQwWgl9ztQjAEBEFfX4BdzhumLGPxsQ?=
 =?us-ascii?Q?ugtKjq8gqqxiDQMqqVnoKo4dhLTDVNIs6CYAvAHwitc4Dek2D+lkyZJgGRJE?=
 =?us-ascii?Q?7pMbgp+Hf5ZhKdiDUHKp1X6Y0ieWJNs=3D?=
X-Exchange-RoutingPolicyChecked: lbenA0y+BDsKJqmF7szQRxLOIsK8sw1SBZ/SEbppohNOq7zuAuv00heD0I636rDt8aoeE8rypAJMEq3HsqU2MtU/J717LO5nNWnZOYAMfVSuKrOaoDV8QlON+OSlb6D11+1TfGFwQP8rHaCW97qIz2fJwKPDUxoTTzHHx5mj1NM1EDoho78Za7zdZTuDvdLadD/Vl4QcOY93alBB3y304HLjhqK+Bm9PpntCGsDMyON6nwY7qm8gDDtaxMHHovF3YoW+iYGCaOj0WBK3jwlcXNCYXsU1sJ06ILlg69aywBivfyq55qSCS2/mXA40ngPuZ19TuRh6clSYeaLIE/b9Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90711df8-0c4a-449b-fe85-08de7add51c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:33:31.3916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0D+GY8SaGs+1yy9VphuSB46o1gQjrfmBW+60CzsGbrCKuSPt7+XW7rpaodkq/XttGZfUk66QiBplyneqd1QVl+w+gjd+NgToTBb9opzzS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8669
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

On Thu, Mar 05, 2026 at 05:45:49PM +0100, David Marchand wrote:
> Some applications use port hotplug as their primary way for using DPDK
> resources.
> Having a systematic device probing is a problem when not all available
> resources will be used by the application, as such applications won't set
> an explicit allow list at startup.
> 
> This is the case for OVS on systems with multiple mlx5 devices:
> one device can be used by the kernel while the other(s) are used by DPDK.
> In such a setup, the kernel used device may get reconfigured in
> unexpected ways and trigger issues like the one described by Kevin
> not so long ago in bugzilla 1873.
> 
> Add an EAL option so that we can change the default behavior from
> block-listing to allow-listing which can be summed up as disabling
> automatic probing.
> In case some applications want to require automatic probing, add the
> opposite option.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since RFC v2:
> - added -A short option alias as it seems intuitive to use with -a,
> - renamed option to --no-auto-probing (half Robin and half Thomas
>   suggestions),
> - made -A and -b conflicting options,
> - added opposite option in case an application wants an explicit behavior,
> - updated unit tests accordingly,
> - updated documentation (namely some detail on --vdev),
> 
> Changes since RFC v1:
> - changed approach following Bruce suggestion,
> 
> ---
>  app/test/test_eal_flags.c                 | 63 +++++++++++++++++++++++
>  devtools/test-null.sh                     |  2 +-
>  doc/guides/linux_gsg/eal_args.include.rst | 13 +++++
>  lib/eal/common/eal_common_bus.c           | 17 +++---
>  lib/eal/common/eal_common_options.c       | 10 ++++
>  lib/eal/common/eal_internal_cfg.h         |  1 +
>  lib/eal/common/eal_option_list.h          |  2 +
>  7 files changed, 101 insertions(+), 7 deletions(-)
> 

While I really like "-A" as a logical shortcut, I am a little concerned it
doesn't seem a shortcut for "--no-auto-probing". However, I don't have a
better suggestion so.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


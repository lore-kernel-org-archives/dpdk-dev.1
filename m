Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B2AC282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 15:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F00C40280;
	Mon,  3 Mar 2025 16:20:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BC00E4027F
 for <dev@dpdk.org>; Mon,  3 Mar 2025 16:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741015201; x=1772551201;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=va8kNgNnudnmoCMq/SI9vlYosaPRqRl8LjSt4ExOFiQ=;
 b=Dhuuss+Uu9ExwPLdh9sl9xHUKRcAUc0bMJs2zl5+Kzvj6Sf48Pj8IefL
 S6y0Mmehn2M3Hbfzqqso124R1ec1Iik5+0wpl9P8AK7fvm11MGsxF9FlT
 3ZMVEnvzDTzMi0q02B4793i5MKReQD/x1vTo/VtTi0ADnONaSIE3EnPgf
 M28Fs5CV3A4vB4gf5eFFCoDAaCjF6L8LKNzrHhxRo6K0jc6jfh9WCef+Y
 DB08FZmPA9y+X8KLsivqEQDn9f2gZi4yLTZ4L9shNjnhmK3sde7t1uNST
 zgCBiSUF/63cc6QF0MvuigBBNiuWOTzfiJa/vlavF2wDu+0Q7ni7HpJet A==;
X-CSE-ConnectionGUID: J43vs0QYQUS5Qs9LpSmALg==
X-CSE-MsgGUID: FVCVK7DAQkCsku89dfv2/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53298551"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="53298551"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 07:20:00 -0800
X-CSE-ConnectionGUID: NBQ4gxzCQNSuEcdeASVOKQ==
X-CSE-MsgGUID: f4jTUAcxRl2XI5ga15WHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="122181012"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 07:20:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 07:19:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 07:19:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 07:19:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UawDti5yODPmGAcme2LZhWDerkNwbpxUqPorsrOVQnvXBGeocaISIwg/kZIEhrvJ/ZuESZXhVtFClKUUmL3PuoqOeBLDCsFUY5dDzX40M5n49wvlfuadYdWMbaiSin3/OGwX2SMFJWhik4BnqyrZQRhjU2fjRVNbSSguZQyq4QxIS10udV/bA/orVw+rRvOie2J4RfXgSzi1PV60zJAU4R3uXsUDrp1jR6iDyK91O5Pwzjlp9Q1eDt9zpdIfclaT7n34Yh1PrbKNJF61oPSMKD3r72V5/vv+qUN8tW208OC7cwBkxzENyMqTG5GMgJ6EyCHnbr82uE6MEnRivH+gBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iDuJyEL5IffBnTInMlKkw4klAcdGn1vf9ZpEIrkul4=;
 b=Gv6j9y62EIJsVdDCYf0RHJi6c2TGM9ZtWnDPQ3CKsZ9fMsrlB1Hr4o3XEFjFz7fxj6CZBOl8E9uluOYLPoRPfSIRzi1yUZdgPkf3b2J3kW2TaUNECDWcq1ox87utOiT+08zFq5hjtPM1q5r6OVA/CrxmyxWGtN6p5gTqgeVhUytCF7wADAgnTnDFd2yUhu65JQbcZqoli8FoZGLgCtnXnw6smFe27cjJyDL4dxgPSW/52YiUGJpWpmteixmoQK6EPDZMWTcdPlYKzJEyBbutKSzA/ZlDP13/QpYJCwi8rxN+8rQIzOQx6ILWUMAWAC2ksHAhwixLUP0tZrNZI0YRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Mon, 3 Mar 2025 15:19:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:19:54 +0000
Date: Mon, 3 Mar 2025 15:19:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH] acl: use common top-level variable for easier maintenance
Message-ID: <Z8XIle-aCNzFN86A@bricha3-mobl1.ger.corp.intel.com>
References: <1740768356-29954-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740768356-29954-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:10:234::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7829ad38-934c-401b-24c6-08dd5a66d96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZuebM41UL0vIabe9YTCJXt+XeyCWvwSj9DQjukHftIT15IoT2LB0nOwkobRS?=
 =?us-ascii?Q?7HMSQviyorcHCCMijNEFCga5yKtbTNDU87HU0I9R8tcvF/RDusfTPJzRlzAf?=
 =?us-ascii?Q?D7CqU6zXlW8re4VU5NOTY3kVuHUNtPppaWbqfsjUJC4oBYlw/2a6+t+2UWSY?=
 =?us-ascii?Q?TmZN5j0d41FO/jLqqULqkDOD1geTQItceuYEiwXadQzW4aPGO7ZDMJnxRG8y?=
 =?us-ascii?Q?VQGiLdeB9VupTvrMwDn+hxAYNVbTdBwx/dNXNSat9uKkzj8FagnWQXu6b01u?=
 =?us-ascii?Q?lzPrYE9kixuw2pFcULWmsj3OBzcgTReJeMzdUEnyJavjAuxRqG/MiIC+0bU6?=
 =?us-ascii?Q?ZUaPQkX+UsinC8Rtos4I2M1BJ8sVfxZSln/x8ZC0w/8jZ217i+hVUzFakagS?=
 =?us-ascii?Q?gRIO9QJbncjjniLYgQ9BQM2jJM/91kc9u1JZpAsWGhSo2C2XiqDPCrJhFr4q?=
 =?us-ascii?Q?x693npPdnpGJc4dMVTpd1/t25GzpG2+w/kloz5MRVcsKaJGlRLEUJrqua+XH?=
 =?us-ascii?Q?Kz4IV+MTnckadm+zqRgVYviDmtKz26sQKJeCtiRzq7OMRIaygmvFPXTLXGSo?=
 =?us-ascii?Q?CAVfpYI8XZqS8vOrikdWGEQqlivCUvvI5gbBDvUFdUqdwxUYDVWrqQiB7DF4?=
 =?us-ascii?Q?is+hlJyJVktTQtrmn8G5E+DKwyLwu/BAHR/P3Vw1Vf4VaHL/1dlkqiJKZGVt?=
 =?us-ascii?Q?p9m8iNOCZvNEgUk2cLpVvHLHfP2PIQ0nxjHpvUeI67n7eMnNwVn0s4Al/beS?=
 =?us-ascii?Q?ZDHMwMzmFaEjj9T2i07G8n4Gp3nzJUQWBHnp0p5UOrFDijZu0l3N/tV0T8Dp?=
 =?us-ascii?Q?lpvMbhYX1tJJ5m3Icr/aQvpGNWBYiTgm6gGoKccJ0imxIqJ0Ch+faMnTvHQg?=
 =?us-ascii?Q?4Hxjj5sTf5aooQidtXyq7LHiLSL+VwwCjfIfp2P73jCieXUz73BKpA1bXWrD?=
 =?us-ascii?Q?SQvWhT+HwgZvQ8OhA8YVaevOt/cL36IepsVVluvpeR+I2RQXFkqE6LZ0LrQl?=
 =?us-ascii?Q?gXlGTa4mv8ZYDZS/03dOzmrLmxUg6Ond2hRMW+6qCCdnna5kOOeSeRLFvjNX?=
 =?us-ascii?Q?XbPYvXMnpcyThxFfld64ZzLV8jvDzcsWEOIcFOATBtA56x8v1wovFkGqiLlC?=
 =?us-ascii?Q?o1mYJD25fDF8JmJ3B34TDkDffFR8LwOJwea7du0yuHSthRB8VGwQliXdRxNp?=
 =?us-ascii?Q?AyYBi6C7LIJXBMOWWbb+ZK3okzrgoattimLsSjdo2HajlOpq4Y70MZ1XqiS6?=
 =?us-ascii?Q?9EDJzjjW6ezt1G1JzY9sfN6dMJ08WRRj/evv9OMSswjt6q+cQ7wWcIkIhCGO?=
 =?us-ascii?Q?FsROnQfr/ewj50Va8tngmPDBzRAQmutUrsBu+kM4uKF0MXrhIg0TB4k5Spe/?=
 =?us-ascii?Q?0BuYbh5KgDmyORhAcyvvxp3ffOe1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ti43fBnhFsT+iyhcdoToWqKE7huxDhxlNxwGLnXxYFZAtPMye4FquomIfxVt?=
 =?us-ascii?Q?7YN12V5fqjKQSndK/aIMNevi06umrDDToR2rpmJFP/3/QJv4vH8uyWaycdXM?=
 =?us-ascii?Q?2i/n/k02eKPynInntQB0Rt0ItIRCTxj2V2tclmpQCuKk7jSIxTTn3TpeOruy?=
 =?us-ascii?Q?ABahsAeC2Mqev2cswu99rqLgwWODJT17JKV6pFjIz68S2ExcdwT/qEqNmeVJ?=
 =?us-ascii?Q?BRbmyei4to2bXz3DHK8skwESlSmj7f1RVsHf9VrhiwneYgONMWKClbGbcGew?=
 =?us-ascii?Q?GyiGTKuPPbrIn+XSOqzz0bc4OIK4WrevjaoNvzWVEVmbtH3RgOBH9/5w88mI?=
 =?us-ascii?Q?xHxKi727v8iwRXowPh6Voe7e/5eHqyQpoUajVg9v+ScAgGbiTVmHbf7UZ/Xl?=
 =?us-ascii?Q?Dpgm14prdosuJe3fH/c9k6dEQvQXo/G6gkm0BYSmkOdR3Qcr+MoiANzMb1/7?=
 =?us-ascii?Q?NtNwkLdLC3Rn6DNGFMvtU1xu/niXX4EXZ93EaRWPJUatphfV+RnNUraBTBFe?=
 =?us-ascii?Q?7i9szwyghCYV74b9UZyTrAlv+v8YN+1FVgD/GYlj/4TB6n9rq67ikxiqQTMx?=
 =?us-ascii?Q?YnYvWehDAyDUiEeltB+NiUWtmex4ir0ZCIhaK7yH3VKcevXTivcdOdShTanP?=
 =?us-ascii?Q?O0Y4oydJ9sWxhUfT7+xRyU+E+fUeetXYQNYQ2r9gdx8l0dg7v/rD6cFp8cut?=
 =?us-ascii?Q?AsCPODi+D+nZch9gtsPl11B7YCIQwZx15aBqgxsF85haQZ7x4W22H8I/swTX?=
 =?us-ascii?Q?1Jl7xxQ65ukPqXaZZH5D/NlWk/PYqEMArNJr26803q9P4fV5spCEnQnk9v/n?=
 =?us-ascii?Q?q0TaVSk8LFV2OnUp+dB7toI6+88ZSWspIpSdc/pVmq/DX58LsrHMxm7Ui9uE?=
 =?us-ascii?Q?ovPnS4bz8JR9sOiaikxzyZ/cC8VWv3iNIcJ6pftNs3SqfOLpVR+fctT984Ug?=
 =?us-ascii?Q?I4e90K6O/SWfZUjtgWFDk6nzHYT48qTi/y1e0boo2dk2Gik3RqDAg6sJyoWc?=
 =?us-ascii?Q?E9jEt12YUUyLlpDiCQ3zp8GP09Zukl2KHHkK13oiJlLpwFApQg7JjMZVcNPY?=
 =?us-ascii?Q?sQCrFxyso82KePz1d3BDfqviCyAYXnqLDOPWfqySXTuC0vYvx8nQZkTp1ofv?=
 =?us-ascii?Q?2Gty3WQHKlA7LF3GEuzfcRXkT+VoZLmi6V0TXduQE4sw6ZvbfXbWLVGkALx2?=
 =?us-ascii?Q?UHChG3E7fw01ZdlI0FIAI9qQzB9XkR7Zo3WcUY9tSYTwpx2pNcyvVXqHtpqV?=
 =?us-ascii?Q?acbBYsWGsO5PwYM138sFhK5wHRWysDEhGhN8e4LOfownObS6q89SPGZBs4/j?=
 =?us-ascii?Q?S3gpd0lYJ5nCV73rO3uBg+C4q2ND9xGjq6TakCc9nIxmnwKx8pmBShc4nwdi?=
 =?us-ascii?Q?9zyjJQ5/vSxyvoVsFijJmibFy45+OMq973Wm84WR85/y+RPuC+orFoxZlBX3?=
 =?us-ascii?Q?C8RK34aihW4Pty9c601v93oA4CD1SFGBi1GryPwt8gtVn8ROD4pw4TotRfqz?=
 =?us-ascii?Q?/zQcZpFo5ajnIxDbSctLgrrnaVVWy1+Dl2cd2+v32dYo8iNNY7adAdtODGPo?=
 =?us-ascii?Q?xAE/fqyTUscT2GkShg45ysnMoGPka4OFlE1oNRhiz4zwuTyGVKRVR+QaMyDh?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7829ad38-934c-401b-24c6-08dd5a66d96a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:19:54.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNmUCOLqIWpHJAikIhMqjyd0LtErXouZcgZvatslbcwav/ot9d4o5GXj3LZI0TeYM1y8D7Bd1HIkzb2HKCyerDBqEnuhviBeIvzy9XVpHlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
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

On Fri, Feb 28, 2025 at 10:45:56AM -0800, Andre Muezerie wrote:
> Updated meson.build to use common variable cc_avx512_flags.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  config/x86/meson.build | 2 +-
>  lib/acl/meson.build    | 8 ++------
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 

One suggested improvement below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index 47a5b0c04a..12befd4d73 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -14,7 +14,7 @@ if is_linux or cc.get_id() == 'gcc'
>      endif
>  endif
>  
> -cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> +cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw', '-mavx512cd']
>  cc_has_avx512 = false
>  target_has_avx512 = false
>  if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> index fefe131a48..6ba53fbba4 100644
> --- a/lib/acl/meson.build
> +++ b/lib/acl/meson.build
> @@ -55,15 +55,11 @@ if dpdk_conf.has('RTE_ARCH_X86')
>              sources += files('acl_run_avx512.c')
>              cflags += '-DCC_AVX512_SUPPORT'
>  
> -        elif cc.has_multi_arguments('-mavx512f', '-mavx512vl',
> -                    '-mavx512cd', '-mavx512bw')
> -
> +        elif cc.has_multi_arguments(cc_avx512_flags)

existing variable "cc_has_avx512"?

>              avx512_tmplib = static_library('avx512_tmp',
>                  'acl_run_avx512.c',
>                  dependencies: static_rte_eal,
> -                c_args: cflags +
> -                    ['-mavx512f', '-mavx512vl',
> -                     '-mavx512cd', '-mavx512bw'])
> +                c_args: cflags + cc_avx512_flags)
>              objs += avx512_tmplib.extract_objects(
>                      'acl_run_avx512.c')
>              cflags += '-DCC_AVX512_SUPPORT'
> -- 
> 2.48.1.vfs.0.0
> 

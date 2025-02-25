Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A70C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 09:04:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FD28427D0;
	Tue, 25 Feb 2025 10:04:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9590C427B6
 for <dev@dpdk.org>; Tue, 25 Feb 2025 10:04:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740474242; x=1772010242;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ddx0PyRtxdUKOphZkqF5V8B2KycsrjiULnZ0Kvgpe3o=;
 b=YjQfgncJhXO2TF6TcqQ1b6ahjW1A2S8uncPGNigniQI+remEONoNeQsP
 RdH/hErW80+Mtweeo4h+BVipoE2B9wInprxdnyZMW4YUkCyZ78inyU2GE
 SZ2yW2z9OFXwbBG6tpgGJl7R7Y0R/TChMy8oyKRyS1AT3h5jen9CeyzV+
 OWoH6EO8Pog2rqZlW6fcRutNlBwv7sq432b354zeAtAukjqdhPP/sQpFm
 5VeRUEQzUYRB78nuu6aNDQ+d1riBWkeLJxnzBcuXfpmW4Wu3Wfq2Ki6sW
 I7zVBCEqKkdvrYuHPV/9KGVfY+8XH8n+yTLBPl2FQKOv0xD8yr0qoa+9X Q==;
X-CSE-ConnectionGUID: hOMsC2hKRZey2tvZ8fwtnQ==
X-CSE-MsgGUID: 9zrHN+WiSBGgDBAAPlDhYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41402653"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="41402653"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:04:00 -0800
X-CSE-ConnectionGUID: kmOXDYDRTteFSPn8XhQJuQ==
X-CSE-MsgGUID: 6NAPsFUnTK6wZQVzCN7XQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116817080"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2025 01:03:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 01:03:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 01:03:59 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 01:03:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2grY851Fcly5XRcROUH6/V4BT57o+ahGj8fGLDXB/IVPT99jet+lKNQkzhujQSiAeUGS+5362NDsUxrUicDSnaYX6NUqXPXWIxNCqq73H3K+U8M/bR35N3b3rKwl8KBZWEouzvszfi1JQIFInA/H0Bn/1J59FPgdqEdNpgZiCIYuuQeULf3p21Q6XfLD0algClSpIugelb7emNMMdIuv9LFNsKJ9ZAT+Mx1SBV4ydUC6mYPpv1Cwrxp/8h6+7y+cFZKqz6yz7B3/SYwO62+uTDH4WZeP8DzEmWq5uHFs8FLPuUbuIDv4Kf4c7EsAXpozWUoWNSGXdqZDOxq+qJT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j4YH4unoA4DveOEuMoGrfp/Meqc6PaRocZpEwZCNlc=;
 b=w+YdWknTADt5GcQ05AaaU/pwm1Q5HrO/0AVFybIIuKb2wOViM3uxWVRgzYWLl7fiGoRAX2WntDgKTAe4STrz0QX9DFXeEBiFnCbvTSWCfyjvrL/ke2jdXLBW3L4OSV/aT4zHR7OhQloeZMoe5z9SufMV3njU/VXScX4yW0PqA7C5j5GcFbP1COhzLu0RL7OOfLkgdgSKaMQ46cmC1dtMfTa1lEvUqaDYhqJX3y5TbvfU2Pa6o1dTKhMT9N4Nb0YXS9HLtcC+FKvFaWuCw0n1q+r9zGcQ5LuA7E4ly1aID0ME1IyJytL0p/JCACZL7ktQbX1/cBVuM1XSpJnhEUk2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:03:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:03:42 +0000
Date: Tue, 25 Feb 2025 09:03:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH 5/6] acl: make compatible with instruction set updates
 for MSVC
Message-ID: <Z72HaaPEhxfIk2QV@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-6-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740430879-17874-6-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU7P194CA0016.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: b16beff5-9e95-4c04-984a-08dd557b4d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bsoWKx/JEdpT02WlNopfE2rSaHhxHBFBoMIbohIsMGnkz15PcSGz475JQZuk?=
 =?us-ascii?Q?VPT4VkM5q8w6UgCnb/+I4Nx0cjN3nbq8bF/BlAxFzGRQOGx2dgd1aoYXnb21?=
 =?us-ascii?Q?yB2SLLOE7whw+XPVa2r5xB5Uxho0huflZ32ooJ+DY98uv6Qnt6K5EQbHLAA6?=
 =?us-ascii?Q?SVVAG0COIjwNEzcjDEcyJbtrUbg3jFfkB7fiWA7E3e5kgX9Jesira7/1Zkqq?=
 =?us-ascii?Q?8Q8AycU9xg+GQG2admFtUpwKOdhtYw/0L6rMweM66g2lU+3lxnNC4XMNov2b?=
 =?us-ascii?Q?6wCgTZqajZGBbq8ynEd+WtlvXc1j5VFSntdYBjWEWEH97cPVf9NbDX63ilbR?=
 =?us-ascii?Q?mW0SeXPiPWANV4OsooZctXXlUTSSqb1kD6v+5Dljilwk8Da4gcXxFkiLi+uA?=
 =?us-ascii?Q?jqdFFS5OzS2UcBCM7yaqvGZG3mtXR5xSsuL5LKf6aoHP8oRNhaxNdqdP5+6Q?=
 =?us-ascii?Q?pPK5PvWB6gJSFZM3qWF+Itmc+rb/BfCme5kdnz5SEGoBw9Qhg7P/geQyPyLB?=
 =?us-ascii?Q?LisfN/qoR1lXqdu8GmKIgGr7OY1gHGlD5K1+kwXhSafCTOakL7xXp1LYc+Iq?=
 =?us-ascii?Q?rRVd/3n8VVbaCMCgs//DNV2jBF1tABhspSORSLvOC2uHJuhvQkLxaxwXaiY7?=
 =?us-ascii?Q?e4GTAZW+qi+k3sJyOPBIYNY1hW8vbcM1lunR+GsT9DlzLkDtTVaOJZ5XTAbY?=
 =?us-ascii?Q?irE4yDIbc+AiNcZRIkO6ebQPuywdysQRg5W8VfG01h5/+uVBW2M57mexJ/uV?=
 =?us-ascii?Q?R4Yq/WfYeVdI8yPAJbvRVKlGsk5BbKnREjWaJmVoCYbyRczw/7o3rIaUGMwi?=
 =?us-ascii?Q?9F09Q84cu3vZ2JmPbZ8eLGwim532W2A92brT38ZUa//Lnw1Dz5Hd4kvLDW3R?=
 =?us-ascii?Q?gofp1tiq2PTy6wVBjfutCdf4vE5xHgxdN64idp4KPWS9u9juiVwVLzJjqF/w?=
 =?us-ascii?Q?St6N0YmfeON1cpnTF7+/ZdlWa+9fUKj9tTqGgrMKYMSVlt51Yo5eo3vF9nlO?=
 =?us-ascii?Q?fkanpv3UcLJyklCwukh9oNJ+XxrqfjN8HpW8JzdI/YMejWVGD9/gYDzXsklA?=
 =?us-ascii?Q?GnGktHTie1AlSWkUECdKPqWcOeS+LrENRgEY4Npg1BTn8c70KciFHRf7dvNd?=
 =?us-ascii?Q?xFD8G/6ViPBRHGDY2DeuOG0SAiChwxbGxeaWufvS2qXfJuVV8Bae8EP8GKe0?=
 =?us-ascii?Q?7prfWrygS8sxYpED128DnDGTgTEGbt6n6lGFGOOlZhHemN2RIcdXLdS3YZ0t?=
 =?us-ascii?Q?69hNby0ExRL7PxqdahglwRmFscGx8cVHO2tyzm7Y+Si1HseUb6a5AmsKDo60?=
 =?us-ascii?Q?lpTUfiXp7P8MMJsa7QLo7OTzgkE7vr515A6w/t92M4hglqpdtGHZUlTnvFIX?=
 =?us-ascii?Q?Qwjn9CXwLRgkJ14UwANA3W7WgY3i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZFKyDtmaWHCDOF0jhKmItpFVmfeIuKAmZEQ7H5MgX9VGUm8reaD6xVtwekm?=
 =?us-ascii?Q?sFaOD92+b8PmSgwKuKzSPKquszltWFFiV2yLszKpmU+M9P2oXMSS4uBEWwAo?=
 =?us-ascii?Q?2esQIgvrrFsyeanQm8VW4yxet7poHN4gU3qtbrgTDcZPLA2JE1DdzDhbE/W5?=
 =?us-ascii?Q?aezNb/g8Rm1JOdOD61syu+jjt+9IyBDULJT9NjzhJUmLKTUX/iyf8kpRaX43?=
 =?us-ascii?Q?p26LcwhsDfBH5mufAD9a1orj9EAZaqNpMDkeICCLe2ql39wJrmtYJ9TMMDys?=
 =?us-ascii?Q?Vfo/EI+50rCksz3q3XAAulDUhB3B3GStcnLL+kQOeqOUhGFjKzgIpOECXz0I?=
 =?us-ascii?Q?ijVozgy4noL7e3omzni7db4XNXxLuAUZaH+jNP7r7+P2RGotI3g6NB+kyhJA?=
 =?us-ascii?Q?mRszRHadXDgIIMVc6kHJBdC4F28q/OqxeCQPqAPtxgKlJsha5mbWUS+UWuKA?=
 =?us-ascii?Q?pFMwpqjVyI+xYfR0aHD9Ry7PPRQjHFsdELH7afvHIhy15rjeddLlL6EJYcSL?=
 =?us-ascii?Q?fmEHUhHBxFPyV44DcMVimIMkAkre398DmFzzyRfvUG9OvawbVe9t04B+amQs?=
 =?us-ascii?Q?BHA8FipXKspI67osLxm7YowMh4m6r4QzKU7XksnfUNDaTbNweFI2KipDG34F?=
 =?us-ascii?Q?1J2Ok+pfIKmDnGej+ZyAULtO5ham0dFitHvNbB+vDcDbf5Sb5f2NYnt4jb+6?=
 =?us-ascii?Q?wPAaNUrdUAIblNWoTQ79XHFhbn7u28N1wsMVaTMdQecYY9pREfC7oFyyGRhN?=
 =?us-ascii?Q?xzq4VKPogZ8fgbTuFP9ca85YiFeZugVhDPavcqr1n7dELjosepDF518R6+O3?=
 =?us-ascii?Q?pHnWxpTWm5C4bnD0ooxLcn+k03oVm3BX5UCwySKjhhqwVq8XUnpFTAkH6u1i?=
 =?us-ascii?Q?wL2KCVVZHGBnxyjDhtiLBOR0lgVqig55MckO6ZF0RjbuSG+wsXNUn/oCOzEu?=
 =?us-ascii?Q?wuSs/Lmw6u/hSDSg2tSifvr1HsrVNHROVQbHnPLbpdiw6wpzz47Bop63YhfV?=
 =?us-ascii?Q?qSElXsQQVhpY2zayY+rLyCROHnt22jqbzOpp8P7QLTbdxi4DLNdKGmO5EHB7?=
 =?us-ascii?Q?Y5me4cNg+svrImuPCDKAVHWMKFim9AFDFDcKdkwSyxMVC7rLaNFNAhRi51E4?=
 =?us-ascii?Q?lmGYQRhcFmdII3xWOWQmomWt2mXOmNiLZOPe+D+lUvF6fROXinIYECkOblFw?=
 =?us-ascii?Q?GT0hddwVwv++3iuYASGAeK3iu1yb+Gz5es+olJ/LQUUPo4RSzOhhG/X0GTyO?=
 =?us-ascii?Q?YN96WKKjf7nR8PmMhgL8HqrVzaQJVGjKKlr2+9D38YiqCkZhii0IrrGLEsh5?=
 =?us-ascii?Q?hX8YBymxAtdgIz4Diq8H48+S3hiC2jjaDAD0OxSO+wMYoRSULY2QNTADMi71?=
 =?us-ascii?Q?TKy3E5f9KjP2Q7pa2u2jvn3LKnHOvTYePu3APe0mqgP4qSKWESV9wtgcMZ+J?=
 =?us-ascii?Q?TIFTI4LqHqKU8LhMLHgVx896vx7CZR2YqBsISNM6J6BR2jiw749vBRQIx1/Y?=
 =?us-ascii?Q?MWV49qXceaRHZ7s1IYUgigMuUz2anXlBiV/907IupKxAfUv2qVxEUvksjXpZ?=
 =?us-ascii?Q?QMwjXUQA5kErmocvpMQL8vKZdXOhVOHmpkbv9QYFSkZ1i3cZ2m8HLlrC1l/I?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b16beff5-9e95-4c04-984a-08dd557b4d07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:03:42.0597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZwdZeCVgNyAnb4Ay8pEiHlzfXTi30CTS0a8DhsXfXIS5XBgulbMhU2huY0xDlqHftRuh8YOCQSDXa/MbVwQUV0KfMwBRChyfwh0MMRbTB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
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

On Mon, Feb 24, 2025 at 01:01:18PM -0800, Andre Muezerie wrote:
> Top level 'cc_avx2_flags' was created and holds the correct flags
> depending on the compiler used.
> 
> File meson.build was updated to handle the correct AVX512 flags
> depending on compiler used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/acl/meson.build | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> index fefe131a48..24e47b6cc1 100644
> --- a/lib/acl/meson.build
> +++ b/lib/acl/meson.build
> @@ -19,7 +19,7 @@ if dpdk_conf.has('RTE_ARCH_X86')
>      avx2_tmplib = static_library('avx2_tmp',
>              'acl_run_avx2.c',
>              dependencies: static_rte_eal,
> -            c_args: cflags + ['-mavx2'])
> +            c_args: [cflags, cc_avx2_flags])
>      objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
>  
>      # compile AVX512 version if:
> @@ -38,6 +38,12 @@ if dpdk_conf.has('RTE_ARCH_X86')
>          # compiler flags, and then have the .o file from static lib
>          # linked into main lib.
>  
> +        if is_ms_compiler
> +            acl_avx512_args = cc_avx512_flags
> +        else
> +            acl_avx512_args = ['-mavx512f', '-mavx512vl', '-mavx512cd', '-mavx512bw']
> +        endif
> +

in the non-msvc case are these flags not the same as cc_avx512_flags too?
If so, let's just get rid of the acl_avx512_args variable generally.

/Bruce


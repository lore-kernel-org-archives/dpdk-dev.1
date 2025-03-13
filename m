Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697EC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:27:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF0254114B;
	Thu, 13 Mar 2025 18:27:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 17EBB41141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741886834; x=1773422834;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DwnA8qIynkFAqOPdU59UewUJBw8hXcJmIHiElV+siK0=;
 b=Budj57SgWEqQ6NPLM7AoXzt6j3kbyuTBw1GKpcCctfafjoMtCzQb2dWZ
 8s3lDqXc8iSGckMnDUnT8qz8syLUlYhDz2uAxnVbJIApqUUwRJJ+UkLFH
 xeezT0uk6iC6TWDqhPEAJDvMnbQYf9N1qXTsqJQMvJt5IoxOmghmjD/5C
 OEIYktYWx9HKbaKz2Gw3pO+wYruGk1PMbVKkWA3+AG4wlv1QMN/uAMcMG
 SX6bBaOLiTJkomueiVZxy7nldnNHfu7LOc6NxyketH8RnTqr8RMpJsev1
 OGdvCtCRc0uCFgnN3X8omfxYgC/HHoLsTmLxPYZjV5DS2+SNZqb+561cD g==;
X-CSE-ConnectionGUID: o55pOfM1TGG2HRqD3qKFJg==
X-CSE-MsgGUID: IGMwfg1PQKypXtzIaPAVDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43121856"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="43121856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:27:13 -0700
X-CSE-ConnectionGUID: gIyW3WAsTqqqBvdC+++Tvw==
X-CSE-MsgGUID: vjZLU6gVSMGWcbR4tdFAIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="125905538"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2025 10:27:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 10:27:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 10:27:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 10:27:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5rThPLUDg1JQG2/LdpyoCqnYNhJNZVpkFQEgb5Prc2zeCeTpEFOnRoeafQRnUIlA/SnX1CQ71rPVJqrTi/ggBXSIPp83YTDzfg8WuQRFIHpwuZi/Dx8aRrFi/ZbzwPQsO7/fnGM3QZuXpz3pu9Y9bZ3qw/bkuOTvr16YQnPq6wRz3Eqyvyne9f1PVF8143kJbgxgn55XyAkt88IxDxoco+3alCjTACnlnRhn6r+Xc0SqImJ3kjmwLJcMFOJDuNRXzHjJjckq/tAR2NU7yMJdY8jPuCCJ4gXeeP8FkpJxiVLy8ON+p5bsehCtKJymRyke/xcdOwaELJx+kFYcHRMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJTKI59TKa1010cdoWsX0rFhldH/FilC0eVB80wJrd8=;
 b=TPcwarm8M+IG87iJCZbv/KOdQgZVsbh4cd0hhEbY//aozijv+TVvNNYZKD4nlbVSK1Y8JBMQnSPTf+/c6yjqpCf+Ohw/EIJincDecYw8jqHNHKngTyJd9XMelayXn98yhpriXW87Ak1Ycmq7G4h9s5Ps/3VhAgHBtCAxyXlUzX8syRN6ILwO1WFOMH/1XYoZlqSWl4ms1tgCSQg1v9oUuVsmUkcrs9fVVX4OPKv5EpNKDT9GCzVeSMzWD2bniI0kzbtOROzfH8vKE/0ly39BrokIonl41TNiERLW2+bCtnMuDRK7HX+p7MLB6Sf73sFk7a+QJaNJ68DajL/GMbQ4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 17:26:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 17:26:52 +0000
Date: Thu, 13 Mar 2025 17:26:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <andremue@linux.microsoft.com>
Subject: Re: [RFC v3 5/8] build: generate symbol maps
Message-ID: <Z9MVVzHCtYaVy2AV@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311095609.194523-6-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0237.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b98e26d-6a20-4c3a-f4ce-08dd62543e4e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+zPH8555hkszAoTAQAARqbG0fYbR98h/iUJxi6BbRvFCtYK+iFlTvYzhBYY0?=
 =?us-ascii?Q?CfvXCCqCWIMMF4ab5t6uIanhYbGqQphB731G0apxjaXbXsgmAtlIalyKwhgt?=
 =?us-ascii?Q?4fWuEfmY7sJ6xPBdIwVuNLr+BM3TRvlkmBjDvqUghBsh0rPR8s7mK2bEVeTy?=
 =?us-ascii?Q?VkH8d4+B/dJuKoXqTd+SHHN0maxsXfiODZ0RC1/Nmw/KzLaf0vMvwfLIwxIT?=
 =?us-ascii?Q?oDcCWI6zH1FuSOycbPqTdR55cZ8Un1CPNvtvKwBYikiuySeHTBcqnfZaDGvA?=
 =?us-ascii?Q?y3o7X0UjP9eiXOrj+/WAIpI/iphH8aUjaqJjGfqXvLuT5gwjbrH6JCDtJjYx?=
 =?us-ascii?Q?cMQtPVLJ4QDw7wKMn14ZEH2oBzaELaXOjcFd5ReLJZaWS3LqA7KeO5k7OZu6?=
 =?us-ascii?Q?Yy4KDRyg+J57vaeQqgBsTEf3gHjszPK5g8w3Cp4duzVrVf08d1A0dAwACeWv?=
 =?us-ascii?Q?v/rYwlHRL0KXGkXoxxD5KPjYKCYXvRmACC8I0zaWGAxxzpc1G3XJlYkXaFHm?=
 =?us-ascii?Q?slzhFMvlcyc0JSS9DY87v9dTIi3BRMXSmwA5CHJ6tpbuRjUJ7pQojU3Tiseu?=
 =?us-ascii?Q?Hha21nCMH7SEpLr7cMN5Fr681oRVlmISwfUXwCcAU2NMUbbvsn4kwy9nPBe3?=
 =?us-ascii?Q?Z4ySrk0FYsd2fl9b6i4KdLEWo44deoLhGbH/eB/n3qbKk2GDjgF5jzrw2Gzr?=
 =?us-ascii?Q?PITksW6UPpvIZTyIm36ws4Jes8p9FDIXf68c6O0QPGwKM7CZFhPNu8mOndR+?=
 =?us-ascii?Q?RobdY1lSdUJcxiT2EzoGLwSffd2aTNcv8I6isoadc1msWnyKOCdmUZhy0umB?=
 =?us-ascii?Q?xV426bBfc5my8taqRbXNtZ5g5AqZBRwoclXNdECgxPl+y1UaILD5T2XDRFkk?=
 =?us-ascii?Q?87CrMn7c9j8RZr/1igj7saqgobWEGwaIIBtuai95Pg2PqoQPzSukqCy/v7tU?=
 =?us-ascii?Q?1/0zAva9S9yjyBz2A6f4yg2nA9S/A40Em94NhoYKn6N3dFvSX0nqKiYRJH2L?=
 =?us-ascii?Q?iUzkCZKNi4mwttak8b4oL45vhv+dYPc4MOff4hZx6iVdsYobdtA3F7qnzA43?=
 =?us-ascii?Q?cLb8lEFgcFB+xkIia5Q7vZ8EN1QOLsP2Ukm5E+dhOBFDMH8MsZMA8COXRxuf?=
 =?us-ascii?Q?tF3zzQ4Q8LtwBXXLJx2LoB7yBOxZX0lIAk66zNEoEAoXU9yJfrpDTxnMShhs?=
 =?us-ascii?Q?CKQs0jU2oAuujYMjeD0/kBXHmetmYxm2c+DrIFHiEsHPV/rq1z0AlNFOgur7?=
 =?us-ascii?Q?HjgKFRJbwLSHCMXs4w12tJnO/fzEQjVdv/0fPJADIr+35P/e0B8g6tsNFjLS?=
 =?us-ascii?Q?oAhmjDpe62CYWjo0KEnf2+zYqCB994Istv8+W878kBDvj1dlH8JdeQANGwDL?=
 =?us-ascii?Q?yTd+ma4Oo/Z9vLhZRiOquIzVzH72?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LCgawEa17bcb40VX/+B57a4bDfWjWdR44wCbjgvwMUEhTADAP2rrzNriq66?=
 =?us-ascii?Q?Q/go3QXrUe3aVnVlu5Y7rJCdwK+LgnefvZf4w89WemjyXBy1+r7KuqZOVUfW?=
 =?us-ascii?Q?Tjxy2StOUN7jcjxENUgFWe23Yp9ffUxIA6wlhbcZsoJGIg0OepRQ6KcsEoGr?=
 =?us-ascii?Q?JKIn6FWJEn17TTzoGAsHIWw0DpNQNKPLZvYQdvjrSQr+n9kIqfb+JxbANmlx?=
 =?us-ascii?Q?bRWyw1L/yrND9le54Jme7tl8sRtidG2LwfNMZhmx+g8/US3LJA4Auk/ks8nJ?=
 =?us-ascii?Q?oulHLFC3WXYsJsYXWseU07+nPZydFEKtgT6B4ahuZdrX+NK/ZjO/zuVanNah?=
 =?us-ascii?Q?n+7b6ATmHLwbgmyW5YTaZsnKE4TwnetyTveZ5fzXJ7xI3LWJhSo0ANsd5xVF?=
 =?us-ascii?Q?JHB7dTK4vvjgVG1833BQhxYNC6vAQUwtFkjcVeEho43OgXXwMZ1N1qI6O6X4?=
 =?us-ascii?Q?15kfAwp88ISHkGuZG/VyljocomXaAfujU+9PADmoQSSuCWQGPBB2f+L8M75Z?=
 =?us-ascii?Q?IDvWvl3ZqErBqKXDTALotI0D93R0VZ4IkM5fHpOvfyId9pxnb34BuP7JCEQ5?=
 =?us-ascii?Q?nSALLDhQ0eCRGfcP3WhRip7Cto+fk7X7IrLpnmdwXO2u8YNoKx6+57oGng/w?=
 =?us-ascii?Q?yoOHfotsyNmuyaJdJHjYdsu8RSKXOA6qbo/PWiWTM8w5yA0rB9G65tWu3Ma8?=
 =?us-ascii?Q?BXrTYfbVLPgmbTKAeydodTbcxt4wMz8EopiwdhuqX0rDfjXl0zXPuMtyrP5s?=
 =?us-ascii?Q?nUgAmM/Y+piQzvz0wu7bfRnYz/HmrFywfgbhBPp0Wh2xe497Ue5uVwwDYGj7?=
 =?us-ascii?Q?QzGBax6rIHqwrVbcwUhgQmGYWmJjzTLOLzF0wMvlLB8k58Hw1dpCj2fnKdoo?=
 =?us-ascii?Q?rzokqmyTI19ZTBlGDDkBqM4WvW401VNdFYIpsk6TJP1Kb97NLEdn5iIydmGx?=
 =?us-ascii?Q?TO7hrPHniR43X6me0EI6o+Q8soYRfo5eaR16iiBOgVzA0gmrFZdT/eERIAD8?=
 =?us-ascii?Q?geKhJjWXMDVhFJ1pRT7vXacCmpAiMIeNxPSg0LF+x4KwftKBxAHwSh52qFmz?=
 =?us-ascii?Q?StJFJ+1ndKD3C8OCSlQIyNVSnn/x+7zMmeIQW+w0HPv5taynuV+b3Wf9Nd5n?=
 =?us-ascii?Q?HR02+UKfeYwSRuGp7J5MFiR8wepaCviILPihGGgWaN8JVTdk4fCAkoJq1UGr?=
 =?us-ascii?Q?mNPuMfJII4ET1h1a0FRVXZS99sFAbKxRg79HcysZWBVrR36eTDTxiqGoFeFS?=
 =?us-ascii?Q?7Nk5iUdw94v2oighOJrWmM7cqCaf2347lhny9xPc4gOCPHjCXMXNuzj9MOXz?=
 =?us-ascii?Q?r4JZnRjjOOvUK5CuEkWWCkvOpWlCIdwznRICJ286Zdp3oPDfbZ36HZ4DAiHM?=
 =?us-ascii?Q?SiNlg3ggx16xPLiNt7u03+eKFZdZZV9621oYj382/foo6VP8MoAehkvXWcpZ?=
 =?us-ascii?Q?TtcJj55HWc8pJ4/atQRFRgu6UBpVtPwlHkPeRso1mSEW82Of+FTmVFn57YUr?=
 =?us-ascii?Q?Hn7MsEKvNjR3u9n7iunOKUEFbo6lTPVK0xP1eER3i6SVw9eYcu+vWW3ql1vG?=
 =?us-ascii?Q?ABRROh28jJDe06ieWq6wZ2yAcABkOfaU1CGVlCI6Lr4Iirr/7y5BPbXeIkKk?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b98e26d-6a20-4c3a-f4ce-08dd62543e4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:26:52.0946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gadVp1lAW+RE+5D0v1FloHcQR9hKffh+UUAcSv+Z+25+Eh7CxcfzxS6amHlxzZLLt1oCN3q9t08k7dHg4MEa5dTGMH5g3KbkJabP5YAe8uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
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

On Tue, Mar 11, 2025 at 10:56:03AM +0100, David Marchand wrote:
> Rather than maintain a file in parallel of the code, symbols to be
> exported can be marked with a token RTE_EXPORT_*SYMBOL.
> 
> From those marks, the build framework generates map files only for
> symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> becomes unnecessary).
> 
> The build framework directly creates a map file in the format that the
> linker expects (rather than converting from GNU linker to MSVC linker).
> 
> Empty maps are allowed again as a replacement for drivers/version.map.
> 
> The symbol check is updated to only support the new format.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Some comments inline below.
/Bruce

> ---
> Changes since RFC v2:
> - because of MSVC limitations wrt macro passed via cmdline,
>   used an internal header for defining RTE_EXPORT_* macros,
> - updated documentation and tooling,
> 
> ---
>  MAINTAINERS                                |   2 +
>  buildtools/gen-version-map.py              | 111 ++++++++++
>  buildtools/map-list-symbol.sh              |  10 +-
>  buildtools/meson.build                     |   1 +
>  config/meson.build                         |   2 +
>  config/rte_export.h                        |  16 ++
>  devtools/check-symbol-change.py            |  90 +++++++++
>  devtools/check-symbol-maps.sh              |  14 --
>  devtools/checkpatches.sh                   |   2 +-
>  doc/guides/contributing/abi_versioning.rst | 224 ++-------------------
>  drivers/meson.build                        |  94 +++++----
>  drivers/version.map                        |   3 -
>  lib/meson.build                            |  91 ++++++---
>  13 files changed, 371 insertions(+), 289 deletions(-)
>  create mode 100755 buildtools/gen-version-map.py
>  create mode 100644 config/rte_export.h
>  create mode 100755 devtools/check-symbol-change.py
>  delete mode 100644 drivers/version.map
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 312e6fcee5..04772951d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -95,6 +95,7 @@ F: devtools/check-maintainers.sh
>  F: devtools/check-forbidden-tokens.awk
>  F: devtools/check-git-log.sh
>  F: devtools/check-spdx-tag.sh
> +F: devtools/check-symbol-change.py
>  F: devtools/check-symbol-change.sh
>  F: devtools/check-symbol-maps.sh
>  F: devtools/checkpatches.sh
> @@ -127,6 +128,7 @@ F: config/
>  F: buildtools/check-symbols.sh
>  F: buildtools/chkincs/
>  F: buildtools/call-sphinx-build.py
> +F: buildtools/gen-version-map.py
>  F: buildtools/get-cpu-count.py
>  F: buildtools/get-numa-count.py
>  F: buildtools/list-dir-globs.py
> diff --git a/buildtools/gen-version-map.py b/buildtools/gen-version-map.py
> new file mode 100755
> index 0000000000..b160aa828b
> --- /dev/null
> +++ b/buildtools/gen-version-map.py
> @@ -0,0 +1,111 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (c) 2024 Red Hat, Inc.
> +
> +"""Generate a version map file used by GNU or MSVC linker."""
> +

While it's an internal build script not to be run by users directly, I
believe a short one-line usage here might be useful, since the code below
is directly referencing sys.argv[N] values. That makes it easier for the
user to know what they are.

Alternatively, assign them to proper names at the top of the script e.g.:
	scriptname, link_mode, abi_version_file, output, *input = sys.argv

Final alternative (which may be a bit overkill) is to use argparse.

> +import re
> +import sys
> +
> +# From rte_export.h
> +export_exp_sym_regexp = re.compile(r"^RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+), ([0-9]+.[0-9]+)\)")
> +export_int_sym_regexp = re.compile(r"^RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
> +export_sym_regexp = re.compile(r"^RTE_EXPORT_SYMBOL\(([^)]+)\)")
> +# From rte_function_versioning.h
> +ver_sym_regexp = re.compile(r"^RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
> +ver_exp_sym_regexp = re.compile(r"^RTE_VERSION_EXPERIMENTAL_SYMBOL\([^,]+, ([^,]+),")
> +default_sym_regexp = re.compile(r"^RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
> +
> +with open(sys.argv[2]) as f:
> +    abi = 'DPDK_{}'.format(re.match("([0-9]+).[0-9]", f.readline()).group(1))
> +
> +symbols = {}
> +
> +for file in sys.argv[4:]:
> +    with open(file, encoding="utf-8") as f:
> +        for ln in f.readlines():
> +            node = None
> +            symbol = None
> +            comment = None
> +            if export_exp_sym_regexp.match(ln):
> +                node = 'EXPERIMENTAL'
> +                symbol = export_exp_sym_regexp.match(ln).group(1)
> +                comment = ' # added in {}'.format(export_exp_sym_regexp.match(ln).group(2))
> +            elif export_int_sym_regexp.match(ln):
> +                node = 'INTERNAL'
> +                symbol = export_int_sym_regexp.match(ln).group(1)
> +            elif export_sym_regexp.match(ln):
> +                node = abi
> +                symbol = export_sym_regexp.match(ln).group(1)
> +            elif ver_sym_regexp.match(ln):
> +                node = 'DPDK_{}'.format(ver_sym_regexp.match(ln).group(1))
> +                symbol = ver_sym_regexp.match(ln).group(2)
> +            elif ver_exp_sym_regexp.match(ln):
> +                node = 'EXPERIMENTAL'
> +                symbol = ver_exp_sym_regexp.match(ln).group(1)
> +            elif default_sym_regexp.match(ln):
> +                node = 'DPDK_{}'.format(default_sym_regexp.match(ln).group(1))
> +                symbol = default_sym_regexp.match(ln).group(2)
> +
> +            if not symbol:
> +                continue
> +
> +            if node not in symbols:
> +                symbols[node] = {}
> +            symbols[node][symbol] = comment
> +
> +if sys.argv[1] == 'msvc':
> +    with open(sys.argv[3], "w") as outfile:
> +        outfile.writelines(f"EXPORTS\n")
> +        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
> +            if key not in symbols:
> +                continue
> +            for symbol in sorted(symbols[key].keys()):
> +                outfile.writelines(f"\t{symbol}\n")
> +            del symbols[key]
> +else:
> +    with open(sys.argv[3], "w") as outfile:
> +        local_token = False
> +        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
> +            if key not in symbols:
> +                continue
> +            outfile.writelines(f"{key} {{\n\tglobal:\n\n")
> +            for symbol in sorted(symbols[key].keys()):
> +                if sys.argv[1] == 'mingw' and symbol.startswith('per_lcore'):
> +                    prefix = '__emutls_v.'
> +                else:
> +                    prefix = ''
> +                outfile.writelines(f"\t{prefix}{symbol};")
> +                comment = symbols[key][symbol]
> +                if comment:
> +                    outfile.writelines(f"{comment}")
> +                outfile.writelines("\n")

How about using "" rather than None for the default comment so you can
always just do a print of "{prefix}{symbol};{comment}\n". The fact that
writelines doesn't output a "\n" is a little confusing here, so maybe use
"print" instead.

	print("f\t{prefix}{symbol};{comment}", file=outfile)

> +            outfile.writelines("\n")
> +            if not local_token:
> +                outfile.writelines("\tlocal: *;\n")
> +                local_token = True
> +            outfile.writelines("};\n")
> +            del symbols[key]
> +        for key in sorted(symbols.keys()):
> +            outfile.writelines(f"{key} {{\n\tglobal:\n\n")
> +            for symbol in sorted(symbols[key].keys()):
> +                if sys.argv[1] == 'mingw' and symbol.startswith('per_lcore'):
> +                    prefix = '__emutls_v.'
> +                else:
> +                    prefix = ''
> +                outfile.writelines(f"\t{prefix}{symbol};")
> +                comment = symbols[key][symbol]
> +                if comment:
> +                    outfile.writelines(f"{comment}")
> +                outfile.writelines("\n")
> +            outfile.writelines(f"}} {abi};\n")
> +            if not local_token:
> +                outfile.writelines("\tlocal: *;\n")
> +                local_token = True
> +            del symbols[key]
> +        # No exported symbol, add a catch all
> +        if not local_token:
> +            outfile.writelines(f"{abi} {{\n")
> +            outfile.writelines("\tlocal: *;\n")
> +            local_token = True
> +            outfile.writelines("};\n")
> diff --git a/buildtools/map-list-symbol.sh b/buildtools/map-list-symbol.sh
> index eb98451d8e..0829df4be5 100755
> --- a/buildtools/map-list-symbol.sh
> +++ b/buildtools/map-list-symbol.sh
> @@ -62,10 +62,14 @@ for file in $@; do
>  		if (current_section == "") {
>  			next;
>  		}
> +		symbol_version = current_version
> +		if (/^[^}].*[^:*]; # added in /) {
> +			symbol_version = $5
> +		}
>  		if ("'$version'" != "") {
> -			if ("'$version'" == "unset" && current_version != "") {
> +			if ("'$version'" == "unset" && symbol_version != "") {
>  				next;
> -			} else if ("'$version'" != "unset" && "'$version'" != current_version) {
> +			} else if ("'$version'" != "unset" && "'$version'" != symbol_version) {
>  				next;
>  			}
>  		}
> @@ -73,7 +77,7 @@ for file in $@; do
>  		if ("'$symbol'" == "all" || $1 == "'$symbol'") {
>  			ret = 0;
>  			if ("'$quiet'" == "") {
> -				print "'$file' "current_section" "$1" "current_version;
> +				print "'$file' "current_section" "$1" "symbol_version;
>  			}
>  			if ("'$symbol'" != "all") {
>  				exit 0;
> diff --git a/buildtools/meson.build b/buildtools/meson.build
> index 4e2c1217a2..b745e9afa4 100644
> --- a/buildtools/meson.build
> +++ b/buildtools/meson.build
> @@ -16,6 +16,7 @@ else
>      py3 = ['meson', 'runpython']
>  endif
>  echo = py3 + ['-c', 'import sys; print(*sys.argv[1:])']
> +gen_version_map = py3 + files('gen-version-map.py')
>  list_dir_globs = py3 + files('list-dir-globs.py')
>  map_to_win_cmd = py3 + files('map_to_win.py')
>  sphinx_wrapper = py3 + files('call-sphinx-build.py')
> diff --git a/config/meson.build b/config/meson.build
> index f31fef216c..54657055fb 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -303,8 +303,10 @@ endif
>  # add -include rte_config to cflags
>  if is_ms_compiler
>      add_project_arguments('/FI', 'rte_config.h', language: 'c')
> +    add_project_arguments('/FI', 'rte_export.h', language: 'c')
>  else
>      add_project_arguments('-include', 'rte_config.h', language: 'c')
> +    add_project_arguments('-include', 'rte_export.h', language: 'c')
>  endif
>  
>  # enable extra warnings and disable any unwanted warnings
> diff --git a/config/rte_export.h b/config/rte_export.h
> new file mode 100644
> index 0000000000..83d871fe11
> --- /dev/null
> +++ b/config/rte_export.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Red Hat, Inc.
> + */
> +
> +#ifndef RTE_EXPORT_H
> +#define RTE_EXPORT_H
> +
> +/* *Internal* macros for exporting symbols, used by the build system.
> + * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
> + * version this symbol was introduced in.
> + */
> +#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(a, ver)
> +#define RTE_EXPORT_INTERNAL_SYMBOL(a)
> +#define RTE_EXPORT_SYMBOL(a)
> +
> +#endif /* RTE_EXPORT_H */
> diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
> new file mode 100755
> index 0000000000..09709e4f06
> --- /dev/null
> +++ b/devtools/check-symbol-change.py
> @@ -0,0 +1,90 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (c) 2025 Red Hat, Inc.
> +
> +"""Check exported symbols change in a patch."""
> +
> +import re
> +import sys
> +
> +file_header_regexp = re.compile(r"^(\-\-\-|\+\+\+) [ab]/(lib|drivers)/([^/]+)/([^/]+)")
> +# From rte_export.h
> +export_exp_sym_regexp = re.compile(r"^.RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+),")
> +export_int_sym_regexp = re.compile(r"^.RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
> +export_sym_regexp = re.compile(r"^.RTE_EXPORT_SYMBOL\(([^)]+)\)")
> +# TODO, handle versioned symbols from rte_function_versioning.h
> +# ver_sym_regexp = re.compile(r"^.RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
> +# ver_exp_sym_regexp = re.compile(r"^.RTE_VERSION_EXPERIMENTAL_SYMBOL\([^,]+, ([^,]+),")
> +# default_sym_regexp = re.compile(r"^.RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
> +
> +symbols = {}
> +
> +for file in sys.argv[1:]:
> +    with open(file, encoding="utf-8") as f:
> +        for ln in f.readlines():
> +            if file_header_regexp.match(ln):
> +                if file_header_regexp.match(ln).group(2) == "lib":
> +                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3))
> +                elif file_header_regexp.match(ln).group(3) == "intel":
> +                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3, 4))
> +                else:
> +                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3))
> +
> +                if lib not in symbols:
> +                    symbols[lib] = {}
> +                continue
> +
> +            if export_exp_sym_regexp.match(ln):
> +                symbol = export_exp_sym_regexp.match(ln).group(1)
> +                node = 'EXPERIMENTAL'
> +            elif export_int_sym_regexp.match(ln):
> +                node = 'INTERNAL'
> +                symbol = export_int_sym_regexp.match(ln).group(1)
> +            elif export_sym_regexp.match(ln):
> +                symbol = export_sym_regexp.match(ln).group(1)
> +                node = 'stable'
> +            else:
> +                continue
> +
> +            if symbol not in symbols[lib]:
> +                symbols[lib][symbol] = {}
> +            added = ln[0] == '+'
> +            if added and 'added' in symbols[lib][symbol] and node != symbols[lib][symbol]['added']:
> +                print(f"{symbol} in {lib} was found in multiple ABI, please check.")
> +            if not added and 'removed' in symbols[lib][symbol] and node != symbols[lib][symbol]['removed']:
> +                print(f"{symbol} in {lib} was found in multiple ABI, please check.")
> +            if added:
> +                symbols[lib][symbol]['added'] = node
> +            else:
> +                symbols[lib][symbol]['removed'] = node
> +
> +    for lib in sorted(symbols.keys()):
> +        error = False
> +        for symbol in sorted(symbols[lib].keys()):
> +            if 'removed' not in symbols[lib][symbol]:
> +                # Symbol addition
> +                node = symbols[lib][symbol]['added']
> +                if node == 'stable':
> +                    print(f"ERROR: {symbol} in {lib} has been added directly to stable ABI.")
> +                    error = True
> +                else:
> +                    print(f"INFO: {symbol} in {lib} has been added to {node} ABI.")
> +                continue
> +
> +            if 'added' not in symbols[lib][symbol]:
> +                # Symbol removal
> +                node = symbols[lib][symbol]['added']
> +                if node == 'stable':
> +                    print(f"INFO: {symbol} in {lib} has been removed from stable ABI.")
> +                    print(f"Please check it has gone though the deprecation process.")
> +                continue
> +
> +            if symbols[lib][symbol]['added'] == symbols[lib][symbol]['removed']:
> +                # Symbol was moved around
> +                continue
> +
> +            # Symbol modifications
> +            added = symbols[lib][symbol]['added']
> +            removed = symbols[lib][symbol]['removed']
> +            print(f"INFO: {symbol} in {lib} is moving from {removed} to {added}")
> +            print(f"Please check it has gone though the deprecation process.")
> diff --git a/devtools/check-symbol-maps.sh b/devtools/check-symbol-maps.sh
> index 6121f78ec6..fcd3931e5d 100755
> --- a/devtools/check-symbol-maps.sh
> +++ b/devtools/check-symbol-maps.sh
> @@ -60,20 +60,6 @@ if [ -n "$local_miss_maps" ] ; then
>      ret=1
>  fi
>  
> -find_empty_maps ()
> -{
> -    for map in $@ ; do
> -        [ $(buildtools/map-list-symbol.sh $map | wc -l) != '0' ] || echo $map
> -    done
> -}
> -
> -empty_maps=$(find_empty_maps $@)
> -if [ -n "$empty_maps" ] ; then
> -    echo "Found empty maps:"
> -    echo "$empty_maps"
> -    ret=1
> -fi
> -
>  find_bad_format_maps ()
>  {
>      abi_version=$(cut -d'.' -f 1 ABI_VERSION)
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index 003bb49e04..7dcac7c8c9 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -33,7 +33,7 @@ VOLATILE,PREFER_PACKED,PREFER_ALIGNED,PREFER_PRINTF,STRLCPY,\
>  PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
>  SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
>  LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
> -NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG"
> +NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL"
>  options="$options $DPDK_CHECKPATCH_OPTIONS"
>  
>  print_usage () {
> diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
> index 88dd776b4c..addbb24b9e 100644
> --- a/doc/guides/contributing/abi_versioning.rst
> +++ b/doc/guides/contributing/abi_versioning.rst
> @@ -58,12 +58,12 @@ persists over multiple releases.
>  
>  .. code-block:: none
>  
> - $ head ./lib/acl/version.map
> + $ head ./build/lib/librte_acl_exports.map

I must admit I'm not a fan of these long filenames. How about just
"acl_exports.map"?

>   DPDK_21 {
>          global:
>   ...
>  
> - $ head ./lib/eal/version.map
> + $ head ./build/lib/librte_eal_exports.map
>   DPDK_21 {
>          global:
>   ...
> @@ -77,7 +77,7 @@ that library.
>  
>  .. code-block:: none
>  
> - $ head ./lib/acl/version.map
> + $ head ./build/lib/librte_acl_exports.map
>   DPDK_21 {
>          global:
>   ...
> @@ -88,7 +88,7 @@ that library.
>   } DPDK_21;
>   ...
>  
> - $ head ./lib/eal/version.map
> + $ head ./build/lib/librte_eal_exports.map
>   DPDK_21 {
>          global:
>   ...
> @@ -100,12 +100,12 @@ how this may be done.
>  
>  .. code-block:: none
>  
> - $ head ./lib/acl/version.map
> + $ head ./build/lib/librte_acl_exports.map
>   DPDK_22 {
>          global:
>   ...
>  
> - $ head ./lib/eal/version.map
> + $ head ./build/lib/librte_eal_exports.map
>   DPDK_22 {
>          global:
>   ...
> @@ -134,8 +134,7 @@ linked to the DPDK.
>  
>  To support backward compatibility the ``rte_function_versioning.h``
>  header file provides macros to use when updating exported functions. These
> -macros are used in conjunction with the ``version.map`` file for
> -a given library to allow multiple versions of a symbol to exist in a shared
> +macros allow multiple versions of a symbol to exist in a shared
>  library so that older binaries need not be immediately recompiled.
>  
>  The macros are:
> @@ -169,6 +168,7 @@ Assume we have a function as follows
>    * Create an acl context object for apps to
>    * manipulate
>    */
> + RTE_EXPORT_SYMBOL(rte_acl_create)
>   struct rte_acl_ctx *
>   rte_acl_create(const struct rte_acl_param *param)
>   {
> @@ -187,6 +187,7 @@ private, is safe), but it also requires modifying the code as follows
>    * Create an acl context object for apps to
>    * manipulate
>    */
> + RTE_EXPORT_SYMBOL(rte_acl_create)
>   struct rte_acl_ctx *
>   rte_acl_create(const struct rte_acl_param *param, int debug)
>   {
> @@ -203,78 +204,16 @@ The addition of a parameter to the function is ABI breaking as the function is
>  public, and existing application may use it in its current form. However, the
>  compatibility macros in DPDK allow a developer to use symbol versioning so that
>  multiple functions can be mapped to the same public symbol based on when an
> -application was linked to it. To see how this is done, we start with the
> -requisite libraries version map file. Initially the version map file for the acl
> -library looks like this
> +application was linked to it.
>  
> -.. code-block:: none
> -
> -   DPDK_21 {
> -        global:
> -
> -        rte_acl_add_rules;
> -        rte_acl_build;
> -        rte_acl_classify;
> -        rte_acl_classify_alg;
> -        rte_acl_classify_scalar;
> -        rte_acl_create;
> -        rte_acl_dump;
> -        rte_acl_find_existing;
> -        rte_acl_free;
> -        rte_acl_ipv4vlan_add_rules;
> -        rte_acl_ipv4vlan_build;
> -        rte_acl_list_dump;
> -        rte_acl_reset;
> -        rte_acl_reset_rules;
> -        rte_acl_set_ctx_classify;
> -
> -        local: *;
> -   };
> -
> -This file needs to be modified as follows
> -
> -.. code-block:: none
> -
> -   DPDK_21 {
> -        global:
> -
> -        rte_acl_add_rules;
> -        rte_acl_build;
> -        rte_acl_classify;
> -        rte_acl_classify_alg;
> -        rte_acl_classify_scalar;
> -        rte_acl_create;
> -        rte_acl_dump;
> -        rte_acl_find_existing;
> -        rte_acl_free;
> -        rte_acl_ipv4vlan_add_rules;
> -        rte_acl_ipv4vlan_build;
> -        rte_acl_list_dump;
> -        rte_acl_reset;
> -        rte_acl_reset_rules;
> -        rte_acl_set_ctx_classify;
> -
> -        local: *;
> -   };
> -
> -   DPDK_22 {
> -        global:
> -        rte_acl_create;
> -
> -   } DPDK_21;
> -
> -The addition of the new block tells the linker that a new version node
> -``DPDK_22`` is available, which contains the symbol rte_acl_create, and inherits
> -the symbols from the DPDK_21 node. This list is directly translated into a
> -list of exported symbols when DPDK is compiled as a shared library.
> -
> -Next, we need to specify in the code which function maps to the rte_acl_create
> +We need to specify in the code which function maps to the rte_acl_create
>  symbol at which versions.  First, at the site of the initial symbol definition,
>  we wrap the function with ``RTE_VERSION_SYMBOL``, passing the current ABI version,
> -the function return type, and the function name and its arguments.
> +the function return type, the function name and its arguments.

Good fix, though technically not relevant to this patch.

>  
>  .. code-block:: c
>  
> + -RTE_EXPORT_SYMBOL(rte_acl_create)
>   -struct rte_acl_ctx *
>   -rte_acl_create(const struct rte_acl_param *param)
>   +RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param))
> @@ -293,6 +232,7 @@ We have now mapped the original rte_acl_create symbol to the original function
>  
>  Please see the section :ref:`Enabling versioning macros
>  <enabling_versioning_macros>` to enable this macro in the meson/ninja build.
> +

Ditto.

>  Next, we need to create the new version of the symbol. We create a new
>  function name and implement it appropriately, then wrap it in a call to ``RTE_DEFAULT_SYMBOL``.
>  
> @@ -312,9 +252,9 @@ The macro instructs the linker to create the new default symbol
>  ``rte_acl_create@DPDK_22``, which points to the function named ``rte_acl_create_v22``
>  (declared by the macro).
>  
> -And that's it, on the next shared library rebuild, there will be two versions of
> -rte_acl_create, an old DPDK_21 version, used by previously built applications,
> -and a new DPDK_22 version, used by future built applications.
> +And that's it. On the next shared library rebuild, there will be two versions of rte_acl_create,
> +an old DPDK_21 version, used by previously built applications, and a new DPDK_22 version,
> +used by future built applications.

nit: not sure what others think but "future built" sounds strange to me?
How about "later built" or "newly built"?

>  
>  .. note::
>  
> @@ -364,6 +304,7 @@ Assume we have an experimental function ``rte_acl_create`` as follows:
>      * Create an acl context object for apps to
>      * manipulate
>      */
<snip>

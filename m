Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A570C5DF82
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 07:53:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 945C240150;
	Thu, 20 Aug 2026 09:53:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E20C5400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 09:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787212420; x=1818748420;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jKoqrlbBsbQK9ab/395/5dBj2ditvSqhqlAFxCP5G0U=;
 b=dJxOXCsG7uk6kUYKFp0KL3LbMiifpb+fFV9nAb/jKX+BbxXkNv0Xu/Yy
 xN14bRhMuYp1xezOBX6/Ga7JcWidsjv3zmH2rODpg1FNaKXSyd1/GO5V/
 lmanwt1/UiK6hnHoRukok58/bClo6a5dxirPyeNgN4kjMktMDh8sqpHf+
 BF0WaOWRY+XxFtnemzATxQyjJKtRz6dj8yI0OkL1+6aof6rAWHgsrCm1n
 K4UmWGeaJjAO+HpIXGKYez+cupj9KyzVfhH5zESprSlbwMkEDvH2tFU+a
 dvQQoTyYG/e6jG56+I8kWqvF3kUEZWfd/g6h1KO9/+p8sU8/BWexxZ+OT w==;
X-CSE-ConnectionGUID: Ok2btG19RN61htP3x5CwwQ==
X-CSE-MsgGUID: 9vf/hroTT6yhDhGoDmXilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86857422"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="86857422"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 00:53:37 -0700
X-CSE-ConnectionGUID: V+jLmyIvQmqjAwad3WZGXA==
X-CSE-MsgGUID: m8ZQR/sgQTu968J/veYriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="264129688"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 00:53:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 00:53:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 00:53:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 00:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoZXwD643zLiGiAkW9JI8FNKNdbRIzFs/PRQ3b7PCeYHrgWu95eyDHOIHOgVSG+3yXeJfLUDYZjFZzeIqvWVALDvPB2QZPWnd5YcfM7KF0c6zqX15+kWCYLfsFxn8eXHgby+j+25lvaFW6GxZJndtZ2kIpNGBxa+l2vFhfm//1VpYfJPH5+qtAiwErIeavcxNe6aVpOruzHBAltDhlVQmYwOjaqCH3FcoGVqC6I7ANEShXKuLeXWv/UDjrm9H7kfyctTBXNxgfgPA1svAJZFmzRq1dF51eHFt4L6V4fenPxAzHIGKXSjcqq9v3mUROGume1iyuKS0w/0rfZ6mCV/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtgiTujcf3qt86ozgEYAi7P+MtqA9XFT12sUac8VaWk=;
 b=A62xvZXB6Taplq9UiYnGGH9iyVlNJadgFizR/41FecJyWHGkAXwiCtvsVF9NAS9mqdJl/uHcjdbcDxWqUWGRvwtL0G55s2VBdZ9pppGQUdwus/MS6xuB/A5zoj9ZpfTcOwvQeYsPh+/ndZ2f59pKJ2TGVORBCeBuFIr4ey2/ZVBNdvjnxgH7BZmfPZoD1kcCPiAOkzxOVxcDrBnwwMUdGHClIY6NuCUxwqV05XC2gLbNMQM6otsS7nIXgJJFfb73sBueUbqO+glmHgEvTsDI+Nefmfk+xaKqA1A4J+pICY5tDJivFh3JjU+NGOAl6svBUNz5mLsrpw6vizSp3xVQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 07:53:31 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 07:53:30 +0000
Date: Thu, 20 Aug 2026 08:53:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Jie Liu <liujie5@linkdatatechnology.com>
Subject: Re: [PATCH] net/sxe2: fix build when optional libraries are disabled
Message-ID: <aoaydY0-DBmdTUl9@bricha3-mobl1.ger.corp.intel.com>
References: <20260812175531.375636-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812175531.375636-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:10:232::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH0PR11MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cfcee9-df3a-4587-0563-08defe902074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eC7UxYuFPGosrrQiijJ1iY0eJL1bO+It6xonfTzF9gSuFdwNSzxGUHJyI3AX/x/UC4IfNjTAPsTS1ewvtPCsLVLGDA0R3iUgZhC9iVPIqCmF9yXSx2zVM/pbuSH/lC/gRKLpkU4V+SKXzPnMH8VFGsI3aYrLFWvWQz6GH7fOmGeBFxkopNn4EHpYvEMMmpaJoXKtAsY+vyY6lOlwJmVFi9rqvYGjwPS6hNXBWY+A3Gwo33l7EO7WCJu2PQ6s4nWaYrzplDmilGIsXJMgEuOsmhhvAEU12jhUWkz2oRwQ1lqnMEecw7WSSOoAuJoa9nSrJlf1NB2kIYIcfWE92pf5G6w9Xwh9ovDzxpsbSiTW5Mfoi6gNZqw/ufB5VIZ3VEQBdTRMwvTjK7L8TQMYTv7YsbnDUWUjGOZU6hDtXvMFK3RYJSsGgam7N29ZC2fayZJDFi9zN/WgjPuFToJUVFGdIOjfdUN39+mSnnRd5fNDGlG/exd/dP61IzHDfUUhiDC6VGXfKNKm7Yrrw81SOt3yurrXdWJ0wDZjfiSSgaW+lfPBIdXvm99ifWkS92GKvmNT4FhQ5szLoj6CM8gSKTVAhAfADV/kSDKgGNEbcPeRNDdXEotz7KuorPucB1nnpPOktyolG3T7Ch9fbTQm7WgqnSLZ/sWzUinNYbG3m4iWYNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jlC3lXwBy/k6qbKa2Uk+VboLJEnKVsDTbX2LIKmiaWKZqk+EsDKKQdyXEDF?=
 =?us-ascii?Q?652iqq6W5rQwxpCWBIMVnVM4DbUmkaUo+rfW70uAb+FxMCwIwtdfwbgbUw+7?=
 =?us-ascii?Q?bMTzFZk/aCVl+IwGhSvb+lsZjd5cOMO0WYPyWm//Yrg+eF8i7A4eNTJ1G/WK?=
 =?us-ascii?Q?xBjwgbsVnNDvR4/9z5Lp1XzoGFB1V78SxK1P6XolYMbjr36CVYozHsoULV2N?=
 =?us-ascii?Q?7olCgcSDeGMvlbwcy8s81S2L6l+cTd8FAeBdEz807ueLiLOlwEdcvCbmP61Y?=
 =?us-ascii?Q?E8o+ZJKs0MmuSPJhF+u3cZxl3GVVtWAmhBsjr/D3ys6Ou7dM7O5SqI1lu+e/?=
 =?us-ascii?Q?zxEaDLTmK0Mn+o+qvkNoREWq6LjMN7hFmUd/MFl+qW2b+FDbRBG2DsDBobY8?=
 =?us-ascii?Q?UtARJkQY4YlMzGuW08EjP/CqTvqQPjh1j1t6ZlpGTZ69AhAuTspHjZHHy0qK?=
 =?us-ascii?Q?KoDWbUX+V0gRpe4/OPrlVsyuZsVushxX23as5NqbTQQuy9TRmaIoUeBkqnF5?=
 =?us-ascii?Q?6C0i6LxKFXnuGpQVBmX0bJq5z07PBkin/ms4kllNojFkSiLlLQFgGIflYvpl?=
 =?us-ascii?Q?Mkl5Rqld24dTgbKKvuyZR6vytyL6qCnSyV/IkHl7Yeme8C187VRA+M57CFR7?=
 =?us-ascii?Q?ffiCAySsdQ3xPyyhPXakuvCrZEB8JbULjmtd2uC2JAWJIixtXNqX90JKkt2M?=
 =?us-ascii?Q?Mqq5/NGIgzsNdXuwCk3PjJR3mokn354vrNEFe4Oi4PTznFm2YjN/03FROLW8?=
 =?us-ascii?Q?jx571NDcbbwT5umGbC2mtU45oOpR4EA5OnQuWqxaAF+tzstIlGBZI19OmbM0?=
 =?us-ascii?Q?F2iJ5rsFo7zfGsQaynGOSbAdyi1L+xoKvBM9S781chQ3YqyICtidWlz1v1eQ?=
 =?us-ascii?Q?NqeU4BHlEtxW9kj6bmKKaW1pycXj3OVgphNINuio4bhmh2BioX4C7MMcD9Mo?=
 =?us-ascii?Q?iuMSeSh93r6M6lenRd3co7Te6FSzCq/7xUSaMqQTaSrA7Xc5ENL69BfLPWUQ?=
 =?us-ascii?Q?acJS3OQYoE5jSkntIHm0nim1b0WpKzCniI42H0kT//yh83gIc16pTeOUqGEg?=
 =?us-ascii?Q?GJYchuqX2xuoCnjvMChMVfw198ImvmnJ6fv2OjPOPV+67xa+/274xtSUTkwY?=
 =?us-ascii?Q?Rqtg50AwMod0BKnnYDRZp57Tr6rNr5sXPCeZwDVZLM9pJERi+U4myF8v09xT?=
 =?us-ascii?Q?wPYzLaxI2XIPLF89VCt/8M7CaAL4iPqD9sRuc0B8aeoFGwTgiX3d4UkLm/cK?=
 =?us-ascii?Q?I4jb9c8pKK3oag/S1a5ztRz1cG67yebW0KljFCbdutK666bHsB8q0m/9J2MH?=
 =?us-ascii?Q?+phXp7Z86w4CYtO+UdX9FzEsDQicQlUJqNlsTIufmhy699j6AnTsrH5brGdP?=
 =?us-ascii?Q?5YnZCjxjKOJQwcbe/OxKYaBiv0bTHd7WoNZqS944pnFZxciIjs9NKXnK2B76?=
 =?us-ascii?Q?h6bEuPj2qxWF1s1WPYviEUGuW4NBBJQIVB2AiTVs3KKfaH4vNAAKNSaW3kn8?=
 =?us-ascii?Q?6uzrgUJyFruYBu6P8LBaFc7zwUvP8Qvn4Es0wTETf6WHSKNFQHdELWRpQfiL?=
 =?us-ascii?Q?Ass9JcoZE5kRzEo0bVmBYD0NA55jooGN8uEhv9T+mQOl2bxUaMDBiEmppcWo?=
 =?us-ascii?Q?U4Xoi0n9eQjg0l5+XcWxSVxQjMuLQMnWShp6SnFshoUEGk9+DhqkXoQdoSoP?=
 =?us-ascii?Q?7swHESrFF4r0OAySV/Qrs4QuZQB9Y583nSR6WeF2km0zbDQ2FtdX5wrXsnI8?=
 =?us-ascii?Q?RllfcBdiheCS+e9bd4hLtVXxvfmUB2w=3D?=
X-Exchange-RoutingPolicyChecked: OJd1l5X8N5fZVUniPtkXqrUd3WgoPhESBwXw9md8ENTtek7Xg051167LSvknXVD9GxgHgpb5otIAn8C7/VzW2b3Jxy+07kY6YBq1+QhscNjJxMU82PNnLGtB4BoXfhH/9oohAh5ksSCz0V3i+qZ0u26ZxBpvvDcTzCjyOJQxgeG3ICxOTZJjqPe9hEh3eUojCndZhQv1omH5W6yW+dcS+6Ck+JHZ1Ikt0WJKa4j4gugBQxZStDnMJeGYTvBl66aHh1udXWBIOMyOiivFsX+4ESEMcqFo1VCQ+8O4Ci2/lTk5ty7NvJMcjiZ8nYDt2KoTGn/URBhfbvgpEVeqopsL8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cfcee9-df3a-4587-0563-08defe902074
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 07:53:30.8408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEqVoBTqJCoulcbb2iAUQHXedEXsj4kXt6AAs2MP9PbTrK9FjFdjt1xXnmOX74MUcI3ridl0RGd0XAN2amuCFJY2XjK9CKEIr4jjVts2Yts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
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

On Wed, Aug 12, 2026 at 10:55:31AM -0700, Stephen Hemminger wrote:
> This was found by AI sandbox build when doing other fixes
> to EAL. The sxe2 driver was doing handrolled meson to pick
> up AVX which fails if security library not present.
> 
> Fix build failure when building with
> "meson setup build -Denable_libs=eal":
> 
>   drivers/net/sxe2/meson.build:37:24: ERROR:
>   Unknown variable name "static_rte_security".
> 
> Use sources_avx2 and sources_avx512 instead of hand-rolled
> static libraries.
> 
> Fixes: 59d866861188 ("net/sxe2: add AVX2 Rx and Tx")
> Fixes: 0af0bdcdcf83 ("net/sxe2: add AVX512 Rx and Tx")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/sxe2/meson.build | 35 ++---------------------------------
>  1 file changed, 2 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
> index d653d071a9..409e3be248 100644
> --- a/drivers/net/sxe2/meson.build
> +++ b/drivers/net/sxe2/meson.build
> @@ -15,39 +15,8 @@ includes += include_directories('../../common/sxe2')
>  
>  if arch_subdir == 'x86'
>          sources += files('sxe2_txrx_vec_sse.c')
> -
> -        sxe2_avx512_cpu_support =(
> -                cc.get_define('__AVX512F__', args: machine_args) != '' and
> -                cc.get_define('__AVX512BW__', args: machine_args) != '')
> -
> -        sxe2_avx512_cc_support = (
> -                not machine_args.contains('-mno-avx512f') and
> -                cc.has_argument('-mavx512f') and
> -                cc.has_argument('-mavx512bw'))
> -
> -        if sxe2_avx512_cpu_support == true or sxe2_avx512_cc_support == true
> -                cflags += ['-DCC_AVX512_SUPPORT']
> -                avx512_args = [cflags, '-mavx512f', '-mavx512bw']
> -                if cc.has_argument('-march=skylake-avx512')
> -                        avx512_args += '-march=skylake-avx512'
> -                endif
> -                sxe2_avx512_lib = static_library('sxe2_avx512_lib', 'sxe2_txrx_vec_avx512.c',
> -                        dependencies: [static_rte_ethdev,
> -                        static_rte_kvargs, static_rte_hash,
> -                        static_rte_security, static_rte_cryptodev, static_rte_bus_pci],
> -                        include_directories: includes,
> -                        c_args: avx512_args)
> -                objs += sxe2_avx512_lib.extract_objects('sxe2_txrx_vec_avx512.c')
> -        endif
> -        sxe2_avx2_lib = static_library('sxe2_avx2_lib',
> -                'sxe2_txrx_vec_avx2.c',
> -                dependencies: [static_rte_ethdev,
> -                        static_rte_kvargs, static_rte_hash,
> -                        static_rte_security, static_rte_cryptodev,
> -                        static_rte_bus_pci],
> -                include_directories: includes,
> -                c_args: [cflags, '-mavx2'])
> -        objs += sxe2_avx2_lib.extract_objects('sxe2_txrx_vec_avx2.c')
> +        sources_avx2 += files('sxe2_txrx_vec_avx2.c')
> +        sources_avx512 += files('sxe2_txrx_vec_avx512.c')
>  elif arch_subdir == 'arm'
>          sources += files('sxe2_txrx_vec_neon.c')
>  endif
> -- 
This looks correct to me. We should be using the standard variables for
these instruction-specific files rather than hand-rolling.

Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>


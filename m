Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE77C282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 15:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7587940280;
	Mon,  3 Mar 2025 16:22:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D8B004027F
 for <dev@dpdk.org>; Mon,  3 Mar 2025 16:22:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741015339; x=1772551339;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=A52KjNkDuEYe2+Rsp68WTtebgxyW5kRjxMSutpiyDqg=;
 b=nNhpHSLLH8ZsRQCmBA7fiuFpvOb2T25iZpWfARarrSvcXMkl2d5WxTsA
 OBahw/i8Whrqa3BfMAiY9RzEoiXYutYO59KfWhvTQmGoZ0PcBr/msRNBN
 Bmf5WDKZAp9sCxpI1Il09GQBIyU6Q0VjPliFAbtzNLEyPyNc0eJRBxRk7
 7caWacVt/G+2uY56r4PNqVxbLATpc1BkwHdelgFgXuBGt3kcuG6Kz1adp
 bfLVhQg3+tYknS842ZJAfSMYr6eUb1pK0ToePFDkEm+L7nIIlQb2Fy+V9
 Ly28DCEQWr/1hZjnNkxpPVOFJ6wBrSHmAAU3vtmkUy/VDMwYbr2Qor+d4 A==;
X-CSE-ConnectionGUID: RVDpy6ABSpyyRDDBCHZFhg==
X-CSE-MsgGUID: wt87zzQfQI+dchj9qZl7ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41783514"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="41783514"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 07:22:18 -0800
X-CSE-ConnectionGUID: ndxMRRhyQ76TOD2SGqYDeA==
X-CSE-MsgGUID: P+nD9vmFSliW8a3DxLuEZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118969405"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Mar 2025 07:22:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 07:22:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 07:22:16 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 07:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK3FI5u9CxhKXNIpzXkpoEWhlRuHDwNaFRgmiYrwy9MyEpl9P/lLZXqlYw4x6XRYcrI3NHzxZt5SgQ1899+yu+nJnYfhSmuz3n9sKBs5nG8SFYyyru9wU4WAVsiYz1ioasKX/L+2wdpLbTXMTQvc8nVmmqOSvg4QDXjPPNJLJWVu1pjhWVfJbSgOgtsaQ+AMzsPyVMCE6KYS4i0LUKISi3kPkvv6RYHeILdLVbXBQZ17xe3ZQDcrm7jzaa9/u7eOKabeLkZ9JO5dQX2TqrwKWPeeEfGq5AQAyCEGkhlSqjsES2C2gwEsw6yhBd6x12SOUQR4F2agtauKO7dRFnHvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgZS7GhyT9Y/ZnVEp/r+ZKmANR2DnayRtkSPFWLWEwk=;
 b=Mqq1cxj7W24tG/b7LoAdIHQM3tMYKffLWn/lLqyfyKIRuxMR7DSGsAhzSYE9KximC/XOXArdbkGoPmCreAfyX1N8u3wfpF/I4fegVLRv/Oyl0qAUb2OQ1hVFvx1yj/lOrPgp/2kc8qaU42gfXQcL0jcEdreUl754ihCVW7bEHTgAxvQFRjD6DVYu8r6u1bF4Q9ZUrkNMtOiCoip7SQ4N3nvLjGJwi9N0+6AhwcoLbrYF01Ekf7X7SUcvVpH54CZ7Z6EgsoFs54jb741IyVEoF+dLCDnb2XgEpC+7vkYne73iDj+tU9vb3Uxhwvq13/XyNeesDT7Q8H+iQgy0xtBkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6008.namprd11.prod.outlook.com (2603:10b6:510:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 15:21:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:21:45 +0000
Date: Mon, 3 Mar 2025 15:21:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] member: use common top-level variable for easier
 maintenance
Message-ID: <Z8XJBGuHKRxbUfzE@bricha3-mobl1.ger.corp.intel.com>
References: <1740769261-736-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740769261-736-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 593b6275-f1b1-4cd7-7907-08dd5a671bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iTWZWqtqvLpb2+BWItD8B1JCqD61GL9W0t9f9iS8qZRi/formZx8tOjx2WzR?=
 =?us-ascii?Q?wPTwQ8h4eIoM4HdLDPENP+PC4CDY9hwLMdwJX9DL1kp3kmWrQHQR5WKwoaXT?=
 =?us-ascii?Q?zE79fIok2uSMoJ+iJZ2EUPjqsPNHP6uuGcbplhJbmkbnlYxcptDzaIlYYgJV?=
 =?us-ascii?Q?nd/NA86vDxWKJqxi1y2R5aUlidhb5yBaCAfMMej6JUQmx86A8yZO7jxc7jXv?=
 =?us-ascii?Q?xq3rlNzfZHiY9pYhkB8m8U92VRnzKo2vr+nXnvYuVxyFoSEe9vbIGuN9y9C7?=
 =?us-ascii?Q?3j+2e+VVdZBxtiumepqh2YrYBLo5zCiFupfG4KGwj3Y6noVMF9Bqb/nChUXF?=
 =?us-ascii?Q?KKquxvs4kGRAnMy+4ziwB2sTFCT0vt2I7EQhKkfX0GxTiUd4EaaWYVEQBsLo?=
 =?us-ascii?Q?DkSniIRqCDk8kfllRwSixRZBtfsJKzU6jkPCYLugxdu+BewJHEIrv4dvMDiz?=
 =?us-ascii?Q?NrVRUDLc7uGYODnXcGMUOgGtQj7Gd3yNSNlxl/7OU5lI3RE72zahCJ8+mUeo?=
 =?us-ascii?Q?lGqedoLiAtGANsHdSCw7W9u/R5a4qi3fbOReIY5AHjGhOssiDQDBiHLwniDg?=
 =?us-ascii?Q?Jfs/ASyh1YKMG0rk3zfzOSMzjjhYdDJijJGYIqnpB/VKFM5N5hIjDb7rYAOd?=
 =?us-ascii?Q?m5Sq4GYg2hMwS+sjoK25XWOrZYqiyGYCFoQdOxOdsNxOkjGrQ1Yg5A/he7kj?=
 =?us-ascii?Q?q5SPQ6kylNgq/wC760yIWS4kWS7Ot2npXCelLdPWp216fk9pbYuFFwDt2rb4?=
 =?us-ascii?Q?tyJI2VIERb3cmS5H8pcEHSmy5QWuxadddX24lHszg0TgwHwJfmSCAJDhE9K1?=
 =?us-ascii?Q?MOIIok5fxt1EAbyDb4bvisiiP1ODRApAE1pJNqsGb2OsTC9BvTN6DWmhn0n/?=
 =?us-ascii?Q?FM8YoMKj+xlRENJ7K+UBmh+IINTFmZ4A6oA+TPcSxXaEMBL2p6FxeV1qhUSQ?=
 =?us-ascii?Q?LpKlZ6ktmzrnEC8fK6cf9CKjRUPk5dBy1bqRPcid1mSvPSDaVWSO8UjuACpd?=
 =?us-ascii?Q?eqlLQGXjR6n3hx1FksDvkQMIejlXrM58ApnnNXJe3tAUMh9/uR3vS2FLitUD?=
 =?us-ascii?Q?3giBu4Xub8yIarNOT0rLeYT9cGP9mx5yRCQz/y0xwS8DnCK96nuF9kVOdWlX?=
 =?us-ascii?Q?zJiPpYVwBHcyyKIdgn5ICQpb+BYyWnepUrc297DUHpX/YHwXgDjTaipOQhHy?=
 =?us-ascii?Q?tbWv8IpsSKj7VgszQb88Ve1X9UzV/Bxv0i4Bc3FcuMsJc2zNGxnYaHLBxrPz?=
 =?us-ascii?Q?L7hBu2MheLgQeLHh8FJ0PQ85xyN+9Bjy1OP7Vlzvb7od5DmA94s5e0munq6s?=
 =?us-ascii?Q?9N0an7Gn4h+6/6z6A2r2aqpE3QcQNPKq76n6rU2bhDGiDofKKNcWx3sgcBUt?=
 =?us-ascii?Q?6edFlrcJ1aeMYHdS2ylbXP9Twmq4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IvzqBy89vErfjVihrF6iUkp2rOrcMYrDhUGOLYUG0hPRXxL5iXpSr/6lz8p0?=
 =?us-ascii?Q?KnsbHpBASRLozLiEHxCOlIKGN8hWsdrCt9cuu6Iys7YK0IfHQ+kuJulllvq7?=
 =?us-ascii?Q?zdYsvBiQu9e+IfOv8mJUaUJvcnr/29myd2SvRWtmLPl28qh43QLBLGgKhX2O?=
 =?us-ascii?Q?GDQn+coXgkdYKAj5Q7ZTn/CBbnFrxtn1oz0kCKcBecWzX3cR9GZo44YInygP?=
 =?us-ascii?Q?7OhQzFujJJkcV5Odr2n54Ps+h2loweQNUC8XA02UXYVFJOKemY502eqSOv9V?=
 =?us-ascii?Q?2johyy2Ca+RMLPHauGzZL4lwPgsG5AL8Pf9LJq5vb9+Mu27Cyhva7SMDWnHD?=
 =?us-ascii?Q?czKCqy8ArY8ZYK6BpkrB1mCkQzJkN20Z8rTpcTJygCsq5zy/ElkArndWUgwx?=
 =?us-ascii?Q?HW/CnPVaJti3f1elB0X/H6Pm2U/PnCE9cAAr9hafOxDCIHquJtlue4GMFHCd?=
 =?us-ascii?Q?a220Dhh9SUm5N2pkZIDb5yYaJQgrruYk+xBBf1kV3CtHM9Wsh7D1OAGTXul9?=
 =?us-ascii?Q?lySGzcme6mZIf8bXu35uFwYVAfpR8WT1VgbX2T68LBnjJV4Gl56Ri9qKPw90?=
 =?us-ascii?Q?L9gRcW1DevM1P+ezqNK3TDuCBQRJx33G9Uy6l5TrE1vXFNHB+Kh/fWBDsK4O?=
 =?us-ascii?Q?i2JM+CT8N+1S9MTweUYq/ZlyifjC0UwTqyNYV41ET+osDqZxx3CYdSKWWDwy?=
 =?us-ascii?Q?a0kuMXw6WQN5ZtCYQEHxCgxXbjq1SFaVqM1ISAAviN9dmy/aRsfF7WGuJgWS?=
 =?us-ascii?Q?fqHiCt7Q9vjO1huuROz0eRCOIjQKDamlXAH445TsOTx0wV8Xo+eR48nswKZe?=
 =?us-ascii?Q?nV2g+kZPzxuoXJYWDVbiiB3F5zlyWaq0E+bhOIvRZOkLcV2SrBn70fvIanHG?=
 =?us-ascii?Q?wAGgDj51PskTda1leyQrNNfxxBuUU+H+sfbc0BSCnvAKtE7yanoHqoq8nAbk?=
 =?us-ascii?Q?m9Utb1PEiqTSwfYjhL6NcZdH++MM6uH1BRIJHFNt+zYkrVxefa+W53HKFnY9?=
 =?us-ascii?Q?eX0KO+eXES7BePGCOBclP2EhCgMQOWGBhqO2efUROuztWlKaP/yCiZzU6jFE?=
 =?us-ascii?Q?NokfSXQ+usknD6FbDUED3HuFDoa2PJsIn4ETunT5ismgvvEIwqeTUOXmATB4?=
 =?us-ascii?Q?YoLKLBb3itivuxp4xN6Hr6z3zmFjVQjsZ6IbdrhTMY8Oq929T2V9TmOkyody?=
 =?us-ascii?Q?6NPyCFDRmysoHyU/1d+jogMVCamcuITJTksKlx9O7x5DpCXxIZcwiivA8uyl?=
 =?us-ascii?Q?lIq+3R4+qHkxjDyxdI0mexXfjhbTF6NY4pfKnbfO9f2SGUaBwzQdhMITHEUz?=
 =?us-ascii?Q?iasuJox+rmNJ7hKWOeF/RUO3noPabNif4BJrSKj//y2xM+LIy9ykRhe2gOLd?=
 =?us-ascii?Q?B5xt8eLlG5eM0LI4gYgqvmR9J6hNpc8cBYAE2ULsrEw7wuoUSbuvLMbXSV1L?=
 =?us-ascii?Q?fuKA3pp0lXPWy4f/z7KVkjSUBiQbP3MH2aexlhLnWn3feHdRwdkOSF1ubDTJ?=
 =?us-ascii?Q?SHQiVxTX5MXdMBMWOC7uzXD7/Cbwtw7zBA0yGIfCIlGfJdu2y6ma1LYda8da?=
 =?us-ascii?Q?eHZy3ON0938xeYJM+dP3kH8mQXN6Nx5RyAWQorLA7Btj0k7gIaY/ZN9sVK7N?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 593b6275-f1b1-4cd7-7907-08dd5a671bcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:21:45.3530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN9I77gLWYWhYlUkaKH/RpygPphvzueviS1VFu0iomIAWLvFEBtocCVzinBVoFLuRNcs5DZeblHmAMDODhFTnWZzBUXJ4K3egTowZ/MWf4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
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

On Fri, Feb 28, 2025 at 11:01:01AM -0800, Andre Muezerie wrote:
> Updated meson.build to use common variable cc_avx512_flags for
> msvc and avoiding code duplication for other compilers.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/member/meson.build | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/member/meson.build b/lib/member/meson.build
> index f92cbb7f25..8416dc6f8a 100644
> --- a/lib/member/meson.build
> +++ b/lib/member/meson.build
> @@ -33,6 +33,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
>      # compiler flags, and then have the .o file from static lib
>      # linked into main lib.
>  
> +    if is_ms_compiler
> +        member_avx512_args = cc_avx512_flags
> +    else
> +        member_avx512_args = ['-mavx512f', '-mavx512dq', '-mavx512ifma']
> +    endif
> +

Would this be better as:

member_avx512_args = cc_avx512_flags
if not is_ms_compiler
	member_avx512_args += '-mavx512ifma'
endif

WDYT?

>      # check if all required flags already enabled
>      sketch_avx512_flags = ['__AVX512F__', '__AVX512DQ__', '__AVX512IFMA__']
>  
> @@ -46,13 +52,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
>      if sketch_avx512_on == true
>          cflags += ['-DCC_AVX512_SUPPORT']
>          sources += files('rte_member_sketch_avx512.c')
> -    elif cc.has_multi_arguments('-mavx512f', '-mavx512dq', '-mavx512ifma')
> +    elif cc.has_multi_arguments(member_avx512_args)
>          sketch_avx512_tmp = static_library('sketch_avx512_tmp',
>              'rte_member_sketch_avx512.c',
>              include_directories: includes,
>              dependencies: [static_rte_eal, static_rte_hash],
> -            c_args: cflags +
> -                ['-mavx512f', '-mavx512dq', '-mavx512ifma'])
> +            c_args: cflags + member_avx512_args)
>          objs += sketch_avx512_tmp.extract_objects('rte_member_sketch_avx512.c')
>          cflags += ['-DCC_AVX512_SUPPORT']
>      endif
> -- 
> 2.48.1.vfs.0.0
> 

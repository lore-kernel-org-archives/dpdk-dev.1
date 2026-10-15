Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B34CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:40:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF47400EF;
	Thu, 15 Oct 2026 12:40:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BDD3940041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792060822; x=1823596822;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5416Rr2VXdgLbH0x8hi48hmyFZ/xf8LMouxsh7AckGI=;
 b=G7sQvJlESNnGny3x7Wx/p1aJsQEpPY3rm0Cjb/8xG3GfW6D9rk6dnzlV
 YfBDSoPYNnJnrZnfnh4EKRxqlFkV9Xwa4fSc18BFgMh1pvp2K2fBl94EB
 24/K87Ge648aAwAIsnWYF2ZVBJae7fHN/6Xwwv4PuOVwCMCci9trDLMgB
 wVl7ahXJMzyELn+Zx3eE6SLVt8mV1lUQW5g3RETux5+sq46g2U63Tlf2d
 dZAyHxtwA4vH40rCSm5J03f9bGW205zrev0am/2X2+nWnfIw0D6iraIh3
 0uDzQY6qvyFHi1jKR+aaPDLOpTvknzWmQzGifeUukJZASsxJTuP5tPw3V A==;
X-CSE-ConnectionGUID: X1JcVNmaTe6xaN5ohas4rg==
X-CSE-MsgGUID: 5VjYSlK/TmyJdk/tmMTimg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="837460"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="837460"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:40:21 -0700
X-CSE-ConnectionGUID: vBoviAknQBSzEg3sCZwKvA==
X-CSE-MsgGUID: bdoMYWZKRiW1hNcw+f1Xpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1679349"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:40:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:40:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 03:40:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0akTMNnw6qo0tVIC47V1zXi8bsvVxL+fJ8ERYa0bhib+opHybb65JRss0wKIpuB1pYykonzP/3qr0GH/FFYunIEDWKuTi+mCeetxmoKR7FSyLZqp+siYqyt5pUorNIxxD2Uo4/aEBhUxsijbZUkbevEdvBaJZlCNGaNVAcHm6CKIxKx/YOsfSuzemfDiyoyBuFEW/GLPH+8SoI9IBY02nswneTtVlmCr/Ql9FuB/cfWHELB/7oypG47Pg8a1FVKfKyPNIn/6woQZv6PUVEo5M40kO/xJgQ6XpHQMXP4pgkGvreHCpRh92MJ0ZhtqU2hYD6wpZUfQtarrg2pYN1l9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VmShUkkRX0pwkTfVAZgUiF/gdQKwcko1TwNKGUT2ZQ=;
 b=fqMVawy6HqbyGcBmd9MKRZxAtP0aN26IH/Or5ayup/pVru27p8P7E/DZU0AsdKZtg4I+uWucP+ilwiS5eIKwWoNFukGbqI38UuDETy9PVCXSrIHEdqqG0PwJNdYYJd5uVlj6FKBCJG2vAzyqOJO/sZR48UKC/bvJz6hGBjDS5OE0fNfpNxz8R6H//3D9lGab98cEWOEPD8A7Dyd5NQRbneAaWYOP0KK4hvklWWssHAuKw2cYoa1tgngBf1gEmybxdcm7gF/M/3Cs0nBt8H5eW+O8NFHBOHCBLIMgcukP6kSwSE+R3xL/LS3iF2HqiI1VmbJInTsib2/8H4p3h/whRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PPF31D2DA56C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:40:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 10:40:13 +0000
Date: Thu, 15 Oct 2026 11:40:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk 2/2] meson: add drivers to dynamic libraries
Message-ID: <atCtiQ_Yhtz81jvA@bricha3-mobl1.ger.corp.intel.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261015100921.2944274-7-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015100921.2944274-7-rjarry@redhat.com>
X-ClientProxiedBy: DUZPR01CA0289.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee59138-d1db-479a-4a6a-08df2aa8b1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|10067099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: lya+v97M99MpBK0c9lrhyoRCwHFlYWNLGelTwtS8xjcQbRpRRJck3PkxS5NgWkB/XlPYePg5NxYYlqkp6kJNp2aXIDZfrP2O1Ts8F7Ag3+Nx9zg7O5yJ2LOE8IFci8DhtbiWXH4tmYAjiUAmXDX/OqScwO7aHlWL4KkvW/RSCxY1NvhEnViaDMafyCLfZAoOUPkVQ0EZEcJZbPxjIDi7G728/UZU/gqQVJ5WKt0c+6KKDLp3+mjQX4MLhy1VpjofPuRC1R1ZUnukZVYhEdMKSG0q9iDYZ+gs4bkEKuHTAdQZLz/OxcqP/Xls1ezqtMWaone/f+1BGjPKM7O4jEsOKbjVEtJN9FmN7oeAjd+9+bi1xN5tWV521zCalz8RZ3yFz6EkMesVi2kN8XipGghq0mQfF1wUdEZsyRspe8SZw1a+ynFjSaILrMfVAuKbQQcybhxT/DOXWhUJpWk8bpH1W3fj0SlNCU9+g2gc1neShuj4ZZP2/fzZxPmnx72p/AkFrqyd/rQj/j9AVDgwE24FonwNSk7hynZNWdDLKBmz9H2mP1QSxI94hBhde1woVw3xkf4Pqj8TwanOlFkLVRd6BqM5zJWAveFK1gn8ECVVJ6dm+z4HGUu3My8JYi4PscQtp1RS5Ob99a5HMG4nGYnRcdWc+r0Skz/ecWIsS2dutJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsi5PMmg63yjtokCTh+T6LjzfLb86tA4ytBn61gXXOcAi1tp15qF+Q9UB26b?=
 =?us-ascii?Q?OrtVCVd5qoP3zukUZ9cHqfGqIJmnIv9fgFktH6bnjwXLuglEHf9hRgnCD5jD?=
 =?us-ascii?Q?MqpRd/8wdF/whrEzGK8m7S2vp8t9TfJPpMxnmjB1IOSAjFsPMSjV6HDM4CLg?=
 =?us-ascii?Q?iJWzKaPzqmK/12HnK0vFI6pKMKdBvCQ5QY1oRgyWJGeKOk1twlaKfPca9WQR?=
 =?us-ascii?Q?/ZrwNBUPxJ31957rTti7rAYa62FEAKPElSUnp/AS225siahkZ7jWjIWOa6tE?=
 =?us-ascii?Q?GkoP9wnGZm1ejojj/2OOWT0FofTJtTL72XVqOpTS+3bGfYw9SAsuZ2lQ5bYP?=
 =?us-ascii?Q?9vvOU/zg5wBVR8ERKFqJwRAzGcXy3Z0qkiU7jxEh7mqvSAIp/Va2sqQ8Tu8S?=
 =?us-ascii?Q?Q0jMA++r1ZOl5Jl+Ax4iyy5J0HKeLLOEjKJEKo34LAg9zNWvcph/mQViznJU?=
 =?us-ascii?Q?Zyydq5p/0L9LfMU16CN09bGAsOhRNowrDYiiG+zQOtExaX+JRED4/W9XrQvD?=
 =?us-ascii?Q?dKnZcudc7jPD1g8+YdkDtlV7WUyBXwBjk2AamGQLpQ1QTEq9ObVZxjHmd1V/?=
 =?us-ascii?Q?vWdO9Sv4fPdOCVjh7sh/hsdXls1+7Y4sr8K8i1frV0A5XXHdJHRum+/1HHmd?=
 =?us-ascii?Q?Z0reNxKa16M393hfsI77uWQ0YjqstFcaOglnk5d1TnXOzdTWU1kcKjwIgZRM?=
 =?us-ascii?Q?fpJD5ENgonkmqGDTreZeoAjvz6PlvRx61ok+gu/sw7CaPQB4ne0URc1mIk3p?=
 =?us-ascii?Q?IdF7VbIRa590FoT+b9+GXNL1rgyNBso4Di+BYJqN4x35gvfKS55JsJPANYih?=
 =?us-ascii?Q?Yrt6PiqLPIJZq6kZUexLjSpH9IdhQ1c2hunc0ccDQZr3NY0Z46+5WavkeolV?=
 =?us-ascii?Q?qlFqisaZ+kH3wDzv4CLqEXhQrgzu7ZcPVOmDInqoc0ePgRqAbNfSV/jf41lW?=
 =?us-ascii?Q?EzFv/bQRxl63cu2tuhnwQumdl4j3bt+Gjo9+ZEhuTmRNMC8dQyq4HguH+RWX?=
 =?us-ascii?Q?YoRyRhjEI04e8HWCpVSA6qRDrS9RF9zwwBRr4ByZ+IBvR+VKiBaTllQjagdC?=
 =?us-ascii?Q?X3b4KIbszRGlgtpCdgGB3TxuOcQSK3fcDdUl0XLjO1QzGsnnNe4bVGQktrnD?=
 =?us-ascii?Q?dtXAWCDwx8XgEl/OYlM3k4zpYx2HAC5x59QSEloebEHa8aQ1v0508dQqnC7i?=
 =?us-ascii?Q?22MaKWzl0BbaeTx44U9ySmQ5W1srfW12VGq5z/y5mzOqszWUyypPoTYvkbgq?=
 =?us-ascii?Q?dBKyRYRCqtJPYbDEhOnkw/QpaiRV9wX/8HhjiqSMAY0TYqsnRhwRMCVAJH0S?=
 =?us-ascii?Q?H1pRFhctP4IpE9i/BwC81ee5nAoKH3ds32dLDOkZ1hDR9k2PFaHmkPE7QmDN?=
 =?us-ascii?Q?GG9KqT08QTRl6VADymyf/5I0H58yAdflfjef0+fjWXPqXEg/CeHaTvLLPDdT?=
 =?us-ascii?Q?K5wwQ3HKisnfT6bf0Zh3aS8WVgtrKTiEeaRD3oI4h5XvoeCPuz4L44b95LEL?=
 =?us-ascii?Q?fHaFxBhjELGy3zssX0uCkrt2MExDJgsSmBRcGcKWIKp7nIybH21Xt8CGqmE8?=
 =?us-ascii?Q?HnwT14vyAuzAoerMzBrTu6o+AVyjOuHNWmZG7SpZplhlKWJQpd432pTNYvzt?=
 =?us-ascii?Q?xxS3Tvhu7enyvdCbEb36tpaHiX3eEINeBHObNdU9Dq2SQIzd+0r3dERZaAm9?=
 =?us-ascii?Q?v/2anFXKM3ti0f+aZz0Vwq941rUoOrOxoJfLICNkIV40AVbKJkkul1hoMZYk?=
 =?us-ascii?Q?lA5UIiVEXPgB3xGnoCoEvjkh7dU6Dn0=3D?=
X-Exchange-RoutingPolicyChecked: XBmHpbaOnviMTs6p321HXWAuSapfffVBiO8d7G/dbjdaNi10iGQOrWJ5+9dhABRfCLLR5CIHcFp3gJtCB3pz+1aHYo3pFP/gFLzlXqFWSKwMC7ONZM7XhSJvnBxhMUOVxfzI2AoK4IY67ucYsXxQwPXTK9TNIc/psai4/rGQqNNIyo7zGrN50vxV29y4I+eCEep53bvgH3kenevBncpFFR/F+obsn75fnb5SYpXxBmmk+fivicLyIxbRxfKFv1uE8l18z26E1EBugFM+Php8054tf8VDmIZe0pl4wznb7xP0IhescNr8idOIePdiWpO6DvJPKJGBP7J7kMhFl0va1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee59138-d1db-479a-4a6a-08df2aa8b1b1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:40:13.4836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHhxnPvBPkoubG7EsHtY3ZX7q8FHy2Y4pixr99mhIjCgZlLzxvVtrKHSSt/28IRWH+q5zf8QsxiY1WPiopj+UhOkX0pJ0e/h218BPJW3v5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
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

On Thu, Oct 15, 2026 at 12:09:24PM +0200, Robin Jarry wrote:
> dpdk_shared_lib_deps only collects library dependencies, so DPDK built
> as a meson subproject with shared libraries never links against
> drivers that install public headers (e.g. bus/pci, bus/vdev). Add
> these drivers to dpdk_shared_lib_deps as well, mirroring what is
> already done for libraries in lib/meson.build.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  drivers/meson.build | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/drivers/meson.build b/drivers/meson.build
> index 7146f036c4c9..37b152979109 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -405,6 +405,9 @@ foreach subpath:subdirs
>                  dependencies: static_deps)
>  
>          dpdk_static_drivers += static_lib
> +        if headers.length() > 0
> +            dpdk_shared_lib_deps += shared_dep
> +        endif
>  
>          set_variable('shared_@0@'.format(lib_name), shared_dep)
>          set_variable('static_@0@'.format(lib_name), static_dep)
> -- 
> 2.56.0
> 

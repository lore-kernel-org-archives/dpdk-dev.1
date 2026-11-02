Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B260DE99C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DpwCVgzf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DA4402E3;
	Mon,  2 Nov 2026 16:35:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id A15644028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633708; x=1825169708;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4JmpEYbNrS1dTUBBRLvz1LF5UJLScqiEgMyEfiCV8fw=;
 b=DpwCVgzfrqU5FhaMzxfrQAKJI1BIvATyegPaGlxa/ume7KoFXW9wZq35
 ddQTkzY53zqOwuLcg43qbvN0t68OqzpqT2R/av0Bisxn3JxQMJU+9P8iU
 JB3vxIKs4tvepKH/rGs5SRojm9fp6B0jfozS1Fdy0stcqJY8c2TLfTJnj
 ZuKzDROMVRbSkbVCcYBBeEIFHqcyntYWztwd6QbRIhsMD01SvNVj5DcBb
 KXpqfxns518dixBFx3dy8XBI5rzozUFo+YRtWnSW6fcU4z5fNK+Nq68tr
 8hsjZ4rZ46Sc2/uMiYsc2Gvm10LH86DSTbC8pdXrKvTdV8OHarZT27fgJ A==;
X-CSE-ConnectionGUID: THwPVX+JTL+E41yd6Jufiw==
X-CSE-MsgGUID: olYuTpDPQ3+1S3GU79AURw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2421317"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2421317"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:35:06 -0800
X-CSE-ConnectionGUID: IoKonvH3RKSwo+NiATvGlg==
X-CSE-MsgGUID: MBlQdLOyRcGB7weCNTAHfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7943833"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:35:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 07:35:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 07:35:05 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.21)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 07:35:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNo6haSnBk9H38sDxRmG/BiytBnMborKoRtNTJpxafzSGEkhNBmMgQ/rXQP8XklmmQcymLSnS1FZWIfRb6iFgk1n7YTN9DKOAJOOoJUTqrDiSHWASKG2ls3L4HcD/K7MLoPTyXVrRxY90rcs7Rmce8GTaGAZFYNtFb0YRL046rqmeq2n6c7WtjO4tY7njObiXN2BNYKAknAaFDKG4vS7aSwwAcx2oMQfitkQYxwlWDDriLJlsoSBFbg8BvyQexMVyfkKhi/H+1Ab0Dae3YPANFjWaUKLF9XFHK541JfCbUb97KlrmE0A+fxirhgOwtfN1HEclddbzXxTOAkhq/T/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtwyOTPFKsHc6kDgn5wIIv5Ja4rWUuLsv79kMMNUeJY=;
 b=tHp6Qbsg9YGpHyTbqtu9iJw9z5QfJPP/cZbxh4kCZ7/BlEzwFtKmQW8fc4V9jyVYV4k7TPpopII2DrhwDO/MbDPm/8p1uAOhiHWotdb0gtjCFhmSTO3hbRBD/OZLh/VAyjLKAWLO2QNrhVOQrqvVaKCVZYzdEZdzCJuB9h7gET7omkTmHXFM2uXCnF0iNkJyXFDxeshjVIaYET3Ja++8G8vxrDSdU6FsoNQ6PMuIwuYcR0eVd7PjCkc6oG6LykBky510FgoCDTZCU0Cp1YvwD3kc4e8lFNUnoBMVLF/r29cht/XiYWZtFDPyf0meTl3rSF9ml+mmUGB1SbUBKHQNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 15:35:00 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:34:59 +0000
Date: Mon, 2 Nov 2026 15:34:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] vfio: fix cdev build with old Linux headers
Message-ID: <auitnhsTX1eYCuFm@bricha3-mobl1.ger.corp.intel.com>
References: <20261102152805.644416-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261102152805.644416-1-thomas@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA1PR11MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: b52501ce-82b3-4724-4921-08df38f6daf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261102123227099003|10067099003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261021123027099003|261022075727099003|261026140227099003|261022113327099003|261021121427099003|261009223027099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 2Hw1bT9fV9QzpAKaqsUewphDeL4P0Wt7sjkkJ5uEw53axLf2mXHVtMH+po2OMNROm8GKT/WTgg3ufBd/fgPkRApFrC+uigKPVUz8HRfLHqpKvVY/JozYx1sonF4d9YNkSUG/vv4ijvi2r8ZwyXUQm9XtqWhq3UTbBZtiAXm1Q/08MhhXkv9ryU93G17ywBy2J9n+rAfPeNNtIGOGzl3YeB/xxD7/NdmSV+sn4H4krmQE/XNqrtxBM/kZ+jUPyOHLP3Y0LdgBE4DIusqJNs7xJYlYBMk5uZRmO3Gmfuyc4W3q5j3DmrG/coUi++zh+4qItEhWyo1ooKonthxi6pnD0NWvUAVuhDJOyb2DMHTXaTjfCmVSEK4SW+SuDy6vopxwxgYLvo2l3tmiJTQHByMsgE74PBNhjAJRDzUqKM1zMQuhHOKTiqthRNZvw16jO1O2fARKNaa2qgmKGHkEH/2J9gup2vVkH8guojKNGV40KVLnNk65o7+q/kNiFcVe7iXYcWviqf76U+NvHDshmq9PLQy4m1TB6y9/N1GCdR+lJMcn+uuIgNJLhcpgcuGKgi+75Q6Y+t3QicrbKN4B+WIQLQqG7/E76zKMR98fF/alrGJrTDHzHie1J/wVx6OHe6tQqB084ZLKmqhi65nvA9gubOa2vi6GKpdaaAFDoMH0kf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261102123227099003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261022113327099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l7JHBTK8pon1gXzs2WVBeRd4WK3dYLiR+fGyWj5KXFpiqjx0p2f4s4jQxvPr?=
 =?us-ascii?Q?De9Lg7Dj4MpAReNN77p35GElJ4UDBIjqOsuMJuqkNMwQlzV6AL9tfL2P31LG?=
 =?us-ascii?Q?iYDdIV9b/Tx89D+yUM8neUr9PhD23vRXhdrAokO/Fo95cnjZTH0LV7PcLIh9?=
 =?us-ascii?Q?kMFcaY5Gy7gZQgLv1Bg20yWM5tHXLV1WxRgk6VMZx6+qa4rfW1NzIY/gOE9v?=
 =?us-ascii?Q?LEG+R56irStahaayq1kaVBeAGagY9t6RXzrT3SByiXq1JpsTazAczB61X3S0?=
 =?us-ascii?Q?dZlScppLc1tg+V4F1LSREY6uFUDmW19L8MPbHGBGrFmy6Jbf0SsIUXGJiAFY?=
 =?us-ascii?Q?HHX25C7u89SgZvbEUMbTX7W4kH8xfgcbUxhI+9EREIRKSIGA+YFjZAmWznTg?=
 =?us-ascii?Q?z88TjsFs8dYwQiIrNCWy4Ft1aj6e5Dt9cPz+OtidHLgeXhU7Xe4bkNDCtDgd?=
 =?us-ascii?Q?whUA+9Nlfj0Br8+D1Vy9llQ4k6iaG8T4m7HtTI4TamL2E0RXwk/O9AAgvd6G?=
 =?us-ascii?Q?sNwG6/cijjoukqdXb6zMUjhIoXH7s6mUeqNJrVyVc0xgO1kPCBaJZvpgycLM?=
 =?us-ascii?Q?iAPEQ36HYUtu30OlsG54qZkp5IIucMFVKuRbVjPdwHSLqmh5Ih4J4H8N2lat?=
 =?us-ascii?Q?asShAnJjLI1ziCIiqR5NbwlY5mOjuTmY6N9b2p+kpFzEnX9nsnVF+ZiT1qTC?=
 =?us-ascii?Q?+Z3oGbSUX8zfY4Pwo398WffG6Bl/2zVT4awHUDjWKJ1mLQWDvr4ied1u706w?=
 =?us-ascii?Q?+DvBfOPhs/aHYMVJCDuh536WoDr+UxvjLlwsWxShegqo5arSQPE3jZt6ROrh?=
 =?us-ascii?Q?kfAheHMRNwkplhJepRxqt965S/+ZdupczD1EZl7sXfOA5J1Xcdi/pekAHXUN?=
 =?us-ascii?Q?vv/ugH1ljmjFjDHhXCZV6mP7jgQE94QTr/2CdZA3WBqq1FV7pp06XeJPl293?=
 =?us-ascii?Q?khjjaZ8hkXoFOM6dkMPOamaT//V9WhY1UENJW6PXmJh8MskZxtmL/iS8PnXn?=
 =?us-ascii?Q?LX8uWpFn52n0HNdOWrSVZMWFTXlko1MOaVKAygH1cm+BkACHwdgaQMryWB9o?=
 =?us-ascii?Q?Anv4zM5rBNRThOvwDG5LBHFHJG6vyvnvA07ds4qTXRtOy6GXlQgocy5GnjSl?=
 =?us-ascii?Q?pLes62b7u3jWqs9t66y9PBuBDTduoKNsdaEGovt+QnxvxkSW3DrxWQPg+9Wl?=
 =?us-ascii?Q?bjMjTJco4C5Xu64B9XW8xyC0UmmTx4cvCH33Gm23IGNQMxofx9Ofw8x/YAKE?=
 =?us-ascii?Q?FpKC99Hnr+BZBMG3bJ7BinMoc198O2dUGz66Dd6Wvd2/yA7LaB+GKmVovvoR?=
 =?us-ascii?Q?hN8ADP4PKQM2ibKOfgz5oQT15x6e/5ZxUYritp8VtxClSzpwAGRnSRER3M0t?=
 =?us-ascii?Q?DTBjB5Tkm5D78iiRnK6H7P1pm/zJ0xD1rc3kNubv9hrrv/XNpILiUeLPGxg+?=
 =?us-ascii?Q?MAkxuhU+yrfL3joXWkAbJKXoG2triic1UOukiuM7a8XDGOXIph4MqzzudkPO?=
 =?us-ascii?Q?XpInMnaBwYuz68/SmyLnEDBw6yP7Nrk8BRW86L06XeRl+vzKADjFYh61NhLF?=
 =?us-ascii?Q?6/5twR/msQaLish6VzXfLhh9qr9LsnbvDw5sTZDvZ/Y3SZYztdBE7QRiMyCW?=
 =?us-ascii?Q?Ut4CqtULzy3ialZvbQGLX5z5IMFSAtbKOn7mkJmidfQCcuX/iVn+rhxoXMXc?=
 =?us-ascii?Q?7BCm8FnW94roOTsDe/7ZXAdtP7IqTeF2Eu4m7s5BlHnjsjBwj2y+lmd5/iXx?=
 =?us-ascii?Q?0Navdgrxzsx08WH/vx9HKMRFi6crJzc=3D?=
X-Exchange-RoutingPolicyChecked: tb4JgyteBTcpxpGDZd48hmdUaZwd9fcvb3796EDQYbRbm9hGFVUkkCyTcHE1KvP222ArKVo7aPSVeOL6UCer9Qh90WyoDtdqNwen9/MQHozi3jOOPdDGGe/g37aBpeB30vw+qYq100Qu96vUnjLk2jE32xGR/oerZb4yxUOjQf1gMElbesQ86Muj57h3Z0LKo/m2VA3I0U9I/2rFPSJdJiK4hpmEDg2ujs+bUdW81s2J/GEXh2L0k8sHA1O3ebPkgmb4JwwR3tv0JafgAyOmXA+N8G6GO/MXUUY4RDYHjl7PYHTTK2mcMPhoDE/HHc/KQsQ/r7uY+x/eLNbWJeKZIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b52501ce-82b3-4724-4921-08df38f6daf5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:34:59.8301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMbpWnWnE7RU77w+BsSAFsNwoQ2UrZ9QvZWj2I/cXUNH3NcK9ggi/DK3w3iIQ0p341WV5W2XfFQvaCk8K4edFIH4AlIxXDNaTbkQS1Yx5y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 04:27:59PM +0100, Thomas Monjalon wrote:
> System headers may indirectly include linux/stddef.h
> before the imported UAPI headers.
> Both versions share the _LINUX_STDDEF_H include guard,
> so the imported header is then skipped.
> 
> If the system header lacks __counted_by,
> its fallback definition in the imported header is not processed,
> causing a compilation failure in vfio.h:
> 
> In file included from lib/eal/linux/eal_vfio_cdev.c:14:
> kernel/linux/uapi/linux/vfio.h:1524:51: error:
> expected ':', ',', ';', '}' or '__attribute__' before '__counted_by'
> 
> Include the imported UAPI headers before the system headers
> so their compatibility definitions are available.
> 
> Fixes: d129414711aa ("vfio: introduce cdev mode")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

LGTM

>  lib/eal/linux/eal_vfio_cdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/eal/linux/eal_vfio_cdev.c b/lib/eal/linux/eal_vfio_cdev.c
> index 4a955248ae..e7cd547c1c 100644
> --- a/lib/eal/linux/eal_vfio_cdev.c
> +++ b/lib/eal/linux/eal_vfio_cdev.c
> @@ -2,6 +2,9 @@
>   * Copyright(c) 2010-2025 Intel Corporation
>   */
>  
> +#include <uapi/linux/iommufd.h>
> +#include <uapi/linux/vfio.h>
> +
>  #include <dirent.h>
>  #include <fcntl.h>
>  #include <limits.h>
> @@ -10,9 +13,6 @@
>  #include <sys/ioctl.h>
>  #include <unistd.h>
>  
> -#include <uapi/linux/iommufd.h>
> -#include <uapi/linux/vfio.h>
> -
>  #include <rte_log.h>
>  #include <rte_errno.h>
>  #include <rte_memory.h>
> -- 
> 2.55.0
> 

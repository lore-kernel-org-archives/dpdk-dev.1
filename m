Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84ABC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCB6A4042E;
	Mon, 11 Aug 2025 13:36:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 275624013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754912199; x=1786448199;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WIa114uO4Yyff60pYwEoT98PCDl4DA2QvJzzRYNSz9o=;
 b=B51bb9uLgFFYRY177XEwIXRNxY6EQIIfGp3zl/UAfZxUDwIh8VgKxYLs
 7FAGj9d++WsVuf2tHb1Nl7manoKhVT4HhSmfRL/wZDWSV8Q+Egdh0k1xq
 Yi4+QnHU4nDKwhZuQAoKKIm3gszFBqASxpki89x37gcbnm5PjEnvUzUof
 A6rLqGkkZwi8IuGmXOTaAp8sElfK0TT9uugU1vUtQoWiIg9EFPtH4c+rD
 5huGOOZRSMklnt7ggcv8PhFdZYcd+4A+MIdXqoA28aau9Um+YjkkIvEbI
 DiZmIL2imRN18P/q+XggS5HcWbY8nIlkFb+QjrXYcp2vaVgTApEv8euxR g==;
X-CSE-ConnectionGUID: bBwKO4tVRmeo6tDowa+qxA==
X-CSE-MsgGUID: jAZalgDvR3yvNoHMTCa49Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57083177"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57083177"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 04:36:38 -0700
X-CSE-ConnectionGUID: X6eJ31YNROaIh5vPhlm4Rw==
X-CSE-MsgGUID: OacyKFtiQhOK2oYWF9Puxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="165099827"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 04:36:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 04:36:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 04:36:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 04:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvrnMeSO/5xVOoTrPTkfVcbg5naSem/5vKktlQSIy9LbltgPOHG/rM7J+lkKX3giMX5xVMdNjcwgHv0Q0/xzfY8zngwvs5sWgpF3tLm9nz1o/UbOeZ7j4RBRtSM0O9tPqZ98FJETbhpU30gdFMjQoKEtKMQOAsALEO3E2GbswE6gbL4KTE63Ah2Tdk3FMc2gDFsNLMIyKS3KAm7zQV4GPkjigjeJKVIf6ZZDPpcHW6DmqbNuOg3j1IZpJlZ3RXotXg0/1tCB32xzfNMHdwBYNeKo6EPIphRslH/NIL/4sAlbRjN/QBGE+Pb75f63H4Pb1WCp5uLYDcIQxYo2AJ9WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edv5e2ye576N6ez6NS1A1y4VzFribKmhqDKlKcNTZ3A=;
 b=W0w9tCiBi//rZ7DKY571gbu5WAIkXd8ORPWIsy8ecUT34g0BiqoIqt/2g1IS0K7C2KmFg4yJ2TXsq8klr5JS+chigwYp1vwIxWeiu/2AAkRb3uIsZ1FFEgQawTA5qLNsr7/MyOo8+eV1DBHSeMrjMW/5XwBISBPWv/omokenEANaos1AdBK1AKGYH9gG38S+oHRO1h7n16dGvO9s7qnCUnymWZrsi4O+gd4IArjoZZGyo23f02Gik4BYs1O5xv3y/9JqGfSckUsVUzIzcFncAltw0gzdHvMwNj673xMc1YoBinbJmRQGXXFoqRjmktx3p+C17bkHlVxWVf63WG+l3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Mon, 11 Aug
 2025 11:36:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:36:35 +0000
Date: Mon, 11 Aug 2025 12:36:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Message-ID: <aJnVvjcg_nhgnesS@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-13-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807123949.4063416-13-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd1934b-17a5-4f4c-30e9-08ddd8cb53d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Efx+LLWHUKSE3tfIOxVGG2YmzpIit9/7iUAtuR4S/3FIq+4nE/rycSUnhDVb?=
 =?us-ascii?Q?8QX9PzJce4Ao73mxt8415CDUYVzPZsBmnWGjFEBaOipRql4FhY4BD5oV89HY?=
 =?us-ascii?Q?I4lm21v6QfBLhVREFSa2ce91+ogDKbpxFu5+C2jdd+1gINBbxSnqSIh/ayBv?=
 =?us-ascii?Q?dzy7xzNq5HI733Pky3LBmf+0Oerlo/3vG92TG0a1pwPyiMGF3tOjm0d2Zh/l?=
 =?us-ascii?Q?mxPLxbvHsFpmJVWNRAPZ0154kT+2R8Fkd3h8pca8jSXPPHLvpuAudJDcAFNb?=
 =?us-ascii?Q?QOQxvZRwsu6WvQ3uq/LdIVp2Fv1BKDNZ0KksOgMLWat3/lxyyazlZp4jd4Zj?=
 =?us-ascii?Q?TMWvP6m5uslLa/dMRfFeKSINSSjzjbEaKzZkhJB21CiXjTUOS1wEM+bYh6XV?=
 =?us-ascii?Q?0ZlVHlYPG4Rk0+REPNyEq/cZ3Q3wcUOdd1/bpmkNVABvfOTVbEBTw6+ZIF8S?=
 =?us-ascii?Q?qKMMUMav2IdGWkdENf2H1PzFN+BOdLfiAI/oIYE4NrFBzUC15XBKQDRYLk4r?=
 =?us-ascii?Q?CT9Brn9wk5mS7GfuY5/Sm0Mt55DOpJVC238FTYg4byolbjzGZXAxXHYqheu2?=
 =?us-ascii?Q?vEBJfHiWzzp4E8IfVD46PcoKqxeor7zPFFfvJT5idpSRmosyRyZ0wd20MDPI?=
 =?us-ascii?Q?57A6g/84VrcSe3bj33IX9oN6dQOVZ5y1i/jR/4KxMy3SVVYjwwpIC2n2H7xJ?=
 =?us-ascii?Q?nO8iTEkIMv9A1lPyie7aGikND3fwBH1xd8vLc0wSa5FSW4SRGvROR5LoXjxa?=
 =?us-ascii?Q?ofog0SUFGUDGPi3pMa9spM2dLGAgy5/2N9Yi9vbgndThSVurIZyG1l8KjAeU?=
 =?us-ascii?Q?SC3QRWxiEAqWRlkGIlLY6/ZiI1cCM2QyXYhjoBJfCf1v7+GKqvx6hSmke09d?=
 =?us-ascii?Q?hMhMrPTD1oaUQ/CCyOyXDdSOZvLzhDW35/fBP7HxRfjEzxWaT/Q7UhIfHxcQ?=
 =?us-ascii?Q?JUrYeQku0WAFKOBFPsRxFTfsMKsi3i6v9ECwiPvBHUvIK6ULNKixHe2ELDOD?=
 =?us-ascii?Q?Tau6VBlJe9giKJ47yEFN8n5p2roLBqQeD8o3IqNRNF9wnrhhC9TPLlK3mfQu?=
 =?us-ascii?Q?h2G1W35fUW6w/5V/GbGgmjKr6qofby7lzneIK11MnmZozeHErF/rb1jbCN2x?=
 =?us-ascii?Q?SJR/eZe41mTkHublLgqEzrnSm/6exFsyjNrbCNF+gzsnxp7PPvKjymrCdXDD?=
 =?us-ascii?Q?aripkH6RKJCVPRZtmg/nkrfdw/04VPN7r0TjiEYvz0XTUW9gqhla3cVtCAN2?=
 =?us-ascii?Q?Lyu59Cd8lKCscyUPenB2ZWrW86lxyN6A+YjBOIrgpC/iY1sDfOOriL3tkNne?=
 =?us-ascii?Q?X839idvIFUYbomUvm1Cr2tIfbudnj2HWwRB7i/pXJpA2TVwZwn+R0MaJMEY6?=
 =?us-ascii?Q?NKAAsZjnW64SC/bpXtYigdM5M8BoHQoJua2H/iVT6KJj/yFpjNLaO+Z226fd?=
 =?us-ascii?Q?T5GbM0vYN24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OI4IlGCpdYEqwx8TqUtIW+yxqxwIWeYn3aNeyZT7dELzzTyRhvpI8qYuEUi8?=
 =?us-ascii?Q?VXdyasVtK4Tq2ZiO7bu+r4AxlFGIHLhweheWPyO3WUVqFtjmuyiKCwM76MH9?=
 =?us-ascii?Q?vPiP3yXSQwMBG4iYyT5an+X3lGA/SnHOTln7jCjwyky8UNHMfz6B0jZHS6S7?=
 =?us-ascii?Q?Yu2BGRjhuuUfP3LtnddGatyF290F54NczHgFI1iItFpocbbLE6PodP3rFhMA?=
 =?us-ascii?Q?5iuJoo/hR6oWIPh7pUosH86Fyvukh09QozIJFg6xVHxfs9F4rONAbQOwXTyD?=
 =?us-ascii?Q?aOCkdUZ+wFy2QDCOai7/17+hWOsjkirCFLGt1Rx/i1ZUYsYXZoxOwkAzBhhP?=
 =?us-ascii?Q?KmeInom5BiBl3KwFwHnB7aMf1xYgcaRtrR1FQ7s3+ebklgdSZKVH1CgbkNOf?=
 =?us-ascii?Q?1LgXsTDJqtzEtn+vmo7g+gLSxkSwnXQQWiG+6K3bL8TgEUCn6AVra0NAuG1h?=
 =?us-ascii?Q?ohhHKgrxpjSeCM+XxuBrS17sGZVpfRbUHL1evdfvYVdtzwEVO6u+OwuonDa7?=
 =?us-ascii?Q?JTYnFi+OsndPyGGQPnK5wL5+jYQMMGf1vlQ+cIztQ2OecIKnD4YvUyYDzAv2?=
 =?us-ascii?Q?/TSDDBAivI6sNpGIWNUhfZAFM8UwkX0DKoOy2PUoGYh/yh9jUPdg2EBgGiZ/?=
 =?us-ascii?Q?zVjobWVaojrj0TOS+HWVtIDQwotQ87vBeGfOw+r1SfexSmxsMulcZYF1B9bY?=
 =?us-ascii?Q?zGgfoCfmDAQDcAkMSgUKM7T7V4LK4qNGjc35N1Xg1uieJjEEV7EBiygr4i8S?=
 =?us-ascii?Q?Wl+V5oDZnE1pDul0FtVfCI3Ywyy6fTUX5Cy6dmOIBf+9O8DV3VdYGzHUZx3B?=
 =?us-ascii?Q?gal3lFyqwyhd8qfBlXI9SS3tBrXYY/rsxyBBNXQtXHkyTDqw5qXnlicq6TT5?=
 =?us-ascii?Q?fD3HlG113L41fFTRapuxS5vnWmdD+LiYF9R9ADs9nnEHxwPfKCrfo53WawnQ?=
 =?us-ascii?Q?CwTcCZVYM6toJE5798SjFUu7+HkKfnqCG6YfGE5/sA0hS2voVTyXbpFTp93I?=
 =?us-ascii?Q?vFchlxUJWf2ZSGnyzTXjFhU8bh9s7toMbq/oaiqdnHr0JvTUTa6QYAo8T/3J?=
 =?us-ascii?Q?jrgbTqKvNQjOWN2blU5MIpqVimX5b/Suj1Ibhg8K1+Uj1W7FBpXq57CP4aem?=
 =?us-ascii?Q?PMgXlSsqDURTLVM3Ka9sCMH48Z1f3FC3dhymvmiUaS/iBZFaOWHEnW309sR+?=
 =?us-ascii?Q?RkGC+R84SMpri/dQB+iArs0XSrpTTaxOJYZA1p6EClCss0GphEvDiEfhdBQ5?=
 =?us-ascii?Q?DGfPIsNR0bXB+PWYT61n6uw/oke6pnXEtjqOX/z8zx6xVcAsdNYVeTaV4nlJ?=
 =?us-ascii?Q?h0Tbh9xEEEntRBoHqHtXPGXI2bbpE8XwHB6DXIQVg6UVu8elZsLFO1ZRVRRW?=
 =?us-ascii?Q?BJj8Ums+Z7eacosIIGaMP98BO7bHkwkPHEyz4rgnrvvPuuRyMdWY+cIwyz95?=
 =?us-ascii?Q?iw/MrilB2eVhVJsXtezxb1ygxWlH65hHIzAAvlJiTEc9/4zehW84F4OxR7xH?=
 =?us-ascii?Q?NHfiVZUKFHG15S5hamku0m3WCEpSQeLDFEXi/UUwjxJywo2UcSPeeY+SqJvK?=
 =?us-ascii?Q?FRpX9gW+TQ4r0IDz41wer0pLFgH57yO4bTlS8G2OPZd3w/F3VrRYJH4Ibrrn?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd1934b-17a5-4f4c-30e9-08ddd8cb53d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 11:36:35.5944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l4wl5tIJ0TbFDnfKEXbZOqxFzJ49IsmM1YRdHDHwENzmFL1e5hG42Vn5d7qxACrSwqas7IfTiyMDWkGawEbnC/ftS6NhzSHEQsOLmR+5tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
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

On Thu, Aug 07, 2025 at 12:39:46PM +0000, Ciara Loftus wrote:
> The code for determining which Rx path to select during initialisation
> has become complicated in many intel drivers due to the amount of
> different paths and features available within each path. This commit
> aims to simplify and genericize the path selection logic.
> 
> The following information about each Rx burst function is stored and
> used by the new common function to select the appropriate Rx path:
> - Rx Offloads
> - SIMD bitwidth
> - Flexible RXD usage
> - Bulk alloc function
> - Scattered function
> ---
> v2:
> * renamed various items from "burst" to "path"
> * added missing doxygen comments
> * attempted to improve the logic in the select function around the bulk
>  alloc feature
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Two comments inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/common/rx.h | 103 ++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 70b597e8dc..6d134622e6 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -10,6 +10,7 @@
>  #include <unistd.h>
>  #include <rte_mbuf.h>
>  #include <rte_ethdev.h>
> +#include <rte_vect.h>
>  
>  #include "desc.h"
>  
> @@ -125,6 +126,26 @@ struct ci_rx_queue {
>  	};
>  };
>  
> +#define CI_RX_PATH_SCATTERED 1
> +#define CI_RX_PATH_FLEX_DESC 1
> +#define CI_RX_PATH_BULK_ALLOC 1
> +#define CI_RX_PATH_DISABLED 1
> +

Do we need these defines? They are not used in this patch anyway. With the
values converted to "bool", using true/false should be fine I think.

> +struct ci_rx_path_features {
> +	uint32_t rx_offloads;
> +	enum rte_vect_max_simd simd_width;
> +	bool scattered;
> +	bool flex_desc;
> +	bool bulk_alloc;
> +	bool disabled;
> +};
> +
> +struct ci_rx_path_info {
> +	eth_rx_burst_t pkt_burst;
> +	const char *info;
> +	struct ci_rx_path_features features;
> +};
> +
>  static inline uint16_t
>  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *split_flags,
>  		struct rte_mbuf **pkt_first_seg, struct rte_mbuf **pkt_last_seg,
> @@ -222,4 +243,86 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
>  	return true;
>  }
>  
> +/**
> + * Select the best matching Rx path based on features
> + *
> + * @param req_features
> + *   The requested features for the Rx path
> + * @param infos
> + *   Array of information about the available Rx paths
> + * @param num_paths
> + *   Number of available paths in the infos array
> + * @param default_path
> + *   Index of the default path to use if no suitable path is found
> + *
> + * @return
> + *   The packet burst function index that best matches the requested features,
> + *   or default_path if no suitable path is found
> + */
> +static inline int
> +ci_rx_path_select(struct ci_rx_path_features req_features,
> +			const struct ci_rx_path_info *infos,
> +			int num_paths,
> +			int default_path)
> +{
> +	int i, idx = -1;
> +	const struct ci_rx_path_features *current_features = NULL;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		const struct ci_rx_path_features *path_features = &infos[i].features;
> +
> +		/* Do not select a disabled rx path. */
> +		if (path_features->disabled)
> +			continue;
> +
> +		/* If requested, ensure the path uses the flexible descriptor. */
> +		if (path_features->flex_desc != req_features.flex_desc)
> +			continue;
> +
> +		/* If requested, ensure the path supports scattered RX. */
> +		if (path_features->scattered != req_features.scattered)
> +			continue;
> +

I think this test should be in a similar format for the next bulk-alloc
one. After all, if scattered Rx is requested, we must provide a scattered
path. However, if scattered is not requested, a scattered Rx path should
still work fine. So:

	if (req_features.scattered && !path_features.scattered)
		continue;

> +		/* Do not use a bulk alloc path if not requested. */
> +		if (path_features->bulk_alloc && !req_features.bulk_alloc)
> +			continue;
> +
> +		/* Ensure the path supports the requested RX offloads. */
> +		if ((path_features->rx_offloads & req_features.rx_offloads) !=
> +				req_features.rx_offloads)
> +			continue;
> +
> +		/* Ensure the path's SIMD width is compatible with the requested width. */
> +		if (path_features->simd_width > req_features.simd_width)
> +			continue;
> +
> +		/* Do not select the path if it is less suitable than the current path. */
> +		if (current_features != NULL) {
> +			/* Do not select paths with lower SIMD width than the current path. */
> +			if (path_features->simd_width < current_features->simd_width)
> +				continue;
> +			/* Do not select paths with more offloads enabled than the current path. */
> +			if (rte_popcount32(path_features->rx_offloads) >
> +					rte_popcount32(current_features->rx_offloads))
> +				continue;
> +			/* Do not select paths without bulk alloc support if requested and the
> +			 * current path already meets this requirement.
> +			 */
> +			if (!path_features->bulk_alloc && req_features.bulk_alloc &&
> +					current_features->bulk_alloc)
> +				continue;
> +		}
> +
> +		/* Finally, select the path since it has met all the requirements. */
> +		idx = i;
> +		current_features = &infos[idx].features;
> +	}
> +
> +	/* No path was found so use the default. */
> +	if (idx == -1)
> +		return default_path;
> +

Very minor nit - I think you don't need "-1" as a sentinal value. Just
initialize "idx = default_path" and drop this block. From what I see you
never make comparisons based on idx, you use current_features for that.

> +	return idx;
> +}
> +
>  #endif /* _COMMON_INTEL_RX_H_ */
> -- 
> 2.34.1
> 

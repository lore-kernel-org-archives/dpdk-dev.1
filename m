Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D4F46456
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:38:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9A844025E;
	Mon, 16 Mar 2026 12:38:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4F7BA400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 12:38:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773661137; x=1805197137;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UtCNYDxWGcw3Fg8h6S4hIGK8s0EdodU3A40wZ2DHvnw=;
 b=m1QtW0IR8lajPb3iCGy+3zYBGExomwX29RoRDvruFIptqVvh4QkKojMI
 SLree3JwAFb+3+aN9U/vkxp/6Hhd1POTyKxmdhBVsfNKjzOhLUvdcYp41
 jwiis4mhvozdZlN+RwwEMju9LeUhWmZ1mfH22aHgqnsigIs9W4Rjmh7DD
 cKOJIQ1H6CmBsybuGnHjRq90U00QeOTm/ofFCbMA/FGKZrmfs2hCW4I17
 QY8WegX+KP7LU4BzNuvvXNkrRUVDVjQ0atH3kPlDKHzI3naWBPkh/R4Q4
 Q7pU2XXYgeaJxES0i0Sbx7QH7r+cOx3eJwTkWjSo2bXcnSvSbvRgm2sHM Q==;
X-CSE-ConnectionGUID: BMNmGflDRxinWA3ra9tlsw==
X-CSE-MsgGUID: UgjGr7AoTK6ntuydOjjfgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74560131"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74560131"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:38:54 -0700
X-CSE-ConnectionGUID: X+xtKbd4RbeKYIkjZMMDWQ==
X-CSE-MsgGUID: d1/LztsSTnu21LR3PBKKnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221971731"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:38:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:38:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:38:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck9QdxUODmG88Ids3YsDrCp+LmAu04JmTjKQLDn3gPm+FpUrryaEjGt8y0tMrQ70OHkrHtblzAefIT88rxqCsnPW9OQkhJOUzwkXMuYiiAmNm4jajjq8k+lvg1pdxXnLeY4+RcOoYJxJ8fY0E4GzkyZbuX/eEIiKJu/Gfzv/zq/efViRC7b4Qrwh3zVpTqXQKm40qKTfeS7DKND+eMfmyCsfoZcYwZnxyKEipNwTNA3xddE7eLtJCly+9xkmrlh6XSSAFh9TcYQsuJwo9eiPSxR/fuSVxUzsHEfIpoQBmPiTEhq824gpW/5K2yXhvS7GbVqI+y9dEazggu65/OZ0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REU1y4z5G8vVWw43jYPZQpT4kr2eMaRGg3UEbuIyBQ4=;
 b=J5oY+D/D7B4zawM867AzQB2TQpiOUZ1cR/mJBB2euQ017KYkQWwxKs2Pxz5c3QtjRsMONxORwfKjUdljBiGgvyhB+/PfhysFrrlpxUQZCQroOGehKTSRtRTYrldpV0fZ8bccWWlzNpthvemyKu/l16fxS0PGnj9+zshWHZrjT3OpeQgFl8lUnnkBoT7ZgeaPaKsNb73n6Ra3zkVk4zJcucc6QRXBkhuiHBAxcRQiO+TBeU0SVXEQqJIiXtao2XWZXF1Wbk0JimH0toSfSOMZbeXvVysRiSGoPMkF7V/tLLNm6P9at4dnsfufmQyZZRpkm84Lt/BxX9D375dOKzA9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 11:38:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 11:38:39 +0000
Date: Mon, 16 Mar 2026 11:38:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 06/25] net/pcap: avoid using rte_malloc and rte_memcpy
Message-ID: <abfruk_fW_pkv8QH@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-7-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3af7f9-bbb1-4d38-8775-08de8350913d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: bsdd36ZXlGmBHs6QmQUgLLGNid1UL+HoNQ8sXOIB5Y/mC7mFNNv73bXFqqqWKKFWPluf0TiSq/jpRB9180hF3DRTLriAPPH0Tydnik28fMAgc668s1ASUH78JWTCQn0HGxFyVdBrYybWsOO65f2108AFYCaJLmwyBvZlsgSmUoABExH6VtHBBw21skAKfeWtUg4aFXs2yeSqHPkgMY6014nQXZDk+ilHZXs3FchQM4zkL9p6dgCWy9Qxq9i3uSOvWGXCW3a8q1J799HYoGebz1ZL8TiXzAgxHdBOdwGrob2QceUz4o1ti4WCv1hA4Xrd6/EDToBn/7MRBAZCrjJcehvG4GgyKIBTpt75fhHbH+8y11LTkdocVr0JCr21Mu9lHOcs7xGKdMgeN151Iqxf1Nn0iovc/KRjcMYGaqHk8YKSNgA2570Fo18MRMta/j4NSkG1Bg60RtVR65Eg5Ct5vdJg/rrvakV1AAOnAm3B3lGdTW6BSd2dSTCaAZFtTzPWtYyx8noOaFV8sSOeNf/Nw2jnh11cqQ+LSPMqsPLJeeL03diQ6yfDpjhXiCVPegtfyf7qPlk1YZ7HvMVWrEQ8cIsWlJMBFFTy0iA9KWesuydXzubKzv8r8Lur6Kd5GBd9HO+2UsPlVzpA9OtBpjGgUXz+188/BtWbFw7/Tx9+Ys1+5Oe9o4UXQcSkx1SgiPNselbsD4fVMCt0eDsT+vewA5XbtEAx3GgcB7wzTsn6qfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?olA/TrIWe289bo5+XjQn+0ayqEYa/tDJDga3bZj6/P5SFh2XjxB9RSEwu9rw?=
 =?us-ascii?Q?fYDAG3Qa+yU9s65ezj33tumZsvItIedXZKvTinNmTp8S/UcZIg16XabhzoFp?=
 =?us-ascii?Q?QIfjiyWuGi1ijjiOAuqra843MwxOmSvSBsA3uPl+tJgJVG7rmsbcnMhWE8aX?=
 =?us-ascii?Q?2Y9iuaW3HQamI3b22PWTcViphQytlHLLE4J/CLGPp7rXE+143XRb2nIXzhxT?=
 =?us-ascii?Q?ZZhDeRJu7XDF5Sz7B3f5S2DTBKf/4xF7ED64R6nMkKWzWPKQAwZBNxLJDlNN?=
 =?us-ascii?Q?xn9MAKAFBagclM7/BVQXkMSbGSy83k1n30w9mc+/ElCNI/hF/We0gxHY7ETR?=
 =?us-ascii?Q?PPHZ2vkUv9KU+7veqBaOdS1xJJIOJPMvYOowu3xAW1sjetcd6HX+0co6Pwdq?=
 =?us-ascii?Q?SlGXC8eVhzCjiEboiVSlyFXw9jzuYEiOeiBwYLAZd5R9OLFV27RV5KaKXLNB?=
 =?us-ascii?Q?eM+mC2d/e6T42ieGLhUmtGxmKk0Afsx03CY3XgRC27dvBo+NvaTcezL35l11?=
 =?us-ascii?Q?BWPelRoZyEYFOUdtDb6hDXD2Z6N7W4UXkxs9+1Q+lVCOk4JoDGZrqpZAbkFZ?=
 =?us-ascii?Q?XbSO371aaWPw3g9//R5TTUYf4UtQow8v4+bZRwsmybLyIWhH0d7sATXHmZjd?=
 =?us-ascii?Q?0ujGiTDkjLGcn4H+pVjewbQYEY/SoH8GQdUbp+yqZBg2Ym5omP3x/JRiMTFf?=
 =?us-ascii?Q?/hmEuV/rq0mELNNqmUkE3zyH8Z1exgL/lYUaHgaptFRG442vJ3ZLYTKEolkT?=
 =?us-ascii?Q?eljLj/QebghwopC0QTpFGYaKHAAcqd8qP4UDTpoTUpHN4Q52mzgzd/LATkfC?=
 =?us-ascii?Q?lZOt+iwWsVU3g4ztK0RAINhwhOeiHHMUMRFngH+al/swUZugE6jlr333+ydE?=
 =?us-ascii?Q?4142fsY3Ivoe3Y4Xrxm0khtqeCwEyBycQEjOMbATd+F+vakKnRWQOQYnRZLA?=
 =?us-ascii?Q?Rdgks6RCVvmSxaThHxnLGMNuwvNdpIRekCC95WMc4n4RHGsdvPU889bhEZzA?=
 =?us-ascii?Q?9+XYJPo8Mv4ZdH2u+U/2i5wdEB6Dbi70wjYdNWfjhjdlezzvBKy/vro4B4Mx?=
 =?us-ascii?Q?Pb02V2JZOZrCbK59whjvQ0EuwuIhlKMzjcF55SrJOBRH4IqlP8Ftv0426WY9?=
 =?us-ascii?Q?sLM8JsZ0phkFnIu8PbdsnqcTVS52QXjmBuZiumfgz9cnOO8MRfQLRkL7YqVU?=
 =?us-ascii?Q?aSxa+0A820D5RJ7zaqALB3/5DKttdPMK9d/w69JrTfwH4EcJ5e/YuY+8Zu1j?=
 =?us-ascii?Q?d3vLNACQo4hFFj3koCY1yduUzuYBwO/+EOnZcXM8FMX/SVFrbt1BfHb1zOoQ?=
 =?us-ascii?Q?u9lhZuXksPmvvuCrr4eW8edRsxEDTdqK8gtQ1eysPE8jqSpEz1zt+R48GmUY?=
 =?us-ascii?Q?2A4nOatPWfrnczRu363XHXJTET9yoWD3K1RoLDqs8VqVpWAnySqebtZQjw3N?=
 =?us-ascii?Q?VQkorWFraSG7SFCrtAkE/B6MMxsfX25Aiz1Suq28xjtE+5B5YS8lB2+LGcTM?=
 =?us-ascii?Q?f3GJ/GYao5d79QrkjsjDomBVQtK68oKVPYYB9JuiWQm7SGSFEEyF47FgSnyo?=
 =?us-ascii?Q?XAX5OTKi8i7s+G18UMGso/+RtA58nCcNXG9tmjsWgvoQQ4eoMaY4OwqY1zgF?=
 =?us-ascii?Q?E8TCDLPiBwg51kp8y/uKtTproAfnDsFK7c+9bYnXOqkO5P0Wep2D92u/z88X?=
 =?us-ascii?Q?DN0FEPAjIy+j6c3TPERwS2rhIkb7rj9Vvy5kj7slJ9RyRs8WE3qxJSE5n7X/?=
 =?us-ascii?Q?dm+i7Sxh0bTmBMJrQXE2wrwLj+0pfsg=3D?=
X-Exchange-RoutingPolicyChecked: iEIrzseag6c5eyObAIhQhrXEifXpGhkhia65EMT2HwY5lCOQf4A4u0BhLZCWE9YqqzSIGeKPGKpWeHdVBoH+Fa6hIxRPhHWzjC68Bh3iZlwEyyWFboWcS3t5eXLBuskqWBx+HAVkR7toPjX5D4LawVP0nGfUe+9BYtKtxGyvLQGTG3XLswF+4/kC0Y4WVHEJOW1Vc8Hyd/FfOt1vL7BL+YMtwE/zhjDixudkZ+MtodqWaOKKbq5sIkHJKPUkSAl5M8BRBqyl8MYRoTrl4Qk7kx50n/mARKpZm1LbkdTfXrwq2LyP56hEMWyTrA4ROSw+kdiXAGQ/0tBrNa+So+jv2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3af7f9-bbb1-4d38-8775-08de8350913d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:38:39.2668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kaROfHKju21e2mr7V1Wy6PAwqZEfQmRokrOK1ASAwOos17koyX/V2vD8QxB8F3lNs13FkqEowHh2lRNhJ+6xnG9UAitZVYgUMbjZoEUFUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
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

On Tue, Mar 10, 2026 at 09:09:44AM -0700, Stephen Hemminger wrote:
> No need to use rte_malloc or rte_memcpy in the short
> code to get MAC address.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/pcap/pcap_ethdev.c        |  3 ++-
>  drivers/net/pcap/pcap_osdep_freebsd.c | 12 +++++-------
>  drivers/net/pcap/pcap_osdep_linux.c   |  6 +++---
>  3 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index fbd1021c39..806451dc99 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -6,6 +6,7 @@
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <time.h>
>  #include <inttypes.h>
>  #include <errno.h>
> @@ -1288,7 +1289,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
>  		return -1;
>  
>  	PMD_LOG(INFO, "Setting phy MAC for %s", if_name);
> -	rte_memcpy(mac_addrs, mac.addr_bytes, RTE_ETHER_ADDR_LEN);
> +	memcpy(mac_addrs, mac.addr_bytes, RTE_ETHER_ADDR_LEN);
>  	eth_dev->data->mac_addrs = mac_addrs;
>  	return 0;
>  }
> diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
> index 20556b3e92..0185665f0b 100644
> --- a/drivers/net/pcap/pcap_osdep_freebsd.c
> +++ b/drivers/net/pcap/pcap_osdep_freebsd.c
> @@ -4,13 +4,11 @@
>   * All rights reserved.
>   */
>  
> +#include <string.h>
>  #include <net/if.h>
>  #include <net/if_dl.h>
>  #include <sys/sysctl.h>
>  
> -#include <rte_malloc.h>
> -#include <rte_memcpy.h>
> -
>  #include "pcap_osdep.h"
>  
>  int
> @@ -41,19 +39,19 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
>  	if (len == 0)
>  		return -1;
>  
> -	buf = rte_malloc(NULL, len, 0);
> +	buf = malloc(len);
>  	if (!buf)
>  		return -1;
>  

It's a pity there is no defined max length here that we can use a static
buffer, but since there isn't using malloc rather than rte_malloc is best.

>  	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
> -		rte_free(buf);
> +		free(buf);
>  		return -1;
>  	}
>  	ifm = (struct if_msghdr *)buf;
>  	sdl = (struct sockaddr_dl *)(ifm + 1);
>  
> -	rte_memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
> +	memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
>  
> -	rte_free(buf);
> +	free(buf);
>  	return 0;
>  }
> diff --git a/drivers/net/pcap/pcap_osdep_linux.c b/drivers/net/pcap/pcap_osdep_linux.c
> index 97033f57c5..df976417cb 100644
> --- a/drivers/net/pcap/pcap_osdep_linux.c
> +++ b/drivers/net/pcap/pcap_osdep_linux.c
> @@ -4,12 +4,12 @@
>   * All rights reserved.
>   */
>  
> +#include <string.h>
> +#include <unistd.h>
>  #include <net/if.h>
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
> -#include <unistd.h>
>  
> -#include <rte_memcpy.h>
>  #include <rte_string_fns.h>
>  
>  #include "pcap_osdep.h"
> @@ -35,7 +35,7 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
>  		return -1;
>  	}
>  
> -	rte_memcpy(mac->addr_bytes, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
> +	memcpy(mac->addr_bytes, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
>  
>  	close(if_fd);
>  	return 0;
> -- 
> 2.51.0
> 

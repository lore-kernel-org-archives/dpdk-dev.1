Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE1C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09A4F4042E;
	Fri, 25 Jul 2025 15:57:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A82E6400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753451833; x=1784987833;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+0KzqfG3bQC3zPuO62+YtRWzuWSNWvvPIFptRvqpmv8=;
 b=KYKfYf++pbdToy9y09V6+BTKzCjX7+VvPEy9bLU5ftdvcQHrsJ4giuSh
 Jwi8ZpN+uLQJ/6HCjOaQL8j1n/1vGxjf4G2PoD2i7s5rpuMT3sbiGJzSP
 BPd8ROdDIZ2D1YBXgBQZ3vPQ11M98IR/eJ9+mKX0fwdlenM5pmYRH79RW
 ICgApOxOF2/24qb0yKtik1/W4Iah/a3DeorkGE4Nx53jumJg4jXz3RmDu
 aVwVzZ4Qa6PbeYngVq/u8H+P7pSXpYDAqlanTchY3DPi4ZSndZzusuNIF
 LHBgs+Vtk4Mu3U6uw5i8AufMbRmHDd/LXvMdzgOD3mpeKVpW1IOfd9Xiu g==;
X-CSE-ConnectionGUID: Xh2J6rfgSb6X2/DXpoyvRA==
X-CSE-MsgGUID: My0Hx50ST9i3E6dVptQrEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66484190"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66484190"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:57:12 -0700
X-CSE-ConnectionGUID: h/4XIhpXQJCiAOg3hHokRQ==
X-CSE-MsgGUID: s46KXTF5TgOlbtuNcTHJHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="191934689"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:57:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:57:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 06:57:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeQGnCMB9XaALZ6zUnZsBK6ts7GCTan0i4uu8OeGVZ1d6/Yfc+BNsNF51XSe8uEfABbdPP/TsrwIgYm3MQdYtGUlBrB9aA+OCyTSm7o8UGQ2LlrFuPOCMAb38Ah0wiyCH9eNVOu5uc34+Sm8Mt18TmDMZ/2+aXr3t/iuB1h6xdY5zQTW8H/jbTI/NnC9lsiytcnYo+IbRpkiK0dgrD95hDb6yb708VhkjIknFAJh1m9mBNDD/YvDBS1Wahq+lSbwGFdF4xZL89dHuwKNpudBi6FhaUQk+fWQhqJLbRqsa22GwiTSGECLFNM+DMoKZfKt9ceKskr967+MQOuZ4QMtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfSB3h1jYANDpWywAW9xKdZ98zccbZpy2RLv+PpYAD8=;
 b=T8MaFy7I81YqN7r02C7KNLjLA8dmBRyVOw/xoz71Z4P+HNInZdQ6fkIUOSOfV/oka65q3chg+pK2pav6PEsRtiKkItH/UM733vnBuaPn1AXEDwRHTTnJjSMnD4JHvt+R2PqI1iuP9SuWoNVZnwTLTU3B7VCuQwZvIHD/+OfNjFYotx4MjRTH0CPWlV/bMU7QcfssOpsKEaz+najdxAJPKyIsLnHN9UL+DxVc0MiYxszFghjs8Qmo6bNilNatKG34JlJR8CRxtyqC6qSqmmcop3GcLG2akjltEfgB5YnIKuZ8RWoFnuNfvXebNX/0CbgzFhD+R8YnXsqiRFXmJ1QoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 13:57:04 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:57:04 +0000
Date: Fri, 25 Jul 2025 14:56:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 06/14] net/ice: use the new common vector capability
 function
Message-ID: <aIONKnXhTZ9UK6Cu@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-7-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-7-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::7) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CO1PR11MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a903a58-65a8-4712-a4e6-08ddcb83229e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KYCrhO+kkiCNrkS4FYg/bZkeankaqGUzZeEpdEv141s+qPN6w97IFWIixdyK?=
 =?us-ascii?Q?rLvob7J1OeBtgoRfZ/u1zIYz1ageb9MhG4S2si27GXexpHERDV5vpoC0jmvN?=
 =?us-ascii?Q?fT35JWeOwXTUAAGSp0Auvg9Jb5GG9kZ70mpIvpsN4CDXpQXQizXB1CRgcMS4?=
 =?us-ascii?Q?DDZEtFFmMwFfMQe35rMisGUQgWWdhrXz4LCraQQHxb8oALxTjAMb+ecpqGtR?=
 =?us-ascii?Q?Exz2xGFzd5BHqVhP7Xw0v1pf0KT7v0N6ZVP6ydek/clMQtk0OEdlbKg6ClKC?=
 =?us-ascii?Q?ZT1TuT7Db6g+gkQviIBMfLgMqhVs/EqR8dab42J72Yb/MUK18JhnU08/SMlp?=
 =?us-ascii?Q?rLYzfdFRtd8w7y07LIAlV528AGaqefpd/nO6uqGhhgEHZK3+Qc5h60yneD/0?=
 =?us-ascii?Q?Ux8gNLroVN8TtO5nz0bei+uJIQZpKeOmRHt3NpMrZ+KlZhxGGOKS2QEm/QFi?=
 =?us-ascii?Q?FXCejhRflovZCSI5v2x43OBA9jgMmPBI8APXkXL0FMoiMhM+Ln0yTmHI+26U?=
 =?us-ascii?Q?jsSfg8rpXl1SItaXV5VMWc5UNjzOygEG/dR7ZtVxuS0p/wovyqQzaFrpL6Rd?=
 =?us-ascii?Q?awovD0FO/CBzeIoIPjLd2jTXS7bLBxpYinjZ1zKhKsHmUPx9c0fcmTLOMqzB?=
 =?us-ascii?Q?FIVf9DGjVpOVzQfWoglHAc9Mtwclrmwej1rmtMI4BF/ONuvFy8Noadr+ECba?=
 =?us-ascii?Q?x2+v6ZZA4qYPhjpyzIsLAVh7TbpQE2u4IrM5mJRjwe94dai1LiL4f14W88H6?=
 =?us-ascii?Q?nZBt7Ebn8qQWEDyydyg8BNYzcvWHrd4EZxskMF9FR/EERgbXXG3wTuc016Kq?=
 =?us-ascii?Q?wCHS1i40DhbJo4yt83M92SfnOo3DYuBEbgkrMyNHX9Zde9uCjMyxIB821CPB?=
 =?us-ascii?Q?djGphTbc81EHgFoBcXubbnqsM8oigZwMlK07jAHQJSoWSE6KEa0GXoaWKzZX?=
 =?us-ascii?Q?vo8jSswycIvzmyq2/1VG6XW0Mf3lXjR7soa7YQvRXY/xPGcEUFiQeTb886XV?=
 =?us-ascii?Q?3UmCRfi07BVgXBFjkGyxQsXiQsVoa7wvWuuc4j0LRFErCHIXGMcX6G4P8hfF?=
 =?us-ascii?Q?hen+S/i5cVVjhFfUJnaEBBFNVwmeugIoiFScdJEKR91PohJo5uSgZgaWP/Qs?=
 =?us-ascii?Q?HgmzLsaxiYAoYwsl9Uf9Ek7t4Guv4RAHw105U+sAz3ghoHJc6sAtciTVbHhz?=
 =?us-ascii?Q?XcWqZr3bcBItzJXcZRKrCMBwcoUzJZcte9jzejUvc4NFeLVzxxmnxuPWlvH7?=
 =?us-ascii?Q?+QQ8McqQb9yrP/iLgDfH5OcPO1EnyrBRJlkb00EOWrVILIBuV4So0LHVYw4H?=
 =?us-ascii?Q?HXIwzO9Tor/vVzHuPEVb5b5dS6AZv9vvToWa1CNlerJU6oz4sU/FDeCz+//O?=
 =?us-ascii?Q?JwO/YBN9IPEOR84LVSuM42Ft5rzPbDlql1s/d4Vq/U1gK4Rb8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?toT6+66aM3qyKG16bSNxUQ5aeaOZWk2sCBSIKftnczSRdlXMF58z2Ash4Sgg?=
 =?us-ascii?Q?nXH79L8JZ0anWfY4jVY4HaOJHp/0pUrLfoyDQamCaiamvnmQ3aIwoGl2RzME?=
 =?us-ascii?Q?kV9UaWQY+zEPlmBBat2xEOxQjQXrDw6/7wsWAUWxMOXVRfgFGc+E+yl2XSLN?=
 =?us-ascii?Q?4S1EHWl0q9qSgAVmYKOL3dySjxCpeumV9BUO0yVPYG3CEJynD36tTRlGyV8n?=
 =?us-ascii?Q?4dH8WB205BBH5f87jJSeDLuDi3Ou8K/14I1S4HmIzYqiyh2ZneeLCfUGClkQ?=
 =?us-ascii?Q?RdOUw9tXP70tgr8NMm+hJB3XxD/uXmriqu6kmeq/lIQtGnmuNxqroDjdTvYc?=
 =?us-ascii?Q?JbeEHhUgkh61BiE5FS+1oLQOcdJZvKnGOieCToPx72uajT8kXAUl9fJgtt/1?=
 =?us-ascii?Q?P+fUb4jcFv3zUw3NkGSWUvnWgIAlDyvvrGd0yHWtvXQgSxbwkpSf4Wevp9wz?=
 =?us-ascii?Q?APie8SwOlt6OTKcAjDSkS1mOYBUujzZo/X/hNTYlruY2N5LPPlgKW/gBO/TB?=
 =?us-ascii?Q?GcT3myZGHccYhv2UlV4mxxuUhD01Fzim0OJQzZSDMR1mzIY4lVG9cHb1LJNB?=
 =?us-ascii?Q?TvaD+vQnZ9LrjssoOPUU/SnASV0grCAnPpTj1GjnGPOAZXMRGxarHLNM1lxH?=
 =?us-ascii?Q?xJHZvaA5KZLhmdjDiAlds5qdFGeAmTdWCCHNWLtVBW25Dw6vujHhaCXYDOTU?=
 =?us-ascii?Q?wPX4fwCGyuurlU5twzHgiix7AlpbOUVwhsygAZcOwGPHi6gKefq5zbiZRXMq?=
 =?us-ascii?Q?4mi1W3T6bw2bG4DQg9s79IXTlstWBjysP9nLZ2f3b3Te2flp5Mm6+SHnRTu6?=
 =?us-ascii?Q?dazw9V7i8WvnWqUj+cqyjtZlQpJ3WrU5eh7dCe8MAVXoh23YSPj0BnKN7GIb?=
 =?us-ascii?Q?nstm7tzhWghU8lL5OKGFmugP4KQjSzjs5r1pf8M0tO5etndiYfNizI4eNQyT?=
 =?us-ascii?Q?WqUP/SlqYPAZkgLqnzWHt/L1EKP5b+V8jUBwKP6+FqUKtyfwMSP0YYrDzmVL?=
 =?us-ascii?Q?XbembCgV2zStadgNWyYeG2GtrDAm83cX0iWlplPPMrBbnbSGVKwL5iudt18x?=
 =?us-ascii?Q?+kMFOEU8z569BBfPjsNry09IVQF9BrettgYCecog188DiuMrDFOnUQO0QUhl?=
 =?us-ascii?Q?CsuElMGn76NMver4PdZ4WPCCIVxyaoDexjb7B1In2GwkCd9SrQ3XS6NFnPlG?=
 =?us-ascii?Q?eZSFCPYp6fKVUlnWKVVouXj+xFr5fsCihqjFZ+FrCLiOwRF9GofaWAhJpx1J?=
 =?us-ascii?Q?4nbS5NiyO61MKl94OOaI7NT3pry198A41hJfC44uibuB/CAV9ThNRA8duDFp?=
 =?us-ascii?Q?iFgK6LA4MOLtyh9DD0ef7wr+Hh8FWAhR9eit5a+Mr4dbZ62Zm2Q9mm+GZ4mw?=
 =?us-ascii?Q?DIPVA55prWssfPxYMFH9FcCR+q3VWZphuvFuBsWKZlsn5EL1FXWcQ7i44JN5?=
 =?us-ascii?Q?JeALAymA2qeFdCb0Y4hi6mdwhTb0bQJkd5TdpbZUAUPHZ7a7s0Bc13NysN+j?=
 =?us-ascii?Q?DM03OYpE26pZGVh+gFjXLZCUFV337LLDWSwLNsirMRZ3fbb29O9TnG477QE+?=
 =?us-ascii?Q?M548NbZtQJ1TUfBgDc4qX3QNvaVNmmYBw0UaouS8n8qMAolMPyjUqXhvjQrr?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a903a58-65a8-4712-a4e6-08ddcb83229e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:57:04.1382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueArw8hNAdSOJ/8StJ+EEf1ktZ6IHUvhIj9HT0ZmtLh+idqcxpTk0SSUTjqj323/OSvQlhWL8PRpVuqLj+zcNNc8ioSJ4E9SEjbGsEkImzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
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

On Fri, Jul 25, 2025 at 12:49:11PM +0000, Ciara Loftus wrote:
> Use the new function for determining the maximum simd bitwidth in
> the ice driver.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Few comments inline below.
> ---
>  drivers/net/intel/ice/ice_ethdev.h       |  5 +--
>  drivers/net/intel/ice/ice_rxtx.c         | 52 ++++++------------------
>  drivers/net/intel/ice/ice_rxtx.h         |  1 +
>  drivers/net/intel/ice/ice_rxtx_vec_sse.c |  6 +++
>  4 files changed, 21 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 5fda814f06..992fcc9175 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -11,6 +11,7 @@
>  
>  #include <ethdev_driver.h>
>  #include <rte_tm_driver.h>
> +#include <rte_vect.h>
>  
>  #include "base/ice_common.h"
>  #include "base/ice_adminq_cmd.h"
> @@ -674,9 +675,7 @@ struct ice_adapter {
>  	/* Set bit if the engine is disabled */
>  	unsigned long disabled_engine_mask;
>  	struct ice_parser *psr;
> -	/* used only on X86, zero on other Archs */
> -	bool tx_use_avx2;
> -	bool tx_use_avx512;
> +	enum rte_vect_max_simd tx_simd_width;
>  	bool rx_vec_offload_support;
>  };
>  
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 85832d95a3..79217249b9 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3703,7 +3703,7 @@ ice_set_rx_function(struct rte_eth_dev *dev)
>  	struct ci_rx_queue *rxq;
>  	int i;
>  	int rx_check_ret = -1;
> -	bool rx_use_avx512 = false, rx_use_avx2 = false;
> +	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
>  
>  	rx_check_ret = ice_rx_vec_dev_check(dev);
>  	if (ad->ptp_ena)
> @@ -3720,35 +3720,22 @@ ice_set_rx_function(struct rte_eth_dev *dev)
>  				break;
>  			}
>  		}
> +		rx_simd_width = ice_get_max_simd_bitwidth();
>  

Since this whole block is in #ifdef X86_64, do we need a generic ice
function here? Is it worth just just calling the x86 function directly?

> -		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
> -#ifdef CC_AVX512_SUPPORT
> -			rx_use_avx512 = true;
> -#else
> -		PMD_DRV_LOG(NOTICE,
> -			"AVX512 is not supported in build env");
> -#endif
> -		if (!rx_use_avx512 &&
> -				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
> -				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> -			rx_use_avx2 = true;
>  	} else {
>  		ad->rx_vec_allowed = false;
>  	}
>  
>  	if (ad->rx_vec_allowed) {
>  		if (dev->data->scattered_rx) {
> -			if (rx_use_avx512) {
> +			if (rx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX512_SCATTERED_OFFLOAD;
>  				else
>  					ad->rx_func_type = ICE_RX_AVX512_SCATTERED;
>  #endif
> -			} else if (rx_use_avx2) {
> +			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX2_SCATTERED_OFFLOAD;
>  				else
> @@ -3757,14 +3744,14 @@ ice_set_rx_function(struct rte_eth_dev *dev)
>  				ad->rx_func_type = ICE_RX_SSE_SCATTERED;
>  			}
>  		} else {
> -			if (rx_use_avx512) {
> +			if (rx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX512_OFFLOAD;
>  				else
>  					ad->rx_func_type = ICE_RX_AVX512;
>  #endif
> -			} else if (rx_use_avx2) {
> +			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
>  				if (ad->rx_vec_offload_support)
>  					ad->rx_func_type = ICE_RX_AVX2_OFFLOAD;
>  				else
> @@ -4032,29 +4019,14 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  	int tx_check_ret = -1;
>  
>  	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> -		ad->tx_use_avx2 = false;
> -		ad->tx_use_avx512 = false;
> +		ad->tx_simd_width = RTE_VECT_SIMD_DISABLED;
>  		tx_check_ret = ice_tx_vec_dev_check(dev);
> +		ad->tx_simd_width = ice_get_max_simd_bitwidth();
>  		if (tx_check_ret >= 0 &&
>  		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
>  			ad->tx_vec_allowed = true;
>  
> -			if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
> -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
> -#ifdef CC_AVX512_SUPPORT
> -				ad->tx_use_avx512 = true;
> -#else
> -			PMD_DRV_LOG(NOTICE,
> -				"AVX512 is not supported in build env");
> -#endif
> -			if (!ad->tx_use_avx512 &&
> -				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
> -				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> -				ad->tx_use_avx2 = true;
> -
> -			if (!ad->tx_use_avx2 && !ad->tx_use_avx512 &&
> +			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
>  				tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
>  				ad->tx_vec_allowed = false;
>  
> @@ -4074,7 +4046,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  
>  	if (ad->tx_vec_allowed) {
>  		dev->tx_pkt_prepare = NULL;
> -		if (ad->tx_use_avx512) {
> +		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
>  				PMD_DRV_LOG(NOTICE,
> @@ -4100,9 +4072,9 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  				dev->tx_pkt_prepare = ice_prep_pkts;
>  			} else {
>  				PMD_DRV_LOG(DEBUG, "Using %sVector Tx (port %d).",
> -					    ad->tx_use_avx2 ? "avx2 " : "",
> +					    ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
>  					    dev->data->port_id);
> -				dev->tx_pkt_burst = ad->tx_use_avx2 ?
> +				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
>  						    ice_xmit_pkts_vec_avx2 :
>  						    ice_xmit_pkts_vec;
>  			}
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index 0301d05888..8c3d6c413a 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -261,6 +261,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
>  int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
>  int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
>  int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
> +enum rte_vect_max_simd ice_get_max_simd_bitwidth(void);
>  
>  #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
>  	int i; \
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> index d818b3b728..1545bc3b6e 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> @@ -735,3 +735,9 @@ ice_tx_vec_dev_check(struct rte_eth_dev *dev)
>  {
>  	return ice_tx_vec_dev_check_default(dev);
>  }
> +
> +enum rte_vect_max_simd
> +ice_get_max_simd_bitwidth(void)
> +{
> +	return ci_get_x86_max_simd_bitwidth();
> +}

If we do wrap the x86 bitwidth function in an ice-specific one, we probably
need to provide one for other architectures. However, as I comment above, I
don't think we need to wrap this - though perhaps I'm missing something or
its needed in later patches...

> -- 
> 2.34.1
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E25FCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:45:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B971E40DF5;
	Mon,  5 Oct 2026 18:45:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A212F409FA;
 Mon,  5 Oct 2026 18:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218708; x=1822754708;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bNWSE70M5zLv5T1Lq5P1gG0Uv5FNT+CNacjAQ00W4ok=;
 b=nN1k4eXvbuZ+NqgoDrPbYaccdE3CBwzuIE3ckvaHlqBB/2o56bmcTAAe
 7/LhTkMGaTNT6Y1xTd8R6LEnhrngHOdMrQegUaxheOE6aAVWW7oFGyeJd
 eN/RdRCoStLzeSvcVKuUX6poxEx9OKtWfrMEOA8sF0cQG4Y3NYYwnWZ0+
 OnvKEW9PSOViUhesA0I4vecnkBp3xdyhcli8vdiNpbory/faqMSPjyvyr
 o9UQdKCVsvOhCLBF9Gj1Rq05Jk0sXROnILHtAK9StxoQc01p6cik4Coos
 4aly8UpOId4lPJ9AsmHhnFyA/u+K6g8dpYyYEqsbpjrCHo9NGX2X2aPhZ g==;
X-CSE-ConnectionGUID: Uw3eUcmbST2FlbneHoUwPg==
X-CSE-MsgGUID: +zlA9iR+RQ2pFM9kMOktqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="103268240"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="103268240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:45:07 -0700
X-CSE-ConnectionGUID: 0xXot+H1QV+z2V42DgzeZw==
X-CSE-MsgGUID: K3bu1cy+SqmEbgUyPquKgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276392740"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:45:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 09:45:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 09:45:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 09:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG6Zlo2OdaGyAxakQuQuS5BNPFOP66XMs2ZS804UO6uo1/AH76A+lTYXT/6O4BXgaCdjerhCOg47qMkeeJb9y7a8jf2sM6EJpiYF+ZngDCDHgLs5JT7Dr/mIzdC9lEkVQ7+O3LyHE9LaiMjCDos2a5DgfbS/Yc5b3lf5MWMxZtJuu/sVAupJqkkULQd8XTyfGTo5T4XjE6sxABGFDS433Hlk/btNXk1ASsC1V/g5FIV6d5OsH3ZHf+OmHDu3kYjtaxdNsMqZyhw7s1s2Mvn+X45YvKO+w2YV/QZ4soey+EZH/fYPOLVdOKmg00uo+Rn86aLY5Tr/sDbKe8wb1oVRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPsRQb8ipsjN2OcX4sqsHoWy9Q/GrBPsB3kfoHDYZ20=;
 b=eKpSj16nbbfJLgForcxhdexodjLXGSk76ojcdmsLRda4xnArRWZCRO6+PZSRXsoOsmVZBiOgjWwRTuEFl1ZlvKwEIsamkJjIRfpNbp/8gis6D3YAPH2FV+JVbRQDNjg28ijXB+yBLNeHkGPg0q+nnrbMqgoJVeYWKAeJ6k71as9AKPWZe27AbuspJkhrNoHFwY6JoETckI1gYjCMgcEgrn0IpkoIM6Bp+UjhkNRKfelUpVFr536HRIgZK2K1XHn1G078tgB3H7MW4tH+izl7spphYiE80ZVou+tjwOeb25q1oSPwbqpnrRznH3eGFXYTEg/m2fVJ/or50A4G9WeGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 16:45:03 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 16:45:03 +0000
Date: Mon, 5 Oct 2026 17:44:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: <anatoly.burakov@intel.com>, <vladimir.medvedkin@intel.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix DCB Rx buffer size on X540 and E610
Message-ID: <asPUCRoCQ1FvgmdG@bricha3-mobl1.ger.corp.intel.com>
References: <20260927045943.58541-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260927045943.58541-1-zhtfdev@gmail.com>
X-ClientProxiedBy: DU7P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: d6180f16-cd71-47f2-97e1-08df230000c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 7Mvbk+oU/3GXmTgYgHcDZLhDu2dgGAtf4294/jxMF/SVKrrRiviFA2zF/2IJHeHi0YpTA0W4BcsTRr/w6IFmm84umz40kL2gKrsM4nZLgIy3iqOA85hIVK2mbo7QXxnKs1sbf+VFAinoVfIjMHFqijFK1BibaRcs0iM7FO6vKEnpLzirEhE0KZZncc/H7pFCJkS+we1B+iu1ko0amvY9pfsRySEs73GyNgm9DnM2nQ+sXbmt/fXSMyRI/7YFbwigKBqxXo0agpfQuUcJWJrJXN2Ec5QDih63m2k2mJBoV2i0PZO825dsyFBEXl7Rg5EpiE2ZIqVcRYnsIsknSq4xCYDiobj0t43MHKu7UDWRnq3oPIAEQ3GiaKrqjYFLKJ6fWWM1fb4ZV7960NYRA8a+Rp+lyMW+NO2pS2bRCEmbKZUjqX/PN6HShcGBK/h5OMvp0iql4DBnofUadYIOrnIypPkIGQlJC4Z+V0TDNPcIdiLhLT2YfgUkKQ2RnfUCcRr+uQynpYhXk4Btpt0JA38f+ItLuvycVhgLpvt0f+PdMQIh3KPIuSSCyKMJq4SkiVqy7Vh4NY8qCsrOJvSe5x4D7NXL3d0Yql9d3xehdT61oDOIXEMAGus9rkalptqG0bRQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUC49xr4ET/mZ8fTFHFNC9CiL727VcUS6Ow04+Y+LDLe9jaxMpQXlsJwNFeB?=
 =?us-ascii?Q?7j3yN/43ePebN5r+AlJvuSpLPV+rQoIwqWYBFrdGk9vZBdcgWUkLDzOVxl3b?=
 =?us-ascii?Q?FvftnrfEvTlNjzr5//op5oRM7b+CILV+IUGnQqRtgAoGDseYO2GYWRo7Rq4C?=
 =?us-ascii?Q?sUVUZ3biFVW0VwO0D025C4IDUQ2yM72vwvE+1LLe6+R0F9uZ9myh+IwUZ8hZ?=
 =?us-ascii?Q?bx+4F5tLVedokYxwV+JBmbdq7phC6E2De8dWPND2YaK6HSiTjNyd1H4lPQrZ?=
 =?us-ascii?Q?qsEXFEppezkc34kl4mCF7QCMydGlVWu0Zm1sHupwxlxwsGITodY1s/aLjpPX?=
 =?us-ascii?Q?eGoOdYz6Gg5H7t8nQG/kxFu6pUF9irITyPRXki4SNkEQo6P1zZGGBSWqDwMA?=
 =?us-ascii?Q?rhWu8d1vSoUQugr9HBh21tlbAdRYbR1WLmdvi5ZWbeoCsp/ad6qX6lDdGIpx?=
 =?us-ascii?Q?fHLu4j+dG8FKhKeqP4Dze9EF4CGZsGYun25uUSdPKaH4eyoFlDQ0XiQli926?=
 =?us-ascii?Q?9S95ibSjAijC8NyKxwJJzbnbZ4i2bW12jMo6MiZ4hUnV0QKDTeZjdn4R5kzp?=
 =?us-ascii?Q?DgcPdokiNgmutdKrSViLWd7TpJW8EDZjplNhmaXz2ZyfGB1aCTtNi/aq7rvm?=
 =?us-ascii?Q?+hLjZe4tChTxLG4Cluf4NASraprhbwBvJ56hi6sdqOy0BrI/mkBqVpNf0F0S?=
 =?us-ascii?Q?7nL3ZcKiX6guPQnuKJDpvT7L8eyw3CLtKC79e+GHo8C3Q4OfCeiPeBE2DevS?=
 =?us-ascii?Q?qxMUlAAAqWxH+wmLuHuoCb8uVpJrqJDaf4D5er9YcdFZkWvais5Ni4XwOGMK?=
 =?us-ascii?Q?CYfRPeiwM2ffiJZ7au+Ea/IITnjPwffx4MkqCwF8Tk6+ePdJKkAVhS58imHV?=
 =?us-ascii?Q?fcB7OLeMvdCAdkcJtl4a2yXaozRYU8FAjYtbkqhToLkGwkzB/QSURPgxKbGP?=
 =?us-ascii?Q?tkyx5g7JgArDVPvk83R3fJCri0Jd27JQR8JMUA20eCTPHi48CJAqXHSnv8bf?=
 =?us-ascii?Q?hvytrOpWmcCEyBZSmM8jIP31RP1f8Ca4tqpmK4MWY/T4AFZ04+0Lm/WcpL+J?=
 =?us-ascii?Q?v6mpyBn97Y/TvUuGXODtOYQeR+bnvymIopfjwcYfvmznGjvNrz+r0QAvoKF0?=
 =?us-ascii?Q?wZEdsM/xpfc6CUV2+/srTE1tM3vDJ46eU1kbd00YJm71IlylxSIxsA9iROb5?=
 =?us-ascii?Q?YSe/OIFIQbxxSOGkAMt0e1Cw6v2zipDjg342spsvNRqEEPPceuSRJosTMAOl?=
 =?us-ascii?Q?ZWyapvYbthPvqR0EA/T+sU1U3Ir8NTCZ3uxTnW2Zx0XECxOr2+XmMbXd5CP8?=
 =?us-ascii?Q?/rBF48M2mYNQ6UC4emXVE7zspIP+1VxM1Fzw/xj31ZUN5E0FRp8zkSoijZQt?=
 =?us-ascii?Q?I8hOKMluNw2NiOHZmsPKaAbHoeS3R67spazWYSaP6hqwOSNPb13fyqj13Bei?=
 =?us-ascii?Q?WLSIWVsgKIj4LzNTlajlNyY+wtXCGZlshwHrw2gzoK/MOklVTOXsdlaHFTY2?=
 =?us-ascii?Q?XER2jAqPA4CX3rH4GfvWXl1tgvQnwODhi2jiUs8pLaefzUodyHppYzrIRl1E?=
 =?us-ascii?Q?I2Ja+OODbN0v1WikU8fNPFJhVnv6plncRdJVvaFpY3bXzEPmpfWja1lA9mHd?=
 =?us-ascii?Q?T+4pJMbqOKDCr5m1i0SSGN7BadT30uDva+BWxZRqqEsRlkCxeFkSkzAl+q5Y?=
 =?us-ascii?Q?0ijDOqASukvYJ2GB49WJv8eiTG2qX4ehbJ4ZrszyxHhEdStIoNCo8Z9eb0DO?=
 =?us-ascii?Q?vZG80Vgpf3MOmUzKkTIbcvEmzNtqCgE=3D?=
X-Exchange-RoutingPolicyChecked: YD9LXuzOpR6HAR3383YQM203/OTKr4BTH0a1hiPAu96C/0Ive5Emt9SIdRmGv8m8S5jAKckUWOn+8svNiSrY5mWdlAMUNeauIUUgc3djEXsDaNXNAAwYl8udQFsLY7wyV+6ZLUGySo+26ojCO72laRTp96uBriEOJPg4K5TURP/s/0EB/kPgi6DQ86KXcorjy4Q87gfp9ONaMF8chGS78qbMFN6wADwV9Cy5sWdM3aHyk2eYb+hg4pLAc4zG/KEJ0JQZDQp3w8z1gLt4ImRqBivD7HrVH5fMyavugXLbyaVCzf86ewn211AWs/UpEK9O5kSbL0FZo8qDtpjanWyACA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6180f16-cd71-47f2-97e1-08df230000c1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 16:45:03.3087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smRTfEi80vE4QlC/GZEHQheTlJngpliLgbFo/S5Yv3y4Ee1EVjvL/Nd0/n42E15UXmCjK19Nz2ak4SypqZ7DA0CEMYArb0RHTjUy8UB+GVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
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

On Sun, Sep 27, 2026 at 12:59:43PM +0800, Zhang Tengfei wrote:
> DCB programs RXPBSIZE from a hardcoded total, 384 KB for X550
> and 512 KB for every other MAC. The base driver records 384 KB
> in hw->mac.rx_pb_size for X540, and E610 inherits that through
> the X540 init ops. X540 and E610 reset also write 384 KB.
> 
> Use hw->mac.rx_pb_size for the split, including the PFC
> watermarks derived from it. 82598, 82599 and X550 are unchanged.
> 
> Fixes: b7fcd13c90a3 ("ixgbe: fix X550 DCB")
> Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel. Thanks.
I've also squashed patch [1] into this commit, so that we have your name
correctly reported in .mailmap for this, and that check-git-log script
doesn't complain. Any issues with me doing so, please let me know.

Thanks,
/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20260927035949.36887-1-zhtfdev@gmail.com/

> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index 60222693fe..890289f27f 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -3835,8 +3835,6 @@ ixgbe_rss_configure(struct rte_eth_dev *dev)
>  }
>  
>  #define NUM_VFTA_REGISTERS 128
> -#define NIC_RX_BUFFER_SIZE 0x200
> -#define X550_RX_BUFFER_SIZE 0x180
>  
>  static void
>  ixgbe_vmdq_dcb_configure(struct rte_eth_dev *dev)
> @@ -3863,18 +3861,10 @@ ixgbe_vmdq_dcb_configure(struct rte_eth_dev *dev)
>  
>  	/*
>  	 * RXPBSIZE
> -	 * split rx buffer up into sections, each for 1 traffic class
> +	 * Split the MAC Rx packet buffer equally across traffic classes.
> +	 * hw->mac.rx_pb_size is the total size in KB.
>  	 */
> -	switch (hw->mac.type) {
> -	case ixgbe_mac_X550:
> -	case ixgbe_mac_X550EM_x:
> -	case ixgbe_mac_X550EM_a:
> -		pbsize = (uint16_t)(X550_RX_BUFFER_SIZE / nb_tcs);
> -		break;
> -	default:
> -		pbsize = (uint16_t)(NIC_RX_BUFFER_SIZE / nb_tcs);
> -		break;
> -	}
> +	pbsize = (uint16_t)(hw->mac.rx_pb_size / nb_tcs);
>  	for (i = 0; i < nb_tcs; i++) {
>  		uint32_t rxpbsize = IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(i));
>  
> @@ -4394,16 +4384,7 @@ ixgbe_dcb_hw_configure(struct rte_eth_dev *dev,
>  		}
>  	}
>  
> -	switch (hw->mac.type) {
> -	case ixgbe_mac_X550:
> -	case ixgbe_mac_X550EM_x:
> -	case ixgbe_mac_X550EM_a:
> -		rx_buffer_size = X550_RX_BUFFER_SIZE;
> -		break;
> -	default:
> -		rx_buffer_size = NIC_RX_BUFFER_SIZE;
> -		break;
> -	}
> +	rx_buffer_size = (uint16_t)hw->mac.rx_pb_size;
>  
>  	if (config_dcb_rx) {
>  		/* Set RX buffer size */
> -- 
> 2.53.0
> 

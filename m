Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE5EC982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFB1840262;
	Wed, 23 Sep 2026 09:31:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5B62F40041
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790148700; x=1821684700;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yD1qdmTRbt+O/2Czq8Lru6vO3N8ia8Atdkl3CUqs5Vg=;
 b=aGgfsYfBjGldMOFf2hjcAiFmW6tO2CYLeCpUD6zbs2his2FsR3vRLuTp
 KjctvhY7sVYl5pbcne8LBj0y7G/XRCCfzBrjx/iGK8XP0IDjNIQIqsEdd
 7XJVHpi5lony8WLqGCvLVk88AvscxY8vOUQ2qn5H6oPVAi2Xzf1rMFMep
 EQBZhkoxl91uvZ8nBksZkR0Ywws7tgjdv6HwO8OfxIjk0XPIbiofQULT3
 dAGchfB83yVeywQ1g/Ro8UdYfaNllxmeMA5Vg6YXPk3exk7B8zMOUp7PH
 7CASm3OCfZn+pZskgMchF3ZmDpzUuLRunm6fsLXe15DpCdAi7YIOGoeiJ w==;
X-CSE-ConnectionGUID: GbaSLpNQTtmBzAIDB3lpGw==
X-CSE-MsgGUID: YMdTV5aMRV6NGVcMrIrZSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78369896"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="78369896"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:31:39 -0700
X-CSE-ConnectionGUID: jhofrokuQZKvEdCZrnh7Xw==
X-CSE-MsgGUID: BLuDHJFgTgyim7SWj3y1iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4562296"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:31:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:31:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 00:31:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJTV2FbNgsPKQM74cq3PNszYXdR7JF+C5RFf9n1obrMcLfhuL52GgstdLef7wzyxEt7PoCE2UNJCymUV+HYLGiiNNRDcji3ucxi4ZpKdlD8g2pVMjOspPbVDfpQmk6gAX4mQGrSXWur/OrWMAF6hyVZOz4ho46DGpUQvDXRS+BLsrNJ8QsMhjkgqgyvCjBjCjJacC8xD/LxkmRxORo3uVgQeDonIBFmbP+vqi6c2WXJqIkMpPhguWwJsD6PqXV/cgP+qyS5YEoTaALvailsI7wmGa5dj1AbIYb+4wCaOabVXkDUWV1MTgKjtxNKS89Lv8hKVT2fbc1cdslKz+GfOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/hGqXob4M0wm9pLG0Adih+KKBnA0WWqaqOmb+433eI=;
 b=toQqyHQ3AV2yX++VKyqtGJ3a4fTKcPxXHwDEFgTPinFlmKnP7KFBh70Ur5cgil0SSaBJfVYdw4g31/qdueRREw7fySPOdGN7cEEX4tqz+tG4M4CclwRxo42Tlly2Mf3kpDraEB27DGW99JFRScwqmaedVXXY1KB8D1a53N01+9KlyIDickbK6822d7N+u++mLli9mIViI4Qmo+JBMdqlTu269stEWlE/7cvjHoCVrn2zwM80B8XYcwiMaBaiTMTvtRtGt4apTeLgmlmh0q/NgJ/9YDaTnKQFSwIPmAmJiexelQNKvymO4fI2xZAGRKFQthsX+nbm9FsTs9MjMBG+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 07:31:35 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 07:31:35 +0000
Date: Wed, 23 Sep 2026 08:31:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH v3 04/16] net/ice: use common division round up macro
Message-ID: <arOAUuuN4KyBE1pZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-5-joshwash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923010742.2468145-5-joshwash@google.com>
X-ClientProxiedBy: DUZPR01CA0312.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: c428f13c-408c-4d87-4f01-08df1944b259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: enHZbRfkEC2I9gceUGd4hmgqU2y6fkyGox5h0UQXk2gBaOklB1wxdvVgd5gCK4qa1g/v2VROP63WfWTPT1PxkKNwZRFjmkxqSz9LfbolT11GQnJ/zaELjGRtc06eRA1GMULUla4uxSkpBc3V9+JQrCPlurXRQMXIHNxpmx9ct+0O5D9A20+93eIBHlLRb+Nk+ifT1/BGd+R6toe7ben4COoFDPiLnt0HEJN1LYWe8IlEQJ4cSP1AWTAh+y78C2RpB8geJaVFXBkSvSy/+S/y/rxwA9Erfj4W2dhKlQ+wmpmkx6elM01qDg1Ktn4pdw4DbPREkmgFk+vypk4FR/xcOjxgi6f10mn+mTZk8Jc8j5Hvcj4TksWLvtTwtAtSqFZFMxlDbAUunZIwuevVUf6OO3fyuyh036D8apYjm1jxyZZnGK0miqUYgPuFrhfBOQ/WlzT1ySKWEuAjsATWGavxuULdY0PqoED1KmFLSjOecsvpdVT94cGc0SHrRhw2quorlc34QSEwGcwNxTIMwKJrklxgRsRf6i1SgiQXoWUF/GaCIBX9afYhYxr2Pvo9L0bOx4/lmkiHe0ZfQ3kezVG4JfHpm4pxcnLfn7XEAMcoB4G9gvyECyP1VplJAvaON+2CG834aDJsspl0PJa6B6ZrKY/SFEtYEefm6fU2S6GDY2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rsqCNtoFr65EF/79Egw3Ms+tXK681FNcbUV4YO+DbnsSjv2BazRfit2J8WzF?=
 =?us-ascii?Q?oE/1CmbJRks5zTJGWzIrDosqlfQEv2swR2e9L/7Qb1Yd36hfK853wxRlS85O?=
 =?us-ascii?Q?0vSH2LkQyBL1j3HytLc09AQyZPVgGktCkSP93ahhzA+NlARIV8Cey0C2ebB8?=
 =?us-ascii?Q?ZaW50yO77hNRyyRM+Oe7+6/nuf6eFZ8FNgJsJMaaMfs2XhyefbRIbdXo1UKr?=
 =?us-ascii?Q?SrPJlg0+Fj3N5CMN4yPKayhHN5uXMPbeVI8InRilPKMt8DkJMzfJVrYcQPAC?=
 =?us-ascii?Q?GSrjeVijJIoe7W6EBTbquT2BQiadT3sjVpKVW7KUYycubfbpptzoTDqQipZW?=
 =?us-ascii?Q?sA5mOI91XaH8AgXes1UWASCE5RC04e6Tdm3kr99s5zz4nNRzkmxKbA0Ua2/z?=
 =?us-ascii?Q?SkzfEmPkEFEhH7nV1suAuEvToSrzY3W/H2F0EPQOaLbRmRQuYZZ3VQs30qVQ?=
 =?us-ascii?Q?Lk73MP9qAx2mKFX5VEdBcXv40hhQQXqYRB9wxWyc0Dvb9Pfrzlx3CUGJ1rSh?=
 =?us-ascii?Q?IkaRFuHkGr6MWodx9i59j4nN0hkiyqe8uaDt96AOGYYyCjMEyVZizCW3vZtC?=
 =?us-ascii?Q?KvNF/76txrX9vKIen5fq7tzshJAamZFPIZkxcY94ZUTO4l3XEXUbmk3lFJAK?=
 =?us-ascii?Q?GDhqnUedSGEZF4tArivatcaYvguGjIIqpAhxZEO6R2oE9AK5jtZ3ALba5vQ0?=
 =?us-ascii?Q?IkunAUXGPFy4zCwqHlyHzPTz7YfRWHub++CsbTyd+PQssMCkaZxd0opzDWqV?=
 =?us-ascii?Q?OXtHGSJIqSTQXNSFC8MTNrYcmn8JuuMMwGJh7zJOhQx2rMBBYoIMxvsFXIbP?=
 =?us-ascii?Q?Q0ycBn4M5siz78dm77xGb1XBw7wLqs7A4djP4zwdXUtiURA3osxI5ERVfq9r?=
 =?us-ascii?Q?e/QD15fzliky/cK0SG+j/ooLcDRX+JxoX+RyH8apHGCEcMNxuExMe4MyiS+3?=
 =?us-ascii?Q?pqsR9eReiJ2OL4EXl0xCgWD9T37jsKM5M83JpaIwhGOeK/7eRIxnL1ZuoUWC?=
 =?us-ascii?Q?/1BDQ8O9ySwcAESLqQEV3T4/gaU3JNYSTMNabKC7epJ2RTu1oGfzl68pGaHK?=
 =?us-ascii?Q?Gs1dg0M8nA5YS/ftA3duy4JrFT26mCjXKZE4Sv5Yw9UBUsOZXq7txn7vrhwa?=
 =?us-ascii?Q?hgpy/IFx+kJpwNApsrsTnQg3ZNJXf517npxFLJw/mbkMAFgQIWXBfC1ytZQL?=
 =?us-ascii?Q?4O8OURH9B2rZdCYViHwVir38MELFBmDBvXZwxidkxFEZViFPicbuwfkO/BTr?=
 =?us-ascii?Q?bMW0u9mdeO9SuuDC7UTtxYSnhyvab8ADpLsgsvgv5IuICdZzJrrTDXEvbeeB?=
 =?us-ascii?Q?/LNOyGZZ4lU+FZs8wF/KPdUWAf1bAxqcI6zcZnOYz/DwYolRFQD3RzpDCND0?=
 =?us-ascii?Q?GZkFasJ2spVUml6bliM3s9qC/FVj6iqdWdT7sPd3Fa1XT0VTJRBfcS76L8eC?=
 =?us-ascii?Q?68kkR8WXed+4z/mOH9WbdFpNiE9OtyG7Gphps4USn47Vo0JtvTWRl5wx7MsO?=
 =?us-ascii?Q?qAhFlhCZ6S3hjA5DeHCnBMOMDDCyl+sG4HRxukPAwn2fz3GkoHtlDdK9C2Sh?=
 =?us-ascii?Q?mvan1fYy3OL5ALlN93pUAYHg4lTo/bk7BZ5dxrA2ZUpRUwlCBIVIFFbi35ym?=
 =?us-ascii?Q?eUND4ccPgTAnmgT3uhO+R2mJmLOQCOs9oMAGy/UVVIA8354aB3eLeoUoCih9?=
 =?us-ascii?Q?pgDluesg3zvd3wWmUnI6JWbtTluQrSY6sR2VdZGudp9iOpQcdQKoOIHg3Bnn?=
 =?us-ascii?Q?oQwJWrVXGK984esQ+7aZaSV3mB5YK70=3D?=
X-Exchange-RoutingPolicyChecked: OkCJulSmhT9AnhKgBODHtMI5Zx5eNoY7m+goiPGeCDf2qkpf4kFnAxHJBpiDaKuAREUHMmnej0sZSZCwUs09/geCei5jQNmczLy4NuR3q9TSjU/K6gnV4DUVFizHdP8ahuANrgdh4tRkc8MVPdMWwj9wYW9wj1c1m/xz7/RcFb6nq9fwcIoFB1Y2hmxIIq5VmiadbAa3x6/Pm89VGdCEyy61i+CgqDfUt9+O1o71IAQ2KElHplkCm877al+MzSbM1bFX5/8YGRUJceA2noseH2EWlYZOZhrqVgrY4kSj/giOTaHI8AkND0WNLBSsbbJT/0nuq+AC8k05vLirxd+eEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c428f13c-408c-4d87-4f01-08df1944b259
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:31:35.2770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30xL/Vt/unFe/AQhfTQPCKa24xfbInwApvyzExiRt2Hmz2THfpWCTiYA/jMcr3XX2VbQ7P4fQboLYypl7hoDAPCUiS053hXOu1Jqe4d12+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
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

On Tue, Sep 22, 2026 at 06:07:27PM -0700, Joshua Washington wrote:
> The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  drivers/net/intel/ice/base/ice_osdep.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
> index 5d92cf5aa4..3ef52eae6d 100644
> --- a/drivers/net/intel/ice/base/ice_osdep.h
> +++ b/drivers/net/intel/ice/base/ice_osdep.h
> @@ -311,13 +311,12 @@ ice_hweight32(u32 num)
>  	return bits;
>  }
>  
> -#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>  #define DELAY(x) rte_delay_us(x)
>  #define ice_usec_delay(x, y) rte_delay_us(x)
>  #define ice_msec_delay(x, y) rte_delay_us(1000 * (x))
>  #define udelay(x) DELAY(x)
>  #define msleep(x) DELAY(1000 * (x))
> -#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
> +#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
>  
>  struct ice_list_entry {
>  	LIST_ENTRY(ice_list_entry) next;
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC6C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 14:14:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6896C402B3;
	Thu,  7 Aug 2025 16:14:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B46A540270;
 Thu,  7 Aug 2025 16:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754576047; x=1786112047;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VVSd69gVMZwta+5L5fMlBEaSFEI54abeb8BThmYIuUQ=;
 b=bn43t5DFVqQil3TAS9LfszVzu/v4uah6O9zHnctWrMBAH4aWSU/QwtVc
 0EEW4QN3/fDLxOQ/1oJ6VfvAkLZsi8JqOoNh8PVAsl4vvmq3q7VPQ/CeE
 VpmM1eBHb97tcMufDIkSt0mza1fpVUyRPFgRjuo4QZPI3uswoqNmLoEFb
 gegO+kvkVOj/uAOE6M7gibTvVYSlwgYeFDF1ZkVGYB89NMj06DA5m75a1
 /WHXN6KE4Skip/gpSzliSXh3AQjtTyZwMGVcd3a66y2a7UAViZRXKKqBY
 0SYIFTRDFSmgcyMjrnuyf3Xsqy7XkiLUADk95Lmt617+LcmWnaj46msLK g==;
X-CSE-ConnectionGUID: EeYPbLJRTxCsa8nfs4XDhg==
X-CSE-MsgGUID: OWh37b5sRrm48+zvTqdheg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44504742"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="44504742"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 07:14:06 -0700
X-CSE-ConnectionGUID: uvzqV1HgTTGiGqhfG48r4Q==
X-CSE-MsgGUID: qzV2or9FTMuq0V6TF9USXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="169535177"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 07:14:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 07:14:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 07:14:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.58)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 07:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9FAGQjR6LXCNVTSljf8N3dcesDALqvhzF+DsS91QZk6hu0xQqiuNMYCDXpC22rqLVxHAsj04iVo2+XKcbO/htidWLKphTJ8YF4R2g3015zyNsT762tH4qVjtqobk9r/LinM3uKK4mhRE89mc9OEi4ye7fTkE1SQjWGnBRzlMU8NnS+m63GhxTzyAdce+l67yc5GxMpu4xyX37rvSiuu6Zh/TQ1Fvg6mWNBgdnUrJ++KbhJhAefnTBHcr0nBaHlv1w+hGSSKTBvwtcsgrI9Q+UhyWR5nGJV1AescpQ5c6T1NUBmxa1uyVu3dSwH3dUma9TP9e5hgZGkoULJOACJwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tMpObFu9qibjx+3ArmohzNMoVOrZPiveeSQQg7qwwY=;
 b=l6JhpHTV3aoufHrtcik3b3JunDHPz/CLNQI2uzVLG+BmooQ+adMgxUQQ8dpIxf56RUECS631GNP1d6gGY61F1THRXeNhqwNAIzA7OCfc8TEq0eXnoR8PgXCSSP0+1DM7OE90QN9JINHXPargIdOQ3JfvWnawpjI/WfHXjjuMqVxCGfKxcHR45vgYsqO4SUcgsB4w8VagqMkM55tnrb6KJnJPtpmcuWsQ8SHuqUNUE/1yf3BwgIzYgS+48Cd81CWiG9E5uRfdrYvV6A6EwOiqitNph6QCORTp0OCqwNSpfGB2shLYy9eB9tElyDCoSnt4TwOMRbuWQS4bOfNe3jEwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6998.namprd11.prod.outlook.com (2603:10b6:510:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 14:14:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 14:14:02 +0000
Date: Thu, 7 Aug 2025 15:13:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix Rx vector offload flags
Message-ID: <aJS0pXHRmvVe6-ea@bricha3-mobl1.ger.corp.intel.com>
References: <20250807110843.54385-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1D78C76357CD3EC36F7AA8E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1D78C76357CD3EC36F7AA8E2CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB6PR0301CA0069.eurprd03.prod.outlook.com
 (2603:10a6:6:30::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b36838-dfb7-4342-36ed-08ddd5bca8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hdj2j+G3xMBjzbyeoEM5Aq7zlXLWHPzgAl9ZL1lHnatpEkI50QyiUeHQ8J+I?=
 =?us-ascii?Q?Eerqyh+SlG68xj9ghu3PCEWL2VZUzqtVerSGxER2/pFWN+8Unc+kSMBpgsdk?=
 =?us-ascii?Q?Wv6qGkSosn1mccVr+A+U5DVy0e3G9fInU4MnOwPzDNmkZT3Ql1Cbrp+S5SMf?=
 =?us-ascii?Q?FG+9CjpVjG13tKv6aqgwkbnO4uba3OStzoMwbAJ0oT4JYTpsjiTaFAlRIXCS?=
 =?us-ascii?Q?H/dJtPdoydl7sxuSJ3nAMWBgWaiQFuJJpka6+vWdtAMEbz2PNGU3pq+cYYLz?=
 =?us-ascii?Q?e+4NnQD3ErUs77ww58XS0ap1c3XhouemYFAqSksTutmX5+GPok16dNSTlNBh?=
 =?us-ascii?Q?jKX+bc3f7dCxlOt1rmpOrnpu6N35TahFQMf5PPwrBQQY/pLR+mPryfxN+hZm?=
 =?us-ascii?Q?E6ehATIIMilyvLt069jcm5SdfyhxgDT6WuC12RVnGfFpeK8Jmm40VZgQFWuk?=
 =?us-ascii?Q?xfZzBzXe5OIA+sPQ/Ko9rqudm8t36/JnY77ENz6wsVOaEKbLYvAZobTjxQT6?=
 =?us-ascii?Q?hiO+Rs8IRc14TKcMic7Jhgl4xNBXYnkTjANqtco9tRVyZrKt59xNN1RK0c1h?=
 =?us-ascii?Q?gwydI/d4+Ww5QhNTjkSoWdLqaWCFkNJ63uocKD+DyuqSwg2XXaVuTldVcWn6?=
 =?us-ascii?Q?yra4krSoJQ+xF+p80Co4hWb5ELk+HDGUYeUnD9g2xol4Zh8ebZGDWjmfpi3j?=
 =?us-ascii?Q?Cf10NJFn350DjnEEfHON6o7dSVp3dMsQD4sz8iyQfKIZ1hX/8EguOzLjf/ol?=
 =?us-ascii?Q?LYDJTYu/ndYn5tTqlExRm9zH/pVCC1u7bFu8oZ7aaLvTrMnvg2dTZGA6bYf8?=
 =?us-ascii?Q?yOd8Jzdez4kHZJWDaaujTPIwXgr50nnETCLNLS+HqTNq+Y/G4ccbkNFzG5iy?=
 =?us-ascii?Q?JNSPcwJzPJMyXkWgfZkj4LvHgQ92EtMmqU11inBpcJS6Ugo5h6N7Co4ogK9p?=
 =?us-ascii?Q?7/4x9lbdXpVfaw18mwdx36jle3YLVD0oyiGf5P55wdqSON5PfjRYizRf9qxp?=
 =?us-ascii?Q?sRDkJKFxqTI1ArHgpscxxs+MyFtlcAg4mgaoSWQITwxif9oDxK0h9AgTgSdZ?=
 =?us-ascii?Q?F4utXRPHcbMO3PWrEC91TEza1ftmsfXIcqASQNh2H+rbN4nke9Mm5FMpT65e?=
 =?us-ascii?Q?vyStTUmyyTaCg23r8Ir3Qy9UMluse7Mkkovjs1FO42E5CzuS2vWmxcKLHcQ4?=
 =?us-ascii?Q?uuDGZ5KaRp4lhuuHo0/boiOMW0AJQFfkF2D4V/H9naGnRlezw+CdQv1OhYcC?=
 =?us-ascii?Q?YmGsyQNjC0MfVXUI1B9F353Gi5v6sJdj+jFBydn4eC2q8Ogjll6/Riqw6rL6?=
 =?us-ascii?Q?oEgvAR8wxtPZuxzhLTE0w3gqYB2bmYwjwf+GwM1FJXXobzyXYHiE2wmUKhJv?=
 =?us-ascii?Q?IK0JGUQFWmhIiWAF01eZ1JmOo7yMQo+LH2X8szkZkGbus2EtpUrQH8lPJPfG?=
 =?us-ascii?Q?ePfikkTkxMs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7RVFo62cp5Om6mlsE42NWomeaIVNpR5q3Vl0H8Q3q8me4pdZwusbwELmdWKh?=
 =?us-ascii?Q?vGn7hqeM62w84AIf4rwRS8u9FBCEcU+myrvf6Qdu3I57kF0omeT9rxiWrg6O?=
 =?us-ascii?Q?jShomVNSF/LnayfDVp92QU/zl8a4hh5fJWbfJhF7OzyVfB1lthpaQV6BOj4d?=
 =?us-ascii?Q?+ngGvE6WKBiSAhixoewutmYI3Po14ASXj0swixIPo/t9PudROg4PcmtQVPpS?=
 =?us-ascii?Q?RvHyhP83ONckiaQRT3XNSLsmfSVUDAterAMcRu2UqFB8QYxjS8BBEvRzGpZS?=
 =?us-ascii?Q?AYcUIVm8vvxzoJoYgO3NVULOhbh89LMCyH6BTnG1TAMYL8hfjsahrulSm+zV?=
 =?us-ascii?Q?0yhQDupFOyRE8Q8YF4zkmHUSERfBwbvpEGRXsjk3RNgAmCmV9R1mrWOrVu/O?=
 =?us-ascii?Q?bx4MBIn4YAkjw/4dl8EI7zS5o/5KrD2MlerKag9pSlPWwT/r4AAYii1eT0g0?=
 =?us-ascii?Q?kT8REKUqMRPaI7gVW4bMPsLekbm5ZFuEesHyvu2BELQ/bNL3/RFlj/U6q6Ev?=
 =?us-ascii?Q?zDOeXuezjMYWmYbCbyqRO/q19wr91zzr+XJ1Vzsw1zcG7aN3iFfS7FCwCrXO?=
 =?us-ascii?Q?WCjeWvwRJxp0VzIaorX2pWEs9qIuO6bJuGkmJFeUtwrjnM5olYoSww15Xl6p?=
 =?us-ascii?Q?bLvrs/PiwqXN5eDHkaNV+SzOQLaiBovngMGx5KvMrVzjK82bXqi7snHkOfCn?=
 =?us-ascii?Q?72ydHkrL0Y8bA+tq0oPubo4ry1W+KZuGBMaIC/yFEGR9O2XRvPjJS9150ZsQ?=
 =?us-ascii?Q?VVe7VJP49yGPlcuZHiu2EwaD6/bWOI6XrzvJmUA4F4Q/VT+fB8vrXxi6RsNG?=
 =?us-ascii?Q?ik6OJyQbUZYbgQZy57k+rz2ljxkLlxmQY+r2skH1A5jaEcLm0ZMnbtpXz5s4?=
 =?us-ascii?Q?HALyRXCIjuJk5236fe16+9ae/+p2SYsHqFIapP+tfevFpIYM8F1BwIEr19G6?=
 =?us-ascii?Q?bSZ31iHaJ2znB/Dc8umDZNJHP6rD+XfgPxzYpevmmWrbcBZFQRBzC32yILSi?=
 =?us-ascii?Q?yK6KbkjWSxGm4OClCTH8nOAaJZMA+vyEFSF97q0bYpw039Frlta9JBiggaIU?=
 =?us-ascii?Q?rjgB50quJ+odsPPqITtOlE1mNTLhTwOUhP2EWx0WAh8RGHADgoFQDgRvg+5a?=
 =?us-ascii?Q?tkjZrE3RFYJEpVrSikTKnCZp95AfzfXVWNhmyPPlbRtTQx+NgV8Eks59Qali?=
 =?us-ascii?Q?kSLatq3RSDB2TKG3hHKjLtQEZhdqU3/osxmvP/d4aprJPDTj7wTUCZjM2bxi?=
 =?us-ascii?Q?/W3IP7gQnh74eBiHdqecTCdpTPIr6c0Ym6UoEMAAOcfjWojGCFKsY29f79EY?=
 =?us-ascii?Q?bcU8qLTbIlvN0wPpAd6DxbQnZvf55YMiNcjW7KwOz95gchN54EXbpb48tYBU?=
 =?us-ascii?Q?3/pZGhVBi0AQ0Y+0dNQIXQiSEZDPfIAtZyhZmPqbcJrFVJjJHbCsyqIQcAQJ?=
 =?us-ascii?Q?gh4mvKrvCbR/8sofMqonommdtqsVJR/SPeS/a7WqRcNVE4UY3qXVZka9GzvJ?=
 =?us-ascii?Q?thPskvEMlPMrMyEi84KxFt+XjJi5Q5TV4iMVByqC+5/QTF0Q2gUF+h0xm6Um?=
 =?us-ascii?Q?8/H0+wZbNBOBXFxSGqXkiyrmoy7nAha4BfV3hXGUGy5ZOXjgL3+zgFJxgjVk?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b36838-dfb7-4342-36ed-08ddd5bca8f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:14:02.3808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq/X+UkpMqudYQAUBbo+eY/2wNqUIMVGYv6VjlmCbvWL18SMNwvYuw+U/JaexYrNXWn8rngYaxINOl831ARo96XylmC9s8ZILILBUnp/i3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6998
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

On Thu, Aug 07, 2025 at 01:42:54PM +0100, Loftus, Ciara wrote:
> > 
> > The vector PMD datapaths for ice do not support QinQ, so we need to
> > update the vector offload flags to not use the general RX_OFFLOAD_VLAN
> > flag (which sets all vlan-related options) and replace it with the
> > individually supported VLAN options.
> > 
> > Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_rxtx_vec_common.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> > b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> > index 9430a99ba5..e41fd8fc7c 100644
> > --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> > +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> > @@ -72,7 +72,8 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue
> > *rxq)
> >  #define ICE_RX_VECTOR_OFFLOAD (				\
> >  		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
> >  		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
> > -		RTE_ETH_RX_OFFLOAD_VLAN |			\
> > +		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
> > +		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
> >  		RTE_ETH_RX_OFFLOAD_RSS_HASH)
> > 
> >  #define ICE_VECTOR_PATH		0
> > --
> > 2.48.1
> 
> LGTM.
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 

Applied to dpdk-next-net-intel.

/Bruce

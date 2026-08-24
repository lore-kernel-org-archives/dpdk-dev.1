Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C02C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 14:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71B3240270;
	Mon, 24 Aug 2026 16:57:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 02E37400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 16:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787583456; x=1819119456;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=66cp0zxIkLegqfkBz4gcikE/Oooy3gpObcqkT+Yj6A0=;
 b=XCCIaq/ZApXJs8WLiW+R5QGHz1w95NoAR1iKPROu4U7hhi/W6qxQIaJ4
 4Th9fBfNhpIGN/EpbhfEr8De3xZ+KNGxlvJEwabJYIwojFdf14asXHSq8
 lETVbrFgoLdYmQ/QqH9fRoay0V/a/ofONUBoHlJradcabtJckM3TFwrdh
 9taNO9thdQcmBC/1cXdD+Y8+UBelBBSslA+ldg3rqTF6SE3eDnFy+hFxG
 mL/1rhaN32ym2ze1o+e+ALOHvsVRlgn011D3bbNHrolBeRU+gpDmd2wwK
 Uh5HBLrkC1Wqr+L6kHboQgTze7XUeEJLRpXobgkLqps58sNEpgoz5iF5F A==;
X-CSE-ConnectionGUID: DKA54MJnTDK2famXUJlVUQ==
X-CSE-MsgGUID: wgTM1VpYS/yHCYD50ByM0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="105413902"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="105413902"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 07:57:35 -0700
X-CSE-ConnectionGUID: xuW37UoKQSONVYiSK5e6uA==
X-CSE-MsgGUID: SeUqXG/+S3WnM6sljfhzqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="265711457"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 07:57:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 07:57:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 07:57:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 07:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWlTGdxQXxUV+yntiXSWQmrz6W0byOanfR4IhXdt+vaCfFK2tqv5cIRQVcRJOP01Py5OKg8kIth13YF8Payf0IlatyI9iGEYMwyTKlGVUYF6qVqxNj4OGudn/MIh9J14uXTIs0Gb/QBm6aeLG3gt1x6tByIUogM0ZV4Yy641KXk/3S+IQx+UrjpF7Oztux0MNN+EabBqxIIdz81kUqGmqKJ6YRS+LOYzCAnnk1Irl5XI37KaSFQ+F/bn8++JKkWMLGtFYpiiWd7R9K3n1j2IcSfanPa0rd9ffRjwI26qYPXRzu9t6s01REcOQa9qiJ40mvIKj7rxEbrcFUt1BFk9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffyq4s9pNdHiG/WRyO12hrgkOvyYDtcz+v1C4g5xZmE=;
 b=Riqean4dLKiSkAR5BhBzzsBPNwvirPzFZJfaJ7jd47oAPX1kdolU8hMwEuacNxJUG1xkJMdEqL5a+uviU64GuVHe6Z10xfe8PbHwq3yFEh4jE4Tbldx+jpzQJSF1dGT68COi/ekM6oZGiV8xUn7f5EQ6ApZMs36S4w96lPDgD2awwbox0VvjQRRAPLJJiz5ELBb0hqvjUASiFPgMDTGXLlfwz4RYiocJGhWlEfS+TNf4NZlhAsJjSZkx/hO2SfUd4+cnbixLOaBfrQ1WqWHJeaNSMcBWQwBADEbY+rkBJ48aJmbQ85LeRggMxQZQRF+TJfA1gYgR96mn4EWePEXyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH3PR11MB352616.namprd11.prod.outlook.com (2603:10b6:610:365::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:57:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:57:25 +0000
Date: Mon, 24 Aug 2026 15:57:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>,
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH 2/4] net/ice: add vector tunnel context encoding
Message-ID: <aoxb0VAWa5U6zlCE@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787566677.git.anurag.mandal@intel.com>
 <1544dfcdca6e4accac523326948cbe2b4571e76b.1787566677.git.anurag.mandal@intel.com>
 <CAJFAV8z+ce0FBGQ5LvecKY__W_B8PWBoh2MJWcYZHVtcyDRSmQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8z+ce0FBGQ5LvecKY__W_B8PWBoh2MJWcYZHVtcyDRSmQ@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH3PR11MB352616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0f38cb-7843-42bf-66f1-08df01f00253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 0KRpzSgAQW9ohnKAm969Jk7A2Ys8LOLqhJPGdoFlZSHyTmx2+b48jHiLSyDPAFq71ulu614yCtSX5pXZ+TBWzEnMfGGlOYW/+qJ1CLRN4bmclaHiXQ6iYEY0V75Lh1QkW1Y6DePrhXYFyASRQ40/NjNlqOX6ayaZM97Ux7OG0xJdA05xcXHFZSKEQQfNvRzqscRQ7PfVIexs0QTwbPs1VYKt6tOYaEtD+fPVNumlzfIMcOCXUisvqXezEcKr4Dxqw5hAstM2jPZV8PiE0BTbfE8UPQdrT1287rPQQGTbJE524ZPX1eayfzf+mBziLyZxTsFlowDNeJ1PzsmbWJ2ThaydGNqJNItcuZv2KU62l/ss0ied87n/IByrKSUY0Tk6LxkOUL6ZHMJpjEv4qz2Qwo00rCgPpD0yzCp+56n4GKxTBHw+N2HmWQG14HCulYvuUue2uzOoSOLyuDCGczDtIahhpvqqzyuI4YwodA7dyEY+LDUTCczEEyzd4sJhR9b9yHRkcbx3n8YjNKdHLUebXKqjJCosmXoRsw3EbMnYfmAmgPlAPFCWiq/fToWpm9nkiICsv27yyKIlyvuX1qUsmJqLyTQnatPxHEMQ7ysR2+yaXgn4rql6sTa3FVwhkpcT9Qj+HMSR5sxyzL2JA70qTxCrGfWwcsOIrVRViBv3W3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKO871hUR344LuGZW/v7b+1yUYKxFcFvFN572a3DMKR72uxc4MIKY8VgfawU?=
 =?us-ascii?Q?InRhYhYmSoTcsOifAshL/LKWovsUSMfUG6GQ7SRJEDoL4ny91jOA+7PdY68K?=
 =?us-ascii?Q?ejKaTXYfFfQFyxEMnIGQbqo5fk+SKDcDG89Ne9ozsruvtdk9oGAUi88juCMd?=
 =?us-ascii?Q?n4VqXd035o+CPIfV7Ui6K9JL+ypOuzkYhNoUH/asmvemcqiZZOleA1Xb28iX?=
 =?us-ascii?Q?ZINFrC9LoaI3ai5dd2dm5UZBIBcBtigrh9kuiwX8JT6zEORzuu0/+aFwtina?=
 =?us-ascii?Q?ddJ+uxGCOjMtqFV9kW1MiiREBQZkzVg4qTyGDhgN5/6bjm6+gClhnunMZF6i?=
 =?us-ascii?Q?ix7aIUx5ZkGXJlwHej6DRrJ6L+vsx4hiU772q4AT3MNKGJr0NoVF2tjp/h+n?=
 =?us-ascii?Q?pU/rcHJGT2/pY9Pk+QxMeVyoWMofR8JPf2OjjpuOKanjrjZWv4s+oeZ9grbi?=
 =?us-ascii?Q?SD2JTce+VxUd+RDuhcy89K+EQXrg4hVpTufNaOzy2vVT6Vczp97V5to/+0Hc?=
 =?us-ascii?Q?ksGxE5+pcWdVnfP1RRgqoqzoSeHwohPi2rv5HxGcSB/3ivnwSjymHSbGRF5C?=
 =?us-ascii?Q?C7hq2p1SjJY2TVoH/fkjsvSuxgFiLVlu4riSJz+BTPfC5dughx09ap31SwCP?=
 =?us-ascii?Q?0Kv9iFAFT26RYNHVwf0CvSMm3wK3RPtGG+hqdjmlLNzhv04sJ0OH0Mnh6MXi?=
 =?us-ascii?Q?Vb4S4w059AtfULyMR1Me0zDUAYP7YbcsETWrowBiQR0l2TwxXSqBDsXwWvXe?=
 =?us-ascii?Q?4pHk1tsgC8BtP3KaSVryS9NyHRRI7irXGFizUG03/OvM8Q6PxUdhwItTszbw?=
 =?us-ascii?Q?ktlEpPsCGhdVOh3QMXCBuOPVnVRdS052oRotKLhE9G595Rc8p1BXpuX8stt0?=
 =?us-ascii?Q?c5Tv4wcvGStnMFtHLyCPK+8ewrQhL+2t2u9+ZVQ4g0Zs+Nlga9jQEZoYVK9v?=
 =?us-ascii?Q?cKk7yIaOI8+SdoZm2AP4bq9szwW8hFVaowYdzSjrQhsYtz2axTTh5SectQg+?=
 =?us-ascii?Q?/iNW6AnONyJ8pyRytdwq6xQsRq4KdLa19U7aAFfoSAP7DOdmyS7eMuZUI6wP?=
 =?us-ascii?Q?P1KH4LZDAcV7ohSSXr/bcyQRZ/U9x93gsUDm4qXU191Np/644+9VSdZeGSuc?=
 =?us-ascii?Q?Yr99JhKxHv4fjYysmXJUpRMUEAGjBe06ASvkVGaXHkKEGfk0RsThNwyNjKzu?=
 =?us-ascii?Q?3+cGOZrtIHa1LteEUOFc3NdG7Ya9FscVWQUwgp5NLI/+hVZNM4J23mU5SQee?=
 =?us-ascii?Q?vj/jyd4FNjROlXxRXi4+6H0tESj3bpeunWTPTtEUof/mlTR5zRqEVerf7Yyz?=
 =?us-ascii?Q?VyILo+vEmHCsQx5S91Yav1luRMp8pViXkh0s6W6yEtJ3ISqL/Ys/NsAfUiFF?=
 =?us-ascii?Q?cke98ygfrIRaTmBT1VJoNpXUjRHnv40PnMogpHEMr4xdyd5su7Witi5DAdvh?=
 =?us-ascii?Q?3sBID4JPTY+WS7TAAmYz+kpdXW4KKUcOPfunIQqJ6mXIQBzchQ/Yuhjyqe/t?=
 =?us-ascii?Q?PSmY+iyk8UX5+NRMqbkDwXf+wapddkxGNvDoXoW9Ghg8Unx7Pua5bHndXeXg?=
 =?us-ascii?Q?kpoPR35WkeBy4yqR+ziiO8kIwne4I6f1Mm8vssY1qhgHodnPCVp/zZxP7gzT?=
 =?us-ascii?Q?KLxAHGT64FLPSVDzU8IhqstUjAH46PAVY0McjzG90ogg2uHYfibNYGni/Tjp?=
 =?us-ascii?Q?cydwRmqvE2UEaNRLiBOaeXv+CJP+M/fpvQ53jqQOlHm5jWLC2oUgQ1aQg5/G?=
 =?us-ascii?Q?mie220+BIx/w7CeUQ9z/PrvMwz2nKOg=3D?=
X-Exchange-RoutingPolicyChecked: CTtpYSI6VsIYtBjqtpXGAVMtoDwjW/XcqkgrMEKMvXvEiCwW7jEpbCVAp9WO9BTzAnqZbq2ezdOw5U8rve/KyL6dj0RPtCtXxtSB1LL9fYCSvCS5n6FVcn4TmmfuozqlxM0jq08VC2wVP66MXP3yaJtdXNgVmlmRy/0BZOJ6WF33cpQVtWZ/8wsa3qAv4A7dV5I50swmeRt4fMFgYgAj89yr4+9WV9li2sdphhc/D4SeVpjXpQ28xO8k+zIZhBBb+E7n4JUU2JS+4tFafaKS8MIx2t2O+Aqr1Kb6U/6KfHf5xnQ5YIclIHvipL1W/2EXXcE9yarnkRi/800byuRtnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0f38cb-7843-42bf-66f1-08df01f00253
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:57:25.4967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+gHTfjrZHKaYtUghAAbo/zbTMgUk5KPh7jK9P34PFAAF5r88tJyBMXJpmZ6uCRS9k3OQEQINFdGOo3KXLwL2fXnUa4HiMbe6dk1kcmQPcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB352616
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

On Mon, Aug 24, 2026 at 04:51:11PM +0200, David Marchand wrote:
> On Mon, 24 Aug 2026 at 12:23, Anurag Mandal <anurag.mandal@intel.com> wrote:
> >
> > Added helpers to encode tunnel context descriptors,
> > and checksum offsets.
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_rxtx_vec_common.h | 53 ++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> > index 1d83a087cc..b84456357f 100644
> > --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> > +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> > @@ -123,8 +123,12 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
> >
> >         /* Tx Checksum Offload */
> >         /* SET MACLEN */
> > -       td_offset |= (tx_pkt->l2_len >> 1) <<
> > -               CI_TX_DESC_LEN_MACLEN_S;
> > +       if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> > +               td_offset |= (tx_pkt->outer_l2_len >> 1) <<
> > +                       CI_TX_DESC_LEN_MACLEN_S;
> > +       else
> > +               td_offset |= (tx_pkt->l2_len >> 1) <<
> > +                       CI_TX_DESC_LEN_MACLEN_S;
> >
> >         /* Enable L3 checksum offload */
> >         if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
> > @@ -172,4 +176,49 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
> >
> >         *txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
> >  }
> > +
> > +static inline uint64_t
> > +ice_txd_tunneling_ctx(const struct rte_mbuf *tx_pkt)
> > +{
> > +       const uint64_t ol_flags = tx_pkt->ol_flags;
> > +       uint64_t ctx = 0;
> > +
> > +       if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
> > +               return 0;
> > +
> > +       if (ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM)
> > +               ctx |= ICE_TX_CTX_EIPT_IPV4;
> > +       else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV4)
> > +               ctx |= ICE_TX_CTX_EIPT_IPV4_NO_CSUM;
> > +       else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV6)
> > +               ctx |= ICE_TX_CTX_EIPT_IPV6;
> > +
> > +       ctx |= (uint64_t)(tx_pkt->outer_l3_len >> 2) << ICE_TXD_CTX_QW0_EIPLEN_S;
> > +
> > +       switch (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
> > +       case RTE_MBUF_F_TX_TUNNEL_IPIP:
> > +               break;
> > +       case RTE_MBUF_F_TX_TUNNEL_VXLAN:
> > +       case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
> > +       case RTE_MBUF_F_TX_TUNNEL_GTP:
> > +       case RTE_MBUF_F_TX_TUNNEL_GENEVE:
> > +               ctx |= ICE_TXD_CTX_UDP_TUNNELING;
> > +               break;
> > +       case RTE_MBUF_F_TX_TUNNEL_GRE:
> > +               ctx |= ICE_TXD_CTX_GRE_TUNNELING;
> > +               break;
> > +       default:
> > +               PMD_TX_LOG(ERR, "Tunnel type not supported");
> > +               return ctx;
> > +       }
> > +
> > +       ctx |= (uint64_t)(tx_pkt->l2_len >> 1) << ICE_TXD_CTX_QW0_NATLEN_S;
> > +
> > +       if ((ctx & ICE_TXD_CTX_QW0_EIPT_M) &&
> > +                       (ctx & ICE_TXD_CTX_UDP_TUNNELING) &&
> > +                       (ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
> > +               ctx |= ICE_TXD_CTX_QW0_L4T_CS_M;
> > +
> > +       return ctx;
> > +}
> >  #endif
> 
> Why copy/paste this code in a new helper?
> The scalar path seems to have the same code, simply moving existing
> code should be enough, or do I miss something?
> 
> 
> Besides, all of this looks really close to the iavf code.
> Can this be factorised in drivers/net/intel/common in some way?
> 

I was looking at that myself earlier in the summer, and have a half-done
prototype lying around somewhere. There are enough inconsistentencies in
the implementations to be annoying, and the options for VLAN tag placement
I remember struggling with a bit too.

In short, it's being looked at, but maybe not this release....

/Bruce

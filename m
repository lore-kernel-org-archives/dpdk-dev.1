Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B6C88E6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:35:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70D5140A7F;
	Mon, 14 Sep 2026 18:35:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id EA89540A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789403735; x=1820939735;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=astXaFQg7NqO2VvN3rjjqeS0IG744dm2fwwQdOwwyKo=;
 b=fYZNy83iJ0DZm3VnHTeLNfut9qzg8yo+yjwOHnt9nw5VQpTaxwIDDs0g
 CHdI5DYmWlxbC9EBp7lR/klByphi4rpChs+POo5OEEW7z5NG9Q8ORlBy0
 aCePEbVnOHGY3NAau0bm+iU9O8IMu/fztZahizKD2exCDUTYeW3jzXMb3
 vliutFRG/QHrlAxy9xQM5AITSYS0PTNuBm4cBljCwxk3XB3SP+iYmmF8U
 kkLZJ34xUdw61GRZtCRL2WmBtQ6qXo0eJHJEqfiOaMRi6dTwkoUN1pDVp
 ecYmCljCuwMbsdR+zCSn1MqgtQlqICHK8M+Cv9YxWNBRugIpNvLN1T1hI w==;
X-CSE-ConnectionGUID: avswIhDqQkyTPwUMLh6cSw==
X-CSE-MsgGUID: pHOP8zk5QXi7SA4ytPsldQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100423266"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100423266"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 09:35:33 -0700
X-CSE-ConnectionGUID: +s5nANH9SG2diqlV3CBJKg==
X-CSE-MsgGUID: Y9gWAsOjRn+KR61oYBq2dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="310958768"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 09:35:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 09:35:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 09:35:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 09:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upK/CdI8fPv6ZbDCB5qTNfFzYBpbCQCLzBB9oH587Noz59W/5TRRMuZbk2Na/2d3T8zR+WJ83UTa0XwB1esm2NYVS7hnPSitIIWjCtIQOwNkKKnGjl9C99MZ1XuXyT1fBErBCOA/VaoSaJHacCdb11wKfV/j4F/VtO1/sfjmtdPjnRhVdpBQOHhQVtT2WOFBlAOz48nAkYQUjTb9usii2O5DhO+qVP6Yn4RBtO1HJQMQ3Ywdj46iRwf3pbavAeEf6fF44a0J+Z/6KF/7V5crvl0Xuc5B0E3CDIP2qDgtSDBbV3zumpT6J/34uFhg1IDNOBoF1c0E5p2j+ZoTqi4rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/jXXRphlpMVt9+WW+ZasXNgWaPn3+F/6hVwm9n2f5s=;
 b=y4rEg6tmnhCvBSRAfuRb4du+musiPlIZedgSdN6uzacdVaOu/ZVB3h4szY94ScCC5eiFjfIE9TJ7yV5gQBS0AgwkyEanvVmypSmHt+u3VMjyGA6A98sjZLsuCrSdhNCsxTixm1ubgNRgSp0DXmQ8u/W5Ixnv/xLE1KGnzqXJ6DXUgcGoz+tzVitAaCO0zajohlhWyBGKUx9AZPN2vCLZqAvLmAih8hzePlaZSNoVYbnu74ajxvjIvq967PxZzP/dHVeLMqpcSRf9QHWD5oeUBlBs+iuPLSjlcrMczhN0g/rtGDWkMkpjWD6FlWrjIp3GbuAmbktmzBmhQP7IrZMZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BL4PR11MB8845.namprd11.prod.outlook.com (2603:10b6:208:5aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 16:35:29 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:35:28 +0000
Date: Mon, 14 Sep 2026 17:35:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH 13/13] net/ice: enable context desc offloads for vector Tx
Message-ID: <aqgiTOZF_hilXCj1@bricha3-mobl1.ger.corp.intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170421.361293-1-bruce.richardson@intel.com>
 <IA4PR11MB9278B0B20DE99B28512414EF8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB9278B0B20DE99B28512414EF8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BL4PR11MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: cd15920c-1dda-43ec-835f-08df127e2fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uQ4wnOV6dIE+0vDBZyROjQpwV5G7MHWcPXtwJ566WAnzZtm5ozCTbHIeVRv4kb7Tn/XripnL/14pFRKQJW6sP3fDG3LSshAaIEx351oJWNZuiYOl1N5g34wl5r1kUtaRo8NotMKls2uVDgx0PWrOBsBWSQGWWQKqm5N83xAtLW6do6LvRocAQOjoncFeZmbRWKiJyk28d+mIyTZa1z1ojQxH/YaLnuG0DHSMoGkTw2KqJkGzETiTDmYvs6+qExTqVCAW2pB9WcHpNSOW+eanXC4nEJbbr4ANJZBDRu4tOPq7vootgjLiIcPE445B9eujg4+KyOF7OjBGKoLa9NUhRc1ISBodKBXvrzNBegRtALilRX6MWPW1w3fTImogArKxzzjUGrFHZ+tBm6x+Q6mtv0wSDVHOHzAM3CEbGEILzPazEhroJoUQKVLG2OGodIiXq4Lxjmzy77q81cdYC7HwO7MI1m77+Y9ixHorBi4aGBmE1E+mIgurATg0CDuxgE7vxqu0KV7s343KKO0xAjtuv16IQtgyugxcLVSM6fyrS6qzaRP5wjQelW1wc0hFMDEOqJCCYttE9K5eeckoE9arTFioh2YSvog277bd9xBL7Nz/aMUq3dbpTGVlIJaApF0/4/FH6tbD6nAf8kq3TKAlOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5F4UMDQpvCUIyp86E3lgEqtFU48F9h2nJgU7iIg9JVnLKEfXcjLWNyq2EFS?=
 =?us-ascii?Q?e+EV1DSIcMqRga+tM+qgSviks403dNxco5wL5nNN7yPsCD48AHFoMglAt7++?=
 =?us-ascii?Q?6WoaH2cgwr4kwFNHrKhweBdc1iypd3mUYuxFR+6vLW7D8eLUJdRCB2YUszQI?=
 =?us-ascii?Q?BEmLsStvgj7l9l3SsRKmLQVy/58xWlIuDfjEE9yWjs4v/g5RVOe5n3tGXBJR?=
 =?us-ascii?Q?4iunoG2GZ7a2egN3rsvvqZzFpDZP4ia3Ywa9K4RnuDLUkAgw7QEqMru/mPgI?=
 =?us-ascii?Q?rxswQ0yE+XYmHvf0H6HV/0QpAaeiuekaj6zhrNsZ1pMV2jtBz2vacMu/8DL0?=
 =?us-ascii?Q?QZJcv1GimIOFHmRWtnEgwO9lw6Gh/6aPFpqJN7bZ9TO2o1u3oK6uTR/o4en3?=
 =?us-ascii?Q?OW57rNy7tzkSbT9uK9lxCaLmVJDrDpDqgcTDIX7cEVmRoeynnighFvc6DgKL?=
 =?us-ascii?Q?Ot3TkKSoXxobgM4wLM43fz1X5rjn9rPOlwIODT0C9LoQ3HtnFTc+0VVfU7ot?=
 =?us-ascii?Q?cAy4g8pZY0R9IBsx5ZuoXDKyVE3FtNz2rZkJURCxwFQ1yTyXkeu8DM2UKRCJ?=
 =?us-ascii?Q?YSBJgK/Bsp3ann323aude8NrGk36hE6Kveb4P+x9yyqXGaV8k+zE+FfWvu2b?=
 =?us-ascii?Q?npJtwP9BM2odEY0pYq3PQDjkX1LSrZ82OiCbAvimZuQlajbwDB4/lmq+yzbQ?=
 =?us-ascii?Q?kPf8OrYIZ9D89/28Nvbmlqke+1lrep/HyZW4Wl4Wvh9YHP/7KE5cKfoxQdHk?=
 =?us-ascii?Q?86EA0L/8ZeyG28tcCCWdlqtMZvRCuAuFGs1WNX5p2QIfthgWrqqy2jU2M9E0?=
 =?us-ascii?Q?4AkFse479Sn0L3MKbYE9VxwVdz5lqQzgo+AsaoM+Drlq7F+fX9IF/3PWrKho?=
 =?us-ascii?Q?QAhs5+xmC7BLYsL5iT0ImJcX1FamdWBMNvM/t9fsZ4WF2a2wqWp1+kl3oGRC?=
 =?us-ascii?Q?oGatnFM6sHB9/fjTYvCSf6lTUs7SofzD6iynAXXB6Q2mhgM5fXTR+B5DQ+9/?=
 =?us-ascii?Q?zv/0Ai4uebhBzwekDwuA/fKkQzpYp6VUj5dO3dW9d8rZab0UCTtSCqFtUBBM?=
 =?us-ascii?Q?d0WhnBoQpeMlhZDe/jui30e6zsgvK0XK5WeLYWVEdpSfUumSlauQRVsxQDPr?=
 =?us-ascii?Q?OeNms0E0ELhTlQbaAOFTG6Q0QwDy7Scst2IEgHYfAoLWNHwbMaq4mh41Eyzj?=
 =?us-ascii?Q?q64za5tJIBUwIO7cGSF0A3wvBxqvGJcwL7oxdzjX0Jh8TwbVm2C5/XnF+22x?=
 =?us-ascii?Q?BygbcA9uBF1ocZ0rWbBAV1x4mSCite1WRI6JrrfaGgrZHk4lgOiUZ5zdUOiE?=
 =?us-ascii?Q?9K/Rqle3x/Vn9l9vrZ73gICy+4DKXsfWhPQ3ArzuWs79TKYTs3TdRWNISue0?=
 =?us-ascii?Q?MaouqMFtrmHFkktaMUIG6R8BIrt3YJFD9DFG6Kmre+VqQnTOfvIhozWDT2J4?=
 =?us-ascii?Q?iXYRDzEmgAX6L4HpduUVpBbD3DJebc9QrkipmZLlmpGekAn4/kuzOqRFzsWi?=
 =?us-ascii?Q?8cbcLOKLTqSOnw4wMz8BkKEYFiIpwoV9oZwLbAGYCSiZ2nvIf2CqIMgg8FQ6?=
 =?us-ascii?Q?rU3zEk3hZKbgtxfSvkpuACSYMSYnWq47EDHijOXcU250fRK7fPa7cecJhBg5?=
 =?us-ascii?Q?3T6lIAjH90YRWgbKj8qg9Pu5JVZacCZZh5QnaeFOewWxss4LgGMNdBOxA8fg?=
 =?us-ascii?Q?v05GBWuEHXVLws3zMZeVOTJV1y7qW6HiClp4mSuvkT52dndw5eP4efgW/Wuk?=
 =?us-ascii?Q?NPHNwvktEsaxFW0cs8DTwPrcBu2CvHU=3D?=
X-Exchange-RoutingPolicyChecked: DXPNRKAEHjINHb2qu6PdYapijxKL1ha06et4uPLuwt4bouRKXjAC43UoXhGyBaxop60vpDiW+356XLfrijrs43uqo4yeTNlXguZko62ZZprB8IRk2HbfE4P2Vs6HQUketYlSBNAU7l7wo+4hLj5wBDCRXe814iOsd0oyAmmocYald2hM4/x/ogjaTWQuqSu+B6kpRQYnaV/yzWadBQ0ZiOPCfUDU3PdBEs4OgeRkxtH7SHGRxcvUK2k5IQ9zQ6DbJTmb0h2QGJ+tOf9CcwyvMWjWFx6JAeTlNCmYUpYognL84OcHbcSAlU2VIGn5eex2JTPPaZebN0pL4Ns+T3DfHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd15920c-1dda-43ec-835f-08df127e2fbb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:35:28.8785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9mN56HQd/EDJ88hsLr5s4q1/WoF32j9qIqCtTjT4I+pDqUeRWmUVPLff/55gwP7KuxqONSsHLA6fmA08dnj+2+GbvHYfGqW9SBJh8BuzFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8845
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

On Mon, Sep 14, 2026 at 03:18:57PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH 13/13] net/ice: enable context desc offloads for vector Tx
> > 
> > Use the context descriptor Tx vector paths from intel/common in ice
> > driver to enable more offloads on the vector path for ice driver.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  doc/guides/rel_notes/release_26_11.rst      |  6 ++++
> >  drivers/net/intel/ice/ice_ethdev.h          |  3 ++
> >  drivers/net/intel/ice/ice_rxtx.c            | 31 ++++++++++++++++++---
> >  drivers/net/intel/ice/ice_rxtx.h            | 11 ++++++++
> >  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 24 ++++++++++++++++
> >  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 24 ++++++++++++++++
> >  6 files changed, 95 insertions(+), 4 deletions(-)
> > 
> 
> <snip>
> 
> > diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> > index 999b6b30d6..bee8a464f5 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.h
> > +++ b/drivers/net/intel/ice/ice_rxtx.h
> > @@ -135,6 +135,12 @@
> >  	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
> >  	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
> >  	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
> > +/* vector ctx offload path: QinQ outer tag + outer/tunnel checksum via ctx
> > desc */
> > +#define ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS (	\
> > +	ICE_TX_VECTOR_OFFLOAD_OFFLOADS |	\
> > +	RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
> > +	RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
> > +	RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
> 
> Now that the paths and thus offloads are shared, is it worth creating
> common OFFLOADS masks? I assume
> IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS is an exact match for
> ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS
> 
Yes, it is probably worth doing. Not sure if it's best in this patchset or
not. Let me investigate.

/Bruce

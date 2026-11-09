Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D1606EE8A
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iAeiAFut
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04BE2406FF;
	Mon,  9 Nov 2026 18:40:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 6BDE240270;
 Mon,  9 Nov 2026 18:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794246045; x=1825782045;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VengqkdCaYaKIIO3HBq1F4YGZ3yyVh4PCDhWIuZaseo=;
 b=iAeiAFutRP8HrbnswWit3JGWraS6HoMVg1HnbVOAEHhbuAdVtI6RyypO
 EeCrZVAkQ/aR71KPYSYZQUkhpYvWTZZO1fN710IOENVsCQccc72TajoRa
 jm2fm/nED0tzEijEvE3QF/u8TVFAnSN7ilhI9UMLAWsV1tiPzgCg0L8Lw
 HDXK3jPGfC5WJzurvI9NU0+vBnoXazQLmmxQav71aaQGINnZXAf6rbMok
 nBORV927JpALdgPdbxAvDRO0XORln/YjUEB95VCjSPb4HHDUbXOkAL3Gb
 mAX4+TnlewwSutbN5E8tAWD5oh42gJ5/wEH2QernyqkoC6SLHOEr9bpYv A==;
X-CSE-ConnectionGUID: iu3GgjsNThWTWQIrjUVKzg==
X-CSE-MsgGUID: G5P04+aCTIiItVWkUNWahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3002380"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3002380"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:40:43 -0800
X-CSE-ConnectionGUID: /ugtXbJ2QZ++M1F0VNPH3A==
X-CSE-MsgGUID: cKT1zFswTeuGID4BpBTs6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9666817"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:40:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:40:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 09:40:42 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:40:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyK6NrrjOcSFcLq31HbP5mqvS5czQL2PZMkq2ou+wv+KyMPGrlkj5GkcYO7zciuNhb7W8zHa1FtXk0CKaXViNPLPGaPWMa5saCPBT6vmkQtvioYoDONtjrG3CKzmGU7fVEAjWsQFPmuP1TjgpFhKy+uVADj7u0XnPE0X5SD/R0aKrmF6tuTSa1ZsJTfcMu7Y00EYJB6BfGMARQIsreTEsKBRgRQjpACmeDJJ2Jq7e44B23tHchmZVeYUCzTRtBEdjSVt36fvdkoDk19uXtmK6zxYJz/iu0qX8OSVEXMTwh3gwwgUvitJwa3FqOi25X5Zq2OqSE4XDgZTZezbf9RCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n6c/9Zqs8WQQT3PgcacDqUvGuIVnMPtmIAQ+w3f8/I=;
 b=rvzqcHlWWZH4f+FKK8QQVtlC98JrZpe4FTheZfH3EhqL0ktvqPlppEC8hF/M1qhFazV5WxD6AOzwJOE8uvClWV2ATx7TDWN35hq9WnDZC1LYkQrZYuDXd2LFEBNABwF90To7OyHwJx9yNqTYUmUDQbzOVAryy9W4rfsnjSE/QZZZIbV6JsWahih+PEmuSwVUK9uMFXeUWkGAIH/vhrbGuvsa7t9EzMZXFm7DAlvbhrQcFZN+DN56RwxAwtjk4PKEkqFEKlGxm3/a820jSZDZXU2oRxmSmkyGLwQfmYeAS1QTohPjb5RQKypP9UyCl56W/aZ7+W9ZNKJzePvu5Cx/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB838679.namprd11.prod.outlook.com (2603:10b6:610:367::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:40:40 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 17:40:39 +0000
Date: Mon, 9 Nov 2026 17:40:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 5/8] net/ice: fix DCF QoS bandwidth replay config leak
Message-ID: <avIFk9TzA8kR9fgZ@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1794094943.git.anurag.mandal@intel.com>
 <285894e024af9bf081d823ac0f9e0b7d71f85fd0.1794094943.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <285894e024af9bf081d823ac0f9e0b7d71f85fd0.1794094943.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB838679:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c3ee14-1ab7-4b2b-e049-08df3e88920d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|56012099006|261021121427099003|261022113327099003|261021123027099003|261009223027099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: opLq2P3DJfBd4Nm1WC6u/SgWZ0NktC4cNucaT5VjApkzuev2reZULr1UUG31nCIzqweNq5A3QPnr3ztUlO//zRFwTEMaitsFCVu8PgUdHB7awhzhbdQNU/2qnMnZUYjBa0fU5/XWfTqv3tAH0grTsKNpVU1kc5zxDtdf2gnnMwkG9de4sOUMUw4TGM35ZGO20Smx20DYjj2pLp+g343SE+OTBJNpJebhHYlt3umO1G9gkHvQbTCEBPlywoPCDvm8szzbm/N0tQDbUmh2HTDSVjuzMFJCA8qQLgRv/PgXe9mwhOhjnLigomOnI276UPDyZbN8NB7+G092fpI7fdgJUn+DQoPRy0252t2Avb9L9CJn9H3XJcSawZlpN3ol6aX4B4d1h1tcsIDClaI1q+TLWCdHYgHUNZspToUqY8DSXw5moZa6kOemAayLCjb7IXXhTZ/wnDnj0MSfSTRa/LLSRQ4IguV3LTbWWjX8lrg7GRNWUupVZ5fqqtEefl0HulUAp36UhrAlNI83XNTH7yJZSeWCilXhBfIfyoW+SxkzkCTIIsxS1/UWMfTTxzPWVqT33sFAyKz1zNHGcfTxfzpk48Np9DOXrkBvLA6YdOI03jzmxuVXedRMc9VahNAmv8a9Bjy06Ui1EQ4bZ8UBZUFBqrRMWxqr+MQ2RNA8wbNLkWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022113327099003)(261021123027099003)(261009223027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JByaz+TpNG7zL+WZS/N5wiIn/of3nQqRKR+/+aAIGnH3KgJda94rhZaZHnY6?=
 =?us-ascii?Q?vB462fQbOeGaG7UPx+nBc/yFBl4Kobj9mQ0U/FEWm+xpsZiMTSYHRTFw2wzW?=
 =?us-ascii?Q?/A8ugvcAnmUAydBHFbQqU7wxGu/+7gBaGELFDVBYsf/oQawMdq38WvllJkfc?=
 =?us-ascii?Q?sukw+9iUsx3s2ZgYzuM5V++Y/xjCI7vdts1VBzVP+3BgBuNCKiaulsRcEeiZ?=
 =?us-ascii?Q?zzBvYxgyT4166W//P/gx1hSNMsaGYICYBV+tfrIJ7rypciaCmaT0Q5vwZEOR?=
 =?us-ascii?Q?WamckC66KCSr30oVCfxybG5FG9Ge/7Bwr8kJLgSljeRvBu2e06msrw0Y4TJ/?=
 =?us-ascii?Q?qkNy0ETeW6euIM4MlhSPTL4nUwbwN6ranF64HS/leSLidG5loHgKbb4EfcpG?=
 =?us-ascii?Q?3gFJlhlYHSf7oA5l4boTd8+wV3pGMedr0+gbLFAjpjqUZyN4YPoyzHe7U3L6?=
 =?us-ascii?Q?ARnGv3oxBRbPfgS+xwEVWvwDBtnmt5wF1THP8pqBDo38ZfVNBjTfk4H2O+Le?=
 =?us-ascii?Q?EmGobfOgwwuipgGzn1QYTN5ofa9XaCXzE7qp9C6R0PxQ5dK7D1vrJSUdBkwl?=
 =?us-ascii?Q?tlvWcKFWpScmtKp+d/Dq5JqRD++Q0tZl8tRxfoU4Gm6Zk2otvn06LtlYU4Cv?=
 =?us-ascii?Q?0jB1WAqr1JGi/Y//Giv26e/H5fIurc0FbW9Dg1smnXjmtfOkaPyym3oqhJit?=
 =?us-ascii?Q?EW01MmnQko5aaArIm1UHAqstoY3fW2FCNK3UTMKFc2GG+n1reYSOq8Ycg7aK?=
 =?us-ascii?Q?DRiIFWxHi7364bS7IDRA80DOc9Aje2hRnEv2oEe+oI+SR8ZCBSmczJlRPkCX?=
 =?us-ascii?Q?P4uyS/OE2KA6IIl8NvJYhD6nMkBc/9XC0EYPk0y49ZyHOugLR5rjWFL0PnUl?=
 =?us-ascii?Q?JzlR8Vq06ZITZcVhqvatnVOosWourQ2pXGCWN4Qh+7wPN8tAPMVo4AVN5G/o?=
 =?us-ascii?Q?uPkUACrIDoImunfd1ZUopRJ7Bm9XTR3g4/cML4dJ92KrmqF9hCHwfW0+s1aM?=
 =?us-ascii?Q?ChAOzP111T7wSrcTa1yAVgOsRdhG7dNCkqhIb8vDXdbv7sEyu0XQD4vA/XUT?=
 =?us-ascii?Q?8s6JzeB7unjeoYQMWLnUHup3KX7OSWLu6qBVuVhFBXV0EQbmpROkfnJytsY1?=
 =?us-ascii?Q?EgJVOpJHejlQ9Xi092y78xpiq7WHNM47FZ0g1B37VzMnB5+PuRmwHEDr17ZO?=
 =?us-ascii?Q?QX7EuZfTzbNWQhXHYboTZ404gr3Qj17oLMXo4XsQHlpnltPXur4XgJX1GpWp?=
 =?us-ascii?Q?CmPZ6V/MEODrfxVE5t12FYmcohVX6Cl+mgCeLNVJ1U4e4LP075Wp0Mxw0rmU?=
 =?us-ascii?Q?89zSQJJccURFmO5CjiojFFU0PkGeiNtawCTdQjzqZ+g+74YIMRedlmFGNe7s?=
 =?us-ascii?Q?sAN91T8av8ra2rkCvN8fplwUlo4xtR57XwmyEP0EUx5Z1+eq0eSjLsDwDtx0?=
 =?us-ascii?Q?zwbV8nmW6S6N7n3rPliw8muTpcGzKpTkyhk0gtVCEmDwGJKLTTS+5y4swa0q?=
 =?us-ascii?Q?oCV/9Kz6R508l6dlnb68Yl6qss97Pim9y+zZvXZDssZUiZ/UGVwwVnAkOj9j?=
 =?us-ascii?Q?4WpT4pvhnV1KojNdAhosuYvPLr84guktGqjQ2VoFRq9YIk3R7n02IzL1bSJt?=
 =?us-ascii?Q?utvFzgaRFgHim66zmdYadfICQzyiT7fw2pzWdh0jqgSWeQLnHYygLKkb0Fda?=
 =?us-ascii?Q?YmKMl3bTMEu5Dlnc89DShQSpgUpxtMvj89GlQt+8FoduO68WDfd9OuOQWBs3?=
 =?us-ascii?Q?HBr+AWtkyw=3D=3D?=
X-Exchange-RoutingPolicyChecked: GevBg/Za4rZc3uIvTiTfrBlN9pKDZY3wnJcPF2gY8fNxAyiWthBcfr3HMCRPf1fOtWBW6DKbA/sviz0iiADLJG39jgoOXyU0sY9/sKWV7qJJkRHG2D02Yf13HY4BiLKfQ7X6Z8+xnR/qnVeujAmxJoTEk97iAGLBjr7k4+pUe10mH1uwa4A6b6ofEftKN6oZPrn0DVefDMUwB4r6HATSTvIIEO2QUKemCncQ53IBXslfdKNRKGPs3SIicXECXS/cCHrBvHs2fLNWHAdiXaDjsI0BDLbQZIpzFwF84FdfiLQfBhD85YXD+gqcSCe3bN29EvQmB+oL9fGUupWCfel4dg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c3ee14-1ab7-4b2b-e049-08df3e88920d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:40:39.7759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud6dOxECzKOt1IeG8R1zmDHsECKeyYi6tu1om11wgfl7TnV6HerqKUsa+WpvDJJkdBEZJIylpKoeW7FSQAu66kTpHdRzDEGiyCp33LKFGt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB838679
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

On Sat, Nov 07, 2026 at 11:52:15PM +0000, Anurag Mandal wrote:
> ice_dcf_hierarchy_commit() keeps a copy of the bandwidth config
> of each VF, and of the TC nodes, in qos_bw_cfg[] to replay it
> after a VF reset.
> Each DCF hierarchy commit allocates commit allocates new copies
> of the VF and TC bandwidth config for VF reset replay, without
> freeing the previous ones,
> They cannot simply be freed there, as the VF reset thread may be
> replaying them at the same time.
> A new copy is also visible to that thread before it is filled in.
> Also, ice_dcf_uninit_hw() frees the array but not the copies, so
> they also leak on close and reset.
> 
> Fill each new copy first, then swap it in under the lock the VF
> reset thread holds while replaying, and free the old copy after
> that and free all copies in ice_dcf_uninit_hw().
> 
> Fixes: 931ee54072b1 ("net/ice: support QoS bandwidth config after VF reset in DCF")
> Fixes: 775a25a372f5 ("net/ice: clear QoS bandwidth on DCF close")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf.c        |  6 ++++++
>  drivers/net/intel/ice/ice_dcf_ethdev.h |  2 ++
>  drivers/net/intel/ice/ice_dcf_parent.c | 15 +++++++++++++++
>  drivers/net/intel/ice/ice_dcf_sched.c  | 17 +++++++++--------
>  4 files changed, 32 insertions(+), 8 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E232C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:01:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E07EF402CF;
	Tue, 18 Feb 2025 17:01:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E442C40261
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:01:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739894504; x=1771430504;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qLcsgNoOZcAycEBS/cPHTvP8v5oGMRZzraRVdt4ZcJM=;
 b=QqeVZ4PFXvi4NBYzrpunofgEYxUxXnBcaG+XO5Wb5yphpW0BrLVLMBBU
 cIfgVMzudbt1kk5BLhIJ/Oy4K4yXGbX0UN4Hn7egWp05M4c45i91JQjx9
 P4BKNjhPOMtdp5+CRw7+cT3hai6ARHXA1JXiglLvlxekXdiNjWfAkmjIZ
 qI4zkGZhf1RFuFFlvxqNs5mJK7GUugSqpeKwWRasWt7UjpodyJG6sNhdM
 4OE+rpAtNhftzy8zblJ/3xglNfS/XkNbvPNhhobGtnhKhQG7r+FJ74P1X
 Yp2n2B8XEFsKCLTDWAspKRJM33esHeQes149Zd9+sfQD8erbBB2xG7iov g==;
X-CSE-ConnectionGUID: qSoP2z16TQKMhxCQiZaDCQ==
X-CSE-MsgGUID: L56el9UITh25cs6WGdxBng==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="52005122"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="52005122"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:01:42 -0800
X-CSE-ConnectionGUID: DRmSXp0SSjyr5tIhNwjMDw==
X-CSE-MsgGUID: ld8e1usYRJywS/BSgb6Rtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118570786"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Feb 2025 08:01:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 08:01:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:01:36 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:01:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIeuEnPz9pmaW27+DmXmfbdxaIAk+7as2ib5tdQj09IN3Cw6rpUfKnFPpWcqHgOBYluAu2ffyvmh9356+eYYgeKikXfMQ8QJwyyZ00TN0/h+EhcliYo2tpUCyRwAp7cRQcQ1Ci9I7MDUhv3sY7v2WQCQGacyV2k7mrYnAI9X44yFeWFds7dKKgBGeEpxiScG826Gy38510oJeRV1yIJ6R5BnQcCefVbM0cjG3ZWcconhkN2JYt9LccxzXie2Ez2V8QkMfYQHnLw2e5+eN/V0ujzZhOMw19ERGykNAKCzERcLhCZCV88nyhc7UM39U54dHBjzhcNFDPaqi/h1VY3bpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOX8TRKplJnQqUso0trVLPykA4eolI0NLkBcz9TfBck=;
 b=BwljX/MwOgnd7mxDMs9wwhAOC2BoK00DIc1SwgN7Ms9p9RDhN8AeoBuRxhaKvQbFjn4OAO/WVCpbGllP81gcFrIHoYg40QiJ+tUimbJGoh2hMZWZRpP3a6ZLgXr/C56bD3t4hXw0ivSecKv1TF9AaW6hk4vmx8KMZgt06sPiE5HPL/qp9lvTItBngtidp9TZuy+fM2rirSw6q5sXmUrzXovCPL2sQCIAoT4zTMIg86GNv8iZMUnNJYlioo9IAqreQza1cCTm8RHxyZ3Fo/tZnHyaD/8QZJML9wyAErZemw9t+cqLmUOAOQuQAbcZ1noveqNDs65x0TmMkhw7DwQZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Tue, 18 Feb
 2025 16:01:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:01:30 +0000
Date: Tue, 18 Feb 2025 16:01:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2 1/2] net/intel: add E830 ETF offload timestamp
 resolution
Message-ID: <Z7Su1Alcdfu_IySA@bricha3-mobl1.ger.corp.intel.com>
References: <20250207124300.1022523-2-soumyadeep.hore@intel.com>
 <20250212214711.1046777-1-soumyadeep.hore@intel.com>
 <20250212214711.1046777-2-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212214711.1046777-2-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 9155e5f0-6975-43b7-7bf8-08dd50358225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OFlzozslPd0YNEVeEt4FXZjbnwi/7hih2tkFY5vQnbXY9TphafZS4GPT1+Yg?=
 =?us-ascii?Q?Genvz19fWq1hO6HBo2cUOlFIa0lDw1TncLGVOHVkn19mIhEste2tpIIEOUFc?=
 =?us-ascii?Q?1v1Ii0aMpVnZbPgP7dxdp4QIUgfuiZbe9eDfYt+oT5ur0t0Zl85eXVq5jFtL?=
 =?us-ascii?Q?RyX+aNA+/F8DShi7xVw40Iouplhchkk0yos2ixxH0KDfm20NWQ5AWn3hl3Ex?=
 =?us-ascii?Q?BVlD+jroMB81WMjQtj/ZWtgBC54mDJZ/0gnDhm4uPEPJUFi+InyVYj6ySpub?=
 =?us-ascii?Q?W62vKood5wyGHS84KPnyKhmOYiIDPjIlxBHedEf29B1j6ADXzBAqMGPecwx7?=
 =?us-ascii?Q?7jDoTas7J3D7oqxh4r7WobGxv2I+Gi02PmZyLMcmJC0xpEz+TbjsWamzYjn9?=
 =?us-ascii?Q?vh6CFU5olQmfL/KNzNe+mflAbpXUEZ66rLwWIYDKnDCWHgd/8MjwtpY0Ba3v?=
 =?us-ascii?Q?FefELUJZ4b4xeBBOYUIDIOL79XrAJdCYEar/mkNfiKV8q5ZajBeKOHmT3fMk?=
 =?us-ascii?Q?1jBNljLpeOexHCgGXReQnwCpahy3N5R6i8UXjKtn0WO4GjeMnJzY2fiPd+Oe?=
 =?us-ascii?Q?7xft4Wrljjf+KJ2kU+VyMaMv6k0PdN/HDVWfnTsR/EX4H5KmRxtaEYpFR5qS?=
 =?us-ascii?Q?u01aPRXkv0mdA3SwKOi5In0qtMxxdQqt6ci6PEC0AitC3ZPNkKAkeF5iecTa?=
 =?us-ascii?Q?H+XgjycmxIalEay1hUpIU7HzWs4tEx0WgKyddTuody/a0RYZYvNsyskFZmOS?=
 =?us-ascii?Q?Nl+4aUaGPmCiui4QUG7Nz7pgpQ5w9tfwQLRaO7WpPevhg4lHpA0MikacAvrR?=
 =?us-ascii?Q?d+ZgyVgfktU1pUfPBRdBtH9g5ANvt4KnGxaRUQq6ivkSdot1qfER5EpzoqX7?=
 =?us-ascii?Q?YVtPsuNL8YooAwWTup8Y+BGXVSQBoEZ//EZ/AFxR3ktew+kS5U05letiLPNj?=
 =?us-ascii?Q?kJKrqQ1xHJbmqggkBQzld2V4q+7yGlvxIu8cUxmPf7JvrZ2RswDanKWrv8ip?=
 =?us-ascii?Q?ZZId6vfArqpQgRzRQY+uVX+U9bkQ7PnKn8v93e8cdoV+9Sf4qNlL98ej/vqh?=
 =?us-ascii?Q?JwCpdM2mzxO8q0gssPcxgYz8+RVnO0R61NaRa9NeLt3cm8KUDLGjDE2i5cHl?=
 =?us-ascii?Q?aHBKVVaSwUdrfGbV9uV04n+UPXj5TUUtbBF1A9gIFuLBcml5k/Pow/IxYzVc?=
 =?us-ascii?Q?EbmjZvoaPNaFX4YYkRkWlkUTUEp1xtmJmRxq8nWbP/Zn7iBecw5T8mWQieyT?=
 =?us-ascii?Q?qW5jLFAQJTn8xCOwHuYSKhFLcodUMYtFjPJuxHSv3pcqiy898gjzVANg8PL6?=
 =?us-ascii?Q?cJwNxXvHQQbYi8xcTg0hySkphso5xw2gstyAxOEHyehKcyd7tBuUPwMvKlm3?=
 =?us-ascii?Q?92vhDUlqzFEJHWy+r2ALCs29ufqj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgiVqaz/i46XY+Az8OPPnPN5g9GMwW0YsXF/Dyz/zdybES3fUO6CY78iyFLE?=
 =?us-ascii?Q?0l1EsumeThqcWlVY7SPr0SZMDHRJbtH0j2ut7v0RazQG5eRtA8iLrRBUI3dC?=
 =?us-ascii?Q?mJ6ddySpAmPg8agPToNxT5E50iBpbiXXHOsF6UTe3nF78ZCLET1jcYUI6+mI?=
 =?us-ascii?Q?5VZxqLNhMuT6hap2PehCjl4IJfbUtqHbJN2vmPCLN/N9RCS6bDoWYOIwX8XN?=
 =?us-ascii?Q?JIsXjK4uYzdcPMSpWKBmWleQRJUJmJdoIln+xSU0A3nwOP53+SJNVUuKCzUP?=
 =?us-ascii?Q?BkcKA7XY982FHt4gUOFJRGMwRYpxzhk8mNl3cj3ivVLajMWAXvAKL0ozkZyA?=
 =?us-ascii?Q?sd1+m9D0NOmKO2HnWFmTafZ64vGiwfvywKgsmi1/TycNSt3a3tX47cYSIBn+?=
 =?us-ascii?Q?RPqJHPPbmhRf3fngXQy6E9c5RSDSIo73li5Q2rHxd+C3jMuj0hfX6ZIq+hXz?=
 =?us-ascii?Q?Ly/vRUlUsyJo5YDIfaYMQ4YtcyTHcqCFc5PAfGZsN38eonppbemBIO4vQ/BB?=
 =?us-ascii?Q?K36758Tp3NmgKMx+liwlwULeK4ng1RQaQfPZp7pTzvZWlVkg0TzwtSr7tjkC?=
 =?us-ascii?Q?c/YeCDfXFKU0Scrr6e8XAEm/8Qx5QoAK5oJu4BAIeGX6hvrRFUkm7AFIbB1c?=
 =?us-ascii?Q?bHBEvG2NNFXvtZVKuMTb3cX+xIVEmfZCxn+dKqqpqqxoVbHjn0ZN7qMNZv/7?=
 =?us-ascii?Q?b3X6SaPy/iDm/63TyZtetUU1oiENdmU+vHHFUwF0EgN8eixc56cZMKYiwl2q?=
 =?us-ascii?Q?OgxpOpXvGagzc/4+8Il50ScoNo4EzLgZ+7G+KNzlDXoBhhyWasa9bI4AjJTw?=
 =?us-ascii?Q?XldZkhxDvQGzqjUU6yJeak2K/F7c5sAJIQn8SLzzBigoyH7DEcWjBNLd5Z/R?=
 =?us-ascii?Q?MmUX1z53MYL8NEBwhXYGvwK5vHJneXpOsikXhn8vorCnjjkLdLgDVU13/VNw?=
 =?us-ascii?Q?fEnzg+2Sp1e4IlTkSaxiRFZGKH79tJMNwEPsK0EO6AR87GQy3K9XmZky9fUS?=
 =?us-ascii?Q?8xCd7PrwbxNhA0gwo4qhEcN2B6XnaIYd1GqjU2HoPHQNBySTAp4IOw7irRIq?=
 =?us-ascii?Q?yXLtElLuyJmYRx3/5chUWtDQyhAmn48MtdLOIjX9N8Wky22U3C5qCTsCysTw?=
 =?us-ascii?Q?z5Igp5upw30LxfJZV5iTuV8k9swQLvOTv62+PNRLfg6kPBNYswFHWsyA2F4O?=
 =?us-ascii?Q?BnOd2RDyZ7wWUyzpOi8OkN8dHeNYvrZyXAmKo1NOyGiU2x2LE23XDnvr3zsV?=
 =?us-ascii?Q?KPNxYtb25LqnNFampC8hMZdxzgFsdV9xCy9U/2Tm93M8Z9Ng0dZrZjFLUb5r?=
 =?us-ascii?Q?sxbqSdc9iBxiAzKemTTMeCHz39sRvpbo5CIYJmkZc8/5IWHSTcPbB4coSdrZ?=
 =?us-ascii?Q?/7+5orOZyE6goQFT4NUR1dACqu8i0aRjj1nfGLWXX5pO8QzbIwQR6QxHKPFd?=
 =?us-ascii?Q?KTt7QjcXPI+JW5LPb6kpbFgUTB6Hdy60msBnj9026SXpTo/ZFXrX8WVgZABw?=
 =?us-ascii?Q?BPCmejMPE2tE/jpNLshaHG0+ctdiKQElC39lom2X6jsOiQdECKNc0WpsGOdB?=
 =?us-ascii?Q?F5mwbAGjhorxUIipIUVcWMWyAeox4S8gzBkTTioNQW4Jpb3NET0nYcqAgCNu?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9155e5f0-6975-43b7-7bf8-08dd50358225
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:01:30.6579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FgaHnnuOTnf5YIcwfI04FJLggZUWep/xNZdxkpZuQe2X0gEpW7cN9LCrxlPtk12gKA9kaGEXcAgRdKo79cF6BHiJ2H3NIhbIT8GCE6DamY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
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

On Wed, Feb 12, 2025 at 09:47:10PM +0000, Soumyadeep Hore wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Update E830 ETF offload time stamp resolution to 128ns along

I'm not sure the word "update" is applicable here, since I just see a
single new define being added. The timestamp resolution wasn't previously
being set in the code, was it, or am I missing something?

> with certain HW defines for TXTIME_PROFILE register.

This commit title and log message should probably just be "add defines for
Tx time stamping" or something similar to that.

> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index f92382346f..940c6843d9 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1278,6 +1278,8 @@ struct ice_ts_desc {
>  #define ICE_TXTIME_MAX_QUEUE		2047
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
> +#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +
>  /* Tx Time queue context data
>   *
>   * The sizes of the variables may be larger than needed due to crossing byte
> @@ -1303,6 +1305,8 @@ struct ice_txtime_ctx {
>  	u8 drbell_mode_32;
>  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
>  	u8 ts_res;
> +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
> +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
>  	u8 ts_round_type;
>  	u8 ts_pacing_slot;
>  	u8 merging_ena;
> -- 
> 2.43.0
> 

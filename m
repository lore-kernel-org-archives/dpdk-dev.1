Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4550EC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 10:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 962D0402DF;
	Thu, 22 May 2025 12:02:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5546F40655;
 Thu, 22 May 2025 12:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747908156; x=1779444156;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gntCYignqW87c/tMK8qJ4CkwIuHLSK2FLZ+TAhzFHCM=;
 b=fM9tWCt1lqTroKs30i285Ngmm/SAYhSdVp8jgjPXDsOgJUfqqyu2bed2
 0Ws3f10J0FHg4X5UAWC3IWqwvliCFSLAVgbrZ/FVrU6SON0mErJ7kLgYo
 uz4A2cMUOvbB1WRsMXiegNApcxbr5Yt1goBjpvUeX2QS/qz/4X1B93bTP
 KO9HSmHheadrS/fSwCrb9n3JCovrb9IR8Yda6CqlF94pH/2tDykbL4oph
 Emx7zdw8RJ0KHIMmjDBNBr69VeOSTZmyMEmwA60az7V2zn7WquznhLbgI
 iRYAplILZcZmX57mTx01Eji1PW03p503t0RrxB6fmtw8iGgNQ34hXxgjO g==;
X-CSE-ConnectionGUID: FPJDkRvUTaW6sWFG0jv29g==
X-CSE-MsgGUID: CCP1bDKLR4qZ83TmNvK9Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49173777"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="49173777"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 03:02:35 -0700
X-CSE-ConnectionGUID: zSz/Mtu+SFK6F9HxLPbi0g==
X-CSE-MsgGUID: zmOxgcWfTven3vwYxA8t+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="163790031"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 03:02:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 03:02:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 03:02:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 03:02:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHS43agsfFGyZo3UBKIr/7SRu2YdEXV+L/mYRQCsliLgBbxP2KZdi2Q/5UTyGzjBVI5UbjzlBmmiqpr4yw4oyF9/WwAzz07bKcc54+25vWpVYsPeSjMqForZHhodGwgltsxuUrfE0DGiVBZmUhvlk9a4pNXkafQ5aRqyqV4AGoOOEgnsHzsc0yZBc1u3GGn9uEuj53Y5P1b//xvHSAFt5e8pLjfpf+S3auxFL28EFhns/igtlmN0hKejzdY/JNMC79vIphEf/SftRcEpZAyU9CcwswSx7Yv2y40ntsKgxZDBRb75g+tqx5BYuH/3BryFyi3H+hS3oYb4+AOA9aSFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKhMoYzqRpMjm5pKV5uWyYUo9uQHlxOSHB0TuMNRssE=;
 b=hQ3PqjC+BYdgRHNOk1wEaOakibjsveJ4sFbiqV7QXBe0c3wyVj/yRgpO8unzehMPYyMVs7cp8fdhAbrCJRfjjTQ7wfm2Y5MeRF4yzYl0W8FJc8HuBOh1NhCq6/sS9FaCwIVI/Qp9iMd/mkb/qXqWfkuyGuWvN/lVqJUL4Rb2mS4YVKD0izgZjtPb0EZNxPe4NIPjjCcPyhRKge2HpWBjFqR4ygrI1zIM7Mu0j4ZQM0+3YyfSxNMvN5RWjhUkkqmMqaxdwj+JiMC0Zz9FvhuodgmljvdGicNfuwdvDm5Bs+N8Nlt4tzakqmlrKeuxkyzRNZ8ljQb/qQY5Ib3jW1BgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 22 May
 2025 10:02:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 10:02:03 +0000
Date: Thu, 22 May 2025 11:01:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ice: fix support for 3 scheduler levels
Message-ID: <aC72FtUu60v9U5bz@bricha3-mobl1.ger.corp.intel.com>
References: <20250506103414.892849-1-bruce.richardson@intel.com>
 <MW4PR11MB5872C77092A3DF1A312FD5168E9EA@MW4PR11MB5872.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MW4PR11MB5872C77092A3DF1A312FD5168E9EA@MW4PR11MB5872.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8854729d-1c4c-4a8b-d548-08dd9917b357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W1WiaL16/4lR1M476eWfUAM5W1NANBGVuzOtkhOvumZXWiY2w8rngj28k/rJ?=
 =?us-ascii?Q?WNcy4k2aPXj9U7EfZBOeqb0bAU1gRMYLPxQyi6OMK/5vjTcCxGwJAtcTrZje?=
 =?us-ascii?Q?PcvQfkS1u5buFoG/bNEV9Nv5DAE6VkUz/gCLFMJjFP4pM1aKP2xAVuYJgUuf?=
 =?us-ascii?Q?ZEXD1j3nTfYYvjH66M8D7QsKp5qZSpkqrDLQhH/0kSGpQQSs6hdRXasjgZaN?=
 =?us-ascii?Q?xZkP6HCPRLuY0XrGzeLRGR9VAjUlZb5buC645qw4Mam8KBW5kXMGlxqoG8de?=
 =?us-ascii?Q?3xJFR6FzDeywoTz+3whzylTGwXe4TMD/8FoNeAOl62lijfosbjMd/D5xZCWK?=
 =?us-ascii?Q?xvlGwxZOg9h3jlk9sSITxF2er6nmb9WWPnJhkWctBJY41IuBv6zzw7whlZAc?=
 =?us-ascii?Q?BxanrQiEzDmJ19M4/NKbcE59GiggTksENceMyY14yaP3JTmeCQ0lY9n9Oj9n?=
 =?us-ascii?Q?289jqY+de0jQb1RQODBSLwAZY6EdtPprIgN+LY88fhiLxLJCds9EJ3dOWJee?=
 =?us-ascii?Q?XsoLY5tpVRsYtmxd1GlWZ2vGFQA2OfvSn6oH3g/r4FaojkqqVJjBWlIJsB5D?=
 =?us-ascii?Q?phkAnHQ/ekrHOKZvLVMoyv/M7tSs5Z8X5F9YoRwSp7a1MLZhP5i2vGk9UH41?=
 =?us-ascii?Q?1KYpRXsxU9Iugj/bd1kN8jZn4nIHnh4WZlweBpMTGsYINGv/ETzGqHt8t8Ec?=
 =?us-ascii?Q?7RHoSsxV3cXrjv57AZl6HYqOPejhQIdzc9HphU9eZn3gymcHouVpr9xK8Q/M?=
 =?us-ascii?Q?F7JHjX6TtbBXtq91FxWk4P8A4cuhEpuqUTw9rfRZeYb5R6BIiqm0vu356eg3?=
 =?us-ascii?Q?X6SYs3WrxRn+sLBPb9MOHBK2OdsOfMT61NCsUdT4GMHi1gAvhbDo7GWHmEvc?=
 =?us-ascii?Q?bskpWKY2mm2T4Z2pjA+tMfv8owJs58/xCjxrCpu7v8iFKyuC/Bbb/Gp6DIyU?=
 =?us-ascii?Q?HV9RqoYVMk8S9ljdQHK0ZOIPvYvaDSh0OR/LzWOcmr2uo4sUm00dVuaMBJ++?=
 =?us-ascii?Q?lzw9xwLDORJyKHb6VEaKRR6MmxJeQ5noarl3mvbah14iwH2ZQjKiK6SOwPlo?=
 =?us-ascii?Q?bXxvVV4Oobpsey1rKtPXYbD6C2wvmW3kzfIyH2L2PbRtbgAYkPPZPnYi4DnX?=
 =?us-ascii?Q?JMUcP8dbR9xTwdUAzppo6tGOjX6B5IigUmwKZxwNa+HEcJGmFqLo83A7GJw5?=
 =?us-ascii?Q?wMM3DxLyhx7dyLRsKPkKG7Nwe37Mqv3oadYCplezNL5THf/Sf9PIvuaVyYJy?=
 =?us-ascii?Q?TZNz4nDYSbFicIlTy7I97Y21QHZoCqkCctxr6Qj4Ru5HesBD7zk8WhHQ8v23?=
 =?us-ascii?Q?kMSUFMvqB8Zt309cE4GqeKe/W125Katp7itV69C74253L8Rc+9JQce3CLGnC?=
 =?us-ascii?Q?FvW0wGW1K0Ytvxw0oaeLALKbErFB22COvvx02dLnLMS4pNhNQHUrv014Ykcf?=
 =?us-ascii?Q?XaffuNG2U0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldNAIpxtyKcXvvHT9MnrKmjOvEDOJhlXTa8uOgXxD8ww7wkURmjmlYuKuKx8?=
 =?us-ascii?Q?eK2m3SbHKWc61uvm3TpIg7RCNHvOefyOapSmWAVIGbFq+JODYaTXedSif62j?=
 =?us-ascii?Q?t9TFDq6liPLPAuVJNnmHv1WDZQkLUzVlajd4Zm1IjwfRqqR/dd5cQJZPLhlM?=
 =?us-ascii?Q?DEYj9YdYgXaKRk00PXtAULRG+1ISlU0wHWm1jpF8wTeH55A1K6rK1Dn+iOmW?=
 =?us-ascii?Q?UfT4g0F3ZIvczynXVGRn9SPSybKeeulT4a5Jq0/nOhNMDit7dgy+yTwxYnnF?=
 =?us-ascii?Q?N0JgEwKbirh7XfrhCjhPrTtcr6iCTuqQMQVxZLpu7aSrey6uyYGTDS20GDmx?=
 =?us-ascii?Q?b3D/d572PL4CMD3By8uM5SgSu7WQ6fLDIM1/nSmiLW8i/zXjPTYKPpXrZzaf?=
 =?us-ascii?Q?NHgg7TbaCiTx99p0S/pHKqVX1mSrbONw/bahKMyierqbUzvE1GEYKXdWvmrF?=
 =?us-ascii?Q?0f4+xdi3GO1NC/hxmYVhVgGkf37CNOk9fKEGgqpuk7cnQlZ3zGWQlAlAUY+C?=
 =?us-ascii?Q?nnJYpN05yQ8rEMH4a6Nv6ubSKHkX2kp7GtD6xUlfjeRdR0s1BkO2sQYxbQtR?=
 =?us-ascii?Q?NtcP+y2Lc9avtv0EXLgU0yEqTOYtIsFJIzgxVPleuySSdlkc0ax8/UVYkEq8?=
 =?us-ascii?Q?KY9tdEkc1ITMj1f96sNLNWd0jj+Nv3+s5GDKz/s78K4+fX791Nw0WkC47VsK?=
 =?us-ascii?Q?64y9IIKlIbH4RuRznIhzuedCTZk9UmTo1oW7vVI/iGiWICeKWqzz6sEEP0FH?=
 =?us-ascii?Q?BhT0Mw2LeavilsFNMYELGEQ/rx/X34bVcm6AqL5zqrpSMy5vf2/pTFlBjhUM?=
 =?us-ascii?Q?z+jK/V2KEG4k3UA/iFZTC1Ql8U3vg7aqy0092YzT9KqLBJaWqQF6rmWokxxF?=
 =?us-ascii?Q?SwrAGdUHsqjHV+FRB+His4j6t8qEyi2OTZPEgy1FAsWCMKZAnrQCaqEDEBE3?=
 =?us-ascii?Q?eqPfVs1D1h1McPamkb4gsZzOYdqZQLthb07u6MzWQOWMSCnTyvcFArHR3mh1?=
 =?us-ascii?Q?2jaDdoxxSvwW0JqUQQoB7g0dSsTi+JBGnn9RftW77q0w53xJeUEAvTobyCOu?=
 =?us-ascii?Q?NjYjCINnrlWgJqETLOIGOZaUwu5b3LIrdLnPo0JzPal/mX1UFuI+ITZy9RF5?=
 =?us-ascii?Q?jk9XoZyFZHjxsH7136tx8hb5H3dI0omvtrtvyZVfBu2EhyYXMfg10iwLnUhh?=
 =?us-ascii?Q?KYaQdqwatby2kZ+qGKALGGC25h8OC1B8+ZORuNuag0ivaEONTAURZuc3rXki?=
 =?us-ascii?Q?EX1jNinR1+wNwcVvRI4Z7pC5KXCRPfhlhX0aIhG0wUE9z8+3MBoNCVw+GLpT?=
 =?us-ascii?Q?RQ+0GhLsCQX4ozbg7P/ww1UTc6RjucAApYOUsnd+a9SzUXF1Y8I5ZDB8rvLx?=
 =?us-ascii?Q?jpEJx5V1GGs6n04mP+8ma5Id68sLKLTM9uyLd53XYImWcKIZ548hjbjmfY8q?=
 =?us-ascii?Q?nuzpljrHF6Nn4MefckADoFY1dGJb2QOZpzeuUg2+ngj1waJ7KMmUvf2rQFKf?=
 =?us-ascii?Q?SD4v3jBHkxmdRO3kvSRxSEAoLpiyrtgPuxrbdfH/eM0YSGOmqO2dOLQ2kov0?=
 =?us-ascii?Q?U5Lfc9OZJBDMpcMHCm+kuolEb8gD6Tb4R1d/ZI+AcLVE6DwBgMfh4ab4XGmx?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8854729d-1c4c-4a8b-d548-08dd9917b357
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:02:03.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ai02fMFXhiUDzqpS4Xi/kti4r86IxrbHfAJ91P7+77+E4Mq6WqIMlfCWhOVlxxZn6M1BzHjniQ5WTKENl49/DYZ3OJASJCJjHwGjpznwcNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
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

On Wed, May 21, 2025 at 11:52:21AM +0100, Loftus, Ciara wrote:
> > 
> > When using only 3 scheduler levels, the VSI node needs to be a node
> > further down the scheduler hierarchy, rather than one up it as with all
> > other possible level settings (5-9). Take account of this possibility in
> > the code.
> > 
> > Fixes: 4ace7701eb44 ("net/ice: provide parameter to limit scheduler layers")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_tm.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
> > index ff3a6cd77f..f2d8e12181 100644
> > --- a/drivers/net/intel/ice/ice_tm.c
> > +++ b/drivers/net/intel/ice/ice_tm.c
> > @@ -818,6 +818,18 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
> >  	uint8_t qg_lvl = q_lvl - 1;
> > 
> >  	struct ice_sched_node *new_vsi_root = hw->vsi_ctx[pf->main_vsi-
> > >idx]->sched.vsi_node[0];
> > +	/* handle case where VSI node needs to move DOWN the hierarchy */
> > +	while (new_vsi_root->tx_sched_layer < new_root_level) {
> > +		if (new_vsi_root->num_children == 0)
> > +			return -1;
> > +		/* remove all child nodes but the first */
> > +		while (new_vsi_root->num_children > 1)
> > +			free_sched_node_recursive(pi, new_vsi_root,
> > +					new_vsi_root->children[1],
> > +					new_vsi_root->vsi_handle);
> > +		new_vsi_root = new_vsi_root->children[0];
> > +	}
> > +	/* handle case where VSI node needs to move UP the hierarchy */
> >  	while (new_vsi_root->tx_sched_layer > new_root_level)
> >  		new_vsi_root = new_vsi_root->parent;
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce

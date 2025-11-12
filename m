Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F44CD13DD
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 16:20:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ED86406B4;
	Wed, 12 Nov 2025 17:20:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8F79C402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762964418; x=1794500418;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sSqs93RnmTlcgfswze71IzyJn5sWFhIMO3nTV8FMIfI=;
 b=BNWuALLftXI/86uHaM3eZHCCs8ASla0hGvWuTaeAffP0ZZ2CYAlQDVxZ
 t0K1HecelobFUuwN9SPf5DbLJjF4zSM6qVPpBfCt6I6i6XmP1ygBtkXj/
 nvXyuv+FxKtIk/3IJIRuyCnp3EYGn5r3g1xMAZ/QOSMgZ54zGDm/Fw1Db
 E0olcbP94mxyz6hkq7Gs0+cV9PwgJgM/Xg8o+/uDk9cHO6eclHcAHA8Zr
 bueGFGt1l+dQeTjPfRuLXjkabI5QJ2H50ZIQ3LjklBnUQbVoZWA1qgnjE
 7YAphkzw7/Rq0t5kd916smJ2xCv0uHbPc2Dux/mnxC8WZ2eUWo9GvyRKA w==;
X-CSE-ConnectionGUID: 2MEWadKGRXS8qn68+68jGg==
X-CSE-MsgGUID: ChgwtGp2TMG6n4ITZ4hRDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68881985"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="68881985"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:20:17 -0800
X-CSE-ConnectionGUID: DnjETZPFRe+ARZNy+o9b0A==
X-CSE-MsgGUID: dvWP0cBgRfWMo4ueBYklxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="194238507"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:20:16 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:20:15 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 08:20:15 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:20:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1AqwPI1pxU90Ocu+TZBYFFMSU01kFuX1iomic18NwCcc4v6dWqMa6DF+K+buW1XdSUtS3/O/mRoAPyqy6YfmRJOiqVb0lPzpSUe1mvZxBcWKjsQhUtR1ddZ2ICRloKpzwCVFoWLZ6Hf7LlLSrp07IT5BxObYD30MNYw8mmYBoDUiYrv9MfhcFoi6nuoDmAJirftytweNt7Bxsn/BMkatUJYxO69OR0bIf0ndNyLqPoKUDOrO8kDoIK0nAQtNrk1AuXMyFOSOu9BNjX69DUADv/nCTp3SgJcHwse+IXwGvWXmZQLnAv4ULORgA00LlCzSX+KidpLLOsLvfBMMHimeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2BgwVnXbuPz2/QZiD/wkjiqlM6RuL603rkT4oRns5s=;
 b=Kz8HsKiQXNgYvy0v/TuJG9Xkt4dWLcyLq+OgC6ziC9ikbo7f7U5D6F48wanWR+E4HMYDyPyMIAR2tLxg/hanoaPw4LBfclJwH+U+jAVkbew2W275qTP0lOe714PSnW3u2obcnl9EQP0wO7je+/JYQQEhHLDkX2VEUnDby9Ah1sjBTgZZhr6mEB6JxdKtrGc3MgUNqFJLLRvj7zlE9UgWEQBKNNuWpyyjRVd3K7D6+amPXuKdWK4Servt1Cvi4kRUOFb1OVZpITlsnBZL3OIHNXk1QkHJW4XBfSPzP2Ij/bDOdUKaKXeV/RHesoeeemqspYhk4+6ZMQAN374jAvmPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 16:20:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:20:13 +0000
Date: Wed, 12 Nov 2025 16:20:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 "Andrzej Wilczynski" <andrzejx.wilczynski@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH v1 1/1] net/ixgbe: fix PF link state request mailbox size
Message-ID: <aRSzuAnoxejpMoxc@bricha3-mobl1.ger.corp.intel.com>
References: <2ff7218cef6c77858929c2aad49bf33d925f1865.1762782930.git.anatoly.burakov@intel.com>
 <aRStG2sr6wj5cXqW@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRStG2sr6wj5cXqW@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b10c98b-8d63-48fe-7542-08de22075bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6WAopdH39S2jWdqkFsL1o2/oVtl9mIAZ8S1CYLLLILVslDFGCWFlkVZLwMRJ?=
 =?us-ascii?Q?EnzmLIaWXubNswGEL+pl0u8JXKBq+J4RnBjMfGzTBo8ldc89foRWH8Kuy5j+?=
 =?us-ascii?Q?mLJGj6NXuk1W7v9zOb6alJxOujFd4p8uFvA9JsTDVQumkAkNZU7QKwp+xBE2?=
 =?us-ascii?Q?G4IXdd4FNiptjywsQbbta+MuggyOCMHCjuN1YpTK+mnZuP841q55vmhCqmD7?=
 =?us-ascii?Q?KpHW2dXAx3YGctgRXIdxINqmIGx79UXUFG4S4nVUNsdtXh/WNqWLM/nMRKZ2?=
 =?us-ascii?Q?nSV5e5CLSYwkpLOQesSKUKYcGXfmXGN7MzhWf7cK/ijCmc7bJUPnJARPoqui?=
 =?us-ascii?Q?fDBhu54uvdZ8gv4Rs0nMH9Y8eQBseTM4NgTSt5DePBogqJAPHuaNfKV5CXOI?=
 =?us-ascii?Q?dCNX4LVWcrrMqF3kq1gW77skiV+zZFsTnvJ2WwHem6Z+PDVsgVzbGGt7WKtQ?=
 =?us-ascii?Q?aEVeXk6p8j2AijpV/3AdIE06p6aUcMBv9SnMx9EoxFF253n+bAeUuRAbrQCJ?=
 =?us-ascii?Q?mdlrz4DJPHZJFRBKw3FT9iDH6F04FlbP3BJH8jK1BW4tWMHfQVj9ltz0+6hg?=
 =?us-ascii?Q?75pe0004j9BoV30brCmw2WlCjqs/xiwupbW0+eSzXk8X2yDXaVeciBZv0g07?=
 =?us-ascii?Q?8V7YPV9eiLtkXMpY+obq37omDh8KMh3grYtTG7STXZsN9WmCt2ZIITr/vGu5?=
 =?us-ascii?Q?6I2lloQ5t9Yol61xdc69OoukzLYXGzAW2uEBgzCjrPGhoyQxkKbwAwqozG0X?=
 =?us-ascii?Q?U85HBjt2zV8DWDrMxItGY6VwX3/M5wVrMLi5HjYTjx8iUQQd1ezlqtonlnmC?=
 =?us-ascii?Q?bpjyCn5vrMQvbx+SPG+XeDWUXfp08XTwQIU9es8rUrIh+G/oCrWaBbWx/T1A?=
 =?us-ascii?Q?gbY0+ZtGRmwSghhIse8MFnVyhVaYDjLkk4JJskjhsCXVxmQGb4UY0MOfhdy6?=
 =?us-ascii?Q?KmElPqMATTBVzezfU6L8KqmJxEcTm9H7oNwa2BEDOy2vWKI7Ybzbfq9qjvQL?=
 =?us-ascii?Q?Bpv3roZsGoKWYlRC2qQ07SVBteItWhc3L7PH5TSUlL3qnzpOJZkEx176+Dfh?=
 =?us-ascii?Q?AS3HvGc0PfcjJSaavCjkvorAAsT2t1H338si/u7qSw+ePCuRJrBF0qRPM3iK?=
 =?us-ascii?Q?AHi2kXSTk28fBOfRIYeP5AaZtn7LQ89i09RSd1WiQF4SK9KDD4+eQQncXqQR?=
 =?us-ascii?Q?2sJ4i/Wtn3UKTJ6P3FWn3NVFAWDKu2tvo+R0Vg0kamL7vW75sU3YA2d3WLZH?=
 =?us-ascii?Q?ZSVkPvESVX2Tp+hiQYnLWnMZsZXBRvXhw7hWvdPSs/sRkv9Wggx2rQUgOUcY?=
 =?us-ascii?Q?WBQPTo5Pb3AZbYHY41DHlNrcXv33j4O4SP8z/VxXtRzPXAhuKHyNQULn+ffA?=
 =?us-ascii?Q?7O+nS3/ErurnkFRQhLXxbBO82H4dETEyJ1EuAVWV6FOgnfmtJUqjh/jrqZNM?=
 =?us-ascii?Q?bzzYaTb6if/zbTdYtCnVR4uUF4r4w8Xa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6DM7iens52p1J/3N3QJQin0fZIeo8z6G1ffhf9V57Zo9WiOg0Ua1mokIwP/s?=
 =?us-ascii?Q?1LhZu70lDqFiuvsOQIJS3UscCiJrtFkTAsLkJv1YTkMZQX/JktdPosTEH/RR?=
 =?us-ascii?Q?/C5H7le4R5Rz+QakIjrghPdZaRK+1v/eN5xvBqHCymyFbHx8rgUI3kv7StUG?=
 =?us-ascii?Q?DhNuU5dxFTPC3a48OyyluMO1EDAclF/bZ5U6rPe9ogUWwFvysoAtYwYeLzGC?=
 =?us-ascii?Q?Sxd/dejHmgkYtlFmdLWdAl9t9rF7NORa9CCLGFCECMYNGJd6IS4t1nfCVvL6?=
 =?us-ascii?Q?Oz+D0/QIfeHr3/8LyVtcV2r6ojZKNY8x1xaCRL8tV9F3tDMfLWpeXeWF7Rlv?=
 =?us-ascii?Q?PN5dxKHdsEy9KgfyLdhhezej0zHqdhoSZFS1kAZwLQoAKP1t8Q7xYUCVe1YX?=
 =?us-ascii?Q?olUV0LlKYR+ZtSgjb8zMoFnOnh9dILxcRe3DMNlyCkDBaOmUCiAeib50Ikjz?=
 =?us-ascii?Q?6VsKbjO/yafWFJLBX5b7MrOsxdpFUpYRpY5Vz9WBWWXbq44I2RDWaj5xXO8p?=
 =?us-ascii?Q?OOBKw/0uGKVOwk3vNBE18AkTMKOWLczGAGAyffcItF1ocr0rkHFr9ghrgV+o?=
 =?us-ascii?Q?2XTtWqDOSgqk5Fxmj/1ZrJFCpDmecmP0l3M4wzOL0DKOO4eSc6CYc86hhk4Y?=
 =?us-ascii?Q?OmG8yONEQqe8rLzSerA9suGm094h4UkMwqNwuerr8rfq6nRrrhModw2VrtSn?=
 =?us-ascii?Q?v+bvIa9ccT2fYRbNJ+n5cpQQrtxq4NZBq6k41yJz2tK/+SuPz+cJUgzw7kK5?=
 =?us-ascii?Q?ew8qxASiaGS4osXXnbliet/+l/iguMYskQRtXa+Jn8P5bGPdUs6iOnKHVzC3?=
 =?us-ascii?Q?InDLx1X2JQylsRThcXHDmOZrf7gKaN9lEtWb+Cwk5//F6MtLBytI97oNnuiA?=
 =?us-ascii?Q?TDiEjXOphLie52wFNbehmphhoFhCWeB4c76dZutTykTpWiCk0ShXHEbg3mvk?=
 =?us-ascii?Q?1OAwaH+UQ4noAIJmFttRWzMGhph1rKknjabZrfKYHSdUoW/65/FpRpXctOGz?=
 =?us-ascii?Q?pRZ2kw6e2aEHsK91MegMF55VzGyrPiOiJOsEVxs87nJi2Iry8NoNrOIX74Gz?=
 =?us-ascii?Q?0XxiQBzjZ63sokWr99WpCAmdEALPEsk0XYqDkiAmS/eWmOtvieXNfvjRdOjt?=
 =?us-ascii?Q?WMDVY7133KTTyos3d679axfWGJiz7SCndwod3qzOtPznbAHFqMFc7G9Rf1Ez?=
 =?us-ascii?Q?Szf8bLbgj/SWW4ENMPr9oitZahLxbwMITkmL9Y+Dcx8igD/xXWG8JYTyCJ0j?=
 =?us-ascii?Q?ya+zXIVrLyjjLjXWHJbBUFfj3+W55SrRQUqSTe0Rr2ptcjvrTuwrw+G8HZYV?=
 =?us-ascii?Q?372vzzTQeMbEjjnOcb2Hbm84TWhOGGfUBBWA4D9c77B2KhpaDdFc0AtQ9Gcp?=
 =?us-ascii?Q?2ayC73NjS2pCreGGEsZmGnb3TGC/narzKPAm+K4lmROV6/wAd5kCzpZPmRTj?=
 =?us-ascii?Q?0/Kitbe8PWfjG5svrukoXA35FUv5Q0oWX+CH5YFyrtaLHkzcV3S6daypVx9K?=
 =?us-ascii?Q?fgpRJS3u4x+EymKP5e4/BwUZkyZbXnJzJKmp3kwXIX9ga4liCqzsifGUdlCY?=
 =?us-ascii?Q?ZnSsEPGR2/w4HQCFLXmAWX5taii8X0AK+vmiQed9YvIc+dkXBv/z2GWCuO7M?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b10c98b-8d63-48fe-7542-08de22075bba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:20:13.5687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/XmcpzNqf5TYdQIrX7ctFLu/csKz64vrZthMov3HXCLoBjt1+GwmCMWXAP6gx6303r1JopkSZlMNZFE6fBElE6kEFClPs1byBJUNF9nT4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
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

On Wed, Nov 12, 2025 at 03:51:55PM +0000, Bruce Richardson wrote:
> On Mon, Nov 10, 2025 at 01:55:39PM +0000, Anatoly Burakov wrote:
> > From: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
> > 
> > Currently, when requesting PF link state over VF mailbox, the buffer sized
> > 3 dwords is allocated. However, the `ixgbevf_write_msg_read_ack` function
> > is actually called with buffer size of 6 dwords. This leaves an admittedly
> > remote possibility of buffer overrun. Fix by adjusting requested size to 3.
> > 
> > Fixes: adbd71030575 ("net/ixgbe/base: fix link status for E610")
> > 
> > Signed-off-by: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Bugzilla ID: 1801

Cc: stable@dpdk.org

Applied to dpdk-next-net-intel, thanks.

/Bruce

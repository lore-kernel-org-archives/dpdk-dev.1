Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C3C3ABD4
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 12:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 895C1402EF;
	Mon, 12 May 2025 14:59:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2BADB402CA
 for <dev@dpdk.org>; Mon, 12 May 2025 14:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747054758; x=1778590758;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uwuQmxlnrDgwkIrOdCLOKyxUd26NbJ+HUuC8ETABUKw=;
 b=Oko8aJaMoo06YSFWBS2zEQYxs0uiU9E/aQ90XeVih5zKFTMRQHWvEzfR
 G5nXVF6nnIWsDXTciuNJFz4txNLkjA0UbGfni1PylcDgJLy2aEyDdGKgv
 dGGuCaESAbOS4utmM4KBPeaQboMvOAYpGbXJc6GdTSwo6hQ5SeuWVv15Y
 HdcDuQP5an+dRpr02uQWDs/RFQmoGq1+6xTH+HqusJFS9OEpxEqKiGlJt
 cz4ww3u/0JeIvkd6/cDovV73d6cuJns3M/cnkpksJ+73p5kJwfzsc6tAc
 oiGgET6l3P6Njw1fG13WPs0qMx7BIpxfbfbkwBSPYyy+CTHKEtJicMiqm w==;
X-CSE-ConnectionGUID: slA3B9DeR5GrI0Qt5b6M7Q==
X-CSE-MsgGUID: zqrdllRBQfWgrSeqIo7h8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60252243"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="60252243"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 05:58:40 -0700
X-CSE-ConnectionGUID: f9L5JVj9TPOCrGtB5ehJ5w==
X-CSE-MsgGUID: maYJqmgeTy6rgOOyzqTYww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="137869616"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 05:58:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 05:58:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 05:58:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 05:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZjI+X1SA1l8/Nnl/lXFRwXwNji9pc5aRvirAu3IP0hN3vyJ2OAUgSkCUSUKCwIrR24YKKGDSLmCTzH9ePVixQmsrNxaZic1Ty0DhlyvORBNBwGHYlKMHo4vT6Et7H2gYRUP1YuERGjrG7XvhEkXNj8w2piSL/yzXtNYVHwXzaAMCumJQ/slYLXRW/WmcWVBNdjmC5uWqifPimo94EADgptSjPKlngumcziIqeNd9S47AfUWPHTrgXqQis8aBLEW2iZwFxPzeQI4RMcnHelnw+efE7g0tKODPpN9FuNedYHorczhzB8wqjF63JDFP/75UPeugdi7Dwvhy6ZT7rcTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz8fj15NAVptpKI5R6L0acZfckcdZYsRmrA5zLnHgX0=;
 b=LbMSZGM/HevIpzH2vnL7o/DIVKau51IsWwi1vnMNGewZ7rYfpqL567e+MG142hORBWOAYia+YCWqAPopsgmdU/8zH6vDRS1Kued1LJqB5tSSVmhEkmRo4aUASmmmmsiP+N2DEt81Jq8122KeBr0yvI+vE+PoYJ4Og8Puel1WjUIkHhQiIrIU1Bam3wTQjMgs3YcEEvDldIJBLFdwnJ6p/mTueAA6ztxTVRt8SfIr3z55N+AkcTXzRVLYs6JKAKGjlMSd1LgBDOGKr5+S4QyGgejDADk66KdzIN7kbyionVfMQo4DFyxlK+fabgl+z2agtT3kQbWdeJVTY5CNi8Nqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 12:58:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 12:58:38 +0000
Date: Mon, 12 May 2025 13:58:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 01/13] net/ixgbe: remove unused field in Rx queue struct
Message-ID: <aCHweB92GXoe1ap9@bricha3-mobl1.ger.corp.intel.com>
References: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
 <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb60d9b-03af-4438-99a5-08dd9154b654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jW9aU4+6IFX4qYAFXOUDDkuBV2RgFNYTex0XNlIRHf2UK50JcTR807lnwuto?=
 =?us-ascii?Q?alVFONxgwf01DNb7+AxUdEEKOklw+gsoA1fpbs3fky9yVMmJ2GXsySK6CjRQ?=
 =?us-ascii?Q?3SiqUudHE1/j97u16aCjy4TKWSF4nw3kn3ZCLQsLV1ughJPcHWvF9dtOP0lQ?=
 =?us-ascii?Q?KJSMDSyIb12TxuOn4i8BmZ859Elso6FFEMBTwMGR47zlVzhlHpWHKLci6Ds3?=
 =?us-ascii?Q?1Je8ulrtMMcrJSXxWfj/2+VGdXi+z3RSxJEA5hyhtCn2tpuIchuM+Czma8Gp?=
 =?us-ascii?Q?M0vmjGxE4pUfi8ebfbFoNxNHcrhuAdpVy1UBLMoptrs9GMbfntFBOiuu12x3?=
 =?us-ascii?Q?rZZ6VMNZn0J3/WAjnc3WABvIyCjuIqoJ2jvDVB4LHJOQGKL9uv00EO1XFY0E?=
 =?us-ascii?Q?2G9hkmXpJn2HQ2RFdOV5l20wgOvVVs6LBq9xD+yIm7v5SlHuWFJNEZzIU2Z8?=
 =?us-ascii?Q?O+FTy08pzhVovAU9u0IuszRAnJUCewqHheFwmbZhF5wtZQdUwaZjwXLx/Lbq?=
 =?us-ascii?Q?ovFjZzGYfgpbogVDRaq4BoUQIEsmn2JtW1M5NDhRbnC6nQNZNNSrsFs6biqA?=
 =?us-ascii?Q?o8gKJISbVj+Kqx5Qp69Px12GOrfPWYpcEgWHUjJPx9zpx0ywCdvSIkLhn46c?=
 =?us-ascii?Q?z39pNICmM5jzQMfw8gc6XJ+J/h7NX3PMLVu9NbETI17gcBvHU9GfL4SIUtNa?=
 =?us-ascii?Q?IrOqHNi6zBFdIlltMkFyFkWL322dvE9GXf71Cabfa0/iiMRsDz3CFIJrm/eY?=
 =?us-ascii?Q?k8mD07QLk0tzc3Pw68UJ8/bGhL6obP0e6NrmGhxfr/BPCz3Ym9hAWD+BO7Ig?=
 =?us-ascii?Q?bd8jAboIMJQKya2p3bxOcG4H5Ys53Z4ulhNKCFpjd3o/w3q0wHRFXMdPTdyR?=
 =?us-ascii?Q?hzoqJJF0thyO18kY2IKGnWBpQnCw9ATwfOj/sBmjGeI1iZnZSl7WIDtiJMXB?=
 =?us-ascii?Q?WLY0CSjfw/d0kcxUDF+I4uiwDuGKtQw/sbM3orwq6t6zVLrKRvhN9B1GIRci?=
 =?us-ascii?Q?wQJCcha8IjpF/xt7W0ijNnT17IcGxZRQTeM1sCCL+s0HosHGG+y35ZvobjNh?=
 =?us-ascii?Q?LjrhHu5q4HT4n7JZUOlatMmbHzKtF1mBPC7E1yi7RtdJLMfF9Ck/Q73VYcB3?=
 =?us-ascii?Q?KaXbUqZbSHC0mlR2DgEXFs3G467kY1yGtvAN8tkPYuMSMUmsZFJ0+wWMF+uJ?=
 =?us-ascii?Q?7YD4riWr1suKwGUy9RcF51xmIVJJJiMsovgkIQUiLLQI1q6NhE75HetQf6/H?=
 =?us-ascii?Q?CNOCoV7y1rY9n05swbNyYPS02SPrpnAAtKmfskpZXk6gCbNDdYf2qYFxSaYH?=
 =?us-ascii?Q?qxxE7jJXA96kVShglusV0R4LvwM7tQkquQmS7km3A0AcE7hSXaf0Zq+3+r3A?=
 =?us-ascii?Q?dizVX1H+93YUe8WR7GmmDqYXd3/fuCKCMPxevKFRSnywiobFQiA2H555cqhB?=
 =?us-ascii?Q?4vL0k+6QJ1o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wMaPIu/BDQNcKqVWv0eOjmO2qR/pE89Oz41WwUvG7td43u9Bhq1CfdNDXfE?=
 =?us-ascii?Q?AvFKzKIhX+6Ng9AwGyChu8WCxNQXst+Zc5EDbioH5O4RYe846Q1AGZ0/KXiG?=
 =?us-ascii?Q?li62J1TIqFrYLnpAC5srVM0cKa60nCphbfdC+0ARHNjFgLEB0ko1+uwpBwk7?=
 =?us-ascii?Q?m0HJBlApB6jQOiK7BB0vogRij1cJLEyBrZX4pPNkrE/QwAuiZ4b3NJKBHzkw?=
 =?us-ascii?Q?fsQWn2lyFTkUlhPFF5VjrqwP+iZDASI22vfWjWDce3/4n0nBoYH3XOI3U3ES?=
 =?us-ascii?Q?XlvZ/2HUHI93LZnh2MSlEbwZEDrrbDyq7agDpVF7XcVB8jzlgFg711hkQbIk?=
 =?us-ascii?Q?dJOOf234a+IvU/wldRLUb3tgPSF/5+KLRH2vevxD+T427n22MvcAJqYOQ9BH?=
 =?us-ascii?Q?lNlRtzkodSWnkyghB4WeAuTTzVPDsOOyF+lkNu3J0EV1VLCG/OPziiGqDE4C?=
 =?us-ascii?Q?6kp9Dhk4ICRJf3fwGPTgO3lkpDM3k9vBhuoU965daF8OAd5e96BAW3Caqbnm?=
 =?us-ascii?Q?TaUPCq+Pk7Xynz5g6/TYXjnd72Ef1V/RRPsEVqfsCvearadnxz4EXiEsKJ3R?=
 =?us-ascii?Q?V9eEAv8Gmfk3gSXa9DrfDI7vWwTx2CojqpgBzsgpgLGz1kJxaB4Ir5cabNs5?=
 =?us-ascii?Q?PQYersmZEgq3VIzsjSaujExXuQNW6WHOSGVhEQpaX383mo4swdpJ3ficTUtR?=
 =?us-ascii?Q?foZ6s1izfBBgY+LNfiaI+iJ9va4cHST9obTMBGCS78y6xftlzFLAUclV9k3l?=
 =?us-ascii?Q?HKjMAMFSx7D9PrhSfXOfSFzJmorNsX46l+fWBJqDsWVkR+x5m6mwgMQa2tFu?=
 =?us-ascii?Q?PRS2qIjN0GqTLYwxU5K4iV37yjQI3fQL0AMj8zc8KF7+p7AcZJrvu9OOJp9d?=
 =?us-ascii?Q?4DqRyq2hNBo3mspKSgul8InlUCtyQSUor4ZjkMKyaOVgY8EFD6RJr56jOzec?=
 =?us-ascii?Q?V20oQF+Kan3OSv+NNOnoNSAItGaKFgOA0IkBeuizmKOnAxBpIf2GGI633QFx?=
 =?us-ascii?Q?SaVlTht9IllhycEbggfxsovEMRzXbQASm1lIcfaQH2zPTEeD/l0fvjS4hdUb?=
 =?us-ascii?Q?uvGtts61a89Lp/YTreSHgzYYP5EVutxX6vu5ZC/XjE43ELGg0a8kWzdl/c9H?=
 =?us-ascii?Q?2te/bKpsR3f66UWX/zTfU+ixpd8MsYAUlDu2goYCY8vEAsVHJet323WV8wm0?=
 =?us-ascii?Q?tWukbFRuiu/Vzmj7MQQMkZdVUQFMJFkVad2mjmbgJxam+O8SsnYpSED+LHdg?=
 =?us-ascii?Q?UDMR67qTyq5pNQum7nFE9d2ibDKwyoiegp6JcueV/3r5+nCjCvjqgHeXfvDD?=
 =?us-ascii?Q?3uthbpcJAhsKHOELArRdTrahOXjCrnSTdVGpHATlOP6nSf9dmozfzq1GCabJ?=
 =?us-ascii?Q?pfvcIY+NCiFpEguicWc5xUqqeCWoEPsRTp9U6U+bfv/EVogI5utUW635jXN7?=
 =?us-ascii?Q?eCsNBvzyqxF41PE1XOeXmG+PnrONRF6YqsV2oyqgPWjZefsK+hiRZrie1392?=
 =?us-ascii?Q?1il/fKZpYEdHBuM/wtaCYOJu8FKjR31UMipO6B6zFISIksZhCaN1x9IITi92?=
 =?us-ascii?Q?q1hSBn1tIlw7yISLCMbooLoAyPOlRK0CT5yu/buQVyhz/U9BBna3O46EpHtG?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb60d9b-03af-4438-99a5-08dd9154b654
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 12:58:38.0492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQwGAn1XRxHpmQTHitcMZE2br822GmyxFP7yxYDJywO93u69EVFHVQsgluTAXdYw6THSN9s4Ke2YY3xrzX//+Met2F9RZL1dbhk3SEDUWEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
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

On Mon, May 12, 2025 at 01:54:27PM +0100, Anatoly Burakov wrote:
> The `rdh` (read head) field in the `ixgbe_rx_queue` struct is not used
> anywhere in the codebase, and can be removed.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c | 9 ++-------
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h | 1 -
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
Hi Anatoly,

for any future versions, can you please include a cover letter, with a
summary indicating what patches have changed any why. I hope to start
reviewing this patchset shortly.

Thanks,
/Bruce

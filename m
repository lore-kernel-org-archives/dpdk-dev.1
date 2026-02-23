Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ACFEC110C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:04:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 462A04025E;
	Mon, 23 Feb 2026 18:04:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id E04D3400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771866239; x=1803402239;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=voeGUGN5rx2VU71TyRt3kYbwWoYw2ABVVztfmzcPdWU=;
 b=T9Ixcm0/145zC31tBJLej1uz1lXWs+I5bU26X2NFBBNF7OXSnjZOVfr+
 36OfXwkHrrAE5pNQzqgzbJH27wd5yFt1cEFwZbsvl7Nm9KI8HKiAKZrK5
 AIsLSfl53IEPZKh1GFCpgI4ffHYYruSSqqFpGc8D6CYiL/+E4EBZ1M654
 hNUlek7vg3H4C+n4EItQ6u+klkHEY2DAdAukUm2+anLNsbFyhvqA2991j
 UVfjuZVsUnXCGkssLPieBI8M9wameNowQNclS4OHImNGx1/z4AnqDD3X4
 7nC7/BkNuC6GnnCMQrlsl0WAugHBwVD9ZzwOVCZxjMOJjjZ4AYURc01Af g==;
X-CSE-ConnectionGUID: GTa/68VnThqWGrUGWmIKpg==
X-CSE-MsgGUID: fB2OQvBrRV2Or8tZpwNHtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76696860"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="76696860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 09:03:57 -0800
X-CSE-ConnectionGUID: PLJkdnliQquXxmb+xf+n/w==
X-CSE-MsgGUID: J8i8jAJLSHGzz9BxhaqURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="220176358"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 09:03:57 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:03:57 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 09:03:57 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:03:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDCqovtwKTcg27bmXGSIMd4CwMk0Ydw7hvOiwvC0WUmTvx6/GAo1Vy0LFo/xT65ApHzLH2aRquzGyZ0Oi5q6XvPxfwhvahmhm2hZ4+65tlD0ZhjbiA7BeSwa5gs3CmGQ05OBl5EFb6l+MuGcXd8RQTCSr6YswnIgad1Ci6BglECqxQT2+xWNS9RJUKzayCw+7iUpLNbzp4xpHBrhdLaZJcvd5zwGqrY8OjbATXePKw+NNIUYyX3CQwA8luki+ZcH+ttQTJ3vp1SiKKFnMgqFohgQ6YfLvABv3KyOTRHhvNc5dbQZMi+QirdDUZYp48yYcV7JYEB8SXRAzH4v1tQYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QDiJ2ZLmMpl7QZvV1Jy3cKtpz1jkbMmjhu2NPI4kUE=;
 b=v/T5WXWUxbZ5blPHgJh2x39MzU1OHu2ZyxkKuLEJQ6rCF0ikXRGkQaVOVWZStlw4wbxxEdaNZNSqr6mM0i8AFSZ0chT1+hWlUKLFiyVAjGW/4i4KLxzQOUP1aXynKZ4VgWNKGhQ3v+p9gCb1FIAZAyy0UBmWJtDqIc96tJMxq9udWdvFbv8hwBWeu3YKYcT05bDR2UQF8u2FUuiqBjbbS0rDChq3OTaAaY47zImOci7lOE+5Q+uq1vn8SH9UstEdkSXrUNHCz20uUlVtJ/QlQzIOaBgbxlHB2epUvSZuSuvX3GHNsyoXD0ODkayx74CUqOJ7TzBMR2KcvOXxI/9ZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 17:01:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:01:08 +0000
Date: Mon, 23 Feb 2026 17:01:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] test/eal: remove PCI probing for vdev tests
Message-ID: <aZyHzxvNjboxwDs7@bricha3-mobl1.ger.corp.intel.com>
References: <20260223155603.3651641-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260223155603.3651641-1-david.marchand@redhat.com>
X-ClientProxiedBy: DB3PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:8::33)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: d2911e02-ca8e-4284-5601-08de72fd23a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T3tiNOWmpzaKqR4FEJRHRtnKvLgfrn7JZ55pLnQeaIbLuQOiOzkjqWFI6mSH?=
 =?us-ascii?Q?DoM4toBQKUWudXHzcu4NPw+1dfC4DLfjBtFgqiPOG2OXJEJT5dMfAlx5DDYY?=
 =?us-ascii?Q?ysQ3ah3/nwxBgLOUkUIN6NCQ3ZX+i9wpjcmZ7S/n1sl4ETZziMbrfL9M6sra?=
 =?us-ascii?Q?0LYl0z7BLgsJ47CtgdTUGgyOWQmWylhC+FK3q70pIZqnDr1g+3L1EtUxDUEp?=
 =?us-ascii?Q?lp9suwOsAGTPfzGhDBQSRE14QzC++s7L3fJp7xI63k9zgCNKc+QjRcMWEwya?=
 =?us-ascii?Q?3fndiEKabItaeA3sGW+GnE5Nde/sgzKUCbr41KXuhLjSoNXH0RUX+EagXOcF?=
 =?us-ascii?Q?wvjc/TkY6k78P68xEHQluvX9Jc63rYtl3AnEZzej/p5TOXX31mN5phvX5B24?=
 =?us-ascii?Q?FnVBeCW7TafDl6ixcN1hQE3v3wlBQ7xPVWBAfNJbypLK9UmrbgiBrSBtHWOs?=
 =?us-ascii?Q?4a4+xVF41NFPiUYG9Z6SRVAx+n72iocAWisXBPX/c+5v0mWbf5mwYw3myDnh?=
 =?us-ascii?Q?xZ6PP1lSfMBTtow41pxcxY50HVAXFq7ios5QwvAOYuvZOO4mHK8ALaw7xLkI?=
 =?us-ascii?Q?1qJiIV/LJlHg1FFDdmL2Nd7NWYzXeDiVu1pqPFu6q8cXOu5TpoX7aY+uOUCI?=
 =?us-ascii?Q?QC4PsZwsJXSD/PrxCl0ZOgksFTTj8DqHT8bqXiZ4WN1loVGZeQvzoozR+TDZ?=
 =?us-ascii?Q?xtrsW4OLg+dRoT0kSneZ6Sh03bUZwb2x2e/ZLclHgoYgADiodKoEA8UYzqMB?=
 =?us-ascii?Q?HfYcxvObclA69tm8waynPVp4jb8hjFClCBdUSkG73Pw0tOUmY48u693Knvev?=
 =?us-ascii?Q?MC/RWvVe92J9wiKEqZzYEbe6q0ewN44qLeUHCYvWbH9Np7tBebl2Q/1hiOLZ?=
 =?us-ascii?Q?AwbPkRXbVguZymn5vrUcZWA5xiVyGpHJhU/8FHWvEOiCn33BWqY+S6vre2/v?=
 =?us-ascii?Q?NoLALmDH6ILDPIjFSbrkCu3eCJad044xzMDbFvhstfaHhFHnqOmtwNXJfuL7?=
 =?us-ascii?Q?/0dFRru9cbNzkEGS3ck4yFsqFInqidDyQxzdPycyp/ACgAMcBKVLwD8HSXx1?=
 =?us-ascii?Q?xtORKAWacGn4LVOlHPhUNagJ1zEOydpmKY4PdsKgateFkaovN3h6tXqkTylZ?=
 =?us-ascii?Q?Lsfy2P8X365oFqtm5Ms9ACcNyrn93aK0Hflc4zcgzbYGAcGWzoXcGYskebbN?=
 =?us-ascii?Q?i7f1x/7rX2/5OmmpPIf+g0P9ujyMeHLyYD7ex9/cX1MeCOA4WpbfSKgFNuYg?=
 =?us-ascii?Q?6o34ICTaFGZ/9IrU+qSQgWHFIs7MVP/eufX8kDZ6l8Eghtfv5j3eoZtTdwvl?=
 =?us-ascii?Q?aSSUeQ8R8x7HZJouey1gp0zG1FPJRcbrO44B4qFtn6czTvxtsdPjM74ONoy3?=
 =?us-ascii?Q?OPXwsxaUDokMrvByndUjNIHXayx+tObzS7bvplOAuOWUQekvZQWR0Y+oe0o9?=
 =?us-ascii?Q?6QQTnA3XhxUtUo8keXRIeo7+A/7T3N7gUDJhHmkPk6c9C6TCUqMJ7wfvnYz6?=
 =?us-ascii?Q?Smr5fMOXb5lIa+KLaImRfWseKUR+lyRKY1rt7YnduDOePK1rb+4hcq9ZHJC0?=
 =?us-ascii?Q?eEFghG7siWX1cY4z9UU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPU613bfV8drb3kaa+8zbEY0fszCZb8TRKl31oCVFXpQdjLVJgFR8AKBpLJt?=
 =?us-ascii?Q?wJIeMzXLdtYKpCwf+NEVzxveF7b27ekKst8NW9gLVXpQFnQJ6I6ed8dMHULs?=
 =?us-ascii?Q?breSdHEzzAc4iEjK/+EcqIN8nmZWPqIqoL1zGeKZdUYO2rPa6AB9Cexn019L?=
 =?us-ascii?Q?Ac0cmrEihA3IvcxP1BjehKzmGTxvTYffLUeGfd+fAaYv5nSBIsJY7h9iNm2N?=
 =?us-ascii?Q?1e6lmh+HidaaB/KUQa5YWabKwj8nOeW3oSdoUwHdgo+3F7Y5s2kC4FJKc4Q0?=
 =?us-ascii?Q?Ys3jDHrp5fPpHRvpIqmRr+OOyKI0pDYn6o7M/JwPBA4UD7TUTEACf/2ydkX0?=
 =?us-ascii?Q?vchDeJzdvn/RFXuB+9GGdphKqPE+pq3XcbBkD69QQYLu0oH9dpm6VV3uVxxw?=
 =?us-ascii?Q?A9OPPSzF9kVhDo97K0YFy5Nq58mHfEHpLP8Sg4sv09p0eyYN6NaJ7/WMTEJi?=
 =?us-ascii?Q?Uka7LAaYjof/e0zl/V1DCVSvwUUT8QqI16nhlpaKRnVV1Aj6voFcEp78b0C1?=
 =?us-ascii?Q?7yJVPHobFAn4gHYjYXcaITBgH9oZQZMlK9Bg6HWItoWUQQ9mIYtlunnk2pud?=
 =?us-ascii?Q?pjyZGnfYgJJm8FN0eQ2nSwnd1siVWBegIUX+qVQqfcCqB7wwgWW+mlPz1Hxc?=
 =?us-ascii?Q?WIe3EI/ujIGcFaVZ5EqSqIoxh8GH5zULBHtbgDYTGi3NTXaDN6iFZwoOVnpW?=
 =?us-ascii?Q?IU6Rz8dqwFV01Ws8fGNLDO+2CeXcCajEZBpc41eGu5fZrBX4LNr9yWDBCvY/?=
 =?us-ascii?Q?R9YLXl4bSWQSFBaQIIA9L2BV50kFf+RAq+gXucThpfdU3gaU1z9FzkhTMdZb?=
 =?us-ascii?Q?KPgcg89dhTBecnYImU4CLnHUn3jaAsnozLbXdHvwuWvkoYzSZ6PJ7aPS1rnu?=
 =?us-ascii?Q?6+J9HxT1e7Rg2FMb/vvvyad1TDmc40ZEUmNxxqExeFq/LqwT4lYV3eQcm+6H?=
 =?us-ascii?Q?OV5ouwoRvjzFhtoI8TyiefgVwcJ87OOd02oJsnuebGvxBX2mH2c9v1Ajs55z?=
 =?us-ascii?Q?PjKirIf1Ob67gYc/fWdz5hcrReGD48esn29pm6z9tjp/BxsRevrBWsbYR8gb?=
 =?us-ascii?Q?uy9V1rK2DUiXRl2nJE85XNFtT2Iz8e4XD8H+y/Vg5MTYfKyCaEacIDxKVHGW?=
 =?us-ascii?Q?Ulb3rtficbFLSHJy9k0iSatU9g8Nk4o+LojN/wezUPpBb3Iu5Wlp49ODrp66?=
 =?us-ascii?Q?QOBu6/NdWu9rQkVRsSuuFq++X7VcCQyDVFdtXHntwDIXNYGWQ2JKkW0SEQAP?=
 =?us-ascii?Q?I8OWlMBmzEYgpAg5EjrUahJl9W9XkqRhQZQkGmcIdY+EjNDB1fro1XvftWxI?=
 =?us-ascii?Q?lIMWj+LG70enfWurhhO4QXUEXt2msCpwDNEtWJSkfRsuh5ZUBIwvnpph+BPo?=
 =?us-ascii?Q?Exp5fez0btgqv3Xj8waKtW4xP/vz5XRj91AfbsNEPaqNO2J5wdy2Z4HDVpbr?=
 =?us-ascii?Q?JoQ8oqxCgNGhSD5HHdtbHGkS1xL11mUigLWq59b9WyntAybOf01eI4kd/qzY?=
 =?us-ascii?Q?OTPUwPr0oKQfOkPEzCFgL6VCfO/zXg5mQFI+Sye7191OO/DByBd1dZa24yV6?=
 =?us-ascii?Q?9/c8DimVf8DSZZUIsiXrZWdLXkCSd5ewpLVeXKkDuyD3chKFT53TwEb0ToN5?=
 =?us-ascii?Q?Q1JsT7ico8ex3ctMMhQxvpNoS5QZxf9Oaw6kpQKehdj3bTyHButMLH92X0qh?=
 =?us-ascii?Q?2ILUwMVZDoO44nPF9aiwq+cxX0p8cDwKla5JsUbHZc48TOVQamFkHebIJTCY?=
 =?us-ascii?Q?ReLPGRwCcW00D1zYkejNfDySSDepVSY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2911e02-ca8e-4284-5601-08de72fd23a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 17:01:08.5448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /62fTle0Egb7JI2dgwho+uQSbivPdgLqT8eJGu8Hk266eS5Dz56O9cPVmt9xwslIrWbpOb/SzyBvsXLREWPF/BS+zWPg63eZtYB+7uoIz6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
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

On Mon, Feb 23, 2026 at 04:56:03PM +0100, David Marchand wrote:
> Similarly to commit f67f76e6bbfd ("test/eal: remove PCI probing for
> recursive calls"), let's disable PCI probing in vdev tests as it
> triggers false positive failures in GHA.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/test_eal_flags.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
> index bebddf1c98..06a605cce1 100644
> --- a/app/test/test_eal_flags.c
> +++ b/app/test/test_eal_flags.c
> @@ -422,17 +422,17 @@ test_invalid_vdev_flag(void)
>  
>  	/* Test with invalid vdev option */
>  	const char *vdevinval[] = {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs, vdev, "eth_dummy"};
> +				bus_debug_logs, no_pci, vdev, "eth_dummy"};
>  
>  	/* Test with valid vdev option */
>  	const char *vdevval1[] = {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs,	vdev, "net_ring0"};
> +				bus_debug_logs,	no_pci, vdev, "net_ring0"};
>  
>  	const char *vdevval2[] = {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs, vdev, "net_ring0,args=test"};
> +				bus_debug_logs, no_pci, vdev, "net_ring0,args=test"};
>  
>  	const char *vdevval3[] = {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs, vdev, "net_ring0,nodeaction=r1:0:CREATE"};
> +				bus_debug_logs, no_pci, vdev, "net_ring0,nodeaction=r1:0:CREATE"};
>  
>  	if (launch_proc(vdevinval) == 0) {
>  		printf("Error (line %d) - process did run ok with invalid vdev parameter\n",
> -- 
> 2.53.0
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

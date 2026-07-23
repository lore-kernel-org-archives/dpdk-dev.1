Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F28C531D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8E8740679;
	Thu, 23 Jul 2026 16:39:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 15DE840663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 16:39:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784817557; x=1816353557;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SyquO3FLbnsplZVmjnPm06fofGaltQJz/oNDcGW+6YQ=;
 b=EnE4XFy2VfKgGxRsJCGpew2nR/M2uhZb046ZmtcAt07dXFkMEQZ3q9QU
 h/mWhfdOODcugb4TBxQIO3sDAAFwyjTBcCVFxIiDA27Iinvs547ETohy9
 mOj3jHUtbCmtHg3vd4Q1WPJK7K7vrtBizDeswiC4hTUOUV7YcgkhkdF7l
 vloKg7JNlOXs6MI78FmfewqQwYBFEs7jIMVQBaM9nW0ob3QUfG5iKdU/E
 8C2bDvw8UNT+VKbza97nsZ+zzBPadmqup8DScAFNjtcN9FV6YvhijLxiw
 F1n+ZAlhkpRjjYgVK8xm/i40DBAfiGusZFIbVvk3NJPAS2buVe8T6ZDIx w==;
X-CSE-ConnectionGUID: NWiMTJ4wStiQKK2hEh2cGA==
X-CSE-MsgGUID: wgNQ2sJ2ThiOQA3X2LYJGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96131770"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96131770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 07:39:16 -0700
X-CSE-ConnectionGUID: cf6KnW9hTFeYjoTM3aWk4A==
X-CSE-MsgGUID: ijb9jIVNQfqUDgEr2RklnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="257896000"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 07:39:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 07:39:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 07:39:15 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 07:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1meB6Jzz1qzNuTDcdfYJhPfNfdTpFoviB3FnJBfDwg4UeJsr20MpG3czBxfvb0yjQGK5nvrJiN2mS3wgkvbWUOH2kGk8wCUfWy5jCkOc4e82RPq68o8fso0sKLqa9Ao/VyhL6c+ZDJ5lBh8gKM2G1BripSoRvG4uWHAXdvDB3elAq1XHTAtjRmemmslNLn+Kmv8ObqP8lo4lTVpkzET0RngP/ZclPd1PMnVVzUSdstjkuMS/4a2eN3ikTdEBFPXvF11IOzOyPt2Z1HVPJVpd6DQFeHcyOlhdcXLIkpqDWCatE0j4x9BfJSZhdsslYCRi7/HyyEOm2lw+iIakQlK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQVzf4AV/LFEFiNDh9E/s8bg/qMLebtJZdX7T74+vcU=;
 b=f0rDF3U1KABY9MQwX62rA1bRxrVAO8tKvR8rsOIvC+7O4GQx+RAaxeGSdCamtnjdITMBUbnwIZVF1P9ZcCrH49DIUvV+h2tRjF+VsMnIjbe3pcUUJ3uCy5FWWRjTDwemOA4k2EClEcN1M2c/7qRIh6N47vvlPOXKjX8OyY1SuAsxhTRN2Q8kTTyRtxgA8UOm6FLhy7mmWtEhDZVcrZt5JiUO7dTz7ocdr9zx4JViZD4dahLefqLckpY+loGokaaA+1dc1uLRwDE8eAS/sw/sIgFSSCTUEAUYWUJCio2KynsT1lVkzVfmGAA+i2TXZXrAVGPu8dG84i2fHy98smq66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 14:39:03 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:39:01 +0000
Date: Thu, 23 Jul 2026 15:38:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "hkalra@marvell.com" <hkalra@marvell.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: Re: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
Message-ID: <amIngBPWflvFJeY6@bricha3-mobl1.ger.corp.intel.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260723131908.3313223-2-david.marchand@redhat.com>
 <amIYn1U_a0WmjMSs@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wqcNPWffRmFLcUNcSL4KD3T0v5v-kjLX886BqFiV4XWQ@mail.gmail.com>
 <1ece3c764a64471ab966dd324bc19d76@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ece3c764a64471ab966dd324bc19d76@huawei.com>
X-ClientProxiedBy: DUZPR01CA0130.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::25) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: f76ea82c-a5f3-4237-72cc-08dee8c82298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: a1CpNWXanLi1sxp1DL/MkUnkjAaUS7sChcXCbEm3fkQgCUVbsDiCNnY12wRSWa7dZnMSdibfR9VG6LuSvdl35QRQ1DPYr+SV+GVJob+j0UjgAbpIDrIFokWWT6jwaNRVIcJLgYmEVPIqz7ZioDH6DVst6y4pnJTmuv76fw788pcR18iHVOoNOJ51tAk4zfAY5L23fE/OYn5qfHvig3vaAt15A/rlXUHcdzutP2zaHslnC8QEp0be4i/n7ijlhirCRvcD1fDq/Gum9nuRXpiGwDAJWAIUtF0EYVx2AFBoQEBjaP5FnN/IeJR4V+ClYhvODEKestl8BnneKHL0FfxQjx2PLx3Tj1plN/HhJ9MkBrViOcbVGqOuS1LFU0k2gXJTRhrgQ3kugCeZYbmrjEEbjVy58SAxf9o0xbBKzgEaG1AnEs93wXew8qV3pRvOoAOhc626S3KiXr2Py0MlXiI3pY9+yCPlq1cvv0ByLPbCuoBxsYBT8hoYVQxT9A6qmdJc9vhSV/KlEpVAVJKPcJ2cJqaVVMv0ks3r2nQNeBb59cxey33DOliGHIMzHoGsGW2XDF7AcxicUApy6bJMUbSYo93+Da/00IGI0PoPCesw3+EpQSsLTogn36Ssrteam0EA368j1GzR9Il3sWp+CxNiE7gGcvn4EiLv5u9640ka8GE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kwsN0P1ilAzYzUfMy0vIzfniOj+Vv7fic5z5kxvcYDYx5Y0qZVM2881YO/7l?=
 =?us-ascii?Q?lswgu7bb7fcrernyvAco+GB9MCtSDB+WmAS/G3vsJtrFBcCyz/F+9+A0qR7u?=
 =?us-ascii?Q?0UhG8QIILcHLbyINdceqxAexHt7qUMpTfDLBlm3g3VIdkwlL6jNKeSrLmibQ?=
 =?us-ascii?Q?pzZ1M9UEp+z5XHiJnCkGOMUmHyAvMA3+CgCD3hHAr3W8FjH+1ttlM8+/5cx3?=
 =?us-ascii?Q?wiP89o2546rBuc4nD0oA5dPVtqNqyQv2Dqo+UR5MQbuyRPVnd2WJmY6C+WiZ?=
 =?us-ascii?Q?fnqSlNT8kXMAFTU1uDMfOT4A6BEmjZ358hP8mYgKe0L5Y4TwncI9tqBr7+P9?=
 =?us-ascii?Q?DNkB8VucTrdP0KN2ZInMMf0YcVyr2QIODakdkaeK8k91IIrfgoS6rtny0UjK?=
 =?us-ascii?Q?Ps8UhKz4UEW6/LmgOclRGDEkg1pFnCLnJfiTZtbGCL6DwPISvzdI5YMXMZ1B?=
 =?us-ascii?Q?cT6yjfGMU0bmNRoiVHvw5ecFUdwKgkXxPP8SIh6YyUdCeJ0vHn/PF7E8i8AA?=
 =?us-ascii?Q?sg85vGHIjyyXhU8fF79dtXtKPAVSzkoqGvKn6R7rBN0LPdaS4pRRZwZ1r5+M?=
 =?us-ascii?Q?hv/EKc7zXWI1SSvM7iVFFTfhDHVXIdmg70zS+NQyMjSHb3p1UGCXhhqDYQwa?=
 =?us-ascii?Q?FxFwEZX8xUVNyHTjZLXWO2a5NVJaP3xoUbl/B/+nD8eog/pIDMI2qGo1KgbC?=
 =?us-ascii?Q?b0+oFdCxjBcUGlnMg8mbJGI2lJ2vNz8nH589IA6TaSCQg6Qg+pHaqjhS0zJC?=
 =?us-ascii?Q?gM3uOLDIVGlJiYMEoNVQxfufzrH3VDpfS+In1X5occBUjuEuXBrxAxJ1LYZd?=
 =?us-ascii?Q?1nj1UF6jOlC52BVlVLEffXT0sWopcW8OYoVY4Q0vWetGti4kwJ1fmC8NKUjl?=
 =?us-ascii?Q?zVT/X56PxnY6vAvaBGPV7M/G7uuUHC8aEUm5vx112RqVzsDm8UX+M05yZK9Z?=
 =?us-ascii?Q?KZO/a1apZwTa21TNmpzcsTGZKJ+bxKdcelx2kONE6vXLNGcS/qgG0R5ic5xb?=
 =?us-ascii?Q?iEhn5sWwESSQEBedF+A0UsSpuXmBhdD03DKwh0MGrtMFGX0WCeoNMsdtegxw?=
 =?us-ascii?Q?p3ACDfD9l7Q+Esk8yrNHA85mqaCmiAVZK0t8q9C7fnlf+YvWJ3ax431ilzQY?=
 =?us-ascii?Q?Ut2GBZ6Z/47q+P1YfuvOwstTMNAOwUboH8V4YlMq85Z90wiOXgLfJ5EVPjsq?=
 =?us-ascii?Q?q8UeypeC8gCWz4rAsH7PRz0Th+ZnFVjxJv+8o+ghpluMgkeDNKYOyML0cxR6?=
 =?us-ascii?Q?st4+MsG7VMuNeqAO1gbZIdurLlrSAmvah76ldHojDWjcu30nbrlyQPVeT+aG?=
 =?us-ascii?Q?OEhCtV8WFfYgfmvpdXk3OqH9b0g50WZ8U3gR5UfUMxHBpZN9sByR45xBLPLN?=
 =?us-ascii?Q?RGmkmCeHwZ565QayL49VUROAbDy/YPC+Y8op6FK4AvVcQo7fep8PUJRBhl0B?=
 =?us-ascii?Q?DIltN/72yZGueyJLC2aUBFePHpCccST3sE3OCLe3CtaCavoF8RfBuhRvtP0K?=
 =?us-ascii?Q?jFTCPnBql3YZ+rxtd10EwLTUsXyR3AWJEh78blukjZasCe0yAWqYohuLgGJM?=
 =?us-ascii?Q?ymzn5tfYNbYPIDLZD5gXgwnUBXWNIROq1JrxtH9Pvv2AAU7qvCBQ+199qGbl?=
 =?us-ascii?Q?D6NwoYBbQk3A+w7E/CG56hpAur5ddzmAHq+cFsOeZqVNmqg4DkMl1bH73/0u?=
 =?us-ascii?Q?6y2YSDk401spCRxvBqLNxR06QimBYeQYYLX1L49GMsnSuZpYUc41lvf1yX7r?=
 =?us-ascii?Q?O8VzFRvpFSTXCOy8KOqtWLD2KfLEOGc=3D?=
X-Exchange-RoutingPolicyChecked: W1M1dPjLJWXk5Ax5s/BUxS8ltq2UkiCglJ1phLaMkTveZeIII8b6y46hbxfp1dFcoKTnbP3rVV8ximvaZfpRPj00GZdooRPjHy9keVLPivKX/fFaBD8NpChhzCx79UprViqTrOrJpNeWdZKkA/HNbqG1JZHc+1rUqvF1y4KHYXAokH2sVF2SfKLokvzoudeKPO3/hw2M46wznhtsdNQFzK7fkMC1oWaEvGVfoVFZMM863rvjmzODzVfEViuQiCWBGmP+z5Ic7r/FIm/CefbmE810u3NnAYWcxAR4ercMxzG3dRc+ia6zdL8I/nDoVvK2+RS8TgvDzPGN22Q98qbM7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f76ea82c-a5f3-4237-72cc-08dee8c82298
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:39:00.6846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm1oM0kxvC/Vf0ne1RLm5v9cuKd7azG0ZzR+Wy21v0O/RTd801q6u3kqoGLTkBF9irVz8uIgyMiSwYsxJMyk9BOy6lj8K30LXH0IIp8gxwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
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

On Thu, Jul 23, 2026 at 02:31:23PM +0000, Marat Khalili wrote:
> > > > --- a/drivers/bus/pci/bsd/pci.c
> > > > +++ b/drivers/bus/pci/bsd/pci.c
> > > > @@ -93,7 +93,7 @@ pci_uio_free_resource(struct rte_pci_device *dev,
> > > >  {
> > > >       rte_free(uio_res);
> > > >
> > > > -     if (rte_intr_fd_get(dev->intr_handle)) {
> > > > +     if (rte_intr_fd_get(dev->intr_handle) >= 0) {
> > > >               close(rte_intr_fd_get(dev->intr_handle));
> > > >               rte_intr_fd_set(dev->intr_handle, -1);
> > > >               rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
> > >
> > > Unlikely that we actually have fd as 0 for this call, but change is
> > > technically correct.
> > 
> > Yes, this is why I did not Cc: stable.
> > Thanks.
> 
> Just trying to understand what's going on here out of curiosity.
> 
> Zero fd is valid and negative (typically -1) indicating error is a standard
> logic in Linux, but here intr_handle->fd is zero-filled by
> rte_intr_instance_alloc, so its initial state is 0 instead of -1. Do we have
> reasons to believe that something always sets fd to non-zero value before
> pci_uio_free_resource is called? Should rte_intr_instance_alloc set it to -1?

I believe that's what patch 3 of this set does, initializing each to -1.
Perhaps that patch should appear before this one in the set, to avoid the
possibility of temporary breakage.

/Bruce

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E5CD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 13:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C222F402A7;
	Thu,  7 May 2026 15:11:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8A3B040265;
 Thu,  7 May 2026 15:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778159489; x=1809695489;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=e9lfmWwXO1adxp796MioN5xl1Bw1yiOGqe1PfgPfXVw=;
 b=LP080D5sE6LLrVF/b9Y4qaV0LPDuS/QkfVqYxjJ4M1i18l7DOA85HnQ1
 E6Gi2x9/6ewX7j1YIhiMUNzv8Bi5RUOs+XT4u1LiPnVR+o7M+MVxsT4Nc
 PNWCUF/6pp6xn335MlYutVXzoeetqxf7eFt8YlFhS8raSaNndbfrkkbKS
 5p17H3L2W2m469Y/FjuY1BfZGzPesvw5I8AnjGqdaa6q4aG9XyDEQxu3E
 7sE1iod4eQWxywHfJw6hnbeBRpk02lfeuXjZC2MC4l9O9liJGZV//4O9N
 4g+gwd3FBBmuLbdDOmqdQTohpbjihIKSpccrctos0rlAebkqz0/wSlG/r Q==;
X-CSE-ConnectionGUID: zzuMairhQ8usQIO5bTP29g==
X-CSE-MsgGUID: O7Sr4qAiTx+fDlFdt6IiKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79099549"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79099549"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:11:27 -0700
X-CSE-ConnectionGUID: lfrcCWw4SduECgY0FsV8iQ==
X-CSE-MsgGUID: RlCrgIIoSfKVh9ZFiqi58w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="236375629"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:11:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:11:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 06:11:27 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aff3J6qBmzGLPkhcSeylmHDvFibPdFr/Zi53wZ26ipKEuzY6D/jqrsiq89AFwJCKjq5B478oGgkspPdpNUdy+bpWYTGABdrSUqbisIbFm7UqY5H2izEGVY9s2WbK7M7vqlAr1QKX5cTxZ+88nOxjPUAWoAlbs8IaDeyOnEsH6H9dZ6CxND0AOd2zGzd/5uiyR/XULKwVOom0N7qcTC8WwMAkM9woMJgvih5URFpTbA073Xq5XQQkBcr3gQHUGW0zo2GeNobsAuOEucGHw8Tl6lkRHNjVgf/1TB4bvYVZGT7WjVZW0F3M9lkFMTByMvnEIGzfdyEuujHnsNS048rKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra+HcsK+z3fZCq9PidiX+ftFi4iMliNCGLouHN4iuow=;
 b=AMC0GSPGMm3XnXJcrP2D049DP4rcnQoBgS7Hbt8f93Mm8tkdf9iOjZc5GlR87NJMkqeAh96qnrfWpfNE42a21cpuxnNnPHC5VOuswk5jgUy40QzO5+Jw38dFCSb3yTw1W4ciDy1SrCJ4dVtrAJmrCjrxWxLjNax06AB4N3EuI9pn4rLn55JW+xm9xNLAnEXJCeSyxQvanw0OSbb8Z/H4gkYx6LwB/UPMW1nWUKzleIoGGTE2BvAr3hgcgZL+7s32qxzjiBHXT9IkvSaau4bSjlRCtQQKMhiCt2ZKQXWPqQ9lRMgehpJM1Adq85Cg0n9/qBM1pXd7aj9jozf3YTFM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH2PR11MB8836.namprd11.prod.outlook.com (2603:10b6:610:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 13:11:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 13:11:22 +0000
Date: Thu, 7 May 2026 14:11:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, Mukul Katiyar <mukul@versa-networks.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/ice: properly handle TM hierarchy deletion
Message-ID: <afyPdAwI6_ClTYFK@bricha3-mobl1.ger.corp.intel.com>
References: <20260507125930.1668860-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260507125930.1668860-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH2PR11MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9ffe1f-f172-4c71-f5f8-08deac3a226b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HRQ9IBwPY8HGkwqblSs4kSsxE5HoYugFRacZ42aNHug6ZJOVuaij/vxRaS0vIfO0u2J8clJ6jLmaeYQE0S1KPUCNxB/hmTMq8ZTwHTFqI6oihE9rsiyJPRfsihLLEHAygYu2bGWbgpPt0ZaX0nB071KSJArzO9l0fTHRwuu3yCRgAT0Fop9gEy9aEO4ySW39+mzXRvksdzTpBMA3ed5wjhMakCX4OJN+jjcbO0j9B8k2FJ0OkzbV56PY5t3ggKNvzHMS5zHm6NtpCZOSjLy3YwsBkRbmUMEUluGIIdJc4isslGqAadqMA12U3L6PzNW8bdcaVJdJRDSlgLrw7CB94CjO2b9C8P25awwAiepAxCq1QX464agkRFOsxqf9uX8z2pJwHYoYN9d1dVYKfCLkckRriphmdRKa4TK2npPSoCziuDbX1kWFPkhYOTSTJdlIKmtzxWhE+BJLTNNkokWbQlq6rp6Pv/kHCx2KaBseQ1H/jS1lg8yhAtcE72mTHwDjcgE8r0AG3vJhkZVmZj39186KPHEnbIZuJa941cbiM6CvnuS+1wbI9+9gF+1XuvCjkl8ba1VzwMyShxAJkoe3/tX5WKlijSE/BbKud3bqupNPR9UX2sX9giskMKUG4Hh2pdeYCuranCyNFSzqJ6k/NmZaS4qCeuOoZzYoUrTwh+6kTZDilh0IAVnNwq8vabab
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlJ1wWs/ah2D7AXB/FB7mXJfEEz3zgtTCc9CppsQ0PvZurGircZ4dsuEBro5?=
 =?us-ascii?Q?+Z4LQp+r6ZImPqtTLDlolDQ575zRkCCpOC9SKemST/1ZMuvcVJs25VTdRuLh?=
 =?us-ascii?Q?UPCu39uRxzh2XP6lB7Y3h8YVIGS2//+nLGOlKg3tFg6W0Y23gWa9ZsWt8OXy?=
 =?us-ascii?Q?b125JcFp0/1mCy5zHfT+96PTZGGI9fgmX8QfSTr65OvE7/qzpRvAGPwo8LRc?=
 =?us-ascii?Q?qR1HS7vVeOO6GYOYKL0oYbYXyBwDDBbVJl+QCrc7jSL6wU7qmi5MYjcijN8W?=
 =?us-ascii?Q?7AW5fgX8QUtVtqVGcBK4fH+TwYvYRYVnAO6w2olPj/SIb7irQmnjI7CqBSxg?=
 =?us-ascii?Q?/qpQGONzrWpSGmTCc1FbKkx85UiwYX3vy+jKG0mRX4Qr1LeSnUZUqYDrZj0Z?=
 =?us-ascii?Q?OUDv37pcQ72UYNRmZRVl09yjih+U9xoOoRWZp4/S7EOpm1S+Y36eG+RVr9pX?=
 =?us-ascii?Q?zf1s/eWy43lTtQj4FLZI493E8dl3vWEYyte6VBTDx31ks6cxU/4rGPl7jfsb?=
 =?us-ascii?Q?VqLhoW62s+OoDhCoer2aiwHRg3elU2Vxw+asDd9cfh37etkovhbJdKz86L2a?=
 =?us-ascii?Q?l3UP2affPqN3iNyAmTqdXt/kBDrV8r0Wa+gGK0wcP94j9HzeFsZbIbE0lUed?=
 =?us-ascii?Q?AXyilPmMwIpjDR+DV4ZUv7DBL1tSi8aarXQ0FHqkycAYC+PxviSg5crHgilW?=
 =?us-ascii?Q?q21yC2piLkOOPpyoU9WmJUoE6ByYDw1WirTl151E2UiQRM2PzkAaXrX+W/IJ?=
 =?us-ascii?Q?kydiPVTeTkNvctMJ2dMrdY00dOaILHjnBgeT3INYTl6MSoPuz8hyRBz0SVXh?=
 =?us-ascii?Q?YN3dRokBE5Q2yG+IEbYjCmvvf1seTil/f9xkmyUrOrhYk7eKnwJjedyUmTOf?=
 =?us-ascii?Q?7rSRkxKLC4clH5VgsdFeb9VdGdH97hXyRkjJ1NLs4gmYlbCIaxnWmYXL9cJI?=
 =?us-ascii?Q?WDcmPalvGXqaERBRrj0eCZkdMTctATZr56KFpB/11QUdtoso4X4Ug9xnQ1yq?=
 =?us-ascii?Q?qp2QscwRNZuLgENrilIvScdy4L6kpJRHlqqVhdaunXdQRjJhyBSPDIsNxyLE?=
 =?us-ascii?Q?VwaCleOwObZ48aWR+mAX+EltLmD6/KEfFyf4L8e3lWGirct1t6/m+kUOV1Zp?=
 =?us-ascii?Q?8Mmso8ULBBq2r06sqMMSaJ6mSGxV35WzwfauHefjQxtViUvtgdozJPzYfitG?=
 =?us-ascii?Q?ZDP9daI/MfTrgUhtAE2tpV8IZkg5QmrJbr/bq2gvl/Le/PK2wYZTsKyQnVEv?=
 =?us-ascii?Q?xsU8Oyj2Ciiax/s7S2SeuCYJTWKKCMbhRiX/r7Uk0sqd9/nPZGul26flqL+O?=
 =?us-ascii?Q?/eI7Ytevz/ljTaToSs0bpYdmvDJsi1ha7jHq4nS5h1toP4ZObK2o94cZIrYw?=
 =?us-ascii?Q?lHK5vRSxz3MlQY8YqJJRw79ssYp7mh0cSkBFbUqteAGfekhCoMPPXxV0gpK6?=
 =?us-ascii?Q?cDcNWSwBXuucaVjm31CxQ5sDntnriDlMtFTG5ZhQ09zh4RKe4KUNuA/KrmdH?=
 =?us-ascii?Q?iU4k3XIdgNbjZWx1O4jM/SNEh3xw5Y1EyQ+drISfnezcERHaAYV3zpZRms5P?=
 =?us-ascii?Q?vk/FN5ewtXfvS9X49j9x7I1X3FMUOTcCXG1NJSvFYnNXaCj+IYJC5PydPXVq?=
 =?us-ascii?Q?Z50Iycs0QLjs5dbsXKqyD5L9bPeQeK49fLT99SV2Ho4oyZSE1OirYeZlnjKX?=
 =?us-ascii?Q?TqZtKUbNpos6iG4tzWFq7ucm0CjqHV2QX5OM925qw2SqrXDuCANZ4Le1xi7M?=
 =?us-ascii?Q?avK99nMwttzCXudibNnoYZK+AMSCvDo=3D?=
X-Exchange-RoutingPolicyChecked: UlG7socVyearKcwtMCjIF45xdxdVouagT7JigG2r0pOBdOwYHvC33sPMZj3HxsDOIe3iExYFwNkfg7BIuC8X0H9NhjyybI7cba056K9T3EgC7HSWzoKDBNwl0AdcocjFt6LAwnEfEYzbbVXCjSx2j8dJGn2lluccaP62TaoJrGUTHY1KosybSxE/0ak8fm/aRWUOP0EdcL/uCIwgWR9e8gsE7be5fugEu7+W+31CCtIVpOVAfF4eG4RRs7tOA3UDuPpjc1xzJgescMdjinYLUYv5Jk6183R7Lz7cye3xh0Il5Rdy4dVxgcE2mG3EMCwrncbcEn4IPSmdiK7+ooowtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9ffe1f-f172-4c71-f5f8-08deac3a226b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:11:22.0477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5q/HIwq9K1bYZPhqTQfJ9Zfjt6GRfz230eW+JKaJuCU0rzXLV88aGjC56/g1nIZLtr0O/VLZEwdKdOQ1HzkUKykQnJ20S638DYS0SCZLxYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8836
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

On Thu, May 07, 2026 at 12:59:29PM +0000, Ciara Loftus wrote:
> From: Mukul Katiyar <mukul@versa-networks.com>
> 
> When a TM hierarchy is fully deleted and then committed, the hardware
> scheduler nodes may be left with any bandwidth limits that were
> programmed by the previous hierarchy commit. These stale limits may
> remain in effect the next time the device starts, permanently throttling
> traffic even though the TM hierarchy was removed.
> 
> Fix this by resetting all descendant hardware scheduler nodes to their
> default state when committing an empty hierarchy. Also restore the port
> queue count to its hardware default and clear the committed flag so the
> port starts cleanly without any TM configuration applied.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mukul Katiyar <mukul@versa-networks.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v2:
> * Ensure restore is only performed if a hierarchy has already been
> committed
> ---
>  .mailmap                       |  1 +
>  drivers/net/intel/ice/ice_tm.c | 24 ++++++++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

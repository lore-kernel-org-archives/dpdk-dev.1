Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BBFED2FD
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 10:01:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C57A640430;
	Thu, 12 Mar 2026 11:01:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5766A402E0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773309665; x=1804845665;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OddXbDlgY+y9uOr22nb1/nkKVI5OtfJ31VgGbhzldQc=;
 b=AkKkCsbWwLQr2F0GvwE/YGdW9jvYge3msM3HF0J6afQX47D1+StP73NN
 808E+tMaFjK8pZl1hXkk3gBK9PfqMGMd2UUAyS/A5rwiB/OwfJ04qmXTU
 SWDhC4SRzAPI+PesmDbgeQb5tmZdCZnnnRAvu8A1jJMNa7eVxsCnVG18J
 VbQW6VLOo3GGJNfAclAqpQqTprd2FK5oUeUVOB2g5VlNaytZKT5RF7Ak0
 n7gwSfepWuURC7h6LCURAqTDZ+M+4iAaVrMvI28jqLO91PYF6+L9L7kLz
 d6Ka2tUEG7D4cX1QYdpNVllitCr0mBfZ7t8K623Zh6DZz8+lWu9gQEPyf g==;
X-CSE-ConnectionGUID: JthOuz7bRpKheGok3xLLNA==
X-CSE-MsgGUID: DIPuHza1QZyXO9AYuvupGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74275435"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="74275435"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 03:00:55 -0700
X-CSE-ConnectionGUID: AyDmlODvT6KXzSsjSlCgDA==
X-CSE-MsgGUID: qt93siVRQNS1XxsXE3b5uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="216910636"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 03:00:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 03:00:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 03:00:54 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 03:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNFXsHvZSUWbUA/AX5DPJ5YszUOWNZj357/aACBKCzyFM22Khl5F4kb0gRjsY4KyItnLb6RpwMAmYyMlPtxHyrR3r54uBrSSRxbemA9K8jSr3OsXiDkTz64NrlWhCjMIdDnhXkIz5id3vNMruElfmfDq+NZAhagMIPszCB3nyYow78BgqDUht3yKscyuxWinE7EKeuoHEIPxucqvFxPnHBX2s+x8GGG6yGpiFnzZjOTk+Un7nNA2OfSK2pm+vqbA5rK2DYGC+lnQTPpTAVVP9NS5vwzd+j3qTlgSYwyus02J+wa1pnKw4XVBHaqhRCtw+NH3SceN/rMazfus8ZSHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0Dha3WzpDPIRHxgR0XkbWzAMdd+wtLwleQDqXKBLAk=;
 b=FvcBxgcKv5xhyo0dphva7Cdb+0r1yO6WpmI5MV7HiYRCb90po5/VyfmeRkYJYYxW8PN3qXrTFEevZM3TSr99cWllGIaofb1X1vnTetjKZZjpPEiQQU7ze7EawfA1z4rLFdtM+HdER7fXfmYfyMpgtdHPQSMU5Zo6eoI9BhIbmao1ky4FjSfZHP2+trzrJ3fJkTEtJyIdmrwxYjO371wtNd+d4fToy22RqZ9RbyidUs+XNZH/wh42wvif7drcD18sQFzDeGMd2C3pxPbHz8BpVwPh/p7AEMaPXq4/jOg5hoWtjlGNr68K0J/4COya2KMA1ydRxXAL4NeLllgM9dR15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8239.namprd11.prod.outlook.com (2603:10b6:610:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Thu, 12 Mar
 2026 10:00:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:00:47 +0000
Date: Thu, 12 Mar 2026 10:00:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>, <rajesh3.kumar@intel.com>
Subject: Re: [PATCH v1] net/i40e: remove dead ENOENT assignment
Message-ID: <abKOyn7Vl-TmmDMe@bricha3-mobl1.ger.corp.intel.com>
References: <20260312221926.1476679-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312221926.1476679-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB9PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d2eadb-4117-46dd-ca78-08de801e3bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: lFKAFMDa7bdeaJ8lVK6gMzyOc51OsH1lzyzUgl4OeeK0qmt7dKZPSI69RgP0g9odJx8VIBv+Qds8YSq437JlFr6YWLgYfSjRGGza6uAsSeN06NMucmRXiEaCsrULTEe5caE/KBVnudSrkMkBhMVt1U9t6nBFnfHuJ5IqzJwIBllkEAQ8H+VIdJn6Hbrc5QKC1OlWSnb9+/2vLdPgXsE6RCye70oBQBHzFWyQzKDiieoq/x4741X+ozZ9DUDkUBn0jZmMytczTUf+9zVg8rC6hXN4CIVDt6GNQrb+m8XdV87BYCE/O7G0xVpSxSC1YbP8L1xWwFFL2OpgwDjE57MMI28sFHDnseuFmWt7s2H1xcLCM+FGTPrSItEyPtwpnYqbCQNhD0YuEjgld+i3HNCD2qrip7MI80i5GVV7hiu5n6SS62y1FYmgM4AWVtRyD+s2EWFIDw0rSG8qLiZDnOnJi0o8wOXl9vnMxkCZyZHoDw0dObeRuzZy3Q2bCyKC5jC81AoMsQGicBD9flpsUofMiz1cYxiPBAlz75q8rGzrzojf6QAIzbxLIuiv0KyGDhbvRm0rTPJKXSImRe8eRvPQSHKlmCb/GGWZLBkfrjR0TPkpAq8M8jLGbe+vhzO63HQST0kXqRCHfGc326SyUR0m+lSYkUmo8GjmAtPhnunbUCjaUM//LDckKQZfHL6e0bu177jQqhY2U541YarCmoEscZ2hqnQVynvK3t+Cv6Hzr5fimOUbOZIKv0hVOeIWP3TD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EiubBhC7OTuZevQHDwdrjQAxd7HNG3WSROvlSfC/2Z8XW8d8lEefaH1dEENx?=
 =?us-ascii?Q?G0ZIMBK3RXEyXm6FIzjPsU3l/EGQfQzapM2D97dsyiAaK4sbzK2hVaMUlqUG?=
 =?us-ascii?Q?Nj3rE7aSX5yLiodV/we+hvyN4vNwWv1LOXY6JNoYaPETKssaGRR6Rfba3Ypu?=
 =?us-ascii?Q?sAbywJb3R7RQ8CFeIVMdCZ5Guv76mN0JDJLrPdEpvwXEsJ8lHBuiav4MNp3f?=
 =?us-ascii?Q?ufeeOXOqLbj94DjJxAOSs0fedJ8tbE/2k0hPNYBCV892eH2r86gm35Jv+gjY?=
 =?us-ascii?Q?DkAUEbFaMuvnKQ+a2hawXjeUpwYmaByJwkcpNZAnJc+jC0MfIM6TVDBdoI4T?=
 =?us-ascii?Q?1PQsGxwxnfOYom5r435pJC8vPRSZkARAga+r0K7wlndr3XtLTkvPm6hRb10r?=
 =?us-ascii?Q?hqaoFU1K8uvVa/pxG3Iuo1WAay14aQ7hFbfKXVZH1GRMnwwJ4y9nDD+yOQLa?=
 =?us-ascii?Q?48geNG5moU67WshYBKeNPXpJ/qT3nyYf1LomXPHYvynx8w/a8eXwuF0TfxQs?=
 =?us-ascii?Q?g4YFFjcjOv7mIMcDNExTqos/L5hlSsHV2cg11Wbh2cT9R4whBYw+tsw8iYbj?=
 =?us-ascii?Q?YovCeEUIRMXeR1bqHNIixYfQJND9DnhEOMD0K9DJIvq5CebpnsYqJEtKnzP5?=
 =?us-ascii?Q?sYsCD2TZbTUMRqjx9GVcDLniOHPmz/hIohhDqpLdkkjieUIRkJ5v5LCmPS/+?=
 =?us-ascii?Q?fRhvgu/aWBuzzI8dWD7d6eyu6wBRSnI7YsbI1IXri9+noST18ChVpLIXdwlw?=
 =?us-ascii?Q?mySb1fTYLCm8zGs0Hswd1byEWHi8snYvsfnvoNZiA6N0wa7SBoGZsslP+uMv?=
 =?us-ascii?Q?SLz2rbSjEt3vYrQSo5Ui/Skd5G6c/hpLZ7qlwrj1g60/2dR6GaNfQZh7IkHy?=
 =?us-ascii?Q?4hTgfGQpzBrDUapJgejcsQRyRbDbvr+QBlEq/MR0J38n49nKy/wKU0Tjt51e?=
 =?us-ascii?Q?iPIgSymbDrvlG1+AGgqpO2vucJridQKGnz0/5NKUxYmN7lyiZqo9SAsiIQGM?=
 =?us-ascii?Q?PdGqjILLem/ViTG7hwowVDUrZgKs3TbwH6UE2nGCCbJrmx6tO3tO22qqOn2d?=
 =?us-ascii?Q?cAyZShu5/qtz441kpncIIpiAyL4/Op22Jnm4U2ql8ZlXSkQO/u4Tv84wwsD7?=
 =?us-ascii?Q?tMpdIx9wIXTU87VCOUSQfRE5Y9J0eSS+M2MCfWAo1Kg94bIJ/deFGIeF/4iv?=
 =?us-ascii?Q?EKUTmD8wkZiZ9L+FDmaPxUGNOJ8y6OLRDBYVNwZM3twAVqyQtBElTYhwNr9B?=
 =?us-ascii?Q?djutNRyTS05am+CmwM+WS8e7E7k82rqdZ6e3ky9TXgr9SaPyGk6mSttz/qsw?=
 =?us-ascii?Q?fzglzBRQ5NS6m7jbul4O14Mmo13KDtBNzgiyeCx+MCpHkwZ/NM089n903pbb?=
 =?us-ascii?Q?ZJJCQLyr7U3/S1NYH4nYH5BcsGR0NhE1j8zUs3QPNLalYHpPs74u6gCFfanF?=
 =?us-ascii?Q?sBxc3LMbVQYgNaztUZM6GUeRiqoWo/420K57ytdoTuiqpnBhfhi0MEHhMeLD?=
 =?us-ascii?Q?0oKhGa4MqPxRmVFiTh5AnJv0CBd7WjrEB3XZTcQKBayUHC+8TfV7k1cdy8lG?=
 =?us-ascii?Q?bMiEsJ5psdAZcLY95Vyr41PGpJVxY8tclzNIBROp/8ihPGFpPkZSpgJtEchH?=
 =?us-ascii?Q?OAEZfhcNKSWogmAUH5FBL6VnYPJBZ7XlM5ni7N2GGh6r2hxRtzTR0hIXE3P7?=
 =?us-ascii?Q?lXJRlE892jsiqAkIQMqqRX/vCwarz2ue3Pznq4RVynKIqgQkLp0uf8Knm8MP?=
 =?us-ascii?Q?G1LxRKs+FJOuniWNXcn+RCT2UJQY0K0=3D?=
X-Exchange-RoutingPolicyChecked: SgzYiyWsmBf4qFE8C3eEjCz03vb1OJbMML1EGvnzu8vChi0wRXrnMfDExvcm6fmd5YDRjxpwACxtWFcvxdjBzNKk9HXh3mK+NE0IEI0LRJGBHXOgAT6i3TjGJZMdkaS4AeJjI2VAGoT+/IYP+2NS+rWQ4hxHDFQ2Au0+J56ssV8j9oostQsQoJhhWgjoRHoryHGCVY4M+37Omixr4GRiwmCW8jdxCfLAzZYa1Ec2ITtdTDCJaPgjd8a1Aym4k9+Qv+770WvwzbIoWNOgRtOtmnrnEcGqIqyoFj4XO09MqeOkilD0IkjWAvA7Chohz45+S0s8FE1g1L+ARO/v1i1xpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d2eadb-4117-46dd-ca78-08de801e3bb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:00:47.4305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMAFqCMriAHj9FHc3iEypQlZCbIquyxX510hPGLZhgLlDRKGYEfEtOXdb728ioQQf/0nnJR7sc0nZCq87YALdgdxUmdScUZ+szlbElIMjdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8239
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

On Thu, Mar 12, 2026 at 06:19:26PM -0400, Soumyadeep Hore wrote:
> Ignore ENOENT from firmware without rewriting the return value.
> 
> The previous code assigned I40E_SUCCESS to ret in the ENOENT case,
> but that value was never consumed before the next iteration or the
> function return path.
> 
> Replace the positive ENOENT branch with a negative check so the
> control flow stays the same without the unused assignment.
> 
> Coverity issue: 501831
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
Duplicate of patch [1].

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20260311161955.1833722-1-john.mcnamara@intel.com/

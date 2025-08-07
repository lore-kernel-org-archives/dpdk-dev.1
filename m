Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280E6C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 14:43:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 638C04042E;
	Thu,  7 Aug 2025 16:43:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4223640270;
 Thu,  7 Aug 2025 16:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754577821; x=1786113821;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u/xaowGZJ3nNfIb+IoynH9egm1/XYyjnq39gmWm+Rzc=;
 b=FnCBYcnzqMprVXlPu6oEhChqKhPfzNZ1E1WlFFV00H+XTOK7RkOmR/pg
 0pdWnvekryMdp9Ay5ULQNwe+XF8mcdKBoQKk3dziWL6R5rU0/3ybXud67
 gqSbNvjOg4UGjbaxT7Y8xVCWEIMLJZ1nhUIcNs1nIEHLCbDY+voqZBNhL
 QauRrLTkI23Lo+i7UsMlT6mZXsBLsE0weAxhSxoPaqM547eQNZUxysI7w
 FlaTgMiVkqX5jzUtp+34ARFtZz+3pDwa6dZnFuyfU+aySJZWkxJViELJM
 E7sYE8ee1sQjckUgS965CXT6bOYw3Y8V1AF/BKQdK5EiIkVOxzozSwyQO A==;
X-CSE-ConnectionGUID: 90UMDWM2Ro6hzqJKMzWrLg==
X-CSE-MsgGUID: PWmZbv9QTqC81rhVTBHrog==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60759574"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="60759574"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 07:43:40 -0700
X-CSE-ConnectionGUID: nxh6UrGiTM2z85DdWNdVxQ==
X-CSE-MsgGUID: NsiU+jpYSpS6BSFMKVqlFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="165435929"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 07:43:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 07:43:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 07:43:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 07:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGJUeM6neqPENoaatmSk3KGQsU02+1t6iM68L2gCBjhSIsxDtoK5Z6KsuXFrVZkVbqEUVJvaJZfBNHp1AxqbWNe8kfK1KdwLC0A/n/wNV0lk0rL+3f7mxPpg3xf/sA4JSgk9U8ljDGf+iyIq6057CIlsgpVeeM47ciYI6fPzuoxl/7Dl2CMJHvqtCKmPsGNmgEjYPPisVfCjV7VL8TAJQI8bcB/TvK9LHvsv+W2H5AfW2MhSjTQj/+LCy4H9y8fkgBoJYyNzoULTwOCM3MWykWhVt0RSyGAiv251BAX8K3NFZe6S/pnzIXZ7GH+vzhLd3oh0SdAD3WMm5uN1ZZzTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZkoFykeMfrS6dr4UBNFWA0UxdcCb1x3PLSXa6x75QY=;
 b=RdF6VCKla7WvRtYK34A4HYLhy42fVLkN7D5wIUI83iuI/H8SdizaV7Xh9k1zmiIfPbXT75Nex05+kkos0fHTiLRwkIaySDxBaRN4pPhEC7W0T1bStV3Ht+tkDqRgmZ9TODBqTowt43MwhivS2xx0hEPQMAhUWHrHNAO386pXuJO44nRYVx0I+lQToHr2tOnJq1GG3ej7ZgwgCHvF/H+N/890TQFZl4UZgb48I31PthtI5DbavKVjuQbF9qg+DPfSr/UvJIm8TMXRW8RjC8uo95pDoKtwCN87Hcy4gFvFxTJNYA+PPO0JHZ+aEqsG3g3NmRJbwAWZSbhC4exC14FERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 14:43:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 14:43:36 +0000
Date: Thu, 7 Aug 2025 15:43:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yuan Wang <yuanx.wang@intel.com>
CC: <anatoly.burakov@intel.com>, <vladimir.medvedkin@intel.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix SCTP port support on E610
Message-ID: <aJS7kySPEL1-ksp5@bricha3-mobl1.ger.corp.intel.com>
References: <20250718085335.648078-1-yuanx.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250718085335.648078-1-yuanx.wang@intel.com>
X-ClientProxiedBy: DB6PR0301CA0069.eurprd03.prod.outlook.com
 (2603:10a6:6:30::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: f17d22be-2616-4ba8-3bed-08ddd5c0ca9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6B82Fnco0L5zcSMPnw+W4vd2JKS7oIVb8u65vDbPeUw5IwYRKjlb2DpEFq3j?=
 =?us-ascii?Q?rNDv60jViLNktw6G8jJuOZQoIS2PDtIp+l0kOlFxxM8kZvLdTg/AHKO/JQ0l?=
 =?us-ascii?Q?mMUJxg1CsVuK6n+Do0hH1AA4V0GoOmKCMbxiwZohjZgDhxApmSQki4vPpiLT?=
 =?us-ascii?Q?3lIrxo9uH4WJ4t0Ww+7vtK5ygFvh5rNhSlZwPgX4DiAMlBDuBkLEJQmQjsG+?=
 =?us-ascii?Q?p0wQkj7MWFHLWQm8gvsK/WV0C753YwagTgklv1b+OuHJvXFnzRu0t7YI5PLg?=
 =?us-ascii?Q?HWY+K+0NoHaW9Ege+iN3xtrnQL2RG9I0KjevQmAYHwU5DBPkp1KKzKcjeapC?=
 =?us-ascii?Q?dSuX1UVhWPKbzoOhgzSLFGf4/3STz+BLfd69jnrYoDb+P5B02z8/j+OQu2Yg?=
 =?us-ascii?Q?Ens0yQArF/s6WU5ivqoBtTvtHCeG9QTPESz/FEC/J0XrCLEYZ6QQ1B+XQTqD?=
 =?us-ascii?Q?id4nfpwYIIMdAjwYQ7jpBzBbtRRCW3fAK1XnCSu1YScvdSujdrKXs6QDAVmp?=
 =?us-ascii?Q?tNfgpUubJJj7p8scBtV+02kZGEQ8l0o26W8SJCZUqHNaea8eneCbeyjsqEEZ?=
 =?us-ascii?Q?QbUo7qC524YSwW53zpHRztuz3nYNnIYoRlLcd5oR8dsdnyuqF+1tJ+XzUc4s?=
 =?us-ascii?Q?qutF7Y2QiHZiVrv+OypsnUSK9aRh1YO8skmVnD++kpmLc1X6rBTVmOYsemvB?=
 =?us-ascii?Q?uZw753k9d/CEgo5qxBK3wXpPo2VmjtcC33nDHdSptwbaOvbncr/ir5G7IiEj?=
 =?us-ascii?Q?dwBXBKomxHsBf3PQzHDUYwM8D+p9vZJlc7kLGm1lho5w61m1Up2kLKNmYJcM?=
 =?us-ascii?Q?xHpdJGPFQA2y6+r4wDo2LZzFdzzdhoOj3GthJe3s83kK5c590LucOFr/hGkI?=
 =?us-ascii?Q?LgYv9SRXHalXrHfktDZqWM9qth/v6k4hF68S+ZAmaHhNjdMfKasiZYeJpxcn?=
 =?us-ascii?Q?KBMoc3V2b97fiZ20PjB33wwqqaVcd9axpOvGV+GNMLPm4Xsva1vjnkv02P1Y?=
 =?us-ascii?Q?+3UJ+NGHCBjYyUoTQo1U0UowcbtT9ACyVVV9RAvFUPw5mNdU1nuamKWubhzR?=
 =?us-ascii?Q?FWbsyrf4o8m7UOuwp8XGbXQs9JfYi3QsvImTQYFYjQ2a5PLY4N8Udshf9nsI?=
 =?us-ascii?Q?DJA9XGJY/TFuwgSBppIjBLqsF588C/A1Jbmgim+g7UbsNwFeWY958d2vbwyN?=
 =?us-ascii?Q?QVv3oXXCXPcDxGVlBgQ3htPFzUd+e4BEEBECALKLcaZUsXx5w/Zt1c8Np5Js?=
 =?us-ascii?Q?g2BVKc3wp8TfpTmQGTR5EhpKq+0NWWS3JLEJKQTQFI6/XuggfoJl1as/Fl+w?=
 =?us-ascii?Q?PiVqldNSdU512QLaJcStTzbqeo56iWqRrTzrwrv+ARxTRqUQALIh4uHeJwkV?=
 =?us-ascii?Q?Q29ufYBkbJZtNfm1iTrxS8EGKEI5KSa7aDuBChJWQOkDjrehPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?crE7pu7vK+J+smhFT6wqgWMh740tYCEOH7NGQcaBmiWiNPpaCtthkbM5WEk6?=
 =?us-ascii?Q?S7SXc/Qft7/U6W5Mdbr5Lk/oIDST/9oygZqxDnKDHrPPfR6r97dn4IhdUJw1?=
 =?us-ascii?Q?Mj1Oq+z7b4msBqtOr1dVwUbqzYeSalOxjSob9ApdXzE8aPfJ0wtXqrJOP+uf?=
 =?us-ascii?Q?/0Cha5laAkc574jAqzLf/k8q+rDcyXSK5HhuNYE0z79pCCQSNKCKS3GNVi7G?=
 =?us-ascii?Q?YAeSKWIxncddo54ckVgbfbZYF9on4LJVfk+H2C+r//tBt1RrsmY/1oKtW9n3?=
 =?us-ascii?Q?yyz5ZQppFFpk8U+95vFLBQXwPUHgPtE5mtpOIfiM9R1EtUibAi/BdlJ2o0yp?=
 =?us-ascii?Q?MZKQNti6snJF7qNh+qpbllfiq4xgnySJw8fvKBaoKj8kAYoh+MkNVi450q+r?=
 =?us-ascii?Q?aLWP36tU5OKksJeydgjd8bYdbHSwQlJcChwxaSlwqwCPlLQIPe1cg/l1jxZb?=
 =?us-ascii?Q?MGC/KzQ6/P185yGFA4Wuq2MNY8ZbdshTHT6NfhjXFPyNjdIHtx2iUj//siU9?=
 =?us-ascii?Q?ItN9j3IpxauoDo40bZN+roDvwACmS3WmXcjJSZCY8H/XUnmz79Mt18E9iI0E?=
 =?us-ascii?Q?3YEYkDdoRAj2KsSa+F/M4yk5Zqng8hQpn5wu5vzd2kvKAMCtzQc5Dn2FMLb7?=
 =?us-ascii?Q?G84V176TexJV5xM2vZdpJCTjd00nqk4aT9eD3Z4VS9qne5CEmwaPbrM64G6p?=
 =?us-ascii?Q?4TY4JWnpz5qd0JzhNGuHPMWL1U5b0w2puE/PNMT2uWDuPilP8fsvLKAeraoQ?=
 =?us-ascii?Q?ij+MZ8frQRQ5sahdfRlFxT9i5XQl3Gosx0aOK0lCiWqvNRaUYbSdZ5xAPhGR?=
 =?us-ascii?Q?pVO/FixtiPVvVhrZyJEeNYdqyaUtjF8on9V2+HJAyg5Ez4dPI/Lu9gJxW7uw?=
 =?us-ascii?Q?lGkNGVnSvUWxxBOZXsXfD5jKDjfr8N6Gzf+lwOkHxWGodafMrzzkEan0a8HY?=
 =?us-ascii?Q?7XVKwfHN5bTwPSsM7B+17ZQ0rv+u0yXOy8p97k9mbdgGjFascOhOpkBS+XJM?=
 =?us-ascii?Q?csXfos98nUDJkb6JoNiBw9frl9xjSDQMAz02sUI0QLqlgdu9LHNAw0A/VU06?=
 =?us-ascii?Q?0JMjZLxJgMlvhovg41DEjsU77A+22440GpR8UX0vE/DOQDzLYq72QwwcEv0L?=
 =?us-ascii?Q?c8WILZ6mQ5ck+Y7PL7/C7mqq5sxLHQsaoC7X41lskkDDTf77JSgLuNvwiSvg?=
 =?us-ascii?Q?Sk7lxTg0OGYLzPBvuQHlPVGtOnhvh1blT8Qfm6EE8eEF1ZeN/ZpsGM6IyTxr?=
 =?us-ascii?Q?q1ZeFMsC3OWPTlxmD5ELRfEeCs1J4J7zTtUUSGOd2rEYWMwoIy8Z95F48NPD?=
 =?us-ascii?Q?jPvOUiF+o0UgUZhJ805BpCJs5CGVyrWQBekhAPomtP7PJtt3p83K2cFlElR8?=
 =?us-ascii?Q?Wyjt2JWEcJzweEoNHpE21oPHPAxugB2JPC5rueFGNN7PdeHyTb9aTwCENk3i?=
 =?us-ascii?Q?JeVp/9iNMfl2OFyB3zHWtijHud5eY9vVi/k66GWxQAKT4K9Li+xaXQCKsa6R?=
 =?us-ascii?Q?52g+RZrq1JzK4KUzwVtm8ulk3L8hvHu30Ah3JBEYkebX5sx/bPkTOTHh0/8g?=
 =?us-ascii?Q?z7M6eHaK2t2a8flvm5Z0gkJqrcqwO+rwCy/BaV2K9fSsM+UqRnrb71xtgi6o?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f17d22be-2616-4ba8-3bed-08ddd5c0ca9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:43:36.8961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gnt1FtaVGbSiWrGrBD0KiO8qFxtkjOXqfOfcpNFGvNqFcYQRgiDjl+hxwx3QFSBQR5oQViklHDVeXKOJKFWvmUdBSVvVOXjEYVSw5rnHgK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
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

On Fri, Jul 18, 2025 at 04:53:35PM +0800, Yuan Wang wrote:
> E610 supports SCTP port in FDIR filter, so add it to the support list.
> 
> Fixes: 86e19565f5e2 (net/ixgbe: fix SCTP port support)

When this commit was made back in 2017, there was no E610 to support, so
therefore it wasn't the broken commit. Putting fixline of 316637762a5f
("net/ixgbe/base: enable E610 device"), to ensure that this gets backported
only onto those releases which have E610 support.

> Cc: stable@dpdk.org
> 
> Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_flow.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 6278646720..1bf0af330f 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -2114,7 +2114,8 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
>  		/* only x550 family only support sctp port */

This comment needs update now too, since it's not just X550 parts. Will
update on apply.

>  		if (hw->mac.type == ixgbe_mac_X550 ||
>  		    hw->mac.type == ixgbe_mac_X550EM_x ||
> -		    hw->mac.type == ixgbe_mac_X550EM_a) {
> +		    hw->mac.type == ixgbe_mac_X550EM_a ||
> +		    hw->mac.type == ixgbe_mac_E610) {
>  			/**
>  			 * Only care about src & dst ports,
>  			 * others should be masked.
> -- 
> 2.47.1
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel.

Thanks,
/Bruce

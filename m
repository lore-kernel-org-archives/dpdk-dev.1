Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C8BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 13:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC2D440DFB;
	Wed, 28 May 2025 15:08:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4CE2440669
 for <dev@dpdk.org>; Wed, 28 May 2025 15:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748437695; x=1779973695;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OJeImuoMLpBWDDdhcxw75So9GNWVJ6Kd95VIwaXnlHw=;
 b=XbINxbMkYlxPDC+7gNVtN1Ou39qHsrX7ixaEJz+EyASYMEznf2Sn2MlB
 VraRf9vdjQDQKE95HTjPt1H7ljEdN5nIjlb2B7jvpJLGnxtqTui5wBtUF
 m/AoxDUqeqKIE80YV6inds5qwggzd7QsPysC7QlPjxbU9T4oqoOFCIiKs
 bApHZM99Oyh6YIiYk/tqq+wEe1g7T/qrhHHRsRCov1Qdb+TTT4Oz56nq6
 Qh0nakbcaY+abnePljqsvxGeTTecOAWj52usZChUEXFsSt7fH5ROvhN9D
 5KddvPKCccDKKUKCmnKPp61AKeEa5LRpkQryCpp1Yp8wZY0dntm9EHbWZ g==;
X-CSE-ConnectionGUID: tpsF6xaBROeN+ERoiCc/EA==
X-CSE-MsgGUID: Rq4Zv+XnS/GsIZ60k2b1fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61121800"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; d="scan'208";a="61121800"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 06:08:14 -0700
X-CSE-ConnectionGUID: 7NrnN1TvS36aidRCA8bu1g==
X-CSE-MsgGUID: v+TUFbH0S4GuJ6EUH5iO4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; d="scan'208";a="143876278"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 06:08:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 06:08:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 06:08:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 06:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmORpitSnH3aWJc+VIIUE86510xWTt6Y98VD+ZwCgPwtWVnefb90bM+Cc5ipoJ5f3ycP9QI5WYssEC7iMYHsBBIisVwUelBIKAoiJGir8+TYV48tAUSGtdJN0y+uqROEmZ9lFIkMQA1aZBPeMwOursQsNBQSPsOf/19xbnD4Pibc0YKgsLF/KP8c7J9Nv87bPAUtwkBy6ZObblSsx6F6qI+UBpMnZ/Uh+258K3lIUdntFB8nrzVPnpJLSjWfAnrooQ4KDUVNS35+GoZ+nOoYbyHIuey310mZZLts2vLieRlaPpcS2xbkP8SB67A3nQ+Aa8E9Y86wYLS5NmzQNanukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoX/hAptYm5gXkcfILZwODQdz/OibGqI/7fffqakl/I=;
 b=QzAGL8zkz2Jh9hqelWqZcUUFQzg6WRxmtyadiMZ60Gz3cARCPOYmgo6/06fHoFT6zWzc4lMo8zhOLnjehAg6jgdIvXuPzpanua8ZKoMXo73jlzFnC0DUn0JI9dAYQAP9IsKmktc333BDfsNwv442wVd8xHN/yVGtedd0gt7XXYcb/S6+itQ6hhYA3XCyjlgri8ZPW3C4cYx9I1CjXb4izPhDCAMnecNxlleaI7asSCS5AkNfRg99IQJ5F212JR0EObM2ds/6WptMFuyg7xzbGXUheyChvn9Pv0kO0Dj/dXZpznHLM/DxV3xT6GLncleVKNDmZWKCndq+kFA1JQBKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 13:07:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 13:07:30 +0000
Date: Wed, 28 May 2025 14:07:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Lukasz
 Krakowiak" <lukaszx.krakowiak@intel.com>
Subject: Re: [PATCH v3 04/10] net/ice/base: set speculative execution barrier
Message-ID: <aDcKjfSrOShfJE1b@bricha3-mobl1.ger.corp.intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
 <20250527131741.7606-5-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527131741.7606-5-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DU2PR04CA0300.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: b66f5221-db7f-4bc6-d58e-08dd9de89a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?748cbKUoQcQKHZx8pHvA3zhwNwonm4Eq4TMdPTdUwBCepsznt1cjnArJtjI8?=
 =?us-ascii?Q?fBK90FOOA6dQ/z+9geMTBq/x57qzaJGf7aa6V6t3dsO4f4KcS7F3zi6+SZtt?=
 =?us-ascii?Q?Zf4nKBLtnWa1MqS9QSKTcdkan0V+gm+RSVzWF82xzOchWZ44nTlDgC8hqVZu?=
 =?us-ascii?Q?3v/5Qu2l4KNErZo/TzaWgueeI0H34lnzu+NeEAJgyxotD7RqJrb07q7LzBwU?=
 =?us-ascii?Q?dZXnqA/JEU+ABbySqC4lwDpozAcMLU5YZnN7Mi4fEoi+bqjdHqjPVfbTF56M?=
 =?us-ascii?Q?XaSNokV8HaRvVFJg1cphCXeY0WRhArwjRQoIdnxO8drXUg1+O7AgiMOeKqHe?=
 =?us-ascii?Q?l4SyifDvBJBns13I0Tax+pQ6+/4k85xUjG0ZHeNfmEB9TjAEWS+q0NRFy+QI?=
 =?us-ascii?Q?H6e/LROtNaZWX8pSQ7tQTr7VJ/wlCRylgCEwm0peK39+ubX7M0R8IHEpBo12?=
 =?us-ascii?Q?f1wpcyCpNrou9NM4nYlIZ6Q7fT94kx9hTFCVtpWAtIJd2noecAfizs38XV8B?=
 =?us-ascii?Q?hveWVlt0GWsXcDhoeHOm1A9b0z3xLw2+2FIe8z0Hk32fhL9gpPHfGgkTH0vp?=
 =?us-ascii?Q?Z6qPhv2zWw0rwZsdonIWxjMLOxD4GRm3xvZ02vg02k2ArfiPhpYwEHbmLQ81?=
 =?us-ascii?Q?Stm7rEqGF/7Qu3iUrfSeEdle2gTI1FxVilvWiGj/uY1Md/j2ZAbde7BzuDef?=
 =?us-ascii?Q?zA1n0EzvkgObrksjK5Hf9l8kQ/f2cs6rasgD9doIJ/ehSjjSp5Z//aBqrQxv?=
 =?us-ascii?Q?lxqPrTTwmMm82NB/YE+2Ky0CLcHzbDl9U56lOBWAsyZBTSHW88j3F9rAYvFf?=
 =?us-ascii?Q?M2qfihLli4oTP8Jq5sCGEK0pyhMHj9YboTuXHEwP3mYU3YrI9mZBkfXO9QLn?=
 =?us-ascii?Q?fpIvm2Ilmtejs1W5rK+a84jNUQNfxFmu0+2ZI6UggmOoNjj0eEoTHV10mobF?=
 =?us-ascii?Q?/2ZJ/pa+on8b43RwwR5mxwykDrRcqNp3n74jXNpDB7VplBI90IuTvmDD1OJw?=
 =?us-ascii?Q?s3Rhjlt7kOiXmBjkcLRY64F6I8T5l97rY3FIE1jNSiWYF/ztYXXtDgyLOWv6?=
 =?us-ascii?Q?fxUoO2hsug+UOLGqX1GZb5a+/6Ji/nnezPzX0nGyaXJZf0EM1hOgm9YSOD/X?=
 =?us-ascii?Q?mrFlOL7t1rnCM6xScUtk8juxNA39vpv0IJBlWv4/ueBd0grKm08+mqw28bUi?=
 =?us-ascii?Q?ld4ZDHIUgLn99Wnd5oqU8LLhOAMwpxdgghYOYFYwPjmKgo6KoyIOw7cUQBVG?=
 =?us-ascii?Q?bEMKKBdHoSt9gl4lWU7C66J3S/S4ytVm0onUllbY2pp/cVcbw/lyuRfrzCzq?=
 =?us-ascii?Q?76sSZq/kn9xVE5h4hgJiei6uBfCZUWdRv0XMvlZKEUXibpdWw5OuEQ7qb+SN?=
 =?us-ascii?Q?tbvotlX30dY8SZH37PIsQ2Km8ivaRRoFCk55ORIlUVFuWnBsWw1QBuX9CHSI?=
 =?us-ascii?Q?I/be86yptok=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eXFxwIz/k4vtPY7jm/fjo4o2uxtRsfeb3F5+AOau9mgvtPMdP4KH0Gi0gdij?=
 =?us-ascii?Q?mbVZqRr7GiCN8Kxdn5NmvXQN8nCEz5cHgWV+d/Rh82iNwzv4xRcka0izFUoX?=
 =?us-ascii?Q?9ugtpJdaYV0P4w2ou6FpFQ2sg+pBv+dpDsNC4qDu1Fahq3xgOkT8HPHsO/KB?=
 =?us-ascii?Q?HGfT+lMTJ1eNpFaWIzHdZPvmACjfvdZ+1AcqQXbnPMsTC/CPxcVZCg8CDpvI?=
 =?us-ascii?Q?G3Mfl17/SJgG2aeVmuGbh1orURQNKuAGaLxgZWHZvTZldrGmfx2C30NPC+96?=
 =?us-ascii?Q?vVNtkB4+Lt/a3DhxSybtIMT9S2gMeRgcWVaj39V5/UFvimHZfS58YLCduWLw?=
 =?us-ascii?Q?QTz77BYprTbpmsyzLqlsT+kAn3k0FWXQoPgYCmHk1bh/Plj5Wz7sPOXZXROo?=
 =?us-ascii?Q?0oC3G3YGgMHZqhY8OkBUtXN5cfcJ1SFjK414+mE4GdcH1jyKN0zRD4ibx87H?=
 =?us-ascii?Q?x0H8UE3Gxu2w3VKm929dCl2l+nKLEa45KiF/VrEgtRXBNLhYsU2+VLYMtoRd?=
 =?us-ascii?Q?fjgqKV1gg6bmU00jMS/mBh2GT+auBvYVzjSgjyeeF0s2hUskwKJKde5VeZl6?=
 =?us-ascii?Q?dpASEfj0xz70x2H0P2SMHlVF2lv2E4OjTlK22f1cC9uMfcA3BuG4AMeF7Naq?=
 =?us-ascii?Q?uTN2hlSbDDkv29KIsuG3gAqiLAS/SK4KzB+OLSAD1nDI4yQT3puCGCEeKIsB?=
 =?us-ascii?Q?xN97xhWZY+GM5pC7mYapuzUL7AqohFbPjUbQMisu43HkhAWy5EwH+jZtklN6?=
 =?us-ascii?Q?KAL9ToQj7iK30WAycJI8SwiLw+RmOxGa1mPy+SNygzJoBZouN+5foOdVuGLZ?=
 =?us-ascii?Q?3/sEO07ox6zhmABRdd8F7tUIhIBsHeEW1a/l+FHN3z+GVI4HS5kH6IuLQUgE?=
 =?us-ascii?Q?g1tlFDcmHkug+KzpA9cqPNoIcfvUJgsmcG+gG84F7msFou4dv6GJsmvQbCa4?=
 =?us-ascii?Q?73+4GpCAjZgjB6DhpCEREY9giSngKK3NcCYNKZ7M+6bQQkX18IdQapQYTi1K?=
 =?us-ascii?Q?8dYU/rpBVUY0falj9l/FOJ/WM+juGkt11ISff8mduEhKFGpmdjI+rzJMST2w?=
 =?us-ascii?Q?Z1dIadcfY4KLXNkVuszu+O/EsSqPBWwgasEfCMrUxq4vaDnwyjacFvtYKkv5?=
 =?us-ascii?Q?R0qKHtWzLlQZ2cQDuinnt6d3AoHraHgVce49seSciWCw4VJ91d4+xwIvHP49?=
 =?us-ascii?Q?CVQU2lQLCzORk2WO4YTRQhqzTvitTtr2xt4iDDesAa30gxoo/AAIcTOdKuwb?=
 =?us-ascii?Q?v5uTSle/HatwOX7hp4zDpdROLEnHJ78TzGasw1fdH4DXNZEq1Q+IqNqD3v0p?=
 =?us-ascii?Q?1masIZqZQChzulxHCyv2QGBEutXhJlRE7azDlT66ht7Sh2nbtP72wC7VC0We?=
 =?us-ascii?Q?P/2yOg3ao/0aBv16X6UZwdaj4/pCVltueyY0I/PAYJugQY85Pk0Y+8rEiLJ5?=
 =?us-ascii?Q?kN9z/ln+ORCAifth8ZgIOcoKahtZohjYheiT0+WhjC0Kt7Vi43gWqphCZ2ad?=
 =?us-ascii?Q?MAPdTDjqH87hG+tfjGOc/GsjOim9N1i7oZ1Jr2WSSayv5uePhq0rKOR0EiN2?=
 =?us-ascii?Q?/e4wGvpJNLHIggi4Ovxx05W014dmBR+wtHAGHf3Sxu+2j/IMpK5f+05Xqp2S?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b66f5221-db7f-4bc6-d58e-08dd9de89a35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 13:07:30.4543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2qWmSUxjYz5EnLDZwrTgN4fXh8dyRG1ava8vzlaBhe8fUiCsRXsH1Lbuw94u7+urK/EM0OBSiGmBJqikw3q+5N0aB7LxttbfDwdu3ZQSN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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

On Tue, May 27, 2025 at 01:17:23PM +0000, Dhanya Pillai wrote:
> From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> 
> Fix issues related to SPECULATIVE_EXECUTION_DATA_LEAK.
> This changes set speculative execution barrier to functions:
> 
> * ice_sched_add_vsi_child_nodes,
> * ice_sched_add_vsi_support_nodes,
> * ice_sched_move_vsi_to_agg,
> * ice_prof_has_mask_idx,
> * ice_alloc_prof_mask.
> 
> Also, Added memfence definitions.
> 
> Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_flex_pipe.c | 2 ++
>  drivers/net/intel/ice/base/ice_osdep.h     | 6 ++++++
>  drivers/net/intel/ice/base/ice_sched.c     | 3 +++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/base/ice_flex_pipe.c b/drivers/net/intel/ice/base/ice_flex_pipe.c
> index 6dd5588f85..dc8c92e203 100644
> --- a/drivers/net/intel/ice/base/ice_flex_pipe.c
> +++ b/drivers/net/intel/ice/base/ice_flex_pipe.c
> @@ -1280,6 +1280,7 @@ ice_prof_has_mask_idx(struct ice_hw *hw, enum ice_block blk, u8 prof, u16 idx,
>  			if (hw->blk[blk].masks.masks[i].in_use &&
>  			    hw->blk[blk].masks.masks[i].idx == idx) {
>  				found = true;
> +				ice_memfence_read();
>  				if (hw->blk[blk].masks.masks[i].mask == mask)
>  					match = true;
>  				break;
> @@ -1648,6 +1649,7 @@ ice_alloc_prof_mask(struct ice_hw *hw, enum ice_block blk, u16 idx, u16 mask,
>  			/* if mask is in use and it exactly duplicates the
>  			 * desired mask and index, then in can be reused
>  			 */
> +			ice_memfence_read();
>  			if (hw->blk[blk].masks.masks[i].mask == mask &&
>  			    hw->blk[blk].masks.masks[i].idx == idx) {
>  				found_copy = true;
> diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
> index ad6cde9896..7588ad3dbc 100644
> --- a/drivers/net/intel/ice/base/ice_osdep.h
> +++ b/drivers/net/intel/ice/base/ice_osdep.h
> @@ -203,6 +203,12 @@ struct __rte_packed_begin ice_virt_mem {
>  #define ice_memset(a, b, c, d) memset((a), (b), (c))
>  #define ice_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
>  
> +/* Memory fence barrier */
> +#define ice_memfence_read()
> +#define ice_memfence_read_write()
> +#define ice_memfence_write()
> +

I suspect rather than removing this, they would be better defined as
rte_smp_* barriers. As in:

#define ice_memfence_read() rte_smp_rmb()

Let me know if you agree with this proposal, and I'll add it on apply.

/Bruce

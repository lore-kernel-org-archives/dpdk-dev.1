Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB4CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 09:49:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D8AF40280;
	Fri, 19 Jun 2026 11:49:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 06D5F40279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 11:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781862541; x=1813398541;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RNXGXoChwkA+FwMcHk0hKDgAni6ZadLKamfRq2tww7Q=;
 b=O/nJg/TOplnPxkZ83yUQdZGP8yeVL+iTq86WTNM/19lLTAmmqIQSpSnp
 G7Blsp3aYaNf+oU74UmHw0TJxqyyJR5hBqgY0S+obCDT/yk+kqfEuin4x
 LAaWD3X8T344CwKEN3sekl2bG/vHZCdVZr+oqmNdWkwU/OwUhMHn7nZg7
 7ZcR7a+IBKIV2VU/UR4CbcGEL/49eeSwduy4iMjxfT/H9PkvzlhiRTByP
 dvzevCfcZGimmEIj4FKnBMAymRNP2f1hcxwHvpfnDzmy65JkAeWp5DBa+
 zHGBdCz/svfzaqXTeC0XnQ+2RmHa4Er2IO6sA4SN4MXri9vmTZk5idvQU Q==;
X-CSE-ConnectionGUID: crwa+mnPRZGQ7ayLxYW1SQ==
X-CSE-MsgGUID: 25CPM02oTJq58qC16LuNHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="105508655"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="105508655"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:49:00 -0700
X-CSE-ConnectionGUID: LiGPAiRBSAeAzRI4WI0PkQ==
X-CSE-MsgGUID: rdVaXJ3nR6+bXGC2mbvj5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="253580450"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:49:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:48:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 02:48:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:48:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1ebiZVYXndOFidIVUQPjF3tbXR3ft/ktHtG4r7vjv+e5d+pFBWF+0XyMkORUV6IaTSX0CtHEWvJ65OdqBXW3A8Zub8hn0UTT40IcWqFM8FSVNyxVkYLl3gGP81VICvBtwz9y/JFDqpbY16/raIPMq3uMkiT5V2rgicqItI/mgVnsB4dcwXolS6gD5lpfrIX1rll5BBNDyLBXNogceHOouNf8sWc7OalYCsf3MZinou3lGkNMVZgUdU5QIH1Wl2711GjiZXCB8KwlqkqNAExDG9+l231v512pPh2AR6GHIyOJmCA2TR3E7CjNfOlov+9A4EBPzN0nXz1wEfB6MaqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1vGSNE3zCCiP0EYyG/1Rt5n6qpGO85F3RgaXeCrLUI=;
 b=fhhEUHoCszZGAEPvMkerWg3Vv3A3k2HUdFozQKrmQAK71x8M0FcPpyhp9CkWaskoDhWlHyJDtFa9FaiMD9rl1uXmkGr7GD9beKwBXt+gRnOn6Ml7LGAmoGrdm/eJuaWOnql8znnbD3DTv9bMslaaS9SSPBAzAXef5lxA9k46XEnlcDHQ9er+Y2gWNzkGd+o4Z0aM+mxXVVXjDbJ7ZvQomK6Pk3ZQlcrt4qgaCpnsg655T4m7SQL2dg9lQksR+jBceK533Q4nZyr3u3Bp4Xbr759ZyxOIp63DIeGXZFps4tWBg3Ovx2R8nYaoHmxGQc1fmCPyDU1o7R+/fomIELc9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB6573.namprd11.prod.outlook.com (2603:10b6:a03:44d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 09:48:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 09:48:55 +0000
Date: Fri, 19 Jun 2026 10:48:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>
Subject: Re: [PATCH v2 1/4] net/bonding: make 8023ad enable function void
Message-ID: <ajUQgQUGn2gufLKu@bricha3-mobl1.ger.corp.intel.com>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
 <20260529000157.235931-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529000157.235931-2-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 192a4190-5d73-499e-c66e-08decde7fa14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: /FtvYqGQSPF3YxBNC1H3VONM5UuC8WJFkiuiPM+e2NhcmBOwGZEXGXPsrnTRgpXCvVlfzfLa9zFGM164+SAcni5QXxY2rfk2W5I9hzlquO3ktMxt31OGUiewxVA6Dj7g+WiRr0LZs9xJRjoAorA8+/G32PSUXQ7J9t4I7TysAd1iwfZzS+Fnkm5hOphQTeQ4lofvOgo5sShS9g7B/fk+kS8OiRqS2PRfOSjxwNCtM0NNZhCoz4BvNr8WdfVN9jcnH60HBsGuOsr6dKCKA1OkJdStiEkvLdP5p4lbmCvt5gFbqWKr6zaGIMHbaurbz0yCwTKv5kP4cgb/WorGnTuOlPSAnGOyV6V3HXsmrRCbBtavAyfOweQGZ0WFmWp37DBUiS33s+IrMkYN2WFlhvQn9BreTvlCfNqfZqhH0ufilun5S9N6WbXP2WyQPLbDX8zQewDf3iCcPHINDEDxM0qu5D5ZalK6N4ae1xOxmhzTahSkMbevm2tgOdgPnRsTYu9X8HXMTgRv0UyslgWoa2YNGikt5rGS6r4hyBe0PoLezmDoKFekEpXl2CNaZuHf+q1x9nPHB9Zi8Zf/BVk7a3ohqG/QuHLNyBQ9WST1k8KMBBfhq+if+hrH+q3tx0FN5VXXqjWKyBCMAws5Ibb0/rvkrBp2esyYeFwKH2xUYlyu33k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpT0LGlo3pWDtGZy7d5GyubHm41lrkX3KwG4Rb35llwk0tWiDSKcWPOeYDK5?=
 =?us-ascii?Q?yuwaEvzNsRRGfLdzqDGQ4j+9LSDYWaX9oom5Wl47hid7cbmvtPH3cijT6i96?=
 =?us-ascii?Q?xbI3Dod4JiYn24flE8Wt/7bUq7e5whXqbwoBpwoDogjqh0Gu+XfAxht+iVok?=
 =?us-ascii?Q?iKxiEcmiN3fjGq9mR3/VIIz0Q2XJ1vsIsrnRS9yYN89j0kigixrbHAuZuLsq?=
 =?us-ascii?Q?oKxZ8m5rdnmCUF1rEAtFX6d2s4UNFxfkjrRfL78F+JGxtlyYOGKY5mlSRe6C?=
 =?us-ascii?Q?m1SQMBMDp4Y7a6cROjdq+quc0KlEF7UH7Y7EY12useXZ95GoCnrg1oU7CkwD?=
 =?us-ascii?Q?qbcXQNampVUFSvscBTlxdnL6CaKla5ErDi2UwHbQB7LnfKKnlJkMsDmFieRV?=
 =?us-ascii?Q?huPExDGfw7/Waxs9ACozlAPyCULrwPNqFhjASQxtykhN+I6wHXxoNCUZ2vIW?=
 =?us-ascii?Q?LC3Spg5aMNkyioxNU4lJa3IT6/y3K3+rHUDmCqrM/kUFcN7SGJf8T2utxLbr?=
 =?us-ascii?Q?RDNXE/F29P5WLI4xHMYaAhz1fLQ3KNEZFVqQNHbm5A2KF5wTDgy4tnZXr0Le?=
 =?us-ascii?Q?EXcqSW6y5kea3p3tDsPAAUEls5AoQihSCSglDdhks8IB1n9uDD4CaxJ/QR7K?=
 =?us-ascii?Q?r61ExdMdlZVeamSq0nx8gHYrK26/oGs5CtQ5a0m0v/kQ1qbiQ4ZwLqz/MOgy?=
 =?us-ascii?Q?qj+f03iZiimPFOBBnoNWBPEcyiYPYhDN5GHUdsVjIbPbkES+FddHu5wSncoi?=
 =?us-ascii?Q?IJpy72R3DYR09hrk1O87PT6NSIx0kokx+x7SxogyKtts8r0b/2kv/YwGuFcO?=
 =?us-ascii?Q?nQ2Xjv+MmIbC6csPOl9LMtN4I11R9nMqcq9V5uKUwO33NsHXhQHWWgtYB8+G?=
 =?us-ascii?Q?n+E43xAre1VCe6A+fkBHW6l8tl64c8YTWW+T74J4PLAH3Z7sz1G+D8oWk7Ex?=
 =?us-ascii?Q?5o3O8MSq59N9dkUxzEdZeMdRB4EIXt5PEdInu9gVpAsz4MpFn7kh5751YiTZ?=
 =?us-ascii?Q?DejjwLTf1RX/OPAfgnVHLl3xDqIDb/GGOf0mApRvYRAw+xXV3jmHCwYbLOoB?=
 =?us-ascii?Q?KLt/+N+P08wEfnKINCSd5YsMiNhk3eFXSxI0/PC6wULrF3AIgM+/7TnnWHL7?=
 =?us-ascii?Q?zP0dGbLVG3mVh4sSrlUj/3cBAkdxT6JH3xJ2zyJHDb5J1PGGESxBIYjczeUq?=
 =?us-ascii?Q?+/HgO5oSbqqFaIa5BYsvLaijs9/gRbFEhCfVg1kTDYD+A+WijeSOZCed+lPS?=
 =?us-ascii?Q?VVT1T0yJOn308KcEE7C4lp5ZwzbIIpx5ZcijQMIfD347hQEVsF/aneO3atuK?=
 =?us-ascii?Q?Jh2Ev5bg6sqdoLnag3qTJu+jyRUWuQzpKEL4gat/+XtqqWvwVKlUAv1KoPpP?=
 =?us-ascii?Q?zS7os7Iw7rmiWvoSM2CFE5rLokR+Q8uQMrtBO5OAMxGwCKz41lNOq5d57poK?=
 =?us-ascii?Q?jolWSZwX7AAxLuO44Lilo9Fs79hvIzUu+yNLrdwtinABAWKZug1OYhoEfMta?=
 =?us-ascii?Q?AfMaBtEl7h8uv5H8USTI7y+I69ZOyM4m9qwLB2JwQ0ZLIM63/O+6bL4imOnN?=
 =?us-ascii?Q?GkypJ7JG4W307froBX0O68xUYMxJ2XWVy8CuGbV4HCyjKe8aiRWgSW3xck46?=
 =?us-ascii?Q?GX3uuXaZjwha/X3wELRdyCmOG2gAiaSRPXFQwfyZNjgWuMX3XLg3+QWJi8kQ?=
 =?us-ascii?Q?XzIELF5oYS7WOg9UYHrCKmcXQNSQGupW0mFZsV5dXJ2gtO9s8xp06tOOs+pn?=
 =?us-ascii?Q?Tkmv+bx0wUi4OcK1PSfDSblbUHXD7Qk=3D?=
X-Exchange-RoutingPolicyChecked: OmFzQUEj/VOqyjUj8AdYuk0GgAM0O6SVdcaGPKjFyL51fzAhOvK/gnHYib570xYZGv97PhxVEX/XJ8uf6RWmyKCU3IOl4QYWXPDy/XclRdHTTjxwpOC0q1I9lA4yMBAnpbJeh1+LYfkX17mvRWNqpf16/12cMQxdyns8N6MGh3MEeDKfn8NnYmp5HW5GcYSqbtjmQix2gCOt27i5c9ETpuQXGgvRCnP03f2ZKaayN9Sx8mxmSRNDljgFOWJ8g3nmLl5+5U/2QNXelMSlDljjKTtH9jRQCgaaWvPNapOTd8Emtim4k4/bCyCRGeDLpzDRC2e0rDuU2gSWV0zZRcS7ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 192a4190-5d73-499e-c66e-08decde7fa14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 09:48:55.2168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQHKgBTrEHrwlgfKfYDofADoPfPxDgdSjZ90jLUYleS7Bu/KSqjCHJAPiwSe3zPnzWCy2R7xGmzY2UXC+px9/rk8EPdmmje6JOwstPBUtlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6573
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

On Thu, May 28, 2026 at 04:59:13PM -0700, Stephen Hemminger wrote:
> The function never returns an error. Cleanup the call sites.
> 
> The 8023ad disable function was never implemented,
> remove prototype.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

While I'd actually suggest this would be better as two patches - one for
enable, one for disable, it's probably ok to keep them combined. If
splitting in a new version, please keep my ack.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/bonding/eth_bond_8023ad_private.h | 17 +----------------
>  drivers/net/bonding/rte_eth_bond_8023ad.c     |  4 +---
>  drivers/net/bonding/rte_eth_bond_pmd.c        |  7 +++----
>  3 files changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/bonding/eth_bond_8023ad_private.h b/drivers/net/bonding/eth_bond_8023ad_private.h
> index ab7d15f81a..bd7a5848de 100644
> --- a/drivers/net/bonding/eth_bond_8023ad_private.h
> +++ b/drivers/net/bonding/eth_bond_8023ad_private.h
> @@ -209,25 +209,10 @@ bond_mode_8023ad_setup(struct rte_eth_dev *dev,
>   * @internal
>   *
>   * Enables 802.1AX mode and all active members on bonding interface.
> - *
> - * @param dev Bonding interface
> - * @return
> - *  0 on success, negative value otherwise.
>   */
> -int
> +void
>  bond_mode_8023ad_enable(struct rte_eth_dev *dev);
>  
> -/**
> - * @internal
> - *
> - * Disables 802.1AX mode of the bonding interface and members.
> - *
> - * @param dev Bonding interface
> - * @return
> - *   0 on success, negative value otherwise.
> - */
> -int bond_mode_8023ad_disable(struct rte_eth_dev *dev);
> -
>  /**
>   * @internal
>   *
> diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
> index ba88f6d261..eba713e381 100644
> --- a/drivers/net/bonding/rte_eth_bond_8023ad.c
> +++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
> @@ -1287,7 +1287,7 @@ bond_mode_8023ad_setup(struct rte_eth_dev *dev,
>  		bond_mode_8023ad_start(dev);
>  }
>  
> -int
> +void
>  bond_mode_8023ad_enable(struct rte_eth_dev *bond_dev)
>  {
>  	struct bond_dev_private *internals = bond_dev->data->dev_private;
> @@ -1296,8 +1296,6 @@ bond_mode_8023ad_enable(struct rte_eth_dev *bond_dev)
>  	for (i = 0; i < internals->active_member_count; i++)
>  		bond_mode_8023ad_activate_member(bond_dev,
>  				internals->active_members[i]);
> -
> -	return 0;
>  }
>  
>  int
> diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
> index 96725071da..7fcb3ec7d7 100644
> --- a/drivers/net/bonding/rte_eth_bond_pmd.c
> +++ b/drivers/net/bonding/rte_eth_bond_pmd.c
> @@ -1619,8 +1619,7 @@ bond_ethdev_mode_set(struct rte_eth_dev *eth_dev, uint8_t mode)
>  		eth_dev->rx_pkt_burst = bond_ethdev_rx_burst;
>  		break;
>  	case BONDING_MODE_8023AD:
> -		if (bond_mode_8023ad_enable(eth_dev) != 0)
> -			return -1;
> +		bond_mode_8023ad_enable(eth_dev);
>  
>  		if (internals->mode4.dedicated_queues.enabled == 0) {
>  			eth_dev->rx_pkt_burst = bond_ethdev_rx_burst_8023ad;
> @@ -1641,13 +1640,13 @@ bond_ethdev_mode_set(struct rte_eth_dev *eth_dev, uint8_t mode)
>  		eth_dev->rx_pkt_burst = bond_ethdev_rx_burst_active_backup;
>  		break;
>  	case BONDING_MODE_ALB:
> -		if (bond_mode_alb_enable(eth_dev) != 0)
> -			return -1;
> +		bond_mode_alb_enable(eth_dev);
>  
>  		eth_dev->tx_pkt_burst = bond_ethdev_tx_burst_alb;
>  		eth_dev->rx_pkt_burst = bond_ethdev_rx_burst_alb;
>  		break;
>  	default:
> +		RTE_BOND_LOG(ERR, "Invalid mode %#x", mode);
>  		return -1;
>  	}
>  
> -- 
> 2.53.0
> 

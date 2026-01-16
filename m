Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7E1D4899D
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 13:02:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 199684279E;
	Fri, 16 Jan 2026 14:02:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 92D55410E3;
 Fri, 16 Jan 2026 14:02:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768568558; x=1800104558;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JolOCthU7LIZDwFdHMqdUSYv5yREgvmRCW3MUlcvlHQ=;
 b=R/zwvkSEK2I6TsyQ1vt7hpDE2bH1lLusTrw9STLFKLLakOVDxFxoajCH
 H/DADSpC5axSCFlNDETDFhwwN2bDfTR/X0Sf9gg/0HVwFTCqvDH6Qvv5K
 FrvlckzFQuqJWsxSAjm6xzhzsMx7rjMQdAvisywHECFOw/S/9oKijmYhY
 K8WBZ0R+9i81NgYRC0+sZt04Temhu8L1sYcXiUZ1BjYjFVmYoDgjTU3PE
 2tFc0PLxxQ/kW/iDETEgVQjT2vhbud1udVazOCO/olAgL64UltSWTiqzG
 TOH20VBuNMbBj4FCt4sC6cYLna7dEYgIuEBRzp/8Y4xR8/iPV7yiy4M3v Q==;
X-CSE-ConnectionGUID: c8i9HyJ5QKe1Djx71f88aw==
X-CSE-MsgGUID: 2rh7ShsXTYCiah3r7CNSHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69793533"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="69793533"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 05:02:36 -0800
X-CSE-ConnectionGUID: z4Qja6g4Q0qQGDRGFQ0MGw==
X-CSE-MsgGUID: XxyghlwwQ6GbozXvRrPHMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="228252574"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 05:02:36 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 05:02:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 05:02:35 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 05:02:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmcJyX21aueP1R0xp89E+t9NxJwFCNkyadPejOtGqUEcKxBhajaP2ngJrDEZ76cfQAOuzsaHff8zfZ2cjaMQgu2DS6uDke4x0bu9/ffKxCuXJrosp2Ly/GnOBZyVHtS+XbIL8ADCALtT2GN/yE1O91YTsZHBPVY8NljywJXadqz6YYLtuQ/I84iWprrqk56rBa06Jmz5V7ldnFrDOGlWVs8vW0Z11REswLTXQuTazOAxEplrt6jDomnRmdkjTc1Z3/VkDEPYadFtkVXCi7jgZgzx3EkRd+RHspOTL0e/QzOAQkHbcpa+sZJoHJtwrZS8w15dkqtRQ2lL3LxDF4Lx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyfSpm6t1rrOWreCuouwDHHhHKovPpaA5wD4ugBAOE8=;
 b=ZR5kbF0TwYahmjME7pPvVI8Z4/EV/lRUJU73hzFd5gx2eTfGFH3du5gqPvAumIh4839WZGycc17l0Ha6YlAOPsd+iuw3NrNyCTLN871+ELwYGu7mT8BPsWVmSunQK0mRkb1Yt6WoYVjqPQHkmLcaAmaKcKP7Gg2/OpscFdVL0d68b0wUWBXFteDqwuFBRwssMmudjRZq/oUPpwBQthTLBRsEAWfhoRpC7SWMtAUrNAV/hlchmLS+viJrxOi8soOtqPe5N1gNTDiXSGQiuT1JoyHcH4Zq1nTR6jhaU2XX4iEDd1f7pHL3rqPT0TbU1qt5znR8LpkCzCtn/EXLxsd2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 13:02:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 13:02:30 +0000
Date: Fri, 16 Jan 2026 13:02:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <stable@dpdk.org>, Olivier Matz
 <olivier.matz@6wind.com>
Subject: Re: [PATCH] net/intel: update key_len when getting RSS key
Message-ID: <aWo24YKyq18oV-g3@bricha3-mobl1.ger.corp.intel.com>
References: <20260112135311.2507243-1-thierry.herbelot@6wind.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112135311.2507243-1-thierry.herbelot@6wind.com>
X-ClientProxiedBy: DU2PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:10:234::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aa1b79-0e2a-49dc-b7b4-08de54ff81ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OGuohdwlGmvUx3qyxx44R7OhwSZxV9FCX2ohFRd/4m1unLj/w8x3aUEGnrp7?=
 =?us-ascii?Q?ao0fVUBWEwX2FJ8IZQ904j87k9SttQiZg0P+jvgI5vpA8fqOHLAxF26fhwaT?=
 =?us-ascii?Q?LfK4XsFOq+eq9N5Iig72DgAOzZOw5RpQFsBcUQaMXwv71b3Yp2+WtrdGun1R?=
 =?us-ascii?Q?OuHZDTv0IzxjEZd5CJMGuE7RslgJ8aHJyxKegwC5/FxuKBFR9+uwKc6/3KcT?=
 =?us-ascii?Q?CN8asma8mPYekhJDdJ9nrO61OBG7R2XPASotFg1g7yejIEMh7s34mViTcvyt?=
 =?us-ascii?Q?xxnzNdwxIrCE3jN519kmcvnRtJze9FoWRtxdTb1iYKfP0Q3qwaikcs27z3va?=
 =?us-ascii?Q?izhuFENbTIUyoiCwcu0QeXN2Opt516bndJlCThhwEBNKpBhHDsnOXARgdV0g?=
 =?us-ascii?Q?N1jAPUKA/NUW21r+Bhn8TZopVoXNWABoIplLVAT9VSEyOER5HKCZkQEPkkVl?=
 =?us-ascii?Q?hWYxBrZnJmcoFsR2xEHk9DzMUdCGqOV5C9dJH+H6Abkufv73opS8B9H2gXB+?=
 =?us-ascii?Q?RwDdfB88yrq+unVh9paeRui+dYd99guYfh1nFEbhY9T9RleCljnhwj1BUyb9?=
 =?us-ascii?Q?fODmu7Suvbj0mMgFmDr6y6z77BoHpIkmMwvn9a1XooP0V1PVpli3zPeG323G?=
 =?us-ascii?Q?B/goi40CePDT4qTz5S/i6I52IbEObareJ+zSel682CjReKzVJJ314JMh0tNG?=
 =?us-ascii?Q?7ItmOGd8u7V2Ft8uJ/38UJbtwHY3xPvBpXkEUCGbGaU7I33ZmTOnUjjXBemo?=
 =?us-ascii?Q?Guq6mdMOdF15pcDDoy/iVK75q1FZpNAmi0AWlkix2kxJ9Vg4REPnxsJKsxw8?=
 =?us-ascii?Q?a5rLu6ayPS+e/31dDzfN2CHiTsYWGtZoFn3Aan4K/hHHGE8783X8amCjErNJ?=
 =?us-ascii?Q?vpE6t65V3bvFV0mMtLu14P6O4000WX2oURgSHyX6FiY7RDZ/Nrchb3LMo+Zi?=
 =?us-ascii?Q?/Dfore9EylLuSe/aWcPKM0FyFMu7zYx7maBHF22kcOm4e593tsvW3A7qYgSp?=
 =?us-ascii?Q?wJtz0vV/4CuCqT9JaitzJzoi1r7i2f5x3nGVM3kELw+i/u34hWpdtsV08xsc?=
 =?us-ascii?Q?W5ijvpDx+S7dCUXtDoGyJhC3tGiFp0AAxSc9M0h9yGbovSMCTI3RxoPXxt6d?=
 =?us-ascii?Q?IT+aezoSKISWW3KQoxDFXS+WJWu6eQmnj3KtL38M1qmYKZN8quEMaT/JHE+8?=
 =?us-ascii?Q?Oigho5D+T0veDrU/VT/YZAeqhh5rcCDZcIT6xoZ0aHawJUnIqjjNTlZ5bZW0?=
 =?us-ascii?Q?tKxLuEIQkzosHL97thunngJqvhyBz0ZhIxoT+lyk/XWUHXXpgOjqJ4g6AUuI?=
 =?us-ascii?Q?9RExpMNMvDHzxUB0Exg6cYGRGArGui254Mwd/D527UdtIslGx86bvd7cnuN8?=
 =?us-ascii?Q?odLxG6GuAWdzB1SyW1UhCFfXqOxsgjuSZx0aQoLV5WFMcbiYpNiw+NCUE5wR?=
 =?us-ascii?Q?hKLAG23pTxWQWBro2A3xjG+dadLQs4XkeFA+RdpEcKj0Rip5EB5i9VcSIYRp?=
 =?us-ascii?Q?N2noD9yJD9NFQTYfornZP0PDgwoft6nhvYUFBhQ4MBmQtAvbF/y9f54+Co/m?=
 =?us-ascii?Q?jQFiE5C3Obn+eytrgfM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ulvhwbu3Z0zbu4RnYYAxZD1GL0UqVFp19TRo42fusRXoGd/T7PpslIX/wW8/?=
 =?us-ascii?Q?vP8anf5aNgqQvylhyQURzdLebFnS1kx7D8zUvNxZ8XprNd0vsK46NFYw652B?=
 =?us-ascii?Q?RFXPBfiMbNpN+FNqiQIWQ7k40VMa2UxTl7gw0tAtKk9QEvayPzW1dLuDqVIe?=
 =?us-ascii?Q?d6T9GBod94UU0THIdwMmTbnpEbEhXUifRPR5LlUbCPuFGNHf3sZDsNbTelba?=
 =?us-ascii?Q?s2yFvmR3WZ25trP7Ce4t66/klU6dZSM49HSwx9xd2nAGFtzSUh8gl6uUeNmj?=
 =?us-ascii?Q?ARFs10tB5R5pL41KOFXidSAXUh2SDhzXOIF4gJ/lNuAvH2fyzHplFrIX30lV?=
 =?us-ascii?Q?YkTwXG9vp+7kizElgRjYgTdEsL1nBUyDtRJPAxQZNdViBr9ykAzJ/j8SSel9?=
 =?us-ascii?Q?Qp4u5JB/alB2gcfWRnRuJehcJkOJSCmrJYw0PM62ZMSgfro3H1Tnn5fjRiym?=
 =?us-ascii?Q?Fuqfpp0VQXorcGbITqxvbBa308qB4NRevuWd/KwB5sZxMQvm25rGZnPZY0C4?=
 =?us-ascii?Q?k3DCT4L05B5IhnRkN4y09RVLAbNmlY3x/NLf8BD/bM3MJJ+T+dAZL+A7Gzn2?=
 =?us-ascii?Q?r83LfKwjkEEla51WqeGDINn3mjKtiZ1t6w95yQW+4bX3IymhTQjC3/hkHJVf?=
 =?us-ascii?Q?T9HYLn1ne5gjKNHNErtNxdJ9bEZLLDuGOkMiekJUc2ndoSDbQYaZjR4iVFZv?=
 =?us-ascii?Q?7ZIE23BnrUJt9orIhsYAspRPM1FRLDIP/g7ARyg90N1+XTt1wOXXZd9IT7om?=
 =?us-ascii?Q?USNlqq0Lh4B+ARaimE5YDIXLfZ1VSutBRSX9JPqP93ohXW5nzFrG3nQGOsKU?=
 =?us-ascii?Q?2L5jbtalA9Wp1fNS+CU6OutRxb0B040Nd3AtzgJi06633+lIvLlLR1przpFl?=
 =?us-ascii?Q?8UhK3YmvmCsVX9ryrgKua8zCoGTrPMIi5RskYEthpVG+K/fQoTLuxzkDEKiN?=
 =?us-ascii?Q?WaVG5SPoSIJlw841hW28YJufRJILYKJXy1PPIFoglifAnt6Col8g/Kp2S9Xx?=
 =?us-ascii?Q?qvrSrAxt0q/U9vSs7y2PK3TXf2rHzS/RdhShiQq0meDKTSGBPbN58l9axlJ2?=
 =?us-ascii?Q?/HM6Kr5M490fnqbIfOs/heWGz0gH5gefyMYDzOOU6sWHZsCgJzf1e5Mh+hOn?=
 =?us-ascii?Q?5gjD+4wbbfcZztCR29mgYn+uIPC+2HatOorphNYgAzKlJ7hY0OPZQxdBEWAf?=
 =?us-ascii?Q?CoMGX5wuYs+bvPw9LdYQngljAbE95zBh2xDwjZbXaNL+HriovhLgmaDgcl0x?=
 =?us-ascii?Q?ozGBHX3gqJm0WcMvUAzt2gzmU15LjW3YSg5FLvS7L3T5RPMg8lVY99kkmncr?=
 =?us-ascii?Q?R/mtHvrZOmxULs6bPjhhWqtQtVr/fE0Aofc6s4Fa+j62ecpGz3+rHZdVubxd?=
 =?us-ascii?Q?6UM60q44KuQgq9t9xjfVcVbBp/kgk1GiBNaKi5p5IDes0ouzRJkHxHxyRMBP?=
 =?us-ascii?Q?/UFI8sBCnRhsv4AjcIBrDGo6KzmKBIPbHSUcB91uGAfBaLariz6tLkEYNwQT?=
 =?us-ascii?Q?rl3ibRs87fXhgruPKG047ulALxO/c4uK5AYNoYxrV+BhgEzFmTbchHi9vtIz?=
 =?us-ascii?Q?Qp64q45xEwBXWTCxEerPqAI3J1cpCG20f1Jb+k9ISLEJpqYyGaZ4mEx2tytA?=
 =?us-ascii?Q?qoQ4cpBJhVtl6X9HX8i5jYgliYctOOiXSFsSay76gYi1I/Ta416Xs6+U99QY?=
 =?us-ascii?Q?XlHSZiwuJCFd+PIUQpuaShtTv4TDrQWfQDe+okMRafM7+7x+depJSQB1vaDv?=
 =?us-ascii?Q?MDGgWKumMy3lODkqhedUVm2TFKrwNME=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aa1b79-0e2a-49dc-b7b4-08de54ff81ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 13:02:30.4093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKjQClOslF7gWXdpwCYhhMRZLRsu/1vc7+7Z/VJBqu4qwBT752p7v8f80LQORYFTfFh3oh+bb/94znusgGwDbdrB5pxgd/MsZKoaJd+y1k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
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

On Mon, Jan 12, 2026 at 02:53:11PM +0100, Thierry Herbelot wrote:
> When adding the i40e PMD, the rss_hash_conf_get function was changed to
> update the RSS key len.
> The corresponding functions for ixgbe & e1000 were not updated to
> follow the new convention.
> 
> Fixes: 8a387fa85f02 ("ethdev: more RSS flags")
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> ---
>  drivers/net/intel/e1000/igb_rxtx.c   | 1 +
>  drivers/net/intel/e1000/igc_ethdev.c | 1 +
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
> index cdd7a3338f61..d5c2bc013702 100644
> --- a/drivers/net/intel/e1000/igb_rxtx.c
> +++ b/drivers/net/intel/e1000/igb_rxtx.c
> @@ -2042,6 +2042,7 @@ int eth_igb_rss_hash_conf_get(struct rte_eth_dev *dev,
>  			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
>  			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
>  		}
> +		rss_conf->rss_key_len = 40;
>  	}
>  
>  	/* Get RSS functions configured in MRQC register */
> diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
> index b9c91d2446c0..9f6ada3bc6cd 100644
> --- a/drivers/net/intel/e1000/igc_ethdev.c
> +++ b/drivers/net/intel/e1000/igc_ethdev.c
> @@ -2559,6 +2559,7 @@ eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
>  		/* read RSS key from register */
>  		for (i = 0; i < IGC_HKEY_MAX_INDEX; i++)
>  			hash_key[i] = E1000_READ_REG_LE_VALUE(hw, E1000_RSSRK(i));
> +		rss_conf->rss_key_len = IGC_HKEY_MAX_INDEX * sizeof(uint32_t);
>  	}
>  
>  	/* get RSS functions configured in MRQC register */
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index a7583c178a14..a2c5ffe0b3b0 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -3756,6 +3756,7 @@ ixgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
>  			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
>  			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
>  		}
> +		rss_conf->rss_key_len = 40; 
>  	}
>
  
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Code is correct. However, do you think it would be better to use
IGB_HKEY_MAX_INDEX and IXGBE_HKEY_MAX_INDEX in those driver assignments? I
realise the loops don't use them, but they probably should.

/Bruce

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59EAC61DD6
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 13:01:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38940427DE;
	Fri,  4 Sep 2026 15:01:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C79AE4021F;
 Fri,  4 Sep 2026 15:01:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788526879; x=1820062879;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=g9rc0MfTPsx0P2puXyglc7XPAyc9N4bISXL72TRXbbQ=;
 b=LxGbyjqpLU1ZRTZPR7/uwkniFsvopD4uQEjEYN3CF6SjVnp7ZQ3TPuiy
 3oVJD2rLiuvOKE2/9idG1icXRrUkxpQj07+OMH9GMi09SplrJO3uyg/Bp
 RVWDtTwdRjHs5a3Mzz1oObyaqcCewDYsBhGj6Y+Wbml0PxPZz8nEzpswZ
 /vn2lxOgW4QMsO/nzPwvi8l4MwHwHBV6cnThbdAiAY7/n5qgkBnuOxxDu
 /ggHwkgB6mdIwI27Z7MZ7Zk7keUKhAKIRmmE3h5RfQsr2MuqEUnCtkREq
 bwXmCmTAiKRdYaRNWKzLT8sgbtcEamP6eU7G42ylLJ2rEzxlwwFPny1L8 A==;
X-CSE-ConnectionGUID: h3rAebFEScWZEpRySDOiYw==
X-CSE-MsgGUID: P2ZbLjLhTxW8Uy/grsnXzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89082206"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="89082206"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:01:18 -0700
X-CSE-ConnectionGUID: eutEeTYdThypr/XGM+1vtg==
X-CSE-MsgGUID: ilyVRCp7TqqBnmU1IJ0gZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="293542671"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:01:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:01:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 06:01:16 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:01:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuQNE8rMmnw43ipUDdGANlFQ2yAu7MiQkiOvNcZI13hWr+ERKhINMAe5DBaw++NYxYDIWaaiMEw8fl1YEglliEr0rpsh3VzDw44RoHGBNKYbkkSGOYjW6iJ/KwY4PYGvVJMZYVe5/us/w915lHfZZjQgxeh6L/9XeMd/QPjIQpdvYhsc4ct645qwIaVdBU70tzlXSpFxNAk4rZaNZvEn/agVoFc1aLe+UFfMS21HnLAPV73LDlozBPjtbpPZdUH3kXKUiwczMX3dp8vUwu7uprgTv1KR8MZb57PrBAGpmgg+hg3zkpCbFAsUfQru9vu6nlXQscTjUmGyl7lRQzUcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cXlsdNQgU6oTfQ4ZXQqmG/b2u8fnTwdE/vK18lfnfo=;
 b=rEVOrRDSZqJF71o4zUX4JT32k/rbARiBxC+AkTrrSGvynfPvlACfxTvc6dScH7TvRp/KsctqrgsFuAzItpoIS//gDwj4mYclHd2hpTrDHiDgtXe38WtM31k3jloZOie92OUtYJsfZTB56dqSMeXGjE9bbVNwLL3pYOeaYi/6JbrSORjzbckcU33Dk7Fdz2RJ2YPBdpiYdoe9D57GkwLXx9BC7A4+I0M5f9mI/pKh5dxmkv80xPe90TxqdXmH3CwyVm83IZ2BQ83KV06TzCCQ/Pe4hPPal3IG9HU+Zc6LYhOyrFioNm0DwZF6L+CiWKhGy/7bscD9rhX0p8djfOLB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS4PPF399DBF572.namprd11.prod.outlook.com (2603:10b6:f:fc02::1e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 13:01:04 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:01:04 +0000
Date: Fri, 4 Sep 2026 14:01:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/3] net/ice: fix Tx queue capacity sizing after TM commit
Message-ID: <aprBDKLb3NSxhESE@bricha3-mobl1.ger.corp.intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260904105139.3117640-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260904105139.3117640-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0293.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS4PPF399DBF572:EE_
X-MS-Office365-Filtering-Correlation-Id: f98e1f8b-ac01-434a-25ab-08df0a84940a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 13NIl0YQayVim5wxaL06CAFfyRfy/XwloXQrBwlmvw3v4PRIxMKVOcmI6qh1onpB3H0xdhumWuji4UQ7Q6kTjB8TbApHm8UrBihFRgdEOq+gWYVPmQDibvTQhiyHYixdGBrZPMACS3CETlUUF75S489ATeukvL50D52tVTmeG4Pz07B7pmsqd61VETeblY4TO3A/9m6FSgcrLVsCub4mL1zJRau+ofAPXT5UmSnOtfjl5r+kgsdlzSnGuqbJUkgMnlYAbQHPboesWuwr4gu/B9YDXQiBNm8X42PTUWt5+ah8GeJEUM+5Q7ec3TB/Ecv1PnBkM96Wx39oSisuoT9Lys4YhKRl/8oaMcSbsHoFDKkSn8Vw7n5s/MhVkIA1bzJhhwjor14+BdUmF82YBkgGwk0nVXCmIPT21hnjHZfLVS4LoRvPc2LFPhf9iNkxXB3WVTwvHiX+CI7PQNfqxnEag3l57YWRuDWAWA8p6IGN4aMlGyZHslT9RjYZByRDUXkqooXBlex7lkXNf0fdHo5ZuLqB0/AiX7xB9VI0oQlApx1NSTxft1/+aabgenURK+y7Byv6p2KmTES/j/2pDfwvSI7Wl2n/S2EQufW6xI0ZqwHpkoTPrBS9kt7iBIvp9TpXIvkFFxCeTPoS5MOq0WOaJU3f4bIu7+es1SctiQtHCX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGkYmSzZIe80qddH/pc4AUnv7riAfo1BZGQ+SHKsi5RLGNh0jGZQesuAsBmg?=
 =?us-ascii?Q?ngjJZ5itsKe7zEl/jFaAIVQ1jEHhiyVZ7iDywIfBcqvnKObP8un6JG3DvttF?=
 =?us-ascii?Q?NQlMA/g8/jECGvT3HSW0Mi3hw+HpRCrME4Ux+iUZC0/UNUVdxZFwJcKPu7UF?=
 =?us-ascii?Q?Lf9UjcCXkOOiEjSq+jD4aneJYoTuAJU6K7B461mkVj4ru4ZxGCSvT5Be9+8v?=
 =?us-ascii?Q?blwAbWSINoyd2IiS8v+zg7DmGvOP7Tkow2TMS6P0hwBT7aw3zdEY5i0GDSR+?=
 =?us-ascii?Q?BCxHp96cu3USM0KepX+/2i+myNINMNL7Z0TTQ4jEwzR8Cmc5zR0vu7nAA9IO?=
 =?us-ascii?Q?h0t7uGgeSByaJ4F6yVmGAQfd1aBOuM35yMSKbKOorm1RpKIdFYkoG+hBTCq2?=
 =?us-ascii?Q?VV/0Z8NhjR8ogkR7luA3jiPFGHLcAEFum9p7t5qr6KW3hyysS/E77eA2f7Ks?=
 =?us-ascii?Q?NigkgSqHiTTV2QzXYewsrJYvlA8ty6Z7VqJneL6suSKnw+R8H6dqj73eec0J?=
 =?us-ascii?Q?24x2aZFQ/minOmf/Gy414+E1LA6BrSA5l5aDZIequOEC+fMpLtte3FTmU5oT?=
 =?us-ascii?Q?Gyv0QEBRiILGTXhtJ538AO1qr2rmc06yl2ICxsLgA9kPlDwx7a01jj3MPg1I?=
 =?us-ascii?Q?n1V2iVYLTP27l384uOKdrCglr1pG2+XjIV3US7EXrSUHH1Xuz8LU+Avh8Vt6?=
 =?us-ascii?Q?bLrhcj/1tnwKCXrl43wCK3mtXI+Ggh2JnDhA/m+1PsVl9z6WGlxdIpD4FMUk?=
 =?us-ascii?Q?uDYYViFVVbxT34ijLCq5Kh2NFtvGyIvBEIx079xqAw1hhgzKySpoHw5SGwUk?=
 =?us-ascii?Q?wfm3+W7cMN2KyfiKsmVFJ6RLuKUWNUpwGfP0fcjUEWRUmIdN5iFz5EZgVUoX?=
 =?us-ascii?Q?Z0z41c4elSUBdqLbb6JslnwucVSUvgtgFS0BEEmWfE+qSR4S6uk2+8F6oB9p?=
 =?us-ascii?Q?u8X1bRdOzCqwJT4oQap5DPMNSQkHQ6oeIMETZwXZVFnzl7y0Le+2w3tnjEd4?=
 =?us-ascii?Q?CacGmrVcNUoFOc4F/NOXkhuJFWHmETEfEFGxZdX7qhS5TMiM2Zqf32C5wIPW?=
 =?us-ascii?Q?JGYkoArRRyJCHdrjiuSpn+5z6vIzLuWdVz4u26dwmN/wgLS/v/G+SjqwbcBk?=
 =?us-ascii?Q?OO94jzLmeAswxayFydghuA6Fkkbu9thHAWjpsa2pBEnhKppf6Ls3bBnGO3wd?=
 =?us-ascii?Q?9YmfRUge1sunaii0CdGs3De39PEv60kSwgi7LHX7WlHtZNSxtmFBgJAoG3jm?=
 =?us-ascii?Q?4Vi1GG5PE9loV/eBaZJhZt1UxjPGmqU57i5gxjcWti9enIFHquyCMt7EnKoL?=
 =?us-ascii?Q?LhBJIRSnyq1Pn3DrRs81hhtu4aTQvbKmsWDxw+yJKuaw0vLJktUD2H/Yzuvg?=
 =?us-ascii?Q?evKyeL0YjdVfA4EPuqfERep3Iha2PsqtNUBADwAn1uBU8elsaWX+341DVIRS?=
 =?us-ascii?Q?Sa/ih60uR8ZFyATiN91r3bo2r7MgBJzRJLcwm2KS0tiJEnxGj48Ep+2oLlHk?=
 =?us-ascii?Q?POBo4LMhq9DXrceUL+KCX5BLYBMrUTGbJcUjVqfoxhS+HULPISq8Xq5+XG+I?=
 =?us-ascii?Q?5HndbR028o/QOXQAxdyIsFA3+6j/rsMWSxzWps3Y+P0oTX2Rlmg/yvheW7Jh?=
 =?us-ascii?Q?L11v3y+LJg052nHDTSbx5GHb35g9BrlmpZT2Wv36mvThX2c4Qg98F+P9LNqy?=
 =?us-ascii?Q?P8SWTkM7EUxg1E9htde9sx7RWJHIGTPDfdWtnmaYu1xSeTdJqmH1egzW00JV?=
 =?us-ascii?Q?xeHdj/hiCfsxWRF8ZPr22G7SKFVqGtE=3D?=
X-Exchange-RoutingPolicyChecked: Bk2kZzAKqdE/J7GPar8als9nIBo48mIjZFikRQiF9EsASEH6Rjbceb17PFJbJkWDMyY/BZcchWT2NLxSSMEQjrUS/0qVaHJb8xJwu2H+HmhWSE9fwzzHRsRg78aL79XdAz/a1nhF+1NYCfjKxmA853M0vGWJjMl9uJLTI4srT4dGgfM79sByhFayC42NqyN+sKfqrGEblr8FnBzdhkfCCNmYPVMPptyoC8qqHi8nKos4egVx5b49KfGacfVhN2mR9NUWTvuFQhc35iSSb9kvxZ2E6HuOM0TKr+gJPO6CA+jxT8/zrzHt/+TiN8O3YxN8xVVimLjFDALUd78/xjovyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f98e1f8b-ac01-434a-25ab-08df0a84940a
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:01:04.7243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szxBIrMbQLDe0TsWupg0Vlo8Ol8379Fd4ha5wFLdzlXaVZwEGlJ2sfwLEtsrBMxj6erP1bxj+TEKG3VWZbKRE7ZnllzIxPW5hOwo80Z7/+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF399DBF572
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

On Fri, Sep 04, 2026 at 10:51:37AM +0000, Ciara Loftus wrote:
> commit_new_hierarchy() computes the number of usable Tx queues (nb_qps)
> by indexing the arrays nodes_created_per_level[] and hw->layer_info[] with
> a value derived from ice_get_leaf_level(). nodes_created_per_level[] is
> indexed by absolute hw scheduler layer, but ice_get_leaf_level() returns a
> value relative to the TM hierarchy's root position, so the index used was
> off by the number of hidden layers.
> 
> This under-counted the qgroup layer, causing nb_qps to be computed from a
> shallower layer than the one actually holding the committed qgroup nodes.
> In turn this caused rte_eth_dev_configure to reject any nb_tx_queues above
> the miscalculated capacity.
> 
> Fix by converting the index to an absolute layer index.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/intel/ice/ice_tm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
> index 2e6ef9c264f..651d6aa932d 100644
> --- a/drivers/net/intel/ice/ice_tm.c
> +++ b/drivers/net/intel/ice/ice_tm.c
> @@ -848,7 +848,7 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
>  	const uint16_t new_root_level = pf->tm_conf.hidden_layers;
>  	/* count nodes per hw level, not per logical */
>  	uint16_t nodes_created_per_level[ICE_TM_MAX_LAYERS] = {0};
> -	uint8_t q_lvl = ice_get_leaf_level(pf);
> +	uint8_t q_lvl = ice_get_leaf_level(pf) + pf->tm_conf.hidden_layers;
>  	uint8_t qg_lvl = q_lvl - 1;
>  	struct ice_sched_node *new_vsi_root = hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0];
>  
> -- 
> 2.43.0
> 

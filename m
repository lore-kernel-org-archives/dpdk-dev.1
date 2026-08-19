Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E67C5DF6D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BF71402CE;
	Wed, 19 Aug 2026 14:52:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 23E4A402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787143938; x=1818679938;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6akSIw9aO2Muw/dJtI/iXjVdUPczvmc7eCxfyq++0Js=;
 b=UUloYuvloUuexeLCtT++61f8EFigGKvLJTZHSot6aWGdhKWPgm3lTNuc
 Al/ZmWPA9lEy7t/Uw3axDeFEzW90mdDRY0yQPClKWcL0w/UvmGLoT85Er
 k5X6deTru/o/B5WTSiFDQ7LcNdzcP7nNsnFu/Fn8UfkgV/r/McS4zUGv9
 gCsUoumkaoL5wv4F5A1MDhcnM/gDe48OmYUTc6BCNxH/ct44nptpVv1+0
 O1kCKCDTprCymA2HwnjQz+MbPy7WTOKEUrrOYUNFcu/WR7D2/CToGAwvY
 HAqJSgFl6wpAz+fJFvIffmCDvJrXtjiAGoJ5CQFsC8soCaTxJRIN8pxv4 w==;
X-CSE-ConnectionGUID: NytL27jJQf+dlyWLvkp3vA==
X-CSE-MsgGUID: 81+tWZJcQzqQbZ4ebL47DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98816777"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="98816777"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:52:16 -0700
X-CSE-ConnectionGUID: vwlYHR7mRsKhL6N9MDZ8tg==
X-CSE-MsgGUID: TEYVsX83SlaVB1PnPN+MWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269048673"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:52:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 05:52:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 05:52:15 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 05:52:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ29FsdsJedCjYYUyHcIYd3Btaiz3cPxSju5rujsSwPOXIpyKICrdCMvzRL7/NpBTj7FcYjAr52pCVmOcOq7yLWU2orjr3ckFgKD77FkXxSJ/Fz4+BZfEGqtgBtwqvqWucp+GmYSxMKzvpagxfIYIf56JJawYD5XDlyzi4546Fo6AXxZnr1j2QVS3dHPLhvoc61+ZG8muN/vl+LpqubbQDyr8wVebyyS/NcDfXAu0mNccNioqVl0cmQfXBRiUgi2yiDmYWhWeD3ddx0JqOAz9Sl7MQvLwg2PUp4osdwg2Hjrue1n98UQQJFjDMFgvoMy3fxhPN6RfD5CWNV3k6qvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBVsj/gZzoKSuxp7u8UhCgUtqfpkmoZmZpFKaAFpKPM=;
 b=r8QJqRyjztgtY4jvc19vUXS8j2DuNTjfpdEKUnpu5CtTUbvVveFqdD0qlJpZiaEyA0HxRm0QRWb+qYsB4Jh/Blme2Q9Q1V2HjZiRLTQRJuaO6Vu6KVwxO1EH7HF5skWMGb+sVj8dyEKc4kTosU/A5yD+H0PrgUvC2uqZNZ28eWXhEWRfYItLXSgzf87W/7fK0SmHqHawa78GfAyq0+Fy/OmmZftj560mIS7s+YdebyUw44rY/EK9QAOQVJJFGKxN/tbfgjCTV/BoTjJc9fTG9NnC6qOApJxCcKVTBOsJSmwsiKAER6fJR30qb2HvfzGAIe0+rx0YOQjk2GjC2J2QDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 12:52:11 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:52:11 +0000
Date: Wed, 19 Aug 2026 13:52:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 5/7] net/ixgbe: use correct index variable in IPsec
Message-ID: <aoWm9nhRw4rEoI3s@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787142684.git.anatoly.burakov@intel.com>
 <cover.1787142684.git.anatoly.burakov@intel.com>
 <5cf7d8f5cc8470159d7ef69c4c36189d20ea1852.1787142684.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5cf7d8f5cc8470159d7ef69c4c36189d20ea1852.1787142684.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P194CA0023.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: a35df03b-fbbf-4c7a-5efd-08defdf0af66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d5gc6/doNrd8+ZIHx5tzKIGV1BOrwHwCEgaGscX6HnL5OGSclpFspDgp5dcBpr6MFyD3qmb9UU1c6IZF3bLrTDoSkAXKVNQN9vaG15cNnsOOxFAu/SgRTs79HPc/ZUaIffYt8JJbQzBVZJ/G9Dr/Dn1yAJ2WhdPJ6EivLY9c/nxhD0FeK/vy7yl1e2cxzZXWTG1EGd7DYx/un60PRXZ8PG/2xfiwiHd7aIkZDAYFmkaKGbDdyEcDdEDSCsghp8C8HW4bIjSLKaXJi3xpWlP3xmc2ojakqRmD1FJ3BYuOIbzzcmf+rUloEuxA7d3vTQba95UTW21SyI8b78sEZQBPsV9dcpPeGW6v5oGhU5FEhN+vZBRja0FlEBdF/y6udD9fSEutywdAvPMbkId3oDdpCt4UdQTFjpoSpUqA/fyJmiELEFSafvb8FPl5ipJ6QOmLIlXc7QK+5rVA0k3qf50cxLkGDe4b0+UBoOPtxF3+l+2QPkUKY3ZI4MhlAJYAM485Gfwlriw3g6dTqJ2bdSWHtjwTueH0kOeybWuJa5FCpPpg1mgcC1TMXuASYePnZH1/QFDMO1qPObVc9qHx3lA7G8xiL0PpioQo3hx5qMPhbi6iJWyn4EtHuDROpWgXho91TurlGkMOA9KiNGP40ihojeMxPhKO6J9R/g6+dlcRHno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tMKNA7PSUrTOHn+bSLBR0CwjEudY8PxvCa7KGhmDroaVsp+KfNkXFJa73Zpq?=
 =?us-ascii?Q?Js2PpbjSS8TI8MIC8sN7U6JFwrBX4sq6zcgfleIeGeceZXtBuSsHUs7j0I03?=
 =?us-ascii?Q?kZXezsDnzcF1FG+DYqyJziLXb+uqWd0Efmba0R57ol/dnP3nmyj8TgWQ0/Ev?=
 =?us-ascii?Q?QiMWigFIndxTaBlyOj0cveWyX2cwS207u8eVnSclsbwVNmpsKPDXZjl/cWpW?=
 =?us-ascii?Q?Y9b6uIjoipB7/N+1TZssgejjoQnw+KoT5dGe0yczeNY2/EZz5j2LCUCA7/pj?=
 =?us-ascii?Q?utbnQ1jfjvw3rItSnuO2SljS1Vlz9zseAdTrHGREKh4xKPPFsFT+LR36ANLP?=
 =?us-ascii?Q?KW/HbXUfSwkAp1pIdO5lnWpZ/oR6EMDYizeMUhGMcZlQWRFRYRp+IC+YYBbT?=
 =?us-ascii?Q?JUt1YiAyiNwl04X95H5A9MbgNrQCV0aDTguZeKCA3gklV/gLmK7PX9Xf1hOj?=
 =?us-ascii?Q?kzzIwkcEuKDGfF1/ApTsubCE8WyV2cvfR+HYUjbE/rrj70oQAmRT3LLsGaO7?=
 =?us-ascii?Q?f4EBSLwv7goZiO06i7zD4ShCqbpZJee7t0vLaPUzQ60OUnp0cUcgkbLW3Znm?=
 =?us-ascii?Q?xBImkPADR/swbA261PuUBqxpIHn5njIOOlQFjFGO6Sad6vuBwxi/1o8rEf9X?=
 =?us-ascii?Q?L6GE2cw9+GZcMXtOj1c7QDMZFjiSt3gB6EMCQlCL1CmMp97DK3k3kpOUAT8v?=
 =?us-ascii?Q?TfBh4YZScQlY4xff7Uhxec9HpnXwoDgdOshrq2Q1fVEPXyhZ/x+QzaMTw+3f?=
 =?us-ascii?Q?riWcfix/9XRFupwmeD3VmPHerOEjml0XqaI2d5CVuj18sGS2ZxS9AWpWSOWT?=
 =?us-ascii?Q?UbLYs4IBmCuayal0Uq/3KeoND8x1hQr8gYCKlMDRw7vA9QMxOLoSnsyc1Wez?=
 =?us-ascii?Q?0yXRQ6ps2/YTkwPwK/xGfUGt452Y0hsycIWKLIkH0Opjc3oIZVZFdkI/xpyz?=
 =?us-ascii?Q?ZSBa3naeewVEREFdTlfcdYyBwcBH0JV28fU7QgHkWX0ux7MBiJTtqME0a21G?=
 =?us-ascii?Q?albnypkahG+N6goOg1sFvikTgde+yGVJRaOxNolZ7tosS/tLpDF0rM/iJAvT?=
 =?us-ascii?Q?YgEoHz8PpeTpKqI3A57dZMbdBpS2X9RzR2RugIyBhuT/hv1oZzMzEIIPLFgf?=
 =?us-ascii?Q?ztTUXwn6r90Dn74K8U/qVxgqpfaiDhzroksnVqbblnFO6fiWXD7MCuzNyaVI?=
 =?us-ascii?Q?adJB7e4VboYiZpbvdbGH0Z5UBdMbl42EPpiNqL94ca7SeJfildgj5b0ZsnRZ?=
 =?us-ascii?Q?Z5nkxIJVZTAtgfRiDdbqe2CX4jPo4JdMlOhjp/3lNhifGJQmOf7ARl26qLNT?=
 =?us-ascii?Q?nCjd1jyFpQlNa72DeHB1noaCG05cEFzPxvv2kEmvz6h1WVFYhnst3cF4G9T0?=
 =?us-ascii?Q?DairMQH1FbpNp8LasNi/5LPwwFz99WxaqBHdjJ3cDL12EfCfp+I70i6e3/4H?=
 =?us-ascii?Q?77/5yqfWBkfYJZcN7IRBx0mFJeexaa4JwKn5fq5pzhLR1t4ae7sdABH//VYA?=
 =?us-ascii?Q?FnxBtEPD7yYs1EJ4d9W/iP7bO3XAzmOfM2wcp5iH81i5/ekV6z7DHC1W16so?=
 =?us-ascii?Q?d1JFNuIy5imw0wTpOi5J6XkhMA5WcDERotVKFrY4wLCXiBsVwp0U3BLalOch?=
 =?us-ascii?Q?GkEmJiEcHd8r5AcsDLWaTqr6BNn3Bc43BxpkgZMjfXt4WOV2hLnWzVbQUgt0?=
 =?us-ascii?Q?ghEb4j3U7RJfzE+CxAPURgb+4ija/aIzNPPWvIiKI3A/J6zdnoaTUT1vT3Aj?=
 =?us-ascii?Q?NcLek6EPYrGgr9s+qDh0zlnQGlRgFbM=3D?=
X-Exchange-RoutingPolicyChecked: KWDblfAjK6Docxw0PT/B4cNDIzGJvrK4bLx68t49bpaYqtkgPTbcRW0jNyb9h3IawSymYRjVCxEn0WgSwHE/A40CclTNZ2n+BAJ3hMm38TQ2M+ILgazNxCpCGHtsJfSNAqVQTttW/cENjKtlJIc/DUTnafdrob8SswblxHEo7d80NRxMJdVewr0qLnhL+20svMcvY0xj67XBFA393swy/8EyJ/RcNcPqD/RSTL1gKSflti3ZIRzVsPeRYm7Ld7/6icFED4p6+lTJqgD9pmTgWfpI8i7aq/QH/n7ls+pgbdWDfhDY8TV1Rylljrv+qA31N/RZDqBTXhsYy03G0NDilQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a35df03b-fbbf-4c7a-5efd-08defdf0af66
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:52:11.1229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvEWaJzWj8dxebG7B/lpvyzoh59tA0XOxTGgujYOZPTv58n0FKZW6pfPiqX+5IuSBbRZnhZcQf+d8Th2BCbsNZHGGO0JMo1PcCLBNzOiyro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
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

On Wed, Aug 19, 2026 at 01:32:37PM +0100, Anatoly Burakov wrote:
> Currently, one of the Tx SA table accesses uses `i` iterator instead of the
> `sa_index` variable that was assigned from said iterator. While this is
> technically not a bug because `i` and `sa_index` always carry the same
> value, it should still be fixed for readability purposes.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ipsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
> index 9c4937fcba..f026a41690 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
> @@ -229,7 +229,7 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
>  
>  		priv->tx_sa_tbl[sa_index].spi =
>  			rte_cpu_to_be_32(ic_session->spi);
> -		priv->tx_sa_tbl[i].used = 1;
> +		priv->tx_sa_tbl[sa_index].used = 1;
>  		ic_session->sa_index = sa_index;
>  
>  		memcpy(key, ic_session->key, ic_session->key_len);
> -- 
> 2.52.0
> 

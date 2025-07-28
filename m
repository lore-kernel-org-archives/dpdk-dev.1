Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03134C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 11:21:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE6D6402E0;
	Mon, 28 Jul 2025 13:21:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8D0EA4026C
 for <dev@dpdk.org>; Mon, 28 Jul 2025 13:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753701662; x=1785237662;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tytzbJ6wl0PmamPmaOgtEG6C7Gckq9JkFpSozScUfxI=;
 b=Wq7hWvZJZAPf+nTRUmtC9naqTfLSLv75pJd8XCgjhuV22GktAen9f7M3
 m3V8aHjHFNWxmO+t9NjplDCvz/w/zzXJ3CI2EvJ+Skl3OpBbM2McGtY0O
 Q30x1ZDYbx9eBM9P7t/9eZdGkJN2ORE1c56HyD60VlzR0s7D+zcMx+3Et
 EhqPHqaNUX5GT/O+g0jmnmBI67mTUIS8chmjC3SYzgMhVawgKQzI49nSO
 vwThdV0j7l/ivEv2FjOobAf1VB5RHiWYW1Qz7UXeHoxQ+r3E5nlZMMMFn
 NgX1qmJ/+5JGWsQD3GKKuIH1HTcBE499cbfZARbOTd4EkcGeoZx9Nsg2q A==;
X-CSE-ConnectionGUID: 6Qw2FyvTTcaxExMq3d67Sw==
X-CSE-MsgGUID: +hZNpO24TDid6q7WsjaG2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="59751616"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="59751616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 04:21:00 -0700
X-CSE-ConnectionGUID: fXmDKXyfRgSpl5sUyrldmg==
X-CSE-MsgGUID: /dwms1n2Rne8VIn0pW86HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="166589171"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 04:21:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 04:20:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 04:20:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 04:20:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFO07Rl1yuhEi8U4uOXErAUCHCNq27xwwFBAnmoDiTcF8nujLcycO+kTRHPSradrUTbs+V175RPlfu9vl6YkKKEkOANWdG4X+Jo7KbCelY098muYjx6ZbZOFms8IunHshbxXeEXa15iaq0iNJmgUsTNxx5GIsu4aCSvXuz8w/2azUZ20P3SIHIiPogGE1IJly5TFyuRcMaK9TBHqEikXcaLQ/WFhm914Xl0C1dmhx0ue7nHC1IVZsAUuk3nZgYrhFJsS+HoPsurLZBGu6doEsmPVrP1BrThhFj+4T5zkB/fbU6bS1i8hiQ+b02pCn/HGjHRsDkHa5j/ow2OXDEOTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07NWPAwWKWPLU5Y3tiplUdVGz/lQorYPowI0dwKfYdo=;
 b=muh4r+hyUINcFDQU8iKA5w/Sdfkw/QalFzXdFKCOFlT/OFHevhecC6gXTUEmG664DjtjUMQI5vf8zcghJIitU/NRDCFKiO3B5Fm+0VRVj73mTXr8ClM0WMUESdWxgGjMU7fdVGSOahKMWY6eLEK5jB8Fjxe4bPqtsrBLyxb1v9r4kQW/labOWv++YnY2Jxhr9nJf50kgLlFKideevROEtCd9Vkc5y3LPJpR0Roi1IOuouFaTWS4XQ9O6GVgIx2aLbVlQTTSBcEWla0oPYRrChlwhwfnlF+tYD1HVi554PQgUmzf/5o0g9ggwocyW7PdbNxIdzS1UTRe6o44x4CWjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 11:20:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 11:20:43 +0000
Date: Mon, 28 Jul 2025 12:20:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 1/3] net/iavf: support qinq insertion offload for scalar
 path
Message-ID: <aIdc_kAgHNGL853b@bricha3-mobl1.ger.corp.intel.com>
References: <20250619133658.13494-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619133658.13494-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: e382e03e-eeea-4f36-3e37-08ddcdc8ca6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PjHjzBmgcj4oUJqJ5xbVhXBgnTsIFd7pTLORz+0Mlz5fwsBCpzEELDC4M7L/?=
 =?us-ascii?Q?TDkxVTe1Bynh3BFn5XbatvYREya3ZV5jLgaug+Qvu4G7zyJnAzilSO5IalcO?=
 =?us-ascii?Q?OeBXwycY6Yn0pLBfTTbEAYrUqK2xJzeLu8Wb87M9G3w7YfUDvPQQo2iJJ+6Y?=
 =?us-ascii?Q?rrQFbtETx17x8SGhd3bXciwRW4laLQAKa09XPI2U0NzzZNV2rArmqmtOSP3k?=
 =?us-ascii?Q?MDLu6mOfMVynjFqI/LVrVYwKYWbbbnLErKDqu8A67ry08wR1D70vcl3dyBbK?=
 =?us-ascii?Q?zQ5+r55UK0N3ITaJ0XbuOJcCbQFe98T8rWBzKu2YUekQ+T+iPFG1X2OYmNYk?=
 =?us-ascii?Q?HUkjuMQf3lGX2rATye8FGNHmFuqcVFGfeBQ+YVIXLJ0u6QE7ZA79at0VTE55?=
 =?us-ascii?Q?vvWHmMofzn1Gg9q7ENuyGOOHlK3R/5ipv1GfDE/R07kaTaMy0xeUmYOAazxC?=
 =?us-ascii?Q?NCxNLx9rDI3VQL8MbcKhwI3CKlygGBHRsBB/vap8FpbsUg9Ftv4CBrNN7ygl?=
 =?us-ascii?Q?3qERsRYa6e9sgQxjY/GpOPYRy2S7hV8OeqtnJ6DvN6EXed37VpZCm31IWOh+?=
 =?us-ascii?Q?725piZjQv7eFS7iKuvwMrqFVZmpEsNC0Fy1Wr/82P6IxcmYmT3cyl53BWzeH?=
 =?us-ascii?Q?6WHF9CsRwcQ8Ms5qdplnvBvpyoVlOpS8ycQ8slEutHuZz8N6gxjfzX4lvuKH?=
 =?us-ascii?Q?hTXuDi/AQH3TZGMAHbUPd6kkR2k3TEmN22iZPrswew28M4M+iV9+azmfboJN?=
 =?us-ascii?Q?1MQNVzuZHSXXiB3bTZ6c6tLPBUgaisTLPRZrIcR7Ol20oEMDuQYr3hciVKA3?=
 =?us-ascii?Q?stBuRy6N24S5uzeTqjAN2YlZMIhtsN5wu3o7wzIwyH6JFW3ZWwx125In9C4w?=
 =?us-ascii?Q?oBm4GCOs7uEQjOg7a9AhcnvWOEJurrtGZ/FBj+w9snqPBN+d1VmcJijvgrqa?=
 =?us-ascii?Q?2tSZbU8aoj9LLoD4nKEGdJd3zaHyOTGwYwzkteejfTL979OaENyvakX/Syvw?=
 =?us-ascii?Q?4VIPmsDsGhWsuAzQNWPwB2VimfMlT8r5vLxy62+grWE7Rr4hdCD3wbkt+U/W?=
 =?us-ascii?Q?5iHp46Dz5pawwV5qnnHyk1xuKx2EkHnj1GFTg0kU8LowDluixruBvRosuO9F?=
 =?us-ascii?Q?rtz08LZA/Oz6fN+GwolaqletSK5zxGYZ83Rb316x9INw8W73xUV01QhPIbFn?=
 =?us-ascii?Q?BNwcHXLSNME5muXti8nzL3FqjD2dHlwIdzoBlE+XKftOXT0e0TVi6gBQ0Lgm?=
 =?us-ascii?Q?WXV12kBl7ZJK12gJZ+mzbrxGa7qQtm7J9T6SFmsYFSOgEjiOnd7q0+oii7lq?=
 =?us-ascii?Q?v34hZtgPGdJKbV/pwa3K3cjXaGbOnye0sFfukvYPqL0YEHyLCqykmZ1mMvpD?=
 =?us-ascii?Q?e2YrOaqT4vKAIJYJ7aUanTQO6eBNln/CTlglRBRddiTQTE2Om7i59T6L0Evy?=
 =?us-ascii?Q?OEdlTeAlIiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eNFYaZh+df3taGhFiNPmHHINLNJS59t0+jf5kq5Ra9GCkOTRMYtT++Oybzug?=
 =?us-ascii?Q?GClS4ZqZ0stXms6bumZSnVby8fHHpve5y9gCOXwskFBI1OqNM4AcVfOB/CJy?=
 =?us-ascii?Q?fN9/+j5OaJw+V/Wg9BzZb/d7H/0Wx2mOhYUDr0kR2VCqiCFl1NmglCAKqVTt?=
 =?us-ascii?Q?Gebi36sD+U8gMaWNkxqofGJ6ylPrrNtU7mpBi5lMa6HTMtvSQ7wEp1IV+fhL?=
 =?us-ascii?Q?Tu3XB5s+BX/It9eI5wPghlMgAHBfDeFqvmLacmG8KkLCXd3bSNy+fLiDbmEf?=
 =?us-ascii?Q?obdyG0JdNFfbDUS8O5RwlWVVs6Bh1TjqoNxTvbEUV+VxNscNYekNx30//ZYQ?=
 =?us-ascii?Q?ZcHQomUeIWzGo1XJr3fLbIF4u3RZH0xO0t4ajz5haOBPbG38zde5Ybf5UFEK?=
 =?us-ascii?Q?bNXiWbfuND7bOEcSjgJqdoWSVVIdTsr6Yo+tSgwAuI5apyOmWny+DA88C0T4?=
 =?us-ascii?Q?JVvEje7hfyj5C/FTJ9h/KAL2I3DHQP/1CPityXFui9jAKvw1cmW4dYqMo4pu?=
 =?us-ascii?Q?kXrAnl+kf052IBaObqaJjvKzuwfc9dUrZiFMSFSynqDLi9rgGW6adX28+AnT?=
 =?us-ascii?Q?xdhCR+9UpOAbIhPCON7IqXA+bGkQGvB8guc5jWeyVq4q5omfhZk09XaBA8NT?=
 =?us-ascii?Q?oM30nXrIDKN6ZBXZiydrVmlzeq4yMiC49PEDsgfg+TT+DfzEX7yTodvQn1S7?=
 =?us-ascii?Q?vJ01+ZC63y2A0GvLkcUK+cFvZFIcXSSc2X8h1cvJSMbjkmE66xtg8KfiwY9A?=
 =?us-ascii?Q?P5e23ylP3Im3DcMulAqp2ELXbIOkKb15S9YWoXXgf5+dBhLk0mMrZBgHn8eE?=
 =?us-ascii?Q?yEui86E9k28HkT0PrxsjGcRmJK04QXpcMoDol9g3JNH7yo2XYSzHdeZ9wES3?=
 =?us-ascii?Q?QV96qb3m0gGViv9VgcdZZcG4V2w/JWY5w6PoPypncXaGfmNKi++kWPzgcvY2?=
 =?us-ascii?Q?i/p8l1d8MEuEAMdRkEQ4zUHy0K+iG4e9ctbQLOdnsCkNkBoJSKU+laud5kKt?=
 =?us-ascii?Q?oRLn/K/mg49cJFOO/aDRXSEJVje2Gn92BbrQFZHel7gK4xcuIQMvmGBRh7ci?=
 =?us-ascii?Q?7CC0y/vurt9UvLxseL5DoKEwsxm5s1kDvdoVqQK/BSDc9/kbcc1/04KmDzh5?=
 =?us-ascii?Q?u13/3pgrSw07IOPiQWdjOJ3VJjsJZD/vbnDqWduQZAMRSq1pNlZMnoFA+5It?=
 =?us-ascii?Q?Z85au72EFCPW19gElhQt/Pb9NM2viBWzv4ea5s1UzDpfzN0VgRhewoNx53Ao?=
 =?us-ascii?Q?8JNAiYJCbnqI4ckHzSm8wDIcicJs8eRwicZqBP706eU2O3HleSuKE9BBLla+?=
 =?us-ascii?Q?Pmhn7nvKD3sijQPTIhXRLwkMVKTIfoYb774HZhTtSY7Beo5X3QabDhYfiopz?=
 =?us-ascii?Q?WVb4KECRhCbFy3vGDOFdvtWaA/K2OoIQ/ITyl6D8p8d8B6aqHuONoMyDoRGl?=
 =?us-ascii?Q?qZ0VC9/5Wz/oxb9G24rdd0J+nxPYtZJp4GRiZFwPn5WcRxTG3hmOOdkBq7aw?=
 =?us-ascii?Q?LkHKnBCLjrhDxBUyfs337Mo/Vfs0d1mIAVjH4LBeVeD7ypI2vrYJ03Z3e/Di?=
 =?us-ascii?Q?YyTklqTL74z8pwoeXAAyuEkjevOtr5foTRjIGonj6T3WG0A41h4rZQFIIPoE?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e382e03e-eeea-4f36-3e37-08ddcdc8ca6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 11:20:43.2271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TODEwsQb+grKmzE7Fv2oT59g4oImrv+k6WWDngkn52feUVPjRpP35SvV1xRFlYaPV0OoAr7OnYbAST6Mg+CI+M1UbKyK8hHtIanEahF5qpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
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

On Thu, Jun 19, 2025 at 01:36:56PM +0000, Ciara Loftus wrote:
> Enable Tx QINQ offload if the VF reports support for inserting both an
> outer and inner VLAN tag. The VF capabilities report the locations for
> placing each of the tags - either L2TAG1 in the tx descriptor or L2TAG2
> in the context descriptor. Use this information to configure the
> descriptors correctly.
> This offload was previously incorrectly reported as always supported in
> the device configuration, so this is corrected.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini    |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c |  8 +++-
>  drivers/net/intel/iavf/iavf_rxtx.c   | 55 +++++++++++++++++++++-------
>  3 files changed, 48 insertions(+), 16 deletions(-)
> 
> diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
> index ce9860e963..61c4742197 100644
> --- a/doc/guides/nics/features/iavf.ini
> +++ b/doc/guides/nics/features/iavf.ini
> @@ -29,6 +29,7 @@ Traffic manager      = Y
>  Inline crypto        = Y
>  CRC offload          = Y
>  VLAN offload         = P
> +QinQ offload         = P
>  L3 checksum offload  = Y
>  L4 checksum offload  = Y
>  Timestamp offload    = Y
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index b3dacbef84..d058b87d54 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -622,7 +622,7 @@ iavf_dev_vlan_insert_set(struct rte_eth_dev *dev)
>  		return 0;
>  
>  	enable = !!(dev->data->dev_conf.txmode.offloads &
> -		    RTE_ETH_TX_OFFLOAD_VLAN_INSERT);
> +		    (RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_QINQ_INSERT));
>  	iavf_config_vlan_insert_v2(adapter, enable);
>  
>  	return 0;
> @@ -1158,7 +1158,6 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  
>  	dev_info->tx_offload_capa =
>  		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
> -		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
>  		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
>  		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
>  		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
> @@ -1182,6 +1181,11 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP)
>  		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
>  
> +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2 &&
> +			vf->vlan_v2_caps.offloads.insertion_support.inner &&
> +			vf->vlan_v2_caps.offloads.insertion_support.outer)
> +		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
> +
>  	if (iavf_ipsec_crypto_supported(adapter)) {
>  		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SECURITY;
>  		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_SECURITY;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 5411eb6897..1ce9de0699 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -797,17 +797,32 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  			&adapter->vf.vlan_v2_caps.offloads.insertion_support;
>  		uint32_t insertion_cap;
>  
> -		if (insertion_support->outer)
> -			insertion_cap = insertion_support->outer;
> -		else
> -			insertion_cap = insertion_support->inner;
> -
> -		if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> -			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> -			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
> -		} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> -			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> -			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
> +		if (insertion_support->outer == VIRTCHNL_VLAN_UNSUPPORTED ||
> +				insertion_support->inner == VIRTCHNL_VLAN_UNSUPPORTED) {
> +			/* Only one insertion is supported. */
> +			if (insertion_support->outer)
> +				insertion_cap = insertion_support->outer;
> +			else
> +				insertion_cap = insertion_support->inner;
> +
> +			if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> +				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> +				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
> +			} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> +				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> +				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");

Is this scenario possible - we only support insertion of a single vlan tag,
and it's to go in the context descriptor. In this case, do we not need to
add in the VLAN offload flag to the list of offloads needing a context
descriptor below?

> +			}
> +		} else {
> +			 /* Both outer and inner insertion supported. */
> +			if (insertion_support->inner & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> +				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> +				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG1");
> +				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG2");
> +			} else {
> +				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> +				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG2");
> +				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG1");
> +			}
>  		}
>  	} else {
>  		txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> @@ -2391,7 +2406,7 @@ iavf_calc_context_desc(struct rte_mbuf *mb, uint8_t vlan_flag)
>  	uint64_t flags = mb->ol_flags;
>  	if (flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG |
>  	    RTE_MBUF_F_TX_TUNNEL_MASK | RTE_MBUF_F_TX_OUTER_IP_CKSUM |
> -	    RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
> +	    RTE_MBUF_F_TX_OUTER_UDP_CKSUM | RTE_MBUF_F_TX_QINQ))
>  		return 1;

In this check, do we need to take into account possible case for only a
single vlan offload, and requiring an L2TAG2 field for it?

/Bruce


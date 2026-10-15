Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E97CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 13:43:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2C7740291;
	Thu, 15 Oct 2026 15:43:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9C25A400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 15:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792071781; x=1823607781;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zMrFIgitzOsAAUTSk5IT5CxVhatriRvdK17nQxdPndg=;
 b=POH4zlrV2LxIOz2qyQTnYTAsnjE5Dtw93PN74J9Vyy9WvuXbiFbrHQie
 4MAUTPSRMgce68TXAmJRO16pkxdBvf/VeACnicXVxp7B2QDiUhKFsskWt
 7EafYYaFeMfVI2MXQ4YunlI1+jVpN05BsvTI0cDqSJOOh4WC+eAzy6S6A
 Nq9s3NVKH1HbCwAMSMsyLMuAJfsyzSpXrIuM4xi5OLT6XfN2u0+LuISFq
 FTwQIE2Pz6iceBeSvHVFcy0R6mYG50qWq6mRJKBJ0oKdwnT7DaReruUM7
 HZLhzsEzv93aaFwBH68D/6VgPsEsBXx3j4IK+bgRch3qTSd8fyKPeW1uH Q==;
X-CSE-ConnectionGUID: s40PfzjoSnWwxdPC1eju3A==
X-CSE-MsgGUID: FnKzytPVSdyRYiUum6zgTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="850782"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="850782"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:42:59 -0700
X-CSE-ConnectionGUID: +/KP4pTpTc+a8vySAhA0Pg==
X-CSE-MsgGUID: 33fGyHwZTPaFORoeE0jr6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1747638"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:43:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:42:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 06:42:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epcMWv1YEvK5Zds1uazxiExR7e+P72/eSI5ed2IKppIukTfWVA3iv7kfqpJBhQRECbFd/m5wdFSpybOfz5gYiTeGFnq+1I2ddwRGTg6/HvQsFb/4a3ts1GjHw/4zlBz8M0UZDGjPHIF6+9Zc2uTwxjQIsV6rGsNRdFrr9+B75eW9shT13IoCs2AZ5X9tsFxmxHnhjHRKgbvo8M7i2n2Z48tI3FW93wapbPeYjvyfYutDxQRGtQFTl75/kqRrIyDnIHxIAlE5meYftchteoLH91bSAg+jOB6Mg+O5PPMKsyhjtcvdU4yLVBdiOqyUVlOPikFEPWeumTD0LQV/I7KElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1ckKaEHLBsaRXLmXQkFO9bcXuWCy9TQagfosoQmhjE=;
 b=MskaZ9LpI0gbXBZ+G/C0e21EXBqe/vBIGsnBFOIru00nWDVBF7J1XGjJSTIi1+6q6n0Kld8/ruBl0A02mNRC6LU6yagOY0iUsqg3YPYAk42+oWaBgnQ+3w7hPzCw4KQCazpXaGG4QcIFYf7/pz98WRBYgaJfEJ/7eEZ1UEX38wSnKLTnrZtlVcTZvcLGFQ9wes9jDpUlAFvHSPHq8H7n/ozhJwkW9V697FvoU61Zx4sEdbYn8fKKX3FlvTL+JzP12VbRl5lu7zxIerphmwAdx0NK/i7yZ49jbz2xI7JhQfBkaT5oQNWCQxsAOMNaQaekUSCnb0UD/Olc0On/8hhsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PR11MB8757.namprd11.prod.outlook.com (2603:10b6:8:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 15 Oct
 2026 13:42:55 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 13:42:55 +0000
Date: Thu, 15 Oct 2026 14:42:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/iavf: set interrupt throttling register
Message-ID: <atDYWtn8lwvGspyT@bricha3-mobl1.ger.corp.intel.com>
References: <20261005110613.473007-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261005110613.473007-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0267.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::32) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PR11MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 232790c0-6d97-4262-b5b0-08df2ac23768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: /78PfwNKgi1cZ7fERi4kkqFPsl7hIkM/Yc0tysXQ3knJ0Sz5peseWgErUFz3Z3gP1NPUBmROG7jxuquNmxZdUU1CaNDeb//bdAjYw5Kufbknw6/8GVKzt4WC644gdvh4p21xcQk2IKG7r4wZM3WBNxjEs0xgflYLEMbcdvK01clpv4AT1mThzMuKzubsDkEES9GGItJSUKOtRQI/NfMRFlhNH0wKRMReUIOcd6FULgvg/iJ8Ag/IHQYFyXyft3wSfehqnTSU1d1+on6INzgfOy09NPeMM63GzO5gBVVC7NqgngiqsWU1qSNdDdDiIr8iILJlRLisX4t7XFps6yE/6Bs5tHDsQiwFhW0rEGnvgpoyAduEQ+TxPvou4yJzPmOApLf8mc/Qs0eyTTjB8s0/5gj7l6zCka9/2gfDwr6Bu7Rfa70r77zO/7llLooNuOWPRBY7aLYHbygHn0QdQbYF/qBLLb+0R0lECiQNRWGa8Z4Ixk9WYIRdjYxyEhgwpVUN8KCxPEd1JA6hxN6/3wgL6C4c8DRnmBgKJG0/rNryKnkh1kgtYE0sztkTruT5gL5PXqBtQT5+uDK1PwhJInj2YDeqkhvxhX09QCBHtPrNVl8+HDd8SN28uot+PhdNZ70XbJ0yvGktpHqVxVxooYlzuoNmdPkYEO4iD74kco5V+KI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZFp5sZcYNEu6GgJkZNX+nw6B0L1rsiXkZw1BsFmYLvTImq5y07zEA/a5NBos?=
 =?us-ascii?Q?Cv1oMcPReUi5Z+q8O4KgFLkA2h0TchiE9G+pljgdnImPj1YjKT/AxOHTngn0?=
 =?us-ascii?Q?I9vTO3qB9XCyMiwqs447rxDuVhanQ8lplKibeG0RQTG790jaGVFOPi82sdR4?=
 =?us-ascii?Q?FM7gStuYTJUJE4b6kYTA55Tj6CskgGc33TXciHe2rMMD/4TmRRQI76mZgv4S?=
 =?us-ascii?Q?4Yn+mS0Ez+lntj1gi5bl559P8N4fwunvH/zIsPp9Vdty52K/PA9Vfq26QLRA?=
 =?us-ascii?Q?o3RYmMAKohJHNXaG9LtxXxPdcZ7FpJa7CiPzRXydSOU6uhZFlVaTkiQHl6S0?=
 =?us-ascii?Q?UZfWwGQakHRm8l9Ow1Ia494RM8C6k6F9ntEaG9KG+77Zvu9W0aKCe6NR6rew?=
 =?us-ascii?Q?8CfEPti9ubcuPc7Bb148r3cEeulzlDfiIPu+9SoMFOCy97/J8YDv1856mrey?=
 =?us-ascii?Q?iPAHbdb46rJM7HTBxfR3xfEwH+GfCXjWTJylOoz9/LwYoY2TUMc4kXG+SHZW?=
 =?us-ascii?Q?SNj5TEuCwN7X97hvy9C9K+Nb5tsFpvMBrRgm8fWYXRzAkMKAUZTEWyHmZTaK?=
 =?us-ascii?Q?Bt85SECvc9Qy+66n7bxQK0U1Njp/w6h6mjU+IQuayOgwiwx4S6qUqvI70LBn?=
 =?us-ascii?Q?y82fEK7zInmm+eZdKz6l7kjHjnfIzXLjK/5lJBtERqDq3DsicuDFFLsrTNlq?=
 =?us-ascii?Q?sRwCXB/aUK3I00MWVW0cBLgSmwdpMrzIZyM0FhtZvZ3NwmBiFS8kiILp/HR9?=
 =?us-ascii?Q?V+TxmibGBanGZk0/u+u/5fDk8Mq36Bz5Dq5VhdKmQKvmr0YEe3LSm7tgV02P?=
 =?us-ascii?Q?zHZEFXo96kNMONkMiOfcOj6JmYzXIYvSU6+1KQ/iAIama5k8YQMv6tJ2eI5p?=
 =?us-ascii?Q?xHJtHDe+hd4DyKQtScLwXLGZdF07HmOe8Xsvz/eVhm9mqWfc+DMSUmEZhEh1?=
 =?us-ascii?Q?95vDxPSxD04XMrj7WF1z+5xIqDzMjVVarkqghhe9mteulofrKxKdSdmcjzQq?=
 =?us-ascii?Q?ivvnMcZoiF/E8T6SsIIK+q/vQ62mwtktaBgW/pkoAksujkUn6oIi2EatJjop?=
 =?us-ascii?Q?Ui530AJDOBy80wJjRVKnw8OzNokmSO4wCny2qixpTaBf5msMsW01owouiAk8?=
 =?us-ascii?Q?r5W4ITLxSqEmfFwIKE2ETRQZt4UBkt8rwFQS0eeAOr1Of88MxrNtWJDik2rx?=
 =?us-ascii?Q?qLDOEkOUK1mV5fGSrskK3aW3HTjacHdd3LpsRr1nV8EDO3aym+YYRfeV3QHs?=
 =?us-ascii?Q?MS660b9xobx0ygcp1Q3WiEngIxZgZBU3P7iR2H3WCfeqtd/K7WkH/fKgJLR3?=
 =?us-ascii?Q?WFxXlhQVk/lZAoGVs3CcNvGYLyrq2R5bmrZbw2OeGz2cSJlJYvX2MoC+c9fi?=
 =?us-ascii?Q?nW7JIQLmsFHTSskLegbLGPeu5wAVMkDcZ1dTv/S1y+zX0uuN58wZHQNxmtbJ?=
 =?us-ascii?Q?XIhxv81OyljZPamFHMHlnto3ryRnPCZ+UnwEIIztz8C3mAEH4AauqLn5+k6g?=
 =?us-ascii?Q?u8cL0V2t4hmovkWZvGfbncxB6i0xiNoe5TaC1sKHuMRkY7W6kLbhzhzaGX0U?=
 =?us-ascii?Q?Q/0D/uS41mUg/1k58sfRuuHqYe+9sl8uc2x3zHL1lBz4R7w20/2IjzVtHihN?=
 =?us-ascii?Q?Fw8jpzQMYml5iDBXnU5fR+eXbs1O90F5hJjNViFd4epQNkOWvEgYVyS8bvs4?=
 =?us-ascii?Q?DPZ7BlWE0ojQW8hmSaBpR3xxGwqYCACH3gr7LoC+VOtI4XTL5rYQWKX8kl+G?=
 =?us-ascii?Q?0yKifeFudzP/AUFZBaFW7+qOCbuutYQ=3D?=
X-Exchange-RoutingPolicyChecked: WfMhwZ4lpS3bifd5ISJE72Bs3TOqKcnXUdNjn0Cr37Z23wtK5EIA/Otb/HB8hiHXVwLi62HCe0vpdd1dGrU2nDiDa3Kk/tra+GNg5y9qjOTbJS8eubilmBJkERdIDEyDs4wnIVM1oKifhWHwpQpIUAKN70vkXuhJqysgfxcCyuIVgX5pvacXpnVNSoFTg+bpg5IqUTKERz4wCwbielFrltAsAq4qdCBXmlvgCjkyB1SFSPF+aFlkl7/B1WQEDeUoUQqpNLIEvToIe5aTkVg987NC3RQc5xGnMcHsdjc/V4nUArToskDXzcwrIyKg3gi/38DE2AjAQJlzxPjYQ2A8lA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 232790c0-6d97-4262-b5b0-08df2ac23768
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:42:55.4552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk8yPxeJzsFIkW9y14KrQ42rAex1X39FX+Z7yZHzQjcuf5OJPj1XkHGd1gVDdgDXwwYc2A/CuXNP0IfEU70YcaSBFTaqUqguuGZIBSp+q/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8757
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

On Mon, Oct 05, 2026 at 12:06:13PM +0100, Bruce Richardson wrote:
> The interrupt throttling register(ITR) bank 0 value is set to 2, but
> to ensure best performance across all systems also set the bank 1 value
> to match.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>

Further testing has indicated that this patch is simply working around a
config issue on kernel driver side[1] and should not be necessary in DPDK.

Dropping as rejected in patchwork.

/Bruce

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb096882095e5a8d6b5159e43793d4a38a0c5b1f
 
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index a8abe0154c..dc3cea0b95 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -899,10 +899,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
>  				       (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
>  				       IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
>  				       (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
> -			/* debug - check for success! the return value
> -			 * should be 2, offset is 0x2800
> -			 */
> -			/* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
> +			IAVF_WRITE_REG(hw, IAVF_VFINT_ITRN1(1, vf->msix_base - 1), 2);
>  		} else {
>  			/* If no WB_ON_ITR offload flags, need to set
>  			 * interrupt for descriptor write back.
> -- 
> 2.53.0
> 

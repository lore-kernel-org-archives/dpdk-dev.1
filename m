Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3399C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:38:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1397B4026E;
	Tue,  8 Sep 2026 09:38:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id BA8214026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788853097; x=1820389097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=h1tN1LlclhizhnUjE/E9vzupArHc+fyBDsOSOQL/V7A=;
 b=kxhJYsPcfNI0Bl0f8sg6+tPfVIDiQSgAhvDbS5l1zs0xUqtgpn1OUS2i
 JzpelmhVj0ZKHz3xaYQECh1rIuvf0IeGStKShFN5NyljbVYvyl1sbNTIB
 apqbYzw2WOwrVhjYCzPNyC6SQAkkDqv7jyfCqIVc6CcCbmILUjEBSDx5m
 gueLYckdY67Iaqt89FhaWhka09rORiamWtmSAowVUVFracuX4jGnflmcb
 bksKCeIp9avGQjUDJQAatWnJQhxQTRAlz5yMoyvmPvf8vhIgwvbrWoO0D
 a7mm+TPDEiIQAqs2t2A4suvWD9YQsLB7BvHdLlH1p3qU+tRCTyiLR0+yF w==;
X-CSE-ConnectionGUID: K+EVvzHoS/qHkZU03Oq/cA==
X-CSE-MsgGUID: J7xtA+6mTLi06lVtIGNeFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88182420"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88182420"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:38:16 -0700
X-CSE-ConnectionGUID: F2NPvZXGSLe+NjLIuuMxcA==
X-CSE-MsgGUID: EI/cIyhAQ5CXAp2mFRfepg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="264720594"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:38:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:38:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 00:38:15 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4ljXyXKyPx14wu5yWnOmFe6eF4Hxc60Cl6+gswOiSDH/L2TvPKMvHAttQJ5Y8nnpO7ReY6DRzcfcNQN4MjyjzcJAyw7fJvMfcj6fundHFaj36DhL9rnWFE5UrihcVqm2mrOfcd20DRuEDD6yLXrhlYZhAc+Ul4tQvvhJ3q4TGIyQ7zNQP0DdtteIgpKiK4PWgEiVc+FSdRZf8IhRG9HztJuFCqR5V0DWYTlZWx8rDmRYhkPugeLVdNnnso065ohbbBbZKRhC89exnxG6U4k8BV204/2qwb0BDw80f3hJ96Mrs2zqg4XuQC/buAbBR6xxW095KonqKzA7mRz2y9p2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwTSpC2GaRzNtjlY7ixw7YNpc1klBoLrSXyUtBBRshc=;
 b=JDVJUjwN/mfOIfSaK0yGimvxZTLaPSwSSJFR9piWQpRVRWLAbwHBoGyRSXH1lKpLL9fKzOt+vM3G0USQVx/UpYaTtXGRHESxTZhDQ/sQMfwRct3hhLP9zE9J1CHh4TQJ20fW9Oio088Opllqb9zKlcmCrgXDpBvOrB7qS9MWTGPo+021G2VCaTZgdti3hIl/MPnIoavqg6B0xDbiyONBkBENVMHkzI9Brczdn+uiP/AN9m/nvmGm8LqSYjDpj4pc3P4W1m88dNEYQlaE9q1O6kat37LbmcOcCYbu0kNHDAEeS0+ZRBvTu8Pmpl4OTOU4M6CJJk5Ya2BqO0LtXaHKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.14; Tue, 8 Sep 2026 07:38:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:38:13 +0000
Date: Tue, 8 Sep 2026 08:38:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 1/2] net/i40e: fix MAC address removal
Message-ID: <ap-7XyKQASD32yjv@bricha3-mobl1.ger.corp.intel.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260908071854.3419531-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908071854.3419531-1-david.marchand@redhat.com>
X-ClientProxiedBy: DB9PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::35) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PR11MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4ad402-e0a8-4a56-133d-08df0d7c239a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5nd8m+lX2rEOg/q3u10SAwvZMQ5WpNP8olpU9OsWCWbdhbLd7QgF4ffuW6ZbAEMMVnEU4U+IotlphQWXXgM7uGsX0kf0bOMPByMkzHwHXg/HkuwW9RTgo/w7T0PWXEvxNzmqPL5hoOksJDx4jmZWm1O15ekZn8wLVyqvHKEikcF/ApuNd2BVXSavmbTVfuFg9rVdOQcl8ypGf6k9s8WSP3yq3WRUYR/VmZtsQSUSPKQEcXC0UOm9+3ZPbA//PCHRu/tEG8JU09eAWAK/seoucAauhdphmb3WTEbxU060mOJMJYGPmMoYbJ2aNJHvzkW64FRK4H9IRs7dekuV9AmU7CuHqjOz8Fd6ms0iksmzcTX57yo4CLRKxTcTqsz/8lpXX3Vevkn0xLysg2D2/P3J7UsnrHbCxrPqaKXfbzMlJ+/Ic25y4yQ0G/dZUWcOxMfoDyaShf8dFlMDVgiFL4Rpxur1hF/1s1OSYKzSeWtxLMuVAN14chmjds7ZoG5YIaYqu3GvDHb0FvZF4nTD3v+yWJoqM6dRWyb90jD9IN6lujCxNypq1oDJbFoXangOPAjBRt9Ib/XkXS/oEW5fVdLPlggytmjs6/P/wx17xWk3HKdfzj/8izgMyvzfUi8iVclJlzM+TYa/EbO1bBacRkkjvD4OOPutqYDdCW20xz4ssY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hD6J0zVjfLwhHHiRu7AjFu0LqD0d4p8PnWINuj/h93EYiNY/gTfQG7bX6GJJ?=
 =?us-ascii?Q?hsGIdVhI8z0IhAGjEIjH4dTjb4WLonhhOlJzOD0mntSd/clYzS/Yb2V8rqWZ?=
 =?us-ascii?Q?p+HFqAxmhanycYs1K6IO+20e5/UyQCV4oFt348t7viA7q70K4cYAbuZGO6HT?=
 =?us-ascii?Q?udeVxuiXM4LEwtb5sBlHigFUAh2F/p6rf5XR3Dild0dw9bq8HWbweYUeIAsv?=
 =?us-ascii?Q?zUb7UrqQJuoOu/ut4vF9KHfgW6Ff4ddSUdV1pjkAd1TLvqf0Pxlnuh0URmo4?=
 =?us-ascii?Q?N6FKdNV40/QiYKcFp69Jamz6mhE+4JnBBGTSoFb5rJXXNbPfC9id8gfaPRQ+?=
 =?us-ascii?Q?C0ymiavIYGn+LMU3Kra7gRPGBBynP7Dg13BlxptBupN1/2t+hAg3Z2eytMq/?=
 =?us-ascii?Q?y5UqYSKSOcWhoagjogjgxrC1vhF+meQ2AjfcvyITrPWutiwjhmNs1C8yyDM9?=
 =?us-ascii?Q?bjrtNjf8rk8vJqFjnJrUVImPGGOag0knZgxFPuLhPD4y9jQVoq2FkAov3XRn?=
 =?us-ascii?Q?JanNTml5obfdTRQ4l51CkH4mIaWg271Y9lOndCgjtrKuCNGRZ1BBAP9ebhsc?=
 =?us-ascii?Q?SPeAH96FZqQJSScD0qZ8n6j9PLYKqYTgSJK1MXVAxmuyh22U6sNspqL/1MGz?=
 =?us-ascii?Q?BnZdtMTgY2J/lOB3wm1HiZ8WrRtx42K4JlJp/sMwHvLsQuhZ1deih+0jW72/?=
 =?us-ascii?Q?vi+yRdPT6p4X/xm/6GuYJsYCT9qHrO2XnZRyAfUzkcYw6MPHaSR/yus4oRVB?=
 =?us-ascii?Q?IhORgvjJWOeRJ+A8P1tmqpnKPA37NrLyILMQSN06aTsMy4Ct1+XqMQLCLtSM?=
 =?us-ascii?Q?O4xodM8CGPg5JpkMNK5LTHpG9C/SVbUKf59bDrosNy3FDjKZnvO2gWCdu+yg?=
 =?us-ascii?Q?5n7RPSuSMddGh+/28BAG/3QAG9ocNUL6sd4qgf8HHh1nMwbh2irsKZwHFyGX?=
 =?us-ascii?Q?9cW4WZkGQ6Amrs5d22em16nLvaTVYL2IY/mWb0JkONp5DhGkCPowbXPnCqx6?=
 =?us-ascii?Q?XuSeu1xJofySu6sHNU7VJLWNme5O2sK2z0wSAOWYLHNM8LmeJ4grxM3JcgYa?=
 =?us-ascii?Q?n1912KfvNzZcMLvL7fqi6mo2IDG5P695odoKADcwQWBHuYpWhBUlskZb1M+V?=
 =?us-ascii?Q?SVPzyxU0hf0QyZsuq09JnTdnUlE0eKvI9g6iRoeDUKKvqBGUxTxVcF9O28BD?=
 =?us-ascii?Q?RBgw6RuxVxJ3yyLtcdoPO/jo2CKDTPlML7tSIG8kP//KsUEiEiFpVCLSdUYT?=
 =?us-ascii?Q?hkuCpzsEl+7JQDaO64UW6Nb7qcsJNAhSOZHqdFLwyNSYkPM3q58yjul4Peg8?=
 =?us-ascii?Q?iYnJr7QXBtA2oj5QZQpT4+hPQ3qk1QscUxVuGE3oV4daIIXvHrEOmlU2k2wI?=
 =?us-ascii?Q?zhlBTOn3Mp6AQhMxITJsHcs/5bwNTC1FmHJsiEM17MMsfg+CPR4XNi1MuTtK?=
 =?us-ascii?Q?yNGoTYY6rFF3MQUv7hw0mX/Z7sbWna3VcEvhPjoWU7XzLzK9tssKLM1NIwVG?=
 =?us-ascii?Q?4z7P99N7XBE3e4SoR8Vb5RUZg4UCol5/3telBRlVAA7kWKo1nmESUYd4AqRY?=
 =?us-ascii?Q?QkJSimAz41bKCTCLZMW2ITcVLrnM3Ka4liulQSD20na+r684Ved61ody3mqh?=
 =?us-ascii?Q?ulQLPqBr5t7p6T+j4gp8g+9IkLCzZlNiTOqCWqt/f3W45XsLWNddgRizN1nJ?=
 =?us-ascii?Q?N9bh0e5rY/2R9uNsR1bzcckKE2OeTDoOEDU72OuSfMgaK7Ps2oKaoMplJWcW?=
 =?us-ascii?Q?eNRH3Vk5KfgnIQ9VQqVmnQky5GzWEIc=3D?=
X-Exchange-RoutingPolicyChecked: GD4MQoMvbk1ET6O4sLuo4umw/WhdkmZv0HrRnodcqI1sv1E89Xa3m7wfCbYAvpUeqWvW4rvOasUbFeBlOiqdO3p8ldnaEg7sAoBB5501y1Ar3EjlsjKjP4sHz4P37dP1aGgm3mzJVv3KR7rpa9S7etaXRBo7VzMk4bS3/cfbgHWTxk1pES/znbD7DGlAb90Jk+r3LqeowHGLPgn/HQGlJUM2EC8Q+ul7OjL6UyF43IkgIINuR7zz3C8aJmZPl4pYKHPgktl5EYIJrgMBx1AG790x0Mgn47mbWN3WQhsp3OrySyM7Gd3G7jtUBpZjaMNJMh0xr566W/PGq8fVLhOxHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ad402-e0a8-4a56-133d-08df0d7c239a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:38:13.6233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: li1h28L8kG35BBuGFfzoV6TVaep9qJUbLE/biVdSgKMM+lT85xxEF1fygfDtxkJIYSm9KaQ80oamX3xMYnii9//z6ILQTlqu18QT5dtD7J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
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

On Tue, Sep 08, 2026 at 09:18:52AM +0200, David Marchand wrote:
> MAC addresses removal was tied with VMDq pools even when not used.
> So if VMDq is not enabled, no address would be ever removed.
> 
> Fixes: f9ddb36e0065 ("ethdev: skip VMDq pools unless configured")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
>  drivers/net/intel/i40e/i40e_ethdev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index b6b2d291ee..0d914d86ea 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -4513,6 +4513,12 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
>  
>  	macaddr = &(data->mac_addrs[index]);
>  
> +	if (!(pf->flags & I40E_FLAG_VMDQ)) {
> +		if (i40e_vsi_delete_mac(pf->main_vsi, macaddr) != 0)
> +			PMD_DRV_LOG(ERR, "Failed to remove MACVLAN filter");
> +		return;
> +	}
> +
>  	pool_sel = dev->data->mac_pool_sel[index];
>  
>  	for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
> @@ -4521,8 +4527,7 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
>  				vsi = pf->main_vsi;
>  			else {
>  				/* No VMDQ pool enabled or configured */
> -				if (!(pf->flags & I40E_FLAG_VMDQ) ||
> -					(i > pf->nb_cfg_vmdq_vsi)) {
> +				if (i > pf->nb_cfg_vmdq_vsi) {
>  					PMD_DRV_LOG(ERR,
>  						"No VMDQ pool enabled/configured");
>  					return;
> -- 
> 2.54.0
> 

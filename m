Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A572C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E4F4028A;
	Mon, 13 Jul 2026 12:06:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id EC59E40276
 for <dev@dpdk.org>; Mon, 13 Jul 2026 12:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783937179; x=1815473179;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jm4UdayTPmJTbVlsQzc8m6U+7c8qx1Q4dGdZNIq09eM=;
 b=hTgAr05o8rmHccg1ssSCYCVhZxdaJuBTWm6kJjcXwdcJ69decbtCh9kG
 VrbHm35cXwaxEMWkMzsHRWNuIM0gqU9g5iuQ6Jp661IPQeH+G15ZtaeRJ
 aEJL6SZtPc6ftW1T8pg+S83qf9nDQlmnP3Ue4NOcs0kjlCzjwjQHXHWjj
 +CZgneUxtNsAGRdBNQmu5uLetUMQwJI5jsdUoWIpaXn6xcHjShlQV1sex
 BuJDP47CbGmnrJsKXPHSSnM5jCWgzr/6PATftX6BpjJSe1APuMnjaYBKR
 KgxFDh62JRgC+RifLjeiZp7681stih7NhYmym7Zd6r3ZMUdfXl1oBgvIp Q==;
X-CSE-ConnectionGUID: brY+yWHgRZCk1aY3E7VvxA==
X-CSE-MsgGUID: H0pGQJ+lTJKHw1WbIODa5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84593401"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84593401"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 03:06:18 -0700
X-CSE-ConnectionGUID: 3tNjl7S5RQC1P+Qb8oft3g==
X-CSE-MsgGUID: OjWzpHX3R4+8cIH5O9OUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251090509"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 03:06:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 03:06:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 03:06:14 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 03:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2OR6e/Zx16GsLhm8quzUIS4Lw/mQ3arHUH0CbTd2ovt6cPIAPyHZVGXhAS817gS0YUkPvQkzK5t/nvEN2Gx+JWFKWKy6iEbB4cHDR2Qcm7BR8AG1H0eBnS6+lwRmqG8rpc83pDD5ycVEOTnGDGz1u75HLzz6K8GIyqJrWTicDtAFnA0gyYYJUeeHTwcx2zNAodzPliz/fagWQxRV//joRpk6pxLNoYbE4xJBuP1k3WialrqM8xrxBXIKe/9kx2wbJX0/YN1qjePhiLUMTxIBu19OeOhaQB/nEo1MvTWr+W8jWubDAp6RkoaPN1E7VSqvvitCL6hodNyUWywnZfmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGjyxOk+kMpMDVz85bFuzh+hJBe/Lb6GAJKAt8TE34c=;
 b=Vf+oqBbygfAs/zM2U+zQbPaVBqiplEl51zfiO4h/Xpbsei/yRCvhJlk8906LR/k90awxC7X5QqKfqklilK4w47FKqViD3piKhEQrCZz1PiRVnlGMSL08L8WmeJCXTCgDmDinJvJt0+7iCV4D411XxDWTMFyYlYWq8DxRTKJZZczVorUYBKpZxt86E2Ioy8/p0T94SDAcks/jPusGuVMLpz4Ug1h+kfu8EDHDwWu7eBI7mJXpSBBrIELjF3XvOhxle62+lEewT7W11hTE9VF1iyE5pl7zhMV1nygGwv4Kys9Adt4UEYdgQ7sr6BIMnRTwE3vxJ02EtAZU+YoogWNSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by DSWPR11MB9581.namprd11.prod.outlook.com
 (2603:10b6:8:36e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:06:08 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:06:08 +0000
Date: Mon, 13 Jul 2026 11:05:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <marek.kasiewicz@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 1/2] doc: fix ice scheduler rate-limiter burst size
 description
Message-ID: <alS4eYMnlpqisUMQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260708231926.1550698-1-dawid.wesierski@intel.com>
 <20260713094259.1721234-1-dawid.wesierski@intel.com>
 <20260713094259.1721234-2-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260713094259.1721234-2-dawid.wesierski@intel.com>
X-ClientProxiedBy: DU2PR04CA0228.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::23) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|DSWPR11MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6b49cf-dcc8-4525-6163-08dee0c6528e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MOl8EqQQKEcR6LsPuheRH3g5bIA4fm9UTs7KgFQh7Fyvc2YCbP+XPuH3QzFJQOMkAqWZsQpjZWKCvbK9n10AC7ZTS/xrPLbM5p6aaDo5ppvkeZLfVPFOtgdhe65b118skA5fV7xDnufAuSGW9j/Yse8S2jkOHhvxP0/s+FjInsVzUDKYUue2yKNSL7td9/CNUtk38LFIuIxe2Gz6uhGujuCh2Huf/S4yG94VAkuzyfqaqd9Huj2NTo38EZeiea8cHaraovL4INQSDDJ0ovJCaC1XXipmrbaLiR1pQlqDqqOgCeBLxPsYg8gYG8WUq7wnwNuB2PYti0DS8vx2o8+gTFhNP/buB9T+GsDVWzkJTRizVVGrhtIFqO8kElnf+uDijwayy/+xJu4lrNFh2dYWtMO7fTMttVmaBWNqSfo8t7niHCy6P9PHBvZ0z9eJcqwcRwGwASLOrKU+Pqrk8nz6giRJolzDFqATfhrOt4NYbXkQez5FFiSfAdl4y8zbvEcog070t8DP+ccr58mDgKWKsH0hyFLtCQWKOISmat2BcLKM2kln4Un5yQJZHvvXAb779gC2Cw8jU+M0LaQLfKQfByHjAvv7t0VFSS0gWEJQVaufF0GyHIR6sroNgwPonXcjfOqR1/srj1UmhCjAg0+VZfI6IA0cG1DWinTL4MWEuPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dw8umN3c8iEADuQZheC3SAxc+Yev/ocIE6/VEg1SSGOTP1XVVHZi8ox+qT0R?=
 =?us-ascii?Q?xlRKWGw3Cn8ag1Ex676uosuLMjOtRj6EJMPXYVcneFKm7AFyJtWsaxBaNFNl?=
 =?us-ascii?Q?2YrO7Z5lPJy2KBk16nD+Gj9ZZTGQ5nPc33F6nl7jGyhHnr/JGLid820V04q7?=
 =?us-ascii?Q?Sbn89lCnRRGPsnrHospm/J11zYULs4hecUnPosTdLT2pKrmIanjAAPEeDt2M?=
 =?us-ascii?Q?RouU1uDCjaoF9yxGNgPv2ooHaf8ulPmEBJ7BXdWH6rvZ18Bo7Iv56VFiu+On?=
 =?us-ascii?Q?N0rjodrBQaid+PbiYqA5gphd8IkjYpvYoXPg0ehK/URlQ2wG/r2SM395hGMS?=
 =?us-ascii?Q?V4ptSXKZF57m6miqXhSxZ1uq3/tDT0/ubHOaGlX0klGFbJKSzh5egc454hdF?=
 =?us-ascii?Q?wB9lg+HQXcXFafgX+ATmx2W5IpQsdVpS5OQ06x3r2TphP6VmoTtpU4j12P+/?=
 =?us-ascii?Q?7encwCCwxkQ6ElVD+hev49mXQiSUVygHuOScwL1EOPoFSE0XsuhdSkDKM8ho?=
 =?us-ascii?Q?EZFpisOKTZ89No8yAur8Zb73N8AvtaxzVBOKs9idwsGaqbue6h33M6bhCGCv?=
 =?us-ascii?Q?m3MLgJstCjDDGD2PX7aKjwuh8f8C/Pp4KPCzWIhjpn9BbIz32yDeFSRRxVmR?=
 =?us-ascii?Q?eWGqMzvaZplrqlLuEWIxARavqshh6DvBkkiI/XzAiIn+/unmRlauqkrYor3I?=
 =?us-ascii?Q?AyyVxhXYjqrSa47fT6heInbCrC1jWLyOlb58/6hxSav0JQ6GaxdMb2oCiq/q?=
 =?us-ascii?Q?765rybcw55rpCtGidt0Cq/iV57yuzlzCCBD/AFBkRzUPmxpL2mAO5loHCluO?=
 =?us-ascii?Q?B86Z7ZcDO/GKLiLb0++JVEzEYKQEtq//81OVtvMfomAxggYCJCenkuZDFcGw?=
 =?us-ascii?Q?C4c/ZoeJ4JkH7IiVArSZszym6tQqRPxjfgB60pkTRoqDsjQ8zLCyoVCgTzE+?=
 =?us-ascii?Q?hZAhvffKyfc4B+O9+NdS384oMwz4NYLxXlHEBNTRpVi5EoL8gFazCcJ6EtVT?=
 =?us-ascii?Q?/FB4KNYDq36b3kIG6IKxfvKpZ04B89OBeqhODIwBpGr76K2UcHPN2qO5WPIU?=
 =?us-ascii?Q?cLG+eMyfSu+ZeyxFBSTvv5k04SilUvlVSdYoYaBKi1ME2VWPFo69f47UPGlf?=
 =?us-ascii?Q?ThfdMDzaVYmhDJf9Pm7r5TprfFaLATs+M+3eAOkoYzCahEIUv9DPIOMD9A9F?=
 =?us-ascii?Q?xRszYofZKrbY8OkhKOmqaEYR6sJMCDuzUH5hJk9Evk8N5Nq17RjY46MRk2JL?=
 =?us-ascii?Q?G8RriO/eqF0UcOwpbewJpwgntmUQtNVKvp4+PVHd3L8M4T7wsh0lMNnoJhf0?=
 =?us-ascii?Q?ZumcWET1pmhy+psrci/jN7hadvRF9OQYOQj3QfnGZItIkQ6PIdfW83Qw14lT?=
 =?us-ascii?Q?KmOkkHaeT7S4KMLuKbk+Q79mvVRTtUlaNzydvHuxg+ufuGF3z+mzeSW/ptra?=
 =?us-ascii?Q?HhTUUsuZlOu1z3a3o+WoxH4aigU5AvPEIPhW0lDdlZsDZAx0almobrgI96Aw?=
 =?us-ascii?Q?32/ZvECXUgIBRCXdeK5XncH8neE9Qs3YAkakoUJrAmPdzmYQUksk9cdOoIU4?=
 =?us-ascii?Q?zTNdXjY+OU42rh20QT4iGRQ7D0e3Nvq8KMRA5qgOkaso9Z/R4E3Va9MCxu22?=
 =?us-ascii?Q?NZ2HEn/+HSpTzqu8juCFfkTa2dpnjeehKgAGoixt7ZE16OMoWpazJB3TKcbL?=
 =?us-ascii?Q?lgcfSTAfrsZef9BhfMaoNxeY1qjR0+Hu7t56Hmk/3lMUvHrsWr+xSY89Uey9?=
 =?us-ascii?Q?fqbUw8TAWXNQTf2iGU6+rHNnHEDcdkI=3D?=
X-Exchange-RoutingPolicyChecked: rCcQcez8hMDWGNjM5uoQcXk1Dx7Un8X1Tgvwc/odmCbFLWsjb2+f1IuUq8nVkMD9/iHhR/o2naG2E35+fNwFlm1Fo0QUNbyDYljfd2LOYCoT6A23knzjEqyh9uMmyp8ujArp2kyWvWf/8T1+jg1mSwRvLGSea1pqv3leHKlPZyarG3q9NhPPvU72Ec3a/Le4ecMkzD0XBrckpp5eLjDmlxmkZRCwZwQPtA1S9CBXfeSHE2KjZ16vqvr8Zq13lx7TaYuO4WsBeWEv6LawKFQK4Pme+2C2Ol3+Ob2ft6rmKBZZIH9GOl5stvQmz9ai6xhKFhSOEcmUQO++DkuqB6cQVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6b49cf-dcc8-4525-6163-08dee0c6528e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:06:08.5772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mx9+GT9S8s7MitQbS+YrO1/xkWvwej3ciW9/gNfacJna1wmvCtena42vfziP9Mx3JkNatq5B+Z8a1mJSGkdb1Z0fT4MK9X1RCE9Nia32HOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9581
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

On Mon, Jul 13, 2026 at 05:42:57AM -0400, Dawid Wesierski wrote:
> The paragraph describing the rl_burst_size devarg did not mention
> that out-of-range values are rejected, which can otherwise look like
> a silent no-op to a reader. Add a note that such values cause the
> driver to fail to initialize, since ice_cfg_rl_burst_size() validates
> the value and dev_probe() bails out with -EINVAL if it is rejected.
> 
> Fixes: b3f2afb3b7ea ("net/ice: add scheduler rate-limiter burst size devarg")
> 
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
>  doc/guides/nics/ice.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 5589ce934f..2f7c9e6f7c 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -164,6 +164,7 @@ Runtime Configuration
>    Time-sensitive applications can lower this value to reduce Tx latency jitter
>    at the cost of throughput by setting the ``rl_burst_size`` devargs parameter, in bytes.
>    A value of ``0`` (the default) keeps the hardware default.
> +  Values outside the range supported by the hardware cause the driver to fail to initialize.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

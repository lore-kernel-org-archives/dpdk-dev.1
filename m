Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C58EE36AE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:11:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67A294025F;
	Thu, 12 Feb 2026 18:11:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 799C340041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916295; x=1802452295;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kZ8Pw7yj2bjfu0idoddg08BVuGxfLyk7yxpuHnUF1vw=;
 b=YOdmZAYTEKhv6HwZidi87mV3w1ZR5EAPyRpne979Goq/xCGrW7xci6hU
 s+9L5cLKJAjspZDe15e8mwRki89/uZzZK654bwodJZrD5ZqIyuf+mqkk4
 4ocl/W4gzTS3Cqg7sA+JGIwZPK3J0QtveTvdrnfcr4e8DcAYvt/I7dQrz
 HUT3eKZYpW+Xlfeh3wwmv+jTpKT3RWTULdAdQZQn8lQ/rVpPz/O9Silso
 FT2fVOnrsQmGoceBa40ResKF9EW6108t/XCDlcB/r7aLlSBT6lGY6KH/m
 RwF5lFTzzIZL9xqmhSVHUfxBOvKQWxQqAZXWz8u5ZaKfMrkG9F99BdM6A A==;
X-CSE-ConnectionGUID: uo77jtayR+yEb7KA40rvRg==
X-CSE-MsgGUID: l5aa9OI3QIGrD7ffGtGFXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71122604"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="71122604"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:11:06 -0800
X-CSE-ConnectionGUID: y1XsNhDhT423DBkw+vtPOQ==
X-CSE-MsgGUID: yi9V0g08TAO40JMdbwjyjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="250342042"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:11:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:11:05 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:11:05 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4GrRiibgatna4yhkd4V7vGKpDWeiTeEwq8B//b3AbNGNyCwhfXl8n3am2aAMXKRZ+nO+RtuYYHGYYwPNHa6ZMUTk1Yd2p4NUZGfsK6S6TB/G2+UHjx7XEuwQuZo3A+GLdGqi9q75x1DB0qujgDUrF155SIendVxjn5XYknrBTp2BsAOd+2JcKdTNEIj8K2blg0OGYSGCxAWH53M+HBh1iRx5IAKS1gMGC7F7kLmVIDEZd/fMZgadU7sQZQUIka/q6eLEbkxANoEzK5+b10cWB63bk0gWffsERJMaiApzF7lzWZk7eC9QEPGcsIw33h4oWONs+7qacpMl3XqOppdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2K1YMOGqWOopTW7ZRv3TGRGg3+gt5zVvXhggb+Jj+4=;
 b=CkZYNxZY9DFY0FyquGUK+n8M5Bqk4hERg34Dc3v95JdIakX313Xiu9ZW56VWNXZesYkjOK+5QRSHABEDQGC4ycqPbnofvIwqfgcLmIPA+uq1QNhGtt0m36nkJAkVYJ8LbvKnJsVILobgrT4r98ycoo3NrcxyRrrM1eXh/7kw1C2qobRoq/tIfNNgE2RnzshAO00+Cjb115WXFgxrl/9ZBFfE80OSVbAVm1Ck/cb/osptzXHcTDRooWaQajQFizldstuMPwVNt/URq6vw2peffjFVyQaJ55ksM49xyPPIvHAn5FBcKbzUT+rdKuOQSNoYJsvDcyRy+cxo3AQmJc9bAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 17:11:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 17:11:00 +0000
Date: Thu, 12 Feb 2026 17:10:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
Subject: Re: [PATCH v5 02/12] net/ixgbe: fix memory leak in security flows
Message-ID: <aY4Jnsjw2DDRW1QH@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
 <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0174.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a40ddb7-0636-44ff-24b6-08de6a59b193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KalbHGh4/rophjSufphOofJbbc0YZg0e7iTYXvembMMbzYG8zTuMZLtCFLYw?=
 =?us-ascii?Q?xxW28JHfVP1tNJGh2F22BZeCNF7VTvE0RnMRk0p42hbL+9MWjZj4djSHI3NJ?=
 =?us-ascii?Q?hmR5zU/CtweNrnZj9dngr/ZREeX6H+gELo/VLO6xI+//cSV49ebwOuTfOVpC?=
 =?us-ascii?Q?r7LtTZroecJdXAS1ZSj15DKzGYO6nPx9ZSsDJZ6OTFGJZMnjUf7YND73emU0?=
 =?us-ascii?Q?yEJqTtLiBuJOtEnJA1LizT4yc1JbDT8LvXeXV66lkTrEnjbg9tO/XBFqksxl?=
 =?us-ascii?Q?791KWDRHcM29cBRyVmfLw76X2ZQX0dOqOVeHdQDxLRTN9hk3AtuywXwudF26?=
 =?us-ascii?Q?FnUtFQOOd/IorGSPBdGGGjjO9KVaVA9KztLnbAj7/014YuGcwUikRm+kVjQn?=
 =?us-ascii?Q?bPWY4j+IlHwLl/5qVaYhdhgqma07jLDlMnIBqBVbNMFXVkmfQuPddpKyUN5R?=
 =?us-ascii?Q?htkwEeD8D11pv/1hxO5XkAl55raH9eW8wU6WC98qaMndW78u6e7GP937GCxf?=
 =?us-ascii?Q?NlOpqeg7eAVCqD0vge2FLwHAM3X5osddO8Ee4/IzJsYtlJUBeCHw0t/6PeP1?=
 =?us-ascii?Q?LSsEaFgD5Mmcx7hS0ORy8VxTNNkDyOIaFOZwyaKAq3YK2agyFAvWKN20yMyH?=
 =?us-ascii?Q?eMr9nuvMl0oHzuLCfJeuo7F22o2rrAijvkzO4RINZsFmCi1A7MV2tQp/iZwB?=
 =?us-ascii?Q?totto/XkPjJbRG94ydTBd1o7f1N9YoSDdveyv6bE/DxZCNOR/zH21ynl59km?=
 =?us-ascii?Q?WAJze0PtyJiC7SRwfgpJ5+aUcUDxqmUWV00DYfel92xPagSe5OIYZ5G5lIOe?=
 =?us-ascii?Q?5BH49IoVRDNVIQ91E456FI3y5Y7iBNxQzzR/3SX68l89TFkQqxuFVOzer5nL?=
 =?us-ascii?Q?RDwKXYaiKUvCz6Wzcknak1Y/gg58wDQj7z14OiTGmDMM8b/suQVSZEYK9sas?=
 =?us-ascii?Q?F1pTJuvwpQfWyqM/fpUMAl8EpTBgA8Wj3s2HnDZJh+G5cgqzRE4fnBwAn7HF?=
 =?us-ascii?Q?LLUyhZwlID9S3r0gj8tt5GrhiRiK1cts7W716JAX//VkZ3C4Jeha7nEALv6M?=
 =?us-ascii?Q?gUdfesBI5H5VN4H29oWX15nqw/t2cXCCffcEMC70JOmI/wmkp46bGt/WDeJs?=
 =?us-ascii?Q?bE4guuhcbKdrDiD6sW2C2HzTjshQkfmlWjmyhnwhI4BleYl9jrcf9WfkgDjn?=
 =?us-ascii?Q?dLIG3NfUHuV+9uROXgR6BYahiCuQFC6y6OeG/G4jp7mtfoy754O0eTnQJUxg?=
 =?us-ascii?Q?obNIJrZN6+//79543U8stY3gNhvXo+GXuVUo1X+MYGa5u1p7lt/gJFjCsZA3?=
 =?us-ascii?Q?mBb5Nr5WJkndT3r+O+NYFQha6j23mN1Sp2IFBarbS+oSd3aT+SVrFhFxkiCD?=
 =?us-ascii?Q?5o+6abrhPVaoyOKEoMW05pLdmib6dXG3Ti94Nlly86UvvooFEUKLIHec+5Co?=
 =?us-ascii?Q?ed4qOt1XS63/hlPpLyQENt6t3ha1nSI5Ct8ROBbb2+h54OItF++Wb/yWwgWK?=
 =?us-ascii?Q?NC84tlOfQKAVpoSExkqC6A9RNx4HudGEUPt25pjPZMu3OHjhxCIDjcTKjHXx?=
 =?us-ascii?Q?3mCypxZgBDPwG/nEmPQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UZlGTfW1AOd1OXm8y/eWS8YnDDhF8qUnk1Dtko1TlTaGpO6KAIvXgkswehP?=
 =?us-ascii?Q?TSmJC7xJ+rFn3oKmXLTpOASDgTctkQjtwixUA3ttjEBjlBjuJPyUjPePIkQA?=
 =?us-ascii?Q?LAEgiVg5DTjRCLPfhV7OzT8DUXJ0UDF/5ek6CfrRauVyzFfsmk9PEoepXJXm?=
 =?us-ascii?Q?0nUy8PsuOHU/uBX7yleMsjPmhMHFq//otdZF78JLGXYjJ14TuZsFHOX+ktel?=
 =?us-ascii?Q?dPbSvWsgenMcjPllOOH4DxO8Q1POS/r4SodkmuemHsjPK3hsmCmQGKD6mtv9?=
 =?us-ascii?Q?2S8A9VHfp2LckKdGUmmfGesOnJVX3o9HHK9jEosB5iDUar3HFlMruxFGlzyG?=
 =?us-ascii?Q?TsnCDWKz9hfxZzGxyXetMLgg6D2YeIiBvJAdXQM5Q9SiNRNooA5zwzNAD5YW?=
 =?us-ascii?Q?P26y+PAqu92bSyrahyfBuokCt6N/WaqjANWSF0CcGKQ/s3O8YplFfzSkXgXI?=
 =?us-ascii?Q?D6G3tpjJf8XFPJW02+AIVXbu8ViAxkZ6ojtsBifv2411FXGZo/BQISEyLYoV?=
 =?us-ascii?Q?OgluL9+DpHp1XRiUIQ4glX3N8WiORwRvzQccwU69WeZTj7rv5uIVSKxURkKh?=
 =?us-ascii?Q?5a5bsrSDOjRwpBTyS9Kereklw04H1RRocABDb59gNogV0GVr2Z5S5lqber/1?=
 =?us-ascii?Q?35I152Q+EzRuierd08CsK3HRT5z8Y0TGzNAn7CjikmZZrVZalmq4qAWgy0X4?=
 =?us-ascii?Q?zcUn8ogDarn6J5ibop49x8zsGl5l88QpVe0jeKwmuqEC16dNkDvmvsYn2oms?=
 =?us-ascii?Q?ZKG6EuHYoSpfmQkGh6j59P17lWlq2v+tbQcvBpdANZKTvyDSgcyxmuRX+oxo?=
 =?us-ascii?Q?VH+TUa4OGgqgSISNULN6xirOiUNvWkihofE5iV+49VM2Bf5imME/mAWxRwfY?=
 =?us-ascii?Q?d9JiGHaPZsBglTG6Ddsuo5EFxS42raI0x7nt0h6v54LoW9yPoHeMK6CWS9jR?=
 =?us-ascii?Q?WpbytOfwSgN0NLHTkECIoPNN3PEp45vW5EF2+dRWX3X6WLHRsonyFW0SvDgo?=
 =?us-ascii?Q?h6TvJmCde+XqajtXHXiyY5R+7waAa3r0ceM/P2tbiu9xrnNsF8e6QBhKUr7v?=
 =?us-ascii?Q?Wc3QutoQuh93ExnuzirWCq8Dm5wkOIY2/BMu+eSiJaCILToiuYbf316OUsd9?=
 =?us-ascii?Q?B7HUbbiIm+sLE6QOv4F172PciJRMpJrjNrrcWRbXwcIOmPvkR50z/NAyzi87?=
 =?us-ascii?Q?MMchJoM1rgTjTsibM/VlkTos1o0Yk9zxMyuN1Z6glA+49IqszbwswEnzXl/6?=
 =?us-ascii?Q?lOg0cmnV5JfnHZugA8Kd9HKfNpTsxM5TBuSCv1G3pBRsvZPYt393mPLS9zS+?=
 =?us-ascii?Q?p5SDTHjelEienbIr6EIMV3jSmmXiDi5qXSPNsJJmH7iJ3I4rcgz4a5EllACG?=
 =?us-ascii?Q?oN6luRT3sSdmRkwzWC61QU3f1doM4fww+p1AwQtS0ByMIP4eEwpxdAgSRhhZ?=
 =?us-ascii?Q?gMGaZWzQVBZrUybxzwTriIm735QrQSqG/h1eCZxdRA+teETDrZGkdiYJ51dB?=
 =?us-ascii?Q?yobwwoC8DRRXxu4dXUQZiNbZNjz4k09LRh1dHxtIUmGvbJENrkIVANSQpV/K?=
 =?us-ascii?Q?WGFY5E4tZsslQz0E88LL7R0Bm946sO372X0K4kGfSUrjPHYb+rpbShkBrgbc?=
 =?us-ascii?Q?BfEPZKEUkZUdKz/1fgUzhWIKFdrHcWJLFD90fwbspmvMZsX+U8B8whfyleIR?=
 =?us-ascii?Q?/ZpYeEBdHfABOGFDJEw6G2LUpTaO//gGpDmpEG2tVDMfE0UC336yxDCrGtIz?=
 =?us-ascii?Q?gCjEc0H2/h+35yOssbkHhY2CEyNLlKE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a40ddb7-0636-44ff-24b6-08de6a59b193
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:10:59.9804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVQDZ3uHqYbhV8WEjZ8EqdeBX0DzQEuoBfivZwXdntquWDJk2SOSnGphRjnvYRSGgI0SSuyEwNuYfoNcGIITHszxY+PyFLwyDfbjEtwtFFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
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

On Thu, Feb 12, 2026 at 12:53:25PM +0000, Anatoly Burakov wrote:
> Currently, security flows are implemented as a special case and do not go
> through the normal flow create/destroy infrastructure. However, because of
> that, it is impossible to destroy such flows once created. Fix it by adding
> a flag to rte_flow indicating that it is a security flow, so that it can be
> destroyed later.
> 
> Additionally, security flows return pointer to allocated `rte_flow` struct
> unconditionally, even though the underlying call to ipsec code might have
> failed. Fix that by checking the return value from the filter function
> before returning.
> 
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Not an expert in these security flows but the patch looks ok to me. One
minor nit inline below which you can take if you do a respin.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 ++
>  drivers/net/intel/ixgbe/ixgbe_flow.c   | 13 ++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> index 5393c81363..5dbd659941 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> @@ -359,6 +359,8 @@ struct ixgbe_l2_tn_info {
>  
>  struct rte_flow {
>  	enum rte_filter_type filter_type;
> +	/* security flows are not rte_filter_type */
> +	bool is_security;
>  	void *rule;
>  };
>  
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 27d2ba1132..90072e757e 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -3062,8 +3062,12 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
>  
>  #ifdef RTE_LIB_SECURITY
>  	/* ESP flow not really a flow*/
> -	if (ntuple_filter.proto == IPPROTO_ESP)
> +	if (ntuple_filter.proto == IPPROTO_ESP) {
> +		if (ret != 0)
> +			goto out;
> +		flow->is_security = true;
>  		return flow;
> +	}
>  #endif
>  
>  	if (!ret) {
> @@ -3350,6 +3354,12 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
>  		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
>  	struct ixgbe_rss_conf_ele *rss_filter_ptr;
>  
> +	/* Special case for SECURITY flows */
> +	if (flow->is_security) {
> +		ret = 0;

Rather than assigning ret explicitly here, I think it might be better just
to set it = 0  at definition, and leaving this as a simple goto free. [It
would also head off any future compiler warnings about ret being
uninitialized :-)]

> +		goto free;
> +	}
> +
>  	switch (filter_type) {
>  	case RTE_ETH_FILTER_NTUPLE:
>  		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
> @@ -3442,6 +3452,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
>  		return ret;
>  	}
>  
> +free:
>  	TAILQ_FOREACH(ixgbe_flow_mem_ptr, &ixgbe_flow_list, entries) {
>  		if (ixgbe_flow_mem_ptr->flow == pmd_flow) {
>  			TAILQ_REMOVE(&ixgbe_flow_list,
> -- 
> 2.47.3
> 

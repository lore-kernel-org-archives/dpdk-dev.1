Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4926C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70316406A2;
	Mon, 13 Jul 2026 11:27:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4F8FC40B99;
 Mon, 13 Jul 2026 11:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783934839; x=1815470839;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6HsDMmtvFfsmHGB5rGWevcNvRkN9f0Ul58UD4jH6XV4=;
 b=dgUxW4x2C/x1rFT4yT0TnCtq42PyOPM7Cfv+F15CsdlWYnf6/8MrYv3D
 I2Tld4HP4D7tLJYCj49FIUiuQ4bkwFLpI47Rsqcoynra1Y69Im2qm/8g1
 g83Du0D6ATWyqndFYiBAuk6DHYnfcOkc/UPVHIo3QSqvDdei09xVfkY6B
 oawp40k974rTcdUWwVmuuQuXiqqZtukls0jKl4hA3ugP1DuOKFKAGx6yI
 Pro27wT17I8O+0zzdfAI+Svmxf5cao1/dl8y9x5aWvvUuJFAWHf0kQF3x
 jty55JoReAoDXkuSd11lIbNCMDUbxwUucfgKMISC/ZhZuFan7vapJ5vwG Q==;
X-CSE-ConnectionGUID: c5Syf/9ITSC5b95grEB6Ew==
X-CSE-MsgGUID: 7NVSZTRpQFmVrWx9QGaZZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84317038"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84317038"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 02:27:18 -0700
X-CSE-ConnectionGUID: iy901QfrS4W4ZonZNqzmaA==
X-CSE-MsgGUID: mZ691r1LTLuzjK7/TlU27g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259802882"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 02:27:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 02:27:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 02:27:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 02:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL7GSvnh+BJhH32MNeRFPt3JhStocYrj+wdOTtaOd6b7HQSdQhPoK3aNZFOtwfLFF7/VceVV7jzBzyegWs80yWdSrkXA/JZop1kw6drrQ9LUIdup+20J6PMPKb89D3WbznCn3c/aKih4oUPI5DrQY5LzGqRBBjzlwQoNLmA0uDKPG4xF6vgQgxMrAHRXigTg6aN/JtPwWRgBCxnEn7bCLGMee+D5GcClcAIJLdh2lA2Dpl8FRKrwhtGu9lCsy6hKh4JFHt62QpfH1L5VAJdmm9B+mrZa9WNanUsfvvgyqq6vAPTV0ymqivr95roH7bob/RQ/MOLi2n7AjQxG5rb1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vOBBoDc37DgrBtHNqii//8TGCh5rN6gddz7R2QckHE=;
 b=Bjak/jMe5Udk+/H68hMY7P2R2h4NKpjdCo4+WAJ2/OtTN+BUsyEkLwj++Qj9n/UBTpNpE6fIOslpHKJPe2Zn1Oh8uQLFD+5fHCjkc88p/SIFiAFhn4ryFrRDrz67+JxoddT3pPoKyrdjM47C5K4k6UbEHqJxSdozf54q0dyEySRXdDJvCg7qWUHoXwIlDfm2JsJFLwy/glrFP8U8IozeEXpqTy4b0Gb37+LYyzLrMMTXYuKe6fwRbEoq26MROmFxM3/gWlGhRPYD4biczgrW456Me6aZBH5GckmXjRgYAd+3oq7nAdSppawpjBkQsJ64g16vbI9cugi9RI5CYAT08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by SA1PR11MB7132.namprd11.prod.outlook.com
 (2603:10b6:806:29e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 09:27:13 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 09:27:12 +0000
Date: Mon, 13 Jul 2026 10:27:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix missing return on unsupported range in FDIR
Message-ID: <alSuwXCSpecgJGn7@bricha3-mobl1.ger.corp.intel.com>
References: <20260712032647.196461-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260712032647.196461-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0229.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::26) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 6608a96a-b8ff-411c-e862-08dee0c0ebbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g5kGQiJj8HwAVOeb3Of/tp3hVqqiTwVNXqiMKpkvkdNt8PP4q80FbxQ2dRmMfMUTwy8hVqQobJ3G8GnewRifhV1SzOULLut8dS/jun6VD0cRiSJ1/1obyOZ+Tw6aYqwnvVrWyxOA0F02eI17oLfBpC4jQYhbXpCqSZWea8Guvra6BGmkSyy2NBc7Fb3QphlD7PHFHQKHBZcsRzOu7bvQ2aAJqqHLV8l6OWTcGAZDuivPtW/Zmgr20+XKojrT33s3plToyRcaVc1k3yAncSgJKYY83nwQNxaAbsMvOKxxsmDYNY+9cCjcal9wB+kTreodgIpb13D0oziuRtaSeVWPuopsvngoqHLhGkcaqs4GcBPKaVPTLR02UsVC8h7q4ofQx2BS+UN3ZuPZLyW1vANKDT3S3dAE5FSMXB98L1PcryCax0TjFFLq4w9fskotI63RB3FOsWTTy88QT296T3s6Ku6CDiZkKAgfMFdSl9821r/Abqs+Z8KDF5m5YLNrNCZQgigkO3iSHUdvNJugKlkQrToFfJV0GZJk0OgTEBXQF9zv+38i2ccCbVWlGhyrnW42d4TWnUx1s58ou0IcP1dJ3uL+CRnEgry0qXWkRV3Rs3yA99aBGj3f112IcbA5aVrudh7/pUpPrfWXkVfE9dXl7zmebCQRofbP+EjvwX4uCPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0/OWkjoBA82Pz3Zy9l4wQZhZJoArmu55lLi3IoONf1l2yDDEAKsT/qmmOsr?=
 =?us-ascii?Q?fWPg0AsGRijrZ9w+JJw9LsgdS9iCXF2WssDSPgP6nfjRpRUofGBumBAZhXhZ?=
 =?us-ascii?Q?hrNao+aKrNILsjdDBcls3ZKHchD/H0MxJuyV6MQ+RqXt+rq5E6tN9LPTgzkc?=
 =?us-ascii?Q?h8RF/KB+76JgM0+beegwjkJTQvk8JtTsQmqbctFPsiPThGZkGRYJM0tCPYK6?=
 =?us-ascii?Q?M11h/GiO91RbR7SOMcrpe/WOTOoaIgW1+f2eOgnmOVuGhKrhKz+61K8aFhOX?=
 =?us-ascii?Q?1wzniEzujHc/fm1nLI93cJsEwpctjH26r1qsENfVgDKw0dQbkLqf/h0obyjd?=
 =?us-ascii?Q?zinRS1W/Nu6iNYmezkUDrrwMpqTSSavcFvA4ogy1xzQK+wjNjXKGnBmX1dsm?=
 =?us-ascii?Q?EXhrTuiEZLuOhj2056sAWIy8biUEQJAcJy0ML1f5w6xLhx4Qr36uQxnkwaWg?=
 =?us-ascii?Q?isB0ANLLA2ZDHbUqVWlcEG9vkCBSXDfuAKxdRfz4zUwP2Vf2OEABz4NFN35r?=
 =?us-ascii?Q?trKTLZE9QqSVi0t6/+fItncIIpWWf8iIE5jhX2rt105PSVdpgWruuJ/qbir6?=
 =?us-ascii?Q?onIrXBHV/Q50pJfsXMQrnX2Fb+Gaqm3jr2TUo8buR6TbPh+bnAKZESClNCbw?=
 =?us-ascii?Q?4HVI0UnrKAe4QYRDLH1yqv1jFkH+TJAa/GYGA7vKFfwfyQ0fN5amkXzOzimT?=
 =?us-ascii?Q?ZGslvkz03ciFdbEYmLRsByHduKyGFbl/XJBZ6W4eKtELDk9FAjTwf7kAQisW?=
 =?us-ascii?Q?3dxZQqbdbfeE0K0uagSWRw0eqwk6NgXIkLOhFmsg+752Ocu30JEN42oTWCkX?=
 =?us-ascii?Q?Cl8APP5zDfl0Ef7a/xVfzn/pltUbgc2m/XBEUHu6PzoBBaBJ2s5/YoiCEh4j?=
 =?us-ascii?Q?Tjgnkg7cd3ykKH/T3ROWpO6r5j/S2gsTSz7WC7Ti0MucwPlJ2i+k5Hma9YSU?=
 =?us-ascii?Q?5wFdVG44NtxZ7LfZajQk8HETFl3YStakmq9GD5pHWinKRVqDzhTZVjGmvMQk?=
 =?us-ascii?Q?jiTOMWBhSs055yBaLtQPvt8V85zqGVn2ETVHMlSPnsryevXvlgUyHn5tsoOu?=
 =?us-ascii?Q?znuBwos3Z1sxzvPC8bWuKiXWzqOZaT82U/G8DTcPxG5CDqBArSQux9NQcyrz?=
 =?us-ascii?Q?xnF5KPqCaZAuuMWG2ts0V2+IuzGK5WEfS6txoLvoT6Kwbvqu2lrVh1FnPTJv?=
 =?us-ascii?Q?N5a5bKVJElWNK72PxIPvMip5Tq2nQLbcuuSe1CTfWHDTmxkjg2GVIkJysFmz?=
 =?us-ascii?Q?tFed6xV54EMyrOkexdQNATnY3XzRRRhsxPLV1OUdrpJsdO/xtrk9rIehnWEw?=
 =?us-ascii?Q?aJLUVPTpDShC3CPnxbt0IZVI/CWfwOLKsDEaTOk9lAI/9ZTNN/fI2+Xz5xhK?=
 =?us-ascii?Q?pvHfeygSVYjBQyxLdX0K/w5UcYn1AxUFi/+UMzZ7Bid4p3LRG0Su3uJIh+hO?=
 =?us-ascii?Q?1ZJuemANq6Rc7AKiQ7YWDmJy7HjL7L9wdzavep/95dyJCcTN4GkNLmVVRp8/?=
 =?us-ascii?Q?4V8lC+kSM6n00aZT/XaSNr5uQBaYcWy0M+sn1LcJPNuMUBE5wVjzRi7SfBO1?=
 =?us-ascii?Q?2f2ggMebPXgbCnfkEvu1vLLN0PHqenZnyMi/f4zTiBkro6mAMkiAgxiemmjM?=
 =?us-ascii?Q?MzQUIGdjbT3umJe+qHc4PNOSF/jD9grgtKHVWSSkumSeEM4QXM2Cv9vEKukc?=
 =?us-ascii?Q?0B1ZhIn8RQuPWXQJSgsvYTuEIFPAG6cM73zEro/5Sd+sGRS/BGoQkBC/uwr5?=
 =?us-ascii?Q?zcFQU/sTAiG634JTib+a4qepKaGRcGc=3D?=
X-Exchange-RoutingPolicyChecked: mSFdJa6kyLP77fijKBI4cGM6Go3YdXEFJU94O09vhpwOi6KDDAWcLq9Pk9ZeGguQU3NwgbM8MluvfJZSJelBmeW+juHqdHyis/Nxqg7oNLDGViR7Mp4V3RFIyn3J8NTxCf5GM2x0DHcbdG6LZ1frf7wwPApiZ+j5n7Z5nyuAcUb5ZnjAQWSPzP9MMAeVrEy1CFtdVXOJ8j8nM/lnLKvbiZohU86ev3V2Own0DvFXgl5jNwfftzETMIwf3dtHwAjV6VxXLq6zllaRZBZE88rhchklYGUFT1WghA0vH8W4UZgwDGxzh7hw+wi6mAhIDyKecWnp9GdHk1pQRCdpr+UydQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6608a96a-b8ff-411c-e862-08dee0c0ebbd
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:27:12.8861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9VQSSA7XVcObAleCspB/35FL5AALdQppYqvvpwhOxYhq4+iT2Ygk4OFdp8MqYWujRWpswK6B8SmfrKu1Bvhb5N3lqT68dCw4iFSOMMAAgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
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

On Sat, Jul 11, 2026 at 11:26:47PM -0400, sandeep.penigalapati@intel.com wrote:
> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> In ice_fdir_parse_pattern(), a flow item that specifies a 'last'
> member (a range) is only allowed for IPV4 and IPV6_FRAG_EXT item
> types.  For other item types the code set an rte_flow error but did
> not return, so parsing continued from an inconsistent state.
> 
> Add the missing return so an unsupported range aborts parsing.
> 
> Fixes: b7e8781de768 ("net/ice: support flow director for IP fragment packet")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Trivial fix, ok for RC4.
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index fc848a33db..d7ddd32f90 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -1929,6 +1929,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
>  			rte_flow_error_set(error, EINVAL,
>  					   RTE_FLOW_ERROR_TYPE_ITEM, item,
>  					   "Not support range");
> +			return -rte_errno;
>  		}
>  
>  		input_set = (tunnel_type && !is_outer) ?
> -- 
> 2.27.0
> 

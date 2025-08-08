Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CEC87FD2
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 09:25:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A561C402B3;
	Fri,  8 Aug 2025 11:25:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 23A63402AB
 for <dev@dpdk.org>; Fri,  8 Aug 2025 11:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754645153; x=1786181153;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OmLvbE3rPp+9Wp3CsfeYZJo5qzQ91QaY8VSFANxUR4c=;
 b=fzhGqqZbD6Mo25JceXgM0v4l7WDZMTMSd8JnlyP58hlcjWsvSM3C9Fdy
 7Qguec6ar5BibTRFef8EE1OQB9WUttYbQmM+G3I82Xx09Puoar3Fpsld3
 AnEduS9v4ZnVROtHOdz1WSLZUQrWDI5EK8BS/tTFScMVO4lwTgeyhoTXc
 Mb790XfWY5GeWETZdKj5Q4Lu+GuVTFomx3yKglrNGxua4iHk0w4zlgnwA
 K/9WWi5k3UcTdcoUeTRppzbH1IH/qQeHNP5rU216XSCKu0r02oAoSE6VC
 U4SasCSjHeQQ1MXJMOC7W1j2otYeq3YrM5XiYmZN/QeJifj1bTegnMmrH A==;
X-CSE-ConnectionGUID: 0bYVI5R9T7W2+gNvlO8xLg==
X-CSE-MsgGUID: sLZdfE4tTCeh5Vf9lIwMsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57133375"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="57133375"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 02:25:52 -0700
X-CSE-ConnectionGUID: 2KFsWxEhRlmQWTjPMucS4Q==
X-CSE-MsgGUID: n/LEb/rqRP6bcEgglq2xzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="169498987"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 02:25:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 02:25:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 02:25:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.80)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 Aug 2025 02:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuzV10fYz5z6ImYO5Kdd0h1+5hsyQEpcrkmj4GpXXnNowYn3Bow0Jh6WqBnTzkCPomRSdjZzaUaH5C3/flh9AvPcE09HtM4ik9pFAAIpo0jogcO200CdNTd4v0j8B3iuNYYm/iVG0bXi1uTzrEuT2Y0zFxIAjbm1T97w8scUJTeNL0Dll+QCISB8rXNXfypeHcAde1Zr9TqARvDQl7nRLSuMDCFFJdyrLLQ9WI+wkPTKSKg0Gq//lyYojm/f0CJ7LcmqOLm1LBNklY4IGFFb1xdQwGKsnW4pVsJDf59uBrvB6mryk+hruQGdw+ij7om2OR0CGEziVOj818faZ3lqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoMOOvu0eTW0jOyyEsoS6FIDhnKeUsmcCUW3V+i7/c0=;
 b=Te2YOBPGWJw//d+Qy4i13kT7/CsYx4ufE1MT2/k6GAMonrx4VdjE0+3sX9qolS5P4bHx1f60qzKHmlhhNu/cwrBDXRRAX/FvY3p+9Dc4wRvKfMiTE9XAUmaj4CR42bysml7elg9ceyXX32CWugOtrCsaabw7qiyfROIxt5LJWKhxbldraNDI15jDscFHyTuKnOQ4U0y4EWPnGSI0kwo2b8p21adzAVn7AbRXuuKD/oXK5ZWFeqh9io5nrMXot2opMs9sDuU9vqvJwFQGnom1OWAALpSN+Ln2PkeLXjn+pLN15o1AHDJfs6jOh8b/C0oMD+7UqDUDDxJDopZroZrL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9086.namprd11.prod.outlook.com (2603:10b6:208:57b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 09:25:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:25:48 +0000
Date: Fri, 8 Aug 2025 10:25:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yijun Geng <1204565380@qq.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/i40e: support GTP in tunnel parameters parsing
Message-ID: <aJXClxDQiVORnCcj@bricha3-mobl1.ger.corp.intel.com>
References: <tencent_51BB4368612AB46A24214A53B97AD8A3CE09@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_51BB4368612AB46A24214A53B97AD8A3CE09@qq.com>
X-ClientProxiedBy: DB9PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 86876ea3-2e27-4aca-ae1f-08ddd65d8f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pd7JeWRlktUOGnEzWQ/dcMrFFZ1Y/IFpF2QEZj4pSg1E19a1jCvBCYkSnMVU?=
 =?us-ascii?Q?gG0/8eANkRlphTFB0dgg2AH25xG922QuAQgSdwr9lgS6FQmTZLTjmff6Ey2F?=
 =?us-ascii?Q?m8iGCkzmfsxanWfvz0AclZ7uPCtxqmoS6ugdnZO66gSSILqKgvn4B+MyU2EC?=
 =?us-ascii?Q?ZK/+AOM0f2C+55RZ3owetZh8yscio8BDtErj9ocdRPNCq9fOFq5uYWPPwnyu?=
 =?us-ascii?Q?hDNgnvK5r6w6hGJQ5jTdk9cTNtdSsznYZDqo8Ip0B0FVP1wtq5rvGJI0MD1o?=
 =?us-ascii?Q?8RFbO596sqnVvcN+PPPqgUl9Al/uU52GWUXjT94QsR0DSr3y6lOFoYCaMkzb?=
 =?us-ascii?Q?MsYFFkHFmZRILCrXMZoON5cPJ/2sPFqGhGEFC9fTPH5yj0K1eTosX0KtEW4p?=
 =?us-ascii?Q?IQfXs/W2gDyEwQptcmBBEd1K0G3jKl/Wt7OisD2d4zpbw6uRJoLGFkIQbZZ2?=
 =?us-ascii?Q?LaRkneSrm+5+D3PT6HP9NQEPjvvgPzXun7FdqvPh9q5VIcLEZqPGEk8uIO8c?=
 =?us-ascii?Q?cXM7S6pdC8GdICv88XJWk2CwmoGBIkz+Zfy1u6FumVkYRWNq7g/FJGgSjLuO?=
 =?us-ascii?Q?3v6VAJV32QhTpp01JqH9Q7BkdK3E2wg81D2h2Iu/pumAkR6COSrF/6Njw3vr?=
 =?us-ascii?Q?bjtUEgrLonjh1SDrv198STY23lLnTqBNRiP6XlaS+c/eRtVXAU0pQ8PpPRRa?=
 =?us-ascii?Q?0srkA9ZCMjkxiAXR/4i7J1NadMnZ6/SmXvddAYL03at12GV+u2RqNaUl9qBG?=
 =?us-ascii?Q?L5kvyGN6SgwbrvSfk+k6DczqeoWvEFLPhobz+8NgEgE+Si3ETjhR064vKImC?=
 =?us-ascii?Q?LPc3zuS0qjY3+gmhIBMHZbktJxcPwqdbhiRB/LkMmZHeXvCCs7T9ZUC4VqdP?=
 =?us-ascii?Q?DibYG5J2wd62kiy4kXDsDj6gNZNAOmD9O5eSoITOoShUA9Fm1sm+s0cuIMvu?=
 =?us-ascii?Q?8Gb38bMIQIELFulruEeMDVVxENRWDxEZLM2wZojB7Ir/uKFOCdA/FunNETB/?=
 =?us-ascii?Q?qh/B7g9wfi+sO7Kt/C0cHAeim9B9qHp7hvIQU+OVYWYera1zO1ACA1lllX06?=
 =?us-ascii?Q?XK8LhUwcOplWnkOXY41lznNoJku+u/g4AswSuUW/nnTEyR1+07VwnfBvfmiH?=
 =?us-ascii?Q?PPhH6JnUOB/pW5YWu2clZbpIC0mSCA28TP+Do+FjBtZoDUe4xw/6/JDyOZ9I?=
 =?us-ascii?Q?M8LmPEF6bHzhabgAoPkqMYZ03727vzZWGswS6HZK3F6Euc83kLX+bYHbJ5VC?=
 =?us-ascii?Q?RdbRCh/x8a59PYiA4sPSZaddHBw7EdZpdKNx6lE4uKufp3xMzm5RSElvUX+3?=
 =?us-ascii?Q?SS5w7D/b5Iy2bfVUrTVkuRNGlQaKsrLwtrSjJrvWKitOaTldOQxTgQP5EAR3?=
 =?us-ascii?Q?vL5Lc5QMelLo/bj209b4zHKf6JiFBonZ06qbX9GGKSFzTE2VmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfLK2oajwehW9hSd792hpbvXMhQ5Py9DsxwcnUSPD/xPPVi4g23bQAPANa3j?=
 =?us-ascii?Q?OGLZb99Q8Eh+MbmIGGqBsbw/XKFO7hmLKvdAaenXb0lMpJdRCbgsnQfJi2Dc?=
 =?us-ascii?Q?a2HMeMFw0K68LqnzsMzmg9EdQiDzMIax3ByJqmEwfozni7Km34BLlZgMfK4H?=
 =?us-ascii?Q?TM+BB1ebUDrCADQkMc/B3gmyCRR298q4UtZqHKGr+ngZgrgtXpxkbkSNMs0o?=
 =?us-ascii?Q?yokO7ho2lNXscBVmcO5MseqerfUDodJqtVtJWpJIY3naRhY0SupSSD44YBvf?=
 =?us-ascii?Q?b2xAMmNKL/1qrTpqpN7C0Zz6VrgCNm8bGWFBg0P6vbYhOShZJnT/Q9ngXVE3?=
 =?us-ascii?Q?oXsTT4JLXCh0617Uhludeh2ygDKrKBfd/0Fj7L6F/irvZxZwf2Y6V9wjZWBO?=
 =?us-ascii?Q?1FP/ZC4ZbHHMMJI5jQWvhSVltDlLMovtC2QSP/HJqK30Ftq2l4Z9fFGFyYKh?=
 =?us-ascii?Q?rV3CRmVWIdRTX25EFK5aoTdZQEJBaj392HmeZu2s+h0+mVi/nASgcECkmlF4?=
 =?us-ascii?Q?TqYRzBdw8OgrENcYfrT+g60F7Z7mwKscyCfLDITiU9zMcRnYMQzu3apsB0SM?=
 =?us-ascii?Q?kZZfn2UW7xjI9ZED3kbs5w5H036zBM6Q2A7JKc7hl6gIwBKgOrbq/dXV88mt?=
 =?us-ascii?Q?yJWcn/4gef1xO/3Bb56KWo3lh+w6vHhOX3EaiFNXcAODHshSsuP1rFk/DpfZ?=
 =?us-ascii?Q?mWbMWyKewdh3yKOWu4qWSic2lGDbRqVZxP/tWMcTrjcZBDUR/8V12wn1TpOu?=
 =?us-ascii?Q?e+xnjDHXDCSfNJo8rzU/7djV2Sexr88r0xf2+e4t+JT/lcLZ+xnVYJZqEf1/?=
 =?us-ascii?Q?sjAdWphk7YP5vuErnALSTomvDLm8M5VceRgpj2nkJqLfxid4bOBL6rUL5Yf6?=
 =?us-ascii?Q?DeGgbPm4EOisWJsC+O3cdTIqbqf8Hd2OmaT00B960iRjzKrXVFfTHUmtV61W?=
 =?us-ascii?Q?TzXrd8Jl90kB44w2FAZfMZg2OM18ZohD+So/KmJYEj7vOuimCmLwbTebFeir?=
 =?us-ascii?Q?EY25OLnv3tcQDBpv4fO6UQc+pACVrf5Xxr0y5FJ6vqTYsDv8XVMd2+fy9z5O?=
 =?us-ascii?Q?yE1ortJgK6q7mzlCEf1ELlj8/Oy/Rzvfiy4pw2AWrvo8PGnkSVgM2dh4kDrO?=
 =?us-ascii?Q?xvMyyC3r0wyt9QLukvHSyetTBpxoweelCQzIehIWB0Z4fKJO4X4tIqdjdoCp?=
 =?us-ascii?Q?GXmwEEwFKFgZUQ5KU1QNZTSEfK3owkXHhHb2oa7wAGDis7fkEUPaki+zz6Yn?=
 =?us-ascii?Q?ykFHbnyEubapb2XgSCgUdpNayY3dDAuVBPWTvYAq0HEWuQKMpggdGWHpdoor?=
 =?us-ascii?Q?I0cu29mOGjR9FrQ/WuBMErGSu3Z6GcZhJ8K9k9X/d3QhxGMBupKSw1VxbMaI?=
 =?us-ascii?Q?lgNHQEFrhdTr+dBERNfl4kX1dX3tfiY7iv4CskI9ZXlIbyyMMrgC778KU6eq?=
 =?us-ascii?Q?5FwM7yNXEF9FnYqueDka3CM4mAQgVZx/BmeIuNPwlqjAvXKVdRvqBjNOAUYE?=
 =?us-ascii?Q?KMVl6T12QeO88TjW2Sw/pAgZxtUo+kG9lYNTZ1xal4luZd90lCKDM6ksB2rS?=
 =?us-ascii?Q?hXgit8MvD9XERb1Yk8cnVpLr+aUyUG8ZonpwsCAIW7zkT8x3Q6FaxbmiruH0?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86876ea3-2e27-4aca-ae1f-08ddd65d8f45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:25:48.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWF187r9f/3YbK0BonMTEdaQcmJztrF+DKTYIs2VjaBXpeY2dwjewezloLpLM2v/km0MWCOq87iMXOYL8PkPw1d7YTbdt7HfbI97tggB7Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9086
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

On Wed, Jul 09, 2025 at 04:32:14PM +0800, Yijun Geng wrote:
> i40e I40E_TX_OFFLOAD_MASK indicates that all tunnel types are supported,
> but gtp type is not considered in i40e_parse_tunneling_params(),
> tunneling parameter: L4TUNLEN is not set. During TX checksum offloading,
> the incorrect L3 header offset was used when calculating the inner IP
> checksum,  resulting in modifying the length field of the GTP header.
> 
> Signed-off-by: Yijun Geng <1204565380@qq.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index aba3c11ee5..d59d81474e 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -274,6 +274,7 @@ i40e_parse_tunneling_params(uint64_t ol_flags,
>  		break;
>  	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
>  	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
> +	case RTE_MBUF_F_TX_TUNNEL_GTP:
>  		*cd_tunneling |= I40E_TXD_CTX_UDP_TUNNELING;
>  		break;
>  	case RTE_MBUF_F_TX_TUNNEL_GRE:
> -- 

Seems ok to me.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


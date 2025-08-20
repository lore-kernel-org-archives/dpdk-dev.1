Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DFBCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69514402DD;
	Wed, 20 Aug 2025 11:47:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7C0B740292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755683260; x=1787219260;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F/p4+1NASzWjF7uoF5fPvf/xp19FnuMeqursldp86/E=;
 b=lZaEcf0U64tbVavzrbf7DmZbOhl2oj4wGP8rznc0YJtqsljnS4mjj0of
 0b5McBrxkZkDjlTVArszWcaUvazWIdiVF6J+JfaIpp1HVTPzd3yaFHjTB
 oT5z6/qUKfyJt/LRTdnJlGqxmmTT7lEPkoLCYZ16Rbdmw1wb4qC45CENV
 b4eAoNg0rXBdd0UeAS1Oa7lDmnwnlyKGLFr8iiK/A9KO4hHYpV84LUmGR
 ryjC8huEpS3Nl5jEjO8Ly9E5TQdBqsGX51WhQTVYpmhi8ndPmFTgIZrCB
 5A6lJ6FSN9ww+5ao4T2jiPSLTTjvNg1G7uJEeetJfstZzOjUnwLeCXZu/ w==;
X-CSE-ConnectionGUID: LKU4KtTCROOxlVBXO2cyfA==
X-CSE-MsgGUID: 2PKF8ko8Rj6e4iSXSfmgzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58093592"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="58093592"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:47:38 -0700
X-CSE-ConnectionGUID: uiwwf0DKTvmj+H/aatDw3g==
X-CSE-MsgGUID: 0usa4RphQaGY0EjpuHVdwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="205243502"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:47:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:47:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 02:47:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFmWWdd4hW7RIssR9KL8LiVqRoTESF/LXkwqCd8kQ/+QxlZjGSOHyKoydRw1WXN1jakjyybmHZ0UPQDEbC7Pr8I/dF8g6YPKUhw14JXM5KepKv/eqlEXfKhoJBL5xoznMVJp5otpjMSdukF8hrlzgEhh78094cl8/tPCkN/OZI7Jq5f/gozjho0EQR81Pa4w96/3ge8txOd0kE51nZsl2tapeM5n6eYXABEuKBU0onVrYEYHosBpt7DKMauT5FLUw+mYYlUunY2yh6VSlXSmr9TfVFl047Xi63Dfs+K96VOme0fQLlpLbno+4UfNwsvp/QquIwCgLVsUpY8C79Mmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEJ57ydGRGcEBXPcgzaFKv99K9IyMjtkruXUyR2LVm4=;
 b=bL0ZOLw4g9flyJ6ZGN5Ktv/xJgnRHMpClZKbXKXzydZz4jg5xHGR+8eM4kIgMWt9/bRBE2Z/hNIwW1J3QsXlSH14ddzp/AAlyFMjCarzT9cDMjlnCOfNbeuYJxT3ZIucWApMmFeteP74yTW0nI2ehqoYizUWpVCaIVUhsXeiyHFe+OlY7My7snb18u3COHWaU+dtMhIhNFOYE/1kfbmoLw/ruJ2o7gTTGwevu6slwb8ensGhiwvtniT92Wp8OlOx5xIs0i0zPzB/XH4MHOYsr0tnnpl6ZJelnrn6BZvRBR58SEp476wXZhNhDYUcMjMTEN7C4tJiBVqrK/sD5uBKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 09:47:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 09:47:35 +0000
Date: Wed, 20 Aug 2025 10:47:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 13/15] net/ice: use the common Rx path selection
 infrastructure
Message-ID: <aKWZskp8TOzugdJE@bricha3-mobl1.ger.corp.intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
 <20250818105914.169732-14-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818105914.169732-14-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0062.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7cc187-fb30-4dce-7623-08dddfce9790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pFyqdZrqNq1gAkfdNnSCD54Giq/lF9BPZ0Pv+57anE7wH+bjarqixrj5JQ1M?=
 =?us-ascii?Q?R8jqMFL0pfpgKDBZ9lbSQxwQejl9qpbSgy8W8t+yp5v8aaFSpXOYzxrcat62?=
 =?us-ascii?Q?I/X0niG2vV4yXeBE5phdwDDU5b+JU0tejSsq4ZReruBWynbLBQj1vwXT/yQf?=
 =?us-ascii?Q?VLfIte5JOqp3xKHbfxOkf4kEtMB1MR2KJsX4CN/rd5gpvYibXUsr3rmrfwO5?=
 =?us-ascii?Q?0Lh1NdMAM2ppznXF09zeaqmit6J4PGrX1PMU1dpZfN4dD3hVKTKLQN1m+HMY?=
 =?us-ascii?Q?DmVLIGBvabmjtGXYgZnVBXns5m4GgkSTJRX+C2H7sscP3Qt76JFufVzJdkfw?=
 =?us-ascii?Q?/w5tQ5Y3MX2bzd6UrwhGheT/3XdD7LH6QPl/UciIYj2jvxlog7g+/UM8iPn2?=
 =?us-ascii?Q?U4JHSN01h71hiWC+KUEL7EB++xgMpfMP26gf8/8gR5ZPw+AjhO2oUDYrhna1?=
 =?us-ascii?Q?pGjOrCSLPmEf0DrIcvtLAL2SwzGyPdA7mAaXljBuBJupEPw4QSKzfIt2ZE1I?=
 =?us-ascii?Q?co5BxgI46oMPQpGnsZEF6lQXyN8NTjEMYs+UigBpgiq+NjoHzA6DUBNY5rsO?=
 =?us-ascii?Q?PJpJDsCnwKxODX1MXrT6tLKbWWjmXChsPNw86nwyB4FMMgxQjKwazDcTo6CK?=
 =?us-ascii?Q?EPQGjUddgrRZRakFBjWWgJ1Rd0gtFR1DNgpOMYz1omyINBIUwmZO1VSGwLlR?=
 =?us-ascii?Q?xhM6JmJWEM5TUh7mS0sZ6bfo2FYpn5yMwCVDAR/APSnIwe0gWKSuDzbnAouk?=
 =?us-ascii?Q?Din0AB9wAdV7w1DJDv6whACtc/9mHK/TtMlcBZJON5eQkfnY8FuW5g+mK9Md?=
 =?us-ascii?Q?QmRAgByyxhEY4476CFEXyjO8IIUsmULIuSjDGjoiXupInb9wNqnlCYo05xqA?=
 =?us-ascii?Q?3lD60CRcnguqjd7O7th0I3sE77hSBJ5zAMsU9BT6xw9Zya5hzPUcJKtY7LrJ?=
 =?us-ascii?Q?CpIeH/8adwbZoMzICmIaJPH1ghzRm/OPxNaEpG0BvlAkT3OhdxwewYCm+I/C?=
 =?us-ascii?Q?ho56SM+Trim0letpkIwA08ifna46s8FtCrf6CMGvHZ0w/Cb7Rx4We67kM1NS?=
 =?us-ascii?Q?6paQdqSZxfQwEW1hTDSLc6biuGpY+p4xSJM2SMinRGUEzjmdxDLIhrcqKGwX?=
 =?us-ascii?Q?IAtkHlRZTHpx53upxDeKNgpPkhKQnw7MbwtOwCzo/cGLLoQIQ+8sbfjQTq0Q?=
 =?us-ascii?Q?RKosMq3M90SnpV8PEdqSjNKTy0tcJWHv4y7CFvwQrLtVmPKXU599zpgYhh0B?=
 =?us-ascii?Q?QZW40GGA0hKP7lEaeYX9yk5U7RlUMDCbgnbqZMrYA/3diSQX8QjCM0iAjnsK?=
 =?us-ascii?Q?3jGlE9V4EmaVXBBSqnPz5rbjmy1Yq42jVFbWRQ/+acRk1oqy+PfHLMxA/JNZ?=
 =?us-ascii?Q?PdRpB+U5do+ptRah/r6CiWTdg3klR48zykQbXZ/UNkAt0r45Ggj8H2iyRnad?=
 =?us-ascii?Q?TeOghWh/Tn4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2kMVNE+r4uIFshauSulrNcdm3ZJhJuBAdmAB25bS5kz1keTsBdgabg6voD3B?=
 =?us-ascii?Q?zLiEzWUAQFqgj+MU+U9v8eztJlWys2pxyLUW+rb847kzKp5nooyC/CjWxkwU?=
 =?us-ascii?Q?fcMw/YNjlHszn3T0WXx9cs1grMrUS0ZTLnh4c+R2E/dyBElrSbb9L3rsRQtd?=
 =?us-ascii?Q?zc7+M9dXVyLS8rIKw/CkV6QIYze9tcWRS0849KAKUt7oUZPTf2LEjnRvv8JF?=
 =?us-ascii?Q?qivKWaJGkuPTV7L59rvZrI0Vaw1QpYWIek5/tU6uQwWfwoqwb7FXoaGpsoxw?=
 =?us-ascii?Q?xSt1LwTzi253iRw9usZSmWl4ArPNEdFstPjd+AFHT52I8RQgYubqCXzoPXGv?=
 =?us-ascii?Q?svFqFEWmgJBkQ6DFYPW4yn9uGKYCexXS1VCt9DhvG01HjXpgRu+gd5b402GK?=
 =?us-ascii?Q?uxJHexR6kAxU2YJoTzlC8dj5sxtspigxM3cKZcDASZHGd7kT0ecu5hVkRDFZ?=
 =?us-ascii?Q?+wXuQubRmH/k60N80xgoL/m1JSelYO+z6qVdTXJJeaqoALz8mqyR5c5pq3ee?=
 =?us-ascii?Q?jAiFBJvJkzIvcBRUy+DjwHgSDnsFvXy+buNT5lISQFgYmPEQN0fd2L0wSyDM?=
 =?us-ascii?Q?33qVtYxRUFC2pktbfFY183ISIMPgHTspGUmkzuM8TYk7dy47VuwRd49x37PC?=
 =?us-ascii?Q?p/dLMI/KtjyMD/MzgzmishTDo0kspxUPaOPMQLMV6Ra3WJR1InWtA52Z4xkS?=
 =?us-ascii?Q?zcKx81c0Z75NyASnEezr//y6Q5PMIiniV8KRlq8bVeereJBl4ljQLx4b/eqQ?=
 =?us-ascii?Q?eBTl36lGqD4ftOlBydoHTOtKnQFT/qJo5ewfdvm3f7Kc4IqbgJu8ib8fxtPA?=
 =?us-ascii?Q?RO3pHYATiBWQ6YvX438D8++j2pQhftUhUx/E0Jj7le2O7fb8ouYjCQYk2rjF?=
 =?us-ascii?Q?DuCdCpGI8mZQotHscno2fxg6c+z4O/bb56IRvatOyg8airyeGEwMQ6JxOZQK?=
 =?us-ascii?Q?QONkfo1yIg/wuLhPjaoZhhdM7KmVykA44CX1ljL7FyvOy5mIQ5VbTT8gCOmT?=
 =?us-ascii?Q?0GtBi6KB613PncGd5xeuuS+vOw84i0ynwk1mMcLnkNpQbbLTK5vaiQ4hCIQ4?=
 =?us-ascii?Q?LcJlTMhwZpaaGumbK1PlwSt4/49so4d4imlXb2cvuIZPWHUQ1x9b1XYxGf2N?=
 =?us-ascii?Q?nSle95cSCF0F4k0RrQEkr3Xmlv4q8hj0D8zz8c6Tv1955Es777zm87yxJDPc?=
 =?us-ascii?Q?Na+OUGg9E4TQizAEBn0ju2COtTPRbSEC00nf2ueFAEgyRRsespbc++mWRhZw?=
 =?us-ascii?Q?bYOWL0j/KOxH836nhPehUjpiM6hvZdOeXiqHbr2DleXtEzU3DIV5KEyep6y/?=
 =?us-ascii?Q?ZrVAIH82NXb2TlVwv04RIl8AI1s7cjNmBSTIsbpaYwHQm1jFNv/J5t0hlqmz?=
 =?us-ascii?Q?ywA3YZ/QMB65RS9EViJ14nhd0jxu6Ldb/EHT4Wbul/xDugDd63ptZ9HIl4ep?=
 =?us-ascii?Q?lMZkopMbwWgzFhK3+ntzo0VoLelTr7TVGLYyA4g4YEp0YEOukyWUkvaC3jIx?=
 =?us-ascii?Q?QglAeFkD2QX0/RLpnK5r1IaeScAgC65UWOtyBP7b+evzK3gEhYE77tMUaqOM?=
 =?us-ascii?Q?auX5VBLRAnzbeNG7kLFxUdKCbmfEredBJNH2b3n03o9y9xbjVvZLdgM/7T2z?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7cc187-fb30-4dce-7623-08dddfce9790
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:47:35.7773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEGFpml0UFGC9L2JWBahYSyvHe83nnrE7bya8Dm8ffCJInAy/2pphmvlf3wIbUqTP2+1x+iOtXE4kZXKW9R1uoPCezEE+btDLdcOgPUJAs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
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

On Mon, Aug 18, 2025 at 10:59:12AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v3:
> * Fixed vector offload mask to excude QINQ
> * Use new extra features structure to define burst features
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


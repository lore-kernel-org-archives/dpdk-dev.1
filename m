Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A3D59D65
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 15:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 683C64028E;
	Fri, 12 Dec 2025 16:26:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6D5FD40268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 16:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765553195; x=1797089195;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QAOCXc4SlnRBt2yI/qS78VnwQC+HcQ+rlJfCVpHKNhc=;
 b=fiE+nrbgBvaJLg4W/6gFGAapMlkkaRNaHgs5xyxITv5qSX9Y8UmFljq8
 HiA3fr2oOKK0F25Hz3DMlmIWaJNJzZCzKdxw2iXQNt3SokPa9SwyLQLR8
 HiO30Gz5tjVRLFdVCpZF0f0/tmJTsceD36L3mJlN6fC4ByGP8TLOmkoz7
 Fxpy+FGjcnVmiEXs3nfs9n4+KQB7nSCPAK4VonMBYQ3VKy7ZRRuBQ34lN
 PM/0esLUy58HI3LoJQaIQLEYHioyk3vvtB7e13rmMI4c1yrcfdH3dJQni
 2/MqpLee33tkMR4TONkvFuCa2T/w8s3PICMDg2k1Kz9KHekqrKs3oD2Ka w==;
X-CSE-ConnectionGUID: 7ULOHHrOT42CIX75dhNP/Q==
X-CSE-MsgGUID: dgn6o/4cRG2go/xsryg2rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="55122439"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="55122439"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 07:26:34 -0800
X-CSE-ConnectionGUID: NhPR1bB/QpKt4bx7N1fZXA==
X-CSE-MsgGUID: J1fpoRXFRiiwcGB8UVA/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="201291924"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 07:26:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 07:26:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 07:26:33 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 07:26:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdGK2t2IM7HsPHM+7Y+umlZMJH3JDju8kH017/dC+w/GDmVF22kCgSTzKA5/09Di42T+aK9tOjzTXi7JWSH+RQd4cqpuIHLPuZFgHtIbAjIfqxPvROwjOd/rb0BnbuCXBrWdkFnpqc4++6FKC/UE1kLiLJYeFeZXaR8DwPcIDRxu0UmTlWxkES0W8ypOfCopPe3vJiXDsQABzy6PRxmfFGm47aAqV0VVbGmSp58F6TXedcmXopZ6hhM2EDpnK0Qq6J2SL1FSPQgGoBtN6A6PqNtbBkAJfHiiw8t/js9nY6MPJvqpoQEg1JDpV/Eiyt5333LHfZ/Rd5ZTOgWMlU2KLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDLhfPT43ZgN9rx8nKqGa792d7wiLy21UXKne90Fw9w=;
 b=RRd4IEsC1MMXsDlaqRiUzhjxyCyeOqWCvrxzzP1zxrqgYcxSUrUfhq7J7yyQyPoKOSeY5Qe5fhBWnRCfZQt3tUbqhL1nqYh79P8j81k/uQeCv4//U20SWf+fZoAd4LmmAaSjKmBapkjI1hAHYG/9rKlSVXTHq1Kfb7UG152Z1RQZRj3Mm157kz8iDWsGIjQzA40F3nw74mbDs3pdODUI/C1Vr61251GTN6qrCP/WCKKy10USOK3e3l0n6Q7hiW83ntqEGHbukOXuDpmWfJmk0SUqrvZNFHXjE4Ii1kxJnyLLFZe97GHbws9mGTdlQ5XAXiAoINTDMWnwbW8fIYi2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7076.namprd11.prod.outlook.com (2603:10b6:510:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 15:26:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 15:26:30 +0000
Date: Fri, 12 Dec 2025 15:26:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 05/10] net/idpf: use common Tx path selection
 infrastructure
Message-ID: <aTw0IS3eOx8hDTy1@bricha3-mobl1.ger.corp.intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
 <20251212110628.1634703-6-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251212110628.1634703-6-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: ec20d9f0-9876-4672-4aff-08de3992d363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ieqAZE+Ro10SM0enfjvvMQvxE/TKx8xdqRW6hODzx8gL5X6cg0pnSYrQux7X?=
 =?us-ascii?Q?VVcJU+BskBpd2qy81m2CwpVPhguHAdogvvqkcYVQ2XmwF5w5ZjC9Ume+EcUe?=
 =?us-ascii?Q?El5de15WJBKziCl5P4C+7DjCHsSxxIj7i05u2cbTBzVOMrmmXAZzvYBEM8pR?=
 =?us-ascii?Q?CjGuIRpM3QqejsrDyfUX8wrymzEq5otUb9ZFCSqw5cZQu0qKgA21CiVUZHQv?=
 =?us-ascii?Q?pE1GZ0kDOCz6OvPa39kxuz6jDAMB6tR42/k+cXXsbch/S9bbYUQmwLRGYPqd?=
 =?us-ascii?Q?DEBNBRjpMgMYTgKh9Zyxo1GRCLQagMOoX2px9Nh//3ScRWDqg022ak3YaXnk?=
 =?us-ascii?Q?uSoJ25E7ltYTHuakAznjmTkaKS3qsbylf6KEjS05ROMlKkP4oHhIkEiuaDaM?=
 =?us-ascii?Q?4zARWaBLRQf28A5u05RTEMeAIchmhnc0llmx83GNuvTpK2hbivAD1B+t2PWN?=
 =?us-ascii?Q?OtN2IR7HtbFyfOMYWg1fzL3Kkwo64X7ylmu5QZXdaMY+uoHuRvubJWb5u5q1?=
 =?us-ascii?Q?1zw1SBPMPAFa7JsjD/NDLjJyI4A7EGzD9w92xiuQLrN1mdPN18yOcF53LljH?=
 =?us-ascii?Q?8VCztPEYqEat2sepbz/rcSO/gC4tf939XMocTo0D/TS4QN68VprXAnj4Zab8?=
 =?us-ascii?Q?AWnX+HRh1/9kuhaLfYOAETKMw5TBMTaJYbXYXOp59eLgpWVEdD0neUC50G9k?=
 =?us-ascii?Q?XD2dz4VM5nR/+0qn7rbME6DfCMGFqO8e38bpp2qQRAMiZbvqVknGU8a9CEKG?=
 =?us-ascii?Q?gwzK3grQ3u1/7z0hgbo8uRdMHszea+Ge/0VRmTFth0EWr6RnGS2gzNUXJPoE?=
 =?us-ascii?Q?82F8w2Kk3BuaE4i1Nvb1fOZD2AhbxnDnfjblch+TrTf8VvxIK74M5qlJIRZr?=
 =?us-ascii?Q?o6rWHJgNJuj6NFR3+BU1iGC5mpCSK/5yu+L1cz8CVpv6LvP1LB6jmVLzHq/Q?=
 =?us-ascii?Q?m8FidTvXYhZCxbm5a4C25NT4cHWliAMSVDYVoun/aHd4lBUoz3/9ZMPp9p1d?=
 =?us-ascii?Q?h7bsnX7n2kKEFoSfVjvKgfwSFqw4KOEMv8OeEFZe95Zr3ckGLF6LlIdONQtV?=
 =?us-ascii?Q?TKJm72wjZ58r7z9TENzeeHqZZ9qkW6/i5cLpfbmIPmvpiQ+WtgghCEcKL9Fo?=
 =?us-ascii?Q?Vx2awCxbdeQJ92IafrA0AwEVGzd2o1lVvkWVrMnZX/Fa0MvBzgmd+8BCAySl?=
 =?us-ascii?Q?q679ubELf4F6jqkmnjA2WXpEXwoQLYN972zVT/Gm+xJsXqwy8qtLy05Zc0kR?=
 =?us-ascii?Q?ifIqkXf17PfLtPEVgJhztbGuike4ts/iFumZVTXFk6TE3wXjmDlzvJg/VOMY?=
 =?us-ascii?Q?K4E+1UBotXVr0btZGobvLX4vUzChMF43fFPd7DGpdOjR/x+luv/MIpnaI2bs?=
 =?us-ascii?Q?JWkxpjO2FeziY8ipdNGodjHUaKVZ3wZJl08y2Wj5pOJNFkl1A8PESfFmJK2w?=
 =?us-ascii?Q?7TT1BxDZSPi0mys/t5goRJphzVrHfxd0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfILYwfcYpFloaH/wXtkNTPeUF5IOvNWreUr+/J/bM6xdYNITEPF029nLIyx?=
 =?us-ascii?Q?TdQUvo+P72jgIEeGvlyrecVvhF61bX9/vL2dRY1TcGHVjPTujiuIm5C+ktql?=
 =?us-ascii?Q?gwlfTCildEWReqf0nl7rw8GWlY7jmsFgBU6n3LChzofljJcMtPSIFIEl/47g?=
 =?us-ascii?Q?yM6PD20JI59BOJyI3Tv8nZYJD+ig3kBLLqGOoQQ6FthtgINfqSRY5KR6+nUE?=
 =?us-ascii?Q?vn1fn3kHJW7LBI/X8Tbc+4h2hkKAbVlCThgOGVPcl8lYroNX2mdCxgBR8WPK?=
 =?us-ascii?Q?t6nIkQ515PCJEjWmGm9MQ7003tv8LQjVVEnEE8V5PWSEXEMcq77nYmkOofSb?=
 =?us-ascii?Q?5bJHggaVkwxEJGXbI32lj8+/0DYD1QPGq21DcbVWY486bN/Zmj0vfPYOcBAv?=
 =?us-ascii?Q?v6iMtvcLOdAlNltCdsE+CQkDb0b+xaaE50MKU6i3nywDpoEjRSWadSs7IOCe?=
 =?us-ascii?Q?oWcPtl5b6iegiOyWHzMj3lu2Qps9q+kNuEYRG16ozEhy9hycdybqyOGk3XAk?=
 =?us-ascii?Q?vYQYVwtwsqd4XRZXGLpfn5TZtGfvVTLY4hRYc//Yp1ACMcsFDhvleJcz8wIQ?=
 =?us-ascii?Q?cR8fCyslFP9hgw2sKPFuRGII/bVDbxCivTnR3FNomQq5ibCaizf33ubfMMl+?=
 =?us-ascii?Q?PJFnDV99bKrPeK6Rb8PHjMoaCVXhterVAWTjZux3mIWOC9o1ele9ltfoN9nR?=
 =?us-ascii?Q?3BFsTA3quA9Q9ziU4DEHsksf3ftRqQj42hnPqbUq6WLAvhW9Df18tVsyeigT?=
 =?us-ascii?Q?78AP2xUhVZXXJvjvD5st0KCIu6INE4nXWBa4JVQPbkxKRaBOdMG7Qph2988j?=
 =?us-ascii?Q?jlSzoWdiIArmax3Zj7K8FcBEWNGY3hUEKcf4hSzmTMRvaK79sfUatXTUoyGg?=
 =?us-ascii?Q?lnilnamEWxE0cOhdNNjnNSyNmV4+kF5dKQ4aWFRNOzazyua91rHTEs6/p6WM?=
 =?us-ascii?Q?W+rLUPGOEiyQS8b+YBbfjD3rLUM6lBSidpOEU3ylm5vxAwamzbL1cLtUhF1K?=
 =?us-ascii?Q?EPrVZBsEiUAlsSFGp9Xokn4f3RktbfpbXQXnP5r66G/CYR8PGC7Rj3EjEASs?=
 =?us-ascii?Q?mMZMOU5TEI8C/ULrje+Ceh+D58tvdS5e60A4e8+Ps63sXzv2LPEBCoT71UBs?=
 =?us-ascii?Q?0jK2RgTR9hMshKIIiwPYLRKEAfyrEATV/5Exd09J0FYn3nQheB/pSbtrSBEj?=
 =?us-ascii?Q?He7HC/CwlNGrX0jDQbMviodZ/k72aJHeNT3RTJ1S4oyvEcSOD/x9DoHNkULy?=
 =?us-ascii?Q?+HvPZrJHN5Egyeofdz/h5MD3Hn8l9JNtzyu547t1KUdZmZxT+A+lsMCf1bg0?=
 =?us-ascii?Q?vr3kaYpu0xHDRbNqrvE36xdImrkLD2UYItoOQkZYhHDUSr3mQbf1ydR9wSBW?=
 =?us-ascii?Q?qqwE/ASAqlDwQZNEEowDsNMlia+n8G6FluRe9lf3SAyKd2sf/NhiDZAUYBcw?=
 =?us-ascii?Q?UYyQdLLGkJDfuveCwW2lAsdX3kdcKBY3aEf6ZXNJGYFVY+sZg77XElR0cEaO?=
 =?us-ascii?Q?yBSUmasSasF8eDsRQ8quwiaQTNx2/+soLVV4WhXWlDveEnyuFhI/k8iKoPvt?=
 =?us-ascii?Q?uzzWFUaGnS/QYtUirUN+Wxivpm/7mx1l+C0dKxnXWs6G5TzMIKpknr6Q1DZA?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec20d9f0-9876-4672-4aff-08de3992d363
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 15:26:30.9126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97umvMgtkE5OPkPBEgpOvW3egzYTYO6WpD5LlWw72GA2z23U9/ybQzaEYSdJXxw0aPeZoD7ggjhcxcUdG1DpcbIHZxrG1cHNYfZA0FncIUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7076
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

On Fri, Dec 12, 2025 at 11:06:23AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function. Let the primary process select the Tx path to be used by all
> processes using the given device.
> 
> Introduce a new feature "single queue" to the common infrastructure
> which represents whether single or split queue mode is used in the given
> path.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
> v2:
> * removed unnecessary tx_vec_allowed
> ---
>  drivers/net/intel/common/tx.h                 |   5 +
>  drivers/net/intel/idpf/idpf_common_device.h   |  10 ++
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  49 ++++++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 ++
>  drivers/net/intel/idpf/idpf_rxtx.c            | 118 ++++++------------
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  10 --
>  6 files changed, 112 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 60b1bd642a..24fcfbe225 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -124,6 +124,7 @@ struct ci_tx_path_features {
>  	bool simple_tx;
>  	bool ctx_desc;
>  	bool disabled;
> +	bool single_queue;
>  };
>  
>  struct ci_tx_path_info {
> @@ -318,6 +319,10 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
>  		if (!path_features->ctx_desc && req_features->ctx_desc)
>  			continue;
>  
> +		/* If requested, ensure the path supports single queue TX. */
> +		if (path_features->single_queue != req_features->single_queue)
> +			continue;
> +
>  		/* Ensure the path supports the requested TX offloads. */
>  		if ((path_features->tx_offloads & req_features->tx_offloads) !=
>  				req_features->tx_offloads)
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index c32dcfbb12..eff04a83eb 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -75,6 +75,15 @@ enum idpf_rx_func_type {
>  	IDPF_RX_MAX
>  };
>  
> +enum idpf_tx_func_type {
> +	IDPF_TX_DEFAULT,
> +	IDPF_TX_SINGLEQ,
> +	IDPF_TX_SINGLEQ_AVX2,
> +	IDPF_TX_AVX512,
> +	IDPF_TX_SINGLEQ_AVX512,
> +	IDPF_TX_MAX

Following up offline with Ciara about the need for this MAX value - it's
necessary due to the fact that the function type array needs to be shared
with the cpfl driver, but array definition itself is in an idpf C file, so
cpfl cannot use RTE_DIM to find the size.
Will add a comment to explain this a little, on apply.

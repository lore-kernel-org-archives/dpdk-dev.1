Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F56CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 16:52:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CD5A4278F;
	Thu,  4 Sep 2025 18:52:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D9FF040275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 18:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757004757; x=1788540757;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JAbHvQYHdZYgb4d2Vbmarbtx9COcxHeSQSm2f9DUd+s=;
 b=HzZiM8y66UflcQzJgCCSqYHeUuzzGeO7Qv0xwnjYBi0AMfG5/HbJSOFo
 vSzZUS4t5gKKFLFvnytlSo2p2KmchaxS5NOa8bcJR6397UushrLf7Tbta
 KZuVxb6HREba4OPCjXmpYmGLVHcgqUlqQEjBZZImSTldraCXTmu24+3l/
 +WW1CwjzpQbw72zPQ4rqVin7BUH4+t4xK1H6jCOA+4OeSY5BIdfTqUAto
 A8hU6W7RBGzTFb+Yw30M3HxnD6G1QV+JqrFfFpFdPVv2XPgzXw3C7r4ei
 /arhBV3Jh6Bw2Z5UZ5q+NKAFZ5eYnyhj0vG+Q6FhFQoCMXf2yrga6WJE7 Q==;
X-CSE-ConnectionGUID: NCi2Ni4aRdS7q01dIL7NFw==
X-CSE-MsgGUID: Yj0HiYf1QgWnVXGfRe9QQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59461611"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59461611"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:52:36 -0700
X-CSE-ConnectionGUID: rwgo6geTSpqh5e90jCJc2A==
X-CSE-MsgGUID: F0BgJyLwQK+XsUXYpelMSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="195600117"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:52:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:52:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:52:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldilWE4R+Rx+7DnEVgFmXYCHhWWenoTSU592tom5oPp1HO8LKTaotwRwEaiFh/I4TsNJvV1SLTPw9KyoRwfOeXGJTmLcvpeSYUY6oCfK49h8A/u3YrpL1m3UyEim7VxI6gXHBMXHntFaEmfhOpmIteb+Uomr5IYSUKKeqQKuq86vtQaXFIsuJBjXXwbd6UYogk/IjdChKQgDR7V2xgVXbq7PInUJfO/h2w0PZ5cilg201/VPDEfd6gy9vRPQMA8JDjY/7tXSVQPxnp9uv3Q77PnWZuOjbeRMCHuXByTfeB0OFu0HcVkTT+fwY4ho0/7eiiw1gt6A3abtj1+NO95D/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTPpmWqlWyNzA+k8ssZ/KANCD3P2o2QM3pWfMgYEg60=;
 b=rgvHgDO9I19M4FFKEtdm5gk+4U2ikMi/ErYqIeAoWGBwu+ohtAGGokvOYKWvIgQrkp/dIaMrdrKBRY7QN5+CmelD8beQ3MSMwSkBUDx0LQ0zxMzqJVurnyNLJxZ1zvOK7IlSfircfcthEKFG74Oo1+s81kr+/xuYQWSjSboLGomspC3FoL4FQGEH7ydzm8ECOshgxjjj/t7k199dXU+eP3vVU8/CDEHPb2FqGCkN2BNHzPGV6gMuUyZqOval0sacNYrHynbjiwPxIO08EuMSI+bJuQEMIkhgrimzWWIMpothfPvxBGnk0/FTFwwixDUZnmkTdMvbnXiYogj1euBl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 16:52:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 16:52:32 +0000
Date: Thu, 4 Sep 2025 17:52:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 4/4] net/iavf: remove duplicate in scalar offload list
Message-ID: <aLnDzF9VsjUNRmze@bricha3-mobl1.ger.corp.intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
 <20250902104859.2100141-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902104859.2100141-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: f4227322-3623-4980-ca19-08ddebd3712b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HTPTzXLbZIdSC9SXD4duanaOOLxwYdMBWAbQkmaWJ2kexOPxy/yCrqrlRpbK?=
 =?us-ascii?Q?H8dUQkIqS6HuOsO5K4ArMqSLXTPiNEeB/wqv2OWH87xXF5A9Hx8u3QEEuu2t?=
 =?us-ascii?Q?tjcpeGa64bADPs5G9T24EMiQzZU9z11S0/CnXjg8vrcA1xbgylVQaK2DH9hI?=
 =?us-ascii?Q?czLJFydgtUygEHWye/+HIWVIgt/fBM9s00EHt4AfyAR8JGcW/bQzCudP/sCZ?=
 =?us-ascii?Q?88QHQHDuWKWlZiNClxSOgtEtr1eVmeft7svpYjsrdaNq0SDu7xfvsaIXUCGA?=
 =?us-ascii?Q?Bkmcu1IhVo6y2sU/mO8tzKpc3Z5StXFhxdLZ5zTh3w79rSd3q+qzzRxrX9aA?=
 =?us-ascii?Q?Zn+APCYPtfHJeStvwFHGVeK30GD92AxCuohI749sr5tptNkglg3/Cg5rVzr1?=
 =?us-ascii?Q?C6g67MbVi90+zG50WDf38S96KHeWYQH2dl7n6QQGGXx5zyIdBkepeZknSmja?=
 =?us-ascii?Q?bVn69Fmiyh7HK658pJsmLLqtZT69wd5zgB43kDPYqNeB0Uw502eds3MqZ3o8?=
 =?us-ascii?Q?ilPeFy76Z5Z4BcWXUmECm9k22TO5lafFxc2uml6OkNCZhxWvktdnDTXdYye7?=
 =?us-ascii?Q?ncCPWWodhOQyk0NesOjPVr87vvcC3G0mzHrG35EbaF0bwOyOujK5QVPeoV/t?=
 =?us-ascii?Q?k8QmgWbXRNsYGj1m1u9DlAcDDud/FsBgBDcmcFNYTFgo11mOkDEb9Z1PSeCf?=
 =?us-ascii?Q?OzjT5n9cAVgvDWCM+wFNNGvEoi6PXcyLwXmY25M35sR2yxVtgY8/HxrnXhTn?=
 =?us-ascii?Q?XPobim1d/Cc0dd7psKqa6zfme/pVGxZkMuim6xPafPTvDbBq3tzAh1oLGfjJ?=
 =?us-ascii?Q?yU09qkBQn63H1xSgi0OeSNQ0ZywDRR9tRglzGi1r0+5GIuOiI0FPBxjYQ2wW?=
 =?us-ascii?Q?z07M8Gsvka6EPt8z+iN/ZgGOpw50CcX7x2x3HqxNxxJHzuC0mxJIi3nCMI7F?=
 =?us-ascii?Q?tKdouhaKLWU/amXQLPftJK3Yf+rvX9ZE5QML0hZriZ2B5PIeHAcLWOzDinRv?=
 =?us-ascii?Q?8s9dy3mXFSbc+v9QvFTbQDjUc+eTWh1mQt3dc05f0CdctCnZDnvk0y7AbFOC?=
 =?us-ascii?Q?G8cJBNPNIhemU74nbCazk3PhqNaHNLWKnPlSfTC346NEfo62jyyR9gWpvPXo?=
 =?us-ascii?Q?rx9W9P4HtMY1YlKsviCxTufM7t2+5WQ9wTzoCVfTtbxr7C4478xBxYZ4ws5n?=
 =?us-ascii?Q?FkZfylzffiVX6NG1plIx5IYi/Fx7Pq4eTHl36ZSULPODIvxyX4o8U1bl6a8i?=
 =?us-ascii?Q?L2r6QbtO0JeItnbTXxlRzqx1YBxXIRLK+RmQiEKEb4Z9/qmJaL73maJhx8ob?=
 =?us-ascii?Q?njQWiPISNhqtxVaxT4zbcrvRX+Nj2LoSHVte9lez5Zmn/yTGKfdmAlMGZueG?=
 =?us-ascii?Q?twKEugRWO0AQxriQCpTf60GZsn4B5f/+1fOwJE25/GNNFesnmDx8IAgEw6WT?=
 =?us-ascii?Q?v1Z54UgtXgc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6N1TlJC9Grz1hyCVZTczWe/B46eNrgAK7ORTsrydoHso+tBu/jXe465+IVHB?=
 =?us-ascii?Q?CFYv/csaoeJSHfvn0mJIw50/6FORYvkhY3M+QOSF9XZboyCguoIx0Gwi8yqT?=
 =?us-ascii?Q?0FFp1XY+ZzYNRP9xRUXmw2x4swn7ia3BnalbS8bkvDxvNtFUD678w/jq0YYZ?=
 =?us-ascii?Q?hb/M77VRZnatFZQGjpF6pfqpoyqWbhsUV3AU3RflY7xfC+ISqSeWOhcIlxIp?=
 =?us-ascii?Q?RxWDFNBicF83+xTBAETjtjtLSSY8pnOswn5pOTD7viXafXzbP+2zE88NIpqq?=
 =?us-ascii?Q?DUOm+hvl65MUi1amPI2ubB2Z29IXqkFdyqxIPLkx/0F3yAzoP/VDiQnq1aHY?=
 =?us-ascii?Q?Q8U/5gOkUYVBfdFvbvsoslvNJbcrsvflovpkWZ3EbEKZSLsQZBV/O0oIolfS?=
 =?us-ascii?Q?TBTq0mAaaHmyWjtZgnPX7dE2ufN1tY+1IgD+qLp2T3fycWRWBM1hWpZz8vD/?=
 =?us-ascii?Q?rgjWhVuk2c8u/+HelF0Qyy4egEqzNdtrZtePCAFR4BjGld8FYY296GDD07m7?=
 =?us-ascii?Q?/VKs1rxr74ZGoZo+jCwr4Sb5SIqNq4XEYsUlCY93VmxurQL4yNXdEg414lMd?=
 =?us-ascii?Q?+uXB6BR80+hK5guFFdCNav05QHMsz3jnRySCOFKZ4aPYQhrqZiq2kePlmfYF?=
 =?us-ascii?Q?trB1KnQRjl0J550fatK1ZhsgnAO/Ozn4vYpg7lr2VxuXYGLuGH4q0ZV1TmDJ?=
 =?us-ascii?Q?YZ7Pi1bMQiYGFH0FtGbsmTfxIM90EiyTTMVncJMDTFNCVAHkg05eKXL9vGeH?=
 =?us-ascii?Q?QWltNQHiy2gpCvnFNVpgT1C7PybI+rmtZ5ykLTt9redvYYGfbsaxkzV5l7F/?=
 =?us-ascii?Q?nypgY7wgbarO2+TEyYkVBw90XzMSND904zFcp31XZSQ0iQnGdvNe0mdlT6qM?=
 =?us-ascii?Q?TKBtgFpnG2UM8RSptwENPcTANq+8pfQOvIpZ5/hVZytWu09pkPpnLTYHqK8X?=
 =?us-ascii?Q?0VfrgsOXUEtd/hY/BOiZXOaa0kUi0CjleM4YoZJEi05WA5XX2o++c+wuuFul?=
 =?us-ascii?Q?VHFyyrX0EdI5Y2BVox8Hngcgf0+3O8VB4Lwf7Evokq38zvcxn3Gi1AfKh1Cr?=
 =?us-ascii?Q?DWHLVMVqfDvwu/AaUFfrt/1C0+z9R4PQe/7TKrayu9xjz7CMyEx2t5sBLBey?=
 =?us-ascii?Q?7OLvWRkiAi19mgBASj7wOVYbDUOQ/OHVTzsHuBLMDZHC3XYWWMj/spFvflKD?=
 =?us-ascii?Q?wMJTPGndT8m35+8WPudNepx3nRkV8vP4wp+0axrWcymTK5Dp3JKZsNamrqoR?=
 =?us-ascii?Q?lrGzFcN6QX43HFyaaXKDHjHs/avhwPWQhCNwS10cKKQa7EhzSGslMrGNFnJg?=
 =?us-ascii?Q?w5HiiK8lhMaJ6zr9QQ0I+1igJsbRv30E9PpBiTNqXLXM+KFnC8vf8MSNC9B0?=
 =?us-ascii?Q?GfsQjzBc6k6zPzlgQa0YIInDPoDLHL6kqwRF1/564heIVCH6/70hDHpFF1n6?=
 =?us-ascii?Q?54w+yvHSA5bCaRker4rIVV3yTtUxATP9+yMJslgBzbd9q1jXsnjwiULO+aSC?=
 =?us-ascii?Q?jOPp84FKmOdPsNwm54GL4zKvs538eniLHPakJ/Rpu87wxcNMC29uEnbfdBPv?=
 =?us-ascii?Q?FJcYJjKiPQJKMCZqOhXsJZOcD3B5D7P7u9l+TZlo2sdZoGw3RiQYCHmN8c16?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4227322-3623-4980-ca19-08ddebd3712b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:52:32.7902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLlmM+x6THMEm5D3vQbOUMyMBAvy+eNvfGLC0c0godkeYkwFKuy8V7y/CJSve2meEueS+ih+oft/ziTPwNPeXW5aQRDEvBxJG2tKx+BwyUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
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

On Tue, Sep 02, 2025 at 10:48:59AM +0000, Ciara Loftus wrote:
> The scatter offload was listed twice as a supported offload for the Rx
> scalar path. Remove it.
> 
> Fixes: cd9889d90b84 ("net/iavf: use the common Rx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Will squash into commit on next-net-intel

>  drivers/net/intel/iavf/iavf_rxtx.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
> index 723c30d05b..10812533c2 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx.h
> @@ -68,7 +68,6 @@
>  		RTE_ETH_RX_OFFLOAD_SCATTER |		\
>  		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
>  		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
> -		RTE_ETH_RX_OFFLOAD_SCATTER |		\
>  		RTE_ETH_RX_OFFLOAD_RSS_HASH |		\
>  		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |	\
>  		RTE_ETH_RX_OFFLOAD_KEEP_CRC)
> -- 
> 2.34.1
> 

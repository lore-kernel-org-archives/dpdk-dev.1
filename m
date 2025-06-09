Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B33C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:29:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA9940661;
	Mon,  9 Jun 2025 12:29:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id B131340658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464980; x=1781000980;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YdtEeEd3tFgpKFNqZSTJRKLc7N+kDdYvzLaIZGyFU2o=;
 b=E3blh/o2WK0fD160ShAGAaA3lewKBPhtj9+OCpz5sMyqcHS+OziC+dvR
 H3n5LKHyRShQHevt40sQpsi7Mlwnht7Q6+ZsRH0/ODUN9YEcZjGmAsWs/
 ysM3N/HUSMcSElYoqD/MzojUcEZbP/9b4P9z5YP3kTCKsrpzWfvWnHO8t
 PghGUmxcn2PBH8Ed5waDGSeBUtISS9uLi+ibmEXBvJNWoLXDS8f1pcZuN
 b8qWur9od1STUxBriPD93kjcHTpXmi/vuAhLqD9e4QWZZt8YP4pGI8Epc
 KJDs/S/t4JwxboWQSpX4lvJG7O4yisz6l7J3wC6Bv+OkSgPVD7IsWIu4T w==;
X-CSE-ConnectionGUID: TLWnD+FeTzu4agydW+SQmw==
X-CSE-MsgGUID: EGQK/uelS2WdMWPWXCgCpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51395614"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51395614"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:29:39 -0700
X-CSE-ConnectionGUID: 4L7vXt1sTW2U6h3N2dGpAw==
X-CSE-MsgGUID: 0N19Hh9eT6a0GrpAhNfffw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146996876"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:29:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:29:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:29:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJmpYwZD6s2CKw7kzXVId699BMzwCjcEot+EJjFoDWdmwpjnho6gQyURF43D+eH9I4DMBmyWmbxKLgleQ1WYM5bpAEQ29KIYjGfgBQJNsSFxCLOlEQ752O512YCOTWp4Blus0LvnO5KLQnNwmyrM1aEVBIjecqH4mkoag+0axq+WzHRydzM8lvKWTLQukD00DrUTwhY1Drans6pVWmIP3zwt7SbXxtG3AeQDCBxwT85G4kJ59j01CpXQDf9THVFaLVoxxU3IeqLKKdLvtZIkpZhlGS7kwka4s0W/VvTKl1i20yRrY+V6KLSHZdWTjrlT0PNt2742vlETPqpjQSymjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFVAFs9sBgPIK5oqQ3pb/yOxRk+iCzeBr8sz3tC4VQ4=;
 b=ZCvvnINVA4hzG8zqjd7S1lislBOA3pMgskhvboRKlAeYwboysXPOuAqkYZ2pV5zvbqn3bowkTJX80i39SHvMMCX8ObRU449UsQrFTUUkPdNHebJEB2255FWB0CbzGjbNbw2zv7NQRbBPd70FvIEpnX6olR7r4CRHvIdPxiZpUcSdVyM49jMHDALgkE55mkqYIHfDXlJ/MsZMV7I7PySfC5/tKEmbi9Uv1E2O8Rr0QckrKfr09RtWilZeGruuXGBDEyaZcqrGF1nNcxBV5/HkGxL7lv84+rlLCRd0D3O6edFHy71stpTL7X6OIaDjfrqU8KvMhF4hB7VV5wMXjMGwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 10:29:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:29:35 +0000
Date: Mon, 9 Jun 2025 11:29:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 11/34] net/ixgbe: remove unnecessary platform checks
Message-ID: <aEa3ipQhyAGNQXqE@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <a58a51b8b3d0393af942f256f95fbb5908d1b872.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a58a51b8b3d0393af942f256f95fbb5908d1b872.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB3PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:8::14)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6df1c6-ff3c-4931-8bac-08dda74087d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BD6SsI5EAJumiEbqPQvNkptzOPpPuVssh6BOMBKArMif5YkHyGzOmSgFTNKf?=
 =?us-ascii?Q?bEjHuvjoXYLWA8EcXKDNp3PY/Gyxota/eckQUtxlbnDY/cN/N8OxJHZT3c2/?=
 =?us-ascii?Q?U/i4bnrO2Aqu4hYu0TBDKPmHw8WL3ZPKn7PTK9TbZHsdAafnE8Q5pC9xrLnW?=
 =?us-ascii?Q?sIjBsIFr3QCYo2VQRfqUP69e0y1MtASmXkfnWpaTA9XVvWyUcY2YbAGceQLK?=
 =?us-ascii?Q?IDMuRI7bT0ySJWvgFTHxZAa0LMzlE4+UkQzwGgCgJYnqA2WMF6J5oXalcgVI?=
 =?us-ascii?Q?saMQmSkWCDF0ERIS+wom+0aZTQHfPaiAIptu8hQ8/MvjwvatY1wSilF+uplO?=
 =?us-ascii?Q?dd6kScSSSFTqLSz/XT3Ivla1if6Pvb77CLwCMk2CLt2qy9hnR6GfI10g6BVo?=
 =?us-ascii?Q?gS5QhIfdFeVLNj4IEwTXtWNYvXh1EMkowfkZn/FWKGxFeC03DtuN0Z41Dacg?=
 =?us-ascii?Q?1cBNsq7yG8Ivaz+3s0EKQYVKwjtf4NCCn1FBJWnxknG0EXaClTZOCIpitOUq?=
 =?us-ascii?Q?YDDt3CfhjHawlsBmE88eakg5Z08Zd5XNxGJrbKDxISEZdTSTKErMddZTIY6U?=
 =?us-ascii?Q?DCkT3Nuh72FD1t5dkAzygk/0Nc/ncdhwpynpfR+6w7l1v1HiGcG81fcLd7eI?=
 =?us-ascii?Q?mLZ8EXyoMIV0RYqvyBYgK1PMOkyXj+BYR20oNuSjUwosLj1YqB32TmZifAm9?=
 =?us-ascii?Q?utQ7qadNrej2r5YDkrzc3K5rdEB/PEM6IH5WCt5Sq2LnJF75LugACHsTwS/g?=
 =?us-ascii?Q?cVsQmm1/TfR6HG7Aj3bGXVhikN1SBSN5+XqDepnYIJKqXQ1PVmuZhuz1WZZG?=
 =?us-ascii?Q?GOm0Uqd1t9aiosCL7qVcPThnnHr7TjxbxL1Sx6/PTs25cfAsSho/kv+wM3HN?=
 =?us-ascii?Q?3AAdChE4VZEmb6jNuazlDhRM4sqF0fANL8rSeFe82Fdf1f7DcmsWdDoQfqjL?=
 =?us-ascii?Q?F0D99fnn97IF4QDSBt4JWDeIAIgO70ht1kiHlZ/idr0xnLSDMUYnOdzfpkLW?=
 =?us-ascii?Q?VevQLNe8DmXPIjghQ24ryGKIlExgSusCWD/HoyHCyU0g9dYU2E12jg+gVLcM?=
 =?us-ascii?Q?IyCztjdpPX5vseoR4n9uWx/dxun/Svfw+7f/EQi0icmb3F4p9SdMSP7cWyaB?=
 =?us-ascii?Q?F1e0F3pG76ZufXw8lz0Sl8afhnsW4tirFbdmpfBLtd38UwRtGr4PkycVzge+?=
 =?us-ascii?Q?14jA2k+OQPzVt5bqZrakCE9GXSHR2ObClN5SNTMFTB1KAQe3UlVwlFlhRafW?=
 =?us-ascii?Q?FYTR1c6IAj7I3mAuPz3VGzDb8EtTD6NOHuOeVKiKDW9WLvmIhI81leZj/dDg?=
 =?us-ascii?Q?yOyngD4/AChk49YVxOn697c9POtz8BQ6YlilMQEdZgSeLwglsuVFZxhdP//U?=
 =?us-ascii?Q?wWcxc1ar5tH2uezlMQj0NufBwP75SCGfUt+DfbXrLAAI5AlSu96zjU0l2zJ0?=
 =?us-ascii?Q?6FXpsj82Nrk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xs2nrJWKkIW6eraWz8IFhNDjk1tQv735J5De0qAnWItZauQL2nfZNLha1YQF?=
 =?us-ascii?Q?ZWxsKVRXjFyb+C5cLfBFZjIjCcWJKC/GxXYoVG9UAtg6osxbch20+7sk4g19?=
 =?us-ascii?Q?tA8JIc3YzhjMI+NNvnlPJKxL+0CxbRUIAAheJWRCWrLNJx0/8wUrTBvqseaC?=
 =?us-ascii?Q?lPZVvFgC6rSc1yQ/u/5JfbsiN6WH0IBp6WwrA9bo4vPIjhssfEYdQS8mkdg6?=
 =?us-ascii?Q?x3Rsln2IR3cU0jrcmDJ4z3976iaiYwNILWDsBlHk/NkisEPuzM1vCnePPGvQ?=
 =?us-ascii?Q?rxxdLbX0GSzCGf2MKVFYUySMsYi/vfkqBCo1ZX4sUTQzkky+3yHxeMGs+p61?=
 =?us-ascii?Q?2583oZilFlLDNy72bbjQlMWoNQtcheHhO7LOh3VE5zKjb1Dz0NX22iI1MSat?=
 =?us-ascii?Q?4Wm0ntz/l/AtyVHHws6W04G/DB4vucstwY1xBVqyUNZKnyx00A7qNNCzoMe7?=
 =?us-ascii?Q?0ZDxQIv/hPv2yAA+lS3klekqEylCsisT7iDceIVu4SV6lxumyyIt5gpFVZaq?=
 =?us-ascii?Q?gHomOrBO43Yc0XZf4tpLjc1zvDI5Nt1ip3QYmylMih//pTa1EFHJKXNPdcwh?=
 =?us-ascii?Q?WmJ0pVPh0wIlultk1mKUCoAiuDru3SALUy+cmj+WlW62+ncxXAsloRMvD5yg?=
 =?us-ascii?Q?Lxyx062oXd8GgZMk4u1E2gYFclvZ2+eNSJZkCEeQ3K8Ao8oyKOf3SyHE48gf?=
 =?us-ascii?Q?WVOyha7IIoj80a/RPNR1PwvgLqIMDZreNsNFQX0EKxR3oRiMoobem15hCfDQ?=
 =?us-ascii?Q?tPIO9ue+DUm8+EA4HwVdBYILS7MbPqN/cz6K0QnIUCGbo7/zSKbe9y942ejQ?=
 =?us-ascii?Q?jdUZLWT+FUzG60ra8Y0AtzqAjqctToyzPzXWX4J+0piEBWCtZspnUzwsnyok?=
 =?us-ascii?Q?teyKF3FnW20sTiT1DmkBV0hWMyQNjcEzTNUntiHU0QFPyJrQHfQG6sfAZXv5?=
 =?us-ascii?Q?a5NFrIbDScU4ftH+D5Ym1wFUwYQBZEBojp5YhUSp12ueX72aTD2AcrelWHsa?=
 =?us-ascii?Q?TMmqGbPttSVGEPzBkINXyPS9kaKTs8JIo4PI4ar6hDhxAgHzoP7vzz0XWetR?=
 =?us-ascii?Q?Fsft0A/whVTg6PTG2DNmRGV+A04PzxzHnE7EXjSzgynWQUGTcLAyjXV6DYdC?=
 =?us-ascii?Q?j3vjz4fQikwS4nLq/gwxP4uqNBJa2+SJ9ilkGNQfyXTrg6zXPi0pvcCmjbts?=
 =?us-ascii?Q?cflJ+F3+glvHGjNO2nO8bfRdMf1Y9lIN31nxJaXdjSaSzg6GSm7LeVWMuxw2?=
 =?us-ascii?Q?ezaY8ih047Zl1dCjY6ODM8BvcLExIR1ttDqh9Psb6DdZZMqLsiafKHjlCWfu?=
 =?us-ascii?Q?f3QAVJ3k480PCQwBqHxgEJx2OielAz5jR2am6ezqrx5enAmtmG/kc+IScL8K?=
 =?us-ascii?Q?jnoMWecSvAkr9nug9ISE8UFOjCpM4DohULtaYyc3xkh7H/xfRyayaP1yHw5b?=
 =?us-ascii?Q?fo/dNltLdC6Xd7J7p++elM/zBV9Y/X95x/OCMp6BID9EonBylbFM2GB4MsuZ?=
 =?us-ascii?Q?iGOCIQIRnyehairAwCw4j/niA8+uA75R3nIG/661SpprJyQQnUL/R7V6aNXB?=
 =?us-ascii?Q?xpLBywpI5BwjtQbXbLtbzbn6rQppRefzgD5QxfA7nmp9H4A6Dwb4wo7GmWL+?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6df1c6-ff3c-4931-8bac-08dda74087d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:29:35.7729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+IWFZ9zametzVF6gew8u4pNgzH7rjEnxSICN/xi1lufx3P1bLEkyyyfxGigDbyHgeCx4vGs1juIkTmgEV6ZO22xfzeQpmuXkMOV1DYolMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
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

On Fri, Jun 06, 2025 at 06:08:50PM +0100, Anatoly Burakov wrote:
> Some of the things that are only used by vector drivers is guarded by
> platform define checks, but there is actually no real reason to have those
> checks, because this code won't run anyway. Remove all of the unnecessary
> platform checks, and provide function stubs where necessary to make
> compilation work.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One minor nit inline below.
> 
> Notes:
>     v5:
>     - Add this commit
> 
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c | 24 +++++++++++-------------
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h |  4 ----
>  2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index 8fbb795097..77d0555fae 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -2678,9 +2678,7 @@ ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
>  				(rte_eal_process_type() != RTE_PROC_PRIMARY ||
>  					ixgbe_txq_vec_setup(txq) == 0)) {
>  			PMD_INIT_LOG(DEBUG, "Vector tx enabled.");
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
>  			dev->recycle_tx_mbufs_reuse = ixgbe_recycle_tx_mbufs_reuse_vec;
> -#endif
>  			dev->tx_pkt_burst = ixgbe_xmit_pkts_vec;
>  		} else {
>  			dev->tx_pkt_burst = ixgbe_xmit_pkts_simple;
> @@ -3112,11 +3110,8 @@ ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue *rxq)
>  
>  	rxq->pkt_first_seg = NULL;
>  	rxq->pkt_last_seg = NULL;
> -
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
>  	rxq->rxrearm_start = 0;
>  	rxq->rxrearm_nb = 0;
> -#endif
>  }
>  
>  static int
> @@ -3408,11 +3403,9 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
>  	if (unlikely(offset >= rxq->nb_rx_desc))
>  		return -EINVAL;
>  
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
>  	if (rxq->vector_rx)
>  		nb_hold = rxq->rxrearm_nb;
>  	else
> -#endif
>  		nb_hold = rxq->nb_rx_hold;
>  	if (offset >= rxq->nb_rx_desc - nb_hold)
>  		return RTE_ETH_RX_DESC_UNAVAIL;
> @@ -5050,10 +5043,8 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
>  			PMD_INIT_LOG(DEBUG, "Using Vector Scattered Rx "
>  					    "callback (port=%d).",
>  				     dev->data->port_id);
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
>  			dev->recycle_rx_descriptors_refill =
>  				ixgbe_recycle_rx_descriptors_refill_vec;
> -#endif
>  			dev->rx_pkt_burst = ixgbe_recv_scattered_pkts_vec;
>  		} else if (adapter->rx_bulk_alloc_allowed) {
>  			PMD_INIT_LOG(DEBUG, "Using a Scattered with bulk "
> @@ -5082,9 +5073,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
>  				    "burst size no less than %d (port=%d).",
>  			     RTE_IXGBE_DESCS_PER_LOOP,
>  			     dev->data->port_id);
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
>  		dev->recycle_rx_descriptors_refill = ixgbe_recycle_rx_descriptors_refill_vec;
> -#endif
>  		dev->rx_pkt_burst = ixgbe_recv_pkts_vec;
>  	} else if (adapter->rx_bulk_alloc_allowed) {
>  		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions are "
> @@ -5872,10 +5861,8 @@ ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
>  	recycle_rxq_info->receive_tail = &rxq->rx_tail;
>  
>  	if (adapter->rx_vec_allowed) {
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
>  		recycle_rxq_info->refill_requirement = RTE_IXGBE_RXQ_REARM_THRESH;
>  		recycle_rxq_info->refill_head = &rxq->rxrearm_start;
> -#endif
>  	} else {
>  		recycle_rxq_info->refill_requirement = rxq->rx_free_thresh;
>  		recycle_rxq_info->refill_head = &rxq->rx_free_trigger;
> @@ -6251,6 +6238,17 @@ ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev __rte_unused *dev)
>  	return -1;
>  }
>  
> +void ixgbe_recycle_rx_descriptors_refill_vec(void __rte_unused * rx_queue,
> +		uint16_t __rte_unused nb_mbufs)
> +{
> +}

Nit: the "void" here, and "uint16_t" below should be on lines on their
own, to align with DPDK style guide.

> +
> +uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void __rte_unused * tx_queue,
> +	struct rte_eth_recycle_rxq_info __rte_unused * recycle_rxq_info)
> +{
> +	return 0;
> +}
> +
>  uint16_t
>  ixgbe_recv_pkts_vec(
>  	void __rte_unused *rx_queue,
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> index c86714804f..bcd5db87e8 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> @@ -35,10 +35,8 @@
>  
>  #define RTE_IXGBE_DESCS_PER_LOOP    4
>  
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
>  #define RTE_IXGBE_RXQ_REARM_THRESH      32
>  #define RTE_IXGBE_MAX_RX_BURST          RTE_IXGBE_RXQ_REARM_THRESH
> -#endif
>  
>  #define RX_RING_SZ ((IXGBE_MAX_RING_DESC + RTE_PMD_IXGBE_RX_MAX_BURST) * \
>  		    sizeof(union ixgbe_adv_rx_desc))
> @@ -102,10 +100,8 @@ struct ixgbe_rx_queue {
>  	uint8_t            using_ipsec;
>  	/**< indicates that IPsec RX feature is in use */
>  #endif
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
>  	uint16_t            rxrearm_nb;     /**< number of remaining to be re-armed */
>  	uint16_t            rxrearm_start;  /**< the idx we start the re-arming from */
> -#endif
>  	uint16_t            rx_free_thresh; /**< max free RX desc to hold. */
>  	uint16_t            queue_id; /**< RX queue index. */
>  	uint16_t            reg_idx;  /**< RX queue register index. */
> -- 
> 2.47.1
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402FECAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 09:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8441A40150;
	Tue, 30 Sep 2025 11:07:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6DE1A400D7;
 Tue, 30 Sep 2025 11:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759223247; x=1790759247;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2SNObAp0XdhafS8MSL34ZlshHyEg3WtzGhQzlxKApQA=;
 b=YvuhUpN9a4HIyN83GNT9wYpP7ggGmUfDDTk+9iYpxBu4Bg/9IMHwHaWz
 bDyc+9wrMjNh0fPBzEDbIJlj7K5bVvwKcA6H7pYiwm5AC+Tszm35VkAi9
 RI3qZjYbLB0YL1hJ+6IxwLsFEUHOeS1Q8s8OvGbp7/grvL4g0giN64VF1
 G1Jf7ltbk3uazEupXCHRYAJ7XI/LSDZuxH71/tQ0uHZeQLdlvKnrD0O06
 yd0i1Gpf7q75cCkBXCEDXX3Y6GMzFl0RVIMgepiqw/jaBfL2LU4uIgIXG
 /CuJQy/qT3JcuQ+LHT+RiWUoSfOmUoUXNB0eBb7qrjxfSJyNp85tKXhiD g==;
X-CSE-ConnectionGUID: 6Aj22MSCSH2aoLWMEVByfA==
X-CSE-MsgGUID: +cqRhJJvRzCD0ds4hS7VLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72093236"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="72093236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 02:07:26 -0700
X-CSE-ConnectionGUID: XdEYyBiXRFONNLEnL6hhYA==
X-CSE-MsgGUID: z32GQaDIRACoDHgrXs1wUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="178266508"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 02:07:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 02:07:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 02:07:24 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 02:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vthwQn55njYMhHUjKXM+mBhR3IFO0yUkT/T1QvzoVm2aN9RwWpXoIMUZZeENBEj/S0AMUMJROtTu3lFWe7ursaxzLyXOf2m30Rgn4d7yG2jz0SHrvJKskdqMx2z29SZax47yKKOIgGgNTX3oJvyjPh0APrDk6w2OxyM3vVHszg4WE/CZ4wv0253kowfe8PlHCpqznVtmNBLhWfh9sYhLBV9p6fQaJZsCEhVYJ0dnx3fWFe1iDZODOD12W7ngxcUu8ahjFXOkMzwBGwYs7TYMRT3eGSvP8FaFrqKPqU0d4+xdjMgVpAZGSdYikyNEbpmvd0Yx0KftfLbeuwqfn0xxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWstTOdWggy4POnnhHewRF77YbrhBYSsWNALgkUbCRs=;
 b=DXhWVkGQfxumt/ygO1J5W/y9dC0S2PH8OblwoKUS3Wqs1Qo77xQDMzgHIdkAxVvUHQw41tFPjJr94/29cEeTgb+X6Aiz3T1WRy1uj6A27Olss8tx8Uak/xVcm27vK6OHmptNP4Z9c4joy1ToTNUjq6Z3zKVSZpuMMIMdDIWUvYpx8Rudkeb62lWf/nkkhsEjuyfk6/eZHkS/8GPTKABeiZIS+CyqU/mhsBaS2S7Dwtz5MbRdoGWEOeY2PRBvkQ8wL4JGOLt3msb5YcMutK90EBbs6JeRAe3Mj0xpPhCUHcI/m4/9dj5GvUGhdpciQUrnyYK2l6vLoQZocN4rzhZ2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7987.namprd11.prod.outlook.com (2603:10b6:510:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:07:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 09:07:17 +0000
Date: Tue, 30 Sep 2025 10:07:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, Timothy Miskell <timothy.miskell@intel.com>,
 <techboard@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: support VF initiated resets
Message-ID: <aNudwFx7CPH3vWot@bricha3-mobl1.ger.corp.intel.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929143039.547207-1-ciara.loftus@intel.com>
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 227b356b-0a04-496e-0910-08de0000c0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eqRe8kWHi463ZtrdoCnOajEw3Oh+BxSKpOBiQAvTHJhF+n3CvnAeA69dCtHj?=
 =?us-ascii?Q?fGAWK7TAC8VusxyOiZ4z9lh7bGEcenbGyC1DMGiANT+FJA6YioV71SG0lbvd?=
 =?us-ascii?Q?L1dbugf6kKpgIccY036AkQGwycJOu4AD7xa39BVvey+HFwS7S4NpDxbCEg9h?=
 =?us-ascii?Q?DXwlDCobVgyYWgugDxrfCgXTjw4/Y+Y3dAqVnzdBattUnqpAwpcUqU76Ahon?=
 =?us-ascii?Q?PduGvjOz8iUDhM9a1r+9+X7ev9ukHGk0uRc+o2xlyBNks7WbQxbREIzk07js?=
 =?us-ascii?Q?ZySv5Sxtvx+v9IDLViibNo3UOPZ7T73SYvJPKpQN19axpqomWpMA3noo0IDF?=
 =?us-ascii?Q?Vc6Mba531dQshEyWtSZRayA/cNCDY65NmbM9Vh/XMIPi9HPv5XjI4us9Y9Ua?=
 =?us-ascii?Q?gDQVIYV8RO5AWAMeDWSfIAWaIavdaHi2rrBEYyXnUAng+rBs2kojJcwI+tkK?=
 =?us-ascii?Q?jBtIUG6pSjx/QSA/d5udcltTO85D5kgtnZ0nloC7JJorbgCHmer2++e+Tocp?=
 =?us-ascii?Q?WvwIxikaO8cAtSdowE+xNUynOqt/3sLBnCMiasVT+7ngPGVThvB5rQUWVHYF?=
 =?us-ascii?Q?vAedLVxboYH4SQMm4aKzmYnq3TiY5EG7hnzPUHHwTbbTJDjxrq8LgfKn+HNx?=
 =?us-ascii?Q?WPQSVFmJcetIZIiWZRKFAQoO6UTJXjPZnSB6kE8MRjg1YzPgyj2fgWoiVjne?=
 =?us-ascii?Q?JfSJSHnC9+a5J2uF89qiU/7vv7Xo/eEi0Erj5qnVfT2mLikBxXj5r8ASuR1V?=
 =?us-ascii?Q?ZZ+e+o/CBheK8qo9z65i1AMjrBMT4cEOLZAS7UVyPKYc15OGZFE/EwUEKjH/?=
 =?us-ascii?Q?4NPLK22nGUvgo8ylg0kac18Vf4eWqCa5r1ghngZCbtOBFvecxmrjbXQ65mdV?=
 =?us-ascii?Q?rRncpqOr78R4TjOXpe/HRfaUOgx55lkzouKdQ2cRxq49VVxPYs3m/hjTo0P1?=
 =?us-ascii?Q?5iKkcpjN5FDeZ8FlA9Rjj9snr0x5jVJHkZkIa2WWI28JEqp4MGIWNKSqkm+v?=
 =?us-ascii?Q?Ld5SwoPKGpSkI7gHL4+9Fe/MKo0wKjfNii6y6PcbThzfnl01v+jthvt7L94v?=
 =?us-ascii?Q?tU0vH4UJiMomOj1TKSMjSp/QnKuy82H9I9If7Fy3wqiwtECFD6IvpAeFL5Y1?=
 =?us-ascii?Q?K99ORSJ7WVXJ3E4NE9sZlfLtB7n5/AUyAY/z9HZNkpyvsjt3iDmxn8e37dDx?=
 =?us-ascii?Q?tl9jr1cXTopV5Tx6rH2YmaJkSQ84WLWhpDKqaW3Wmlao2Ije5Y7+0fxuN14S?=
 =?us-ascii?Q?Fw8cPjkG63TsBWIBEGyTcoigpnn0anK9ONcuOrVPRVFpqYZLGdnfrwMhjRVm?=
 =?us-ascii?Q?TIAgjpcG7f4gTvPqVHtwrvfxLPiFrvXnV/UWZGONm4RH5D28SCe5NVEQnbjT?=
 =?us-ascii?Q?cD5TJRFv9w7mp3SjRjJ2WWWxFv53BY4Y78lLqWhAH9FphveXrCPEDTH/vqPK?=
 =?us-ascii?Q?NGeZNaCQjxs6mkjCExkCt1ULJum8d2Qk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEqkEth6F0C+dAUDDSHUMmpsoYkseDdpe3po3JNJrmsfdaB7dD2hvCG6R6RZ?=
 =?us-ascii?Q?iup3WI+Ua+j9qvklqCAnWaWhArgYg+m8CLYDSo991XX5/ZgwAzFO3GQnK0XQ?=
 =?us-ascii?Q?LAVXHJmy0fOJyJGgeAQ1VWRScdtHqdAjHeSQx9RL6yUcLJpiW9yKpbWMAOGv?=
 =?us-ascii?Q?oUp9fbP8AZ9DYq8E1JV1oq+z+r7qq7QaHCqt49I8Hdqte69xsJnHoUHueqNP?=
 =?us-ascii?Q?KamYi8Vpqymox728bRHF2q5LAgX97sh0EMc9O5qqBWs0MMabzo6AW9+4WDug?=
 =?us-ascii?Q?RwjluVbsaMsz1Rqou5WTmVp0ZooB9oxmeojVO6ekGPgMSY4Fab9G3WIsmpRX?=
 =?us-ascii?Q?Ib69K30Hx7Y1rmEYQrx6CZT9mzt3vhkvXbsggcBldi1w+oNnTvij3foaBKX8?=
 =?us-ascii?Q?AvB5DeNMeto5CHFhHfZeviOLrkrQlSGie1iYtrp+NqtaTvfdG0xF/q/j0BOD?=
 =?us-ascii?Q?/g9QBfXBkZS8635bv1muD/HRxmvtUYTiDYSeeSlQc7H1nsyGd+Yam711t+Ge?=
 =?us-ascii?Q?XbD3SNlXd8tVgE3CRApqsAcsmR5Rxetk8txMPEtAW53kRPWNpsFAbqp07Ly1?=
 =?us-ascii?Q?RGYLBldK1NUm6AxV4XQyRPipv76hlQ1Ujejvw6FjbVJpLqvEwqiViOeuvqaa?=
 =?us-ascii?Q?JJf1DI+LY1hy2pPuKqphNx/LeP2lXVvq4uQ1XQ42HJBpGkEIGh6QTr3NMEvm?=
 =?us-ascii?Q?KQy609QuauB0u82DtCInEPsCK2BuNeur+Mb70Ylxu6orTStS/YUn5JBTy+2W?=
 =?us-ascii?Q?cqCwLQyA1p4OX+VV7CdPz0j1NpwS9gVKPKikqaru0g4xrOCjiaGWoXAqZXWD?=
 =?us-ascii?Q?ay2Ul2gYfKx8pTkvqninwHGAn8E4hcKib6/6SKcrtvRx2eYwCfHwKG/7kmA+?=
 =?us-ascii?Q?3lpxBqmoUlebrDl3+j1+GEx0EoHM6Mn1/ChkVeDdYJ+ciAwEq0IX5ZyYfJuR?=
 =?us-ascii?Q?Fy0+JJcLqwsraphDO49Br/oS7E0qF9/mrWwYl7D3LrDQPy9DIvHx0uIyEtuP?=
 =?us-ascii?Q?Eybe5tp6wCnw23LACAtaU0E85rkemSWrQbR66lcbwacvVB1FdVSKXiPyMg1m?=
 =?us-ascii?Q?gYayu2AEIab3EDa63l7YK9GGbSv+ma9SZ+B0+1PhWg/0g02RPfOauzXTsONH?=
 =?us-ascii?Q?fynangKrVy7YBpmIzZ9h5WqYpuYQFpW7noraqVbUPBCZOdsW6oSg4DUokj3b?=
 =?us-ascii?Q?1tfXhjf/Y06p15Y1bB6KL72uWPPDExr8nZ4awHWg1jYw1bk+tbdhuFC2Zu5X?=
 =?us-ascii?Q?I/YvNolvyf2asoJmAEXEQTHpKCpUZ2iAS7eixFmH3/CLhk+nqkYIyzZk31U2?=
 =?us-ascii?Q?2Nd51Ttl789b1q4kDCOmNS3cM7x7cI29kTClb0UFGPa1esnLhR03u4rasAm4?=
 =?us-ascii?Q?xdwhqTPRR5JwsnZUEGdbk7a1Yer6AoBT3Tyqad2N3m2whmtIdz8FwGPGqaOz?=
 =?us-ascii?Q?ufDH+1YJxBNgxqULFpSbgh+QiyTHxjRTqkZeElyR/dHCflDGd/+wzfNYERTp?=
 =?us-ascii?Q?fFw5yhkDBdgh6UUs6XXUQzD4ln1DvMNyjXYOY+JLVqpErVSUhdWr+U1KvvLv?=
 =?us-ascii?Q?pR0IKjZwnFUHCV5BE9po/Ve9hkj6h6ciF7lin5I4Ga/M0djwiQ54TcrSTmGy?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 227b356b-0a04-496e-0910-08de0000c0e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:07:17.0599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUPCzKxF1aDOxATIrnNjZqnIi0U1gbvXs3Hh/zs4JWJsyInm7ZgXLwn+qJTlYZcV6rIS6c1lajBr5LvQCmsp5gHLoj0MCdZYwSArj6HDcJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7987
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

On Mon, Sep 29, 2025 at 02:30:38PM +0000, Ciara Loftus wrote:
> Introduce a function that allows a VF to request the PF to reset itself.
> This is useful for example when the application detects that one of the
> queues have hung or any event where a reset is required and the PF is
> unlikely to trigger it.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h         |  2 ++
>  drivers/net/intel/iavf/iavf_ethdev.c  |  5 ++++
>  drivers/net/intel/iavf/iavf_vchnl.c   | 29 +++++++++++++++++++++++
>  drivers/net/intel/iavf/meson.build    |  1 +
>  drivers/net/intel/iavf/rte_pmd_iavf.c | 33 +++++++++++++++++++++++++++
>  drivers/net/intel/iavf/rte_pmd_iavf.h | 11 +++++++++
>  6 files changed, 81 insertions(+)
>  create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c
> 
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index 435902fbc2..6e7aec1bb1 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -565,4 +565,6 @@ void iavf_dev_watchdog_enable(struct iavf_adapter *adapter);
>  void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
>  void iavf_handle_hw_reset(struct rte_eth_dev *dev);
>  void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
> +bool is_iavf_supported(struct rte_eth_dev *dev);
> +int iavf_request_reset(struct rte_eth_dev *dev);
>  #endif /* _IAVF_ETHDEV_H_ */

In general, I'm not a huge fan of adding driver-specific functions and I
feel like this should fit under the existing reset APIs in some way. That
should avoid the need to update (or such a big update) to testpmd, for example.
Some thoughts here:

1. we could add a devarg to the driver to adjust whether reset does a
   "softer" reset of the VF just resetting itself, or a "hard" reset where the
   PF does a fuller reset of the VF.
2. rather than a devarg, would do use a driver-specific function to adjust
   this behaviour. The difference here would be that the driver-specific
   function would be an init-time one rather than runtime, so the runtime of
   the app, like testpmd, would be generic.
3. the most generic solution would be to add an additional parameter to the
   reset() function itself to specify a hard or soft reset. This would mean
   updating all drivers to handle the new parameter (shouldn't be hard, since
   it would be __rte_unused in all cases by default). This also opens up
   the possibility of other drivers - especially VFs - using it in the same
   way. We could actually document that the "hard" option "may be used by VF
   drivers to request a full reset of the VF by the PF".

CC'ing techboard to get some wider opinions here, especially thoughts on
option #3.

/Bruce

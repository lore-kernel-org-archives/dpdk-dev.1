Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A3D19503
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 17:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3662240276;
	Mon, 26 Jan 2026 18:14:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 64F51400D7
 for <dev@dpdk.org>; Mon, 26 Jan 2026 18:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769447674; x=1800983674;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=r4nx6EZ2OYfnVj4Zs79RBG5+A5YXRsVYS6YCvt9fhCk=;
 b=b9sZVSTM0hbCGK9ojm48al991i6hvyUyxBRUHYg2FaSdYm7TPp013/s/
 jVxMtsSStyezvT/vm/vhakQSny8Qf+L+nTl+VO+BcKUg+eTsItmMLREvT
 SJ2kesCOxhdHt3lV0oCmjakY32+1ps5xMd3ubEupUhkOC5Pmn544rxJwn
 WzyrmFT5JXoONCiJxegm2flW1hfse04+IQNOwY6SClD5StOQdKWuP6fQ6
 3w4zYOSTNBoE9RQPteFiwnXn6AXNaVeWeNSiK6qBWZsQB36tGnuScRuzP
 E3t9gco3tBtTFflQxs5oPOKAsrm/zdLeQ3LZx6/3Yr/He6rPyb1/AXzx5 Q==;
X-CSE-ConnectionGUID: h2NWlQfhTYmEfY2Zj6qPXw==
X-CSE-MsgGUID: ODdKkGkOTnKM/ZKejI2lZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70598171"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="70598171"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 09:14:33 -0800
X-CSE-ConnectionGUID: UXYC69bjTJq8IMUjQ3+QAQ==
X-CSE-MsgGUID: A3O0tQwoQLGu18isg8bl4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212190737"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 09:14:32 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 09:14:31 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 09:14:31 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 09:14:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIcKTOh5nNO6hJhw/LhEXScjVhNzJRd7mUfKgDnZbkPTqPegL/ojlnQNZvmf5QdsTAt0f3dggYha+TdEX3nBYUrOX8IoBFOFdeDYNtDIOrVySEK61OBHIGoBGQO2mmIzaoAtpDEW58+RGtKT4+C6R0NquLzhpMQ//8QGElajKSXG7NxIwTEDcd1+TBV0BWLvXprs4nF9cbrLo24BvpdrhCA0spRwoZvRTvf3Q7PSVgX7Kb+rzU+fpXSX0gGQIguM8DAXqs5hazsVXUPufcUK0AedxkQpOETjdxBmiMp7Kfi259wYFzVm1zn9zQkimzt4FC08ZcUjnN11JXRX+kKMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOyTXVPK46DGrWqqHw3tpv8rSuGW+AZOGvgLzxCVtWk=;
 b=M8oSHgTJg/d4dr4yYrZ8ixq2dElU4S+t5gqdCDIasSlZT2SafxUQt6pvvvkiB8I/RVf4grZ0TwrA0Z7li9SguN6fTYa76Lv9RE9SSyFr9Ijw9blbqQOi1d84na251X5EpF14Uht2XD2MObDVOCGukN3kDjEb/hY+pKzkIhVkDnSnU9ecEBqwQe5VQ7l+8SgjRKsAqml1pNmMpT9dhcWxUJuGiV3Ga32QaqRf3y/DzO4A7b/iTTVRvwRw+ktcp/8E58j9iFI7CQHZ+RcHYdxwP3snWqcI0N9xIPBjSne2PcazYvLdIK2HJTVMHX6jkuMSq67SNZa3Y0txTnXnfU9rsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:14:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 17:14:28 +0000
Date: Mon, 26 Jan 2026 17:14:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v11 0/3] net/idpf: enable AVX2 for split queue Rx/Tx
Message-ID: <aXeg72tU8e9FlAbv@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260105062257.102370-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260105062257.102370-1-shaiq.wani@intel.com>
X-ClientProxiedBy: LO4P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: fb46b2d9-bb16-4cdf-2d7e-08de5cfe5d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jJVoRDoGJIjoQ20+tsNLTTwETNTwyZdrQ24tpdQw2Xj8pSX9ei5URiOexKFu?=
 =?us-ascii?Q?nWXthVgq2SFdrb10ET5Ll0iknLkr3XvqIAhJax0xJfXlxrNAnnPGbBccT2h7?=
 =?us-ascii?Q?k+EvyjGGEiUC2+ghkbt1kVBKwPZqV7b/Xrcq4lB4gbte4nGHuI3BIbGxGG9D?=
 =?us-ascii?Q?cCA59Hwbswlxa5My4SziJjDLBJ7C0qalUkmRK9pHPsENprdDVC67D/8qWpyN?=
 =?us-ascii?Q?az2AWssFWm7UzieJ2efaIbsXQC4oDtJjn7cwYiyA04G4UlQqU3yRT76/RamC?=
 =?us-ascii?Q?FwBkWYBZxvY51C5xkOIzfcapoXE6lhyFFa+5o9BK7BSYeWpr7/ByKtwUBB1R?=
 =?us-ascii?Q?HqKxyyDJMjA1APZsS0kXQd3st8v55xQilj4ieHJYIgsjAXeU4eQBglqD3G3C?=
 =?us-ascii?Q?mBSZRIspQKdTOyluhFerw2TajEK+DFpoO/OtBkDk+2xJjMWrlZ1laKpYRo/C?=
 =?us-ascii?Q?snI6rwJWeA51xa1yjGRzGWleNGCGlQoYM51l/Ct4o4di4HNNEE7h7/805ZBG?=
 =?us-ascii?Q?wK+/DqRNauFeODt1G3Ii3S51qko9GFdzyBCK+2lDZ4n8S5p1aHtHj7EvdQY0?=
 =?us-ascii?Q?U7cB5u4MK/I8C9bIAl3J2J+ZXUk2x7yXO0dHqOI4sfOWacvHWCqfoWNR3ddx?=
 =?us-ascii?Q?tsVXcYZwj7EzJa1EOJGF4v3m7qLuD0lxmT6lPRRdOsKdYljxpywWiL620khJ?=
 =?us-ascii?Q?6KJAqqZhgvahrJ/dzsYI+onda3/MrOvfVKzMK3FK1rJFlF4PRNhDeXOoiQqL?=
 =?us-ascii?Q?xHuZkm1xkUv3Si37UgWQsxj0DKyeNTzYMe6v+TC/nCMnpjx6f3tHcxTL0a/7?=
 =?us-ascii?Q?ig4BrOepn09gwLKfGtOCbwJ5ddvYcvP3n0Cnl0Bqna61H6DXhW4lxK61Yksp?=
 =?us-ascii?Q?oH/dyImL7LSMtWA4pW0PFr1qOOBmyzrXcZ+4ZcS0sFEscOaHgx2VBxG20wrV?=
 =?us-ascii?Q?qLyt/vKjTM4qm2UDhEyajyWjjxM1930hI+7hRsqcQxF+QNMqDJJSPfKjZE6S?=
 =?us-ascii?Q?3YneK5VDoVK8kzuRH76jFYVLSfWxe6Rl6NIRiYKOT7KgsKIEtKQv7BhD06DA?=
 =?us-ascii?Q?HWem7EVGh1iRV0WWyp1QGMODw318HxpRDij35Utsa6VqmGNwDFkJA9h0il/t?=
 =?us-ascii?Q?8wcuAvfoEd6O9nIv5L+bnzQn1QEJjvaLsx8Ps7GmE9qcrKsJJUgi1141bmWH?=
 =?us-ascii?Q?lZHu1D9IPeS0KaPCGFseLJIlfxRuJg872KAMIwkvUFHOuKDdLbXH/ys+CmDI?=
 =?us-ascii?Q?cZ17YlT2uQJLdrjcoeheTbL5T3QjBITan8dwdj2+JorneH22gzoh2ZvLHUvo?=
 =?us-ascii?Q?KdKSob6JTWrQbLa43M7pNS6NhaZCGe6zvTTp70aWkXouSIOzuHAcv2AS2mZn?=
 =?us-ascii?Q?CanoCqvEtPNqGHcAkoy8qXPhrLn9Z1uoQpT/ROsMnAZ+boSitrdHF8rlQdfl?=
 =?us-ascii?Q?473myCD1UPGtWbyqxIAgWcFRJCPczdGRQgKnCIj+1ww6OPPJUtuJIFfO3Wab?=
 =?us-ascii?Q?jxckmfBRFSmkDf//QsT1DR8DjrdfIkVzNNx3NRufOLTHeaOXM2DDV6V9NiAA?=
 =?us-ascii?Q?LoDWTpFOxX/UVUhIZpw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IgEEedfM0K+tYXK23VmaK/y1yw4wknE1JOogzWIlTsbg31VTrGVCzNKqzU3/?=
 =?us-ascii?Q?KIihw56mvm4ezL5wvj03+t3ZiPqgmryY/RWIdI9DEzLapTvYDOOGajbeVdEN?=
 =?us-ascii?Q?jaltHbxAuKQiPCWvef+zA765ecnzw6zSIBjQWr4nM3uvMkBIJQXhiaZB2LdR?=
 =?us-ascii?Q?U50SmD6brIbdx/Qz6hMq2lf6SpJQUA3yld+1ssCfpPFSMABgP1pLh3i8rerN?=
 =?us-ascii?Q?1xGXCi+VP+sCsIDqIiurdhyxgAauwGGabPsMk+BK5cPDOckce7k/D6hMiT/T?=
 =?us-ascii?Q?vjrJYiyngU/qPTEUbguca0pp835/yHFD1DfM8unWXuD6CIOyWR54OywNr4Kh?=
 =?us-ascii?Q?TCAnjptWUibbslJo7PvB1F4RlbI7Jp+EfUa+r99kfpd5X4CXyOQsjqAP/w2z?=
 =?us-ascii?Q?SekrPzgsm3bjS+D7MK0MD6z92AKGi8OCIFRJ6fALrT7im76dFdEimSExqFCI?=
 =?us-ascii?Q?Ov8uf/QXct89rl5pQDf14c2tiOlzBpQJE3MlhpXCYjOGgoWgL5Y8dgCWI30d?=
 =?us-ascii?Q?aPGGjirO9eUHbfOSWWEJ4bD6wg2LgC8f6kYCzrYB6VmkceSnkzpdKpB9Z6ul?=
 =?us-ascii?Q?gY7Xd7laqgucIRDoGrZ391TBAO5nviXuLKDZHb918JBklC39N2XJtE1iubdM?=
 =?us-ascii?Q?zYBMr5kbb5DZlgNMurHDZq+zDy78IpksJ9CkhLRdlUqlTBKs+wBrM2FjrChh?=
 =?us-ascii?Q?HqL5MsrUszHffG8ia1iuh75obO4QEIPQU0Z7ywP7l/EGW10Z5v6sliHwwDe+?=
 =?us-ascii?Q?TxyDrIF4TlxfFRl8AweWRB741uWkUNsxHIaH6j2u1bV4/BKzShnN0z8GuFr6?=
 =?us-ascii?Q?Vg0Jg3iAT8XGbjxaotcyT5q+rtxbL5wQ0AQpwjsbeo+ELBZLTZ9rFlE1tudk?=
 =?us-ascii?Q?afqAixgdPFYB3BxmHQPyF3dbSnMAFbWr8m7SzviRfhwX/ISWYBfOu/jjrloM?=
 =?us-ascii?Q?HcocGiHmMnhSq18qC3MhS87BuRozAmEIaoPuP3E/9f/E79zO478nR+6ujA/f?=
 =?us-ascii?Q?o7bOaGNbanrEAz4ya6z8Qoa9EA/XQ4TRSwShLeTaEhr8hrqWVAVtXBZrEFf2?=
 =?us-ascii?Q?V3vvNS08N+maPb43gTWJfNbhT6+vqmlDEoSZiIv1JPfBzR8L52jJMqiXo8G6?=
 =?us-ascii?Q?tF0UYQ/ceOkW77gDwPIegiFG2DW6RKtxneHni+Biw+1lCovP/jCp6tLDvSkQ?=
 =?us-ascii?Q?3LTLnhLVdiUn0DXmoGQ3hWpO0PA4ngWzJcalRYYZDSbcwhq6PLzc8+EBIffu?=
 =?us-ascii?Q?1ZwPOFsVIrNimvLT6LBc8LVJPrjT5k+vm8SK2hd8ksewKOKEgCRmtFC4MhFQ?=
 =?us-ascii?Q?N6nkPNCf1VxPe6Iro1FZEf3FrGjcvh3ka5YZHUyqjVK8QQtmVysnSzX2lCsw?=
 =?us-ascii?Q?jU6Lv162MzC+YmHaIUhSWiB/HKk5cpVWYDGKH/tb+YhjX7TOOtIXR1kSFDtt?=
 =?us-ascii?Q?8wr2by2qHh7iFfTDzE4wpcgWXqR929zecvHwy2FzDCCOEt2c+IWewlOnpG1e?=
 =?us-ascii?Q?3mYgH+hb767eD9OQJrJrqB+yXdPOb6GmY303ZrXb/7hb8mz9lHLklqu3quxf?=
 =?us-ascii?Q?pOuBz/LowVcqEx2kLKS6Q0x1O6Iaqxv7+NBDm5L75FnpHJOLM5pZrQOAtnQk?=
 =?us-ascii?Q?aWiPjAkGsuJcrlTN/H8o1sZ4BoTDFMeQKtVfSAak/NZJKYipzKGLTEQPt0W9?=
 =?us-ascii?Q?5CgDFQ83yE4Y53Wogn4aGxVWiC/4BNtQaQw0OQ/D6X7hdtp3L4rll/9i5Ele?=
 =?us-ascii?Q?bngJBOdli2j953Lku+6J0rKX7ty3HBI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb46b2d9-bb16-4cdf-2d7e-08de5cfe5d21
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:14:28.8607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGt6AfBQyFOS+0Jv/A6802aEWroLFtsJUNYajWc+BGPVjJRWTy5/53FKHK4Ebhw20tJS/E+yab82CslRBvgakapyRmYTUVNVae71zh3yNeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
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

On Mon, Jan 05, 2026 at 11:52:54AM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> v11:
> *Fixed indentation issues.
> 
> v10:
> *Changed desc reading style in Rx path.
> 
> v9:
> *Some minor fixes.
> 
> v8:
> *Reworked the receive func to avoid race conditions in Rx path.
> *Removed unnecessary compiler barriers.
> 
> v7:
> *Removed (char) casts, ifdef block as suggested.
> *Fixed indentation, line wrapping.
> *Did blind write of data to avoid branching.
> *changed desc building and writing  order for Tx.
> 
> v6:
> *used single load/store in splitq_recv_pkts function.
> *removed x86-specific intrinsics from common code.
> 
> v5:
> *Fixed CI errors.
> *Used defined constants instead of numbers.
> 
> v4:
> *moved splitq_rearm_common to a common location.
> *reduced duplication of code.
> *fixed splitq_recv_pkts function.
> 
> v3:
> *Fixed some indentation issues.
> *Collapsed wrapper and core function into one.
> *Fixed some pointer casting and naming inconsistency issues.
> 
> v2:
> *Fixed CI build related issues.
> *Rebased on top of idpf/cpfl rx path selection simplication patch.
> 
> 
> 
> Shaiq Wani (3):
>   net/idpf: enable AVX2 for split queue Rx
>   net/idpf: enable AVX2 for split queue Tx
>   doc: note on unsupported completion queue sharing
> 
>  doc/guides/nics/idpf.rst                      |   5 +
>  drivers/net/intel/idpf/idpf_common_device.h   |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 ++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 317 +++++++++++++++++-
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ----
>  drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
>  7 files changed, 397 insertions(+), 58 deletions(-)
> 
Beyond the AI review comments posted by Stephen, which does seem to flag
some issues that could do with being addressed, this set (mainly patch 2)
also needs a rebase to apply cleanly on top of latest next-net-intel tree.
It's missing support for the new Tx path selection logic.

Also, it would be good to have a release note entry for the new AVX2 code
paths added in either patch 1 or patch 2.

Thanks,
/Bruce

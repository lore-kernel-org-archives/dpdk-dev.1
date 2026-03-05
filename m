Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDFEF3D331
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:56:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC459410D4;
	Thu,  5 Mar 2026 17:56:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 394AD40A7F
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772729805; x=1804265805;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RagHDbmDTMHX5Rt9ngo/NxSEJJl25GIesaqgG5kC3o4=;
 b=dXMvfdMR8YPzeE+PSn/CTMelzsxzct6om9TFcMI1Gv8dZFK8w5vYl8LJ
 EIv1ePGGa6aC5P0JzQiTk+juY6t+IJz1iAJ57wLrdAJ20woaTmHqpOoZg
 +Bw6lJ6CZ35xtXSBMXANv5uMhwXzSPSOFvcuprjmlJEey/yDfaybozWVR
 G0A7dnBXArCL+C8WEZZ15Tw2Zi2YN6GXECCqYakIeGOGQvnwMyz/A63Ok
 0xZcUFJ55t0cyWIePu02Cxdlr5xq62anSEyH/Pk3JlnIUMmKjerdlWqNs
 v6HCdpzQypp+fGDsu9b1lzf2TY6EQ3e1ZP/MeG2phx8oshdMygRCwyTBv g==;
X-CSE-ConnectionGUID: ftOeftaeRTO3VsN2a+F6Sg==
X-CSE-MsgGUID: LihdBRK+Q9mKGov2CsAVTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77670732"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="77670732"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 08:56:44 -0800
X-CSE-ConnectionGUID: Zmsrvm6ITX+Em3CwE1+D5w==
X-CSE-MsgGUID: jZQX5NMCQ4GaZh1CppU7yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="249200982"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 08:56:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 08:56:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 08:56:42 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 08:56:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fkv+RmqXIJYXQZsERHqq/Cp6Um/eFPGYwbw/yWg1SMAEVGQsB+hFxmN10UyUSYFp4pExiOvvYa4wZCN+cLYr7qxbr40Ra4QnWTXSYjcg8maJQoP5PUOkr9M0c3F04jyLvfK0dSn/1wmM+woAsumAQlpBY4hhkCbw8XibN7Cb9DMfseH/nRwYC1rJu6wPSCMV1Q0rPC7LeZGc+JToy7DbIxQJ7LFN5TYZHFEomIFn2ODaFuTdACQsU8FLYNRqY1uEC/fGapi+6hR05SDZcUHqiKxJmCtb1bk17cnVbD+zKxuYhc1l1zez6Cy8d45D/i+8LwF5RellSW62F07H2uX+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaCiFGUfU0QV7CEU1XUU5BFwfSVWOfWtii+N3xfVmjU=;
 b=SRQjW7Nf1HZvb+nxuyYQnSz1jSZX0KsBEGOY6D5LLJAI+dIczWFgaQzZffK+mrZIjbPBxwl2pI4QtpR4BSE+7XZEFuQixZCF/kcVDn65kOQojNkPGdJ2BOa6+tYCmfFEQpQhm8qhpl7KOqqN25HyLocNxXj3Uj9SxenFqB4slDhu8JBcK4m7U6ESlbyPNMeNOad4itfTKkjf/Rc3jFvIof/huvX6NSI/W2LM/yXZRExwwIKU3ot6gei8NZRf3LdhS9ZFzOPiSutz+6FYJFH+d/OKC/lwa2hNjsFQjJHJv+MkY+EjNDoo/9pmnyoARmrqWJk2O+HTc8QuV4eIQbzpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8100.namprd11.prod.outlook.com (2603:10b6:208:445::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 16:56:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 16:56:34 +0000
Date: Thu, 5 Mar 2026 16:56:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, "Chengwen
 Feng" <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>
Subject: Re: [RFC v3 4/7] drivers: cleanup devargs lookup in bus scan
Message-ID: <aam1u-uOmrI3JfN-@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260305164550.2067453-5-david.marchand@redhat.com>
X-ClientProxiedBy: DB7PR05CA0005.eurprd05.prod.outlook.com
 (2603:10a6:10:36::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: c572c532-4e25-47a8-5f78-08de7ad8285d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: srLG3EeZdWY9tRieeJPzyQCscCZvN4d3/KPjoeSpcC+YGCdjzJISt8XaR1ou9Bn64+Exc1bfu7Y1MaCqy8bebMCI6IQ1ackzrCD4ddLPXEsyAdtcl2YlOJ8UARBDT0jdZqNUX91fKYj/qGSDScl1ixjOllyZ0n4BNY2pTrZSXknoE0MogRt4HxyHpEjf/oczDbeKt64MolkdVRCTZ7n14URqSDJ+MYjaoTaINTJ3U5FF19mvGSi0hoRr61kaMe0P1FS7PyigW2tCfb1tPdlv4chVyyOlUaRgyxrjHJACIxFsoSLjwn/xVjbPxgU8h0W2YD0Y/v/Xss5fqtQHL9Cs9mq2gC6t/ePRGwIjLJ255FbNUMWjuyCHBgyp7ehhdtNEsLLGAFUNWTmqAzugKVfdbfhQf+yM7YMBqqjmUQot6TYTntMxXy+EsoUNdZaov2K+/8tYPRFnPjGFZ0oDkta3Vya4FF0Jix073GlntqhJaCm0dgHjcK/YAkaMg514+zBhyP1bSo5Hath2DyaQv5Vv/HBtSJYOUURQlAMftOEFID46wSSgfV03NGyyVAHEdXeb1rlLa/nQ+sp0WEklmoRe2zBqgjUd7/FCaz9YqbwnADEyL7epZdg8eAaypm7QT33Ypwlzyc5AUEbpApP/tFcdnKXzuBq9B2khBKgRqG9OcNEfLeXQo6PaIXza05osJrRPhfzs0/2OBDCP44cOyanvmE6gC4+nrHOYf1vvEZwtAcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5NxvzwQUzoqVfbMVgwZfEqJGmYD8cZTT4T5KpxwWYAv5g+Rhlupwg2Emy9zY?=
 =?us-ascii?Q?/Hm30x8ZXFlZENvlYqubP9821lMllSXSchGhVANFZtU9QbnrqOFcfY7jvrtN?=
 =?us-ascii?Q?TeCHji4Q7w/91fCOAGUca+EEwqaJO1q0KkmK+ZWLqoBt24b+BSSQaNlU9YQN?=
 =?us-ascii?Q?6ivAK6syNWsDTfkCu/xayvrmPzrBRquKXcEzp3KxmM8KQc7CZnldHwZ8D0Mg?=
 =?us-ascii?Q?XrVr1ev0OTX3p7UqbhdKWN+6+ilemmwGi9yJ1vxHH5nNpK9K/1NLkYIFFp/E?=
 =?us-ascii?Q?gFxwA5oEXjhGiAGsQWREMQm2IZL0PQJAUi6zvFsgH2ArLxH9XVYRhB6N7TNO?=
 =?us-ascii?Q?23PqLJebjWEYIfQr9N/+TF3mT8GQBo1P502Mu6qdEuk4EO0w/NpWQYh8PeLY?=
 =?us-ascii?Q?AII3XtNoutwAFRDa9hUhKeNQaJDQgWw71vcd9FFwEVkL8Ud9VUzP91OVAEx1?=
 =?us-ascii?Q?eyatxgZkx/NE24+t7dS9YVCmj8aD5MWSg2dt+zx8lI6XeROtrLJ7cYSB/FCG?=
 =?us-ascii?Q?v3QXZl0fcqDfsoJcclmVfCWHtppeS5yIhh8+DX91f0e+w999byKE4eulhpYE?=
 =?us-ascii?Q?p+wgcIypwvBg17rZlsayFKXh3DQMXQGnRhs0RVaOeQZzJgoLAVETza4TmSJf?=
 =?us-ascii?Q?9qbXh5qo9Y7GCDkMzyoe4CBFqNFrDAk8FrMsTLtncXozZsrLYDo2j3GoHExo?=
 =?us-ascii?Q?W7oSYK4eD1bT4R4wCT9/yZ9zBNaNUa6G8os13UUCn50rfSVNX5TeV3JCOka+?=
 =?us-ascii?Q?sw1JVQX04ylv5UaLckEw1F969VJy87kHuCqw+2u/OtTD84JM08e7NyIvTFCi?=
 =?us-ascii?Q?swzystrRdShcxSX3mj7mQRd4IxTBtTgu6BAxXVGN5u6KMs1MwHv6qDlEBs9I?=
 =?us-ascii?Q?sNG6ZdfVi0FX613t3sAj5/2RkrHOkrMx+9tQiIi7hfF+Q3qmvjdl5gIsF4Kx?=
 =?us-ascii?Q?UVsuj77HkwU2lGq5Cl4xlcXZtP783K7q6id+Ws9BuuL7MHJmznsZYktwzk4R?=
 =?us-ascii?Q?UaOjHhIHUPF1jk+YOH7+G2eLuBpuV5zgk63F06g+C5odogpar8eW3mjeJ7Lr?=
 =?us-ascii?Q?23B20LyDo72/sEAb9ODvrsLQ4kNS3Ilap0/WRSYZSXC+vBedDwa0LdtIPe8u?=
 =?us-ascii?Q?15KoCmdnJ7SCZyX6Ls4K2ekM4IOahg+8gV/wCHAIct6wsqBKvbbY76YvZCRy?=
 =?us-ascii?Q?re0O3rc57Yfe9hVZgHRxQpRdWQQ5thGISNZ6Mds4RdH1jxDkCFpogvPQkKfi?=
 =?us-ascii?Q?ZlBUBTuckY0xMFbPKDRu6oikg73sQJBgS3ymUl9BuYEo3BUYrgcEVKWb/JTu?=
 =?us-ascii?Q?Yi7lnMuJM3E1scB05rvAxAZv3hCh+9wBIJXLX5Wc+AXN+GvIC8ks7vtRdrHf?=
 =?us-ascii?Q?5KU2Lg5yORVpre9jS1Fw5iXct300eGh8WRpqtnc3S1AGTCnzbSkOiTNeXi65?=
 =?us-ascii?Q?C+O4t7SjOTF6d1cwWrgzRFiOcaeqPRNAMNwEQyU5naz25ZqAj0Fo3L+1sq4i?=
 =?us-ascii?Q?USzkxBEfnF69Chd8TAwd5PIF9/l6NtE8c1Q6hXND/7xDAQktxgkhCH2nw7a0?=
 =?us-ascii?Q?IVoFgV7I+towoNPB4/ce8lUnGos4RzOVcix5dPfHNm2ZjRN15WgxHSZ7tvdf?=
 =?us-ascii?Q?DHud1ciPi0NCyMzAMsMLHEgS7lYvcifbc7T20YguKtj76eOp8Bgu101B2HJc?=
 =?us-ascii?Q?Ch11fRt5Je/BKN3y9wpJgcs5/9B3YzgzhjoiDEP7BQomz2P2KLlbc4PsvXxU?=
 =?us-ascii?Q?UYeKjxkvTdNLCCPJOQBNVoU26qwgfIE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c572c532-4e25-47a8-5f78-08de7ad8285d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:56:34.3417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBe3B6h4TLqlPqWQ6uRKjx2XTQWP4+lUNEvLVJ+NbLHG2sZF5rmDRshWrAg0iNQvtYaAQJGMwKAMKO14JB4Qb353qvqEDah6c1NUhgXDiOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8100
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

On Thu, Mar 05, 2026 at 05:45:46PM +0100, David Marchand wrote:
> Don't hardcode the bus names in the RTE_EAL_DEVARGS_FOREACH() calls.
> The bus name is set by code in EAL.
> Even if there is nothing broken, let's reuse the name from the bus object.
> 
> And remove the now useless macros.
> 
> Note: in the ifpga bus case, the call was using an incorrect macro
> (IFPGA_ARG_NAME instead of IFPGA_BUS_NAME), yet it was working fine
> as this macro is aligned with the ifpga bus name.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


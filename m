Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443ACC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 09:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F15E2402E0;
	Wed,  1 Jul 2026 11:45:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8737240278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 11:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782899152; x=1814435152;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wdwfOM9iYEDO6ZjUvflFBIVO4x1EZsFjLLlSw3XISfU=;
 b=ltkETQl/OZQCPveC9DaWWaDYbBC1v0gd5iFD7S8wdQUvf1wJ2+7/ww5c
 0nyEFNjxyKSc9nO9rDo8osEvWWDTbUKLxO1lMJiIeJp35bShZWRil7CuJ
 GYYSEzkNXlkeWFJSsAEhfPk+fq46AuFHEoK+Gpp68zZEh1V6Jv2BDdndL
 rbVBYGs1SgqMy9Kdba6kGmEG7XzHcjTdA+1u+xrVdc58X7cxIaUqPISLZ
 tKH3OXyNQRvH/aBmTpk6BF+flbCIYz/kY9MbaE3Cp8SL3df5FGP15PLh3
 nvXCG+E1FfDdxtBMUdCfmO4pGvYMMcQAmj0z2yA3xR2ZpAKrTM916EVTw Q==;
X-CSE-ConnectionGUID: H0zOn6JgSWu+6N/3BB1PNg==
X-CSE-MsgGUID: ekH0vMl+Tjex2+ezjsad2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94781557"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="94781557"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:45:50 -0700
X-CSE-ConnectionGUID: hTJWNt/9SZi+7VIBgeOXuQ==
X-CSE-MsgGUID: 9RoTIx7hRZiRzM9ujlYBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="248541782"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:45:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:45:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 02:45:49 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6MFEdOz9l38cV3jhRqLPhaTepcyqnnJM35B1l6nbx1il1SDNh2L/YFNFQwDMZeuPxGEhKqzDkf9bw8GACwF/ZIeik++JFIr3SWCktwXasFsv4KqUeabWfKFQHNXeqyhPSWS/SeaOXQm3tPp1hcLeagZ87pxqFZ7zKZdjB3vwkaV3HfMmcRYMDyo5RN3FcqZv3eWGqbR0rE52Jbap2l1vGLtnvQKf5Qm+jJPYwcCE79LmmZLMQnyL65HJHBhaTARRhwDVxgpU9dE+7uNo3MCigGH8o9UET+CM9haV6A+rLtVpCEdaUU32bOppmGVqKhU2FqcgwTWXWx7cdW1UWzOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5URt6HmJVAA97KedGHNAJ/JX1E6rp2hNr90PBN+ysv0=;
 b=iTH9ZmSvWVmUdnwmSHB61W4yThjcPzFIPcD2KQiT0k5VGYxvFBQAHpwdVJIHG+1a/sB8WQPVmerIViwXFPBWVr4aBYE7TrOKrdSGpTf3RsrLwIbJfsurC02oZspqXGwVZfoojCfuo9UoCgJ13X94kX+nEnpL6VnMHoPozzket/G1J+5zc9EaNnGRERxurtMadn1D0Omaryh6abgpBtP5yXk+UjqU3qUcPI23kfWhavhnz1cWplYrrK9UPBzk5XEcoIaE0042h8D9yxS/JKtc3j3yLBNJUPjAsAXVVjX+AkrKoVwwQH5ZiGiweWFF8EikgywEteaPaKeXTDrfVC1HcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by BL4PR11MB8821.namprd11.prod.outlook.com (2603:10b6:208:5a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:45:45 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 09:45:45 +0000
Date: Wed, 1 Jul 2026 10:45:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/e1000: align device IDs with base code
Message-ID: <akThxBV9-hqkMIJQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260630161623.3131518-1-bruce.richardson@intel.com>
 <845b63eb-a2d3-4605-98c0-76c8173ee522@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <845b63eb-a2d3-4605-98c0-76c8173ee522@intel.com>
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|BL4PR11MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4cc8c1-4295-4b3b-609b-08ded75585c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: sOOrCntJ9Sgd65T9S1wSNTqHeCGFwYg0je7ooIM2qQHWBkNottpqlbqXYkHTj0wC7nIG3PdtIz/522J/gzzC0QAK/H5oLqVr7jD+buqAY6sv9jkgXlHFMd16ktjugdR1ObG09CStEbDorrC0AX3T1mfszxbJZqh38WB7pkP+JM/Evn2gFqIkzF2+wdtig3nhSmMvbV6V0qxgV6Ew5sH/VxvYzDWDdh+5Y4UkTl0wKJNAu9rGhCU9Ea6Kys3llRnV3YH68ihsobc9mg7NA7rNg/fDKyXzr9qvNNI4J06VxNj5YqkWg5XF73z0eJPGiGbYsj7GpBYh3lAdeYQkMbhX3wtgrxmCDYcsUfxlQDqnBzwaMn65wvOoDJQIEtTDEtXFj46h7rElqZSrdFQTC1uKRMdbj1OtDAvPUv8yMTHcBpn6nl1Ow/UFYBHHTuVVzNZAQTSrlblA+Ce+GWpxBfVODDRc5utBfsOjc2f4CbJHUc4zuxYZ+kdNi4bVFeo3Kt9xd/P8qvRZhCD5+q+BULGwTP8D/BqU6+/cZciNcS6iLUBPZzo5YFPtCyWnX6bfOC2AbeehSHvPzHZcWk2qeyeT2K/wOrJfo7bvGxQgT41Ds3JqZqDYvVF/+qK6yrNt6gAFR8wj4c5RsHplYW0k+sWRkCF7uXuLSgdDi+kLPmHxM58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yzr8ShpagpV7tPuQSbWqwURSF45eAD3wn7RkOdlFU7I9qYK9MvPq9d+4xJex?=
 =?us-ascii?Q?/W41scuHhRvqE0zBZoar2RnNVwh3UV8iKiRuADrXFwiMUTz47CRV8ioWLJDV?=
 =?us-ascii?Q?ZkV5psaLqVUlHUqYZ1RVFBcZHRdMxCr7rzNnZRFQVDf6pYK0XUFTNYxA+HV+?=
 =?us-ascii?Q?R6+bC5vklgdkWscPa2UpwAO6seSk4orud4yzpiYIPkp95IJ/BbTJkOY/N4LW?=
 =?us-ascii?Q?sYHcaP8FLyerrOK9hvQJ+sPZB97W8Dd1LtOWpXQN8PJg/kweqcagpx4M+aKQ?=
 =?us-ascii?Q?89ypJBsh0yEvU/D6ORJypM1BX1vAcT1qNALbjVO1fW6cs/tIbbUQOxIwrUvf?=
 =?us-ascii?Q?DeDH3tM/F7WABGdNVCUlOzzod9tuIdd6P5i7783aDmXpxbn1PnaIYixytG8H?=
 =?us-ascii?Q?iDjQGXCY52Yh66NrliEywnrm+WIyngIeSrnp0B7cn8NuVp0ZolCo7GPxNDsl?=
 =?us-ascii?Q?eYnIzrRJ6IqQRQfJf6LnYJy5XTmP32oqBmOL/jHRKfCN6jinFQP1zUIBcbQd?=
 =?us-ascii?Q?GhtO8evxxa11EmqNdVnM4Vsn+3XjjPvmKY5VkNr6cb+P/Zbg750iVgdalDYu?=
 =?us-ascii?Q?OIGwyZYmgTHQR61h6rGrABPzDFr0wI2wFZBTUFK/k2oJYThowx0RzxwqUiSK?=
 =?us-ascii?Q?aHVUsPHYM7wPepJ+C1I0sh8+pjx8tAlGLBxd30Fr/ZypoE5UEwiC1a3Biy4s?=
 =?us-ascii?Q?DR1NrO9xOqTPKOqOFttl5eLs8R7x1BWVN3Tu3pbylppLv3IaHFFUeRQHd3ME?=
 =?us-ascii?Q?sP1Ow+/vJLhcEiuz8qQBQK7dqGCXyAubU1ezjKJtRZGKh5FDfhSfPXE7la5O?=
 =?us-ascii?Q?05Ff3MONzExtO6gelQheZMILe6SKjeFbNdtrPPb4F3ERtUv9leqahG3rlWDe?=
 =?us-ascii?Q?SqMCkYXQOLZ+Z2YbyibPhtaWxfEi83Uecp3z7mm/bT3oMhCF47YgQjbK/8af?=
 =?us-ascii?Q?/H2rNh0xUuOgHH5fMywCcAq5NVdPAk/lO1Tu/T3ykyU9mQ/t5Qb3X5IAgk/H?=
 =?us-ascii?Q?+zhXdMIxXFg9afGCiaS0hJ82mVd7AJlbZFpWzwUpYF6zvI2a4dT43c61YEjI?=
 =?us-ascii?Q?ZudIfp+dy5Bs8581LwiWeVI5fxjw418dCUIHZWpQ0znglMfNXi6Bq8C28JP5?=
 =?us-ascii?Q?Bt2anhoF6MyIT37xaCQP9bbnthT4Ako1NzZCPJb6sBdRRdnaN2EqHe734dpZ?=
 =?us-ascii?Q?E/0ptA2PyYnyrRVJhVYfKx/VdANHYD+vWnaYFWwV6JR5SFljOvnr1xV+Cnk1?=
 =?us-ascii?Q?3dRkywOWDxoS18tN0p6Mj0mBkeSHL3hD1QjY8DHLYGZOYwYKxCw9ivlf0Ybi?=
 =?us-ascii?Q?3g6q1vfHu89AiAAduqwZmRIAdPCPxvoB5bswDdtj0PMyA6mW3/iR5L1v/t+x?=
 =?us-ascii?Q?KRSRD6PhA5abUH7MeemPgOEymfF/DKzYWGJfJ5djqFcf/dUBcSrFtCdhUQgp?=
 =?us-ascii?Q?MJP8QbonY2dnESyOWEqGFnZCtIKVFZVpoLsxpKqtJRjxrJwv+i83Q9vHQAcJ?=
 =?us-ascii?Q?TlsKX9xKLMYp08TuaKjxjQhNXIR+qUsU32xc1zOJFK5BX11W4DWmdl7T4UoT?=
 =?us-ascii?Q?KYLjao7uHfT8KhOKWBW62WAeTNfhpGCCb5STpo4j5ZIcONIO6olqYKHg+pMq?=
 =?us-ascii?Q?IrEdwYJZkEDxudU3mm+Sr8L2Q+62ggCtXPB17eEmW4DDlKZaibmncLIbgYGC?=
 =?us-ascii?Q?cvtXy/Wx++qtAmpbv5uBFQ504isYlkrjbDxxTGjPu1SKm5Xsv2HF+L22iC4J?=
 =?us-ascii?Q?lfi4QCnDh0RGqr5RTFrNmCj3ybnFe2o=3D?=
X-Exchange-RoutingPolicyChecked: fEYneVQVV4OjUS0hCwCNWHGmMnO7bfGSvm3tr9QkMNoBtiNzvx/3pcn86NpVsm9Qvx7RKt7Y+tvm77B9lpc6Vanyhs/XeA4ODFos+ljAcEnO4rM1mOLM0zwg5Kwwc+WliRk6FzbW/WXm5kaPa5Ri4baZktm+GmRFF2Yp6+wLfk8XdTDXAOQtF8UPWet8rg5zFSptiDtLH5GNTkgz/LCoHupLKfTFQheZUOE0gh9iF+B1Vt96ra7L81fFXyGqrx3w74r/dw7ZQakSSzIYpJfJz2SEtzV5ubCoMJq7OJ2jO7APb0KM+w2XaK8Vl8GybEvHizzf5PvOgcgfvOriOnk0DQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4cc8c1-4295-4b3b-609b-08ded75585c4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:45:45.1504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hHAjtaFZ9axXUPDVLMsG1pZegdUs6pL3J8j6czd5Prd/RLJ4FaAhzbpq9FhVHaxMWFAjem4/nLUF29LyYwKox95TjZnSxRm6ykp0W2TAyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8821
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

On Wed, Jul 01, 2026 at 09:45:45AM +0100, Medvedkin, Vladimir wrote:
> 
> On 6/30/2026 5:16 PM, Bruce Richardson wrote:
> > The e1000 base header lists multiple PCI device IDs in e1000_hw.h that
> > are not present in the em PCI ID table. Add the missing IDs so DPDK can
> > probe all e1000 devices defined by the shared base code.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > ---
> >   drivers/net/intel/e1000/em_ethdev.c | 70 +++++++++++++++++++++++++++++
> >   1 file changed, 70 insertions(+)
> > 
Applied to dpdk-next-net-intel.

/Bruce

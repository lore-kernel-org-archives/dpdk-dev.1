Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5EE6748D
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 09:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60383402EE;
	Mon, 22 Dec 2025 10:50:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id CB97940264
 for <dev@dpdk.org>; Mon, 22 Dec 2025 10:50:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766397025; x=1797933025;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Y8kUBgtYrWucYQjIttA8mEn2ZPYUzUda7um8rXgynsU=;
 b=FwjJzxeYJwYWfo2BBchDlrqQaktUEUnol8AOckamcjrdlKz0Ww8vw09j
 /LxIqCy+hnsdrO6jH+dL/YhGDDzqgYUIcVd/1NLCHwyvTrWzLiEF1bHxe
 1nZsSYa1zEvA8vg+zb7wO70AVRNvHSv+5GOF6PjWt6oQoENbVxJEbvcST
 hKcONs2TQkeoJmFi2TxbBOW+OScTKHZJkd8TBnWeyEWjiA+8YGKCxnJRE
 14L5JKSZEG8Tz4/Yblw/VrDeX3So8H15XbMrNQ4DRYVYk8WzW89LBlmGJ
 4iiMwh06GgXBHLTSxazwQMdalZZOTPjWn1uQ8U1PWhnwtPPP9scuuoytv g==;
X-CSE-ConnectionGUID: TkORrsULT+6qrpsl5XKhGw==
X-CSE-MsgGUID: TJ+cj8GARwm2l2OGvZ3obg==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="72111308"
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; d="scan'208";a="72111308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 01:50:24 -0800
X-CSE-ConnectionGUID: 6ieXfQt8Rp6RVxL+0dmI2A==
X-CSE-MsgGUID: 2QrsjUUgRYGAElxPAIPUnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; d="scan'208";a="200375506"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 01:50:24 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 01:50:23 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 22 Dec 2025 01:50:23 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 01:50:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3tlGCch6zKVODNdPG5tYMotCyqE63mqfQqbPz5Sgd9TI2cMpornN030iVl4MMo75uSznld8aUBmMoEUgc/02448Bao1PXXnMD5qmNgC573irZ/IRYg6SJBvNSfX4XoziAqpoLpzufCd0TuHc5s5Od1XH/UiVyCqeWaV2UNDx7tCmg2O8auHTWFbH+nPUaBPeen/rtEwFBks5+PBH+VW4/nZ7z79drk+hGgtLptgL1/x8efXfIBZ2AXJeTxHBk5BuaYOPt324aH3i4p1/xCXdv0iDV9uMtqn5pwchmDBAIO0yZUp3HmEtjXXzZVRy6jwCw6vLmzTr+2Ab183nijxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFrD3YcTuPGGRWRe5BQHGhZT2ylJgX6wGBP/qqhPudk=;
 b=rCXBj+fJoBu1bLsEVkpIeSP/DZlNHilzYTKwYhUJ0Y/4N8UO3WW2bxmLKgiEWBr5i7Gz9ow7dL+KpqFAJ70WwaGbZG0U+0ObiK7QUyDCsmAI8dGd55+whMQnONxeJgCzIskUbe1I9PSluNvjM7RMlxJGXTTFVjRtFEHPU5/8Un/ASD+HSiSwUEL5NtoN4U8UbA2fXBe/grDlnnf+skKwKBei/939OBej7scgBsxutD0276bOS/ACRPx1U3Qg9Htk8MeA0xP7E8+TaR/QVngxDepStk5QPuAJ2q9zAA+ZvVb32nCxJdqEhj4Sgf6btBh2EwvYV2h6VVLwUZD0Abwqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 09:50:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 09:50:20 +0000
Date: Mon, 22 Dec 2025 09:50:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 20/27] net/intel: write descriptors using
 non-volatile pointers
Message-ID: <aUkUV_mvVb9CoW8s@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20251219172548.2660777-21-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65602@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65602@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ac022d-7f48-4de6-a84f-08de413f8512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Rh/iVdq0NLoMcoo+bu5rdgJ3h3b1vMvACOknP7IY3DsP0qwkv1DwjoeVzA?=
 =?iso-8859-1?Q?+bwIKsI21kqZBjkwGoS2AsgXeLx7KBrhG3JWtraUz/qGcHkB1wzr5eRVwq?=
 =?iso-8859-1?Q?20pbgiWVxjqoVWbC3pFOZblJ1KddT6g7MFE1tP32Cnp8tC90t/qBLR+AEI?=
 =?iso-8859-1?Q?6A8OeAK0RNxTiZFCZevMb9v57VbzpH3ows17wqZKPURm9xW8RVIFEuvs97?=
 =?iso-8859-1?Q?rFR6j+M0dljl4w0PHYaQD/1e9h/zv/GpESRqjNzocpiQq9omxf8nfaD0jA?=
 =?iso-8859-1?Q?el+9TFKOrESYOkJmQc2WxMSVsAHrD4CLqztnPNPFOCiwe+QfJO91fh/+ED?=
 =?iso-8859-1?Q?res53A7J+huOg1A0/I4eFveu5MD0W9mJN3+EDRmHj/+009/oRfyhpf6izy?=
 =?iso-8859-1?Q?g8dHg38eXViwqV8FyV0BNx82uQbyTR//1XDGQmC0mlJ5nnL4Od7P6kekKZ?=
 =?iso-8859-1?Q?JRygUMA5jwQe1jYHxAJFVGTqqKP7zr0R3WfDE2Qbv++4nh3VPGPqIpOei7?=
 =?iso-8859-1?Q?9BQw9jkpzM7dY7ENNIVhbBGu4PUH/xXagrRFGAg/dPTatd3YvWz/25Gtqs?=
 =?iso-8859-1?Q?gBkmal/cuAqnPuz/JrSMu5MDaqXrpgX+0UzTRKJmgsEs48vk3vz77kI5Zb?=
 =?iso-8859-1?Q?mhj320ZwvHzUiYZm66Qje9x+qmRJtWWDLh8zgUzdA0fX5FbbesgD8khLrG?=
 =?iso-8859-1?Q?emJE83/KPcKUPI7/TZ6LRv5E3HBp0B2Wol7ck+usF+TI4ucs8vG1uWNqHM?=
 =?iso-8859-1?Q?ArWz91fP6Jo6cA9MeSDNPM7VbQuO50IwgRH3y40qfBwCBUjDgVdE2CX01A?=
 =?iso-8859-1?Q?dWQzwt7x4E538DnK2gy914H07epe7PR3055MJiZYWVVjU4FMmAK/zeABNU?=
 =?iso-8859-1?Q?9qNZeG2F0ER7wJ0WOamTltWjIHvXEtRw+T4R02luDG2E2RIeZ8vpYk5Gid?=
 =?iso-8859-1?Q?nhpFnwV5fUu3SP26xUfl2s+ujd4lpR31ywnuzB2qdM+cgQtZnDHn3/z0FN?=
 =?iso-8859-1?Q?ZScTcyDdV1GqHCHyzEmq0zC7rXJauAdhvnNLyogRMBXfUO9DnSIJYA/IUc?=
 =?iso-8859-1?Q?T32PGSvt97sXQJqGwyDch3kpV2ncRAosxwK0wuwj7vopOTbgE+sbJKbjIr?=
 =?iso-8859-1?Q?kD1EYS4GfJkLdc02RFpvdwBaNn3HVKfGgAPUOluHyAIhZr0YbFLwiQb7ge?=
 =?iso-8859-1?Q?OmgXsyZEoyG6kVvkj06bwaDamYRGoDgNugPK4BWVdKSLdywPxhbBA40TM0?=
 =?iso-8859-1?Q?+z14yY/kXdBFTdX0EGgB/wqnikNTpDrtrXikSFu7kvDbevtfGxhQwDLoFF?=
 =?iso-8859-1?Q?QrMv3avsMLvQ2w4+xHQWuDq71Y9mbjIrZpWEpGwpxmTel/331Raur0ty5b?=
 =?iso-8859-1?Q?7gW8TStdaFn7PIZFmH7N03t7fSQctS+qxyw38lOAhNhGq2ZfOHNBhwt1JB?=
 =?iso-8859-1?Q?EBVEjmnE8ADkEe+bG1abWCow/yabLBV1x/MLk3JLKxe7WEKcNYuN7dyLLx?=
 =?iso-8859-1?Q?ZNZQLQH0mHX5a7dBa8yYDc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RXWtTy8TnCRjv1wiBllFkETi4YPLMFWJeFMcJh0Dbys3+coJXLVIDVOPqF?=
 =?iso-8859-1?Q?uURQZz01v/AY/qI53FKUIIu6La9WIpkpme2sZdYnZDeSvwG5vFI56WFT1W?=
 =?iso-8859-1?Q?DP8W6s9J2xH6JDUsvYO71671mtNs/YycgPSGBEvaL3W41e5Vx7y7u8nQJh?=
 =?iso-8859-1?Q?MfB5C21lUXgTjXk0Q3MQk1DOM+b4biwFRUjsr1cmlpv+bq4oudR24YVbX+?=
 =?iso-8859-1?Q?U2creHF49obeAAeTAWbZzDR6gwolpU/qM/Jk7o1E5xQfigEik/Fbkbhb+h?=
 =?iso-8859-1?Q?vrKilPMFaR174eI5QHiM6C7P5uLLtxuZ1P9RtSzMWoMz+rW1TDo/kblZ4h?=
 =?iso-8859-1?Q?9IMLrAsUU0YZqTGqeiIf01JGDNuZYCKDIntp+fEIuVdUMzzyHreT9TLNqB?=
 =?iso-8859-1?Q?XCgZzon2VaEByUljb1HM0zxfjZcpkXbeCDZ1SZdwdzxoJPZOcWzLGI+fTn?=
 =?iso-8859-1?Q?E3ytAP7JwWV4ze5DnQBp6rVihpgrFe9Y0mB47nY961wVr6WTtpcOGaK8nB?=
 =?iso-8859-1?Q?Pr+GRI/foTJ3tpzT4f6/7me88SfyRGYd/GjcHUizipvzUS5pAUcBfN4Jry?=
 =?iso-8859-1?Q?Nt3uFV7Q6Z+cQDu6xrjetBv+rQJAbW9Na7v8U11GMVt7bX2dh+gJMUNn96?=
 =?iso-8859-1?Q?0m/6bOecsSElfevhcY9XrkJ8wRRoIZV48pZdu2eeh+CKjbyCWSf5CkVXZ4?=
 =?iso-8859-1?Q?EfeImwAcv++Q62fMNfti5BC6B0UbvglafXhIZLcpZ33C0VGU6/ZXfCVVTg?=
 =?iso-8859-1?Q?t9P33FvXoVAnYv+agjDL1WwrB5rdKil65vo65YG07dCR/XuqMs7p8mvvFs?=
 =?iso-8859-1?Q?vX7j69WM5B6U2Rp0Quw6zaXgSpnI5i16Ok1Mmi0mklmPL3iPNX8qgfIuPT?=
 =?iso-8859-1?Q?XRFlSqCo3/cAFJdIGgI9XuXW650J0zw//nh6Al9dVal2A1tqcmwsmX6QEF?=
 =?iso-8859-1?Q?lX1g4rQGDgZT5omqwjPb1OAsWF1TdKrLDUY/zn1+Bl0nr4f+pdW7R9jYar?=
 =?iso-8859-1?Q?Qx7VOJ20b40pNdArOEX9inC8z0MVohfLxfp08IYym/8xuz9zxeLZ+kGvuw?=
 =?iso-8859-1?Q?yRxIqvIRnQpHwAl4K6TJ8C5gc986yIgSr33YBpogwiYkJBmpXyqKGB/ony?=
 =?iso-8859-1?Q?tNtofhIjAdAdDTd28vzAPUZ09PwmcUaKVOrHQl6jdSJ8uTh1O1f/fSGhXN?=
 =?iso-8859-1?Q?bhtmfP1NbyQDiZoSH9KiLWyax5e7lmhQi5F7sTZPwDeL6rQEZsYrklybTp?=
 =?iso-8859-1?Q?nwPZeCiyGxVY4ZlfuCf9SR9Ma/SzxdFpSv/dy5RSAxlMUpo1+LL3c5/v3M?=
 =?iso-8859-1?Q?shB8YvOYDjK4n2sV28Kb8CaX45LbsK0oGWOEdXAzzlU086G0AGXEa/Ar8I?=
 =?iso-8859-1?Q?VaWjHcjmqLSi8P7wg/qljGEctqMpnexP8xgCXQQ/yG8dJz+QzBlMIArBhL?=
 =?iso-8859-1?Q?7vuI7y+VHlftH2je9T6DJTo5YTk2DHHdglpzcFWFloCc1t8P66v+ZgOpHS?=
 =?iso-8859-1?Q?1MiPTnKfIfZHg2Rnd8oNWbkBc7AavWkv74egj7PqUpQxi7ZpWRJoPQ9Am0?=
 =?iso-8859-1?Q?NwaaII/lnYP4iey9/I6xQx0kBoWfBz5cQXuMQwJLjxjbfINwECkjXs4UDO?=
 =?iso-8859-1?Q?1+ukZw4LiXlfuR7mFJXyaEm8eKOqfJNRoYAzpXWOraS0hF8n0WNxWH88EQ?=
 =?iso-8859-1?Q?1BeNtx8KWNe5W160MHRGlpwEz5yL/tux1uQy2cc+pdxauztBJIWmKmSW3Q?=
 =?iso-8859-1?Q?rv5MWvuM8bjNX01ZQ6JFCFi/O1z1hDpu4NLL2IQtSbmPiZLFlaQeuKfnhF?=
 =?iso-8859-1?Q?U6yI9IbuYnklX9/Ar/C8MiY1gwyFRTg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac022d-7f48-4de6-a84f-08de413f8512
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 09:50:20.7034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQR3W6nWVUGy+SKk0Y9pg0+0lVjm1QfQ21wwcWMVdqHNT/AOoEYBIPl+3k9y1uXwrnrSnMDRl4l/bFq9E0h5hC/zq42BUqw+T07Ivumd95Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
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

On Sat, Dec 20, 2025 at 09:43:46AM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 19 December 2025 18.26
> > 
> > Use a non-volatile uint64_t pointer to store to the descriptor ring.
> > This will allow the compiler to optionally merge the stores as it sees
> > best.
> 
> I suppose there was a reason for the volatile.
> Is removing it really safe?
> E.g. this will also allow the compiler to reorder stores; not just the pair of 64-bits, but also stores to multiple descriptors.
> 

It would be more risky to remove for reads than for writes, I believe,
since when reading we have the possibility of the NIC doing stores to the
descriptors at the same time. In the case of writing new descriptors we
know that the NIC will never read the descriptors until such time as we hit
the doorball/write the tail value. Therefore, so long as we have a fence
before the tail write, (or as part of the tail write), it doesn't matter
what actual order the descriptor stores hit the ring.

> One more comment inline below.
> 
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx_scalar_fns.h | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> > b/drivers/net/intel/common/tx_scalar_fns.h
> > index 7b643fcf44..95e9acbe60 100644
> > --- a/drivers/net/intel/common/tx_scalar_fns.h
> > +++ b/drivers/net/intel/common/tx_scalar_fns.h
> > @@ -184,6 +184,15 @@ struct ci_timesstamp_queue_fns {
> >  	write_ts_tail_t write_ts_tail;
> >  };
> > 
> > +static inline void
> > +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> > +{
> > +	uint64_t *txd_qw = RTE_CAST_PTR(void *, txd);
> 
> If the descriptors are 16-byte aligned, you could mark them as such, so the compiler can use 128-bit stores on architectures where alignment matters.
> 
Sure, I can try adding an aligned tag to this.

/Bruce

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985BC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 556BA4278E;
	Wed, 21 May 2025 12:18:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 12E904065D;
 Wed, 21 May 2025 12:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747822681; x=1779358681;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QtAhImVnpOngWif45/wSikmdXw9ASXM5TlVvtPEuyUo=;
 b=XE2I4bUoOnUmCMBPYYWBBaIoI+5T04s6xPPdKm/1YYa0AfgYkqOlRIuJ
 hoWXmgK3NFJ4h395tgg4LD85aJtHvx3L5tqn2T6CjjOkd3/9tRWpmkdxA
 RkEstlRrV8zA9ulBVRycbiju/dNmwPPzZEUrbRiGdQpaO92Ex6qirhLj7
 Z+mp5VOVeq1IA2Xofq0rtHA7nnqDRLnqiJOQuVWDGxKHOqHif0AgBVcWc
 YnPtfqhXcGFqnJo1zGqUMH7mQ+euLpOfF3iYXLBpdiiYCpdI7eyu6iOHc
 hTDfqy8VD8aVhh2OdOTkCJh/aDjWoujgXPBKbuUnodZXUbgvNauHlhy4r g==;
X-CSE-ConnectionGUID: VaZQUz2PSoyNBStHj9Q8Lw==
X-CSE-MsgGUID: DkIrJRUfRL+5i3KthmMahA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67207939"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="67207939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:18:00 -0700
X-CSE-ConnectionGUID: XLf1H9XnSfmr29eG3J/wVg==
X-CSE-MsgGUID: KtpvTXy5SNq/W1qB/Wf2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="143995519"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:18:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 03:17:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 03:17:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 03:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6+8AS1pOcnO12y7BzxadLArWYj9LzYc/W9rd54ZFyXhsK8My3B6zAU5GlQYFZE8ZDFOJxy1CRl77IxqcBvOswNpTg/saynrckSKIMRNe883W90Y6aFIKThyY7550t2UMxHWOkie6ce58swxk54yTWZP1y5UnPF42i/HBK0wUBEQ2Qpu0NMjAVvTGPLRsu9iUQhvQOVW/k0gU4C3Khmb27R5EQppcmhrH7Xd2sgEkutFfW1g6T+mLwU3HnizHOqxP4sWh4ESuIxKHgWHzSMGaXl2BsHrzm89sJ3GiUSAyZqvKWp1cgNnSFH/YvpSHC92Ht6fBoQX0a4dhCF1KS59cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk2m9IqaSa+vtwtrRC0spQXMRLw3+XyNNV7YrjPSkKY=;
 b=V8IHPLNeiLNueTJoMQumB8fcE0GRDkx6DkeiyAGpihyODl7uaSSyTzH0JyYfk2TjER2d95q/QOHQvv95Su/9yGwaE2XS2MZlk23W2jMNw9o21w4o+Tv82OBAiYXLGUiEbI8DyYUF5f54oH3gMifN1ilQKXos6PTLAjx2QEkjIcndqcUuaEnFdv3SM946kNuCRtnY11teEgbUgSsWr2KVkqh3A3VWujFG2fL2TADobGRWC6D6FF9pqz6bLQPHTqIAl0SYbvp69PDkLGO0g+0nvUV3Mx39vpaUp5b+LXy8Krv4jzJReWlOHSUVAiby4Zf/aAcbHyBIXj595zW59occ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF06F7EC6B5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::807) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 10:17:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:17:51 +0000
Date: Wed, 21 May 2025 11:17:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kaiwen Deng <kaiwenx.deng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>,
 Yaroslav Brustinov <ybrustin@cisco.com>
Subject: Re: [PATCH] net/intel: fix igb tx queue offloads capability
Message-ID: <aC2oSsbGSW8IlyAl@bricha3-mobl1.ger.corp.intel.com>
References: <20250414085353.848901-1-kaiwenx.deng@intel.com>
 <aC2nfWi3-27ibs61@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aC2nfWi3-27ibs61@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF06F7EC6B5:EE_
X-MS-Office365-Filtering-Correlation-Id: c0eefdaf-aede-4b11-75f3-08dd9850be73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RsUNu+q2lmuBRQN/xQDXix2J+GwNfuGdOfFHGK2T5EL607wnPe+Eojiubikr?=
 =?us-ascii?Q?RLXz7KOXwYJt6E0gMXdyM+Tpl12B7Kl20E7LCuLXvL5V6xRfhFrtFqlUAFRg?=
 =?us-ascii?Q?KmjeckRhVUtqjUpqJXLt5uJU+I10VaSsaM+2qUiUj75u2UvVqZeYtsa+mvgu?=
 =?us-ascii?Q?IZY2xZDX5lSeCrMIG7REsC+lhKtDIlF/s78iBsUbFJeITEJeaGaqRZVJSNP/?=
 =?us-ascii?Q?ephWZT0S1Tuhz1TFxmFeJaXbFCpiycnO0JbJxodbOTqp/8W7yhWQLmrc21Ye?=
 =?us-ascii?Q?U1b3TBFoXLC6cD6IujQ5/0Zcbl91BH3+eEXQA0xqD7sv6+oZklodxGwk3DBJ?=
 =?us-ascii?Q?tdJfwU33yVwB6+PMWVDwUW8B5IiLSjYsHzcaEXU66v76kPOSYHhtdDZCf1Bw?=
 =?us-ascii?Q?5p/Eed6jl4XRMpX+ZcsHnUTyCORmwr1W6l6q7ZgCGZcfCvhCyLrh4+cveWTE?=
 =?us-ascii?Q?eXCdA9omfpyawakE1mAmLTgu1yypcJYYuFJZeGVIvSH+p4r4+y18/pEFL6hZ?=
 =?us-ascii?Q?mfZbVEkOlONkpov62HN8PFQGYBYXBZ7OG47rrsy0yYO9+isCUbPyiYsGDXZ6?=
 =?us-ascii?Q?BcLUYQ4ETrmLLd8NzTwjhJ3w+ZjZ7ZAgZuiMuWup3bNRYqadnzAolAU+Am33?=
 =?us-ascii?Q?6pClA4Op+ycC+LHIT9G3hUqz6aEqiFdNv4jSkJw82GiQBC1Uk2X2bjc7eguD?=
 =?us-ascii?Q?6RFs5cBeLvdKtVovKjNba0VM/YNCmlUYnbP49VLeijUo93oITwnsJNapIRF+?=
 =?us-ascii?Q?3kD/N51rPdl1/5U+TX5w/S4D4+CfDlMipryuSmETnKmKx8Hd2OiScH7KgDVp?=
 =?us-ascii?Q?bLSq+qC6g2FW0AxuosrgDJa1VCRsI+Kulrm8rAIcdTGUX35B9JeCN6JCkZA6?=
 =?us-ascii?Q?MxCybiM9MUviJmBYVbpm//bQ/Asi9Xefq3UYfTZIj9fCbod/PVyPmT34qO/3?=
 =?us-ascii?Q?Mqio1w2S56iYf1bm4x30Hm0Ttf02SF4KZVXbt6mRa9XIbOfhc1X1ExxCY680?=
 =?us-ascii?Q?ScQ6jt8gcmDupWn70/hoAbi/Em4dj2cUf58x06MbDqP/RpcDVJ/yRPtc4jz1?=
 =?us-ascii?Q?leFhs8V1OtisFbdS3ZoBHtKF6QPfjCrMLJXzQi2iky/TW7il5eosbMoAS2iQ?=
 =?us-ascii?Q?8RPqTAIH6cqMcX1RBEs2B1V77PFCSl90zkoNdU5QzEIVdW18unmPA1vs0JNt?=
 =?us-ascii?Q?OIX9GXhyEUtf9GGIgj49AVHJ12mfEdpHIejVsjioEQ4j0Mb+PUFZ42FGIluc?=
 =?us-ascii?Q?E2CnjvEPb65oEBmdTPPhKH8MKdbQmd8SWZV2NvHIV6jm1aQ9BwAVB7p6GdQ/?=
 =?us-ascii?Q?NNiQr33J6poeRjDH83o2sNri/8BNRosbcbMOv2D6AnsNuQXjAGRwxUFUUW5f?=
 =?us-ascii?Q?3Dwsrs4kLl4h0PtX3FQOsCZVdBe6IjmYzslv7KvuEVDkTvUeKPX/oGluHJUR?=
 =?us-ascii?Q?i0a5A+WCUkw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zT+Ba3IbTCcKNBTPDXJ59IPkUpGJIYcor+f6V9z2rgnTzZiBaoaTR6UAfeXQ?=
 =?us-ascii?Q?VvS9oCoULjC3wtBxRDzMg7udECRiIuvmAWTHrxkKG3utLdQ53ePbVL9BViyc?=
 =?us-ascii?Q?RQ+Yoq6w3gtfn41ElIzvGWlaA5hrfSLeCqfbYzbsxGiLMZxYDrl9APpnnLgx?=
 =?us-ascii?Q?pHMLs0hlHavh1PALdyOPcrHa3jXHgZuNp8+9aZXHjUMBnt5pyZ8/tQY9Y41u?=
 =?us-ascii?Q?voauhKiph1c+e5XUvKwhrJPrRPFUsfk1k/uCTn9A45/AS330QkqUl2KMNcX4?=
 =?us-ascii?Q?o1lfPjIeoNCvmDFsQ6DzNhctrmud4RvZOOb/AbGkO3ZpzfYu/MZHKVfmGv+f?=
 =?us-ascii?Q?he+/ou7EN1pPmbXl2tpU8cIN3nbTODYsLAL9Hfz35fQEFx7K1flujo38P3bQ?=
 =?us-ascii?Q?XyAe7SAVDIS3nSf/sejaOfjK/OKst8oMLzJzy023615zO/SRUYIXsSBZZvmD?=
 =?us-ascii?Q?dV6h8sUMB3yJI4dneSpDqsIiIDnamc5P8iT7alpt35uSxAcXNFQ7e/aApoS/?=
 =?us-ascii?Q?ClntyVQ3+oyl0h1r3wHrvkFHoxSamAoJ2jH/wfOa95RsCHNaMZg4fdn2vczD?=
 =?us-ascii?Q?7rv8Mu+pNdvibm5D6djad6KjWgMmkOkBlh7bGJp8sLmkUuLRqR8MFc6xYhKV?=
 =?us-ascii?Q?WaynhMr+W8+riY2kjD0ctehEfqfvlHAsB6GCWl1HL4aTQXy6fg+vZCb1SvMr?=
 =?us-ascii?Q?nJmaLPhL6ui5Z8F2GIlsmk/qWfZMYV1f4psz8MkSxhgFqpe8qVVJr2ww7bqQ?=
 =?us-ascii?Q?mBklBvCL08TvrPyHzJCdUk1NYjhCj9bS5CC4P229D1/vw5gTouSRf817+Jg6?=
 =?us-ascii?Q?4yc9tqkQgPcEuB/qpLmGQEiy8hgPng3qOYkWrhAHjQsiAMYne0dF88lVKZer?=
 =?us-ascii?Q?8RmA7hRsQZ18igREi/rI5fpgd09LxJc30LK9HHuyJbm+R0CXUFztgiyM+wy7?=
 =?us-ascii?Q?+BvqjFQz7L1tAmYakQzm/hHa+ZQdzd6jeFlgLBtQ5FggGD3tYnmmQT1jXcEJ?=
 =?us-ascii?Q?pVQhBrlhJQfHflTixL+EJr91Xh0+DJCo2fKwZvxRCyERHQT7s+gPOAECUPAA?=
 =?us-ascii?Q?b2TQHikwcVewlS9QYQEmrUKlxS0BA5qS+CqSN1JQkuol+f/K3C6fbxJQvc5D?=
 =?us-ascii?Q?zX/hAUhlBIhAR4CMZxnJ1PSagryyNyhCyKelcQepyrOYoV66UIBf7/f3GAdH?=
 =?us-ascii?Q?01h88VAWP9ol7+DkbKJCASzxgWjCaSkZ4uqKwCEOLwUjqAmvlPSoiyoz9mzN?=
 =?us-ascii?Q?EIRLLw8rdL7zXWcAEVjJmtFuaA9Wjh8Y3hn8NKwZRdU4F3FUe7GRuI5RTFPu?=
 =?us-ascii?Q?I9EsoQlv+B1QhyZfzbBVE2rgacak0dF3nrX8ZPg2yq3ZO1DHTnGYcZjmaqD+?=
 =?us-ascii?Q?fHA4U3yB2W4s64vB2c7orBsN/ymtmc8xQGzXXSAqBlSghdmmb73Y1QybeOZ6?=
 =?us-ascii?Q?Ku42cweHJJpxq9keHLD3jkzkVIFJ4AQcEW1bvkpW6CSwKqFtXYKo7xo6Oey0?=
 =?us-ascii?Q?iO38MS9UAaXrvL1eIDoG7vc5qREZPZ+0PSZew57NO0gPbCU2vCrpSrxkNWMp?=
 =?us-ascii?Q?sErU0TYUYpMtFNOwc4PFQTFTsmVtnye4ogIGbhR3tj/Vqvrezh7LUFOBIQ+K?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0eefdaf-aede-4b11-75f3-08dd9850be73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:17:51.7499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0bY0x7tDwOxanx3Z8OdF/Rvn/Wr19Vk+rxTJorxMZhO9FIz0JSoH/1vMykaJRlnVh5YXCL6B8HMZMyoSEWbiL7bcJ5M4MEz7uP/zam4Jvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF06F7EC6B5
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

On Wed, May 21, 2025 at 11:14:21AM +0100, Bruce Richardson wrote:
> patch prefix should be "net/e1000" rather than "net/intel". Even though
> patches are moved to an "intel" subdir, we still use the prefix of the
> actual driver name. As a general guideline, only use "intel" when modifying
> multiple intel drivers or the common directory.
> 
> On Mon, Apr 14, 2025 at 04:53:52PM +0800, Kaiwen Deng wrote:
> > The igb driver assigns the tx port offload capability to the
> > tx queue offload capability.
> > 
> > This commit will fix this issue.
> > 
> > Fixes: daa3b0833f08 ("net/e1000: fix Tx offload capability typos")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
correction:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> 
> Applied to dpdk-next-net-intel.
> 
> Thanks,
> /Bruce

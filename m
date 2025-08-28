Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E0CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 07:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A47406B4;
	Thu, 28 Aug 2025 09:43:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 04A9A4069D
 for <dev@dpdk.org>; Thu, 28 Aug 2025 09:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756367037; x=1787903037;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vGDN5YUe0+efX9onf0P5gjAqCbKT18CjYen61/JBols=;
 b=GMGGAQnnzqsAfsZiFtIP+QhsEdDxvIW2F7EgvX9Gke66im3XIWp9cXWt
 PUsnYowV4/ht6oeaRTvZJ633MceKTnp8kj63PshTN6Yv0VWdHSH+9vNPn
 7dfTcNvjzoIn3luOYmblqv/yjdc8L9G5Vg4BQOt7LsZATkTWNoMhPmYWz
 vZ5+KmF6qbs5koGjCkHf3hFzy9NEl3ens2igH7IimgCbKNY+2H2oS2mam
 07iRUTRcnDnztkfpLlku7O+go0i6bVBCUr9OAmJgkCKGIQUYBBa+Eti8q
 s9n6pShahhk5SpME3IFUTARmK0DhXbDqYQKIMzEAtJvvB0MtxdF4e4am/ A==;
X-CSE-ConnectionGUID: lC2MdTTJQR27Tu7wZa/qCg==
X-CSE-MsgGUID: kAqz2MIzQ92w2HVJPfwXXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69721665"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69721665"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 00:43:56 -0700
X-CSE-ConnectionGUID: D61bbFWISNy06MCNNnTPWA==
X-CSE-MsgGUID: BVLBj3k5RuqSBGh/Ds/WLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="175317875"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 00:43:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:43:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 00:43:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:43:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRJ0BnlFqn6dXLCbPj5XO2sbogUQUypDRhClAk4FB3HdT7a9jEJpvcGfSzEh0fzLDDdZ5sQ75zxwa6LcR6riyZAMaG0RXHc3zaS7pQ1s0Fu768LkMg5glrTMYyUAEfOjlo1nz9BywvUHi0YpyjiyfcFIBUKBtJCBDhMLP4HR7S9OzinUjsz0tHClQNF4oBjgzAGPX0DelUT8lR21JhTVR/vtRgG5Q9IH8ekz2ZQwGE5ReR+N0+0VAgWfnwf9LBtLA1v6ypWzX72aXaCO5eIFGL9ulfDwHfSICN7mptAOXyGltxXCLioPnJ5VN8L9mv6AJWeC2DyKxg5IveMvxCbqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUf9MdSstiZ1G2g5b2U4tqrq4yADPXHJMLT+TJ8482E=;
 b=u+gITTyRgg3WFBrdQVd+33JyR1dpIOzkjfLMPzdYX+DjtyNF1cZRMzoxHx7il+1UugoFC4YEpUbZkTyykWoN7GwfQlxQelMlB5qFu8//gsdFn34S5GqjUdULTq9zQymxxw9DMpTEOdUjIq0ZwtsxJapPDyliMBf5i5SaMjLtS0ExElsLQ1KxqQ4e9ogEOclMPTy14TGxRoDWj5Su6A0seJr/dDocScpLxP8auMVnlEgWsH5KkEGRYtk0O7fwGB088Fcc0/xK+xeppE7Ze1WHJLMn95NYzFWIg2vgpXygQChsT1zZQQwU+AK96xhgIlGXf/j7shOsFlInU254NXNcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6787.namprd11.prod.outlook.com (2603:10b6:303:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 07:43:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 07:43:49 +0000
Date: Thu, 28 Aug 2025 08:43:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [RFC 3/8] eal: add macro to disable shadow warnings
Message-ID: <aLAIsCkJNwft5Gg9@bricha3-mobl1.ger.corp.intel.com>
References: <20250827231528.236172-1-stephen@networkplumber.org>
 <20250827231528.236172-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827231528.236172-4-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P251CA0029.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: c13a7a1a-ade0-4c55-3f61-08dde606a03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?igoB99s5mLK4b5+Ul7D3T5yOmzn8ziar8l8N3rQbH9jFPtWO4uuVuNc8UQ3E?=
 =?us-ascii?Q?ygWuKpNtZnl26RaF7uNklynAMHt04tG4NXaY7We58gsBVx8eYDs0Y0ANyy26?=
 =?us-ascii?Q?3b3eibBeBwh4PVKyOalNJ9Ibt6lDa+8NAINaifOtmjHyC/mJ/aDZw03r+DUL?=
 =?us-ascii?Q?0LbfKUSMvuWMNf9p7J3yZOs64EzDJSusUpH3Xgzpat8LD0717Pu0SkR8KuGK?=
 =?us-ascii?Q?P9jEhbRYpjPdHWMaFhlIOdUP8kqDmwbW6R9a9QCk6QtdDkCmEZLbtR1TRwjV?=
 =?us-ascii?Q?nmKfMsQVjq8vYcFrQ6TXUTkJykfjqXy4t5sXSuwUC14SYRQ+IGYERQDj6mst?=
 =?us-ascii?Q?KwjiPJK63ujbCXfNyNjK4SnuDALnSDGvCD9Kgjy3OAvSxOApkqU/0pZH03g0?=
 =?us-ascii?Q?B2mLyaVAat5lVR8v/EyLs9hbsAsX8D6AeKiEALEEe3FDWyTNiN6XGiBRdeG0?=
 =?us-ascii?Q?R0YQIctBsF7W7p2fZMTapB8UrSGRAjayvHab/eiywU9z727GPFxTAYnE/m9Y?=
 =?us-ascii?Q?kHzlxHT/JbzkP9K47yBh6ZRMgMYxGK6B6CLozzCDw05XOJpOqkT1eSl+1ftF?=
 =?us-ascii?Q?leI7C0BeNeGDy0+HwMLAwYBjKdgIM8Mxo7fYB71Q9NesWG68J8MofMW+hBMT?=
 =?us-ascii?Q?4XLq0lP7vGynE5hcS9WlqCQlk1O0b1fozX/IbPf8YqjnMlIlYOJkT0xlvbW9?=
 =?us-ascii?Q?wtwKgDqiCYEpTC0csjQuEB1HtguPmDYRlzdlU8eG1tmfK77AE3LN/ROQjY5r?=
 =?us-ascii?Q?c4d38mcv7orhHouUZ5xyCik8k/eH2Xtxx9Olz+k+jlFBFSHnwjHViG25UwIj?=
 =?us-ascii?Q?eGrvEZKVBX+me3X5czXJA3Vfmcypa4ELcOWpS9k3Bu7/G44q9vz7qq3XnmmS?=
 =?us-ascii?Q?sQ9p8xDZHW/54rt+vcNj7iat4me1uaiJ6sAY0diw4FZ67nOnZNu4NkyaKoY0?=
 =?us-ascii?Q?n5S/tkZtn8FiT1VLQV8FF5NsGPoF/ek6ITv+2TMHm+jSEujS45HzHFbKWCL7?=
 =?us-ascii?Q?uJ1KcLsCEFawjHmWb7L/gl+PVT01nq0V5McLNUWi8P2EO/3RnUHMd0qXSxkT?=
 =?us-ascii?Q?ClL2JDZ0CKnDABEmW42IZ04vZAf+ti/nAGaGIrDlO9KBdDfQl1m4Cqtb6GpR?=
 =?us-ascii?Q?sr336UjDstGBlWfC+mIL+anM965nUr3v32gdElHFOYnm/CGaG0sZqID48mGp?=
 =?us-ascii?Q?5TP0OEO3vHla0PDE/QzYLgNYnnk97Sk5hp53UAedV/9KGTCHjgABW1Xv3h+k?=
 =?us-ascii?Q?fkRGv+D8VD962DKk4YYuTt8UT8mQESSab7vTzfVZ6Y55RmiEOeiMfvjzE4z4?=
 =?us-ascii?Q?YcXiJDhEdBklmg7n/9HeL8deVixhHOfic8ILCwHjnlVVEZ2hoB+x8C0QSdU6?=
 =?us-ascii?Q?tQdLEzwb5H498/tFyjpqi75UpM4vv6bETWFTNUB6xxglfORXgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2bw/l9OcJqzUsT8K6meCaI0M5/7XbECf7X5LeZcf+MydFlQQUC5+t30xQvk?=
 =?us-ascii?Q?TH3/n9FBFdhimadDE+AO0M/sgze/ZP/KLYGdTka9+v4Kv5K3cvJAYRidiNUU?=
 =?us-ascii?Q?Q2TOn2swUBsnK79FJbIEJnSPv8nI3icea50LXBkBLzomE4TIEMIv4VdZBukq?=
 =?us-ascii?Q?C9OlFNH4+VMnh9T03wVA+QQotutZ6A75+HRpwIDgBPqdPzPbG2LRfhytjyH9?=
 =?us-ascii?Q?xlSQyIRyzMW1I9IHSuYKiRY0F7WQAbJhL4R5L5/tHDubFMXyqmtWKeJFXQuX?=
 =?us-ascii?Q?K/DrPQSV7to3izQqwQMqhx0NYIFt6TolV0xnYtrGwDUKgVSIj53/fPAJ7DNB?=
 =?us-ascii?Q?LVcC5Iy2reaz3sxVgvGE79cvmWKLUGVnHkwNRKFHQXS8mdX52Z0lUSwBw0Pq?=
 =?us-ascii?Q?2amsOcHuI8c7QgkUAzs5jrwuPp5VVkSVv9ZQAp8LEl0tdi+cjDd2eysWiMQT?=
 =?us-ascii?Q?7DPHTqoVFARc2eplXnVRa7t74tTA9dJXikMMRzDwcS7oIBULAhooDeRPmMWK?=
 =?us-ascii?Q?o8Mz9caDcJZVQbDphvpVco78ApUBgQBpgdouEAVENXwVNUHExiUgNlTzO3zS?=
 =?us-ascii?Q?MDdsfMeocTXp2PrtgvjhguJnErDiRQLNTRkDFONQBQbwpYnnSU15u9pPKOxt?=
 =?us-ascii?Q?jucFoZak3EwhQlJPTirN+GARKX4B/1nTTk/Kmn/eRbNlVMyEUpzH/E3UodR5?=
 =?us-ascii?Q?1YlTJaxLAWz4YMUufRhfvNaa5IKCIO0QNPr91FC3tfQIxDDSYN/0Pxtyc0GF?=
 =?us-ascii?Q?4xqLymOM+gCbaQ99ia1fzlF8+d2ygLpTRGl++/KFma9CoeaDaKVBdZxtdqu8?=
 =?us-ascii?Q?q7dWdkQBLSEa1HGQIOUtWj6QIpgoNpzuzMNofVZGqIYgXQpJVYQ5MQWPo+1Y?=
 =?us-ascii?Q?ASQOQdJ02F1zgaeyB2M8dvOrRHxYhWwuNhxiVEvZFtFSPlnnNTkTFmhJEcbs?=
 =?us-ascii?Q?ahHVHIlnAJYy1HKi4o7YafwK2lQO3n+08okc+c3s5inmR1c9ErecRDdBBNLZ?=
 =?us-ascii?Q?kizBcN3WSuRkbwEeHccTc/kcfkbHdSubpWWhp30uxGwzTHFIQiyL7sUiq9YX?=
 =?us-ascii?Q?LUlR2nPZIERHFFYcjJSkFChNkL2dfUWJsQexsljgeMbIjQ2D9NzYEE7DX42w?=
 =?us-ascii?Q?B2qLjrGp3D46+w7FP/0MU2bOZXtcjDyxxSfLBua6WARYa7a0UmfQ4vz2/SwK?=
 =?us-ascii?Q?IU1OAqAEZKI0bTYCReg9PywHEYKTq4KvxcpESwekKQtmHdjZQ9s9VIOWeDCO?=
 =?us-ascii?Q?06NsRM55WoR4t0YmLF18QMNh/J3o+nOufdMvHEFwSvqpsoAhFEgJMmzrNADI?=
 =?us-ascii?Q?9GgxilXyGrOJA1OOYwHkBjQIRuVmDCTgr4fG29vlxCNfRdsioR5yvBAFi/9q?=
 =?us-ascii?Q?JEIvElufeKrY64v2n/yf0rC56L9nB11KARLEInbRkuySrUhqAsCg0RhmL47+?=
 =?us-ascii?Q?gW2aCqJCRUija3IAns73bmV0ls8G2YGY0sDH0ioIwhpHtgsGVOgbBfl/9l5F?=
 =?us-ascii?Q?FRDQPc5DEOgjcv/jl21/T66RgI0xb+mXg+DN/flXZR8ynTpMzNJbAx908kvb?=
 =?us-ascii?Q?AM8iOOaoOnY+oIaohCqPc9clDliRez8b7sybZwTwHQDoqFCmtBUYR4Npys4V?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c13a7a1a-ade0-4c55-3f61-08dde606a03d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:43:49.0773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SZFyxEObQf/DCsEAoNPxYU1OiLnZY2xVPE5+l1V0gyL2eRtFNs0BSQf4icID1uxc9o7hPlh6ZQrQ/b5BhoR/ovQDvydP+rQ6F8gE0kRaU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6787
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

On Wed, Aug 27, 2025 at 04:14:06PM -0700, Stephen Hemminger wrote:
> When using constructs like:
> 	RTE_MIN(x, RTE_MIN(y, z))
> the compiler would generate warnings about overlapping definitions
> of the variables in the macro. This is safe so add pragma support
> to silence the problem.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22FFC71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 09:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C658A42EAF;
	Fri, 20 Jun 2025 11:23:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 934AE400D7;
 Fri, 20 Jun 2025 11:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750411431; x=1781947431;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zt3bfJu74W7cuxkNUdLI8UO15QyQ/UvG6ErR/C+Kd7E=;
 b=juqZjHQ1+WMXyR+E/nLPpjolZkU2P5efTYxuRDSKEEtDTz/kHtxpqTzm
 LK+YqPHmIBgT1LkmG9rvK8hUD8ywSzX8gO1vpNDqB+QiFzL8RMPqvbX4m
 TY3JXccpPTZ0SnDN3pTTdoFMQvbDys6RxlN25OyBksqaGaMrdc/uZDQoe
 m13Uxu/4jyX4h5c2Zs2qZ8dbKyp7q7UuyhyS2rFqNpv+2/j4zVIkxyQny
 f5/uKtzTdUHpQuZshUSnDPS+dqECnUfM5xsIK9Pprm1r17eUTcshFAtMa
 GEJgbMVCfU2N+D7MiYrCdd14G+K42w1iH5r2hUXyWQgzUwzoAOJ9HkiW7 Q==;
X-CSE-ConnectionGUID: FI6r6AqeQMmCEnoPqK77yg==
X-CSE-MsgGUID: XZvdjpTRQGe3Omszi5eHAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63719073"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="63719073"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:23:49 -0700
X-CSE-ConnectionGUID: OFJ9T5nFR5mWfJJTJqm+wQ==
X-CSE-MsgGUID: VkEU8EC3QLqr0ZstxTtOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="151072179"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:23:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:23:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 02:23:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 02:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCwVBdXdJBbwTChO6arNs605w4YsyOm1OeO0a638MXIQ6jvkQc6duB6SdjX4k2L8fWBTZvmqhELvyMmT3eHwfLDzQGiUlLubQbjEBRYRtCGjidCJBsTsNYR73j0rC8Izwr5PuOY2t9j3KZO49BTd/QpOvsXFttowtZsAf4USqVG7jsLy+Tw1Dc1K6uRXjQ8U2PUc3eEs8q4H9kn1cbfWXznmTTNGkgw2w7A/CpblIhs9AJem84R7A4+ysUaSY1hjJxshTJSFPbcP/sKUBTuROvfpYYi81TdKUPJ1Qu+nKagpj7tYuCmjE8FCSD6Wv7922nVwWGYLow8+0hpjqw5zTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwzGJA3DbaQz15IIUKYjmmnQeiEo8UVMcN4DgDvG5d8=;
 b=fi6cU8Hq4AZa+A1YX5C3mP+JWwnaxyZx5L42L9C+fIFU/CCu8yFUqjLhAr6kBhY6dP4PXjAbvfdPHCnU2Bnmk3nD6XY6bdUQV8JRtL7ZpdPlb/skWdaNwz5bHfaDN4abNdLS6P4PKaajvDxUtWUjTb6qbFkOX4W1u/5UZOijidL5Y4/x9EHlLSlWB3OETnyHArpn0Ftyx2aiWvOfyEpIJmIXb5FixSO8ek/ob2pBvCTgoX4Ch1PsILzse0XEGXocDE21PqN8hf4pu9xAtCPyFyvEADxs/VpM2psi8IquIK/3/01UjPiWOFPDDxWUVbYPE25x6N75YK2piO/5A75gbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 09:23:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 09:23:41 +0000
Date: Fri, 20 Jun 2025 10:23:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 07/10] tailq: fix cast macro for null pointer
Message-ID: <aFUomNA7NI9m_8RH@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-8-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619071037.37325-8-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ae2319-955d-434b-e3ca-08ddafdc25a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ZL9jccD7SdeMGNbAzKKouH7vJw5suUwsWCRsGmKy146eR9voCf09efGXj/U?=
 =?us-ascii?Q?vp6cC+c4/F6+a91YzD6daf0jNQv5XzzZ/AEzFvVNgl/6Ida2l3704eB3c3lL?=
 =?us-ascii?Q?768kqRT0+CBLIK7cBg654d3nL4Sa2WpWUoZk4RsLzUbLLFwHp0Jdpaf8v6W1?=
 =?us-ascii?Q?osVQsjF6U/zsyl9xMb/5ItdOuoy/nHAtW8LiPusiez8U/UvQzWFiVLFwNRDJ?=
 =?us-ascii?Q?WBQtXyOTcqMQCBBu5efLvzcFc2hDAm2n04GbUvHcy4KB3ClNof6dKxA9E0fQ?=
 =?us-ascii?Q?BWh+DcMYIh+G0vuBUcTfCAXHwRt29d0ixtImkZN2hbaY0lb+XWR6pwLMZWiV?=
 =?us-ascii?Q?0+nPU34wFWWYiyeqOFd/Xzq2vZ5TeKTQ/+9dOdPtNcdyO0jCW8s9K/4mmWBT?=
 =?us-ascii?Q?1P9nCKaaibclx8OzKL2EbNZbiU4/ZPJeqWx6riFKGFR/MlRuSyg7HJSLUaG4?=
 =?us-ascii?Q?n87ePKCUF6fzBnwksnlmK647SeTEhy4WXqY/VsapG58vKIOCh2CT5l8SDW8f?=
 =?us-ascii?Q?SgLZrtBcmLQhG60eKYPGESB7xO/OVYYpsYopkK8Xv48yJyi9G9irTRhbgkG3?=
 =?us-ascii?Q?/W1gvKF9hF9Y1T3TYVMzI0PgxEUHsOcWxAGYVibE4bdPbmVGpvBKmwt6zn+Q?=
 =?us-ascii?Q?uyCf3NGHGsUuVd59HMcl1FmTcOWfC4ZcovVF4Egt2j7n+VXyj2KiHXs82XOZ?=
 =?us-ascii?Q?k7DvIO23pd11gWoHqY5LRSUUhfQvUIPUyLM1C7wkaeRblVLOeS0PretmK0q3?=
 =?us-ascii?Q?yRgHrB4+0D4zJQzzHwUF21Ei72cc5WwT838yb5TVhPgwXXg4mohRr+kQS7VB?=
 =?us-ascii?Q?M+LtwbJp8o+lYBRwYELGo2S6q9QMavXrYQGCU2sn7bQnOdLOTfqQSw4h8/WT?=
 =?us-ascii?Q?MI/TBhAh3ODQcdy3+rCJaf3s33MdaonQsFKgjwkWLxE8+X+m3RzqxRIPai6P?=
 =?us-ascii?Q?X4QkOymZZH3RmAxkbDxXr0R1XBlauqE7OBVs5OFYRYity9QtR/DUEZKV8roW?=
 =?us-ascii?Q?SnFMVfqF3wLrSA4ojymqpZXjHrwsFzwpdSXG7nOSv1BiE46AHIUsggOaBjBb?=
 =?us-ascii?Q?rYIwsI/WhLdYw/jFRPh/4QjimOgvJlsrvLoHIDnHh15YU52FZVfHbKPjYSA3?=
 =?us-ascii?Q?M9KKNblp0YpMJUuLX/PRJiP6jTOxJXOwp5Nx2EyYu6ypUB8l8+AH5S5/ahEJ?=
 =?us-ascii?Q?qnt0EPALlLtVSP8aUqW13+d1yiFIv9TTTiyThLPeMK4te+ZAxabCO9VdpQ1o?=
 =?us-ascii?Q?30B9Y5vlAJtBPO6MuuPU9r3gsMvnXM9DuAiLvs2gKSlnICdOrdBqzimc6mHB?=
 =?us-ascii?Q?Tu05N7Q+dWQIjD3I/siN4s3Rhbax2/57i9bDgW+4Doy8oet5cotAJQf5VlxI?=
 =?us-ascii?Q?HVn147BL6eil9fw215K3rZpel9t2KdwgVVzkSeKncDKj+KTo+iD0xA9WAo6p?=
 =?us-ascii?Q?9aJIv3NUvro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1xUIb1aE/VCe7Fp3vQcuMPWR1Qp36VpY2TPjmlrbry1Zr0wAIsC+j31pD8r2?=
 =?us-ascii?Q?lGFazy1t8m96HpgvIxmteJJpOaKqTnDdNA5SRU/0mvEG6rf0qnJTEsPhRrvK?=
 =?us-ascii?Q?XEmFXmZ9uw3H19dfg+1UsSRXHWsQiyfcukdke6AEIWyJoB0ya8LOuuPrI7Cv?=
 =?us-ascii?Q?tywnEJILGIqr8WTsIOW2FJIYRwvh8IEx8wdtxH+VtqS1TviejN5M8kmSNPDH?=
 =?us-ascii?Q?bn/6eCqGhP/qtRHiJW2GcksYbhQIRwZbQM9ljZJtAb0axi4bsO2saA61/Z6e?=
 =?us-ascii?Q?dcdaN4bqZ7CF7NP47RkfLvR5dySy6rvPytgQ75S1rFQrMBP7e9lzr0NJ3Rhh?=
 =?us-ascii?Q?KsomTqmrdvOE+qjM5cafR2yEszBNiKA2IzIHWdyosZtkt41Jm8CZPI2zh9bu?=
 =?us-ascii?Q?rdQdPo1eoK8dEpm6TR540XJzBqOOMwA9snXDPgm5hS1qg+CzqQOwPcz8NeRk?=
 =?us-ascii?Q?oGyV/aTwS7ZfN85RTKdqt68eKqhOz+cTmUKsJdoG6h2xVVHbC+USr1QNiVk6?=
 =?us-ascii?Q?W4Fg/sV+PONZbU7XtKgB5Bdk0WD3BgeZYTK5SON7Zfb5n4bGWEsEQUTaLzbh?=
 =?us-ascii?Q?+UOhEG8+/hBPiBN+TPogs8OJ+9GB3oaI0vYM/exEY2wwDRBIlw7wvhMbb8KV?=
 =?us-ascii?Q?vs4AJahVe5ALM0YXpX11MqnVzt5zaWlnpyYJcvjIkHgIACRM1puILz8VthiM?=
 =?us-ascii?Q?s9oR2DUK9TbCh0nqLMZLIUzW3Rn1mPATolb/pqvAod06Cwv93dBkwHEmVMkM?=
 =?us-ascii?Q?oX7j0aNW1Mpuej3fzgP7ilUB8zTWJ4p6PitUZxJKPDHlmxNNf7X1u/K/su3z?=
 =?us-ascii?Q?sndwlV5XnvCYAKXFj/wAecrcJ3AUw6KzMU4nJmyiGSXpsXHkFMTRBy0P1n0Y?=
 =?us-ascii?Q?vLFAAztaPywh9pmLO83ILFfsjoF9SWuEsrVS8gjU9E6aCwyOKnPUSBUluNoO?=
 =?us-ascii?Q?91lAzV4/ztiXB+72RAJNbbknNmnGWnk2+tGZ0tuHV/wlZ+zOVrzu4ow2ZvEY?=
 =?us-ascii?Q?3iJEeYOhF/f04UqAb4X6/Y/0nshDW5Hq3p9Cmp22hb876PwwG3n5V55wYkMj?=
 =?us-ascii?Q?zNnB23oz7a81iNbyDZ/xKqYw0Wwv5HwczySvavdkFTPjVAg6sM4P2nfeMg31?=
 =?us-ascii?Q?paEfIkVGgZV63gySqqMciFiSLKvzzjGk9ZWhaZ6hxSvCgCr5+Xvb9sNk4Gl/?=
 =?us-ascii?Q?nhCLybQWSNXusXjvQGJ3IG+iTt7H9h51nJXKh/G5nPFlsMTtsXPVzOL273ex?=
 =?us-ascii?Q?JztHK3JE7lWpOwaYdlB49hlt8WRYYLIbkBP4r+RZn46DzR89zrcmnipVwZk5?=
 =?us-ascii?Q?jm6di+vbotHbg8OWkVteWlOqOV1lVcZMR1yJlmVft3oodXUnUwju9/z+zCpA?=
 =?us-ascii?Q?JdYPyDOKjgFZtPxgECT6wkJxKlJ971OEGRc6+RRuJT0S/PcW6XXDK9Ij+X9m?=
 =?us-ascii?Q?EMuXo7nQcZ21wdRKVjhT+DJmFesVN1/nURDrTboIsX5H+h6jchj8S1ddMekD?=
 =?us-ascii?Q?ddOMGdpNIkYhh0FoCcFoAbC0phFait22HdVnqmq/3RrCXFTMT+z8V9O0Uwcj?=
 =?us-ascii?Q?Frsz9sh6EjZyFHDUAMNee9ZBs5kG+XpVMe5LEj8j2ZksTSRbGF847IgWVTlv?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae2319-955d-434b-e3ca-08ddafdc25a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 09:23:41.7214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLmKy2a3UyvoQU5YYPwfDrW5VzJzLSr0OG9z6xltNsBydZAJZojYahpcgUwvIZUPXupNQU/d91Yu7fb+acQnpECZZXrBtceztoSK7TZn/d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
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

On Thu, Jun 19, 2025 at 09:10:33AM +0200, David Marchand wrote:
> Doing arithmetics with the NULL pointer is undefined.
> 
> Caught by UBSan:
> 
> ../app/test/test_tailq.c:111:9: runtime error:
> 	member access within null pointer of type 'struct rte_tailq_head'
> 
> Fixes: f6b4f6c9c123 ("tailq: use a single cast macro")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

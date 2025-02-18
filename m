Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C16C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 09:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8A92402A0;
	Tue, 18 Feb 2025 10:47:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id D5E8C4025F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 10:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739872032; x=1771408032;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sH/C8nivlyn6tef6g1SvBvnw79ydB2suScb6UW/IDyc=;
 b=hccXwEMxxlKqYd3efOs/1UfX9xhnB2XV3xJglMwPXDkrK28eIqz+t+6X
 ZDvDzbfun4X92qXUX7Ns3DUdsabSSPwb8oCxvyvQD7xEZKo4dyDIMdy63
 bE9GdRq4lscHH/dpc5NNrfJH0BbUc9Oj0yDXZ74jBzOLUWovHosOA0YI4
 sBXIEWNvczdGD+0VtANoewSo4v+wKLn9KPJzWC+cneiu8xrOSi4vhfR+4
 UjACe61YOOaE9VzSrfdS7W6d2m8g3fyqNTZ2mRK+uo9HgOV0oyGrbv1iy
 4NztbKqFdj8ZEGugNhFwV+CQTMZpbIMwmr13zwPd/DlKA2AotXngooR4S g==;
X-CSE-ConnectionGUID: nQ1COFKNSpGfafiucb8jgA==
X-CSE-MsgGUID: a7OTnERzRXKZ4PXWvg2POw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44484725"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="44484725"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 01:47:11 -0800
X-CSE-ConnectionGUID: WfiQrZjiS26L/B9dCutyTw==
X-CSE-MsgGUID: Tu2TE9P2TUGfeJm4ZZ7v3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114997376"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 01:47:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 01:47:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 01:47:10 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 01:47:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfcGqdcKV0iPSO+0QDBk4WET5oD6hv2rwxqQut7HYkml3rtwujsT+uLwchAujkajpWnAtoABJ0XVHcHiy40LWaNBRnbqVAgcrlnucrSsCH6jlZ5r1YUwG2zIlwmjH65ct9iG62TLmP12nYuiQIdTbv+h4Zcc+G8EPRkaWOKGEG8BpbqO8N3ymgt8fdzT8fmyA1X73fAGYmLPSBpNy+6VP+eXNK7f6kg0fFgoSORPM92pnN4//Il+cnFArcqsA7DmmeKhTEDifmNFTunedLYiP6Xs1DlD3nV9bI2M7zK7fVmS8RZaM5Uvk0Q8jm7eWTDrfSY5wjZ0vG5cbHtnA9eMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1FX+9Qcxx48VHxYTrmHMLTjvxkE9ZmNr2eyIN8NEL8=;
 b=cdfZKYrHWkUbUlZzuH6qe/4UrnPe0OfGNVPIxuINQEWE3Ccn09AhKzU2LQ4g7k9HcZBSbvqQijnq5vRvfxCww1V3xfY+YU2y15beO4Br08WTbqiNSwO36eWivPTqy7ptWhFykTljOBMEwOhzCmRuToF5uZsunSEdzc9by8qXoXDVdTHu+YKNBriCigMR2efTBs63gWdBkCBffZJn7FQm65FaVhws+Cy0teF8DD5VDfj3aHq+UsPQBwOYhq8nDTMaQOPPbguaBU+HzyZKGWWm0MzH46w5998TrLTk51AwsKxQj16PgFrgF0pGKA2cFvhO79FjCnRT/l9E8+YjLTY0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Tue, 18 Feb
 2025 09:46:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 09:46:27 +0000
Date: Tue, 18 Feb 2025 09:46:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] usertools/devbind: add documentation for no-IOMMU
 mode
Message-ID: <Z7RW7fTOcGVP4RiE@bricha3-mobl1.ger.corp.intel.com>
References: <a1a8fce7e0eb311e7ca673867862a549270f5450.1733132101.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a1a8fce7e0eb311e7ca673867862a549270f5450.1733132101.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR06CA0057.eurprd06.prod.outlook.com
 (2603:10a6:10:120::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d7aae3-69e8-4acd-12e9-08dd50011d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v5sgpus9OC/RaR/jgDU2TpZTEWgKh+Phsik+8siMEeA8/Qt8alOpWiER6lZB?=
 =?us-ascii?Q?O67AAOf/iqjtyiS8ypPEm478pF+BTIq3WZ+NmVDqRIb0BAtV4+jy26EiTFGT?=
 =?us-ascii?Q?2Vy96ULOpkmrde+DkNw2bvWh/k/WhEjsQuuOtdQeUwH9LtXOXHy24cQOmrzE?=
 =?us-ascii?Q?R0BnerhHNvHLQlhlzg8W0mboIyTR9zj8V/xOp9nryXe4qjcsMo/NAQ3iqWUZ?=
 =?us-ascii?Q?6GkSpe307DBG2yWRe8Rei/rBf7kyIZZCmZ5F/7b3kslMJTOdzuBryGwugVDo?=
 =?us-ascii?Q?b22KtCsZQbr91wmKo4LOhxMvm0afLIjY/VOvNLsj0Tn0XaV4nhGz+lGx/yIQ?=
 =?us-ascii?Q?iA1EIfNUbqNwfEgsGR8QacRzcodRjPNM+8PZZiRoA/kfyBmekvswGQz327kT?=
 =?us-ascii?Q?RM/XT6Oa7ebMav+/4x7HQCldvHZt3aEykcYuHe2j38PQyfXIqy5Cq/xOFrXO?=
 =?us-ascii?Q?ge42K6G7l7BmPWmqdNobZ6YW9yZcMfcA2E903STLTtP54AhXC8iSxI5NILNJ?=
 =?us-ascii?Q?EqLA0DOLTkT4YvyQS8L4FOShClNvQq/LWTjxF13yHnUss1gMkuotTVMWfvl2?=
 =?us-ascii?Q?kvUmVIxwXKPAAK6RQdNyQaou+A9EpgXo7W+SQe0Qi8z4pMVGIhRWdMrpSoqD?=
 =?us-ascii?Q?C5jE671AdhWsF7VmjamxwE3pSuJbSInGpb5fHM4ahQGbPfr4HNZw3K6ujQVk?=
 =?us-ascii?Q?axtmZz2KJgMmyO6vgujlOdnIuc9RDyOx9egIUQgwxFeRo33sSvwNMxL18M3u?=
 =?us-ascii?Q?9Nq7m2LQ95cKNCpZ9K3ppyQ8I7buNEpwoYvP3D+cF+j7UPZf/Z+T8vVx121B?=
 =?us-ascii?Q?+gweDra/L802Ycv8FenJ6Kkmuc5VNgvjyVl/TQ1clwQZa92SslxZhTJm2gt7?=
 =?us-ascii?Q?L72Dj7zPVjct3KTwabNlgYni1+XVfMvWoIMVcFQ9F+EL8hNvZdBPQ1XxMQv9?=
 =?us-ascii?Q?nQ6kLw/qtTb3OT+gCcLkmyY/TmHsTv5tCwrLyCQp8fVE1TeLXaRTucV1woes?=
 =?us-ascii?Q?7MTUbncg7DM/Vka9zH8ezB8G+x9uhtMbIyXecE+vlyIUr/jgMkXN1wGYYTAg?=
 =?us-ascii?Q?eRAT9BxfI5Y0KyXdDcQ8HAc+Ks3CXcmutQCyp+oCbvu2PEFj+KPa6GXX/pIp?=
 =?us-ascii?Q?zj5Gx1kdvg5WlqWTp1A3BQh8twhR+Www1wXn8rNQB7HI4nnnZK9O+/WWKzVl?=
 =?us-ascii?Q?qgw9GyKg7rD8D3bZV+bEW/x9Etp1hpa4Kmv0T3Dock9sW0EkUWLjAaRcTeLv?=
 =?us-ascii?Q?GWkdDUaTvSlRHWpBQsv4jVllcvLSKfTYzRthZJTv1ij9z9fWVzCzcosxfYaF?=
 =?us-ascii?Q?0l8hQNDxyyPYuMl10BSsQyMb/wDZwjf/BixwxaGw5zBu6vo8996e29Zal02R?=
 =?us-ascii?Q?3PbPiDEQHcVcqr8b3QpSsGJ3gPXV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fxEnsEplCS3mCWTceT6LCJWcQAgnQaQhldrqs9Fh7drD8kfSb6c2zqS8l/l7?=
 =?us-ascii?Q?qI+n8O/Orx/SepDMxbNrXckLyyAXIc6gTA4gBqUJY3fVOPqsZn59+0s6WmEw?=
 =?us-ascii?Q?fB93MXZ10wg3Y8VM79/YBel98t635iy7EHEqYSQ1MtCpsKKpsjPV6yWR5XDM?=
 =?us-ascii?Q?rADXHxF0mdRg1uk35te08W//EJ1c6d/dzRWJ5cxWB5CNK0IdxUdWPDo/Wfcv?=
 =?us-ascii?Q?FhYw4tZB5nlUcZzu+ioq2HEVqpQbdb+r4i8UgEvVoM+IV2qc7BjsgPZTNG7Z?=
 =?us-ascii?Q?08r9wxiP8NbQlmv+i4bLxVRn6LHQTgCsSWxRIIoYzeF3v2OF07XbpviG2mNm?=
 =?us-ascii?Q?7+EOmC/4DC0p0s90hVU4+wI9MLlUdMbSSJjnU1YlIYRzz0S2Yior0jhPjH2S?=
 =?us-ascii?Q?6fm17eyS4zIyyu29L1+4TlHnu7amcvmFrZaSMbJC3tHY87GjlitrfOK2rY82?=
 =?us-ascii?Q?5rTxYYeL6sa1IsL1z7tNefRlq1Xq9lzf0P+as7OFTaf92VlqGNSS5At7v+5d?=
 =?us-ascii?Q?rJXxfO3Hwq4U+AaXm7uvA23O0J01adi2gD4wp4VpwEWEL83oHHTnyMRV4KoN?=
 =?us-ascii?Q?XmzC7/RdRFKgOEgPkeHwWxpgaR/q49wfIoIHJevGahgi7M3TXko0rRWsnu9G?=
 =?us-ascii?Q?cLvQ3kR9ZEqIWHcF8ep60218cxCiRc08R8nKxF3IVveVUXbNDrqv94JPddeG?=
 =?us-ascii?Q?g7ySoEgEWmUZlVPd6qo5fJYJOiJVktH8C0Q4ogObXLfazTeEpNqD+B85Z0/9?=
 =?us-ascii?Q?N97Af4C7n2xz02f8FdaD3aRwHChBwsZKQpwYi9XCNsYYQO+3NXRJuWvyOh2f?=
 =?us-ascii?Q?7aOAxjuCTyyopRUOcDQMmrhHbKf3khpMZbIxon3E9xOXYr36ionxdTOdwcbI?=
 =?us-ascii?Q?B7MXtmJmkTWgmnHUD9k29pnQoDmTCzGjTb/4P4wJK8S83dE9cvQw5e+dCbX3?=
 =?us-ascii?Q?yN/HgjbtI6hq+6io7CZvZbq1VRnMSFvkV42taa9xWL/04APqKXDJTOgzHbZO?=
 =?us-ascii?Q?6JP6xc1U4MUiHU/gf6C1XSoTc0w4BaX5IYbXzDQSWUX3naZ69Uoyxb6qJORh?=
 =?us-ascii?Q?tt3N2+MzZkTdcixZZt4L+y0heouEpwBzjlETLnQVCdVwd8P+xH1+fr1uVQwi?=
 =?us-ascii?Q?JIqmtGfV9kopZhQ6WIt0jXt13dY7CGC7KNr7hIUqXhnxmbzwmSB+xQfft61E?=
 =?us-ascii?Q?luldn0iSqRunnvW4a7YGuSSAj3+YrALf6o+wmsuKPv1GQNmXIedrTMr4VQl/?=
 =?us-ascii?Q?8sUlMn8EHwIJegXzt4IU3xAL5mkEu4jLsYf1y+ihccL/5uqTwwRAVQgsli7Q?=
 =?us-ascii?Q?dG4DRawKdtQBXGQfzKzJlo+jbnYo1VMRZDACxAsTa+94tRZ90RBxwCLKzk8s?=
 =?us-ascii?Q?mu1304i8P9hI3p4mGdZt61UvqXo9bLDOeiJnOO9KIUB3EBTu634RApCoiUBV?=
 =?us-ascii?Q?jQMFLQQ6a2geB4f3Myc7Ypks4Vwvx5fS11an4peEyTJONtJkK3ZzaS+H+Nxr?=
 =?us-ascii?Q?phvkuR7XoNHI2DnW/GVOt1ogHnHB1DKEVR2iMoZ4DuY5XdL18tNkZJ5d0jCp?=
 =?us-ascii?Q?lyy6XxJbujJvxwuBt0pRDBu+R2w+xo3yVmASkMjl4xzuDX56dGxCADg81W9A?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d7aae3-69e8-4acd-12e9-08dd50011d2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 09:46:27.2174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Zg+fCYbR+iy+IcVjlzOogEx7QJahL56AX/6sitDDoZC+LSlkZnU8fs/iIZnFiq76Xd9hJoMu2RRVAdq0UiPHqFAdMS1xWjcdw/uEmElePo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6102
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

On Mon, Dec 02, 2024 at 09:35:01AM +0000, Anatoly Burakov wrote:
> Support for `--noiommu-mode` flag was added, but documentation for it was
> not. Add documentation for the flag.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  doc/guides/tools/devbind.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/doc/guides/tools/devbind.rst b/doc/guides/tools/devbind.rst
> index 841615570f..e010d4b7df 100644
> --- a/doc/guides/tools/devbind.rst
> +++ b/doc/guides/tools/devbind.rst
> @@ -62,6 +62,11 @@ OPTIONS
>        Use this flag to change ownership to the specified user and group, so that
>        devices bound to VFIO would be usable by unprivileged users.
>  
> +* ``--noiommu-mode``
> +
> +      When using vfio-pci driver on a system with no IOMMU, this flag should be used to
> +      enable unsafe no-IOMMU mode for vfio-pci driver.
> +
>  
>  .. warning::

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


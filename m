Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18952D5E146
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 12:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FD28402AC;
	Tue, 16 Dec 2025 13:06:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0B0284026D
 for <dev@dpdk.org>; Tue, 16 Dec 2025 13:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765886798; x=1797422798;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2ytQh+G9JihIb+BzX5RgTrO0hn0FRIwKHeLhlAoiHzo=;
 b=h7njZbOhTY0+owEaUbD04ZrusvdkeO/M5NfScoBSBvQ7Ryw85R+bxPQA
 wYcguBBe41ovWbQi9QE6tfBDS1QEtPI520+YrF5yjoWZafAliPydaQxMZ
 nTfVHY/p4GrRsbc53lIbMYsm2oHWHVIpelmWZ51In/UtK6aqJXKJ9HI/X
 lwVRRDo3pAVqqpfn2VGgQSStzWvmdzMUeuFKNu7D2EfcpQY/d1bRbn5J8
 vyei6usscJvZM2nYO2hPta/s7iSxpzbRKTTyCkqf6ISO4B9tKrD/oWT6L
 d4bBIwAx3tT7x8H8HoE4jyinwaiaDmT3jp/WoAQNVfLWdTOq3j28pnGkg g==;
X-CSE-ConnectionGUID: ftIUVJ2DRi6VxuN1aR69Bw==
X-CSE-MsgGUID: /M0lujUOS0ueyAxYhbO9WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67838797"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="67838797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:06:37 -0800
X-CSE-ConnectionGUID: e7OidqzbTty4CbZev3LaTg==
X-CSE-MsgGUID: WgfEV17/Q/eYbHeA9ce70g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="197744765"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:06:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:06:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 04:06:36 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:06:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSoPNfarfo6PfEu90gA5EMO9wteZ5coT14RKu1wOinXoRC5ElaJRwxF1e6cblN3XAJtN1aZS4JTGFHqZJEmOsVylYD0+dBFN7EvMMc8sAmrvZPYfLoYS3jW6HWOTfE29WLqH8z5NQ1irxg7npmwuWDuMvjARp6/eQJ4AN5rfVZ1QvkzyWoCMj0blobzbwGL1yBoqp5uPnvnzbZXJ0Z1SXseDfeELcX/nGYPCRKNDTiYxbbMYB2nd92uOsVndWsRaNvp0oxyojQ0x9lJnossuMOdionLLLXkswm6mamTcFF3+xvzzoXgAvjoAz/hlg0/+FA4KdyQfyCFelr+xEbRf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq2x2aC+Ry6JDObokeYTc6pguazdsveLS0X7aUkziTY=;
 b=sVabTrLf+oQCAHdPxIIShfQ9Id+o4ISWfr6CLZsax4rlK9aXJuD25bhyF/z3uvkEJWkB4uvOyJFpLtyzwJhzUU+oS8ounzHmX4MgY5gneoARgYxGUdU7g963sdYkVDuMdExm2qkAslS+yzgG1DiZtHB8fcVE4e6kRwSJHxYCXaZR2q1TkxYmjtzdrj5lcPhRg/HcWNp9z27TmYcYOg1iQv9nwYp/1NVwRa0H35shP9lx6WF1W1P6KJz6pz+FuR42g/m/rbhLa+T+iRye2hmrK6MAMR8NccMJA+Evwr+G1U5zICp3nPJgTJMb6k4/dXNgJvwtnujVjEEdenjWhZU9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:06:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:06:31 +0000
Date: Tue, 16 Dec 2025 12:06:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 3/3] net/intel: bring common Rx path selection in line
 with Tx
Message-ID: <aUFLQuuKZFAUza1C@bricha3-mobl1.ger.corp.intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <20251216103504.2624535-1-ciara.loftus@intel.com>
 <20251216103504.2624535-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251216103504.2624535-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: efe26aab-e07e-4023-f298-08de3c9b8cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9TyS3nDkOA0IDTzzSTWInFkSpgdMuoOh11mFs+xXX2alp7/BVFYA8qCEDf1A?=
 =?us-ascii?Q?dTrvkPRR1TBbUY1hsh3IpPd9w6HLnJ0DAT1/lljD3eMPBajOnS3HO3WU8T7+?=
 =?us-ascii?Q?FIcj58ghPgqLailOb1gktEgT+Ta3VbDiJq5OOQhmhWG3B1AOK0TaOUdhCawV?=
 =?us-ascii?Q?Bs2w53moNXmOAWk+bT2JIDFpI+nfOQZPwo8XRIPB070MIX9u0fUYzmYtFZ2e?=
 =?us-ascii?Q?N/hW+ZgNYUkoZF+vCfsoBKRsmV6O0pUSPKRqt0FauZTov8AptGJMl3SKfqAo?=
 =?us-ascii?Q?0J0OIqubqgjx703xS124gKm2XNSLdPUd4k9RFACxqfi935LywhnPZqXtGnjz?=
 =?us-ascii?Q?jXpva5ptHLawf3Rjh+5wwLbFIyQiPj7VOoRnEKJDyz0HSp1EjLdpvStU/xt7?=
 =?us-ascii?Q?9RWvlGk21nt5gbswfjKS2FZAlUiGDlaT+IYAL0b9wBKj0JtObEjzk8Y9UrQs?=
 =?us-ascii?Q?CugrwCS9cyv2FYxUbADXYjKX3Ki4znPNvznWMmOyYC3XQmjUheepv9ekjKHk?=
 =?us-ascii?Q?v4NZSbYGo3zoxNBadLiZXSCHWmOGeEwVbK2B+ukVHNycIZJZo4gataGsAXh/?=
 =?us-ascii?Q?6JavkmImikuKBeyKVIYvJ5difRT5TKtIYtwf19vpI+IXFLgg6SxSl3Jcj8F8?=
 =?us-ascii?Q?MfMx2Z73UlYDc+uGnj17eOWMQgD+xVmsPHJxrGHNbV4fV2uisHQaLdrbsJzr?=
 =?us-ascii?Q?NOlgeF+bOl7hB1tn8sbZxUhS0tCtpBcqagkTmdFFh0wjEpv9y730kYKaksZe?=
 =?us-ascii?Q?24UmYQ7BrIXaSB/XEozivfCewA+OSAfEBFLFUFQAeIgWWJDshyDsNPFT0EU6?=
 =?us-ascii?Q?Gz5dGBaY/whiuuEya0eyap/JDSZcb9yjohAAPOd8aVat2UK031tZ6ZnV/Vjz?=
 =?us-ascii?Q?Sa49tUoSlI0POYfD3eLedBbJPvQQMwI5I+c6oBIsJ7g87NAPx52aRq1jO/r6?=
 =?us-ascii?Q?kI4j+g5DFF9ot/M9UVneNQGc5mBAlnuhzzcTMUIeet5ZD/b4dZMSK8TRx2C8?=
 =?us-ascii?Q?A/iTi7gSQd0kcm/Dgj2G/VYIPSLpwLs6NAXs9YzdaJeQDP9UF3P7ZFvar+kZ?=
 =?us-ascii?Q?KyDg1qyPQLEEvRIn3V+rsUTTxSa+iFur8mrVOfYA2KkhlBdrR4tzwr+J5ood?=
 =?us-ascii?Q?ZDweOa695S4SE44JIttgeVdVD+47qWKfbXYeTuW9dqdPROTeZA8VFgqfy8gd?=
 =?us-ascii?Q?dPMdrwQuAWzCQ6mgreLp8KMI+QUk1ihU3Z1T41tLsP0AKG2AdUFibN7TQ/Td?=
 =?us-ascii?Q?qLQ5D0EHUoj9d3VkKzbqyxky9FOXTYGACjyrDoVr61IjLqvrCeNPAwiwtOxr?=
 =?us-ascii?Q?OOaX0Iirdplax2CUM9D5azfgE9uvwgQ1b+xgHvC6tg/xjWhLBzO9MuDcpCw3?=
 =?us-ascii?Q?YVm3w2aBn1cnktWJ4zt7jVjSPpmHCgPnYVXBFOAt8H3ARvg6mAt5qs3QJhxM?=
 =?us-ascii?Q?shYn96q/Xk9BE4hgA5P7jWt6TMK1yDJm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUUVqPGdz2f6uP4U8mamqnOaf7j34QZUesEFiSKcCIeBKQSL0JqJhIniZsqg?=
 =?us-ascii?Q?3astLKOliBHMyF2sN0Pn2PDWB5JDva9ws9zC6Wu3K1dOX/grsWNS3VT7XiYf?=
 =?us-ascii?Q?ip2vXOuE+MUHWgL94NOc2ZfYklVZdxgrS8Dp5bvry6Si4Jwrz6g+BRcbxhHH?=
 =?us-ascii?Q?+XuV9eRodCxWt8+eAJ5LtIaCGp1p8R49PSSVq96Lma+P82G/oiIuaCdGkeuR?=
 =?us-ascii?Q?ER8aaBDr7RjCaLKanqFfMZ+ygFDrbVA0cyGhqjvdmJ3HnEoxyA7cLUfLYCCq?=
 =?us-ascii?Q?nfU0QeBZHhKSydQAkHuoC6FlqnRnCPso8ooBPLHGRlbuKSY8jv4nnB+jox7U?=
 =?us-ascii?Q?ZhlCEiENh3/BxyIZMACcR1tlqi53mD1GZOE7sS90ZRMHj96oLwIHg7wdkD67?=
 =?us-ascii?Q?KLW+O+jLFXGpS6ORX23gW75lyDLJUqcD+fxHjHxkXZDbWaL7mYv7sqFqWDB+?=
 =?us-ascii?Q?Qt3MPVoPEouSxMPjCNeYLohf7QGVIHwb5tKYsoBPKC8/EV0qKKOGuv4knaS4?=
 =?us-ascii?Q?x0bD9gGHaca/FASjrMQVFUERfQNmU65F3CS5C1L85DZdODXMFElF+1bYyH/6?=
 =?us-ascii?Q?Ho9lUxCCyx3bG2rJfrcwfH5kthFgDWr9m8rqGCmXAX2Jg2jhEwSgnjC0y9R1?=
 =?us-ascii?Q?bVyWJaeOnwElUFsr/YWAe9TcGuK1BAWn0osTLcNPeEmj6xt7MKK5JizdV/iu?=
 =?us-ascii?Q?3O4xVDLy1UWFqphRohAl2Qd7feP6qC/duC29tOjrPjq9FolL7+mMNINjLkNy?=
 =?us-ascii?Q?yYCMqWu+9hKlYKY3hS8lcOvqlrIalnpXEab+I/ggZ7MLrSlpC4ny2E033V4W?=
 =?us-ascii?Q?FyNOGKWG7fveS8Iy5v6kWgKlAhPA28P2V18Eo6dphGZyAHidEXRrJa/f8lt3?=
 =?us-ascii?Q?dXA++dfSgPOT6ozK2pPlHzsdqCiFSva6YnMd3TL8iwwiG0VetjaZBVOD2Xu1?=
 =?us-ascii?Q?n4HdxdWFMTqvODZBGVj7+hufD956AYN164N7PSxiKyXDukd0k8W1h/UCvsGY?=
 =?us-ascii?Q?CBmWObktr/lXvHX/M/kz4pdXnB/hHgybnKR7eWrlj7Y5j5Gl4zHJv+UbQ56U?=
 =?us-ascii?Q?/W38MIOCcs5fzBwB3GxchaiLGrv2t/a6UjPiYgyincVJdzp4Pc6aBTwRmjEI?=
 =?us-ascii?Q?Ezp3WPuauJ2QhfF4JMrXZcl2QsWNixvWb0NyVyp6xY+/fZ9Edm6G4pzvMvee?=
 =?us-ascii?Q?SBThgZsSDZDzfJLMPn2fAXBvWrVwxrU+X0nPhFogyvq2Lx9qKYkHJbaxs9q/?=
 =?us-ascii?Q?P3EM1rwU5NtQZnRGJLzcZRnrlnzUbJkfD86UnfMWaxc9NCtF+91dd9S9kSRa?=
 =?us-ascii?Q?81XF0TQRtvoRpDNeNodpZ0bRgcgAp/KzmFiKKFcoGDOtrMdb512H9FYkDwFB?=
 =?us-ascii?Q?IESAifVg6DWXY+qsqE7sO5owkVByDnwnyOrKVGvgYGXtcnfPQ9w8oteN+aFE?=
 =?us-ascii?Q?rXcr1N8Qa2Js0lFKqIkhxF/cio6l/cB7ETMqabRiMWCz6hP1gfW2sX6kYyto?=
 =?us-ascii?Q?4VpuYIgaU0vKxEBveo/vRNEAsmuNAPvyKYP5OUwmDesziCelO5AJUDJBRFx8?=
 =?us-ascii?Q?XgigUkyNe16MRbX78r105sHDBcO/OGBQZlprpo9JTkSO3gc4UkcW3I4c0qCL?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efe26aab-e07e-4023-f298-08de3c9b8cd0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:06:31.4443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hrg4dsvgtp10FT7H/SdqZ38yRfYl7rG2r+N4cetJSEqjhAy4ARNeB3tAFlXYR+rcTdB7/9tuUTr2eUS3NWc3+V/aJOvbA7ztZ5QgdK9MKBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
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

On Tue, Dec 16, 2025 at 10:35:04AM +0000, Ciara Loftus wrote:
> The common Tx path selection infrastructure which was based off the Rx
> infrastructure has recently been added. In the review process some
> improvements were suggested for the Tx infrastructure which also apply
> to the existing Rx infrastructure. This commit implements these
> improvements for the Rx side.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Seems reasonable cleanup, and I like the consistency.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


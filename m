Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E0FCA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 08:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B020F40289;
	Tue, 19 Aug 2025 10:02:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4FBDD40262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755590522; x=1787126522;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0Jikr8QtyVkpp3m0nz9za2ssQeM9mlApNPjz9r5Ps4I=;
 b=X3iMVoV4OtdkOoMfb0pyIotwtb7TiQPTazMsuZhICxcY25TBmCaowNNo
 biv139Na3CKLd6VRwXcQmlUd2OexheXXkY1yVxcmr/K26tly+IgJJx/T8
 1pWyDs/JrvgT5OT4xOZZGVV4HiF7kUcdUBHgoikC9QtMpAH1oOUtj2j6r
 So9187y7wZAMxlLLeBLY+z6CL47SyoXKdJTQVmZIQyHQWHEDmnQHsBg+a
 YkURPawMDws4RSfp1wC5ZlMxlkmEUT/EV9ZRmdYgbXeUem0d/pEoyr3DT
 4bHRWujtctfNZNHB3p7ShSMGWO04BdUzLhClTBhd5a7PE6uPFAVnKWC5m Q==;
X-CSE-ConnectionGUID: KOuzi3ABR9SmqI+kN3W6jQ==
X-CSE-MsgGUID: m/Srh0EWSfmYIrbQ3CuOTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="80421908"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="80421908"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 01:02:00 -0700
X-CSE-ConnectionGUID: VAi1mMXVQgmBCiEuLx5xgw==
X-CSE-MsgGUID: 1cdaMoNqR9mBj7hF2yBcLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="167401162"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 01:01:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 01:01:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 01:01:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 01:01:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koJmCrWXSc5vK/6wPK9jYR9duxqV6cZuId/2uTCTyqQpmJS6UZPIgNIKCejvsAEpAG93/IVcm/iEGQ+wqT/IjlkHLi/cJdXyqzHLZZUq5BciXdpoUppI3mPW+vLkOEfwxTYV2lSQ3ntVgzjYW1VMzAiT1K4drzyRzx8Em0yZwK58OhAkpIEV2dwlKwa7j9Jfzmmoz3BG7m3IMKA2h44fpKKwARRip6mdQ4/R3Vv8+2QMk6AJxEDg9uVoqJvJYpwznlD2U7wMY3OTk9GKDw1wFlWJ2edcMDHLTl00vanedLudg7p4kY0nU6wv8waE+41+rWbDFe2qFUwUg5iD1HJpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THyQOe70FdZxFCj1tQFCf3zoVpGOVI5S+wStTW6b3RQ=;
 b=VR+laysqDGnFCqxY4T2SLvseCd80X3lgM/k2BfH1+NrtdiNWAjgKbiUduPzvw76O4Jz/yliofySLkyxc2g6nQMqn+szdIEl6cA17HDOXLg0e/1B76WSjLjrBYTcZT8lgNsKN/C+wEtouiGbMId657tA6AYMv9VugUzmA8ZoVbLMFTV5IQ9U141QUFkrBXsQSzlfp9gxbKFp+hW51tY6nUgY3OHZpRrwIhD8dqeUB1WvUZ3Fz6RL4e8N0CPGc1QpW2E4gjwinOEm6AzzhZzAw7zjNQVNzvl7VVk8KmCScjm+sGwXPWuclsf/8GJjhRdWwfr9rE59xhg3fkvUKhVWvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 08:01:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:01:54 +0000
Date: Tue, 19 Aug 2025 09:01:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC 00/47] resolve issues with sys/queue.h
Message-ID: <aKQvbbexxFchYpDF@bricha3-mobl1.ger.corp.intel.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
X-ClientProxiedBy: DB8PR06CA0012.eurprd06.prod.outlook.com
 (2603:10a6:10:100::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: fba84415-edc0-4de2-d674-08dddef6a962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dCd3i2OXoxlMFppHCx1arc7MREdywynhIw8lTS1oBL2Y/7wv5BsHEUqn5M/X?=
 =?us-ascii?Q?PwlesvyR4d5KhAABDZCKmzXQOCb40V7YKCZUhVBykANMQuQ7eTlMjfBgM4aq?=
 =?us-ascii?Q?mB/sFJFH38x7QfgFsK1fZEMncGd0PxzqmmPDH+ezRkRrOTlC26EAAj4YIJqL?=
 =?us-ascii?Q?dYcYlUHHczncrOUYaUW0Vj5MWhgU8RTNqC/6AYJ+BwFpcppuYfNwtm5UTHIj?=
 =?us-ascii?Q?6QLKBJRC+vLoSINzKwHQC/UJasKLK3SdycDei+/z5KUKnmaC1QZX5r0yrG1H?=
 =?us-ascii?Q?HSlO5QC8CILORW1ai4XvvjjL6ZKkVQJRvDhZPD9wAIWcA6z0cYl787h+SC+1?=
 =?us-ascii?Q?TamLnzuf7JQCqS8c0jZXg4wgsVR80PLXSUOaw5FOXegjiAlfY8Ha7AzMvhaL?=
 =?us-ascii?Q?moFJHuKhOaG28V1MDMTnqpaaDkZBBOGee8zHlriZtocmsulwrieDsmxPsrAk?=
 =?us-ascii?Q?ek0kVH0gq9+hJK3q6k2pA3rlJ1nEmckR6oxzZe6fmniMTdRQCF+xNBXeKhNK?=
 =?us-ascii?Q?y+l3zd9k0Kqv4zq8cLOXT1BJkD72Z7FDBzONOaEQdzB11XmsJYK60IIdL1Pr?=
 =?us-ascii?Q?p1WSPcbjaJnM4ntX86pV5IFRFFmxM5Kw5Dd1KxsU4474VNJys+KjGn4LKo5c?=
 =?us-ascii?Q?baL7j0yGblHP6y8JfosdqXjXW6xfgDCxe9mf/AdtnCHQlLREqtx5wNA6+zHF?=
 =?us-ascii?Q?FCEUyyhcKPHVnAXa1BeoHgkGM/OfC6bFRg/pLZQDejVSWx/hgr0YekfwIoKS?=
 =?us-ascii?Q?J03Lm7MEIdA6/mzy/gMdJzFVFy01eNdGp53Sb92udcgB74Oszz7NP5nXHT8b?=
 =?us-ascii?Q?NVSrTI36K6rKM0L2z8/tGBlOtNpOl6RhcHq1EZYgmvi6fdw7UW3JAvnct7C4?=
 =?us-ascii?Q?mij01Agy50WEJbswtIHT5XCOtFjm3cFCQ04JBFg5yCdBUuPbVK2rDmjnNU0o?=
 =?us-ascii?Q?e0hxjj8OGy+GgbSVcxrTeyzJG5nFqdHAtF+PqqqGPILMNcRjeKoBc4OeyuTE?=
 =?us-ascii?Q?ghWLzWUXTsLX0kTYVSgjOtBl44fgG84O3VyRcRoz6AioEhLtQ6ICPhIuLhqZ?=
 =?us-ascii?Q?38z2na+ulk4ordF/mVS38IKQtCL4dqTtO1ZxkGezV1TNtIwr4qmoIrywEdd5?=
 =?us-ascii?Q?gnh/2o/d8CFvtF6WHYHz2qM8hQ+W87Coo4LpEg6BZhCb5QuhZmwHGuvvLVHc?=
 =?us-ascii?Q?qC/RJwcjEcywmp0Xw56SEs/M72Bu+gYoHHsV5noXfk3R9iHCcIA2ALecCX/6?=
 =?us-ascii?Q?tU8CyuDnwZaUrY9zUm93I+gZOGHU5nVUvevFzaSHbKdhj7XVvzG55hz0ZzI4?=
 =?us-ascii?Q?RWjFJZkDqgM88uavmx3VPdYoKo7+JyHMB7O3tKSOa+mCCHQSXTTinnMT+sbg?=
 =?us-ascii?Q?MBcSXBR+1kqRj2qGljXYfJbKijX5Sx1LJZQSz2BtpwB0Nb5gnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJyDiqh7iOLdD6hPKlSPuzhS6v863vuljcX/FcvQr1reLMMsWO6e13iQ9box?=
 =?us-ascii?Q?fTfahHi9g9BSJ7Co3WfXSe69qCoPIAV/WNJuf/PF1zNc5xc2sDIhfG0JoGY9?=
 =?us-ascii?Q?4EWOXG0k6xTapyZxtZx4hsQsTX5rEhlXmWxbdhi8+kJ+0rTPOVXiFGnoJOU0?=
 =?us-ascii?Q?kuG4AgRji9pW+4CXY2MakvZymj/hDkGsiiG09Q9C+OrUXWo/Np0Y88JGptx6?=
 =?us-ascii?Q?lutMQQIWc41rXxaDRDRkEEUTpuEi/SpFMPgBkU5KekVFEXhCzId92g+F4/nn?=
 =?us-ascii?Q?I661Tm+VKPr03rVpYCjxe0nTlL52SUK9Uxe355JZNhv9Ms3tfki1pYw2ajwe?=
 =?us-ascii?Q?dp6ivAEFMlrDCSVrD3qBleV02EgUrYHkq3WoujFs4ynYDAOZ7ZrTBVmLbcLn?=
 =?us-ascii?Q?BO2DN/3tI9cJGhs0jI+Zi0P6+P6GiCH6W6zicWS3lvrltOH5kyQYCJo0cj5Q?=
 =?us-ascii?Q?sMGlZifBurUt0C+Ai76uGdWxjYceXfXfTQZXN8ndkxqSbK/L5hCoEX2M79po?=
 =?us-ascii?Q?c6J74rvpmQy4gNe1VKCluDOA1PHY4EjX5Wzrl40KIj89+2p9M6D8rnWZuY+R?=
 =?us-ascii?Q?JpArG+Ytc4uskYxo0d9ypyMzBUvl0XoJnnR/8wH7/Txm73pVzIMD8WO4IoRC?=
 =?us-ascii?Q?+lEl6X0GvT/yG1z30kY1HlroNamNpdTojKIJkaiG8xZZ1hAFxyN7tmQybzN+?=
 =?us-ascii?Q?njAK04GWohtA13Wqg+gsScRSVtoWU+LklOFMro2NhePQas7kcjFI8AtQn4Cz?=
 =?us-ascii?Q?0VB/JdT4BnjSNnp6AFVOaHFIoVcBxqH0nH3gMST64u/9k9xdsWPOtWWc2FQ7?=
 =?us-ascii?Q?UggSVE233B8iw5nhx+QBiRc8iymtovPQCcCif/1mJUargr1pg2xzGwFrCohO?=
 =?us-ascii?Q?xOSiHiHVx9NbS+bO/RH4KC3Sk0ThIy6dV/bUjbZk+C+gxYRlyCF3jKbpGjAe?=
 =?us-ascii?Q?F1hBk3mlYDqD9xPK5a9aUm9yl316qsGETyfPKJDi54VYsCZvYD7A6HJR+8j6?=
 =?us-ascii?Q?rCbXsF7LulBvCRJ/SbjEZMH/VKIo7PwTIklnQ+J/ycqFSa9XBZOmTAX5SsKj?=
 =?us-ascii?Q?Z4L2jf1VQy6cDNXzHc8QMYnBockFLyTahp1jvRvKfXaBXHHmn4UlzYR2Cho7?=
 =?us-ascii?Q?s87cLvqPwEDo0qo7qRDIXIBNZx/kMYp+KnK13RoMqzg7q1GMb4xs51lgT4FL?=
 =?us-ascii?Q?v0ibVLIOhGYhiX+3M3nYYwbP1Gu1kX/fWa9XAx2WJjRrgZCgizDDH1uUJiKy?=
 =?us-ascii?Q?1QW9d798SljYpppBzAwvWzxJqgx54xwE8hsviUozecqur9eXxMwSjyvI+i56?=
 =?us-ascii?Q?8RW7x0ibavl7/bLPllCJECmdfNeC5aeQ9MkE96QKKYFonrcOkJ6manuTWuUi?=
 =?us-ascii?Q?qoD5HZuiMubsA8s8FW0sZ/taIhc6XvWkIt11FCyGlZ1+XR+ijOoKFV9TnbQx?=
 =?us-ascii?Q?ceT3zfEG/YkwoLWyLzr6LYk36XQLZ0hI9fEjQ9bqIpPqpDFQGbpGjvmOhZWd?=
 =?us-ascii?Q?eZaHlq4f59Ps6KwYyD04XYYwqnCrv8wnUjoVfY9ZeOPeTX1zZtq4t8btSYcq?=
 =?us-ascii?Q?txG9dN6Kds9T+q2xvPg+oD8hNlordyIThd/JsyAar4dMManHYnzwb/df5IlW?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fba84415-edc0-4de2-d674-08dddef6a962
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:01:54.2969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBSnclIGBfTZbYtPx+N1IARLkc5SWjFiO/QYUwpShWRuQQoKbDc4BavE2vyUxApVcTBSxEBwd5O/tY6UtHA3Onf/HTo0MLFPZ5EUtedwmLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
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

On Mon, Aug 18, 2025 at 04:27:11PM -0700, Stephen Hemminger wrote:
> This patchset cleans up the queue.h macro problems in DPDK.
> The root cause is that sys/queue.h in Linux is an old version
> from early BSD; my best guess is that it is a BSD GPL license
> issue that it never got updated. The Linux version is missing
> several useful macros which leads to redefiniton, bugs, etc.
> 
> The patch starts out by introducing a version of the current
> FreeBSD queue.h named as bsd_queue.h, then uses it across all
> of DPDK. The file sys/queue.h is no longer used.
> Ends up doing one line change on lots of files.
> 
With one small comment on naming in patch 1, this set looks a good cleanup
to me.

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

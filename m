Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624D1CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 15:19:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8299F40E03;
	Thu, 16 Oct 2025 17:19:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 50A6F4026D;
 Thu, 16 Oct 2025 17:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760627970; x=1792163970;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dXKe7WX1EoN2w6rX/nWnlssE8IrkgDH8hwR/pq6QGmA=;
 b=nyVAwImI5NaBfPBQOwCBV5E/PsCDwzkF3Is9prgbIaHoG2BrabUN6l+a
 6CJw95TUn3rWwbAykjeZqojfP1a8i3FfAq0I3rjk7qwp1t3BgJ6wdflVp
 yCwMb0dr64lV2f0HKgqYwT1WEJcbFLmWWwVMbkfFLHm4lARfK6YrP7woK
 bjrXktcddm9nEYtM+WomIuguDLtwHmam5gK+SjIR/WXZZaxCRNE8tgANT
 RBq9A2Di3JssQ3sYBtC+sOXK/EKZEUSX00Ne9CFybvJuZQXRRf1oBBAHw
 vOXcGQI0R90Y657AaylfWdt4HWY0FS1K7vJ6xNYTY78kr6Zuep7f2jfT2 A==;
X-CSE-ConnectionGUID: 9HZv493TSDWceNFjnLG/eQ==
X-CSE-MsgGUID: SaKsGaFZQP632obK1cjCEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62033548"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="62033548"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 08:19:29 -0700
X-CSE-ConnectionGUID: St6Jqc0ORYSGoncIOGFWyA==
X-CSE-MsgGUID: 6+AUX/nsRO+tARjnkXkZsg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 08:19:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:19:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 08:19:28 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc1NM7y9en0ILBxSVw7mYJRQ1NPSlTgDRo+ZsATHfiT3fTSh88vDsZxSt/8FEpA1FWzSVQk77WxDwbCwF8Pwy5nm2gRWlG9+J8Wox5xTQOkycX8KnBPxk/CvTCFFuENUf6IRRwDHK54aqwDoBccSnxFe2y3/b49m+t9T7U/8Xm4CPlfaEA/qlCRn5Yf47aPsQOIBG3vn8rjvZRCh1Srm2BoeB+USW8lqbplaX6vJaiAe37eLMs6/mvjU4oBZ+PXqEdcqVTwodtWuXHBAqSTQioCDGAoehi1ixj2Z5zx38P5QOQxIJA9jpNy8hn2taFoIpI9xgEfEY2/bJgZVgmwFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DiS3uHUP2hzUDZUr8CU1oB60NFxs1Xyt9+iUDyMIlc=;
 b=PGF56U/YMVHx/HpY5yXGbQW8560W9Evq+hZFAMYJEwOahn17wcjTf60rZRxDnTIva+DNvUWQOW5ZKIdhACkiLIqsgdzfVPOpOVRUFPn0PD06gnoCigE3hLRAccy2e5B8jhhT+YdeA7GjfBNZp5OGWVUtj5dPZBujnQJyAKxAUwoytk+xWtwKUummRM5kDLTZsSb8PBTKU8Mi1yrXsY6XyC74U7u4uedTJMhTk3eft8Rw1i8HNVXSviggJSZU6rt53L/hMOroOwgIWhDOCsSdrgGja70OIbGs1iv6AWS9cO0ei2AHqKid6/bhdHkaSSHoi89bBs7WltxCz+SH488fIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 15:19:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 15:19:21 +0000
Date: Thu, 16 Oct 2025 16:19:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/i40e: fix symmetric toeplitz hashing for SCTP
Message-ID: <aPEM9Ej5MGSHZp_K@bricha3-mobl1.ger.corp.intel.com>
References: <20251014160718.92171-1-anurag.mandal@intel.com>
 <20251015181150.93621-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015181150.93621-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0291.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: f90c457d-4040-4b75-b175-08de0cc761e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jy1gznvI4dsP1lQdr6E0YFm9jc5TUUAbFxjAZhPK+OHdp3Ycr8RdVwkunEb9?=
 =?us-ascii?Q?M0gFZvdcIkkqFsrRuT5lmRKEqdxi7wFzqt9+oJRku/rkLNLXh0Dh6G+GOzg2?=
 =?us-ascii?Q?c+F6SnU8B/1tdj82tnx3CIijqFG3g6WG2EWvuKgZaxTWAt4E3nRob8G7HM/6?=
 =?us-ascii?Q?eWyTKBub6XDbJwbrJZfCO1hbHi+Bp80BgwW+/5pDR0CyYSAyn3V4emGLk6KA?=
 =?us-ascii?Q?x1f6IP0C3yci3L3P66wnRVWLcFVFQ4SUzdHJrHb4RrhJ6PNyQ26fAmKRT7iw?=
 =?us-ascii?Q?eSXGxsv2/8QnL1C32zo/z6012S4c3uNDAryf7DtImn1D78LBkDSBZ3wyee8s?=
 =?us-ascii?Q?fDZKAy5mhu4V259Dhg5yQ5/sbPO/bJpI+ifBEqtLtsGpM/jv/H9K7xOrs1CB?=
 =?us-ascii?Q?NceazGi6MEUbImTibQ6fVONR3XZmIg4L+lwdU44F8QQDE3PVucIBGmgx+tfq?=
 =?us-ascii?Q?sPAwXmG2L9FYSEYVX1G+Gjz1kKodvbvktQELAhFKcmV78YE0nM9Alwbolt1c?=
 =?us-ascii?Q?7sb1pXE5dajV87vpenDbaHaqGrdXMj4B+q1WGdFZGv2fr3poEKtrCUrRDxxe?=
 =?us-ascii?Q?q5ncuGxLgnwYv/H1pUVNA2C9c3eKML5JG035OYMg8hPihXRc7RP55m1m/iz3?=
 =?us-ascii?Q?x7pGetEFa4xA4uUoNgWZX/ALHaaLsB7RD/bS5UirH3kWSVm5S66444xr2syH?=
 =?us-ascii?Q?OwcNZX1u+jRexyxF2nmO4d/uSmeRv7cJz+BffEpBwvTjNo26n15xfG6E6o3B?=
 =?us-ascii?Q?7Ykd+4jqBwwfzrB/d8g8s5ir/ptBEUNqnzFsDQc8/h+YDYfrlYsLmoA7+FgO?=
 =?us-ascii?Q?vQFNBXoOaUztZHSfBCVQ6TcS9MRO6jwALbERtQ4RHMXYzVWnVobkkfmvqKl2?=
 =?us-ascii?Q?ZjcPrJPs8kk4koOowWzSzc1AHRGuUhciZ51LMvHYLGaMJGTkc9YERdn8hNAk?=
 =?us-ascii?Q?PNCbv2jwXlI/QWqD/ZNt4trgMHLKpm+lDJK8xssqtIWdCzzhFY8BXo/OApdV?=
 =?us-ascii?Q?AL9fZkCw8t0o/wnfC89dZmidugM5/7cmJudGvBu2spBW+wr86P7FSs7Cejq2?=
 =?us-ascii?Q?uwHcRb34ExdrQ8o+23yOlaVQHCNf7WAPHV2X47nZAyJAAn1bQaOf77bhuW1W?=
 =?us-ascii?Q?Le6NsDQSjTPWk0RRh3ZCVR8OQTt7fh33JA6/bXDcYbmixeuCqcWiNGV+iNUE?=
 =?us-ascii?Q?qz0f95dQh/YU4c1jgdua5df2gN8UYpKcwey6ZGREUrCzlVgaa16Y7tZ3biUe?=
 =?us-ascii?Q?kkBfP2yVUdkrjFDBueyikIvgteiRrNtxa4SRFaumTELweJqG9oT0e972ZZAq?=
 =?us-ascii?Q?mZZjIxEidcE9VxEYTjS/r394J1zDnGa1gP5CvVwKQbpIAxoyqDpgPVi7x4QG?=
 =?us-ascii?Q?BI+OLjXIVd9VqYvpAcyNlgaLfp2VcksBLVzgOGtvayimqz56d53h4DiR3QpM?=
 =?us-ascii?Q?tM/YJmOjJu5xVTIFeqPdw7xzzcV6A5mL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPYUqIPrNM+rrx/vDyh72l3n9+SUd6jKycXGN8xPmjDMQHkXzXmJdpadpUXd?=
 =?us-ascii?Q?WGYq3W+TNllyVga3/uCR11lNtYtXh7Vi+uap+4HvZ/9XMvSuszELc0UcgKMV?=
 =?us-ascii?Q?hru6GQ/pAVTBw6deXGzqq/BxfdbedmrcWXzJVt58ldDSZRsyojKcc/BJt4aL?=
 =?us-ascii?Q?ey8fp+SF5RX1oeRmHUmPNnRSQglFLKMjGP7Y6tTYjPQuJr7Q8cMvUwmolkvS?=
 =?us-ascii?Q?0TAHix4QUGgLiDXns5tdkMY+sorFu6MIbajawD8a5YeGZmXbJFXZqKwD43/q?=
 =?us-ascii?Q?PZJ3GTNfaHsXHTuNkrTRjl7O4OYyTAr0xavyU0pjvQv8D9C1e8uQlYFAeEmP?=
 =?us-ascii?Q?t9GH3GJC5ioumDFlR7RkuceNLby0GEZvxYU2SlMHB4s4d84m+4xM7uXSpz9O?=
 =?us-ascii?Q?WcnccMZ9tugnXy6BOyaoT+phiOmfBFK1RwqyGwZFzgctSjTMFr+T6HzUqlgu?=
 =?us-ascii?Q?y7feorXYwalNv77qCVENB1z3p/L18euAs8ZzJafj7yKbeqFs7Ae4cI81y+Q1?=
 =?us-ascii?Q?xVpB7TgapvJm1x8VROJU4lNm2BOWxS3vXzwWzjC+p8ad/OYXiJGA/vCOp9Qc?=
 =?us-ascii?Q?qq+JZdPqwB3or2UrshMwih7b1XMfIOH6t3xROIdgCgtbrlOTnFCK/b+fknbI?=
 =?us-ascii?Q?xd9p6l6vJIuNNp8VlUeHUD/jjZafWW9+hlxLtqhwj/LpPYMXE1WIEmguJHgx?=
 =?us-ascii?Q?xjCAC5GC5ptbpViLWUkmWclQZI3S/88Qi6iMuKqjSpulu8JnO3RxixghAS7P?=
 =?us-ascii?Q?vzDe4k4KVUmAY+1CeCl+oYAPn3jSETs6BBqaSEpRGCTpBgiwRgLKQz1Za1K+?=
 =?us-ascii?Q?OFp1hVz71NTYMwL+jm+oRpX4gA1QSiOeqKDZO/3Ez9VyzNJUd44NHBVLWFzN?=
 =?us-ascii?Q?E1yOz6+CSIboYq8srFOenUz9LSVSlSu2Euw5S0gHQW01iCQDx42YgDFuz5tw?=
 =?us-ascii?Q?f9ujJXKVqx3P3hIxZOAg8eECt+olN19GNmSnphJ/krgZrqZ9dlrPJqTvTU3X?=
 =?us-ascii?Q?IVwGkwSNE0HW9F4rUvs3ypnH2vkbQvRRFlYMHTERvaEKiSr2cXWboLecLVG6?=
 =?us-ascii?Q?40MNh5f8C+9N66f04kmLD9ikUdKeEErVl9NKXJ2H0VmnjFnPLJhQz2qrkEzY?=
 =?us-ascii?Q?1ONFz5IzcCq7Bb9W2SNzB2VG96InCVah/Ohdf2lzRKvegjVTl0zhBcyEqzMp?=
 =?us-ascii?Q?aIL/zZwlaRJw44T+dlSH1TIvpscWFv1JJYjUDhS2owD6XvHxOfvAjvFSQKno?=
 =?us-ascii?Q?We0mgSGXhY2OIZAwkkGkGrwXol6Lrl5i8naE6IHM1WroXuLVwZ4U7TsbbYhv?=
 =?us-ascii?Q?My9ekyPuaaaW+2IBNV2gBWKLZXetf4uFpKlHxXFE02HzB0w8EcIAzXo2F3fl?=
 =?us-ascii?Q?DS+jOYR8H+U9aP6dMZXZWle84jNQU0UeAV7CTYcaeFY46FElN+83SoYVFUaD?=
 =?us-ascii?Q?fgGBDUM/kPLPu4hjBpQ3mlw0BHjrWFeZUKbnGXx9t7/b8ZMNEZWvJFR83bPZ?=
 =?us-ascii?Q?kA85A/qqW6EEVYdI1AbGZGDcY9DHgRL+rC6l5msjUg1ZZu0A4Q8N/O6Pf3hx?=
 =?us-ascii?Q?nyBwnB0MliMC0p+B0v3Ngbwrf+mlBJgUe4hyOVS3tByeWvhoWCDfTbof7LOJ?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f90c457d-4040-4b75-b175-08de0cc761e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:19:21.6353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lde3cd0pliEEcBlETdaxwyz6kq5pxWX4Ik412EEPpd2CZKNxYuRQuxNazhwXQ12WSXFd5DRvPT5rD/FD0UPOXX0cUldY9yhicnkV8FhqxJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
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

On Wed, Oct 15, 2025 at 11:41:50PM +0530, Anurag Mandal wrote:
> When symmetric toeplitz is configured for SCTP, packets belonging
> to the same SCTP session are getting distributed to multiple queues
> due to improper hash computation.
> 
> Removed SCTP Verification Tag from hash computation of symmetric toeplitz
> as it changes for same SCTP session.
> 
> Tested the following with the fix & enabling symmetric toeplitz for SCTP:-
> 1. Packets belonging to the same SCTP session getting into the same queue.
> 2. Packets belonging to the different SCTP sessions getting distributed
> to multiple queues.
> 

Fixes: ef4c16fd9148 ("net/i40e: refactor RSS flow")


> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce

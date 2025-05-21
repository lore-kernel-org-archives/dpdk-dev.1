Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB9FC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24BBE4275D;
	Wed, 21 May 2025 12:34:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id F39154065D;
 Wed, 21 May 2025 12:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747823669; x=1779359669;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nc7JJCHu2nNJO9LM7Liz/KxdMbe9fLcF+B+4s5axUG8=;
 b=Jnoifj+DQiUS0IcQNzW+lZ39ho7F8ro8P009dU14hR8IVHeusOp1udYK
 IZIAw3hkaHXDynp8MuNCs5rMk92HiXAWI+qBUj6P1wegyPP81QjISgawx
 45XFLx8phzOgbXW4KuiQHOjKZRI8RY7nzygqTZg/TYlOaYfehn+gq1D/H
 xA80yypKXcdgHVl4ZWUf84FC62aY86VfQP1z35FMm/w2457NGaSImqH4/
 0q3KzFfo4rSRM7+XVWARInLuWAuG2Fev5l/XLOYK26yR6dmj6SD7Ob5wY
 rR4gKMbTuO+fntZea2VbLipVirYHbWZjIXyifJ/+pEIi7K4vkguzppJ3O Q==;
X-CSE-ConnectionGUID: to/KvvFtSra4AAlbmhVXAQ==
X-CSE-MsgGUID: 7HDyb77ITSiumdhoGiCJjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="52421346"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="52421346"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:34:27 -0700
X-CSE-ConnectionGUID: UE+KqSJ0SDqS7/He+rs6IA==
X-CSE-MsgGUID: w5QlylNjRGCKuuIYQ6jPNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="141064270"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:34:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 03:34:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 03:34:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 03:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbDn/YtgU6VaA8nlf05IedOc+SgKu/ZhcCK+10nc5wLknFNdMHJDEltj7KxNI4ppQpFWO2je3SCaHOo9NLBYrorxfCalkGlZX8u1n/l+UKavy+D5TsqspV9nnGTKrJ9BUA8dYnJPepuHx5CjjKRAxDYhFXScZkMqpSYVSlXDw3w6hVsmsYdvexlGhOChna586lN+jrP4cnKzsZX6bYvUGcnr1c8ssF3Hy/rSy/PJnrZmaKOXJIEV5EnFFG2D+w+V9fTKnJW4OH4cwBbSIDFZTTr5FKdGYJO2K0CcJ8OkUtUCOeVQFQgQD7pFEee7N6ZQASJJokPI8oN+nam9PlT7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jYFiO1xxatIVjAh+MIuWyrpYoiy4e8TTOhif09R/A8=;
 b=m0p0p8h2pWgs38SspiCGiqKKgkUFQUvmNsI1/8XSajm/DQRLkd6oGptxEwrt6MuXl5HZnIWKFf7LUPIS2WNxlOT2X790vV+tNH+w7lLrRfqrAiCr4Mys9ABmUlXmiJbRbN4m0YNLpz8tCpzW1824NqXy90j+9SxVKq+Oas8FqbFwpeLGuWUk+1VH7oz5XlQ0wculSxTooSwVmT8samgLJQDCV1D3DQcnmnghlppqDeidyikJZ66NP5PhMyzF/DTRbcV5yycqq+ahtl59CdgkcrjX7aXXd1KSr1wa9lwScxcdBXiwgXpbAK4hTg4e+GbTKFg5mKWVQnjxFNo6sMHHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4525.namprd11.prod.outlook.com (2603:10b6:806:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 10:34:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:34:23 +0000
Date: Wed, 21 May 2025 11:34:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ice: fix flow creation failure
Message-ID: <aC2sKm7nHOWl6ZpH@bricha3-mobl1.ger.corp.intel.com>
References: <20250515112348.7746-1-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515112348.7746-1-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feca2bc-4363-403b-0e51-08dd98530d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mC7a9dddnnKx2PZgJORticzeZtDiHDCKqFOEu/Cw6DgncLZj7/XbcG+Naa2C?=
 =?us-ascii?Q?HdxMWDjHW2esMBnZ1MJOAK/ZsOlRae8EM1jMPeQSPQgy4L0I4EHhlNFLeVO/?=
 =?us-ascii?Q?qgeBJaQR0mOeLx2GQYS91SW+olFmSUn9rimS232UBe8d85yd4E6XHLvfqVRH?=
 =?us-ascii?Q?CEyeaj0eEday7g7eHjxrJzufZ9fZvMhmC0/0gX3akLuVAu11OtVj8DChzloP?=
 =?us-ascii?Q?TeefCgA3pjBdj1c/Mg2VvJv2FaJQv5TX2+w1O+aGCDBnQ13hykLQgwoZ/tGs?=
 =?us-ascii?Q?OJg8ZEy2bn24BKxASO3sXGTp7WeFiP1zVzBNnXJHC2UaXipb5dmPVx8jRVbI?=
 =?us-ascii?Q?IEVMHCog/x0Xq41OlAtNG5qG0PTpo4U9ffNPFMSQv5sv4s1SDFnze8SScl2x?=
 =?us-ascii?Q?Be/Sw1ESKh0B2zoJfHDdG++yFIlH/u10ypf+T0kxIJOGh/zy19LrUL0LQoll?=
 =?us-ascii?Q?k4lr9HEMEIlqyBk3aHDr0nwKmxTWx3KxoSP+ojOPenr86se7+HhkdC3Svpj8?=
 =?us-ascii?Q?r/Q98/LLpWhj8oORDasNI5NLRjmPSLFaPivsj9biLCdmgrxFwpxm5Wr4xznR?=
 =?us-ascii?Q?5d2tKDZsJkHAd04Grduu4kQrW7ybxxdt10WbAQ8k8FBOAEAg2YXwHbS/Yifi?=
 =?us-ascii?Q?PD7NYWuybDfeORSzhrEI0wFRsTqtu7WVTrYMb562kgoqMJdVIA1mhOBXpJeq?=
 =?us-ascii?Q?cqs6XSl86RzFIMIzcGt/glolOkTo64qavifUQY0/TAnWOgWclv9UMGsIy/KB?=
 =?us-ascii?Q?xMaY1O1glljqByjI7sf03/3jbqCuuJdltc3BexfRCnqNX0v/XU7zBueIczOl?=
 =?us-ascii?Q?k6JClPN1JoPSl0YUG1IsKXHnXarVPzv5E/auSRgE3hM0JBuEVPqUUOfrOfuG?=
 =?us-ascii?Q?F0aKZifG9+qE3V0zQM0K8Bw9UHmA0Ia8SFZywl7IuqIEKWPtqaAZaCBoiiHB?=
 =?us-ascii?Q?6O4oXWdBpM9JbHI4HbpEjN6b4YA4Yf/FshVmwoaOaKDupvbFhewN4ZYjIfRA?=
 =?us-ascii?Q?wjdoTk9uFF63IPAT085c3TNnq2oXO+Ui9RMeO8i5IGjtIQgyRxBOrmz6+r7f?=
 =?us-ascii?Q?w+L/D+1hqID/gHWYbe/4wvSFJbWdEf1JhT+1ehzojuRoer9Ttrt2r/OT1ogn?=
 =?us-ascii?Q?N0xahbBW2MjRFi6cIRitCE0Jj0MK0TC7zBGEshcWPRWTrC9q9b9plV/H9E/0?=
 =?us-ascii?Q?hEwTBb4E793j5C3p/nL1/VZALzeEBh0R1Or23po/w84LJZ04cfbQXzBUy2zd?=
 =?us-ascii?Q?lVPqnj0VjWYCjxIQVruklx0pMknsiEdzGDnNFQLZsqYTMrclYj3IwP2qolvg?=
 =?us-ascii?Q?zA5rgn3cn3ZrcHiMqHRcOG+0iowsBRMdrH6uy4kxOfiZ4y41I1SmNGnfNEVu?=
 =?us-ascii?Q?JsGkPaZ6XIrkTFr/16rjEPidoj5Yjaz+Z9P9Ft0Sh8YLPZj0Oti6MMadMDRU?=
 =?us-ascii?Q?PxYPn+QgK30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIFXx9ouKYwtzLT36hA0a1vfD+bKaTmUYs7cIasx5rO+88Au4QCRvpeEn3PV?=
 =?us-ascii?Q?sHfmgqUqgvk485xx7IvQSdA3DaoQwcQr1AbKasoIHuHbYpV+ne6S8XD+flVn?=
 =?us-ascii?Q?UA5Vpw/yRUwy+TIadDppEEDyX33kAEsNTaAqYglE+gyHNrdWV7iV5chxbqZp?=
 =?us-ascii?Q?rdlnOvJKE3XgJU1kiFXc8HwxKjALkjqin5oO96MJp+I7AGlVBsVLBMO9RyGf?=
 =?us-ascii?Q?btJ/89AL/sP9V+iKaIo0UG25zgZqzOWpJSDt1E5JQCv3IFbpCViL9/2hIwUh?=
 =?us-ascii?Q?wjkkh6ygPLaYY4q8caPitbWupzzmS0XlJTd6W0eY6v4qv4gBkmyBRkG4Slz6?=
 =?us-ascii?Q?7fEGpp64JWQb0p15hTA/pbUFfNI1uNLD7tBwGvLZVR48RtmldC68lp3vLFxt?=
 =?us-ascii?Q?vQE2RpeFvQ4+jPjfemt7Zx88syN92GX6iicAUPVDY3DBsY33IfDZyiXw2bwD?=
 =?us-ascii?Q?aDvBizRym9rm8JG72SVcZPcKrYBaU/WoERn7X/gDtKxe+mIZXipZ1SW2/PQD?=
 =?us-ascii?Q?qr3ayAMMUAew5xPx6G+7WSD4jjFk13fkNQxiyKEi+iAKg/0RuuewDMCm+lDZ?=
 =?us-ascii?Q?5fg9UVa1x/gr4h6/3OiO8cwFuJyHSL8aoCLAZSx2vNOrkcJZ/CR/zfZK0j6R?=
 =?us-ascii?Q?e5S+OHLU3y+8MD8CVS0WIX6t7bp37QBKE0q95cCfsEUzlAgdrF8mAT1vVzeX?=
 =?us-ascii?Q?OozOpS59MctLiHree6vD6fd16AHXECkZSqmK47PMXmX5W++gudPXzxrnpkUr?=
 =?us-ascii?Q?XgjSOmmaSUpsg1cdW7+vioWHGLEShB7UxiHIupnLcgRlj/AhuKxXYTJXxyOf?=
 =?us-ascii?Q?+aVc6baC3UUJQYIw2D6Hr7N5jVu9UkLlTPu18RZqJZIp3o/kpThRG7G/Y61I?=
 =?us-ascii?Q?QO0gRG85hdHDNUEZ7pasd7ikUCpbVT4v2vo3shwzrr3AxvLcqoIzQOKgFJSA?=
 =?us-ascii?Q?Ale4A8c9EXLlQdirFKXnzPaQt+3WzF+B8UlW31r+VO9fs+BiaywBVyJZF7WK?=
 =?us-ascii?Q?ddO2ciANYeJTS6tj7zrf6qILr4IDR/mMK3rhigm9wJ7WgakbC535s8IfCrq5?=
 =?us-ascii?Q?80tk7GCdKJ1M2MYbhpU0HdQC2uxkIKhFrFUAXH5veNxv2jiPqU857B8K7DcZ?=
 =?us-ascii?Q?3Bub+ACa2/iyzkXGH9BojiIbhgSn6foRAUXWCjsjxsvCy88P+ctImDWfp0Lu?=
 =?us-ascii?Q?wgsdC3kg3jRq1B9ftYFL8fY0/wUDfEDbw2a9YZRcBJc7o5WGrcwyECrR44d1?=
 =?us-ascii?Q?9VtH2MJXCA/7ZHXxvn8LKk4y/SxidXLr84myNV9sU02JTdjW7xUydAI9WtLo?=
 =?us-ascii?Q?3DBKacRcXEwpnuH/M2Ct416b5tZ3Wpl+bHsOEJpbQOQYx1Juadf1LoCNrr6l?=
 =?us-ascii?Q?cC6+th9nMpAFHcEeLloygYcOheG8lSwvBJyKBJVB3S+yGN0CtI6WhHf2hQpb?=
 =?us-ascii?Q?UXTGKENieWLecjHyzKyJY8JhdjG35XJzkzeSlUFuE2ouTmqp7A5725aLUHCc?=
 =?us-ascii?Q?d8tQ5QwrqTEf2wqJX2hIJyRFcilegtZrRJqGjcmRAB8S/w9xYlWrcU7NyOem?=
 =?us-ascii?Q?ZdM2ohiX4cVVtsigjnGLtaexQe0l4lxla85fTKHsyfhhdCbmRZAFIelXJoe9?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feca2bc-4363-403b-0e51-08dd98530d70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:34:23.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vp4qoebBH/VqghyInukhtoo5otfwm6u5SkeyFv/ZeWFHhyyDs4vIZPICDXVHWkDXnxcQbwb4HZjZaLsuVzLv9uTfMyO5BwMFewccCQeo0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4525
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

On Thu, May 15, 2025 at 11:23:44AM +0000, Dhanya Pillai wrote:
> In non-pipeline mode, priority is ignored, a flow rule can be created
> as a flow director rule or a switch rule depends on its pattern/action.
> Hence removing the priority field check from ice_fdir_parse which is
> causing valid flow creation to return failure.
> 

Fixes: 14b12c939f3a ("net/ice: remove pipeline mode")
Cc: stable@dpdk.org

> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce

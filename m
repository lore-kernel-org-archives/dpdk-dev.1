Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A8C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 14:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 170394029A;
	Wed,  5 Feb 2025 15:59:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id F2B9F40270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 15:59:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738767563; x=1770303563;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=N0uptL4G31CKlwhreKc2+yoCYP25VvVh+VR6GxA/Y/k=;
 b=bAIHOLfdi2wGtPP12oFngO7pJ0ijl714A/SYheBeC8K8os2BfUA+IT9g
 9p3VwhODKMvXE3WBAQITtwV1u+kIZ+FN1fCcSdnCUre/qLVi45R4P5ZcS
 EsynV41K1UzfCUT9Zl5A0wjU1uRCMOHmOne0ReNtM/V2IYqOTk60joO0X
 x5iMQDadhB/3H7uxTSbfR1ZW2IC7yJ07M+MjDoduPe2rCMGvl+NkXPE9q
 WDnMeXEnuFUT88U36mAdawNjwKqMcX7VurhZgAHZ8D6BCcBUPjZMnfRVa
 j38MmlmJSSgXsur+OQlLGo/SWG7I1Sp/hvk/SjkoO4LTsM+fjBzsLFfhT w==;
X-CSE-ConnectionGUID: vy3eJDuYQKWguoQ8t+7Btw==
X-CSE-MsgGUID: cau347OORZWe5SNQAvnejQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56874302"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="56874302"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 06:59:22 -0800
X-CSE-ConnectionGUID: 0avk03pwQVmXP0t1Sg8KqQ==
X-CSE-MsgGUID: +GuBPTSiS2qMf6pkpQsyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="110911617"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 06:59:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 06:59:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 06:59:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 06:59:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4W4bD3C2+OA3iO0tSqtGqvzN0ROjK1wtapMz/bZFe6eEBmZ9xGaHO+vT5DoKHjdzZ3K+QOoFYxchDO5ajD6F5WAyQuI4JqSU09TzwEYmIDVCMznb7DVY1StXIUAk6h+TFs6aO0INevdO/xYHteqBiiDZ8cvyXgfbL+NFecxVNPybPMQs1Qbtz3AgnfcqY9risV+2pISrBMmw071gM7pzTIhtnAsWqjvY+oRi7pf0KHB8Uz03pn5OqSp+sZzILkFafjBXM8r+KJJby2g9zsBXJoJF38T8Wqi8K9/Wz4yZl4PFwmBl3zYCptboAedmFDge6jHxczCojt/CYtPrwjw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnSyCirZ930yg673rNN7gwQw8sNs05xxHCFl0qFmN1Q=;
 b=q1nx/QXffuSEet2q0rORzA33tCdJVbkG50EptktQp6kbdFn3XAo/BoroblbZ4bGFVHRkzU5GYs+Zj5EDK224XI+VF0CUYPhDwi0gsd2e0wHk/XsLgM23KVqWYWtlIBvJ5k5Belaw9MqlbQLVDith0AR6jFLO9Cv5b2gcSXHz1NSlDDSBZWUxBzuj8+bMIbKILTUz+936Z3AZq12Ru/HccJI08MyKXrxqx+bGmNRoq0XqBz+8dyYb9zSNUFXtyNXaxQhRmsNhSgH2NUIF7PCTFjr7jSZm3vHmCHR5Tbad/6ksf8VHZhG6SL6/R0Zdxcw4rXdtFcOmKFVL85niPFWw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 14:59:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 14:59:17 +0000
Date: Wed, 5 Feb 2025 14:59:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Renyong Wan <wanry@yunsilicon.com>, <dev@dpdk.org>,
 <ferruh.yigit@amd.com>, <stephen@networkplumber.org>, <qianr@yunsilicon.com>, 
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>,
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Message-ID: <Z6N8vYkKc01RQu2p@bricha3-mobl1.ger.corp.intel.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <1873236.BzM5BlMlMQ@thomas>
 <8fcb134d-3d79-447b-b673-6dae8186744a@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2040007.zToM8qfIzz@thomas>
X-ClientProxiedBy: DU7P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d73bad-1558-4c6a-1f30-08dd45f5a96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sgn7nKFRpWCEPvOvm2U/1kVS+YU59BfzSC9W2MsICfNwGeKkoFwUZWesrOHX?=
 =?us-ascii?Q?jYiKugTKPnpb6HxJDjT+Iw1HmFS+eMd9M7IxNCnfoiEyKlqXMq4/EanRmgvX?=
 =?us-ascii?Q?W11oWT2bwG4cWi3Ww3OUG4YpyNtvaIYRn0J0UfCkFDPmwPG+9h0ZE4tbcrN0?=
 =?us-ascii?Q?b7AIAtJikIQ8cAJeelOFlI4uGl52mGUckXQwL7EW+HPofcIrVgzgmCxLHgv/?=
 =?us-ascii?Q?Q1FTTj3dwFoqhADzYxZriUufhNvWmZ6vC4i/GibX9Rw5KfQIg4vSDZdygHsW?=
 =?us-ascii?Q?bDnIHSIXgRFYm4W5dkZ1UtP1JTpqRWxN8DVNN2AruS2xN+3yUxqtf5qMnCk/?=
 =?us-ascii?Q?K9i7prES4ergZXpOqRqWc7R49b8Tr4IbS77esgTxBBU8t2CYgOljDHCWqqQD?=
 =?us-ascii?Q?zPHAbGyhz4vaTbpFmQCX7yDZPg1zaqmSK4EEAwv0hxF3fDCTZZ7/zGu+1n6p?=
 =?us-ascii?Q?CMi5E/D1A6q4Xip+DrbEZehyDNt4GZ0mgVSRQjl2IWMHvhk0YhVEPlE4kk5r?=
 =?us-ascii?Q?RQlYwhINZVL3qVng04gfF/fXI2uv4bcRgltCxeNerEpjUBJd1kh8v2ekxS/0?=
 =?us-ascii?Q?qnpu11eixQNYWT3bmvvNnnSUdsdkKyYu1wgj6QLa/YTR6z9IKsNE1ruU9VpZ?=
 =?us-ascii?Q?XXy9f/3ZC5AGW3maYNgQ3zI8YQETCk/ALI9RDvT1tlfCCb5P77F28Omsa1EZ?=
 =?us-ascii?Q?yBey/E6Jp8TztMJqZBImhBLxv4Cj3YYiWUkxan6ZnCIeBYsVyCLj7N1V9yjD?=
 =?us-ascii?Q?vU1V6MuxHW9NSZCxOW+R6c30InmC3eFr1hNnK+CO5OX4MKV/BcbSQxMeL754?=
 =?us-ascii?Q?ex9QL5j2WDdNSXrWGZKm5Er3PrOELRca+zCBw5r1HekoJ1rj/e0swkLPCvLK?=
 =?us-ascii?Q?jEDr1FGOM4d30O7X94kJtOUS5LnCoaFZPEemneggFbYanP+hVw0ry7ag5fw+?=
 =?us-ascii?Q?SqC/TYDBmIWHH/816N3y6As7IQtfgeKj3gQk56PUApZQpW1P47fyVsIApqcc?=
 =?us-ascii?Q?lRc16PE2VoQiEfFPbRkqGVUS+oJOdUFhCJR/KEh/JkuLp5KczjPRE/o86rSX?=
 =?us-ascii?Q?g9ipMdh63fOGt+iECEgB9F8LBHHLjQPC1FmYMposcI/vA9N+W6dqnHkdj8Bt?=
 =?us-ascii?Q?N7ErnB9J7wNmt5le5Aa223nmzu91NtHCX9/NJpKKH5ATMB/pX03bQMxYwz2X?=
 =?us-ascii?Q?rTqAmVXt1D7Dl/1biF4PHWCjCC7/8vdb0uk/235JHr6VHu1CxvWiE1EJdG+s?=
 =?us-ascii?Q?lB4EN2mq9ivVlbB1bR0THfirCw9Ek4P5Gii6TW+g9wNx6xcS1VSmhkoV/cZc?=
 =?us-ascii?Q?44eZ6TVQKC6WNUvP8tIna6rFLKLh/ExkxV1U+PhQ4TSrojYTmO04dw53FmUs?=
 =?us-ascii?Q?DdSlNe9cGao+YD5qk8xSx/yE3eKB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zR4LZWiQMu0MrNJUypGd42lKgV7KDSZ4cWNdc1YDxZC0PkJAe57OXIMQCr75?=
 =?us-ascii?Q?3LsuaBzPRnA/sB/gWkO07Ea1HOlBpYUfsJPHcpIUCC4pSM/fOm/P9z1K9AjI?=
 =?us-ascii?Q?2UFz621Qt/gtFhjMplt/q8CjF6TWZug7Fpk1sUd8CT0riFq8BeZprsrSQfJc?=
 =?us-ascii?Q?bqXJU5v2AJdKg+9njXaHteCRWeviNmnHtebJNWgJ6aEyAWnfOQlS71K73FxE?=
 =?us-ascii?Q?SkCYE8TxLWMntFW4tYf79okXtM9GYwHTnJx0sG2maNP780GHxxGn9CBXGQ9I?=
 =?us-ascii?Q?9Kk/jpxK/WKQ+Owa9MeNrFzh46hg6vU+FcC99HwcvP93YWayRa8BKHXR5g6M?=
 =?us-ascii?Q?5Fq69Uxo5z3qFc8TARC0DcqVRAUYMFVeAWmPE8SjBGTNyR6ZRazjzTViMp9k?=
 =?us-ascii?Q?R1330LhT7XEIZzYjZwRbQfZfnU8lE6CvWJoUMIMArmVR4AkSgz6y60qCSPOH?=
 =?us-ascii?Q?8fIC0UpTC2s3+v9y6ver03+DL4ffLCJcTz6X/4XvmQCl1G/oKCXeGGT0NtRi?=
 =?us-ascii?Q?IZo+HGDRPA8sMJauJoz+TYqxcy4ySW/3ZasdGrcvo8+JIucaDpaog0Gybbaj?=
 =?us-ascii?Q?XPrzp4BANAezPqoaYO5xRnZmfKhi0TdQ1EtrWUemcQDKjsWCOmR5t8jOeVDb?=
 =?us-ascii?Q?z0ELQ7bz+kPhvHsx4J2Wl0tB5b4XpQYJpuiwBalR/X0F6P+21RpAfAmilPkD?=
 =?us-ascii?Q?d6ERGOivS+Ea1nQo5H/P7BGTqvBoCGWt5XlST9v55AO1/PGBPbudswgyw+Pz?=
 =?us-ascii?Q?pUBkw133y8iifQ2W9YNRr6syqsvECoGAlbXXSVZTUi/JLy7zvDVZHXxIAx3P?=
 =?us-ascii?Q?GfGxFb+xfgMXW/7fo7BvMJH0iPGf9Lq8+0mPt3hc3XA065s5ZiGJPkB3zVIf?=
 =?us-ascii?Q?bkx9ZGojJtAGlfMnWan50Q38+MlK/I/Y0aXCsLq+WyowXLWCFvQKxjbP5Bx0?=
 =?us-ascii?Q?jI0BGQd2hO2epp+Hj9eqcDJfuButFOp6C9pCNUSHKpZ3OGnP5cW8WccTrZ1u?=
 =?us-ascii?Q?WYw/1gZLmmw0tGfJ00WCx9gtI/sqw7oB+6HX6KmEV2TrrC1/DGFAfglIO/E/?=
 =?us-ascii?Q?G6s6+flCd6MdN327VCSYqlRsce8glUZHIUGp/oSEC8JGByHEYayUo/hxjQdf?=
 =?us-ascii?Q?gJWz7FgGG3UGA7jvyq9boOCVWENDXr1BIGxLKTRrh1ho2CYMSTaxO2A1LguS?=
 =?us-ascii?Q?CQNzhAuEN4C5TAc9DdtZ5b3Nxvqd6gcERGpsZ5xn1RJLD2BpstXe8xUncNqa?=
 =?us-ascii?Q?hSIPsnEuCQlFwjrOqDKGWAizvy2Su/d1blV25zH8+A2cvEeumH1Sdj2YTSNb?=
 =?us-ascii?Q?VivBf2UeexgZ4FQJdB0pxyGorJHvdz/Gb+vrhW8tD8WqnbdOIH56tx+ehuQG?=
 =?us-ascii?Q?vnt6i5mKtaxkr0C/ZqNh5vfj4pysLeyASSvs4pUPgxQr7ahG10zKldrRccxF?=
 =?us-ascii?Q?VE+GrjtcDuL+0fTkV1ukStPimrbd5vHk1hmO73wObcdpRn7KDN2Ed2+YHYeo?=
 =?us-ascii?Q?wfF4AAQ/EfG5qDiPcNOp5u44xg+z7RafKzYZ9HYLAmbFtfS+i+OKQQ7TFWOh?=
 =?us-ascii?Q?7UebhUmX+Lj+TAlqqu2Br28eFtO3YZ9eIJgZZYkbchGglNg1QD+QuI1jpHhn?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d73bad-1558-4c6a-1f30-08dd45f5a96a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 14:59:16.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrezXhuZCDIoidycaQxYzLx9WccMDfIU09FKoros5SIV/4lYfWsZ0rYPAUO+gxtsw/95mBdf/pd82J1MSgJcew+axOw9Db/T2439UPhlW20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
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

On Wed, Feb 05, 2025 at 03:43:30PM +0100, Thomas Monjalon wrote:
> 05/02/2025 15:37, Renyong Wan:
> > On 2025/2/5 19:44, Thomas Monjalon wrote:
> > > 28/01/2025 15:46, Renyong Wan:
> > >> XSC PMD is designed to support both VFIO and private kernel drivers.
> > > What's the benefit of private kernel drivers?  Why are they private?
> > 
> > Hello Thomas,
> > 
> > Thanks for your review.
> > 
> > It can support the bifurcation model without unbinding the kernel
> > driver, by utilizing our private kernel driver in conjunction with
> > rdma-core. Currently, our kernel driver is not open-source, so it is
> > considered a private kernel driver. This patch series only supports the
> > VFIO driver. Our kernel driver is currently in the process of being
> > open-sourced on kernel.org, and once it is available there, we also
> > plan to submit the code that supports our kernel driver to DPDK.
> 
> OK that's interesting, thank you.
> 
> I think it would be the first DPDK driver to support both VFIO or
> bifurcated model.
> 

Not quite the first, but possibly the first net driver? :-). The idxd
dmadev driver supports both. It can be used either with VFIO or the kernel
idxd driver.

/Bruce

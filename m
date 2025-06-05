Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D173C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:31:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6819140281;
	Thu,  5 Jun 2025 12:31:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BE0464026C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749119467; x=1780655467;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5u/rivrqZBdUBai5+5TWm6d1kZcwTMyDzM7fB5to0qc=;
 b=I/qLROInJui/r1IWCKwl1BoGpHxVCxuiGUCgCZd9KWYye62bUUoH00xm
 Dnf5rKjMMSgx57m4xsH9WOp3ozxu/Kxzh0+VSiloSkZsYmDbD15ELbpKd
 c7ktd3toDh4eZMY/+WF97yBsG88N3M+4UHyKbkJ7uCwyNGyOGqx6YOfJt
 r4UNt8H3XA+cT93TPI46Jh8zFaNGDF0htXCSd/K5UROWbnFNBtu8FLXuX
 MzJOn4e4jGpRyZNLPc9BBx9Jx5gblX2aU9VsBnPRy0e5JmDyXbtbQP/bN
 qvyLaO+FM95TXtE+r0LYjhkjPWPiJZi3iCLHFFkK0M5g8SQ/ZWGgFUMXX w==;
X-CSE-ConnectionGUID: 7c10gQAESUCCY5TQYdogCg==
X-CSE-MsgGUID: 6+PNHX7xT52PGVdwHN8mJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="38859575"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="38859575"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:31:06 -0700
X-CSE-ConnectionGUID: qiLQr4VRTwekxQ+Vw/R4gQ==
X-CSE-MsgGUID: dTssQ3KIQFS7+oqIH3mbeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145350821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:31:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 03:31:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 03:31:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 03:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr1d8nI+2mMB4vI89nV/Ms/8bAXVhhMa/iVuCDNkSPvrXIUzCtODgY7s9kp/x1jkLQkVULQDdEJpPUl5IHfgMWCwEn2pAFYdMFRW3LmnTHL7zYm9Ij+70gs5R0UGSGy+N07jJ//LggQmok4bl8WyBPj6KWlxPonVu98nEbqQ0TnR8ZPEw8rwHROj42AQcrZPxiffPC1LB1KByz+OGm/suvVvo4VePcud/D0qgjamobFAQQAceAd+9m99m4JCleqAYxNCAkQJjg0FGN9UxSE07YVDT+qacZ8plZLFg1F33oW39YGY4XedyozvP9AgOsM056EUXxV0qnrQ8QZ4iuGthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4LPRhs3fyOOO3GgE6H6s2BeFoQAuHal4Lmwks+FE6M=;
 b=Ea//9vG4posnqFkbcym1FpmHJ6goWV63QXnjBKllooIDPBK/TH5RcQGTF07fKGerm4Y0y05B/CHpeq1/QT6hpzQ56fEIv4Y9qlaagc0jLgXgq4WEhS8KCa9Cr9tQjtx9yRtq8fCT32PaLvO2Cvz+mk5Bf/6vpcJ+/xuaGHId+vYbbKTZThth4qh+5atj07A4R6XJtpBjPcfOAsttrZzzRm2se0sa49dbx19OPIH1guW6D+1K3lASfZCFbHYGUc/62EfxDR53aiRBNxBkx1j2aZl7ZDkEIa6fNpy9AhilnUPmfUOcd6HzCXrO1m/WFV9dsOYGEpZnazpBXvsE1dBbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 10:31:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Thu, 5 Jun 2025
 10:31:00 +0000
Date: Thu, 5 Jun 2025 11:30:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Gaetan Rivet <grive@u256.net>,
 <dev@dpdk.org>, <nd@arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Message-ID: <aEFx3hWKy-IlIFRB@bricha3-mobl1.ger.corp.intel.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250602223805.816816-3-wathsala.vithanage@arm.com>
X-ClientProxiedBy: DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: bd087f00-db65-4b9d-c731-08dda41c10f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eVL6uPYyfQ5HQq26YIZT1Qui7GT2d6fpdcPTrvQRK5gXdNepjMEGzxN/Dl0I?=
 =?us-ascii?Q?tJ10XPFFvce49czv2n93DfqcvJspbkHbrkaBF9doMocb68yccfD4MH5L0mOm?=
 =?us-ascii?Q?o0zGh6dQD9NC5YDKP4tu+9A+EQWzkOEhKljbOk94EHA9I7Gtr+ld13rdmxeU?=
 =?us-ascii?Q?TJ554m48RCmFkv/dVttSvxv1c40hVxgKiA+GXsSMCZDR0KvdqcorfRQPkpub?=
 =?us-ascii?Q?sw76OR1e7RH+b/pQ8CpXhsqbFeLLe4joMcl1jW+6hIe7mcJlsZB4S8lPoI9k?=
 =?us-ascii?Q?OUvG2Z4pOVTxS4z26F99m9HYAIQZ08yZF2c2jBlN/2CzZSIL0T8idot5D0Oe?=
 =?us-ascii?Q?bLy2/aK4cHMHShKrnkrJsLQnNCiJ9xZ7OY9GwKun1PB1hp3Md9vvCKkPqAJY?=
 =?us-ascii?Q?jvYY4mo5KIVAXxiWeVwrfCgqQCZ0YX7IbccEC06qipgGCAf9oavbUWVU6/8H?=
 =?us-ascii?Q?gOBeCwdKPDLuZE52r+SKv0hiJVPQ4Xjp74xukkC/VPNPm+1Gl1sBr+8pccQV?=
 =?us-ascii?Q?/Y2f8Ur+SX2nxMM/6JIResRThpKyy7OYy6mlljwaERjER6d8Kqj6B4Xx0t0T?=
 =?us-ascii?Q?htdk3VU6KpmVJLw5RuypkR3bDco08Uu4H2+0X+CAOJWnZUC+NUhTKffmosYC?=
 =?us-ascii?Q?BYvT8Y4xgIGV/mLCtX8AVp9BQ2k3pOg4LacqgQbZTZhQK3yB/A9MREMs8SFR?=
 =?us-ascii?Q?TGlaFTdZEHg0Hl3YqZGyk8Yxj6rLUWHYlwi6mRoAoj8g3lcn/6tNIuycxGmv?=
 =?us-ascii?Q?jsbYDaQJNzlxBjmMpfb8H/5EisrzlRgCkjhh6IbbT//gQFvRtXpFUnXgzg0R?=
 =?us-ascii?Q?67cCsiAaCn9LcwMCDAMi7tRFbUUapPpy8HPJd4j9tGBnkh4mTvYI1Vcw6vS/?=
 =?us-ascii?Q?fWs4Hz7XXx42B1v/b8o2D/CcR7nBztU1U59hqu98Z20vGqkyYqqaJtNyue6/?=
 =?us-ascii?Q?7Z+h072NzsVNftYzfu0w0Aveitek3Sr9JXsx1ipuCyCn1swhJ1QMgoVhggSe?=
 =?us-ascii?Q?9fiBpN6W5557BPmm+GprJBKNp0tuCDtM0q8cMSW7uFhFfe1LYbqd3owqA3cO?=
 =?us-ascii?Q?fDtGAR9hqW6EaBt/4tYPBKh8g9at4MZnAG5Hg80pxxHA4jxQcIB6ryMvoxFX?=
 =?us-ascii?Q?SMg68kTsOcpZQVpflPkW78kyM9C2p5jk4QA3JEbb0eQwpv7lajtFM51QNeYG?=
 =?us-ascii?Q?v8J2JkKYnPbGjO+TBe8ggFJ1RKPxpBzVX4HhtXKILR4ST5tJbGZWXv0sgy7V?=
 =?us-ascii?Q?ofcaaqKUXmhPfq6iOZpug0Up4L4PRIGdL5pn+8kKkFfZnxYUdQGjZPPNDg/V?=
 =?us-ascii?Q?YtBN5QipS7wNvXPNvNJIJK7nrnWEdC8p3ry0TAzBMayZ10LzbfmtKW4oyJoc?=
 =?us-ascii?Q?IRiiMY+oXHMAlc0clUFI5R0/FoFdv2H/xNjxcIQK7QbXQ8kkGjKDp1ydoryr?=
 =?us-ascii?Q?tpwxgDBzAhM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NtB1H3szulT6vP085agkjxz9S3GUusqjlw+gb4Q2+cGGBsimCzjngQ6WxaJf?=
 =?us-ascii?Q?b+foxg7gLiOMovqRmB6v0367G5jeps+YXa45AFeUHqCq5Q+8peoH9ggCgoN6?=
 =?us-ascii?Q?1xWXol3nuN0epge05KgLikl5bhxfrAWmknZhPTeuzHps9JFVs3ZEmRgmhUTe?=
 =?us-ascii?Q?0yAE/5TXAF4peZzBkVIuW+aMuUU1W6dDYyq/AkL9UCC8e7R/4n/YwKyC18Dh?=
 =?us-ascii?Q?0V5uDq78CF91DpqaV/KbMKkqr0gwY/f8AnC5sy3B6/8EL3XUz6X98MR0YuLB?=
 =?us-ascii?Q?pjLdCgaGODA7Vwx8f9OiP/z8wVRcvK4mx2JOB/JDc+4wzEaj4llL8gDYTRPe?=
 =?us-ascii?Q?bXS08EL+ZDt/nY6CY94PdktjbfGfJt190uqhG6Tc3wG8DrUcQ9Kq2A+fVdEm?=
 =?us-ascii?Q?TB4+9wgUBXCRSHsuJ/fYnRaO5FWwzSCluZcCjQ+W9VgKJPdEKC4Xwcw5FU6I?=
 =?us-ascii?Q?rJMafGvHS0qlS6B/lWmAcT+AyfUVXZuooj5Me97Ymebdk34VTDp2uQvJiUBn?=
 =?us-ascii?Q?rGIaPUOEGDeFddGNay7Yq60sVXdpO+jBV8Hg+MuWgSV2cj30NLFIplT/2AdB?=
 =?us-ascii?Q?lscaj4f7aiRS+JigAN8n+DwRddbpSTIHWTQepFIlHCiamr9+MsTu7UZlRYw/?=
 =?us-ascii?Q?66ISlKwI3/DuzkzXdKDyIpsTyVnbpUodRjviy1eWSfeRB1kedpngzIK6CCXS?=
 =?us-ascii?Q?yPsoanbER74mQpx9xjUQbyB2Etsp4SQe22wBv1cVp5DloKyheMgbm1wkDdkK?=
 =?us-ascii?Q?jVyxX4ob1k8R6HntJ7HwWFtRBfpjQy/IoEL1ibnPkMkVsrAHZHnzUIMOjuwF?=
 =?us-ascii?Q?W3DGJ69Peq2L76VI/b98K4976cQkTaiRn4gY2z8fP2EAtnuJ4j6y5h2Pq4Hi?=
 =?us-ascii?Q?j5BDZi/2RPUWktDYzzoT0mRAT9wDTTwZhpNFsjFj3THItlbPmBajOGjaac9b?=
 =?us-ascii?Q?p85Gu7gmLXFYTw4xLUZYjMsAT0iMLStLnhymLKfiHv2qClDYoyj5e7c8mcpF?=
 =?us-ascii?Q?xcBHLj3kUeotM1hvP24oUBSE4GCj9rB+tb0zAFk2ksI1Otbd+V0GQbfel+I5?=
 =?us-ascii?Q?vkONPsBDp9K6ZRcg2SBLOgN24Vuw9XIDzcWQbOcTTAckUlesLPTE4MAFL1VD?=
 =?us-ascii?Q?MlMbanMm1Zmn5iOMpeprjJiYzJDusm2z5nMsTUiGesQ7y0GXVkrIEnHQmC6+?=
 =?us-ascii?Q?ubx1QH1UeISqbFDxZU8KTXAcnJxwORZPCbkCeuWkQ8gN7oQSCeqFL4NgD26D?=
 =?us-ascii?Q?stCvtSdesn72ZLuUwcrc8eCfCVAzOMvTp6+MoUbOiocpPh/Q/MUfohv+bZHT?=
 =?us-ascii?Q?ZeiWbIhS5vDwbbEnR5WoXVJlxZKgs6dfPHmxn/fhiCSH3zAAnLYsvfOuaZ58?=
 =?us-ascii?Q?tU86GTxOBKec0boMK8OuFq08Kn42yBnidSVR41lg8d4CyC3T1miR90Rr8rRC?=
 =?us-ascii?Q?91XeA4wXR13YP389pQWVDnAus89aJJzvCWmonDrPiV4lJC1ncSNFUQXKFiqt?=
 =?us-ascii?Q?K8OP6aTAnVBdGGSs4EWV7FJ6kw4j0EzMTTm+w1U0ZwvC6HNTYlWJdMqtHAZb?=
 =?us-ascii?Q?YYZJWrFA/TzhFa3ZzC31eb9ukQ5RlfpMWRXB81gd5v26ifAtH9nUrwuMNzg7?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd087f00-db65-4b9d-c731-08dda41c10f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 10:31:00.8319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FaDdWUgw7vCc+eoBNkVB7TT51WI0XuP33HUIKSKbydmYMLhwcmzmCItwYXWLPmivhlrbU5uUddIRZAHAf2cO68V9BVQNjoIwqk8QHa04N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
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

On Mon, Jun 02, 2025 at 10:38:02PM +0000, Wathsala Vithanage wrote:
> Extend the PCI bus driver to enable or disable TPH capability and set or
> get PCI Steering-Tags (STs) on an endpoint device. The functions
> rte_pci_tph_{enable, disable,st_set,st_get} provide the primary
> interface for DPDK device drivers. Implementation of the interface is OS
> dependent. For Linux, the kernel VFIO driver provides the
> implementation. rte_pci_tph_{enable, disable} functions enable and
> disable TPH capability, respectively. rte_pci_tph_enable enables TPH on
> the device in either of the device-specific, interrupt-vector, or
> no-steering-tag modes.
> 
> rte_pci_tph_st_{get, set} functions take an array of rte_tph_info
> objects with cpu-id, cache-level, flags (processing-hint, memory-type).
> The index in rte_tph_info is the MSI-X/MSI vector/ST-table index if TPH
> was enabled in the interrupt-vector mode; the rte_pci_tph_st_get
> function ignores it. Both rte_pci_tph_st_{set, get} functions return the
> steering-tag (st) and processing-hint-ignored (ph_ignore) fields via the
> same rte_tph_info object passed into them.
> 
> rte_pci_tph_st_{get, set} functions will return an error if processing
> any of the rte_tph_info objects fails. The API does not indicate which
> entry in the rte_tph_info array was executed successfully and which
> caused an error. Therefore, in case of an error, the caller should
> discard the output. If rte_pci_tph_set returns an error, it should be
> treated as a partial error. Hence, the steering-tag update on the device
> should be considered partial and inconsistent with the expected outcome.
> This should be resolved by resetting the endpoint device before further
> attempts to set steering tags.
> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> ---
>  drivers/bus/pci/bsd/pci.c        |  43 ++++++++
>  drivers/bus/pci/bus_pci_driver.h |  52 ++++++++++
>  drivers/bus/pci/linux/pci.c      | 100 ++++++++++++++++++
>  drivers/bus/pci/linux/pci_init.h |  13 +++
>  drivers/bus/pci/linux/pci_vfio.c | 170 +++++++++++++++++++++++++++++++
>  drivers/bus/pci/private.h        |   8 ++
>  drivers/bus/pci/rte_bus_pci.h    |  67 ++++++++++++
>  drivers/bus/pci/windows/pci.c    |  43 ++++++++
>  lib/pci/rte_pci.h                |  15 +++
>  9 files changed, 511 insertions(+)
> 
> diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
> index 5e2e09d5a4..dff750c4d6 100644
> --- a/drivers/bus/pci/bsd/pci.c
> +++ b/drivers/bus/pci/bsd/pci.c
> @@ -650,3 +650,46 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
>  
>  	return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07)
> +int
> +rte_pci_tph_enable(struct rte_pci_device *dev, int mode)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(mode);
> +	/* This feature is not yet implemented for BSD */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 25.07)
> +int
> +rte_pci_tph_disable(struct rte_pci_device *dev)
> +{
> +	RTE_SET_USED(dev);
> +	/* This feature is not yet implemented for BSD */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 25.07)
> +int
> +rte_pci_tph_st_get(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(info);
> +	RTE_SET_USED(count);
> +	/* This feature is not yet implemented for BSD */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 25.07)
> +int
> +rte_pci_tph_st_set(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(info);
> +	RTE_SET_USED(count);
> +	/* This feature is not yet implemented for BSD */
> +	return -1;
> +}
> diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
> index 2cc1119072..b1c2829fc1 100644
> --- a/drivers/bus/pci/bus_pci_driver.h
> +++ b/drivers/bus/pci/bus_pci_driver.h
> @@ -46,6 +46,7 @@ struct rte_pci_device {
>  	char *bus_info;                     /**< PCI bus specific info */
>  	struct rte_intr_handle *vfio_req_intr_handle;
>  				/**< Handler of VFIO request interrupt */
> +	uint8_t tph_enabled;                /**< TPH enabled on this device */
>  };
>  
>  /**
> @@ -194,6 +195,57 @@ struct rte_pci_ioport {
>  	uint64_t len; /* only filled for memory mapped ports */
>  };
>  
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this structure may change, or be removed, without prior
> + * notice
> + *
> + * This structure is passed into the TPH Steering-Tag set or get function as an
> + * argument by the caller. Return values are set in the same structure in st and
> + * ph_ignore fields by the calee.
> + *
> + * Refer to PCI-SIG ECN "Revised _DSM for Cache Locality TPH Features" for
> + * details.
> + */
> +struct rte_tph_info {
> +	/* Input */
> +	uint32_t cpu_id;	/*Logical CPU id*/
> +	uint32_t cache_level;	/*Cache level relative to CPU. l1d=0,l2d=1,...*/
> +	uint8_t flags;		/*Memory type, procesisng hint etc.*/
> +	uint16_t index;		/*Index in vector table to store the ST*/
> +
> +	/* Output */
> +	uint16_t st;		/*Steering tag returned by the platform*/
> +	uint8_t ph_ignore;	/*Platform ignores PH for the returned ST*/
> +};

Looking at the driver implementation in patch 4, I realised this use of the
info struct for "get" API is very confusing. You partially populate the
structure, then make an API call, passing that struct as input, and output
is also filled into other fields of the same structure.

I dislike having the input and output fields of the structure mixed. Can we
separate out the last two fields here into a separate output struct, or
alternatively just drop them from the struct and have the get API take two
additional arrays as output, one for the tags and another for the ph_ignore
fields.

[Note: documentation also needs to cover what PH is]

/Bruce

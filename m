Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91DD2505A
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 09:14:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1EC140288;
	Mon, 12 Jan 2026 10:14:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 93A604013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 10:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768209259; x=1799745259;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iD7mglrK1Xwrm7ytiT+3TpCTjvZotQdRJeiMcjd7SFM=;
 b=kVUON5t+HmI0+z6wnu4qn/8GumredzDJmTspEzKzkriixcz0nanGdyAl
 ArTfjBLF8EoZQisyhOdN4RDDseqL+H86K0Uh5fh06ga8jZmhqvUB2XVo9
 sm+EoB00TLeCZczb/Y+97aRhF1OPFwgBOzgCcUTSHa83x6ARCa2LL5PA8
 TQTaBiV9hOgN0CeEPpMnd1JNN+9HF+v1mZoU8gjvBpi4SkTziihL9MdvI
 dUmbZbs6od2rJAlvSqwy3cQQiyd1Dw6pMin6dng6+hK+mLpICGK+Nmnrl
 A+uC3RjyQyS0+pVA6XaMM4O2JM7qFTFAmOfsRzeRdNCmiL+D1n7GUgVNt w==;
X-CSE-ConnectionGUID: 1ZzwK7+IRuWKdeq1iW/Ryg==
X-CSE-MsgGUID: hk0JMcDdSquli3CCCPFT9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69531296"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="69531296"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 01:14:17 -0800
X-CSE-ConnectionGUID: lIZyrglMTOmoKAYiuYPnaQ==
X-CSE-MsgGUID: S3h6ZPbLQNKRyVi4L9UR5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="203256835"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 01:14:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 01:14:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 01:14:16 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 01:14:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lfp9WPrEtXsqLSvcjy0JQMFJIOvTBGe/HbQmfMT2OX0O3A17JCRQhGKj4KhceiOcoMegTXj4KlrowP4Nmv5du3MGM0s8Ip7Pa6nqN8KMFocDOwaYe3f9v7/PtQC4GXMWni3Ubithsyu2c3V3vWQsAlghxN0lfpf0ZwLLmQQCsUfo36LiNLO8WF5rJ9OjigT2eLWs6L6cF/mDKiBwGYOdrHGYHe20U3OfS/LEHrp9Edl04ttd1DHXUVBEKXGIFKt1VEPJuF7c3QJ/c6QIipe7RTQirHSYKZPbhP09WulqSXmPIfzUDFlJ7YMYyahIowsyAu8l1iiT1w+NLJcInxIyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCPQoT2Da0mdq0YRtM4gpJ9Zz/rBIO9CBFQAQ3D+CAY=;
 b=iSTxE15IXjEcQ4q65E8XwQ7q1zgSectxRHBYLiD9Y4ZDxSqaaZdxZFhmWtoxjwgTnndSQwQl76dqOUrHHON8LUz2bw3eKEgyzR18jthxJE0SxnvioEiQ6/3EfQ/UEKlsj4e54KVEdyGINeEVOtUcE+QjCUFNytInE1OzhhBra7c+NVcSPvP14jEH676aietn/4Gn9ErvsLBV2cGhRGQseLfWUcIL7QrZpdUrNTxv9AtBifaK+cWE9+WGgmA2Q2EeXAgLybsLHWI3hGa5vgJ/Q7hNcx/3bOx7Y0hyi5LTiGiniTOzBZ8SJKkToPC5EbI/K1tSQ8n45TXwaA8G1xcJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:14:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:14:14 +0000
Date: Mon, 12 Jan 2026 09:14:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <scott.k.mitch1@gmail.com>, <dev@dpdk.org>, <mb@smartsharesystems.com>
Subject: Re: [PATCH 1/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Message-ID: <aWS7YdU11DNPbz4o@bricha3-mobl1.ger.corp.intel.com>
References: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
 <20260111150033.81760-2-scott.k.mitch1@gmail.com>
 <20260111075919.082d12b2@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260111075919.082d12b2@phoenix.local>
X-ClientProxiedBy: LO2P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN6PR11MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0bc923-f221-45ed-93d9-08de51baf4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GSadFhS3LPkeiVPvsvaLe5szYu3KCL5xu5I67NqeBApmfZQ4vFbgQM3mg7pS?=
 =?us-ascii?Q?ROfWbFEPQ7wFfzbLV8dS97G5jdU0H1zw3aVWb6Po9kMNfyXXsO6FC3zG93bY?=
 =?us-ascii?Q?ClC8SDANLuzRhdktLMQMPhLg94vmr4darf81TVirt2S2jEdztDDXjnG75LQ2?=
 =?us-ascii?Q?MNZLxJNpiXPiWsU1hI+xQe10ZXLD18tCieSmCYDBsC6+BFwt+sk5uoSVyowe?=
 =?us-ascii?Q?svaEhOCEJfflgeh3FHcxJkSy83ZegsZ3h2ULa+NhPl2hNL+5Nay5IFncyPEQ?=
 =?us-ascii?Q?i4g1TLOogXJbLSZqBPHqT0jqm9+ytbPCO0IjgzOynDIEmQyNWyJ2BmZQJhvd?=
 =?us-ascii?Q?eQdmDoB7QsMQccQwMDWvWosB9wknNveihhsEzsFypB1fwZR2eoRBt6lrYnpG?=
 =?us-ascii?Q?vdMamFEwa9ES+KhCSEidSmf/N8+wp6zLbY3ijuiWTqEfh8z3N8eavStVCeG6?=
 =?us-ascii?Q?nPpGcpDwjt/OCrVk2Sr/NkOjAKvMVUHEjSqg86V1pi2gAO8DNZ+MxBQQbKI8?=
 =?us-ascii?Q?MbL1ah/YIv7tzqjS3EcFYdKFsRQXLdU3z10XZ/K5s5AEd4dwxvbKB0JKXqEK?=
 =?us-ascii?Q?NtFKXpCmYzPzUCluUt8udSwZysGDHi3wxH1alR5v9BrWh/zdarbV03LU1aq/?=
 =?us-ascii?Q?/XQ2p4fPyeKekfyoLdow+E9nEt5bJK5qfQqXyZknwaRDvUq0IqvVpxWJhnVG?=
 =?us-ascii?Q?0Wn8jzMhKzQG7bY2uAGz6393l0jFNWlLs3HmKlfRu87Le3YH3tCyEqn+uaSW?=
 =?us-ascii?Q?96c+61PbothrMr17plJAw1OHsMRT09xRAhSknQSDvI98xRYD4orx1ioANqH4?=
 =?us-ascii?Q?cXQVBsJtMFIKfZcjplIJC4UYZCrHfWKksd/Qj6CM6lSDZW0b0lyeS1e5RPZr?=
 =?us-ascii?Q?PTdmyIiFrF9XIR+/5OHiQRGftnV4khCcu1WqAESCAVRPtz6Ig9RI5WgFvQ0q?=
 =?us-ascii?Q?jGDQ32rdcyFpC1s7OSDji8SoZaZzGStI8qEWm2AUD4opVKJiuWduBxRoNSXX?=
 =?us-ascii?Q?LkFnS1lpOE2BWa2CM/MyYCLjW1wYfEs41i0eFIUqVsLm23OUYBBImgmGsupr?=
 =?us-ascii?Q?Se463MJkBIqViHkzILjoVFrSgp0b32w5iBTNIEklq3KYUJ2VZre7+Y0RDk1r?=
 =?us-ascii?Q?D4EQ5YDYhaORuwWli9rJ0CEi2X0gb5vAjAqcHTAF7WoffkTYgDplBupkI0BS?=
 =?us-ascii?Q?99QYOOq8OC/+4iVL8DioQtZSVPtuuzCnZm/X2lCNWrb53Ovyqw1lVEe1souS?=
 =?us-ascii?Q?o7OWMg7739B5G8djRLE1EvanL5d7Dkjhwf7oA3/90Nhs1TETo7SDjFDujwP/?=
 =?us-ascii?Q?fFS/HpiP8XZbkzirTdFb7tsGyg+ScgBCT6SS/WAufFjIHrH8BvGgXjD7iUne?=
 =?us-ascii?Q?Rdkw8zuI5Uu2pkTnyrL0NumxvW9eoSQLm1QP+8EvhBjXSQcIOs9fSZcHugTA?=
 =?us-ascii?Q?e8XAkVQpZQeutTGXuR4lpFFbkRU2ad47?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YHgIrjeJ/zVYVoLZWE+0SrBNQuZmmbYkJjYRYmZQdpMnowckCGSix+TkLkW3?=
 =?us-ascii?Q?0c+fJ6DgR7pojO1C3qDP9/hc97l/oJpCun51ifdgEwmWzkdpNQwy2KPjIu+f?=
 =?us-ascii?Q?wNhtfoeOksuj+PQrAAaOGGaxddc/KFbyMchGAC+zjDL3Bv6tRt/SR/yFg73h?=
 =?us-ascii?Q?XaKi+odPBGBE/FPDr4DDePwODiZf4nx8SUR/Y7DpBqWpenqc9oNsUenlxoCn?=
 =?us-ascii?Q?eZ9aLUK4m+hXLLPjO3n+eFBZqbV39jZ1pC/GL6nyGcD5xJc09ICXaWj/Z9Js?=
 =?us-ascii?Q?X9Asjvs+yWp7qs8XelNBd20JOwZDEdv38TN5EL6lrOsDxzD0LgXkb87t2n81?=
 =?us-ascii?Q?w3gPklC22Bru5MJRSQTli4naqPHUxnixqGUYRYCv0tb0SdSaTwhCQ6y9haZu?=
 =?us-ascii?Q?4vcVZyBtkn8AaZlfguovgIKCyM/s2vYgj/U5dyQW9zC/WcTHOv5D9fGHAUCE?=
 =?us-ascii?Q?e1X+nozjekv2vu0sZ6P/JFTVxmHUr4HDdXXX5rsvBDtyKkeCukwhHiDmc+cP?=
 =?us-ascii?Q?XSrsU3UFGkB0xmXD7ebvg9hB1WEjlnwfTGSerw6SFMMNK8l4VX8dWakN5QHU?=
 =?us-ascii?Q?0cIZCzENEHJMtg1fxUccZdweUtLyoyFbu3VtkSCLuwsP8yegynJ2atrQuxlw?=
 =?us-ascii?Q?wMYU5Vqaw7rmBzdRKsj1EepUvmGSqfMGNwhM++9mtDv1rLtnLGfp07q/t3gV?=
 =?us-ascii?Q?AUih4M5U4Uan1kgF45q4u5W29SatUmm7ZVhk7JnqlYYqLFscCW8n1AGSLlru?=
 =?us-ascii?Q?+LeU3I5Nk6Z2BhXCr4a4p5/hx7neb18nhqaI94b0NOlJ5stMVAlWwv77xGDh?=
 =?us-ascii?Q?3ilJG7xBjy8JRFYJePf62JvbitcAdbARfoaveAa4TuuVIjFpx0ZjpK25MV4+?=
 =?us-ascii?Q?zI6a6OV4Xjzs8uSmiYPgQwc70X9TeCpNKQavZ+Mpf2QEOPU9xRLnFGH5osos?=
 =?us-ascii?Q?Be1+lAnAbhsqIl85a4YcfDQ9E8dV58/UuVTgE6f80CHqykwS3Njv+LdHSEf+?=
 =?us-ascii?Q?Oa4bSKt78LStgVL4nuY8W4Fvj9KaeF0tD8uLLA1HbiF18CgL/lpoo4ytVO9f?=
 =?us-ascii?Q?9GO9bcCxTk+GipdryGPeE4x9ACNRBWq+Slf5resF0/WiETu9Tj32w8PUCVMZ?=
 =?us-ascii?Q?NW3/6g93Fhd1AoswFR5veCncJIugz4NVh06zNOn2dqj8pP8unLQCiHdusJM7?=
 =?us-ascii?Q?PuBKgSMo2Ct1yOB3rlYmZvoXv4nta4xQq83VQNizHpZ6B48972x6u9QHE+W1?=
 =?us-ascii?Q?pxugJkhKgbOH23gaqyW2OYvrwYz1I2F7FXDRe3vwZnZ5buv4ebHtMJ+L00Ft?=
 =?us-ascii?Q?23C6opkuFHgz8pOPbE5J8zUG3a6VnrxuQOHYkp+qkHsn49A0Q+uGVBAvw5mj?=
 =?us-ascii?Q?XrAdkduq3gi+u1QuEb513nTiyuO3OIAAfqYUKouHNRAIARcvEwK7pHglp7sW?=
 =?us-ascii?Q?OztXAaPMDi3pxZqcProRCrWkvysQSGm6hVelw5IovGP5Te65qskmzQZhZvwG?=
 =?us-ascii?Q?liiRNt5nKfGDHUaJ1As7AvxPqCtyt/KmV6S3/+9zoLAoznSrKlEn2Yi9bP9E?=
 =?us-ascii?Q?j1y+KsMO1R/Ct+fPyQJd7MRDkmIJRWfi/o55wlIUuU5uROnKrP7EcBkKal2s?=
 =?us-ascii?Q?asLg6+bOCNPh4GHZtzEdL8C4YvW5X5ETLCv2omOMfn+iJoyWUjXDVt1exafZ?=
 =?us-ascii?Q?Fo308etm71ZsLexbOTVPl3RxbekROrE7xuxlKnShMq85ceiC1ksCxZGryW88?=
 =?us-ascii?Q?bakANVYXmiOJ/F9R/TCqOEIWCxNLloA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0bc923-f221-45ed-93d9-08de51baf4ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:14:14.4755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmI7PwYM6sN8mN004jBPrCaaHAAhGnZM07h3c2Ez2EjnhKOJWi4fKqG1bSv+ECZN1NPVaxsIi2mwdOgY7N2OmmDAzkfNHsBE134uMiQU/3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
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

On Sun, Jan 11, 2026 at 07:59:19AM -0800, Stephen Hemminger wrote:
> On Sun, 11 Jan 2026 10:00:32 -0500
> scott.k.mitch1@gmail.com wrote:
> 
> > +#define RTE_PTR_ADD(ptr, x) \
> > +	(__extension__ ({ \
> > +		/* Diagnostics suppressed for internal macro operations only. \
> > +		 * Compiler type-checks all _Generic branches even when unselected, \
> > +		 * triggering warnings with no external impact. */ \
> > +		__rte_diagnostic_push \
> > +		__rte_diagnostic_ignored_wcast_qual \
> > +		_Pragma("GCC diagnostic ignored \"-Wconditional-type-mismatch\"") \
> > +		/* Uses uintptr_t arithmetic for integer types (API compatibility), \
> > +		 * and char* arithmetic for pointer types (enables optimization). */ \
> > +		__auto_type _ptr_result = _Generic((ptr), \
> > +			unsigned long long: ((void *)((uintptr_t)(ptr) + (x))), \
> > +			long long:          ((void *)((uintptr_t)(ptr) + (x))), \
> > +			unsigned long:      ((void *)((uintptr_t)(ptr) + (x))), \
> > +			long:               ((void *)((uintptr_t)(ptr) + (x))), \
> > +			unsigned int:       ((void *)((uintptr_t)(ptr) + (x))), \
> > +			int:                ((void *)((uintptr_t)(ptr) + (x))), \
> > +			unsigned short:     ((void *)((uintptr_t)(ptr) + (x))), \
> > +			short:              ((void *)((uintptr_t)(ptr) + (x))), \
> > +			unsigned char:      ((void *)((uintptr_t)(ptr) + (x))), \
> > +			signed char:        ((void *)((uintptr_t)(ptr) + (x))), \
> > +			char:               ((void *)((uintptr_t)(ptr) + (x))), \
> > +			_Bool:              ((void *)((uintptr_t)(ptr) + (x))), \
> > +			/* Ternary with null pointer constant: per C11, if one operand \
> > +			 * is a null pointer constant and the other is a pointer, the \
> > +			 * result type is qualified per the pointer operand, normalizing \
> > +			 * const T* to const void* and T* to void*. */ \
> > +			default: _Generic((1 ? (ptr) : (void *)0), \
> > +				const void *: ((void *)((const char *)(ptr) + (x))), \
> > +				default:      ((void *)((char *)(ptr) + (x))) \
> > +			) \
> > +		); \
> > +		__rte_diagnostic_pop \
> > +		_ptr_result; \
> > +	}))
> 
> Good idea in general but the macro is way to big and therefore hard to read.
> The comments could be outside the macro.
> 
> Any code that adds dependency on a pragma to work is brittle and likely
> to allow bugs through. Please figure out how to do it without.

Do we need to handle the case of users calling RTE_PTR_ADD with integer
values? Using this macro to essentially cast an integer to pointer seems
strange. Even if it's occasionally used, I think keeping things simple and
just globally changing to use "char *" is a better approach.

The only case where I'd consider trying to keep compatibility using
uintptr_t is if the pointer parameter is a volatile one. Even then, we can
probably handle that as with the "const" modifier, right?

/Bruce

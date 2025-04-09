Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BFC36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 11:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B043A402CC;
	Wed,  9 Apr 2025 13:31:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5C36E402B7;
 Wed,  9 Apr 2025 13:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744198297; x=1775734297;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/wJfiOxISOtfJE0ADPaeap2xb0S17VG9YAQ37Yp9oKA=;
 b=iruc1tiEzeFKAuEZtI3WKMfBHecw8vQsXCv6/6dkCMr0yY0tnVDjciRL
 lONxQAy3V39Pk4Vbx1D51ll7aEDD/4movZmu7R+TOo2Wzx4Od4WRLfb50
 zLjvfarerrp8I64SWFtJZTju8nnykMFRA2QhvHiyWaLfxbsJfaHis9qLL
 peFgvb3ASgZoBjd6KL+EbVMLt4JxOat+HVv5R3fP/e5nBfvsqF9U4p2Hf
 08MJctuIuQZlMhH6y9scPvka86CtgYYMusUgX2xodSPwZ9qANtDVJN6Qm
 6Xmx0F7li8SwvM0bDtYe9dtau5GiOsQosanjv3+HejnQuopKIsjpn1nko Q==;
X-CSE-ConnectionGUID: m00YS4ppRAuT/jK8lWKoag==
X-CSE-MsgGUID: kmAh5sBnRBKUdFN1fpNzTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="57038275"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="57038275"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 04:31:36 -0700
X-CSE-ConnectionGUID: 8xEv1OFYToefws9yOVbB8A==
X-CSE-MsgGUID: cZKJlxygSfmynmlk4r5qzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="128297431"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 04:31:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 04:31:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 04:31:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 04:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATLYdHZMsVfOn80dbqPDu6k1xlTBkVkNxMJxLV/Hw0gRICYq1qJWXwlMKS8L08/K6Bbuk7aNXq9qS8sA6m2P3dzcN/QlzBKvoxvDQS5r8vHGuhH32nh+p+l4TdFGaUd4CFUz0CANVtbXC5wnonehG6D7du7cwM2q/1fexJ4CLsS80Bm2pFQPbnas/tq82EL6W+M/+yCmarR+bEfyrzy/CbMaVfo2eqA3+wwRGZHH2qJWM5K7ZPDiswtjLWf4AYvvWqt8DaZ1+LU90c/dSRtLxNgpU3vq2KW1wWLdwn3XjpqjX55dRW0EH4Uiiu3ZdJt/FDurUKbPj2mSNnrqFT6PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VrujXnW8Ivr5UZu8DE0HC6mxYZNe/gOh4RM0gDZrT4=;
 b=cyzTvMGdftES4gkPghWzwzx9c1ZG8kB5VZzrVpYdbmOBLtW0hVCpcssGT3Rl0aX7ONZQu2KFzQF+NBcw5p877mJDiVlI5rw+mKky6iQQ7ySHZKWMhqGTGQ2xJQS96qlRvcZX3tFgGV9ZxdkBScSpsznu6HmCcNrYTu3EQdcc/8BetuBNB8IPPjR5/ZcfAXa+fQUHA7vOAfL1rWkPuy4MyrYMG012+Pp5UrWhrxuMUPI/ehZLoVpIL/jwaBDZfsi4U4Lkouk7gkbyotpFIQsF4On71ZMsm8cr7EtNVBIW0jL8i2hZZcLuxhytyVHnrZgXfnaGAqsmC0tQYL7AEX43uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 11:31:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 11:31:16 +0000
Date: Wed, 9 Apr 2025 12:31:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: Re: [RFC PATCH] build: reduce use of AVX compiler flags
Message-ID: <Z_ZagNDgzV-yl5dy@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB76@smartserver.smartshare.dk>
 <20250326122036.6cc7c02e@hermes.local>
 <PH7PR12MB859614316DC742F0C8A12B3082B42@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB859614316DC742F0C8A12B3082B42@PH7PR12MB8596.namprd12.prod.outlook.com>
X-ClientProxiedBy: DB9PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d92cc3b-05d4-4148-b57e-08dd775a0aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQDUQOKWXIQmdvvlnv5eZtsBxxINBmRNWpDKKtSBrg59n/Es5HMEPbPaPIKg?=
 =?us-ascii?Q?Eu4V5Rd+wsurElQfDBKYRUJMg7Gesy6th/GKeRfOnU3Lx3k94J9x+WtkE0nX?=
 =?us-ascii?Q?UZZAv/zvv5NXqSo4uiHwkpnJcVYFvFpxyxnWt44O9g4xqzW0Jjbfl1UHUfX0?=
 =?us-ascii?Q?99oMVfvjQ0T8tLavU9YnD5uSOamCm3avWRGM6CYfjdgPCA7b3gxEliXIRXTG?=
 =?us-ascii?Q?qn9VD9Tk9EI6OcBhiriiwpK9DDxVKXC+TXoUNmPRdU+K9pOTy9q5dyCofM/D?=
 =?us-ascii?Q?jW2ZLgRLdngNKCB/H/JfFDmZ14g1xWjUqx1rTbCgonlN61gD8mcJLjHOeeIc?=
 =?us-ascii?Q?0caooHEuhQFIG/pKUNeDbryjBJb/3u++R9gxMJIbparno6kxVSK74uADzxUi?=
 =?us-ascii?Q?EnVtnDz8FuBf2lSxXxzZW8JIYonj7hjL44lGMhKKuAAeZKmKtXcdbpnK0Zca?=
 =?us-ascii?Q?TsVrlCWVwV4gwHAlNo6KafE1Xxth95q0DW1AX10Behh1VWTJzEQZb3BCxEUl?=
 =?us-ascii?Q?H7chlke1GU8fc6SmzsCJT7Sj98rD1ejH9+Nd64rrTICJ3j0UL8TfWBrq6oEn?=
 =?us-ascii?Q?3srQKAx2WJcJnb3f3okJOy1zSgJtqiSlxaNn6GwqKknB2WWdcpCYMlShmtcm?=
 =?us-ascii?Q?IvK9vFsjG7ZHOE46H/wO370p3L4lzN2D9vYbJcFj9klloZB0pi5+i1R44n2L?=
 =?us-ascii?Q?WnnLqWSBZg3w0hIAvDA5aYk3PmVU+5HG+E/x+CpjEJu9nWaktdfj1Zexb7bs?=
 =?us-ascii?Q?n5iTHXd7XMolU9dvq7B48D96MdWsf6pICn6wJWPyyhy0fWtW81J/eNc79ZaV?=
 =?us-ascii?Q?Xy5K4wW3CNMaUXA6komPL/GblCHDB/WXyn9HAgfSXvDuap15tR3SsWVhF8W3?=
 =?us-ascii?Q?fz/fpQa5rAlbZiBlj/bAIiicZ5rM2k2FLlhmSmn337I+eEi9UPrX8sv1/1Nq?=
 =?us-ascii?Q?h0eedH+zhb21k7ATwsWkneWmHdcsOf6ZLO0fVmjCeNjKPiV0pNztuYuikeel?=
 =?us-ascii?Q?0cb+qNb7qSJvKhNtX/IVSo/3SU9SqwnYDQkIPH2kjTwv3DWzgKlfGw765Wg7?=
 =?us-ascii?Q?5hpL76DHc3Oc3eyA5dbkO7IcmwMIgjtFs48c1DoIBKX7zMaHPVz25SshABk9?=
 =?us-ascii?Q?+nOyEmrc3xMkO7JvWdaj/ExYZv/pyUhmvvnfRzpIQ7ZmmyUmb1dBF/Nam3Sh?=
 =?us-ascii?Q?qSws7spB1FGSBcPiSq07dYvpp/tDrU/ui2Vj7xwmR2flUK08KVo1fomU/jYi?=
 =?us-ascii?Q?5myZJko06i/Z02ca/MULJzfENtZWUKWD9gcSQ/RGJFg8iB7Hjw8rXzX6Gx9V?=
 =?us-ascii?Q?tJUVeaUCwfK60dKQgX/aP7Q6K/Y+R6tXRIoiM3nW/YCMBtI0Fvv4L9iBzvcs?=
 =?us-ascii?Q?mZJUR/KdPqvHIm9CrTySVvxcZNyT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3viJmp4BXKsdYVsyZJxNF1dKFryZbf7OnbFLQeopNv8CcaZrj2rvVn23Wr7w?=
 =?us-ascii?Q?q4oA1nhF92davOsB6NHyGfSyB4SN9rKU9QlyAxCYBT478SJAivjqVgs41ZC9?=
 =?us-ascii?Q?5ZL0yCt7Ok+ZGoXENdzgxEjsiu7TaIB3XX4hJrLLCilGJc6E1mULFCzBAcZz?=
 =?us-ascii?Q?5ITzuciSl/HkEUhB7CqvAlISluUUdIxVccoVMZoQ5K3zo9REDySW2sgdWaSd?=
 =?us-ascii?Q?2jg7gVUEsb7uW2ETBJ03InVV/4l3GxUIw7VxqwfuzU2PruaVb3GVTepbUVje?=
 =?us-ascii?Q?H22+9eIyxm7ya58Iw190Z0NDop3NYZPSIeLpcoUcqMEAU0QkGKlYRomwy5Kt?=
 =?us-ascii?Q?Kq+Z/9DRbPWrSQEXjO/YpuYJF/9vkn0wfX2vizeG2Rzeg0LKJIUU+x7IocZD?=
 =?us-ascii?Q?KR0xgRXsgy3P3oFUOHdBC51uYc/v2ynT9FDe9jlxmrOBjF8tR1HImP7aKrSC?=
 =?us-ascii?Q?SW7BDalbNGxTJcISw0mcSxuzFm30wc3zEix4UfG1ZT1QQ/Q+aynL/AQ8H2V4?=
 =?us-ascii?Q?dqKAaD6EIkNRN5hzApHd+0pnQz6VzpObh7AoANpCi9TjLIBkDtWiKdAz9Jdn?=
 =?us-ascii?Q?Q1pbkDVHRU42CegFZ0xeAHn3TmxJ9h484r4fekrC2nPdyWkdMbIbQ7I62v7D?=
 =?us-ascii?Q?ipuw9hiVAbK3laRL0h1dhCFi9cKSJcrqNwa2rwXLu+Z0cC0C46mVORNgqsKP?=
 =?us-ascii?Q?P3LBueNSnLEC6uNxxboKkiEjSd2znKc5XCrLH+jZc+uOmaEJI+F28e+iyW+s?=
 =?us-ascii?Q?cDMcmySTmyNMDD2u23ckt6vS22T/tJMnDYS8vBe17fMEP4q4CcaULowWYqcw?=
 =?us-ascii?Q?5B3cTrfznFKCAT4viIGH23O5eZN1bjGYBoOmOMs7BO02NKK9qwOXuWpXstFe?=
 =?us-ascii?Q?t1iE0YUnZdqLyTckBNYhP+uqxoA6b/4FZzPgvH16avGDsRdGbur8zAAIk+fs?=
 =?us-ascii?Q?dWCZPLZiKoso6E3BRzyDPrKgVAERkwJmxz1Rf2KtwOJWxQnNok0Zd45tp2kG?=
 =?us-ascii?Q?Ixr+1+gCj9zoLF2buK0qTCIrvf/V7WJN6kJY+FYEG4HQcjb2V1NQSuwJ5DVg?=
 =?us-ascii?Q?HDuBaCOsXO/rLnCuijXJdNYQOQiUdfcg3knh3IHoMzl32vAXpldol2Bp6QkM?=
 =?us-ascii?Q?rRUa13qlOAqjl6C5Yd8cP1i3N/6zMD0D3jdJzMkDL8XCeTM82O232IpcsFRZ?=
 =?us-ascii?Q?/Ffd0K/V7KTI+O9f7x01BKZhzgVRE8bjRGh730jn935tHaO1gZV9i/Cgz0B1?=
 =?us-ascii?Q?t+DRIkQJPdcbUhCEkGDUfj95a8Sm67kQdo0G1oFh3F0mW0iSFQDWxMZ6hEdo?=
 =?us-ascii?Q?kOumBLICcaT28Nf5DTgZ1zhm6QpPsQaVfg/udEEH4SjvPWIQm7G6tg0RnCR2?=
 =?us-ascii?Q?YyltVyFBiPCaFlGS6TqM7pdy0tprvjn0w6fTKM0fRr0difAaE9tYznNerRUi?=
 =?us-ascii?Q?f9d8LkuqqD4ZYMB1bFg0bGlS7+Wr4wV/fVmB0nRhV5K3yalsGyU5NFm3yaBI?=
 =?us-ascii?Q?dVdjC+OKl03DWP/funUY1Oga2oRFF3rv00L3ZlsK0vv+S5IBeL4VDC6bbmjd?=
 =?us-ascii?Q?K3AbBiyS/y3IZKT1pfQ3xYmTuwql5vaEXGwqXhPkwyXGhiLinz/htKqfcEjI?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d92cc3b-05d4-4148-b57e-08dd775a0aa3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 11:31:16.8444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f5V76ZCxIdZnNQA1pP3FYB+ADKDBq+kTNIBUggDL6m6YKpxJxWtCK4iC65jnSRISx8OtQglwOk78TGaOM1HUwo4GCkOen8VPEzAl8xhjBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
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

On Wed, Apr 09, 2025 at 09:53:47AM +0000, Varghese, Vipin wrote:
> [Public]
> 
> Snipped
> 
> > > > > When doing a build for a target that already has the instruction
> > > > > sets for AVX2/AVX512 enabled, skip emitting the AVX compiler
> > > > > flags, or the
> > > > > skylake-avx512 '-march' flags, as they are unnecessary. Instead,
> > > > > when the default flags produce the desired output, just use them
> > > > unmodified.
> > > > >
> > > > > Depends-on: series-34915 ("remove component-specific logic for AVX
> > > > builds")
> > > > >
> > > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Hi Bruce,
> 
> From AMD end we have tested with gcc 12, and 13.
> We tried cross checking with and without patch for libraries such as `librte_net_ice and librte_net_i40e`.
> 
> We did not find much changes in the assembly code generated.
> I hope this is expected? Can you please share any pointers?\
> 
Yes, it's expected. This is a simplification/consolidation, not an attempt
to optimize in any way.

/Bruce

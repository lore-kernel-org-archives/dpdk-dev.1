Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C87EE7E371
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 11:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ADFE40E40;
	Fri,  3 Apr 2026 13:10:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 11EC840296
 for <dev@dpdk.org>; Fri,  3 Apr 2026 13:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775214616; x=1806750616;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=o0dXCwpr+yFy4tECSAWzj8m0i+lhR/32Ji5u/coA/ic=;
 b=TK460xz2lGcUrlk/gcSAJUOUM/Uu/58cnwpeFAkzbX5GVNUUDKUwmUXi
 GvirfMZnvOf4DpVwHWqNlgTHouiQj9hYiM9w69U/uJPOOFyKPXsVnhHb0
 O4nixK5Ry9DglwrLLcNNNI6CKDL/bs1f2Pz5bazwStpjPTHUu/XgIgOM4
 pCkwa0rRLUwsx+Ps2PmgNfO66Y+NDKdvJ46xLRfsNdcKOQ0MPp5a7KD8B
 l5B3tmaIj8ioZQRFNtio6/kix5LkJ0rOgr/qXkVhITjdIT0ByeMeHrb1K
 5vuhK5I6oQjyUtoJd9AFodQYvG/6kG795LQs21wi0bWAowvVhBoEIpJp+ A==;
X-CSE-ConnectionGUID: fSPEFtltQweLcKIzuS+SFQ==
X-CSE-MsgGUID: SxVSOi2YTjehpUZUsQX/+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="101729913"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="101729913"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 04:10:15 -0700
X-CSE-ConnectionGUID: N252yLZzTWqLpT1CocJYsg==
X-CSE-MsgGUID: 5DFls5qOSsm3clIrFL7TCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="250452254"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 04:10:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:10:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 04:10:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGigF3yr623E8IOMctEyWtCOXY3nIk3QoEXWXvVfnY5HFPK+keu3TRn+4gdyJ+UKeP5Xe1Rd8ZCzZyqPFzAylMVjgN9XwaVvscBD8eFz8IgDY5sQtovMo7gM+yNbFGB63Znemg4TsOgvLuQ3LgUKmxHt9/V2n6yXEYDo4Cvlvf/KZNP9z7ioTVC+GiYTol7Qi+ezK4AjA4MrkHd0Rfz3Uad8jxyL5Do6k8ahWmBf83obJigXTdSbwkO2JWGcr1HZ2LPb0UgsthEETBRyhK/rJ+vul5T1s4p9WoTc27ouPfGJmlhWCSwxodFxggOMwez7pNj1MMNFTgfuvsnSx1Pc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNJ4rOvB6kBAYecbNwX0Pd7+7ODIZokxzQrj+7JTCq8=;
 b=Cl/Sn15TMk/DjDs0ifAHL5LS+ERnuXpCuSSI10/flFXabzmY5LhpqF+YLFSVzlzI1TjcfNc3GD6D9B5JyIW9+l7SQVgRd1Q1E0vzXUVsdUSvju0Y0JVeUEq2wYH97/1Dw8iDxX/a9K02VghZedO6DUrnLJUYkxF2kk+UGIT4JdDO5rOTJ3107OakY2MM0WHBjxOYdXTSZQnYPqsnmCU79QRikQ229WYIPbshO79YFPgqS8CEWPzryFw3mlt8PIwf46Kkh45+IKNGDbsFavvVYRpSgG+UAhNRPEQqc8/htA3FJEf1ZMmgeuN/NgmvI8g/M/xaMG5bAkDgJAW4fSyNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7357.namprd11.prod.outlook.com (2603:10b6:8:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 11:10:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 11:10:08 +0000
Date: Fri, 3 Apr 2026 12:10:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 7/8] net/iavf: do not use global virtchnl buffer
Message-ID: <ac-gC-IZqUPI2w4Y@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <9707d07db39235f40cfac7cf7ec7bec96506ec14.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9707d07db39235f40cfac7cf7ec7bec96506ec14.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:10:110::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 06980c40-3e83-4f48-42cf-08de917190db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: p1u5S/V57nNHE0YfAfKiAXrAefFDLyiXDKPJoqOmWBvQeL49TNgJYw23IPjDPKrb5fzOGFdHkwJXBD0mzInpkpxlqlEAKfdE9tM+jdF4CBLDfhA6OSmfulHiaj9ZzqI8RagL1BaNWoNM3jzIbqTjim5QK1cEdtd7DmloCjqZxDTPbqFwzc5cnLMcbFE2K4sTROjFC0JGwEUtcxjUbbi/zXkIZBEz5JxzIlD4v6F5Dr0SF0G2bVqPSwWf/6TV7DR9UzZfNGvObofDSxfEQ5/FsJRSlF881BY/XpVkCIqb0lx8Qpsy6i15mLmOfQck6up2jcrPj8U6W2V7bD4A6F8TmWHICPQp+dVXEv6Nkcw7DyxvUIZkXle5sviA2tSw5cwg8RpueNCK+TZ0zOID5iv6I91f7X4hBzXniFlpyHv1Uk2fEzdLjlW1siFVT7HJZQkjU7gy919iYK4/MLJRFjfZCB14pac+YzeMlYXgx6VUUQoAw1grTM6fjSbgfuVuGKLGZvppUd5/wFlScVGKBpcpYRcLavkcqzIpqn3xeT8ODiwewL9r1h+6Z9qce07xYsyaYilD76I8OO8GkZjBt0aES19uOqjFmWAxuolq+fnTo4H8StEmkw2PlaTdkhOvWYhFHM8VG/ZOIhi9MklAxCKnVtCFuYR4TnKcbLL/gZu0SLjx4CJC1kxs8ASVlJaGGK6Jf7VC+eiuayXkfnW6pFmsIHJmeYFJdVOLKJB2tDMYjzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZbY1j7R3c2x7+UcSN0e6CrHEfuYk+OFWlfmnv4xHHG47IMWaj3E29WVGR75?=
 =?us-ascii?Q?rymdUD6NaceBakUR+09ujc0puw2QDP+eE6SRqtoHxaHLGyWG9c4VcmUneSjC?=
 =?us-ascii?Q?La3G9ZRNRfFX0/OcLjixhg93+aMwFlQhvGRBTQ2DkjbmYWWVYyZ85p6qqiBP?=
 =?us-ascii?Q?AU+lQK8bqnJgiihh8r1tCIWi/feSbHg80WWB4nM5am5Nu0VbEyocP6Q0qJdb?=
 =?us-ascii?Q?oqEDscXabWOYfcegAXGvevHuf7Ur4qflbWU1Q/gPmfGuzQmqYBoLxYrJpJ0P?=
 =?us-ascii?Q?qWjc0CN8/Y92La4+aRQFCzTQ/4VevCZ589xUwjtoxmG6IRAsBjBYm5ULwBNX?=
 =?us-ascii?Q?wUSFP88QW+OZvz8i5Ok307gZsyYKq1G8CbzZ1JlO0jGUWmIIRZwgkkREBgT4?=
 =?us-ascii?Q?ZqBVtlPpPE6zq5heNQHEtqljjrwVDOsP6fzteVHy9uLh0v7vZBrMXZkVZ0WY?=
 =?us-ascii?Q?qk7P1xiyLJYfneIte+dC5ZRL3QypGP/qhTDYRP+ij+JcuMDSNNbCbbcsWBgw?=
 =?us-ascii?Q?k8KRqIit9oY3JnJ9pwLp+IILuJnfzhHS1UPmZLL6cNFD+SEksEFcH8v5BR1N?=
 =?us-ascii?Q?lycYQWlDkmceXzW1d+pxoe6qlBF+CSvGoeDA2+sKsKGnRoiTM2FQD0AIuTV1?=
 =?us-ascii?Q?p2RZ0HpRxTCjA86DaNA2KFF5QAOK/22lhzZegkNqxM+MDqpWP2FtI53dY1Xr?=
 =?us-ascii?Q?Rei+iedPfakxnUtOThETAsf3OQFy17qWj1Xv4uOmQVqlRiM+BFR7S+sqQYwl?=
 =?us-ascii?Q?rPALEie8lQGZVkEPvtPLdovMdIf8za3X1Yll5nVmfkPlophrnigPp4wt4/2o?=
 =?us-ascii?Q?rTnzx3lQUpj6ZjWmjvYydcvaaW2iocdZslmcHjehURgsdogbS/uerfIRVJIR?=
 =?us-ascii?Q?00U0t84D81AFOKfLiafph+YBG6lg6VxhNVD3yS442pyM6xdN2aMB/pVRVQdh?=
 =?us-ascii?Q?4bU02bK8QWIP6xFndyD0scgH/cVXXnlVu9+p8m6TdD9/BH1tYbaNKrs2p/NH?=
 =?us-ascii?Q?cygZsl3T+hpJw0NCXaeb2QPhHn+MgjENdVDBtM6Wsa8bgb19v0+YKQbRFSiv?=
 =?us-ascii?Q?jDR5SaYd+1UFaSF43UsCtWhO3lDQ6w2x37PnVBdhqymDmK8swfkTcqeR2A9a?=
 =?us-ascii?Q?2jn0Ka5+iEsJPRfNRcOYER5e4kdq2vb/g6Tp2sH14L6jWS+BLmi0FLMKCCk8?=
 =?us-ascii?Q?VPOSufWuS7yhyWYVyM1xZdcl9Lekw5J6ZjDvZ2J8TqVAsMOrp+2pBP3+eWG/?=
 =?us-ascii?Q?h2JmiC8whsw9dr8DYoKQ8NshZXD2+dpMvYYNzQP8+pVGRYHe6WSW6OE7sGkb?=
 =?us-ascii?Q?TZppX45P75uQAYDFDR17nXK0VML92dmyfIUGPlLu1r3p/CgJMwPAXXNo03R5?=
 =?us-ascii?Q?z1ZqvIMFmCT+UwdQNTOReRuIxxno/G4WOKMpFZkztyDHPLcfw+H0AX4P11gQ?=
 =?us-ascii?Q?6/nmishlnCdpNu2LZvMTGk7ZaX3VxDHS9XFIpCDobSS0ck6/RaTtE6m4fVd/?=
 =?us-ascii?Q?YuvizQW6+xSNAwgiJTl49e9pCT3ZBRT940whk+KZLMh7ig+ZcUq26WrIlPdP?=
 =?us-ascii?Q?D78Pll3u9Xb5h8j7OAsfOMF42kHJ19/BolYXfiVTuDYQjan1qRjFPQzBqgrE?=
 =?us-ascii?Q?lMNhBcFZg1UgSMVaomC0eSmHZTp29aa/yGgsmbCiEzw7XB8yU6JZVlgiZdr+?=
 =?us-ascii?Q?2zW66lw8SOIpWHXy0/9rSYr+E6x+eRhUofSqEqlpoEUojpUq+80I6famgLyc?=
 =?us-ascii?Q?qpTJ1ruL+X9TzzSkgS0cvPOEJsMhlwI=3D?=
X-Exchange-RoutingPolicyChecked: Ayxkk92dSK2k4bTxOmFk4cF5G5bYK+p2pkcNo1CdH1Wq4gDrL24uRw8dR1zKkUIFM8c3Z4E3HfAmpjv7mGMHp+/IyitsB/6MbewLHpfhFAtB2JMMMxrYGLrYS9LBP+I3vFMaZObR5BVVWLaV004pdgt4Xj++pPCXDvIXOJmAENdHHuu6jzbUQtPoHfOYBWKGRocAbQKBgG9e2A6VKzN0As1Tl81IGeukHtmh4gpueQAegVXcDHRan7KnVWVba8lt4iQhq3eqfOxXXfYY/PLMrSMJBoFA/Ar5Ca2siAG8ePmNVdusYkfHzHIqW/Ozg28A+WuR5gurNHDfWBJs5/v7jA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06980c40-3e83-4f48-42cf-08de917190db
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:10:08.2271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jwgif0A+xWmxZ81NT7Og1kiwy69kRmfP0nvsnFPq5id3v36ugARfqZkL9JGpqBAKfg1i6/T3plsyDJVh2RIMKTT8tnC6KNdrQkGIA5ISjpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7357
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

On Fri, Mar 06, 2026 at 10:58:23AM +0000, Anatoly Burakov wrote:
> Currently, a lot of virtchnl requests will use global virtchnl output
> buffer as their `out_buffer` for VF requests. This was originally done this
> way because most requests were done asynchronously and the response was not
> written directly into the `out_buffer`. This is no longer the case, so the
> per-command buffers can be safely replaced with stack allocated buffers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 147 +++++++++++++++++-----------
>  1 file changed, 89 insertions(+), 58 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


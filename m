Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B821DE9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:01:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4C7A402EA;
	Thu, 19 Feb 2026 12:01:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 111E0402EA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:01:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771498911; x=1803034911;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LWlXE6KAN4ubD/po0DfBU+HA2gAwKTAdwy2edKp4l4I=;
 b=CGG5NcfmeNiXtEwGPILpi0CbamEwI9sWaqUCcds8KcSi5uGmOJUxMDCi
 4f8KZeNz2ITb9+8ezpi5W/mJc0/pH5VdVuT/ojt4fKwOFl8dnuoQudxJL
 pT6pROflOTui9FJUmrnlLJp/9vtqYifS9CqL0q2GRpwPqTQ0OOQJoG1Rc
 bF2vmLvitZmH1KfqvI3KubYPccwPufmWM1oxuJh21vHnUQts4HoXfxqRy
 XQEgfL9Jy5sdrW34N+Xs986ZtvhAMj8hkrS5ZqB0qtTdAbuTFU9jQuIal
 lNRwHJM7lZw1gnWOWRcKhN0ETMJrUcQHrMOEOP5plAa5p8Uvf7iDJEm5Z Q==;
X-CSE-ConnectionGUID: gKBbnmnWTIS0briIOdP0dA==
X-CSE-MsgGUID: NiTPKd6oTFSRCou1S6a0dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72490704"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="72490704"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:01:50 -0800
X-CSE-ConnectionGUID: +q0xMRKrTzuQSXxz9c1B6g==
X-CSE-MsgGUID: 25PKCsZiT/m7B/Q7kUoDUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="214501776"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:01:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 03:01:49 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 03:01:49 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 03:01:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5321Jj4dlNMI+AYSYGkbvb0r9x6cLHXBocyH7nXoF5mXbpazLwqYhzdKIVIknKDjH4/jsiDwr+AMpsRVtoSmmj7PiqY9yZW6x0JKAxAnf8Rk3wPbBaEorUnKSPT7+BQl+m9PTSvwMebIhPWNDrsG9oLcD/Y2gfCAYOwmYIICF8/QjQLyBwo3nnvnEM5gIRJ1Hn41WlYGw9cuKGK4n5o+mzc0uFe0wApvQTtlifmhejBiq0d2EFhQNYxhMomwEvpI5qi1y3XaIxqbF0E1BusfAF7CvjVM21ApcoT5tOmPOSMta8je7PUSNalTfr6TGzZugtqH64qWBGTU8/VmtxpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdxGMgz+0e3Yw2O9mlWzjP603dpu9bwqe564HQwK7bk=;
 b=CHT5k6kAR4ke0a4VLtuN5jqGCmUwFEqmRuXbDPK3KH4sb+bTXZfclgJSxXYNmFRx8CTipmw84cuZFGWZAyeR6bLm5Am3Sq4w1hb2xWCizdkYPu4u1xQvzwDUpg0rC/YyZu5EAJZmvQwTCSdN/b5nZXLepUJI1MCrevKAhQzPReu91CpvgoYIGXMYP3nuAxHkaWbw4rnA/JHgw/REe/DdXMsM4bA0ej/wV3XdpRME80DU7uihyvt6ZlbFV+AIB67hJrC3gce+EWl5eizDdToKDTTMTKuOUEnTdJfrOzkUZ5uWfP7wlYm1o13qNjkDiRLdZ0V26CIWifNGLAO2g3iAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPFCA4893B55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 11:01:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 11:01:47 +0000
Date: Thu, 19 Feb 2026 11:01:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/idpf: remove useless function
Message-ID: <aZbtlogha9VE5V5E@bricha3-mobl1.ger.corp.intel.com>
References: <20260218120412.1809390-1-ciara.loftus@intel.com>
 <aZXCSCnW-3rUkbWm@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aZXCSCnW-3rUkbWm@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPFCA4893B55:EE_
X-MS-Office365-Filtering-Correlation-Id: f708a7f5-e761-4c62-2e18-08de6fa64649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wpmKWMPGPCJWpVG2CHKjGQsgYz78WkoImKDMmYAlTGBIPr4uxvx6llLK8Qri?=
 =?us-ascii?Q?YpKVvPsz7666iRYeFbUn34ZgkDAXrbSokn0ak+0uH2NJI0Qv806ST1wLnAPb?=
 =?us-ascii?Q?IiTSqiIdgzdso9Ru6aVa3oGSe6ryMPniKB1qRdX9yuw6PAFUALUTuKWSoYKc?=
 =?us-ascii?Q?uxmb3in2S49eo4QdW27ANBwLG9/ZUWJXScfsAS1HAMKpMtnh2dCD+YDf4zFN?=
 =?us-ascii?Q?s0hbiB5tz+bzniw1TatY/k2nQj35HzKD9Z+UtUlNJ0eQnaXh6zKtNL8fsMoQ?=
 =?us-ascii?Q?OlQlFTh14JnZId+6jrFp3GnxtqATDWn60dSU1TUJHD9k78ojNKk6BH13vwtj?=
 =?us-ascii?Q?3yGATqhwR58w/OHnuWZEa4N4VQFQJ0oUTlGwTvMQEHzEg4yg2heJNR7zoEVw?=
 =?us-ascii?Q?ENk7VzcADUyF5vhXdIA2hOJE350HHUqTtGosT++aOSXTARSekb/JnS6ePei1?=
 =?us-ascii?Q?d6y5zuyQXxg5c2qS3wqciVXf2F1sIhQ1WNkPv0rxABOIFqcX4lq5+ZFkVIsd?=
 =?us-ascii?Q?yNG7oXaCJXXB0DcL2Jex8ntIodSufN6u33hDsnev5mRDkESGd3HGLauPBQav?=
 =?us-ascii?Q?lENf/XtiPzdITuUpHlVwV+g7aIwttrNLadLS7D0fD+6Ubh3pXd1JkeP/u72B?=
 =?us-ascii?Q?QfHvexGtvZ7kBTYHfCqJWet+dXhn3+vf2zuIIi5VHqVHH/Ragj/RlUAAWyr0?=
 =?us-ascii?Q?XZ2U9Rj9in809Z2EXAFnZb66i95FDQdp+kOabsVQvsVzfKFsecaJ44XMwTIX?=
 =?us-ascii?Q?hAmUks82tnXHAqP7DRq61EQ7J37mBQ8t1pzyRDzIEsmqgEFfc6UnXQWhAj66?=
 =?us-ascii?Q?S3J+PtsjVUHVrIx29MGBjj/Nh3Dvx1Jyp8UM42VzJQXFKiUlXTyIlJuN0ryM?=
 =?us-ascii?Q?w1x3dfBqbMzBZ4ItLs7P5LcQwAC9XC4yi8a1XMFLAnr09FFJQb4m10jnLU1v?=
 =?us-ascii?Q?PDtHZWxtMvZxiLp9wA9/093iygycSHEpYsBC4/+skKswVeumJ8uFMUQunWAQ?=
 =?us-ascii?Q?TR1KLlwuPguoQhhD7oQhu5JVLdoPPAMNi55h9kQcF1t5WzRQkot58yTJRgGr?=
 =?us-ascii?Q?5T8Isio+c6zrfINfjdyWWm0GUZqePb4tumIqDXd9j5jXx9a6TNtljsyI1exM?=
 =?us-ascii?Q?E5QCMU4HvrmCVlc4pDEb48FEMzBdcaG0ucvcoQST078FtvDkupUO9eQJplK/?=
 =?us-ascii?Q?WvgeL1tS7ZNLNXasU7OmeL9/l2fs/Ql0yNuuku/FsqdxQbYYqh5C9r3pXEmv?=
 =?us-ascii?Q?pGIN9ZEejqY9HZ45+7HF4Hv+SgY5LOo8MF9M8ejhnXR8xXI/RSYOdRr1AFOY?=
 =?us-ascii?Q?jTK14vxQHLjLPK7wMwei1/a7HFPPmjyXnOYs4V2e/xaJjoxvickzYK8SC5mm?=
 =?us-ascii?Q?yVJ/CDF8Jzu6uOT5xnwJVECvNCF3ZXpIOorXPtzDeg1Xl5msL7U65YNwKwQb?=
 =?us-ascii?Q?Y3BZlX4CQ6kKEzGrAJ9yQA/UeGjcbLeZusHaVA9C8ojSGSKOVsOAXZTcP/J+?=
 =?us-ascii?Q?lk+uax0cm12K/1FGcp0YDXzVOXE21lOj4mKpgWQmMWe3DoKgtnAjotOMF2OP?=
 =?us-ascii?Q?naHSaegGXVqqDl74rFY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuNu0p7d70ABrgLbsG0DJ778lnxz8G4Lqb200eEUaVyfwLt1DZCIQOoZmQBd?=
 =?us-ascii?Q?n7SxXzChNJnfWkHfXfQsPu6domXmBVQWH7zfF9wGrnyytYnQKmKIpiAdhpyT?=
 =?us-ascii?Q?oPHajgUzNWijlrSVwEmOwklrMSOSEI7xe4r2KnPQ64QgLCD7Pbm+7mhlwPMm?=
 =?us-ascii?Q?Pp6uo/B35S3KfSxSihVcq9gHTxoTQy+JfhQrehUxv64F462fiXwCT4WX9qHK?=
 =?us-ascii?Q?3wo5qD/cleKyLijpwZ+5qa4GoJDJTZqVa15nctjH0DUU8ajuF3EpUysKx8Ut?=
 =?us-ascii?Q?096ob0Hh6I1vemQGD47vZ1pp2mEjrudlYKX0pQlurKejtyAFl6tOmjCi/+ko?=
 =?us-ascii?Q?zH+dr40hQbGqdahi/1qrOoJ9Vqjo89rnpb8eWwcOYIemQe3VmfULC87vdGDs?=
 =?us-ascii?Q?iYxztlZ8rz67a6pmrt5IbNeQR0i0hjTJhstXgH1Vhk4AZv3iQnaTeeCXqYSn?=
 =?us-ascii?Q?zMQoXgVqU/sLbIvqcTIas/1evthsOLxZJU5Ipo4JthX0IC4msPmWC7Fzu1LY?=
 =?us-ascii?Q?SkuG9mfejEiUVGC4VucTiWhgLS/lIfFO18PcryewuqcXW0sWIXbAlKy7qSET?=
 =?us-ascii?Q?HN4effIpW5t8PLktHx5xHlSIoNEDu2qAUmwR8eohVa2UZ8Ej0w7CKjz7FDM/?=
 =?us-ascii?Q?dKHCV9TmohvRAIPF4C7o4prWLsmrKkizsu6QiudyIeyWgJBJdD8igoDde59k?=
 =?us-ascii?Q?C/qk345BdvBroqOweazQpnY2w+idmWK63qxWpDEVtKKyhsS2dGZWDNjp94Ta?=
 =?us-ascii?Q?9XA3vDM0DI1EnKyDz8+Uo/rVwhGi4oiqGSkNVlhXfeMNhhrsxL7aDgIvafOO?=
 =?us-ascii?Q?S9DS0o5v5zfTXKmIJL06k3vCar535oiCdtdbLG++8WFe/rsQrkmTAZfsd7C5?=
 =?us-ascii?Q?g4z67CpX1pgX1KevstHgGb3aFsBItUPyQZG8ziap06NdZ4FwGRv461BhLfvw?=
 =?us-ascii?Q?Zk9tpIXwh6E+8/z1W8fkgpVIH6JbWPcP+6QQ9UPHiRwtvHscCZ56+aO2Kpyz?=
 =?us-ascii?Q?3heUTFidDpngZajMDJx6OCQd+Lg+1W1kKEzMn8PgqI+PJuvbaMk4ffb8m7F9?=
 =?us-ascii?Q?QnFJJsiNvc/uPALIrtdmdMnCaa1ygq8O8671jlBRvMnalMMJQVxtYzjwnCdl?=
 =?us-ascii?Q?L7w0ONruFFWcWR4uNvDyUru1oqE1jk0H1a2BYDYs0Cx3vIi+E/aIr4Zp70HK?=
 =?us-ascii?Q?bqc4EpaMg5bDIl8wED+hV8jY/VFuZoquncrEwkE2Z8LG9dWVzdNlxBCjEAIK?=
 =?us-ascii?Q?k1zlUD8BE0bzcMmO3WOJt7TyfyZELT2Hf3Vn4wP8kBXGkBRX8T47OVyGNVVQ?=
 =?us-ascii?Q?VqauUctuCTkS9C8/+GnwrAs0rdxKPu7quHRUsL8IUky3P2VCZBeNLKJFYWT6?=
 =?us-ascii?Q?J9kks26Y4hUnvxFLz/EpBvfEuzbs6Z6giqLJVbc0fUyayeAcImg7XldsOSjX?=
 =?us-ascii?Q?qX9C0edZmqHF4MDcCzBo6TMF5YbxzzvLswZRz8rPCq77HaXmyV5vZlJjfMaZ?=
 =?us-ascii?Q?ee9TSdBiFogrtbj+vVTYjW77zVuqNDbAIWXGct7vi+zhk8pXpgr+Z99t8XN2?=
 =?us-ascii?Q?2r2fElk+jKR7bDF4vo7lBhIZtrnohT4/s8qdRFSH3awqtNCAcOMWrVm3H8Fm?=
 =?us-ascii?Q?0NCSsCKxLjiRbsut8LPpc+OFGqtwyBUK4ump21hlUR+PFlkit2hWAUKayXgi?=
 =?us-ascii?Q?BbVth520iLBP7gGSCk7TwvusYfpRIMC4jxoqjbkj6aDqyx1MXQ+mkI4woYPG?=
 =?us-ascii?Q?llrKZnhuwxbI2yPhxpOn6RSQWhSAL70=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f708a7f5-e761-4c62-2e18-08de6fa64649
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 11:01:46.9361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYitQOGCLgz2R8PsA4mmsxnScW6se95plQsWhzwr2EhQlPPCeH/7z3NleoxiJCwQgSBMnbsoFJmFmUcbqyKeGn357l1Y3hQ15OTdviEB63A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCA4893B55
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

On Wed, Feb 18, 2026 at 01:44:40PM +0000, Bruce Richardson wrote:
> On Wed, Feb 18, 2026 at 12:04:12PM +0000, Ciara Loftus wrote:
> > Commit 376faf4aaa16 ("net/idpf: enable simple Tx function") removed the
> > one assignment that was performed in the function
> > idpf_qc_tx_vec_avx512_setup. Without it, the function is useless and
> > results in USELESS_CALL defects reported by Coverity. Fix these by
> > removing the function and the logic that calls it in idpf and cpfl.
> > 
> > Coverity issue: 501500
> > Coverity issue: 501501
> > 
> > Fixes: 376faf4aaa16 ("net/idpf: enable simple Tx function")
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/cpfl/cpfl_rxtx.c               | 16 ----------------
> >  drivers/net/intel/idpf/idpf_common_rxtx.h        |  4 ----
> >  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 10 ----------
> >  drivers/net/intel/idpf/idpf_rxtx.c               | 16 ----------------
> >  4 files changed, 46 deletions(-)
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

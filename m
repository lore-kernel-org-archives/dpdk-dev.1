Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD1EC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 13:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54037402A9;
	Tue, 29 Apr 2025 15:22:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B059C40277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 15:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745932960; x=1777468960;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mE62RxdfJtk0Z0jSGtNuxQyxbjfrjQLOahLAKfGuwqc=;
 b=PvVQ1dLnYA9PBTFC/C7jJS4oQTOKcehDWu+Z49Ob8UNgBSfRvjw/XQ1L
 R/LHsPK91u1hcRtMpdZ5nqNSU7emlrYZaomfRcxbmb4rRSUl0AiFoXm0v
 sVG5IRVuX4A6JyVMHtZvFm38HJiD/WnG2xVsBtiqzeNJmKlbt+GRtNIVy
 V0KFa3sh0mEZX7DuASD1JoH6j+oqGXf9vgq6v3gf+Q0Ui1vDbLxRpT4lk
 YmOW3g8yepLAJGPE0krD4OKE0Bf2D421tNn2evwmM9VetDmiQ0cqVmWLP
 tPFnqSIW+j5H0/y+zgMUeFgKwPuL0kx5xqMpVbh7zXOWk3nUJ6+6nPSO/ A==;
X-CSE-ConnectionGUID: fkCyofzNShC4LisiUoaQcQ==
X-CSE-MsgGUID: Ua7aOjMAS9qps7a6Kqs+MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47712827"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="47712827"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 06:22:38 -0700
X-CSE-ConnectionGUID: mzNWpzC0Riy53kJXeHO1Vg==
X-CSE-MsgGUID: UV7VVqz+RHe1K/iSsIJapw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="134812816"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 06:22:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 06:22:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 06:22:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 06:22:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1+YjetdvMFQqdnvXBXwCeToNrCspI0AiKUcgm0tSpUzic/U9x1QplTLL1fppUJCc4MeCqe+/lt7C6ueYiUPJrqLP5MUVBuy3XBFdachP4JH691J5goJ9HegvvSdAsEbSTLMGrnv/Hdj+cNYPyAWiBHxOg6qIIsGU9TuNsGy6PQaNOUngw+02/SBjpbXGQxkZFFUzqlv+isWv9fGRnCh9w4owJtnPsb6PWtduAXISv/1XB64nZYUPfspUGtkSy6u1G/QyXXH04UpOngH7OS+3dOu5+4bFSd3ezmpouISpOKNo358f/PgzegkuLNOb5bLjx6e44F616EQ3Irn08v+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW5LGXzsaySsrwgcWjR9ackNdK7f4wjilnITI3YvZqY=;
 b=QCcd7Z34bePROMg686ypVJ9iLebqadLHxmR9e0dJ7Ijsj0R86h57gP3I/j6DNA1VrCckuSarJkjq4k9t/227eUpOyyFpp1Io+klL7S59BLa+lcQ8O1IYmUEbLmEVxsdyP5OqMC9tvGA8AekpVb1cdIlypnabNKQjxDTEL1DNduWTPh8QME11OYmWnFCoMy2QxXcEL3TW0/lXeJrzNoUF+Y/bJ++kAvRQHwoNOhf5EywMXcTdfTLBbZaMBn6Kd7MjSelajWVvEmPBzuEACnB3L08aGIXHCAqsJ4oP9zBA9a9Uwpxer++xyhWwbNVVNEb5LaHwZP/M3/a4pSBLmoXOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9133.namprd11.prod.outlook.com (2603:10b6:208:572::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 13:22:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 13:22:35 +0000
Date: Tue, 29 Apr 2025 14:22:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: spyroot <spyroot@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: 810 VFIO , SRIOV, multi-process stats read DPDK testpmd.
Message-ID: <aBDSliZlrdd1hOst@bricha3-mobl1.ger.corp.intel.com>
References: <CABsV3rARRuh8Qhm4q+QCDAEmA8WP+6QK241ik4qoLyGJBPFdHg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABsV3rARRuh8Qhm4q+QCDAEmA8WP+6QK241ik4qoLyGJBPFdHg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d4e9b4-59ab-467c-9b67-08dd8720e7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wsi9Cm4R7XGdB/9RgSqFuIOzwhIKdLYJ0glRhorxV22m2aDe/enHcr6/B3aS?=
 =?us-ascii?Q?SnAE5ktKHvqajCluxavOW5DBo5iV7wRQ5Qxzc36GE7cDFNW6USbHdFbf6EIo?=
 =?us-ascii?Q?upE771qCp8U7GL4NDhifVzTjEUQxE7q2FoX0f7O5p/jzp4tt2ayhSdDVv24E?=
 =?us-ascii?Q?+b2rVB/VSHQs7ULrCx1quxE9I01Zb+t4VpSid9toiTDS+fXO+ghaI4nvAJrq?=
 =?us-ascii?Q?O6cDL0NQfdPTxj3oNbPTecgaDbZ+X4smLv5eNBlo9F91ws0jPTIMtJk0nG0O?=
 =?us-ascii?Q?NCsCwYW3zW7LaKeL/1D89fWa9QjUMIbV2vL+Yz+LhEIkRB/+NwQNs0SKJEl6?=
 =?us-ascii?Q?ALxMdfgS38BkhhI7eZZzJhNHMcLGYKrs7PiuV2gX/CS4z3jhK1HgiS4DK9Cj?=
 =?us-ascii?Q?aKVEvxFCGyrZLu/XajQj0Qs+460radR9wYnwk6wswuEe3ewIuPLD+PFMe3nx?=
 =?us-ascii?Q?ToKpUx0sah2aBLd8WybNIDQiM+pqWBgb/mPDapSTuc1DoAK14veaZN7RViRm?=
 =?us-ascii?Q?l1uhDZTWeJETaCRjkVcPNaoKhoA2ULKi267NtuRgstlCAi/7Ypuukulwra4x?=
 =?us-ascii?Q?i7ouqucU5UdtD43EEQsB9Gq3aGXE7mn7A5WWkcMG2/egQGGzkf9FUTKNEu7D?=
 =?us-ascii?Q?4blTSTLKxtse4s/lDnn7uN6GJi3akj+KCdUVSYa+65ocZsVhVlVHELTT/gAk?=
 =?us-ascii?Q?7/Tp0e/5recMF6ZaFNevGaZUkjh4jRfPBuWQhY0jgsdv9F8imjS4pAjgJDe6?=
 =?us-ascii?Q?GvcC9DCjyGH4qyZxDXX3ZyYVTJTRochKKmjNh6Ho84L84gWV0U3lHB4nF1ws?=
 =?us-ascii?Q?DG7xfwp5/wqFFy8dufO+EpUJghO7yrMKGpvYKmNrSQi1YdfgaorVEylOx4Pb?=
 =?us-ascii?Q?fIhi4O3SzidRko5POgkPTuY7O11VO0kU6xuF1zldAFJEzcALh7zRHm4eUSmW?=
 =?us-ascii?Q?V02oPZteRres/Ug6ru10qGJC7EM+xE4fHXOmF/hxhA1Sc3ZYO2of5mQ2dQIq?=
 =?us-ascii?Q?/z6qU9rP9huY4G7xoEb31BH94FMrsPYQQ1cQVckRPqf9pqzjDdm85A18dSgY?=
 =?us-ascii?Q?wUhju8RJKM80XGsJONNCbAopvDGN4a7iHKnAMI60Kq4DjKjwSQHeHJ3bKnai?=
 =?us-ascii?Q?Swjp2Cio8vIYHgTGEGNiL2EPNmRVsKMueBXgPinxZiJMCThQqHLlSvogje5S?=
 =?us-ascii?Q?C28wRy8bSvSrOdoQiZHyWTts4226clqZ7Zdai8Nd6FSpcl0oEaDxR4skgUA3?=
 =?us-ascii?Q?1dd5FjbFcyRlVnPTD3HP/HPU/2uV3NYqbwa/nrW8j1SQmK0CSn1tl2MhhQX8?=
 =?us-ascii?Q?AkgmAf016bxHo3HAl8hytQFnzrgSLbshh47PqZj8CBaQl1vkGRJzperxfy0i?=
 =?us-ascii?Q?PZ5bsY96O3XOS3GYr56p5HAbRksIDqBMXGXtB8W0Q/qM2oqjvcy4qJS3mlF+?=
 =?us-ascii?Q?SA/mpvkmRcY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yzn6dJNtl8VXowhIJLSzl1KmR8POmdQq1MtIso2lfwCOhK0h5Q/yxL+8Y2q5?=
 =?us-ascii?Q?HBPH6EmFeLX4HMn/hfh8QCH3xlBmw4ACWkG3b+lCaRx/Iy+RK/ZTMldcTOQu?=
 =?us-ascii?Q?T7BIrr/sOLq5MUaE6KppMMCluVfU8Py2aGrMJFUjwIgqoJYPru9VHYnVXth2?=
 =?us-ascii?Q?5U7mSS2ZrQrjJ06lR77/be5yFB+Pqv/YCgEz9b3iMAwVSD4Ccq8zo+lBgs/w?=
 =?us-ascii?Q?dE7NwMkVXpq/Xpp6NxPr5BuGk0UVcanTPFFF9UkDVFvy1u0hcIwNJDmhb9AF?=
 =?us-ascii?Q?Cf1D+V6pZHMXdkbA7NgbwylZ0ptI3rlwmU6oI50FtGFifcYWN/1lhB3mXiXT?=
 =?us-ascii?Q?rDBbxNl6KbPtBdUoH7C9ulA5IaHdHt54bKVNPRQ2dHPTTBRM1qz+diPVKRM2?=
 =?us-ascii?Q?VUn0SqyNjU688iGLCrjShdsl2n1oPewDhU8a+V5i9svJuA4R2s4Np8kO7Cpr?=
 =?us-ascii?Q?ngG7SQZqM3w+WF0gtoS2Krdet9eBAwTuBKJdSM02uIvpoVC7Zv+33IWjk7a2?=
 =?us-ascii?Q?M1wuQWxcsO1cxtxOowrDy7QR/VazEPSkaMEQipn39umXJemmyoo/jPL9vBFP?=
 =?us-ascii?Q?JKTDb/2XryUO0ql2D9vPDMamLyokZ06iU+trXUDzW7m/i8hO8k69Z764ME59?=
 =?us-ascii?Q?z7TZSUpxXhafIha/YGwcFWNoK2/xXEx7AI9Wk9CoCph+LFDSysaIj1HJMTr4?=
 =?us-ascii?Q?rWg9KLX7+AUJgXg32wtyiKIx8G3RNQgD+GMbI9sIm4//jPj+VQwb5K1eZPen?=
 =?us-ascii?Q?HjtMxMb75WCO31swK/KgmFquPOUsW0guAJMiI6CpqMiJQgvmdXGrZnH3L+LK?=
 =?us-ascii?Q?3XylarV0duv6QPEO7uSs1uNLwRD62vd12Wvqu9R5KbTh2XQmFoEdw5QxrrEY?=
 =?us-ascii?Q?+U9YKZw9T5ywAhj6Py1rAMOJuHRUOdwqCOBxgGXQ3l1k9hMxM1LvZg7Vl27h?=
 =?us-ascii?Q?iaTQkzhURH5ALVpvcB0SsZk2owW9w5j6qnto6wFQEZbD2TXExwcTbf3xNlPQ?=
 =?us-ascii?Q?GQeV8xy600cXbBXty0bMaLOkL49jIBOg/MLXNta2YGnErkYhi6uy13663eRq?=
 =?us-ascii?Q?rMT4OQ9CbyPG5qvuocuBawRitvDeOD3xiM0I8Hb1qL1NQ1DSxbCYYmrjBbrf?=
 =?us-ascii?Q?wO9DlpctVPmtJ9snhbaXBidFiznQgycl3StAJRNruLxyq9COqnFY9ekxefPl?=
 =?us-ascii?Q?4/oegFKp3Q07FPR5iRmRnT0cBqFU17z17dnnLR3x2XSgfVjFebSHTq6SI//N?=
 =?us-ascii?Q?4Z3PK3DJrAg+3OCEhhJmf3yZNPAIFiHlRrYFlQHAwg7UrUnAyIPOkhMhxbRj?=
 =?us-ascii?Q?UFbivuGwxwBTxegwciUBsg1XhzTsfOuA6NS+0b61qaa9pt6/6Fa39V2hqSB/?=
 =?us-ascii?Q?mi0LbWJiloqQ6+2FGcNCBVLc9fKrYMfpAz7plKGimD40+QVPFfBdvP1B+bXa?=
 =?us-ascii?Q?K09VCIIx+8NT7aQRJ8SxywYv+63cDLX7kyavseDePr6v/mmVd3YP+bjq8JEP?=
 =?us-ascii?Q?o/Vk9/JHC/I3T1N97/C8tN+my5Td8tVbpFp6fBhM+oe1Cb1HxJNHSSHM8dPp?=
 =?us-ascii?Q?TLGCWi5iqx1B14ul7Wy4n5F8xKU3BGBBaT8CZ/GY2HnhsmH2gUDDIu03/1Ld?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d4e9b4-59ab-467c-9b67-08dd8720e7be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:22:35.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qny0FeQn3+Ij8fmAhpojT6YVt3llO97z1CXA5UJMCe8lBNSH2l1jE2Vxs0N7S5ldlBBZm5LfFrIInVwedQguThOO8/CCPc+c9ES9E9RMUPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9133
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

On Mon, Apr 14, 2025 at 07:21:57PM +0400, spyroot wrote:
>    Hi Folks,
> 
>    I'm observing some unexpected behavior related to how statistics are
>    retrieved from a Physical Function (PF) on an Intel 810 NIC.
> 
>    Scenario: I have two dpdk-testpmd instances running in separate
>    Kubernetes pods (same worker node). Each instance uses the -a flag to
>    bind to a different VF. (i.e to have consistent port id 0)
> 
>    Questions:
>     1. PF Statistics and 64B Line Rate:
>        I'm noticing that the RX packet-per-second value reported on the PF
>        side for a given VF is higher than the theoretical maximum for
>        64-byte packets.
>           + Does the Intel 810 PMD apply any kind of optimization,
>             offloading, or fast path processing when two VFs (e.g., A and
>             B) are on the same PF?

This wouldn't be something that the PMD does. The forwarding from VF to VF,
or PF to VF would happen internally in the hardware.

>     2. Concurrent Stats Polling:
>           + When two separate dpdk-testpmd processes are running (in pod A
>             and pod B), does the PMD or driver layer support concurrent
>             reading of PF statistics?

Looking at the iavf PMD, the reading of stats is done by sending an adminq
message to the PF and reading the response. Any serialization of stats
reading would then be done at the PF or adminq management level. The VF
should not need to worry about whether another VF is reading the stats at
the same time. [In fact it would be a serious bug if one VF needed to be
aware of what other VFs were doing, since different VFs could be attached
to different virtual machines which should be isolated from each other]

>           + Is there any locking or synchronization mechanism involved
>             when multiple testpmd instances attempt to pull stats from the
>             same PF simultaneously? ( in essence, does a firmware/OF
>             support concurrent read).
> 

See above.

/Bruce

>    Thank you,
> cd /usr/local/bin && dpdk-testpmd \
>   --main-lcore \$main -l \$cores -n 4 \
>   --socket-mem 2048 \
>   --proc-type auto --file-prefix testpmd_rx0 \
>   -a \$PCIDEVICE_INTEL_COM_DPDK \
>   -- --forward-mode=rxonly --auto-start --stats-period 1'"
> 
> cd /usr/local/bin && dpdk-testpmd \
>   --main-lcore \$main -l \$cores -n 4 \
>   --socket-mem 2048 \
>   --proc-type auto --file-prefix testpmd_rx1 \
>   -a \$PCIDEVICE_INTEL_COM_DPDK \
>   -- --forward-mode=rxonly --auto-start --stats-period 1'"

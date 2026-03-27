Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B44A10ED665
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 12:20:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99124402C5;
	Fri, 27 Mar 2026 13:20:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6596240280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 13:20:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774614002; x=1806150002;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/DdNROETKYPYZ/b+akDqtyqFbW6jB/2cL7vo4q4a4/M=;
 b=g5cEE6aACxrLChj/NqwLGVepC84vZlenoqnEsy4tsphTd5O/YUenaJ9N
 Zxb4i4m8HfViRd7XGDg56mfwG0D8ISZXo7h8W/lJENDnUzUBoC4X+6OJF
 oCD9dwPTy1WtJ+bpOsDXHx850NK1qtfKEQ8vJCREuup8FgNVerMKqkkbc
 ApFkFWsSSC0VJKBAk7199KY8JqhkkuuvnpmLxEcne3YBEqIKNpjQWlK54
 NsiV2mnkS+yX+LhMsP3cja0Mo4KFF9vpByMBYqkg3lyj+XwgMs8PXQBus
 xywx07JrFJWeGmxy72fFbIBKQZfZ1XNRPOpoNO6HLuWloxQaLGqUsfG7P w==;
X-CSE-ConnectionGUID: fHYpyLU+RAODjW1EZ9pB5A==
X-CSE-MsgGUID: HQ5uI/kLSYC5s7x94raDkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74866992"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="74866992"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 05:20:01 -0700
X-CSE-ConnectionGUID: BOTCmTygRuGkGicD2+XHew==
X-CSE-MsgGUID: fyqFrvzuTSW0InkWu3Z/VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="226902303"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 05:20:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:20:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 05:20:00 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MljdXwVc7E5v/wHqZTiurCV4ZQ4dEUHVkzOt2QZlY44bPTfsBDoqxXchaSycYacfVvs4+BwYlp/Lid0HaPVsUsdpkqWB6HANIeCwBL+0010IazIIKKRpcS1Tmhyc+as0xD7BNMOULXwgIwWXaKM6aio3CHEJ8iy+AYPEpiGNpBGlp17qGYT970ypH45lyetBfFN5qhp9H4PBhPBaiPDf8TLHQlJmXDKu5j2UIf/8TQiMDNRXuWhsGEKlugUnFvGmwFnm8K4zC3eldfdKoNZCSaaoEcalkMChTOvV3UOXZI0AJhIN0EUleyjn7dIUS2RF45qAtf97ac7ZU7ynYQg9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZATWkKxmXiA/qIHNUUthWvUGYf7vyZc5tCWYePkRDk=;
 b=LNOp2Q85UrDLYgskoZv3Kn8MpDLCTaflUrS5q+i+CFA7g9FBvbbllzKI0uKa/H8oLV4lU0gjITdbkfSRz3tYtnI//qRhrNtTWLfzhEBlJlCVNdhhcapBm2WjDxpLBjgvJtirCIsx37rMwqdJuOOTUPLXCF0e9qO3zVok3mad4RXqX0EI8sH9jyMzwaKPwemSq8I/bgrASKFxoSAd2MBG9Ywq8GrLoIClbqyJ/6gzUj3201ysxO1UrxNJqGUetfES8tzU90lQ/NgommQ8L42G1m8huysAbITtIa4nZgT3xJN9nK9/WPtOhQjqmBlfbsOmTu6Sjt5FC1M1kLrB+KJ5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7476.namprd11.prod.outlook.com (2603:10b6:a03:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 12:19:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 12:19:57 +0000
Date: Fri, 27 Mar 2026 12:19:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1 2/3] net/i40e: updated i40e latest recommended
 matching list
Message-ID: <acZ153OL2B0NhdKy@bricha3-mobl1.ger.corp.intel.com>
References: <20260326005407.623302-1-hailinx.xu@intel.com>
 <20260326005407.623302-3-hailinx.xu@intel.com>
 <acVIssIyrsGgNtrY@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acVIssIyrsGgNtrY@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0347.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a312add-2d03-49b8-d8f1-08de8bfb2816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: bCfPQztbzs01BJZ5qC4M/tOXgqiH9qc8dikJvUNoCY8jl0XccM/L+WrEwisr5hxPifp4mkk0u8vt7Sd9WBpgVovu9MJzvhfD/cSgQ+ioebK8jjAQrbJUERGJstk43x4tCDi5nCzReGSPUeMji31MDHICb7L3EgKN8Ai7jjbsuykgCXwAesGPoqpVx5f/20x6lNKcy8pnYmPp7FdnK3SldiaALb1A+9ZcahGHirlUDjPh4W+9WEHag5Gbsj2BjTPhp4zZ2AmXhNdjr9S8hc+AJGgEMTCfvh4UnJxfS5coZaMZar6x5bdiA9ml1NQtx0LWxNrdtqr4cif6myKrRCYEl3X8Q6bsnUqFUrRIufb1HKDLgPsIV3P+AIJ5bDdG9/Bc8RTFEQUFiBCr8I0/Cs2T0t7LMarZJFuM0dOjXQYM5GYdkthmgnIXg7AD9YJhvy/czpRArsIBvuOZpiQwFDn23gB/kwsWQ0CuHH1sZlT8wKaHQ7spn4wbePduXqEQxuUzAe8eEqE7evlHDncsJ73o0pQyhfft+GNt4w7Lxnc0WWQjwVoaYfSHlgCmKiKFbu7dURzqb2g1rFjq2yHmtfVh9wJ88V2LJkgOj1UlCfYw73YipABKVN3moCpZjebl7eu507wJ1NlA48niwUjV9sKuX+/E6svDB7PJmw7pec+2PCIdLhZ2pP4TDVkhPxcp6j8hmz0f/5NV/u6fgcK9pwvaD3EHmBK8s8hJrO7Iy8+rHV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wG/mWXtq2+DOF9XTqSLoHTFOXuwKqDWdbtvQX0KmmY+HMKMvGsIw0afUaBrq?=
 =?us-ascii?Q?wzf71YfXYM+0qeXOFsNh/B/hH4JVtlJi379E7T0Lujp6LbDlkimBSihkdk+k?=
 =?us-ascii?Q?7QKVcd/xREnGLVDZtikMZo5W1Hp7NV5fL1dYi9PvqgUUIRz9L4Qd2A8H5iVU?=
 =?us-ascii?Q?8R3NnZpsnKMccfaR2F3WZ9HWgA2HAxYFKJtwp1angL4ERp2NRCEh+51y1AmA?=
 =?us-ascii?Q?0MDPPqj6j4cTUcqX/aOqJedRMQk1X/kxggojWcRV1TXQ+EtbXazYTo/ge+R3?=
 =?us-ascii?Q?gFZBekIxYVewCR7QV7ozJlzr3LrpCiyZ5l83Y4skCO2o52o1VOGlsYcgBoeu?=
 =?us-ascii?Q?vFcvn/9e0h72uymRkvO+rpLJjCIDWBW/K8HK7LSiXVLCP/aTbchmbMGNuUXp?=
 =?us-ascii?Q?4Q9d44Fc4rtTxX/OZnhPP3WxxCOo8SAIdvCfHeBmTPkg12G2dhwtvlHGbalT?=
 =?us-ascii?Q?wP8rx9wyWYX7CdCRaQUCHQ1XRD3q5CF4vPT/X5JFkM1/U45gqZwEqIQpohoc?=
 =?us-ascii?Q?DCg3XMRPQqR1lVmFsug3hpesSByp+UyQYqiTM0Qcip72iSDE6ksJ2Taq8jb9?=
 =?us-ascii?Q?DAaoBy+iUpDCQ5HbyQYHqsjcfbRyv0jCQFneieFfzCx/SLsk766ZIkDEg80N?=
 =?us-ascii?Q?LkF4pRcVFPaBWokDvqTIat3PXECnGX8NVxZIs4FtP2ZGDlG9DYZskbCMB08G?=
 =?us-ascii?Q?E51v4aBUbpLH4samgi1DLVUt5vf+QPjxncj4riGlk1gKp8BXEK6zxpGSYnqT?=
 =?us-ascii?Q?P+zOKtAmAAgfkuTYWdsGDndIvKAx82LjbSHFu4TslqoXzbkL0+UokppDm6q2?=
 =?us-ascii?Q?kVCyxOhxLN9doDrfNMy7D3wDg7A/l3f9hvr9hMyQkabxIMyF7mwi1rWDKYSE?=
 =?us-ascii?Q?dntGm7qcFVWotFCZIQJJsbZJqR70xILnDrQWhnwi7ce+hZYXSt33DAmUZVCC?=
 =?us-ascii?Q?X/wurkEWaansO/ZIZgZOhp7rzANvW48K8MK39Ws5gZQvef2L8EH61NEqqP+x?=
 =?us-ascii?Q?BSfbzme/z9Dr5rE4heYofYlV2AmVEHf0v/8XY/MIGzm+pvqLgy14VbLiZOjX?=
 =?us-ascii?Q?JMAvFtNgf776YoGuAdNoK3LC4RByRuRVkID1iBYE9FQUPOe/uugD6/I5w+Rq?=
 =?us-ascii?Q?ECurcY+TigrBmVi2WvvmgiK3TZBeZoTO6WmK19i6QaIy9745mQENNaEphmzi?=
 =?us-ascii?Q?ElXNiwwauH8iMViI/ZGC0cVjPClkSIzcRWlQBMs+0/gA4M5Q1A0NzuQrepPn?=
 =?us-ascii?Q?6zNwesH0+m/6DEbNPcHEWUBCHRXSosfZ+visr5/OQiTQawepjOlToL4IXcDx?=
 =?us-ascii?Q?lTUJMvAHuID31AwLzGRRazNW2RhGrc7DuoGcQThX5dCFSRdid5yrViVCszHy?=
 =?us-ascii?Q?n6RMn+1uVivVjJ4lTk3foucViq5FcvqUacRHGNzElMmGuPfO0Y3sB/+M2jon?=
 =?us-ascii?Q?DIf0ukj+Ww0MLU52FZjY+cBzTEq1auolFA+y/gSLo0ME2QC/6jq4sbAOtYyZ?=
 =?us-ascii?Q?fV14P7Q43Ubve718Cjbvn0NIrsHLPOwnLsqqE/o36zNeVtAcTeFA03pgqxFB?=
 =?us-ascii?Q?2AFsJDbLq3Hwg/Foo6aCunKRXSh6n8oecuQ57SvjEz/yf8yxZebnjqBBEY26?=
 =?us-ascii?Q?BzCTW0Ym6cH2APEG0qFN7RFbXuJKF9dzPRiVfYcyjAVSP4MoiHkytzpxonaP?=
 =?us-ascii?Q?2cFhgZ7f7BdRDVd1m8Tg7BktNtojyKf5Shu2VDOfHaw0HfK9gTWgW2f0SA9N?=
 =?us-ascii?Q?uqtdIlQKepsvv9ezJwNUTVC9PpW62NA=3D?=
X-Exchange-RoutingPolicyChecked: Ywpl8Borc0ClJRvWcpwiaASHTQ3wHgHoktkxNnEancAwqhKCwU1wAjmIJZTd18HNnjp+74Qkg+InZoLNRggAEVTbnip7G3GLnUsmSpwbx5anUap1wWG/I/cm3MaQIXhIxQfb/juZx+yuMuLj7Dl4xgeP9o6KKlMUCtTKGWDyTyBydJKBtriPSlw4dgFSzgTO78fTvA6LGxu1I9s03tl4CJ9sFjQQIPgCc0iyGHQIV0h8F0s0J3ZqkkOF+lrLSmKIH4eDxUlZrmd3eoMcQIzGx9OhoVhhF9DYQDQ0E6U1PZgJaKUFyMcbk+lOiofTo6FJvR4SToa3/iKAnqQzX6IwNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a312add-2d03-49b8-d8f1-08de8bfb2816
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:19:56.1282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPkIn+QObb+xy8X8FV0xFeq0rcugUuzu1TVX89sdEM9vJoO5bVr4A+w2T5Q3Mzkx6TjMW5FIfiC8W7wnYuEJPfufYycDdO4PfKkIuV0MFdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7476
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

On Thu, Mar 26, 2026 at 02:54:42PM +0000, Bruce Richardson wrote:
> On Thu, Mar 26, 2026 at 12:54:06AM +0000, hailinxx wrote:
> > 1. Reorder recommended table
> > 2. add 26.03 recommended version
> > 
> > Signed-off-by: hailinxx <hailinx.xu@intel.com>
> > ---
> >  doc/guides/nics/i40e.rst | 52 +++++++++++++++++++++-------------------
> >  1 file changed, 28 insertions(+), 24 deletions(-)
> > 
> > diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
> > index 0c52807f26..a057db865c 100644
> > --- a/doc/guides/nics/i40e.rst
> > +++ b/doc/guides/nics/i40e.rst
> > @@ -104,31 +104,33 @@ For X710/XL710/XXV710,
> >     +--------------+-----------------------+------------------+
> >     | DPDK version | Kernel driver version | Firmware version |
> >     +==============+=======================+==================+
> > -   |    25.11     |         2.28.13       |       9.55       |
> > +   |    21.11     |         2.17.4        |       8.30       |
> >     +--------------+-----------------------+------------------+
> > -   |    25.07     |         2.28.7        |       9.54       |
> > +   |    22.03     |         2.17.15       |       8.30       |
> >     +--------------+-----------------------+------------------+
> > -   |    25.03     |         2.27.8        |       9.53       |
> > +   |    22.07     |         2.19.3        |       8.70       |
> >     +--------------+-----------------------+------------------+
> > -   |    24.11     |         2.26.8        |       9.52       |
> > +   |    22.11     |         2.20.12       |       9.01       |
> >     +--------------+-----------------------+------------------+
> > -   |    24.07     |         2.25.9        |       9.50       |
> > +   |    23.03     |         2.22.18       |       9.20       |
> >     +--------------+-----------------------+------------------+
> > -   |    24.03     |         2.24.6        |       9.40       |
> > +   |    23.07     |         2.22.20       |       9.20       |
> >     +--------------+-----------------------+------------------+
> >     |    23.11     |         2.23.17       |       9.30       |
> >     +--------------+-----------------------+------------------+
> > -   |    23.07     |         2.22.20       |       9.20       |
> > +   |    24.03     |         2.24.6        |       9.40       |
> >     +--------------+-----------------------+------------------+
> > -   |    23.03     |         2.22.18       |       9.20       |
> > +   |    24.07     |         2.25.9        |       9.50       |
> >     +--------------+-----------------------+------------------+
> > -   |    22.11     |         2.20.12       |       9.01       |
> > +   |    24.11     |         2.26.8        |       9.52       |
> >     +--------------+-----------------------+------------------+
> > -   |    22.07     |         2.19.3        |       8.70       |
> > +   |    25.03     |         2.27.8        |       9.53       |
> >     +--------------+-----------------------+------------------+
> > -   |    22.03     |         2.17.15       |       8.30       |
> > +   |    25.07     |         2.28.7        |       9.54       |
> >     +--------------+-----------------------+------------------+
> > -   |    21.11     |         2.17.4        |       8.30       |
> > +   |    25.11     |         2.28.13       |       9.55       |
> > +   +--------------+-----------------------+------------------+
> > +   |    26.03     |         2.28.16       |       9.56       |
> >     +--------------+-----------------------+------------------+
> >  
> >  
> > @@ -137,31 +139,33 @@ For X722,
> >     +--------------+-----------------------+------------------+
> >     | DPDK version | Kernel driver version | Firmware version |
> >     +==============+=======================+==================+
> > -   |    25.11     |         2.28.13       |       6.51       |
> > +   |    21.11     |         2.17.4        |       5.30       |
> >     +--------------+-----------------------+------------------+
> > -   |    25.07     |         2.28.7        |       6.50       |
> > +   |    22.03     |         2.17.15       |       5.50       |
> >     +--------------+-----------------------+------------------+
> > -   |    25.03     |         2.27.8        |       6.50       |
> > +   |    22.07     |         2.19.3        |       5.60       |
> >     +--------------+-----------------------+------------------+
> > -   |    24.11     |         2.26.8        |       6.50       |
> > +   |    22.11     |         2.20.12       |       6.00       |
> >     +--------------+-----------------------+------------------+
> > -   |    24.07     |         2.25.9        |       6.50       |
> > +   |    23.03     |         2.22.18       |       6.20       |
> >     +--------------+-----------------------+------------------+
> > -   |    24.03     |         2.24.6        |       6.20       |
> > +   |    23.07     |         2.22.20       |       6.20       |
> >     +--------------+-----------------------+------------------+
> >     |    23.11     |         2.23.17       |       6.20       |
> >     +--------------+-----------------------+------------------+
> > -   |    23.07     |         2.22.20       |       6.20       |
> > +   |    24.03     |         2.24.6        |       6.20       |
> >     +--------------+-----------------------+------------------+
> > -   |    23.03     |         2.22.18       |       6.20       |
> > +   |    24.07     |         2.25.9        |       6.50       |
> >     +--------------+-----------------------+------------------+
> > -   |    22.11     |         2.20.12       |       6.00       |
> > +   |    24.11     |         2.26.8        |       6.50       |
> >     +--------------+-----------------------+------------------+
> > -   |    22.07     |         2.19.3        |       5.60       |
> > +   |    25.03     |         2.27.8        |       6.50       |
> >     +--------------+-----------------------+------------------+
> > -   |    22.03     |         2.17.15       |       5.50       |
> > +   |    25.07     |         2.28.7        |       6.50       |
> >     +--------------+-----------------------+------------------+
> > -   |    21.11     |         2.17.4        |       5.30       |
> > +   |    25.11     |         2.28.13       |       6.51       |
> > +   +--------------+-----------------------+------------------+
> > +   |    26.03     |         2.28.16       |       6.51       |
> >     +--------------+-----------------------+------------------+
> >  
> 
> A couple of requests for this update, please:
> 1. Split the rework of the table into a separate patch first, then have a
>    second patch to add the 26.03 line item.
> 2. When updating the tables in the first patch, drop all non-LTS releases
>    before the last LTS one. So the only non-LTS displayed should be 26.03
>    IMHO. This will make the tables far smaller. [For 26.07 you can add that
>    as new row too, but when 26.11 comes out, I'd suggest removing the other
>    26.xx entries as they will be unsupported]
> 3. Final, biggest change - merge the two tables, as they are identical
>    other than the last column. Therefore, rather than having 2x 3-column
>    tables, just have one 4-column table, with, for example:
> 
One further item of feedback, I actually prefer the ordering that this
table has now, with newest on top. Rather than reordering this one, I would
reverse the order of the ice table to match.

/Bruce

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D799C369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 16:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8487D40267;
	Tue,  8 Apr 2025 18:53:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8201C40264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 18:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744131185; x=1775667185;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TmpwHrjfh9ZH8ZV68Q07bBu/0hra8tJzwrp9iwjzRqc=;
 b=CBZtsNlCOeg1y1wiV1nGINGkeaiAZ3k6y/+/eWvplAdBmGfVmoujhkll
 uqpsMyB47cZ/wbMztkV5nvw9b0aCr0GKVRZEcwl1Ooy/Kidye97ovLMF0
 vb8+1vnrK9FhPEvtXKHKphugHDhZM4Owf1ZxwXd+l8Sh2UqpZ2J6bfMFt
 fbxtb88+YScNpnpKuYwrottiRk4Aaqe4Df/qrihgxYyhEbUlaDiJh0T8s
 KsOm80xxuMU8y6B336PaHpr3VvCKww28VYhOOW3f0OwjaGVtt8E1x/Rhl
 FEvTc9aHgcGtDJ77+UG5Z0hHgLMf58x6BZq+HWQ81S5yg4CbzC332tp1N g==;
X-CSE-ConnectionGUID: Fz0kl/R7TSmQiixvkWFYMA==
X-CSE-MsgGUID: Re/DXMUfSH2RbGI/c/bBEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45589950"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="45589950"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:53:04 -0700
X-CSE-ConnectionGUID: ZtdjsYWkQr+yBE5SGMhefw==
X-CSE-MsgGUID: WXeQkmHLT0uFjqfR673nKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128194919"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:53:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 09:53:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:53:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:53:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqS7kWpnp6OJS/sw30E+swqvx7eJIOyHoUCtZuCGRcaZdS+n1he3rYo8BH3//1I9T+8oNNtpK022RnLuyAA2pJxIQ5eKyOF0KAgKMTkxrCPv4OubRcjdpcu6wvnjoDziTe0+HE9dhPDu27KyZehLr6f4CS40wBgGN3bJf3CSAk+vxp4YNSWHrgo5CbV6pHevFUGsTnn11C921cZDFv+VhnBgOHJp8mfSKSrMOFLjpxIURIeoViCg6uvieTb92/rejBFRl4sm464DQGgcjNK4FqAfHnNJ3UEzMygfjH8XmyNWU5hQLJepAbsYQK76ZwX9D6uzKxKrjyjhgQpVRjR5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLUJdvpW3rYWAktpIN3V85IVB/xTOXJr7b/l2CCC5oM=;
 b=Q6pXxcIPO322bJXVoiwx34Ej2c/ZVEjQw9pt1gnioLTKYWkIggxMIbozQmWlTRZd07rcIbgg84ZO/yNJzQ4Y/NN5qlrZtpe3+8pFs6gP86gr5D5ejK7Ru03JC+GhG/yB0Bn74vxgzrSUr+pkrv573vJxWSSVkCodBKl+02JiSOrqbawj7ECbMc85yWOdGLcO1EfCvVY8/Js+PsV6V9MMwoE0Tsyc7kzPsuAibObGsST2wXc8rWYmkuutrAry67fbwcNbfoYftjxbPr7ZEy6oqc+foXeRfGlVN7JGIQ2HzKE9vlmTRYzEwFXpfjKTsGc2LTStqzAuD+BOhbShtTiWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:53:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:53:00 +0000
Date: Tue, 8 Apr 2025 17:52:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 0/4] net/intel: using common functions in idpf driver
Message-ID: <Z_VUZ_gYm5l6kZCC@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250403112429.2741138-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403112429.2741138-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0296.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb49563-2176-431e-2dfd-08dd76bdd211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mm1kP4tb4a/vs7/twkXJey2WCGjhsCWgF9uRgK2GQQhHAKr2t58rMuXKf2mf?=
 =?us-ascii?Q?i0HyJfNCqo6ZZlClZkiXf/1WtJBM9oaCFrXpfbQ34LkWszkkQIZE+1hyoz65?=
 =?us-ascii?Q?oYnOGhKuugugHndgxpjR1Yo/g3uFnI/JyiL1RIb2ZrHswZ3HeJ0OInNTiLqg?=
 =?us-ascii?Q?t1mMTCL/hLSt6UZ6Yd/ru8GfQweXwCdiQbVbpkuyJPz5p19bCGhEdsDKdKTi?=
 =?us-ascii?Q?aS7zesnOUWOJNLNaTn0Snjfn29vaoW+2h8/JEvnoovcr4/JMtP4uYvC5o10E?=
 =?us-ascii?Q?cEE3h4WcJojmjGR0KMCjI2WGL1flFQw2MOJkHgvUItQWDX3Ds9SngZv8NK9V?=
 =?us-ascii?Q?i5VbUw7qlvxRZEm44iJ7Qkt5oTykmTPBOVHJHt8QMSO/Hdk2dVd44TxkodaZ?=
 =?us-ascii?Q?Ed+HCl695Pk1N9lRq+Uf4sH9XVIwsvb777so4nXBrYkGfpZY1azENTRAkZOX?=
 =?us-ascii?Q?eqxraVR7QPpKlzaX3EMpqQHW6H/6yADR+sfLiB1YOXHZYsoA6k040bpf2dC5?=
 =?us-ascii?Q?4/CdGB6cXcCdg5MtwSK9OurSgMnbos2WM7cSyxCcRSC80brgrSw0NzMcH94J?=
 =?us-ascii?Q?1QAcxRWSVs/dUotGPMLhSaEArka+IeEQedLfe9djaPCZPlezxyeHjlLhMLSU?=
 =?us-ascii?Q?kOTyXWl3bj54NgMHhtMGWFQMjbIFse9yZRjG5UlWkPlJEHYkcmt+ee9a9BKl?=
 =?us-ascii?Q?O183KtCqIEhOFBxckJVwy6OtIgxJdi2QzDkgfq6zhCwXZX08IASmUsP4Xndi?=
 =?us-ascii?Q?tnjyWyScia2dhWGUH1WVcovU/iEf7DpgDfQEFSna/pw2uIri9+afXj+TD3sC?=
 =?us-ascii?Q?VWiQRyHXOOwt1mFPIxQ6cx/qzzKyiWw/kSDFS0CvwgupeREwu2/TOwGV/0+O?=
 =?us-ascii?Q?R17RDMD40qHbvnA5y43dA2zgW0n86XspPCG1w6z52/8tykeInaGc9iuXt9oK?=
 =?us-ascii?Q?xn1KxUPMXfaNErigzkJX2PaNExu4Ao/PbtWUwjkfqwOr9ilQZEDebDVol2Dm?=
 =?us-ascii?Q?icBMCbGFLZZhgLFshm1fYFYYQld6zs+4hZioaN2Z+5PhaL/M4RuCf9qH+Aid?=
 =?us-ascii?Q?JNLxmTh9s9BCQVii2xZWxyC4LsxtP3N2e2cZYaPGgZHt60E3Jo2ptiqd6eVm?=
 =?us-ascii?Q?DLuCoq5ZlQR9g+AKEaTSNj3npvHdVroHCuKgOjFfqSbPRN9tEwUqlQ44liaX?=
 =?us-ascii?Q?jOY8+L65yNFUnpjSrZO289KLvuJTW/K0m542wlfvRSmps88E2OUAfkZzKImZ?=
 =?us-ascii?Q?zealpwlJkRfzAId2OjmT9IpwwGhwzKPlL4GlhUlTBDsp1jcPk2x7SoIkIiDD?=
 =?us-ascii?Q?0JQfIgyQ+iSjOTEWKF0Ro+BI+tvSlUzXr5zhl1k9mvlRCNLdQYd9RfVz3SsR?=
 =?us-ascii?Q?mS0pqch5RcUMIbmNABnohjmRWB5eAanixk5AOd3ewdFrrVOFN6aIc+k5NyeG?=
 =?us-ascii?Q?1CslaT5/nH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SF52XXlGxJ7gLYzlR9U7+ZHsEbJpyJ19DFn4VVYi/YUX/J2srMyPF8xmv6Pr?=
 =?us-ascii?Q?12yVUQJT4PthJb40jjMAzxYiFP05uEWGRbTVS9pMVVSY+JDYEHs57rx8yofy?=
 =?us-ascii?Q?nM2+fdY6mkL7snHcuaTCdsbv0CGBErT4xnF9yoplPagGj1M/EyR8uku+A9q8?=
 =?us-ascii?Q?c0Fpxb25OOEFh+wyPdiu3GUTNR4fdd3augdUD2zlXfmihWjaGJEig8DPXjaN?=
 =?us-ascii?Q?KuiSCoH1ssiLrMarZ5TEDD6zkiGQ1XDYj9l6r/TAD5iV2ThloHqoesMWBu5h?=
 =?us-ascii?Q?XfcoH9uGphrqDJnpRPjIyptjkLEG1mXuOp8L2HBoR6V8n8lzRUap4oT3CdXu?=
 =?us-ascii?Q?5Hm+QDP4EcJceG/Pv6NIpaACDhZE0X74tcWVqygMci7zbJQVoGY4EVxkoXmj?=
 =?us-ascii?Q?jt5+M+cY5/Vp39daFggkuKxX14gckv39hfVYTNOivR7Nzl7tHW8dnXJjdQhV?=
 =?us-ascii?Q?am7PBKh0EBYLeFaOXvpYJSLQOhH1F1RwtRxRGeek3c1QxByEr6h8fawwIs4y?=
 =?us-ascii?Q?QG8iNQeK+MFyW+PkDzCReqkEJOd++UWCnG8p7HnNwL5XnmvdvNhpHoz8f9Fv?=
 =?us-ascii?Q?98vSZGicyd3jPI3Pg4HwrK96ZJFlKyqcIr6NQokT5b1ZCaVheqKg1AKHONUX?=
 =?us-ascii?Q?09U3EYVHPPQL7zZ1Z4BmrGC6Hc8f92zWg9nMsqzzuz9w3SBHPi38D/tNMuou?=
 =?us-ascii?Q?DwRa0TxIU4+q6GvpryCGNw2UzX038HH3LGcvW3eYBQalzTlA7q2Nmqj88Cco?=
 =?us-ascii?Q?RuS0lC+YhPSm5tKIU7E8CFRaAWsrkD00qSZNghY38LzE1+RxlPuDEeVhl7IV?=
 =?us-ascii?Q?jaK/0038pAc/5Ecq858IJ4YYAZCZWzq6oDMyVxoVcTZJYB1EzqIwoZm8vKFT?=
 =?us-ascii?Q?quqWT9QBsOd/c4ucgUTrCSbY6Nq61bTGePiz+IHu5gAf5Z1aIlAY3u6W2P5F?=
 =?us-ascii?Q?odSA5svSytSW2NOvsoytgUhQXmhzH0AhHK54B2sos/zwm6tXD+DFscTW71EF?=
 =?us-ascii?Q?GxEnnVs+8PQzblOPJy2LhDezYj0TbbZbcngOI+BZ6cjRwB8odkyieEMr05Mu?=
 =?us-ascii?Q?j2N5vHpZ83/Y51QNWjLOMewmn38AT50zimu5oeosdUQc3Tw1zGiMstMavCPn?=
 =?us-ascii?Q?INskPHgcvhui0oXI0J8z7lgc6JWRItfvUfNEBCiwXYcfPHPgqBYFhVrtsJXx?=
 =?us-ascii?Q?jPfqJxyi95mJnXgB8fW0XYEl9fICEUMYSzv0jjOt1dTx21zHJBXFQt8FwkUx?=
 =?us-ascii?Q?Tq/ONIUCwt9acjhx+4tA8fLCJVsmQVawJ5ji1ZwkUgUBnJfZC3peg5WQFdsP?=
 =?us-ascii?Q?LKbsvI8OX9hTLXnH+GnHkzelkkoftJPDSYiudB+DE413CCX8Vdga00vEKX8m?=
 =?us-ascii?Q?Ax2697E52nDPIXCp7bEE2o9qoMLEWv8mgevY/P1LGsmkaQYKA2j3t5eyCOZo?=
 =?us-ascii?Q?m1JYqDMdmUtxvhiXWM6uYD8ShdCAL/70VKuhj7l7ZBfGYmbf01B++19NHTht?=
 =?us-ascii?Q?AwHfkbOqDNc2qGH2MbFdfGG4Yj5ZvFbn+z9qNTdXUQzxMbVoh7ydHJigMEBG?=
 =?us-ascii?Q?RVUofgaZQdxM4dxCK9mpU89O6MS/0dJRDP5cutvJmCWEKj4TEPHHjt/xMgkJ?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb49563-2176-431e-2dfd-08dd76bdd211
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:53:00.3271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAhOwntAyr4ASSQKkRSCfrgJ6tdbXNUOL5/xRBAFpYjW+UjP0WOgJMdJ4mTd186vWehy2u581h49ru2WFsYOFJQPtu06y7H5Hiez/mLo2KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
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

On Thu, Apr 03, 2025 at 04:54:25PM +0530, Shaiq Wani wrote:
> reworked the drivers to use the common functions
> and structures from drivers/net/intel/common.
> 
> Shaiq Wani (4):
>   net/intel: align Tx queue struct field names
>   net/intel: use common Tx entry structure
>   net/intel: use common Tx queue structure
>   net/idpf: use common Tx free fn in idpf
> 
Due to other changes, these patches no longer apply cleanly to my tree.
Can you perhaps rebase and do a new revision for me to apply? [Please keep
the acks on the patches when you do so]

/Bruce

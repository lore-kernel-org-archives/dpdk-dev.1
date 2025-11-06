Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD2CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 19:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 745DA4021F;
	Thu,  6 Nov 2025 20:58:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 56EE54013F;
 Thu,  6 Nov 2025 20:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762459123; x=1793995123;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TrXZAjfNI7jcGublsmsGQLjqa9S6KplzemWCzGpTAmE=;
 b=Gvy5D7/4EtsCph+f/bTZqxz+I4KSJF/vhRG6UXsh7rCsjFRouHjE/M5o
 AwLkh2RK8Ow98QermTJkvxPcRZFMqadt7bW+63PpdWtpIKLvZb41+PhzL
 15qYS33AKslrJuWMYKn6nYJFrN0io9vigR+Htps7zteHkp9lYJOBY1uSc
 ZAXwvJpK2HqkBNcOuqrPeawALRwLvPP7INE5aPSh+HLHsFc40+/q93JtX
 SjM0m5P/E4+6geLgt40K+cGEHi9MbnNBE0WQydANzg1jw08n5D6M7bdbp
 ZcjDF/asTL603ShOd30N7GJxO76DqkCrNyzeapGvT4XWpxjRMSqa9wIkH g==;
X-CSE-ConnectionGUID: D7slGCDcRaetq2M7PSByig==
X-CSE-MsgGUID: FP7pGzCCRLe90BfPpko8SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63621052"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="63621052"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 11:58:41 -0800
X-CSE-ConnectionGUID: tnFrUxsTSYu17O4Eh08vwA==
X-CSE-MsgGUID: sUSyJOLATtCbNByEmjVzSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="211299583"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 11:58:41 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 11:58:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 11:58:40 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 11:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuHWxXeiVuWYfkYPI4eNqi90FanprAm7s+MrL2PImDcpcrLBtwYRWmQkmkwDOO8rHxLT/rQkq5xHlOtmbHwgtirk76JWrPoDbU3amiEgk2HqssagzqFvwlajfaaMEMKX6MoJnt0ZYZk9aRkjwEgsTUcyiVTWH5qZ16Lg9fYm/k/yPPDrOgFjEJjcUTow5FyJnRl39sm/OoKckKq2EkqV4DoAb3l4agFFUq8ioCCfJJJrboxli4q1YPqwM5OnCXYlD5+DagiNugQoEoaANI7afUxJOGkUJW6PfWuiNebYyfIY+UR4BOZO2QKAO0AS/pP9gofcPy9YDoOd8YfVyjqjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXr3jaBel2CIkGksPD0VmgaR4TOExdBPZEYSylrDxSA=;
 b=QttE5r9Dq2LRDvT99HccVmANG/eTWRd0IA8W1Eutg+TF8XJ/LjKLJ9vXctLbd4bi21kOB0eE3k4rsfM5099D4IcrCZs/R5M7VSFMEV+iiMA2t58RAG4zHrpbl8DXdET7Tz7qj5Jn9jTYe4wfO6qhm6p8iOfYwIGGLXWJIG46uHnsbx5YkVytlkrmRKwTa7FCJ5A0u10V7r+mxIHMOfX5YP2pXxbN0IZVmSnSXhtu3t9m/QElEMtgAHTVxPqT0x2YbLMpoZQ32WGWuBTvD+1I6z/tOeTnOrDyjECzFXZjVt5Nq8DULQz5FvqmV7VVYJUwIbPfBD4wfNnkXHTaN2rGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 19:58:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 19:58:38 +0000
Date: Thu, 6 Nov 2025 19:58:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFC PATCH 07/19] table: fix issues with variable shadowing
Message-ID: <aQz96j9QKoo5s-Zh@bricha3-mobl1.ger.corp.intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251106140948.2894678-8-bruce.richardson@intel.com>
 <20251106113716.232408f4@phoenix>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106113716.232408f4@phoenix>
X-ClientProxiedBy: DU2PR04CA0270.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f2dc72-e3da-436a-d862-08de1d6ee0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OtSnQRLZGAa9V4tHCT87lJHV9xwjCAp2IPjcaqb49bzEy3nJt8f5a6eOTH4e?=
 =?us-ascii?Q?zoKJ9ullwle47OOg+eu5ZkWcoA99rlH9bp1T+fgv6ABkLWYixvHx4nw50Eez?=
 =?us-ascii?Q?uwhASCgMUNNQckYR/H0cWBaOxtZgbssNMWkWe01sdl0ot0mvKRzDM0v1RyhL?=
 =?us-ascii?Q?H/vCCEitbTRCISUwXWZAG1vfmnDQw9LDU16yjqV4MhNYhAQMVXxlXnLpM6V8?=
 =?us-ascii?Q?P0qvb6POZHV3mGwgNzP9YiifDLebQQwxddX1fHkkBzFlt/N99pZwzbbYCl51?=
 =?us-ascii?Q?AhQ94aYVB6XSi1ABZ6gJN4q7+6EPke/IldfJ4Mra/PlzmetHAARCOWNVCiG9?=
 =?us-ascii?Q?ht4aaeaW1XNHKxt5sJtH+60NplVdAZZySlfZc/77YihF2TgSeHA2bRqU5lOj?=
 =?us-ascii?Q?DqW5esfFSt6ghLG9N8HW2hOPVwhnts84m3tteNbWKw8E64dZ8clW1Zy0e0m7?=
 =?us-ascii?Q?FGDX+00+KU2iM1ehXU009W7DPWmsz1cTDmHqPKCEpLQsVjCOUdU1SFMD0gKp?=
 =?us-ascii?Q?u7jPz/0AYPjgLDsm98FnCfNOWoHQYJkJrqd2nXQLoMM82JpF6xk3wIfJ+Izn?=
 =?us-ascii?Q?cunowlqhij66WnGZMaXO2hDcylJY4zIVWbgWzTnPF5lMSnOwGDEhdhpvIFdU?=
 =?us-ascii?Q?dX1ZdmJEQ60fKZCtq5nzIzMfECyB8OaYAOh4yr/P3mZIaomuD1lKvVD0YVEi?=
 =?us-ascii?Q?QwAebRTyJmgNsOleR/4f/TD05l8C5JWFQHjgbcview+KYWIdzLgNSP3HBgYi?=
 =?us-ascii?Q?8cqJRtszSZS7YGloOmIRyAcmvK0yfASkIN8sYUDoU7DlkhXyKbjl4zV6N4Gt?=
 =?us-ascii?Q?WuqHwmyzaiQT89tP3ZIn1vjbJftbZsYKkKUsXDtHQanZpmFvUi+tkvD1QGrE?=
 =?us-ascii?Q?eukhTTO6PfGsveyhjPbXC1o0hz8d1Kshm5LhZpZqls0OHg13ev3AwId7YtXX?=
 =?us-ascii?Q?4Twxsr3Ky/PGB5o3v2WP4tPikqltP3EKljBjbwIVUf85ydFmSU9/W6t5U3S0?=
 =?us-ascii?Q?CpQ3zDoMSLOaIuMaFmckz5hRYAXelDmJt21jNU3zxcjO1yfZNwVtiLnKCfko?=
 =?us-ascii?Q?VQ/ozsBmlm/I1sdN3SmVXFG40HiEN1Nju7MPab/f9F9Gv1WftRhfYxpsLT6x?=
 =?us-ascii?Q?9q1D9KhenJqTeX+Mitmkguu6AfTqEvZNRZJYd8RoMWM+iXAsDhU3ScJdEhn1?=
 =?us-ascii?Q?HSXB3M0y57rInNUuqZVSmnyg25h7aiGjCuQrkczUlg/HnptZOzGzJPrHDCbG?=
 =?us-ascii?Q?c7HVzppxKYYSlMZu41NL6QYe90VG4/yGsNe2zqeLYJoMaBosxIDQi9k0z1s8?=
 =?us-ascii?Q?pLMlqK+F1AzCdFCbEo86OdWRgSW+iTwZQXm1lWeHnpZdTOeixJJ2w5/NgDus?=
 =?us-ascii?Q?pdbjjQKcmoIROdkEm2VqeEBtcUnBPFBxf8bqMmgBJN3mTCBkr7DAHO1Lnx3x?=
 =?us-ascii?Q?NnknbfujRO/zwq7e8j7RgTh4QsrJlUNT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?15nUKVV/ubtHS3ybm/BtzGRaQRBdUByZvSc0ihvQJ1tcSP8N3zrXsLFVhkNS?=
 =?us-ascii?Q?RqBc6AMUTeyDaqQIam1N0l0B0niuy43d0qixqjQQYTkfncPOTakKqAnryoCo?=
 =?us-ascii?Q?VxzEW57W5S0+Z2kQDwBw9HDD5Y8O9WSSlInRdhitmTMfQNooa1wLr+FHnHrE?=
 =?us-ascii?Q?1Zc2WSSw1WPGk5z5O2ygvysAjPDXQPDcuZUNRhVJ1HJqvxKxj8Dtw6/SHHWn?=
 =?us-ascii?Q?J3TALIOPKNvFV5JOcXoJR9Ms9PdGQRD12drYaRCDVMVidl21sufws1bQgUK2?=
 =?us-ascii?Q?aASv6fZXkhFawrqaEc7GWOfAirs/FfRRUYxViv1NE8bopgs3loBdyUsGo30J?=
 =?us-ascii?Q?AMwJRXjp0Tdqlv8Ahu3FXJ6I4zQvbzmKNdMuc2tr63ATMJRTk5e09XburDtS?=
 =?us-ascii?Q?6a7bF4USM8e6ANpKSu1w2LzIdupySzGluTdaGA9jKSnYZKpHywZzrG2Oxhpc?=
 =?us-ascii?Q?h1k2BY9BohcJGijVHl3Jkbb5RhOusRTYZ1KDWHgFr7rhIai58aMCrs1UftiY?=
 =?us-ascii?Q?DXIwNs4050DjxAdBH3N+4mTxhwU7roFoTZxFRyulNiYdHc2QmNeJec71jvHw?=
 =?us-ascii?Q?GT94wAmSLAFAoNCR6Uun3130ebBXl0xmgNBnGTOvloPyH7WxoyEsuef5AoWe?=
 =?us-ascii?Q?XGg71CP28K+Kkv3sz2zPdQTpJAFzwcU+mRpLCzRsa52rs/sSZKdLC3s+G5Eo?=
 =?us-ascii?Q?cwVryURfseOJj3W7i6LeZ5jz6Pj5mRSKaAZ6iETCBhQzHsIz8kPYXoBOxRSU?=
 =?us-ascii?Q?2ycvP3vc1u6sYNtaS+hdgqFoW8uxdJ0zgnTTStUMdetH6Nj15o+FybgW1ItE?=
 =?us-ascii?Q?z5mP8NjLgBU7Nt7YlIoha2FDjrH3R9Fw+GTX09G+3zsFWOnubmacIwrnl60J?=
 =?us-ascii?Q?a8qNZfSXGe12ntO+C+ErdQ4ai5eRlAAmoW3FTeLGBWaOEm4oJwai9kMCpnLH?=
 =?us-ascii?Q?JsoTj1Fp57DfUCHerwpcXXQ6QVpV3V/AmgCigZj7ypqlSO2SL8aPbIlHwrkd?=
 =?us-ascii?Q?/3GmR7M8jtSMEPOApjlH7ZMrpaBi6xZ+t1H5sEalykZE3nNNbI7WpQaPorR8?=
 =?us-ascii?Q?PV6n0jarl2RLe5qtv+hJGDaEG1OczNSuen3MGDDDz934uBW5EoeuGSTu/DhF?=
 =?us-ascii?Q?VxYLGJj5o0V/rukdGRwdhhuf+DuhJaB7MKWUjXSedxuyZ0zNShuaOZNIgWDz?=
 =?us-ascii?Q?CvRFJDk4GkNyE00fAGQ8eiC1I/a6Y0gGZsfet9jYRbEQTTH6dk1zVaEJozmj?=
 =?us-ascii?Q?uRYfD3hYYfeEf53/Ac4jdxMLc0TaVGAAgAt9PGiEcwdm0WWZRlWzw6WOTgIA?=
 =?us-ascii?Q?t4Zw4tdhY50acOEnaaWH80eAyvJ0XVehkivCLmhZplrflB27pb3lxBTpokEv?=
 =?us-ascii?Q?GRmyW6AEe519+GTAFqnVrW2tNkGbiinyHBFI9pO9nCK9e7YMa0S7zwthg+yE?=
 =?us-ascii?Q?Aa+YLpWGNgEPpXnr8MslYnwq8RVmUU5esiF3qxePqAgU11ua5ZqU0zLoMEUJ?=
 =?us-ascii?Q?AYtP5My+6gqEsD2VJBg2MQWa/vWglOvlLP/S4Wb2uJyp9DK/WIm3vmse7pkv?=
 =?us-ascii?Q?gyPq5VvMjFi3wiD9ejNrsFdKChVZETgMQMJrlrmVOtyB8/vzTATvOruKrOzy?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f2dc72-e3da-436a-d862-08de1d6ee0c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:58:38.9175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErXYTOJ1JsSRxO878cYN3xvJQ+j+1LocslXVDH4LH5fvfuVKWorbqB13Yx30LICBBy6OTabrIyQRPY/CrkUQphQfvNYJbAe8bszNlXCsi7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
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

On Thu, Nov 06, 2025 at 11:37:16AM -0800, Stephen Hemminger wrote:
> On Thu,  6 Nov 2025 14:09:36 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > diff --git a/lib/table/rte_lru.h b/lib/table/rte_lru.h
> > index 28aab12923..1436425e16 100644
> > --- a/lib/table/rte_lru.h
> > +++ b/lib/table/rte_lru.h
> > @@ -41,33 +41,33 @@ while (0)
> > 
> >  #define lru_update(bucket, mru_val)					\
> >  do {									\
> > -	uint64_t x, pos, x0, x1, x2, mask;				\
> 
> Why is this a macro? Prefer inline functions where there is checking on types etc.

I asked myself the same question as I was working on this. :-) However,
changing it to a function is beyond the scope of this patchset.

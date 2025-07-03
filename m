Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97702C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 15:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9EF8402F1;
	Thu,  3 Jul 2025 17:35:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id BC92640264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 17:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751556952; x=1783092952;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=WEEpJMiMlXwcLTy8MvtZX02VYf6WhB0S3jJ1h8SKKEc=;
 b=mu+R9nTx3L8+zE8Jtt6KZG3GuT5zl6DiqJVkQqs+ReOyBab2cNo1/ZQi
 X1IcpmrTzr99P6SeSn72UsWlKxyBk2x3OMkRLf8W/cVbQ+hSUNsygFit3
 P3PFvTI8H+p6eTzS5zcNojo/LhrGhQ0veHBYiWiuE0MzlXxpDp1QucN/r
 /y4RjJKwl9Njruf7OiaYIvStxNU4AUfyt/gcUvEVcYVFQeODX3FWpXP4r
 J6NAXX5q1E3QVnrgbmJtprA0jTvOpYvURyvaAQbeGW4aISpzzNzMBDa5o
 sw/eXA5AhT7W3WwTs2lakrUH8kUt9PyeHiku76u0eJwG5A4P9aVXKMvV1 w==;
X-CSE-ConnectionGUID: mn2l18zcTtuIUuxkMupKmQ==
X-CSE-MsgGUID: DXJhu9+mREu+TwMvqL7S3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76436317"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="76436317"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 08:35:50 -0700
X-CSE-ConnectionGUID: JZeLJifpSGi1UYFRM11aoQ==
X-CSE-MsgGUID: wMTtn0BrQFivGQgy4fia/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="155146480"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 08:35:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:35:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 08:35:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA3OQ5fnZVfKKJIL8Sx5BwGpitiLl0se+AE6W8FjXVvAhPu1wnxprcEihyXBQVB6vs4NUQfks5mfxI+NUUgMfPSpOXjsuLKqU6GHZ+kx8fgaoZOC+XaKDIICF0x6t/2n0F6TCrBL6DRKr2Se6c7uV12Z8eIY7HT/d5wspn4vpbASygeiZcHmiBeQiFsAWKHswL8XFh31wm8MQIs5qMlQXjQ3p6oDS2MGlb3TPEvXc3bqH8xQcu87BgkEKYO6n0rDVpj6jCSc/Us8NuQlADa0/3SgJoIKqws8mpqeP1g/HYzStQ/hDV6spGPxM4xOIlpJ6qFa8N3JJUPwBYhFRVOZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmsbAr4Atfs6zsmB9X2x7KMN+vFGunK+YgPdJKULKVo=;
 b=e0JwwqT21DkoU5eEl8Dd+1Dxm3s683IVczQ0lHl1u3a0Xu7sL0lPnOwBjvjQ6bf+ZdfuRFCn3gSOySJSMGnbNnyCXlT051NPA81/sfrKfgbiV9jcGA4F+fKZs1MJdyx8OfmeIlgYqvZf5aYfyhHIoXKd2UhBn0Zcqy9suiNeFUx21pyVokRnicKeyIB2qudv+w+9zkRVgaxEjxjMynFdDp5O40dh4ngdHR767xNwTskz1jXNbL+jHTwYHdGm0uYVK21PNIKPYyDXtVJdYR9NLIdyVv8AWtfrgwY/qxuH1+d4ko2qi8eUcRd6zVFYjQdRhs1C1KIfNy/2rT61560JMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 3 Jul
 2025 15:35:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 15:35:47 +0000
Date: Thu, 3 Jul 2025 16:35:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <thomas@monjalon.net>, Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 <dev@dpdk.org>
Subject: Re: [RFC] ethdev: TX mbuf fast release optimization
Message-ID: <aGajTksN6fYProxS@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD87@smartserver.smartshare.dk>
 <aGaQNxwbTTTF0Al7@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD88@smartserver.smartshare.dk>
 <aGaf3Ii3OxErvYEw@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD89@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD89@smartserver.smartshare.dk>
X-ClientProxiedBy: DBBPR09CA0036.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b152a4-650e-40aa-befe-08ddba47482a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FIl+7kgPXLjj3GBcUI6tAGgb2vxsvefDW2Jc7noHUTZqUItPs6wR3OVn5a?=
 =?iso-8859-1?Q?gKc5z25QsVB5P9W1GgQ67adMa4sAYprbm5gBVeIVYDqHelBDlVNgBZNs5J?=
 =?iso-8859-1?Q?RBRb3wk1ei8zolCFt4CV6D+btXuSQRxWvO0KOFM0WjQGHiRG2zpZPspgn2?=
 =?iso-8859-1?Q?N2uAaXwTvoQeS9WzlVENuIRzW4NweYOtB6aAODGHcBgDhgIj3l00OKYm7N?=
 =?iso-8859-1?Q?76Q+2na1YyaHMAHqsJt0ZImNfyeOxisFAfMOiV4S9aKuAbDAyYV8UPHZ5b?=
 =?iso-8859-1?Q?0QhbeosBOOsjF5zDqYAghK9jH2AiQtEL97/aBB5GQI2xOAKvGKsKaygtAp?=
 =?iso-8859-1?Q?dbTOi799uGoQhnwiBoicEEQ/ZlNC+zY/rrbQHh9P8QG5zUsX/EPfQ00tEm?=
 =?iso-8859-1?Q?51aFoFUc2g0Rq5ZvIpHOW+nYFBAB/4ant7nFyE4qmjLL8HfNJqgHaRxRe6?=
 =?iso-8859-1?Q?zCgDTrFSyv9S4HWjMXCq5hmaXGvwZo/GAY/h/JGWWmbhw0UGQoylHf8Uhz?=
 =?iso-8859-1?Q?0MrrEQ8ika6lrMBTiqfUUenMKKeEI6DqvcsA+DYcdYX/IWVJIuzZtF7VOq?=
 =?iso-8859-1?Q?DqrLQeeKBS2htPk4isy3ud8imk/qXyAcJaChJigPLpifQDwEZt2+g1euu8?=
 =?iso-8859-1?Q?KnKyzDw3Q6mSfpLN7NwKsT3ABJLj7kTnlrM5xhFlDi6/ay5XWwVsIsL8h1?=
 =?iso-8859-1?Q?c0xJE/gD6AuQdKMveKUALwyNpHUKq3vQ7IniderStT9a9jBw3LiMI5AhJq?=
 =?iso-8859-1?Q?NVD93KJIA7hVcLKFTgOHPoc93wveUatbRdEWrkGoeou6OcUtXybQLv5hcX?=
 =?iso-8859-1?Q?ZVAws7sxwTW/I730N0iat4Olxe17d8DOGd9lEndd8gPnChE4WIZ/E5Ts9H?=
 =?iso-8859-1?Q?AA0cYCI1y8Yf837DV5jr7HP/97YBYp6UlVdua7ZQ8x8bmXcBwNmj5Ivohm?=
 =?iso-8859-1?Q?fA2tM5L8jWTDfXcAIfDmQvdicWgfyidnveIh28UmtHEF1vERoYNfBVjr/V?=
 =?iso-8859-1?Q?BFowX7vWZtgzciiYWN6HoG+k84q1tP8KgkAa0TJSZOCKtOtit6umgB/PYz?=
 =?iso-8859-1?Q?b1q6Q+QtJwNXdKZvbNOsuDGwT3ZSOedPwafjB8D61bE4+5urH/MDiXY+zV?=
 =?iso-8859-1?Q?g0bmRzusuGVghMirrLGl7sMfC/ypBfKfpJP/JqGII3rxoArcepSxw6X5G+?=
 =?iso-8859-1?Q?14gbWz8EsyoRQ9IHYNaizLQy6L+XRe6kLTleq8qOdM4Z58EH7N25+25zm/?=
 =?iso-8859-1?Q?QdpsEO6QzsQB/2kBHHpOA6HQOmbXkJ13s31DmvmlxmcLe+w9DaQFiFPYo8?=
 =?iso-8859-1?Q?DHQRWRep0tdzDZ72LePahABemBL1t1AKAzq0EPXgo4Pd1LajYBR9UYrE8p?=
 =?iso-8859-1?Q?Zj28FyBpUo8NO8PQ0dXIiqBOgTsTvULAoe9M69DXMI8XYeDF0PCGB0SPqN?=
 =?iso-8859-1?Q?C5edaOz0veHJL/ZKyC+DX4+wnZxxwx2Ykc5KNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WnEMkaVKELHB4yRqCIGApHq8MzyiJyGTrM0yvZ/y3t7rt8VgNNJJ6pOB73?=
 =?iso-8859-1?Q?nHgq7klHbDhiQQdliBR5i6o2eVbVRWEPL7FrbZvIlz5xEnPP1wZHq1nqPI?=
 =?iso-8859-1?Q?lo7O2/Q/+ELIuPzkJ5nbnHcsKY0J9iRIVJ0M7VXyTsh9qlI8xeHa9QIMqZ?=
 =?iso-8859-1?Q?tPl9GGIarujmEo7v49ZpP3TNTKW0kuZ/b6Y2v2PPhKgnhl025FR5IR5dDd?=
 =?iso-8859-1?Q?xETq4PjWCX2IQUsXRPf7L5mEcq4xx2kJcPh0320viafaT0nq4AsrFmfH4q?=
 =?iso-8859-1?Q?PuJHdoUBkXFJ3A+O8LSwG44wPAEN3/yNFiN8anvAM7BiY0gImDbl9zKdEO?=
 =?iso-8859-1?Q?R/2bB4F5hggxyWOUW68qXUvknW8QH8uIzjp+WIY+qLhQz1BltQM5lmo9ws?=
 =?iso-8859-1?Q?qC+sU/OXQ5GDOgWybjfn4MXAf2Lbk5g/NfUqaf9GnbBjelnZlg7nvxWRkb?=
 =?iso-8859-1?Q?KYHp8ulxLMLYHa4MjAGENtH3iorvgue17qKM0PbfmDF0ycEWfe5iF8+qba?=
 =?iso-8859-1?Q?mXkeLfgklN+LVJoIPtKYdL2Hx73hr0h6CXqZ7O4cyD+KdQM/OI3OgoxZOH?=
 =?iso-8859-1?Q?Vp42spk+LNqgheywBZJvAAkuZuvC7LGgRPuRLl2nc9MxTeS5b7QA043kDU?=
 =?iso-8859-1?Q?0QcUm3unDULpyPNpuMIj8VMxPdEcXRB7tIgwv+sbv6qK/iFu940q8bROR4?=
 =?iso-8859-1?Q?hQisfiIa4o9qQljj+pU5f8NdwOVnJyegXVc69g3HXXfF9sbTOK4iFRt4Mo?=
 =?iso-8859-1?Q?Qb9g8RRCS0DKICJtXzwCpHPZ+k7uovZ3nabv3Qc3j0DAt1GE2wAJoDwfS3?=
 =?iso-8859-1?Q?IVbfivWNlddQvBhEGrw3ICMTN+njSrLsFAFBKZ9tfV9ziILNfwAborL6kD?=
 =?iso-8859-1?Q?oM+WRTOg5PD/uoxh7d2c2OiDDs2MhHiGy4MHsSdstPZCt0D6UqsG/uAThw?=
 =?iso-8859-1?Q?hPafCZq0q+3Xp8Gqg03KNOBEtnprPI3ouXIrhWitg6O7oyiLxwwYu+uyWd?=
 =?iso-8859-1?Q?tjhGboHP9WzpoRxQ906N3DtSMH/VEAYgL7z4UTRVtcydX/IXlvHrk/AB6v?=
 =?iso-8859-1?Q?4EsBTvTy91YfyIpHEb9uPcjbZGiyglVpv4NiX/bF5js92h0I8zZ5g4hBPv?=
 =?iso-8859-1?Q?/A8dP+korFiLRLZUchKpY4zUSPitK9kophgZO3wzAjPjnX64R9CPGjBE1b?=
 =?iso-8859-1?Q?MZGjrKXk6E6+KuCGpTYHc3oMMzrsLZb2gggVsqOeMuFTnE2C/sRl4ff05y?=
 =?iso-8859-1?Q?IV0E7j/D07u7fzK7JtfzxSJkasgfBscerAtOisLndp6pUA78pUcrIYs7w0?=
 =?iso-8859-1?Q?Tk8OnsSA5qpl4UMd/KL+c6j25rzZBEa6Z3xrWCRe4+b1Dbga4+lrkLclx8?=
 =?iso-8859-1?Q?a9KrFc7gLHnky69hJ8uFK7hZ8DpMMT4YtsxVaNrdn7vcnTHMxCIzvEwfaY?=
 =?iso-8859-1?Q?ISdkAdgGHzJjw7evFfpC3iBQMX7CWiIreBXM0XoVE74JbbwnJkm14CR3y2?=
 =?iso-8859-1?Q?aQQc8DDT79AXGaxdTAVJ5HkNRkrDWrAWS04R4+obiZhSpEbmBF5I/TjZ8K?=
 =?iso-8859-1?Q?YqqnM1E3SUGW/HIXCYhLOcw4q+pC/j+HqjxiO/nrwmoVZUm6if91x68VjP?=
 =?iso-8859-1?Q?BnrmOo6ihfqHr52Wtei9mIfNukKpR0fAvSrN+zaLxJKeawYEvhvFePtg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b152a4-650e-40aa-befe-08ddba47482a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:35:47.5437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhf3xl5BMUzoz7A+i7E2j6MOkUi1AATRcxP4NS+7GshzXNWUki7v93XPNAAagzuiNmIxJ5wBSu4Ufywd8j27s2GN+Xsfr+f5uBQ3PL6vIh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
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

On Thu, Jul 03, 2025 at 05:29:26PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 3 July 2025 17.21
> > 
> > On Thu, Jul 03, 2025 at 05:12:46PM +0200, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Thursday, 3 July 2025 16.14
> > > >
> > > > On Thu, Jul 03, 2025 at 03:59:14PM +0200, Morten Brørup wrote:
> > > > > For TX mbuf fast release offload, I propose to add the mbuf
> > mempool
> > > > > pointer to the ethdev tx queue configuration structure,
> > > > > so the ethdev TX burst operation doesn't need to fetch it from the
> > > > > first mbuf of each burst being fast free'd to the mempool.
> > > > >
> > > > > This modification of the struct rte_eth_txconf, and the
> > requirement
> > > > > to set the mempool pointer if the
> > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> > > > > flag is set, will be an API+ABI change in 25.11.
> > > > > Should it be announced in the 25.07 release notes?
> > > > >
> > > > > Note: We could phase it in softly by letting the ethdev drivers
> > > > > check if the pointer has been set, and fall back to fetching it
> > > > > from mbuf[0] if not.
> > > > >
> > > > > /**
> > > > >  * A structure used to configure a Tx ring of an Ethernet port.
> > > > >  */
> > > > > struct rte_eth_txconf {
> > > > > 	struct rte_eth_thresh tx_thresh; /**< Tx ring threshold
> > registers.
> > > > */
> > > > > 	uint16_t tx_rs_thresh; /**< Drives the setting of RS bit on
> > TXDs.
> > > > */
> > > > > 	uint16_t tx_free_thresh; /**< Start freeing Tx buffers if
> > there
> > > > are
> > > > > 				      less free descriptors than this
> > value. */
> > > > >
> > > > > 	uint8_t tx_deferred_start; /**< Do not start queue with
> > > > rte_eth_dev_start(). */
> > > > > 	/**
> > > > > 	 * Per-queue Tx offloads to be set  using
> > RTE_ETH_TX_OFFLOAD_*
> > > > flags.
> > > > > 	 * Only offloads set on tx_queue_offload_capa or
> > tx_offload_capa
> > > > > 	 * fields on rte_eth_dev_info structure are allowed to be
> > set.
> > > > > 	 */
> > > > > 	uint64_t offloads;
> > > > >
> > > > > +	/**
> > > > > +	 * Per-queue mempool to release the mbufs to; required for
> > > > > +	 * RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > > > > +	 */
> > > > > +	struct rte_mempool *mp;
> > > > > +
> > > >
> > > > Is this really best put in the txconf struct? Would it not be better
> > > > just
> > > > stored in the queue structure on free or Tx of the first packet?
> > That
> > > > would
> > > > make it not change the ABI.
> > >
> > > It seems natural to me to specify the mempool at configuration time,
> > > because it is a configuration parameter.
> > > The txconf struct seemed like the best place to put it.
> > >
> > > Fetching it from the first mbuf of each burst at runtime, and possibly
> > caching it, seems like a workaround for the missing configuration
> > parameter.
> > >
> > Not suggesting from each burst, just the first mbuf seen. One time only.
> 
> That's what I meant by "possibly caching it". :-)
> 
> The check for the one-time cache update still takes up code space in the per-burst fast path. (Although very little.)
> 
> But I still prefer providing configuration information at configuration time, rather than snooping it at runtime.
> 
Ok, but then are we mandating that all existing apps now are required to
pass in a mempool value on Tx queue config? I'm concerned about how many
apps that may affect. On the other hand, if it is optional, does that not
slow down the fastpath more having to check for this optional value?

/Bruce

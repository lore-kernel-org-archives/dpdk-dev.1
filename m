Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308FC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:19:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CB48402D5;
	Thu,  5 Jun 2025 12:19:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A076C4026C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749118756; x=1780654756;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3K7dmxHedBhP4PlnQNBJF4ztzLCE7jwZYvS6Ti4mnTU=;
 b=R+FndV26fsk+58W4SL0Kx6NWjwGiRQd0BTt8OvTLZES5DfLSIIuCPLMw
 0FC2Jjim5/126fjqOSgM0ai2zwwcNej2m+I3tpzpSQndR5RUQDkbx0mvv
 bZ7N0e9wEuciSelnVrSdaeMlOniN0scfci7iaXGzXB+xzUi9e80idXVeY
 ZpEiAnsos5u5PMW0l3BVHiDBOjEGgaxxCVw48wVjLx4sxiGYmXx5Fkkjk
 BAP0HmbDWqu6iYGep4Rq+e2J28vl2KtJ/kewqQebGOTHk9o4QO8gPQPS3
 Z0HlbP6BCGMpnvnbodMChW1PNmMQOy3EhI1YFt4UchrruX++h0jwCqNHS w==;
X-CSE-ConnectionGUID: ORIsMR7jSHidVrdZMtHZpw==
X-CSE-MsgGUID: rHjrJwC/RN2BkpUm/ahyXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50344845"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="50344845"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:19:14 -0700
X-CSE-ConnectionGUID: cfun7ZIhSGy1CJBX7SGPrA==
X-CSE-MsgGUID: 9I0oNo8UT4G4Dp4MQMznUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="150480901"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:19:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 03:19:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 03:19:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.74)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 03:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmT4EomtcCGix2OBaYarY9kEQXENN2qaNuIdNwFkPbN9GoR0g22iL4iwyBx+yhbuMHBDf3LWStQJ78APAduknqLaibIXlv5y386YpRm+fEZjEOliSFHsg5I5SnFGrLB8oK66XvWgJMMbIHTyfhA2qaIF9EBq37Ymt+yxPZckdHcv3jCAehoMkHcyFGGnMdiqmUQntW7YyIANhCcAMReIPclDpWvsqIxeow+InaaRvDwV4b8MZPXUdBL4n5Pe/149Yf1zEABq3uKZElNzSpd1mGxEmg2eWYC4zfNfNWwoBLPZfVZlRKPugk/Ymlpnkt8jbU4Baft1GgaJABRRVIpfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhATTcxm/jLl3740Tp7SprlFvjD+dqbzvlBjWwwOMXI=;
 b=ytRk7pB8Yz1qhzD/S3COiqJb+GNzt9gUJZL8zu0gbwK0g1oaTyFpDm2r1qfsKUjx4XhkbQOjpfTz6UMKv/H7XeOYeAkDMJ7ZvTZxlFcdZ3JkElUvoHiBb+6faKwsVZzL2JQaW3//MxqhzD8Rjqdkz7+EoislEXSGnp1t5RIIc2k4itlJxvNqgv2jyEp8Ve6ZOkgXQpT88hIl7q/osIYWMvQcVRypxREiIrlxqQAUpQm4sFypIqnIOhTeq9DWufy6NaIIoTIZcoAa1cn9qO7Ixl1brGTxDbIsY7rTPMNj6gn4D/pRmu1s9391RCpq0f1BqOK2i3kmM+ddxjgPWUzuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF8225D2149.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 10:18:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Thu, 5 Jun 2025
 10:18:55 +0000
Date: Thu, 5 Jun 2025 11:18:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Gaetan Rivet <grive@u256.net>,
 "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>
Subject: Re: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Message-ID: <aEFvChZ-K8dJGcI9@bricha3-mobl1.ger.corp.intel.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
 <aEB6VEFCKr-2t11p@bricha3-mobl1.ger.corp.intel.com>
 <PAWPR08MB89092A3A53CBFA874B1AEA729F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAWPR08MB89092A3A53CBFA874B1AEA729F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0302.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF8225D2149:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9c9ae4-f354-48f2-a7fe-08dda41a60bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fswTILzcNOKEuS2/d4q9MMnaXGluxxtzzmslvplDSzcIRVCVEi5UfqxvNc8t?=
 =?us-ascii?Q?H8SUrKvalX/nfS4wnTndrkst5OdBUzYlRCCbKuxtJvd7fK2a/36o+UCH8SQ4?=
 =?us-ascii?Q?7KMMu8SUW00L6FxLp1TgoUtHEyMKpv7jrhw2uk5I90RGg0vH21ZTWgsg8ceK?=
 =?us-ascii?Q?7qyIjMLCErBVqClmLP5Mgnj5Oel+lJoODlbEOkGQmgTmxIc/8D8D8TcEa+i5?=
 =?us-ascii?Q?RnFc0nBoTf/10jpYo/rlZx20mhrAC5/6Mw6aWDniyU9rtMJKXQP/JRnPK073?=
 =?us-ascii?Q?jPXcEVt7Y27iUqwdC3N4/C0DyZUZT6LJJcyDwzhaHB/L2Dxk33gxZEriqxIB?=
 =?us-ascii?Q?tY3JfsQEAvjtxGQezRekK7esAShWI9YLh6Mos6xsj4QUyDjPrijnCrnXMpEj?=
 =?us-ascii?Q?bNl1kI3SIu8Futoujigp/ZxZ6RXhbE3SJuYPsSmgevcwH90pJ2qBA9J2z0aY?=
 =?us-ascii?Q?S17YQG+1shqi9QIRH2V369ExqmKmEMsp/5IV6vZGim9KP5IIOgWyQdXqFW7e?=
 =?us-ascii?Q?vy+n+F5e9V82n2t0S1jMhpdBbAPnGP8evtkEBYuHP+6ZvIhnQRN+r7jCEAq4?=
 =?us-ascii?Q?C4dxVBlj5E7IsJxUkfSZerVVo9c3ES0ZyGcI3ZTDeREB7XeS2WJxeZ+HHFzB?=
 =?us-ascii?Q?3jhANyOGpdVOIj64X2/bGCYXPZLKFMh6iFEIMQc1M1cIXtRVsSNrmfb9yLn+?=
 =?us-ascii?Q?sCwfPd9KQ6uy213hoUTIRrq2QZiDqYCVUq7dX4AmlPMP5OG2UjHskurig6AO?=
 =?us-ascii?Q?j1kDl4+VmNwzXEUfhUCAqgk1Ave325W2/yUdfXPwupGhre5PHgicY7dpOuzI?=
 =?us-ascii?Q?Xh7UnOdixPbnyy3CfsuJyT+NLozuemRZXarSNjr5+wKgDJfJYRsn8/a8Malr?=
 =?us-ascii?Q?DqbngC9S4KJo8YPCFR3cvT5aJh/3nnzbIg+EYlq/0fn2j5j5EI1iiUFwTnqV?=
 =?us-ascii?Q?dMDzLm33r/FsDaksFbJhFH8NL3EfL+tCJw0++ooYjQk7Ky13m+UHP+mfdPv7?=
 =?us-ascii?Q?d4ea2yCa9I1zim0P5IRt99NjZ9Y2Jh7FPCiIWWKA7DY4tJjTO6HtzsifOb4a?=
 =?us-ascii?Q?Egn+9OC9iJf/bIXhd4sOg9pFMK/ym0LxCSFkVLkDqJjyJG8NvkjblXTxJeSz?=
 =?us-ascii?Q?mSkA8fIU1Nh2bMoUnBJujSh1IOSTcD0M0yWXsIvsIc0Cw9rM1MsQrVfSL8J5?=
 =?us-ascii?Q?QEZFH00SWVlK2dzixxql/VNKFL8vkoNa07Xv9aoAPPp9qo4FrATH84oXq/0b?=
 =?us-ascii?Q?LaZp7Lk18eR30VwH4QPEo/1NUBLhj5p9S4pu9oPjRmHWB1VshUPEfMeLt2jh?=
 =?us-ascii?Q?HkQOJG4WGybxi4F3xg3G2IE/6bmmQGhvvSJvzGqRTB2+h5HItSW66Q3zBcrf?=
 =?us-ascii?Q?n9qEJ07j2w5Wnen5cORgFWmM9l36jKJqiu/bN9J45De0dMMMzXoNHNeFavGP?=
 =?us-ascii?Q?ULJCrLJKP7c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WM8TBdpEYGuT6EZIFCfnN/Ytgu/KX3RBzaqQtNAcKkxGeLH2tXE8a42ZAETE?=
 =?us-ascii?Q?R0KufPu7cvR4Z2vccQlEvyyc/RUH0YYdVgSMDm23GazP7uFVHw9IrsUf7t9b?=
 =?us-ascii?Q?lOX2Ty81+pTUNqKbX2sn+mX4FGNFH0TsY44whJLFjVnRBox2/Ty03HtobfJc?=
 =?us-ascii?Q?sh7bRYiNcnu4IwHtDehCAgutEXYS/NuNpZGTem92aFtev1/72rpw2NZMZPVK?=
 =?us-ascii?Q?mZAk8UO7a4v/Fg3d685/uEhnMFAiLTi25MXqVYpOKX1HGPyahfE2+6qPjpor?=
 =?us-ascii?Q?Sj0ELVB0VRXhjHBIx5lvU8fknND0wFb4kgSNcWt4taqTDeyrgTMBBVrXXZ+6?=
 =?us-ascii?Q?21IVTK4MOz/e4zK3qNL1zmFwxd6Y/uXyHpJjRJJGEffg+SlVTcN8Me8LwHPR?=
 =?us-ascii?Q?d2nOusaU82seBuGNzlo9/znUBIHlulzT6p0hPtDrHSoFy9sk8hWyV7tHJU/R?=
 =?us-ascii?Q?F1MmrSRCYUq++vP7UTfVt5pifiWtuyLAHkKHr04itBrC7KRYUdLV88BySKJE?=
 =?us-ascii?Q?3ApiphoNf/XLL+ZIl4wqL7n9aPLLbDKknHaaqSksTVNGyn7aylPEBBcmF+WV?=
 =?us-ascii?Q?Q1n6ecd8HiIwP9eNnuEE+++HHoXJyflh0mTwEg6KvnNJLMGx1ZZ8LVgUXS70?=
 =?us-ascii?Q?wiqrKnaKWavqBFl2RmuWbHkPEvxkdNpM05s80X88C79qI1aQ8VdYc7spYy0w?=
 =?us-ascii?Q?J0sqB07UMqH10FiuDolJULTjmEORMeXlB4sXkDwPRVOhTL8APv41/Hl1Jxcb?=
 =?us-ascii?Q?3hFFNtp9Ck2p3XS7YjC33F+XBvoi2cgtHTQH/D0UcxK/6HoMjduYkpkVvqnp?=
 =?us-ascii?Q?p48kO86AgDBIvSLYvq0pcIFYLsiIUp8Z4mOZJv15efOuQRZyVL+dxSpgxkoj?=
 =?us-ascii?Q?osai5kh/vFdpVGyD9F+T8v1FkiHd2K2yUwBFlsOnDhAFjXMj6TdJRw4Pf6oY?=
 =?us-ascii?Q?EW6gG1BfDvM9fW6J5s9XERk0vouO9MAGDI4yYcpZzj1uxVheuILuIVKqkCwJ?=
 =?us-ascii?Q?9PNPg8g1wdhYgCtGDKLUy3D6RRn5q+lK/K015V+gB0LTM/YPIF5kFMyinG8r?=
 =?us-ascii?Q?LAgR63RzAM4278x5poDhyRTxnSaAQed8EqTSUmM6poeN8pKVArT/4iU60VmD?=
 =?us-ascii?Q?THNmxPMNu6uUmDJ//dxcnxGPYF3v0/ut6BM39qnKgJJcOoJjqVW+OfzaA1o0?=
 =?us-ascii?Q?nXa+8XP5LDZMxxca1I4DL0kwoSmOZryHjAYcZnKA7X8jNKdMouf85bA+QjqH?=
 =?us-ascii?Q?j7OdgbA4XFZFHp/vpLOb6GaDtzTYzplNfnXrxL8NXRRQpnPo7DGUaKUEVOaj?=
 =?us-ascii?Q?COPTz78OFqtCwvGFxAXGYDxTg9Vj41B3CY7IhT3/P5MmzTUdUx3NUjR63JUe?=
 =?us-ascii?Q?g4gG1mQuHBzXp0yE37co5xN+qMu9d7eJPAmQR8jxzfDJXIRiiXFim7lVEMfg?=
 =?us-ascii?Q?lmAEVb7JsbvrmbHydvpVn36LdFxL+3EL9miSQM8HIBMhp7yDbP3QlVmuygcR?=
 =?us-ascii?Q?vMhZSXoNCk+w2SvjEwagH2vj1Fy4NycAJ+VFVRsGNZuDqFYmkVLJukKO1AnN?=
 =?us-ascii?Q?HOrGaGZDV8dEJ3nc5I7VqMfotr+pP+pgXm0cZ2mXjcygow7g8NaM7W1tTq2E?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9c9ae4-f354-48f2-a7fe-08dda41a60bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 10:18:55.7715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa5Ps8C2O6Rp3XlKpLzjmh2FKTfLOyqtqAIyNMxvZ843RCDvs4wt+s9TJbxsKZsXnXPgjvJyJtT1XndRKdO2ipF4imzxGdDS5WYn6FHSYbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8225D2149
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

On Wed, Jun 04, 2025 at 10:52:24PM +0000, Wathsala Wathawana Vithanage
wrote:
> > > rte_pci_tph_st_{get, set} functions will return an error if
> > > processing any of the rte_tph_info objects fails. The API does not
> > > indicate which entry in the rte_tph_info array was executed
> > > successfully and which caused an error. Therefore, in case of an
> > > error, the caller should discard the output. If rte_pci_tph_set
> > > returns an error, it should be treated as a partial error. Hence, the
> > > steering-tag update on the device should be considered partial and
> > > inconsistent with the expected
> > outcome.
> > > This should be resolved by resetting the endpoint device before
> > > further attempts to set steering tags.
> > 
> > This seems very clunky for the user. Is there a fundamental reason why
> > we cannot report out what ones passed or failed?
> > 
> > If it's a limitation of the kernel IOCTL, how about just making one
> > ioctl for each individual op requested, one at a time. That way we will
> > know what failed to report it?
> > 
> 
> The V1 of the kernel patch had that feature, but it was frowned upon, and
> I was asked to implement the IOCTL this way. Please find it here (V1)
> https://lore.kernel.org/kvm/20250221224638.1836909-1-wathsala.vithanage@arm.com/T/#me73cf9b9c87da97d7d9461dfb97863b78ca1755b
> 
Read the thread. However, from my reading, there is nothing in there that
mandates having an interface where the user won't know the state on error.
We need some method to have userspace know what tags were applied or not on
failure. Resetting the whole device is not a good solution. Whatever API is
provided, if it is going to take multiple ops in one go it needs to either
return the number applied on failure, or if just returning success/failure,
it should rollback the successful ones to give an all-or-nothing interface.

/Bruce

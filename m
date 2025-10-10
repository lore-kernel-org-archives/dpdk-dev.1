Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F344CCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C9DA402A0;
	Fri, 10 Oct 2025 09:44:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BADD540285
 for <dev@dpdk.org>; Fri, 10 Oct 2025 09:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760082252; x=1791618252;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=y2eY3ogwhbtotHOhtytaJMOJodRPtg496qCyamFYM8w=;
 b=MD69u7jKWiyZxllNTH2oNANvQPH71M9ANlEl1rnSQXbKhN28f2dhQUix
 wgdTP2OIGpQhioXbbm26ba2MZk3a0YqNWGM+ZSEF9RmBlEId4VfPKsrsj
 BfeqeXCumbRAwGPaJeawImE0+qj4q7fQuO5K9Gv7Hkvq8b48G7kDssOM1
 UM3zI0tUgq5HCz7dBrHzJ6g8BlXALgOUyKPMncSnNbWY3PE/AGtnxg/gg
 FJxQCzqEegMAd0oJ5fo4XZe5r4l2sNitE4XzArl8zS7ZYFih+9gFjCznT
 5COIF1/vH+VO+AxjrFL3/2zgg38OrobkT+7UmYdJAFWjt+6NzRifOQTHq Q==;
X-CSE-ConnectionGUID: 8joLqBP2Q7CfyPus4unU+w==
X-CSE-MsgGUID: TR8MV59+SYya5CL5D7f6oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79743176"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="79743176"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 00:44:11 -0700
X-CSE-ConnectionGUID: 86/w8UI7TZ+AtbCx9Cal9g==
X-CSE-MsgGUID: OcwL3iSmTna8LdYBY12fqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="181349819"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 00:44:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 00:44:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 00:44:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 00:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfDTSVwiA1immjYIsGKWYIssO+aalkZjpl0eRheW+TxL2VSRMPcs48PRUBFYqg3ixcL+im7/sdUruLJN7j5DgE0MNLD4x/xSDIncKO3g7+o0iiSd2olLUZaE6q7BNH1tIzSuYLlBA5ELUIQVWTMzBjHaY6KpiG7+MPqgF8XFAHI0sGvHTOTyQghB7bNJUCk1+wTtBUp8jVkzdqFHO2OH9CxA9yhOPLFFSuBrg9NpXARBNv4uWfxx5B9OiZVzc7ZOWgKD31mOlFPh0gZoDfNJfYDUl26h/ZjEpT3DdQZBXz00ee1C5HIeu8iS6e8+wX3j4C5m0uYDTNBWepC+qeqDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9nbrr+6Ub8s6e5P/mucZ5WDXuehQzCCsgEDGn7pnR4=;
 b=kn9F/rr4ZKexA/6eBkuXpY9ZOHF50oBnEhaZRYMC+kFHii6uC9wNrP03f2meAcbmzWQ6yIP1be+25P7QzRTcxE4xSD1J4BrcBaDDUROjwWz1mM5igCChamcq1TSZ9vm42A1+F/BCltN4ztWxuBsVY4FckCf+zgrRlj5J0xF1PJgNkAFAPm5sCuO9HOw2/UrgAAYzhpqiIcW/ZFmv1WM5rNXWzUgK1hrDjpHnwdgNxq9JyWeNKnaMaGNmCp0nZRPt94kv75hois79D0DccCownR+Iv1p5fMEbGbGkNvpnemtUCFWfPRWCfuOs06BbjV+1vNKmDjsYYrmuJEIWcmKt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 07:44:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 07:44:01 +0000
Date: Fri, 10 Oct 2025 08:43:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Message-ID: <aOi5PIYXMPBrZLx2@bricha3-mobl1.ger.corp.intel.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654B7@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654B7@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0275.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 720e4596-0c8a-4540-907b-08de07d0c78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7in7KeXtR/WGzF/kGzzMLfZELAKmmTjivbs2BkHZxrKG+QFsTTz8pRmFWK?=
 =?iso-8859-1?Q?uI6Yovav9rK67nqyrU/tRFkni3kyknDA7IXEAUuBDNQbWQEb4nn0/pPsgj?=
 =?iso-8859-1?Q?KZAmFapB0NpnRoQjricVESyUZvnHZ/ODYYgHNoUQfSfjC1JCv682gwA1aE?=
 =?iso-8859-1?Q?1DQCS+jkVjKSz1wHL2/6cBfo1ggJxhCfXoDcVWLbDYpedhEIFIgOXSBV1R?=
 =?iso-8859-1?Q?g/Q8DGkmYW7ahgeeHnDT8/G03v9wfL7trEiQbUbeUKR9hSHMDM2gFSg8FZ?=
 =?iso-8859-1?Q?ShMbGnyxkRovmi7WlgNKaaseCw7qCS4LJSCUdD1d8UxMYrkBqUKc0/5qBz?=
 =?iso-8859-1?Q?RS2xF1m8SPzXwh8ZJCyrAi8p3luqk7nfGUKGphzAt475tzn+Rx91h5UfEc?=
 =?iso-8859-1?Q?RervTUraRKDGjFnJIHoS4J3QhtJWaI5pd1lwjFTKtVXtTGtyrcYpjLwYhW?=
 =?iso-8859-1?Q?HaIsmUUGiNiPMMCLzkdzkp3hFDijAoLt43s9tNcurCT0jfJA8ZGTdMVm0j?=
 =?iso-8859-1?Q?Xg+hDyppViK4Kko49PB0OPOyEy1h4fA9eDL829e77JBlVRDHoYh96MD2td?=
 =?iso-8859-1?Q?Mphe7rQU+hO7oTeXauK6Y2uaAwPbgLTM7kr+UJyRqMSFih1kkD8dIRdUZc?=
 =?iso-8859-1?Q?gfJzT6P8p38BKmm2rn1i+Qu2F7b/Zl8g2j1HezyUOYDQ5h5VskuBaqkZeT?=
 =?iso-8859-1?Q?zbuSlbjS/saONTgnoYtm9aoR4RWBFBB0l5KKO5tIYjfk+oXnKjEfUfY+OJ?=
 =?iso-8859-1?Q?Acs72ysV+hGi6P7/zH0FqYLINRKknDBpvd+ck+MUhPqOap2arDLo6Hf+5k?=
 =?iso-8859-1?Q?ryrpmgkCtlsb4oL9vkksbW2aWkYNebjyKgpwWD8EOG0Lszeesu1vNB/x5n?=
 =?iso-8859-1?Q?vxYV95DpTSga1W7GIKtIPIjQLrtOXAfXcY21JrQgvLaG4NwsfitvlPzn+t?=
 =?iso-8859-1?Q?E4OcD2B8xQ7bZhDuL+BJXlPeUqzD1yjvzFMXCHX3NkKrgWhtNHr3WhROEF?=
 =?iso-8859-1?Q?FQMuJOHX0u1nNqY5YWxjI+reeZfWtpTPtd+ool33iJ1QZyEmd07oF562Tt?=
 =?iso-8859-1?Q?8pP5ELnJSiI8jjwTZ4/mx52GalcZKygPCj5egSvnj+ZMSNw+1fLCVVJY04?=
 =?iso-8859-1?Q?CFH/NSPft2N3IyqbQbBOrC+re2hMZipk7nva83hVCIC8v3xh0fmcgDNYO6?=
 =?iso-8859-1?Q?nEwmZT681Wh5uaobzE0/iPqRLUKUOcUwqjuY64+goOqFUzjbMagje/tSra?=
 =?iso-8859-1?Q?ov1dqlchrnvxxKrrLxjZbVvUrlFGy9EKcqZGmlnkpZ3mc5KK+BY+q9o9cn?=
 =?iso-8859-1?Q?e+dHdz+X5jyWwqxRj9Fv8/bwEtT42IUYRG6LGzEFGUjksRfH473jpo4lqi?=
 =?iso-8859-1?Q?yWBg4J20JZCvMoNWSd9XnnQpOuFkbVadv4oPICpkwoKKHSHrJ4XnbVqKWy?=
 =?iso-8859-1?Q?uZqCu1xIkXgu7jK+pf9PCZ56x+mswZuxvtXf2WSs1BdPySQKZzMaf43CpI?=
 =?iso-8859-1?Q?PrfjzMoNmaCugMMWwasv0X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OVQZxBP++wejiWZJCKIRisU2WzGxZOHGpM+Ee11eaDpRienIwxnX5cNEHv?=
 =?iso-8859-1?Q?OuDIZXTcUlG59FxjMXPKgRXO5csizTZQgL6KQraKc6pNIT6m1KGmqZaUpU?=
 =?iso-8859-1?Q?QHba2eEXsowH3x4zllH4e9g/1SoHSIusQ+4H2ay2fRPFV/zieS8T3KWjpP?=
 =?iso-8859-1?Q?Q0HhCxkFTTpbktnQN5Ry7DNRWSfHo0U9oh4wxtKBIgFdwicNhxN9IraoG5?=
 =?iso-8859-1?Q?QIArWSFdOMyH4YI4wLv0YSIyz31RDdaweYu1IK2DAZ+9qkiSh+epBKj1Qj?=
 =?iso-8859-1?Q?tEWkYnZiLs4ktK3IKeisDTHYTwOXDcX4Khyeor2tO/PuHd5ujpHJbcXOIb?=
 =?iso-8859-1?Q?pXU5OuQoiCZhzCXDb3qrv1YuDSRE9ENHHwn+dthjAxJDSUAWDPUTRgr3RV?=
 =?iso-8859-1?Q?dB6tH3sPU3LHrHh5PUmS5ilu4hFOWuQHgV3eJQMf8SaIJpKJP9szp0fD9P?=
 =?iso-8859-1?Q?XGTvf6MnYUNERmfMs8wk4qa+Biwt6Ikif4aKEnkJHzf0yDsycTqcZLgGrW?=
 =?iso-8859-1?Q?Joyv78QY6nGsw7N03Pcl5P9d8yDj2dP+s4aH5RzN9D+Mo8x+vkAtYASYca?=
 =?iso-8859-1?Q?n+z03vl7HgOu1E+dBNlcAQi1CO7JY3TIc8QL0TMeAJbGSBWmjWnp7CJUbS?=
 =?iso-8859-1?Q?BYJh0rnjIISp4GReM+PqwECCJqEX4U7g7kJoMoHKKVxkGQhF2buYqpXlST?=
 =?iso-8859-1?Q?yTUS165ALaQ2yOwuu2bNQYrTtzNBRACnkBK9CeCRcIDiUBsMktJhYtDE3t?=
 =?iso-8859-1?Q?R9ek5YbYeJMfgHd9AHkmWmFCxLM5O6TMjX1j+LkzLSrhQ2vVj2IXgMY1jb?=
 =?iso-8859-1?Q?yTPEdMH2c4m8sYK1jjacYrV6Fr9pJ3H42umwQRjaac4h9aL5u55dSRYWqA?=
 =?iso-8859-1?Q?UZRDGNSkriNR0UFzLL+2h+0Zwo+rEFv1B+0bhPJ9OF8k96Kr78wzaPNrhO?=
 =?iso-8859-1?Q?brfUNARLVsNsce+gwyegWL3zze3mH+WHtk3Luw7FHNn2pbBeKmdUD8H/pz?=
 =?iso-8859-1?Q?nvpnzWQbZ94AHZ+QzTf5YqkHZqOKcQ+kbipBlmfMpY855GLl2SBoMFbjIp?=
 =?iso-8859-1?Q?PqM0c8d2dE1Zsd557x81Ifu2MZT0KVBwpJi4rj9yGfOOwkC1xW33qlCUV/?=
 =?iso-8859-1?Q?7KiBbowFYjp3tkYRSBTPaEWZ1gRsvZkM+EjjS3W0Vlq8HKKefqEPjxr6IE?=
 =?iso-8859-1?Q?y2m1ekOwHk5D1138PVetR+8EjD5TaLMkw4lNc8sXlyUHg0w5CSfOJFgHxZ?=
 =?iso-8859-1?Q?h/4oUkF4H0e1EVqOz+cfszIzU9EzwOFw9ffxCPZTpW4AwQPD9BpAhYaIHi?=
 =?iso-8859-1?Q?8ysLML9QLoTFZ7SvSr38vxkeg8KTfSwlQSuPe5rut4T3zlvHDjU8Co12U0?=
 =?iso-8859-1?Q?BvNP6lZ5HZDU49tvCotWSXuknvCM9sQMs8IlABj3bLrC1eBdCNX5EmO+Qt?=
 =?iso-8859-1?Q?aSHKbnLHDWeMrR1kgyBoPsnVLoisDArtF4YFEZ7vetCfPexq0+RpR6f8gj?=
 =?iso-8859-1?Q?YGkl8JYdzcUAC8M6aOlQnH6FmjWZXwkZK+8DHMRwvU5obOYegRxMf4HU4Q?=
 =?iso-8859-1?Q?iuaSlY0Z4o18gc+ZBCij2purVmIhqSXnG6OLur4IT2NMYELaY4KzDFl9B4?=
 =?iso-8859-1?Q?U1PvQxWe3NveV0tPi+Q79NQRSQB0U+hdGvHAHmbOqMFDo7r1hx7SXmHg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 720e4596-0c8a-4540-907b-08de07d0c78c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 07:44:01.8334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82NuELWMqmo4gTyZ7WpYw1d8b5D0uEZwze4gHgGInqNgkQAOP62GAz0i8PhF/F1tH3nreW+CYLsTRWtmNsC1/Bddbkj8FhwMeMYhfq6go+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
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

On Thu, Oct 09, 2025 at 07:35:54PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 9 October 2025 19.15
> > 
> > On Sat, Aug 23, 2025 at 06:30:02AM +0000, Morten Brørup wrote:
> > > An optimized function for resetting a bulk of newly allocated
> > > reinitialized mbufs (a.k.a. raw mbufs) was added.
> > >
> > > Compared to the normal packet mbuf reset function, it takes advantage
> > of
> > > the following two details:
> > > 1. The 'next' and 'nb_segs' fields are already reset, so resetting
> > them
> > > has been omitted.
> > > 2. When resetting the mbuf, the 'ol_flags' field must indicate
> > whether the
> > > mbuf uses an external buffer, and the 'data_off' field must not
> > exceed the
> > > data room size when resetting the data offset to include the default
> > > headroom.
> > > Unlike the normal packet mbuf reset function, which reads the mbuf
> > itself
> > > to get the information required for resetting these two fields, this
> > > function gets the information from the mempool.
> > >
> > > This makes the function write-only of the mbuf, unlike the normal
> > packet
> > > mbuf reset function, which is read-modify-write of the mbuf.
> > >
> > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > > ---
> > >  lib/mbuf/rte_mbuf.h | 74 ++++++++++++++++++++++++++++---------------
> > --
> > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> > > index 49c93ab356..6f37a2e91e 100644
> > > --- a/lib/mbuf/rte_mbuf.h
> > > +++ b/lib/mbuf/rte_mbuf.h
> > > @@ -954,6 +954,50 @@ static inline void
> > rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
> > >  					(uint16_t)m->buf_len);
> > >  }
> > >
> > > +/**
> > > + * Reset the fields of a bulk of packet mbufs to their default
> > values.
> > > + *
> > > + * The caller must ensure that the mbufs come from the specified
> > mempool,
> > > + * are direct and properly reinitialized (refcnt=1, next=NULL,
> > nb_segs=1),
> > > + * as done by rte_pktmbuf_prefree_seg().
> > > + *
> > > + * This function should be used with care, when optimization is
> > required.
> > > + * For standard needs, prefer rte_pktmbuf_reset().
> > > + *
> > > + * @param mp
> > > + *   The mempool to which the mbuf belongs.
> > > + * @param mbufs
> > > + *   Array of pointers to packet mbufs.
> > > + *   The array must not contain NULL pointers.
> > > + * @param count
> > > + *   Array size.
> > > + */
> > > +static inline void
> > > +rte_mbuf_raw_reset_bulk(struct rte_mempool *mp, struct rte_mbuf
> > **mbufs, unsigned int count)
> > > +{
> > > +	uint64_t ol_flags = (rte_pktmbuf_priv_flags(mp) &
> > RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ?
> > > +			RTE_MBUF_F_EXTERNAL : 0;
> > > +	uint16_t data_off = RTE_MIN_T(RTE_PKTMBUF_HEADROOM,
> > rte_pktmbuf_data_room_size(mp),
> > > +			uint16_t);
> > > +
> > > +	for (unsigned int idx = 0; idx < count; idx++) {
> > > +		struct rte_mbuf *m = mbufs[idx];
> > > +
> > > +		m->pkt_len = 0;
> > > +		m->tx_offload = 0;
> > > +		m->vlan_tci = 0;
> > > +		m->vlan_tci_outer = 0;
> > > +		m->port = RTE_MBUF_PORT_INVALID;
> > 
> > Have you considered doing all initialization using 64-bit stores? It's
> > generally cheaper to do a single 64-bit store than e.g. set of 16-bit
> > ones.
> 
> The code is basically copy-paste from rte_pktmbuf_reset().
> I kept it the same way for readability.
> 

I'd think using 64-bit stores should be fine for readability so long as
there is a comment on each one (maybe with compile-time checks for field
layout).

> > This also means that we could remove the restriction on having refcnt
> > and
> > nb_segs already set. As in PMDs, a single store can init data_off,
> > ref_cnt,
> > nb_segs and port.
> 
> Yes, I have given the concept a lot of thought already.
> If we didn't require mbufs residing in the mempool to have any fields initialized, specifically "next" and "nb_segs", it would improve performance for drivers freeing mbufs back to the mempool, because writing to the mbufs would no longer be required at that point; the mbufs could simply be freed back to the mempool. Instead, we would require the driver to initialize these fields - which it probably does on RX anyway, if it supports segmented packets.
> But I consider this concept a major API change, also affecting applications assuming that these fields are initialized when allocating raw mbufs from the mempool. So I haven't pursued it.
> 
Yes, agreed. Let's not change anything in those restrictions.

/Bruce

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE177CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 15:31:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE707402D1;
	Tue,  7 Oct 2025 17:31:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6E45340261
 for <dev@dpdk.org>; Tue,  7 Oct 2025 17:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759851060; x=1791387060;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=rBIXEQ+8lTllROTl8Koe62YS365I/ZkCLectxvlFvx8=;
 b=KSrHonJc9mY58EtaX3wR/CJFN5T9ESy7SEz5Hh+DiAiNLQZbKd2iJhSV
 j35kSOlFRa4bgS2PyBSdW1U/cLmznbp2jzwA/V3sFJVBWYHL+m2byyA7M
 k7VN+7pwAQW20u010UJlg62YSMCHwkRz+k/UgBUX/LH6kt2eDPAd9trOJ
 +tyMXOg6wr3iB7tLrR3gsc2M+FEtA3a7p8YtUcR080DagrQDfV6BIGZn+
 dCSRiXCyot0v8WSb9QR2h/dLpRAq0ovxvjs47wBECiDGo7qrULKeexBbM
 3kdWV28rAPeMScdPLLbrHNu2ZpS/xX4U5nCmPCUQQHufQXhpTpxfLqQ+y A==;
X-CSE-ConnectionGUID: GQ56v/ggT0iFx57Q31lhsw==
X-CSE-MsgGUID: xmmxn1vGRU+cJKO1Eia+Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72294699"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="72294699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:30:57 -0700
X-CSE-ConnectionGUID: 38BxL/WyR021C3rXJmlvwQ==
X-CSE-MsgGUID: G5+gN7CyQ5aW52KVTXdgeg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:30:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:30:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 08:30:55 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac+i5TMhPhZc5xDW4f03hZ8vnqqhffz4PhZsPARWdQU/C0jS7rJh3aP577xhvhq5n8xQqFcgPTCU++emI6KqtGwEW8XuyN537ZGCHSf0y/iaR4osJvW0vP9Rt+l7Ktg6/GL/wUCCDrehTMYKZCk6xDyYGScFF+vphXNeFAA3CmIQ4RFW3W1545Jr9EAIfBDtaJl+YclHcV1KSSUFysdkBcCJR4Qec2OJPu1mArkzQ7eoKKteMlENt8TgiEbbfAp+6vUJYZyHg2lAJGnGd9kUXQXdapBJ8FSBp5YxKCaDK0Qhb/TRhNE0vhEAvFZjG3dd7KPVuazo+IwYgqTO7cRfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+38HRMGL7rTULnNXwWUF/2LNn4xInZ58T9cnJCdhLU4=;
 b=NkxAhB0t7Dj5xVzRGRbg4rWD1B0scWYuJkGym0/cH5G/73c1X3kUOOWE+5DcZbQPTjVkAqj2147bsR+fnrMJMrG/Ieg5po2NkmYI6uJSNrnm6bfVnDdPQPJEwDeHEsbxSjq6y/5rePfrcIpQkleuuOYEYOC2x3eB+GXXvR6P/wYIsRAxPcK6HoEa4MLsxB1xlaFWlEVlUFd1X6wKDEv1wi+FJ5iQEdhlQ32oN8MEYiRJKAomiy+LBg0/ofD5CgLgmGBnxpj+5kMO+xW1NqIcTAXBTyZAb5Y4qBWc653To3LvJaRK3Kvou2DP0FJtqfBUmxo1PEw4m3YGAt2ilWrYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF2EEA5C68E.namprd11.prod.outlook.com (2603:10b6:f:fc02::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 7 Oct
 2025 15:30:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:30:47 +0000
Date: Tue, 7 Oct 2025 16:30:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v8 00/18] Simplify running with high-numbered CPUs
Message-ID: <aOUyIX8HTOiF1yUa@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65499@smartserver.smartshare.dk>
 <aOOAyQ2s9whgovnU@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOOAyQ2s9whgovnU@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF2EEA5C68E:EE_
X-MS-Office365-Filtering-Correlation-Id: 52503ba7-f927-4c5b-7ce9-08de05b67cb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?06PKz7fhzKYLmq+qUgH5pch6X7igQlv95C52NPkP6u0BgaULon141ya8dw?=
 =?iso-8859-1?Q?G/hUp6/eZ+yI/6+tzSsUFrG7+nzDWw8KTc2D1TUHnm6dbo/817gw3d3aY5?=
 =?iso-8859-1?Q?E0Af5DOcJvlbMd93ve1n0uOH4UYJ3E3fIXYHtG6WqsnQnvkq2xc1fh4u7W?=
 =?iso-8859-1?Q?SoqKe+ngpOx4rfBEjUN4hLuooFDdyYJ5JjjeTrMQWEGbb06rMRhvbI5uz1?=
 =?iso-8859-1?Q?ewp567zyqieIwSFMwGfB+NfFGmUCyMCpk5XepDwDEKL0EC9lDG9Di1h8kl?=
 =?iso-8859-1?Q?8WtnhxvDQycUDKbCjbX2p+KJ1fkzROMctxyCSHzSZOaBhqKJJ8jtT9+7lC?=
 =?iso-8859-1?Q?svBBrHgjEi7ZcHs4H45WOPkkYdkNCcMBB3vjjD0SicXY7KEf80+ZbdBLs/?=
 =?iso-8859-1?Q?eKUKuLOqfIbX3UxlVsiyLsVMu8zfAEbseQTNl0RwJLcYZCxPBmzt7hm/gF?=
 =?iso-8859-1?Q?99ETM8r3Odm7sJ6Bc6YJsWzwNwb3XnCT1Lj4M4lbJBx6q6W8k9lqqb38I6?=
 =?iso-8859-1?Q?K9RWFR+q43Gyef7dZzXQnshyn3GBz2rsjW+2jtQ5tQhpO95dByL8b7QYtY?=
 =?iso-8859-1?Q?OoKU6yS0vPH98ngWPVjQ51nBZgWraCUSFj6rc3G1DBrXw1sP4ob6SaJ1t/?=
 =?iso-8859-1?Q?wMpxg+DVjItS+xvF3fUp61aGWsYVlWGAxj6gdr0Z1Z9QymVOSGn0pYeh7U?=
 =?iso-8859-1?Q?o2YFgPxZRVniiDvyX1sQsUCv8Fe+netHYUj0SYLeh6UP0jbD2PWqHO8F9P?=
 =?iso-8859-1?Q?p2dor3Q3hxCGjbBh3iLeUz1RSGm7U3gxxd0CQHZYhvPgqW121WPy3/rnHD?=
 =?iso-8859-1?Q?nwDYlkuvexiyaiKxaAd28O2Mr/fzPjHqPhlQZS4X8E04mz9EnMjv56BwkX?=
 =?iso-8859-1?Q?Vd7pfNYJqeHoB8lZcIaN4IXltNxvysieNeOeF37Cd1w6zRXCcsz3YARc4i?=
 =?iso-8859-1?Q?9cnXitHgl9RjNgHnti/H5x7lR7N1MeFQKA3/bGjX/4x16H63vKjTUjAH57?=
 =?iso-8859-1?Q?jT9YKlF6odB49v3IGEJGqzdRpOGCMf7zu5rw4oViVYVZ9+gW/jpxDtahha?=
 =?iso-8859-1?Q?E65ahYX1N0dYEI3n9jrICIkzYKhQDs2etKmuN9Non3cRSoyLoiKlRRSCXo?=
 =?iso-8859-1?Q?4glKDTzQPfNycPdUp8DD3aycKzXhp/Lm5tVvC9Pp8opi6TleiLIoixVdx4?=
 =?iso-8859-1?Q?nZbTFq5eAstZxGqH85ZGUHejAVqomn0DNRWtiSOktbYPTzhMaxaeXJgkXA?=
 =?iso-8859-1?Q?nrwpRgf/PRKXkiHdmD5MJAhrPhRMRNICyZpbQ42eTB6JO2RbKxl0D89uS4?=
 =?iso-8859-1?Q?8sXQYjXpzMMxu2ZYY9L/ROvrg+7AVe4P8GdW8rHmAL1tCW3RSbCNpxclHC?=
 =?iso-8859-1?Q?/6Q1lLQlqZBaT3obJH32ZAxTmrSxdLK0CZgNixE6iKquWdAFxoX+RjLGHO?=
 =?iso-8859-1?Q?k87DciagQ0lJJVvsUS0B0lQ/p8bIHlhrRYBXqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2WbS9bYaVL3kHCfAtJgiUgx8URRoLPYZYsEPr+zekXdiJQgfQQ59eCkjCE?=
 =?iso-8859-1?Q?7yZpIXDcwZGjLlWsH4yax+Fz7TRoOO7HFgpGlQg5rVJ86JhMq4a7noI42j?=
 =?iso-8859-1?Q?p8kYEpkFLO3fFn7du4symO3jYzN1ij2+J375nqjOyWnio24vYko7t5fLfx?=
 =?iso-8859-1?Q?TKC0sa7vh3FarntwDGgADqxAZTQ8mBLxAFzwBDm5MA44qnHsM6hVVaU4JA?=
 =?iso-8859-1?Q?LrPhMmy/Q+QxYKtI/RDYcmQauPhEtcsRXe96vuPg81MEJGm7ddJHgG5sCL?=
 =?iso-8859-1?Q?fy+hkfByezBke6TIpgJS3lPqDfY1BeAFJAfmh4alhI+QLWc7QgoIWIl5fY?=
 =?iso-8859-1?Q?m1dNSE6nB/6vnUpJVx2HC8v6lES6az0NlkBIBKkNN5bfd1Voo3RzQxtvRC?=
 =?iso-8859-1?Q?aBQ5Dlj5gwFuqg6pqo6eRCMfGOItG90DS31xKqPnmX/5XBAOGObov9fx/M?=
 =?iso-8859-1?Q?Kbn7hXm3GQ4SnHBUXv4PiRFRsH4Oobz9vMz/fNwRcxv+FMbIynrXCMCBny?=
 =?iso-8859-1?Q?A73kGwbKJQuX0XIcJW7pMaaGtpnwI1BLmw7sEhNWlnq7PjvlYZzOYMKlbf?=
 =?iso-8859-1?Q?9vQumwCrGyi2nWfPhTqDGljWCXUFQFVF7L10F5Qo4EQzQ1vzlJV3cxnw9k?=
 =?iso-8859-1?Q?Jxf96Jp6lHSVkgkg6dr/jDWG+PfHxVEbUE+PvL6FnVutKIuYu/cmvDtor1?=
 =?iso-8859-1?Q?IdA19u/LMJtXcPjUmHINxn7jhXs3K4G4yEeVzBvPRuuSm8JxvmkTeePWnj?=
 =?iso-8859-1?Q?4QGREGx7PgiI74lXyre5/dvpuhys5ZWxfPYrZ2na3hjMEmRWVsKje/283Q?=
 =?iso-8859-1?Q?BTQrbEJ23TfiNXmPNW0o0BgeGgHqGNoWtRxsxzI0k91lQpHW4Ur1pwbG6i?=
 =?iso-8859-1?Q?TqlMy7cL82SnRTfd8AhTydaCur6p/UgK6jFqMivgv1AUyR2qoLDQLeOqsc?=
 =?iso-8859-1?Q?e3wTLx+Pe1Mg8t4Do4rA5XUW1VdFBo7gtlVeKHhmCMuDLRQzJqlbaw//c8?=
 =?iso-8859-1?Q?2y4KXQvUiIqMaZVWENxObyTXo2cmfbDvj35nrHLtjV5PEHzKaQPKRkQdzE?=
 =?iso-8859-1?Q?mZ9Cg875gsXVhvDtuSFhqTuaR2FCp/QEmstgcj9CYPfpbfm9rO8q0OAvOt?=
 =?iso-8859-1?Q?fGfySNCfmNTAxPa9dV8GJrvGO/Ou/RubwdPKdSKbTg3jjMcN7rQCnXYpek?=
 =?iso-8859-1?Q?TQ8scCVQkG/7rBY9P6t7lsGSmJXDz8ktJujBafRT9XhZUIoFT5q+xcnErf?=
 =?iso-8859-1?Q?282fLD7oXQgjRePtUtB5D2aCvvkKZiCSkRtoEVclWX8wHnb4h6muYedBC1?=
 =?iso-8859-1?Q?GPq0QzaDXid6yrRQyfE+G2ooIDu7BwVQrHtbiY13nwTERZS4Ugt5j7xudb?=
 =?iso-8859-1?Q?pt6qHBqCbypuzsrr8wyw6Q3dmmgILC2pYAKxdG/nP8vpmq8YeWXmr2osM0?=
 =?iso-8859-1?Q?75CaoiNetiPPT101izqvJGc1JPKiNdItPY5KgqUGw20wszIhbP8zET/Rmm?=
 =?iso-8859-1?Q?CDIYm5lKrMlKkUfS0zF4cK8iF25HAZo2VVnJ0hHuqKRbEIKM7rCC5UK8+M?=
 =?iso-8859-1?Q?og8k6ql9XyXfc7xHbzqZX59zOPBXeAfDXPxlBg4QN0Rw9jyXAWDdiKcgeh?=
 =?iso-8859-1?Q?P9B3xBEFumlWJkQi0BxYVgmIWavDbqoLuBrCE5elkcmifSIyvw6YRfOA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52503ba7-f927-4c5b-7ce9-08de05b67cb1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:30:47.0839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MFPlJbqhnYuAiPurILPv3pTMxmbiHSBD6EHRjjF7ID4oNkweV1mh0YjLfpej1mzplxvKkZjFsY+eAIpCcL0ZIfMyDUc+boV2xJu9LhNSxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2EEA5C68E
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

On Mon, Oct 06, 2025 at 09:41:45AM +0100, Bruce Richardson wrote:
> On Mon, Oct 06, 2025 at 09:42:20AM +0200, Morten Brørup wrote:
> > Bruce,
> > 
> > cpu_set_t is a fixed size array, with the size CPU_SETSIZE.
> > This is part of libc.
> > 
> > However, the kernel may be built with support for a different number of CPUs.
> > This means that e.g. sched_getaffinity() will fail with EINVAL if cpusetsize is smaller than the number of CPUs the kernel was built for.
> > For more information, refer to the description about "Dynamically sized CPU sets" here:
> > https://linux.die.net/man/3/cpu_alloc_size
> > 
> > With this series, consider ensuring that all DPDK functions taking a cpu set parameter also take a cpu set size parameter, to align with kernel APIs.
> > E.g.:
> > int sched_getaffinity(pid_t pid,
> > 	size_t cpusetsize, cpu_set_t *mask), and
> > void CPU_ZERO_S(size_t setsize, cpu_set_t *set),
> > instead of:
> > void CPU_ZERO(cpu_set_t *set).
> > 
> 
> Ok, that seems a feasible change.
> 
> > <feature creep>
> > Consider not using fixed size cpu sets (and CPU_SETSIZE) at all, but dynamically allocated cpu sets.
> > </feature creep>
> >
> 
> Will have to see what that involves. If it's fairly easy, I'll give it a
> go, but we are rather late in this release cycle, so if it's taking too
> long I'll have to give this bit a miss.
> 

Looking at these requests, while initially it seems easy, there is actually
enough work in it, that I don't think I can feasibly implement and still
have this work in this release. For example:

* the cpuset macros aren't present on windows, so we need to add to
  rte_os.h the equivalents of them.
  - do we do like for RTE_CPU_AND or RTE_CPU_FILL and produce RTE_*
    versions?
  - if so, can we then take some liberties like making the size parameter
    the bitsize rather than the bytesize parameter - which would make use
    far easier. [With current CPU_*_S macros in the code I find myself
    having to always track two values each time, bitsize for range checking
    and bytesize just to pass to the libc macros]
* the argparse library doesn't have the option to take additional
  parameters such as a cpuset size when parsing arguments - it's either a
  cpuset value or not. [I've prototyped working around that by adding a new
  API specifying the expected cpuset size]
* even if all the arg parsing in EAL is set up to handle variably sized cpu
  sets, the actual lcore_config data structure would need to be set up for
  dynamically allocated cpusets to actually handle them.

Given all that, the major blocker is actually the first one - deciding
about putting the macros/inlines for this in rte_os.h. If we are going to
make the variable sized functions available in DPDK, I'd like to have a bit
of thought and discussion about how first. As well as possibly changing
macro parameters, we could even go further and create a wrapper struct for
cpusets which actually tracks the length - thereby possibly making things
simpler to use and less error prone.

/Bruce

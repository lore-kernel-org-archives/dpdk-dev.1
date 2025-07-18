Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B696C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 14:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 494094021F;
	Fri, 18 Jul 2025 16:41:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6C3B440144
 for <dev@dpdk.org>; Fri, 18 Jul 2025 16:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752849686; x=1784385686;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TpImDG/sjWvVf27Os3qQPQbVNLcXPZE7jUkt1mN/qyw=;
 b=etXSH8vZY15zn10rOqloY0apOH9Z615eylVzSh2mEMG30zA5gwFKnc0h
 +Ih+kcYtAbwj+/Sq1AE0I9pV/OeyQvMEkR1Cz5L+hO+niqnnhZum/ZnBr
 qd1+O+pABOMxEUpjOGHLvHO2FYObO2F36V2l22I95iPLxMItVCeFUDdFl
 J2Wcv/vq8h0v7eX+Iaa1HiqqnOk8cNDpBsyx/7JFIMbtirdOfdq6LSJlN
 zIcc4ebXt7hAJbXeKBbgYbuUBNYuxXM7vWPqNXH/v7cPZj6mda/3DPmL6
 N+j9f+RKtRyilZoQErnBlUrGT0ZCoN8CRWxDksiKmN9LNH+LLlCDSCd9A w==;
X-CSE-ConnectionGUID: kAxpALkvREKoRwso1vpU6A==
X-CSE-MsgGUID: po8l449/SUeD+X5DUUgnmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54857492"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="54857492"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 07:41:19 -0700
X-CSE-ConnectionGUID: zI7IIZO8TLmHpFv/UXfUcg==
X-CSE-MsgGUID: sNSw0Z8PRWKZ7EeFkND+Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="189027439"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 07:41:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 07:41:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 07:41:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.87)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 07:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFvPe6Ces1PYTrQShxFqrfNbbuBgGIJyj+pjXDwtQ5Qa/SZlvfL0mgtIqmLv1vn76Sz4TKY0V20wK8b7eFdxk+CMZl0WXrGB0R8Z0x9EdL6wFP61F4fgV7aTf7/anHL1K14Jd0nL4vDVy+DOCDejTTyOPLi+L8o1eP19kddi9PkRGxG7T6DOGx99Xdetx80L6+9V1ZGnF+1fSjMwqeayl+3req2h1oGeYmDYWCpxnnL3q/F1BRwkM+22i8BhL+HJh6MbbSJGk7FcLWvoenRcz9HiRM+EM2JjyaeVrepn12O0g5DG3f94CouyRORsO6hELdTFxyoTywXKboDA69offA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMCXgMH3AqXp1EhXZDckGu2Nbn+DDG/pR3kB3kBzotA=;
 b=vvCiat4TCMQrSibmCZcV6tjvCaPBjg6hPMTal8VPzHI5hv84h50Cnd9OT5txjoBpBKUxqoAk8OL7ZhEbZdm8eGcbjqEmDw0hdeRpY4dJ+G8kJfjPZN5f1B+enlGgJIbJcq8Er7bEsCW4lrtH2l6pZCXVbOJu0ulO3IHt7B4KNxpKXjqWVMuiVo6QQhuUxgVOn9BaUXnWaIr9H73ukxKN327gdoBsv5CAeg5Pfx7Ko445YU6cMtBulp969PinCA5Sgo6reY8449GRqh+MQhMNS9tHa5CDby0JYttIfxQK5uJjk1QRGxML9Jug7vIthH7jV1WpwPz6iaT3OeNyuGljMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 18 Jul
 2025 14:41:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:41:10 +0000
Date: Fri, 18 Jul 2025 15:41:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: Re: [PATCH v3 0/9] rework EAL argument parsing
Message-ID: <aHpdAeswVVAvxZQc@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250718143356.1578988-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZP191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d02fb3-5f4c-4d98-886d-08ddc60922e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwTz15+cJWWvLHqokNC1BGTO7JbzKOohrxmIb/qH9cNrgyhsfxdOubdQpmQB?=
 =?us-ascii?Q?wjxzuGJWhXhe4j1zbMyPPRvL29c3rk1hZy0Sh0g50upduJeBjMt6wz6BTI/V?=
 =?us-ascii?Q?PbBVaZfhshgvKm6qckHXuIwjzN2WEdE0HZ8HOCe79qaZaBgnKnEOQ02wT0+P?=
 =?us-ascii?Q?zPcUDRoSO7KkJewJnjBc+uB8RjjsgAiJZJngvbwR0+WysJ++uOlcOHPiKa46?=
 =?us-ascii?Q?BXe2i1BNIgpsO162dnhjjWvux0jHGVlTdUPbTwF2iiZr/9yq0KWNLmFiDCcv?=
 =?us-ascii?Q?Azw24a1jtDWNdi9UqeFlGsv4DgT7AMDHdQy+VcrVlBY3URI7muURXsQN4fdK?=
 =?us-ascii?Q?LBmJOUW1C6lWkgHuMjoyCIWa+1rqam+ZO8waJ4fKuG5rN82PW59UU87Z13om?=
 =?us-ascii?Q?8n6OwyRZA6YgRgL1FO3NTleIAe9SJ/TkcVnKcVMIBtlSKCSe03+KR6uE7wWA?=
 =?us-ascii?Q?L8FGUJEAb3Ncf+1BM6H1B/qm/Fdk5xFY3dE15Jnvnnzp0IB9LcHGSp7ujtx9?=
 =?us-ascii?Q?7VGTagCg75DIIZHX+Std2ZDMHtDZIMNwqmbnLGWlfbYkk1LpKZFYJxOJmE6u?=
 =?us-ascii?Q?W9Ew0Ee6OSM+GTye7NRTzJoPoEzXrcqafSM/opCmEUjzMNYS/fYj7fZrdiNJ?=
 =?us-ascii?Q?6KQkHt+w09ZvFwwF8fvAlJcgqozYgnvmKU0uWSA3zde8khfkyn0kFBHVbWec?=
 =?us-ascii?Q?u4sL+2/yr1hL6DVfeuESaEOdJG41ZkN6QyTBvSh8wNA7doWgUgRiUfnOokPM?=
 =?us-ascii?Q?Tf0xI42PkMWw3KG7OWxCtiIcvtXhWPxDluto25nOJ6t11EqvnGBtF1+Up2ir?=
 =?us-ascii?Q?oEPG041ccWcOnkoU7OzK+LiPz8F9NyOvjse/OZMEH8E4LKqDe3Rjr3eAXaxW?=
 =?us-ascii?Q?LP2Vj937RQiYX8zpT8yN5L40guzDbgXG8Abhhu2fQFHdlTqcwRhh8+r2PCR/?=
 =?us-ascii?Q?tgy2RyBptKLW/xQdbl4bbbkyr5+Ku3ZcvGl16AiJWtblBh6Zw74oSRWeO/BO?=
 =?us-ascii?Q?lQrnIUeIpY/ibqe/f2KUTkMTAMXkdQU4AL2V6JJbkE5exRqd1sSSRg28LXJz?=
 =?us-ascii?Q?iME2BbhvChETwlI2DSba8byEgALH//0DcxuwXTtOxIiY8rpAql0zwkMT8uMI?=
 =?us-ascii?Q?+QY9akLC1wWKwwz8ZhNKGXfuV3ni5LBIr/NsfX9Boxrf5xSn6s/n39pQDOdR?=
 =?us-ascii?Q?tMHcjKtwE62csln0eqRsTUpmXhYFZ7rCPtAULS8oNT5LrQ0MrIWnBkAGeO4s?=
 =?us-ascii?Q?xnP8GJNhNbqNpl6RTFvmZuIoTfRt8CqN24vSDO8yVgyUa+3DwjQi7DfW1hKk?=
 =?us-ascii?Q?nNCUXyIUNLGZr/uGg79gZOK9hGxqeIn6Y+SGEXwfd+r/XltVv6nKjy6rBUSu?=
 =?us-ascii?Q?bCLp+JcXDEO8iLC/4/thNuqLxYKdcEz/Ubh2fjykk+Ot2GlFRJ1ADrizjUIU?=
 =?us-ascii?Q?v3jbduOZd+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TisZVyCUVNy5GGK188YHreFAvwXf2r+Ty8iHXh33Xz7XzBFnGPsvMaFxbOB?=
 =?us-ascii?Q?jtLuBiCR9vma/UCHmGP9VzcW/nigoYfpZ9jYU07/2cZC5hXj3B+xNog5UZI4?=
 =?us-ascii?Q?GgCzrqMGo6dsXgHNsFGV4G5bTE2bpjVeDeGoL+ds+IecvogR9Qsdabm1iPbo?=
 =?us-ascii?Q?t15LmRJIxgylgrxQ32EeHcyFvxpworX2umXHjboue4/nzTVMxmI1zHL27Q88?=
 =?us-ascii?Q?ebIz033+jEhBg1ibTGhMVaHUw25SIQAoLxKNsI0EA82x4nePK5lHe33ge4gN?=
 =?us-ascii?Q?uzgYtlmaU/Ngd94C9llMS6nnbjBbw7Sri19n2GJpx8U8DKrLsnCGCE5tsR4I?=
 =?us-ascii?Q?YoObuSXJLqIxaoNvKwxv5joftcVHTQnv/2E/bSsHjiUYR+1YcG0V4O6MZ1cy?=
 =?us-ascii?Q?YzSZXKzH0Pt46nJ7yLeh/K1oqlXnYiaTUs1LOl1i5DfzBHNNt0yy9SKlNsop?=
 =?us-ascii?Q?GkHqB6yqzzZQls6ckySnGc5k27tzf/FWgzSvbwYirOdwwyjAvtONJlyOBUyu?=
 =?us-ascii?Q?NbukK2neYL2vToFcJNHzzNJrlSk5SsXtH3O8HysEsimwRgagVds9F83EJ/wf?=
 =?us-ascii?Q?JEiWvKnBb+HX4qjuR9KL1mb3wkdOB7ic3rQUEJkTM++wh4dhmjryYc62vWVl?=
 =?us-ascii?Q?Uc9/unlVcgH+AzMyoZ9H7wkqG4NF2JTGL1KCspNQZB8JParvgx+abJfqPJwH?=
 =?us-ascii?Q?8vsJwo/O1SVxmtYYgVfzCmIQO7P6IBnNnEW7MD3N/gZmm3DbUnmigw1rCA0N?=
 =?us-ascii?Q?YhxbZn+2M+l8G9y2Dsh2jtv98KMzmGlhNRZpgdDRI2Jf8BHBwR/rNTh+lI1W?=
 =?us-ascii?Q?QDLCxaTrUTrVkT/DMWbE9ROECHeDXZ6o7YNxUnob2cII2u9H5poAEZ9skxGV?=
 =?us-ascii?Q?mLyBsMTzvM6+3N1zbnT0ZhEeFGrVcFIEWBmHNdj3JN2rhKv/zF/G2g2GJw5u?=
 =?us-ascii?Q?61BWOeixqL3ah0pcyQCE5r4zRzhQwEwoTTW262a39Z0KuXA/A/tHeh324237?=
 =?us-ascii?Q?/KQD/DWaC1Pv6NQ9Bu2QfXjrpboOvsemX0Dr28Q6GIpRpt3P6WzbviMrSP97?=
 =?us-ascii?Q?Oaddu4nS6XacH5oQJbJLgJxO09ZS7djb193rQn4JKput/gs15iKUGGgnVHJJ?=
 =?us-ascii?Q?z/zxPynUrGHEs1u7i/rtqN9nKOtBVxwgEbNbW7v21qUsK/VNxTuMkO0WYVsm?=
 =?us-ascii?Q?JPWvf0JVIzOpBYZSNvzcFy5edJ/DETLDIVIGXnQRyRXOPve7TkP03DKIBz9D?=
 =?us-ascii?Q?aYF31ceou0gILxh1gNBKpjLElTssGZiby4wFn6Ns+Gq21dGYtrpbqwG0Qjcm?=
 =?us-ascii?Q?gdLYzeDV2IbmhRZW3uHycvQfjr6x9XhQZ0mIRGRVLjBX1IXAQ33kxGsSZLqQ?=
 =?us-ascii?Q?egWAIkC+cotV+pztiuXforwlxlrCGi9q5Ay3Mtn6VOdVV/DE7yfcmjWsu2Pn?=
 =?us-ascii?Q?j5aHEd8uFNcUusdMlk+0yAk0DxsfTm7ztfbfoNiqMvyMOJhMMgCS1BI8YL+j?=
 =?us-ascii?Q?J/WgTrMFCXJD045jibMnTG6tZHlcva1Y2qsUVJvYXzZyMwpn18aC1avm/jJ/?=
 =?us-ascii?Q?2FSHkRnsOuiq7xbGdCJR5nIF8Pw0IlUnYWLYlyKih4oBLnNKAZBRPZX0IsPn?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d02fb3-5f4c-4d98-886d-08ddc60922e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:41:10.1906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yADRQsy1A14/ucbIJ65E+tB6kYRBsDw69hKJLYgToPrtp8PgQo7voLDmE6N8+rhjHR15B4PR+kDUG+YmruyZzJjtw45UpwsNoVZrWN54ztw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
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

On Fri, Jul 18, 2025 at 03:33:46PM +0100, Bruce Richardson wrote:
> When processing cmdline arguments in DPDK, we always do so with very
> little context. So, for example, when processing the "-l" flag, we have
> no idea whether there will be later a --proc-type=secondary flag. We
> have all sorts of post-arg-processing checks in place to try and catch
> these scenarios.
> 
> To improve this situation, this patchset tries to simplify the handling
> of argument processing, by explicitly doing an initial pass to collate
> all arguments into a structure. Thereafter, the actual arg parsing is
> done in a fixed order, meaning that e.g. when processing the
> --main-lcore flag, we have already processed the service core flags. We
> also can far quicker and easier check for conflicting options, since
> they can all be checked for NULL/non-NULL in the arg structure
> immediately after the struct has been populated.
> 
> To do the initial argument gathering, this RFC uses the existing
> argparse library in DPDK. With recent changes, and two additional
> patches at the start of this set, this library now meets our needs for
> EAL argument parsing and allows us to not need to do direct getopt
> argument processing inside EAL at all.
> 
> An additional benefit of this work, is that the argument parsing for EAL
> is much more centralised into common options. This single list with
> ifdefs makes it clear to the viewer what options are common across OS's,
> vs what are unix-only or linux-only.
> 

Apologies, forgot the diff from the RFC v2:

* Added 3 new initial patches, one for minor build-system addition, and two
  for functionality in argparse to allow the user-callback help function to
  be maintained as we move to argparse.
* Added doc updates in the first EAL patch adding the long options
* Fixed ASAN issues by adding a patch to properly clean up EAL init - both
  memory allocations and fixing the run-once flag
* Put ifdefs around the linux-only or unix-only options in EAL patch 2
* Updated args to handle numa-mem and numa-limit as equivalent socket-mem
  and socket-limit

> 
> Bruce Richardson (9):
>   build: add define for the OS environment name
>   argparse: export function to print help text for object
>   argparse: allow user-override of help printing
>   eal: add long options for each short option
>   eal: define the EAL parameters in argparse format
>   eal: gather EAL args before processing
>   eal: ensure proper cleanup on EAL init failure
>   eal: combine parameter validation checks
>   eal: simplify handling of conflicting cmdline options
> 
>  config/meson.build                        |    1 +
>  doc/guides/contributing/design.rst        |    2 +-
>  doc/guides/linux_gsg/eal_args.include.rst |   20 +-
>  doc/guides/prog_guide/argparse_lib.rst    |   16 +
>  lib/argparse/rte_argparse.c               |   46 +-
>  lib/argparse/rte_argparse.h               |   21 +-
>  lib/eal/common/eal_common_memory.c        |    3 +-
>  lib/eal/common/eal_common_options.c       | 1299 +++++++++++----------
>  lib/eal/common/eal_options.h              |  102 +-
>  lib/eal/common/eal_private.h              |   11 +
>  lib/eal/freebsd/eal.c                     |  245 +---
>  lib/eal/linux/eal.c                       |  470 +-------
>  lib/eal/linux/eal_memory.c                |    2 +-
>  lib/eal/meson.build                       |    2 +-
>  lib/eal/windows/eal.c                     |  156 +--
>  lib/meson.build                           |    1 +
>  16 files changed, 954 insertions(+), 1443 deletions(-)
> 
> --
> 2.48.1
> 

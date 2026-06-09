Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955F9CD98C9
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 16:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98DB24025E;
	Tue,  9 Jun 2026 18:17:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 43CAF400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 18:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781021840; x=1812557840;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iVPk7iNnjX7x+4KYTliMWzqMM3W9q8ouLDTI373tIoM=;
 b=jTtOGvGmsJZqaF0PEcgK3gxB4xlRsUz16Er7i0dR1JVp2sl2ww6POHOh
 thsYVKOdw9HdPQY1MeUu69BJBhaSe//E/RUSVNZIx0JtCcskSNDgm1XXp
 xCpomD8whhQzDrwgT7mbImgDr0T9BhLUda46G82dZHgGirHZjjrcCIyso
 8/BMnatqNzUXLVffWnZ4RmymeHjRhq+xX65z3tXUQWpk1BLRfQsymkPfC
 u2SdxHq/13I0dxi+MEnRvD6gIFmmQfnc6bsf8g5rjxmWamDGq2NxFcKKR
 rC1O56+ei8LPM3ZBxug7KO2/jztuwOAkHyHRgPQYJseqVHKodR8k2lb/U w==;
X-CSE-ConnectionGUID: pDZlqImkSh+6NMGiWDPHLA==
X-CSE-MsgGUID: zK1MrM++SB24aa42gve0Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92109938"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="92109938"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:17:19 -0700
X-CSE-ConnectionGUID: RMELoQT4SrmozAqwEF1P/Q==
X-CSE-MsgGUID: pRI2rA1IQbqKWW/Lt2C+QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="245058753"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:17:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:17:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 09:17:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axDQY4p5Hw0JqvL1rxzZ/nW6g/n+ZFOTO8BYldt5Jt5QFCUOr0HHH5qizOKuSZlKKHwvCAZCjSEQiAzQHFb8kwHtB+O0FvEycUTWT/N9hpr7uBhgJlKqeBZjUYIX0cKSulzg3dVK6/IWTa1xO7xl0UAv8og4cvhvSNlyV6nhn+m1mS29SCOwZp2UQWNJ4TuaP7jp3mJiGcm4cKV3lQBRw+79hW+7g6Juz2ISyOkUwDhnLLUkDH+bfSOsVPTIT4T/fB8ZpX9jzErufdocbdU8QwIVNfDxXQJ7KWxSCeUQO2uPL/5B7X7g6A7rO3go7px5lDVBXTiBbQNvQSxftNeJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDm/7VPona1z6he2qhLz58rS64O4OWJ8M3VsI+t4/kk=;
 b=GVGMRZazPz1/BlSa7AmP/oyKUd/GU0neIANhcu2OTgRXQfQX/bwthnqBzpoeq89nGwJMk+N1oNUiDZLHX33FHJ/YembsLFeQ31XAVsoQijI7W7iOMK9kWo+LI+PE7Ug5CQyNBMCklMTICcEHfIbVrgC2P513RSBX7o/GmoCTedrFEmIPe6TURlhr6B5/9h/5nmJ1uTP/I9Y59X+Jpiy2fyuRN30luXjYAsORVFy5ANLP6QykSbgHONKQ65J5lkN9I7AFsBCp/6az+qDhIwMpnU9jUlBQ+WdzEMVB9U+Rkqp6vCuG3dJtbkIq21cxxnNv7YC8DzmFYtYCJM3KYIW1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:17:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:17:16 +0000
Date: Tue, 9 Jun 2026 17:17:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>
Subject: Re: [PATCH v3 3/3] usertools/telemetry: add help support
Message-ID: <aig8h-9SJ5U7SIqw@bricha3-mobl1.ger.corp.intel.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260609161400.3661268-1-bruce.richardson@intel.com>
 <20260609161400.3661268-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609161400.3661268-4-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: 7016d67c-ad07-40e9-96ee-08dec64292a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|18002099003|3023799007|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XrZ29xwH2FjwEqrgeX2yFXMDNdKutlFpNkfm2J8z6z6T0jd1tT5Xcens2omeqLJfiDjBUETSxCURoaquUAmHYXpO7qXGl04QT/cMoyLbF5uEA8oHCaNzLZB2V7lrT0JHKSH6Sl+B5UzKZM0r1e3GkKVsWMQkn0uKapjErXq8qN9ijPUDhNEN+12nyzXIzDBwf4oOZY1FDWjLN1YkLLya58T/W/pO8AHd3K8ieE6x/JFOJ0xWABIQ6NFmRA2Sn7BkJ05yjE4R3K3Xu19iMiIM4YTfe0q7HNUL1b+cT5+0uR3DRVRyQTZceXtqoSLo+9mTB5YsXWtv7cMd2xWGRUoiMcAUXlReWX9rZZEbrkUxDMx4mlcLE37gISAnnnbotC4ANoYa0hAYe/xb9XUO/40wyZcxX1DRDFwKi0vu5CJCoqE1e302idYV5iqeGHLK08DbRgz1DjzvZAnhi9gRk3ZyiM/BKN9ikLGgLGHGSxVqYGga+Q6f1F7ksIEBL0FMIz7OZ0Zeh4fKN8TYGbCcLr8WY1s5GAHY/M3kkaaXKGxgVOC4dkizVmxT7FxhacuChN+qT08oerIxcQnBdJoxLn3uy3sN5h48FEdCQ3OtE46Yb/8tWUAcLYGck4Cbgqm4NLDNw9yZ4YNnpMomzJN7WPo8kHn0upp979Y4EClMAdBpkc97EMwoCqkJxmuU7k/dIXJU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(3023799007)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qruNWxh6/vo5sF1TWx046HxLgdt6uuPq2/AqrlAuAH2BYQORvFU2rLJMXcv?=
 =?us-ascii?Q?8xitKsW8kmsRmxYtfna9yPHbVjypTPtoleWVS59vWJFQkbid50tEg/LysNHq?=
 =?us-ascii?Q?ZFtCSwTQ0OmOq89el6Hr32XUEpEk6etURCikPiTO7A9h9sw+myy8R+KOfIfb?=
 =?us-ascii?Q?ZjCTsXUG5w4R3T9Ifs0NG7X+ha8usSE0hZ1O4ixNrpyy2VH5Pd7BCCdAaN8t?=
 =?us-ascii?Q?kr/6+FbLF1SLTQabsOExi4T3zOW5GScKzYPrbrZGBoasDJf+UDxYQyVv+w7j?=
 =?us-ascii?Q?0h5yVq3H5caamkgcet43i/4MOCWb234hg6wDsQbaLgHeub3go4gfiF+DvXje?=
 =?us-ascii?Q?877fuTW0iuTQsiDgqFWeKMKw611wW7/4BqFWPEMq8HgimLa/UWxJcUqCzoWM?=
 =?us-ascii?Q?vPOqRuw/SE0KO7BBJdeeohTIYdX+rDCC3X2lLfFIjnr3huqPFDxB2yzNo1I1?=
 =?us-ascii?Q?v3BS/CAO/aF4iEtcMGBSHfsWL5ajFo2xYwxcNTm2XwpikQcLneUAK9pAllwx?=
 =?us-ascii?Q?NIoOrEUXZR1PGWCDzYuPhcY5WFCbM7trz+XjkjfdTGYE7xz1PAhjOrxmwyzB?=
 =?us-ascii?Q?tNrLWj/G6SkdoJODNa9KzWnTUva/d0OL39AslcSUN8tkHQrbiZiVMAiuEqKP?=
 =?us-ascii?Q?r+nLdJdTXBfefvr6Aaux+oi3zFy3ITPF8NDZLWMn7FPqqczzkyxnjU/y4265?=
 =?us-ascii?Q?+npgS4UaZucICxuod3TZ7hAXXwp3Ozs2nlLyCs7qiI+QyRF0pxWJ6oUeRZxG?=
 =?us-ascii?Q?y4U253Wgcx4pn3Tk475/+TEfzIpAv8AAXnKBNy2TykaxJ2MZWU/fVydDLspY?=
 =?us-ascii?Q?flK6YKi7c/Oc2r4IOr3OEP4aHXtqDFi9m0wWraYQ2RWIcmG0lDq2s9pNy5C2?=
 =?us-ascii?Q?7AL6vudx3ZkiWjyydSTgiSz0fxSx72dAi/JqcN6HHrhP+eMiicJtBeQiVb3w?=
 =?us-ascii?Q?5f2WeiPV5QGf2xt4ofC6b6teuqZfidUId/a/FtfBLLvag13muUTNyqzFKwp9?=
 =?us-ascii?Q?S6t7irxUuFhg56iC/TK2cuWlI4OuscwF10qCYEXYg6//j55gY7iiWTWGQD9Z?=
 =?us-ascii?Q?PA4GNMS7glELs9SNMO4hComevE3e0JKZWTjesp/LrfhxJXirDOKb7G1H0DgY?=
 =?us-ascii?Q?EmpzWFArmVoeTUKWnIJs1u98NgHo0C38B4UlAvUzNHgy51G4p7RvapHpotuI?=
 =?us-ascii?Q?TG2s8XfJya1kx3AG+RxGUA2GlCggB7w3krDtiYbQC/aDAlp9pzW50ijFkJz3?=
 =?us-ascii?Q?Xi6PgH4xVAcr1HOi9G5DpAg6CS6u1yRHqYS9srKUDsNqop7ICJ/L1o79MgHm?=
 =?us-ascii?Q?Cch3/dROFEhcnD7tvPbTWzupg5voiEfau7LNuqi1h+FPlBaCY3zjLr4zvNLq?=
 =?us-ascii?Q?8LwtEPs03bEKBguZQIhS5jJwjYOrYu9a/6s53lk3BltUHiFYj5YiW9pcTROf?=
 =?us-ascii?Q?84sJ6gagMlNEn2QvAIHVBoL+oYqIy1/mCKpGd/RabkdLbRO2/KiZAq8FvdIY?=
 =?us-ascii?Q?iZJtQHdRv/mgK9pU/EsCGCJmN4maH4B4CMHX600pMBhfhTdlAKnyiYG/7Wxe?=
 =?us-ascii?Q?S1UjAuytlVQb36iiYwLgQyqgqOsiwNA4rkFEK0wfhRvX0fPfffOMz9PsBwKb?=
 =?us-ascii?Q?OonZCD/ckeP3EkvwavIyy5urX8NycrKAmpJe2qC9dKsywisgsjzGvkw/vWch?=
 =?us-ascii?Q?um5AvjoQwUZ5SNBz7GCyPwtEA/X37u2sCRbcRQCJI3tv2Kw2et7k7xwinKkj?=
 =?us-ascii?Q?9HPYcaiWV+OZHWnkbDa/qBXQUL86AC8=3D?=
X-Exchange-RoutingPolicyChecked: rBmnjddGpqy7dyoobiEZlsnOJ04326MjrHKhY1SPHWeR/sKkkaTE5UfGRJbEZJgqLV/HILCBInZtjm8VCp2s9qEeBN5LjtPC01Wvywi5feGIdINg0WWlft8woBQuEOotu33CKSPZ16bSZDosqiMOzoGH3cOYtNTJi6nan58mZ3xrzfR0ycNzIkimno+HoL27BW6ZvM8YM2IfG5xYJMohPM7yL8PeMvdAqIi5W1p/pb8nXiJy46E9Zl5m4+pODNf4sjKUY7iVIvIXUKMkYYIblql9HySrkuIeFNnkjSzA3KEeQC0EMfBIkNjkMp8g4GhFhH+/5iLNvga0kxdCDJqKpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7016d67c-ad07-40e9-96ee-08dec64292a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:17:16.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQ30n+1XMPd5Ykokg+2hVstssc1DtEdYai79PSr6FrLov7ib4QZNUqpGIGXtmcD41LmWAPV7nM5NnhxxWmo454tBqEvvxiMMSonZ6xKIl6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
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

On Tue, Jun 09, 2026 at 05:14:00PM +0100, Bruce Richardson wrote:
> While the telemetry infrastructure supported using "/help,/<cmd>" to get
> help on specific commands, with the addition of script-specific
> commands, we needed better help support to explain the use of FOREACH,
> and to allow e.g. "help /<cmd>" using space separation, which is more
> intuitive. This patch adds that help support.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2: added "help aliases" to list defined aliases
>     updated docs for expanded help command
> ---
>  doc/guides/howto/telemetry.rst | 31 ++++++++++++---
>  usertools/dpdk-telemetry.py    | 69 +++++++++++++++++++++++++++++++++-
>  2 files changed, 93 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
> index bdefbdc6a6..00cfc1a1e1 100644
> --- a/doc/guides/howto/telemetry.rst
> +++ b/doc/guides/howto/telemetry.rst
> @@ -81,12 +81,31 @@ and query information using the telemetry client python script.
>         ...
>         "tx_priority7_xon_to_xoff_packets": 0}}
>  
> -   * Get the help text for a command. This will indicate what parameters are
> -     required. Pass the command as a parameter::
> -
> -       --> /help,/ethdev/xstats
> -       {"/help": {"/ethdev/xstats": "Returns the extended stats for a port.
> -       Parameters: int port_id"}}
> +   * Get the help text for a command.
> +     This will indicate what parameters are required.
> +     Use the ``help`` keyword followed by the command or keyword of interest,
> +     for example::
> +
> +       --> help FOREACH
> +       FOREACH usage:
> +          FOREACH /<list_cmd> /<iter_cmd> .<field> [.<field> ...]
> +          FOREACH <var> /<list_cmd> /<iter_cmd_with_$var> .<field> [.<field> ...]
> +
> +       Examples:
> +          FOREACH /ethdev/list /ethdev/stats .opackets
> +          ...
> +
> +       --> help /ethdev/xstats
> +       {"/help": {"/ethdev/xstats": "Returns the extended stats for a port. Parameters: int port_id"}}
> +
> +   ..  Note::
> +         For commands starting with ``/`` that are telemetry enpoints,

Checkpatch in CI correctly points out the typo for "endpoints" here. Please
fix on apply if no v4 is otherwise necessary.

thanks,
/Bruce

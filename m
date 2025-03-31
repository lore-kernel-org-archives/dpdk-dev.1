Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B79AC3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 09:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AE5740656;
	Mon, 31 Mar 2025 11:08:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 573FC40657
 for <dev@dpdk.org>; Mon, 31 Mar 2025 11:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743412126; x=1774948126;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tQZuyHc1TTOjE/cara4kW/h9xhXP3LIZGS+ktgyrMPI=;
 b=QLHEQ5iKk/cROg8BQNUvBKsb/DvVwUlKYe0YBWV4gu+5Q7pBx8zMRntA
 mYfyy7lCkLDIf5feyJEi9nld48HRbxHzZ983prGHhCNoUcAS3B4e1CThj
 3QIMKBsc77pcjWYdR5hgW3D+ahHThlU9KFZLDNIRryYHFSPu+GcfR6S7D
 huYPKg58Yjfe3JpB1obAAJm4239Yi1nw39xDDb7aIVHXBy4qU2rsoEu0x
 0QGxCvYfkqKAF3eas8cvqy91IugZB9u9jTw1mA5eeB6D7dry2UQNE9atX
 CW/IqEQVletACLfU+ve0RGgcPw6qWUxQ9fGoVJHUC0hc08mSfSV44jR5Y A==;
X-CSE-ConnectionGUID: PIxTL5JgREi+uGsGirJaig==
X-CSE-MsgGUID: K5xxn+QvQJWGdF6lIZENXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44870261"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="44870261"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 02:08:45 -0700
X-CSE-ConnectionGUID: wH1FvI1nRxyUjNhwxBvLPA==
X-CSE-MsgGUID: NB2ztSaqRlG4gne2wf/6VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="126267048"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 02:08:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 02:08:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 02:08:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 02:08:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB0n2vSbXRP/p4M17bNLpa2iFhsxG74cAYo5+w86QnXTfPQ9pXYfZTM2OddyVa82OwJig7FYK+Ygek/mFLNknMgXBl5xmjdcXhbtmO/PbLEs726uJNzUi9fJW0HghyvmKlYkLtI3S7wVq+fpfZMi7VaeAXF//LOkf5cAmwcvWIgmY5K2us/XtNzkVYqbIVH3/kZZQ13993CJjGvpEQm5ef/jWZ14wSJVbh8nlZE3yY9QYCZJ6jFZqAz7ZzGExNZeVEuJI8Slpkjly2LLIllgmTlyXaZV6D1PSSUIMLF9pVKtOkx6C7kmh2Hl8phWqQyEof9Fa0+oVx24F3f8ojrGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/IZIi28vKPhJy0LwKh1hs7R0yLbIjZlTbZwTAqxLJc=;
 b=iPcjpebpJExr7EstuFIkquyqmoagJR0vJ2j5szkcal9mRUkfbxj7MD6TRvnaBqUpW2gogv7+LKOVmYotuRnUvuqRhhzOOD08qQXVLrnaLJAaGYfdPg4U7GDd9b13ZkLnGSRSiQvTDr+4oUGeY5mxGf1vZbT1bnOw9mJgYqOmfxJOWvThFwA+CwnXGEuVQ7IqDYQDqDyjwCzo63jo5C78BIf57ZrRIs2j4zlWuAPB0VpTQ+n1DfLFefXa2qIHiN2erRM6ZLAjHXwdrrI+tQ4FXh3VS7OaqxxvYs//sGNsfvRWxewq/1HudX+5B7+P9jcTe/VSHiOqLQWiYQSa23/r+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 31 Mar
 2025 09:08:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 09:08:28 +0000
Date: Mon, 31 Mar 2025 10:08:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Eldho Paul Mathew <eldho789@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: Migrate DPDK 18.05.1 -> DPDK 24.11.1 LTS
Message-ID: <Z-pbiOzSc3-mngxv@bricha3-mobl1.ger.corp.intel.com>
References: <CAOFFPTpNTn7=y91beCJ+hvf+q-sR5xr3OUhkEa7wgcYNT7zyXQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOFFPTpNTn7=y91beCJ+hvf+q-sR5xr3OUhkEa7wgcYNT7zyXQ@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0278.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: b823f043-c601-4a16-87dd-08dd703399fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+dPJXXdkZybFJVzT4/ypZtigP/Wi2Mz+OcuobcNXudI03yvyFhgmdeI00FtK?=
 =?us-ascii?Q?ndXoECg/XmbVAuzruZ7Q+Rm1XMHg/zEnsd26ZyuGP/EhRtSLomOT/dg6mBrz?=
 =?us-ascii?Q?xXEia64k7gchgY8fs2lrlDYI33R9twu3zc0z8uWbbmpiJsgbFEusgahbOa+0?=
 =?us-ascii?Q?goZq1adcgXX+6VnUqUHkv6R8Gx08y20iqqqN9QkmQSFLQ2Lw8vary0GcZkQC?=
 =?us-ascii?Q?tCtt7eQUfjXC70OQBoAbewkP3HH+w9L5T2T+5B1H+VKrL8HamlmpRiXHHBkJ?=
 =?us-ascii?Q?SFZkdXTres/8ouN9B3OGvclbxNoCG+G/vhe0wYhbtMGMYdoOr5KvUyIHPFGY?=
 =?us-ascii?Q?X1v9fAWGUwSGlCUHPXqHTb1dCmKPBhVH5ZnduRioJQJfB1NjCH/8WyQVbX+O?=
 =?us-ascii?Q?ArMgjtQEUoPwnog/oiqkPHrUuggO6T/6KcYQBTXYUrkfVMy8La0wrbgk05W3?=
 =?us-ascii?Q?NeZk2StheLc+sPtd5Op9+ZCNfEUDeHjTLqRMF+tn1mjRDZ2XFCCVxHXpWkHt?=
 =?us-ascii?Q?cdt5q0Zw0j/X/UQhSCZZhYZdZzKd2273JxaOF+jMNsM3+EwbJac4baJ+a0uE?=
 =?us-ascii?Q?VevtfV95A1NRZw8jqkb/fqN6NjY6GOMwNBzA1QbJlYQ10MBlvxNnccpqn1EE?=
 =?us-ascii?Q?yMbvSuJvsApKT7LgQtItBbEwAsldeObafk1YDF0e1VFBycpW7GtV25EzJJ28?=
 =?us-ascii?Q?l5D9EI8pv/6r4fqiLLhQuRZkEH+/7dfpSdWV3c0yKPJVIbcwLv/jQmEXBA0v?=
 =?us-ascii?Q?wGNp3QvvYhNSwn2uI5WVjk65IMcA5x/mUcW64vIIRI3z+h/Wo/v5g/fcQVdk?=
 =?us-ascii?Q?q35XGQeW4pd28VM/qbks95eTrNDLB8r/tZynzmCE3symqACoFRnrGCb0H06X?=
 =?us-ascii?Q?GBTw32xdCy2kMAkoMfBqN/bYQmkIUNGZhIY0aZcNGV95PMFG8mKWl6TMpH4k?=
 =?us-ascii?Q?ubjUvj8YxxMP5RJ4CfZ3loUPJDpXgo2VxHUOIRMNjOlo192j77cvtdAzagcF?=
 =?us-ascii?Q?z5GsH/ky90fbnWvNWDP0BjCyK+rPhv/bPRV5K9GRtbZ/LiYv3FNHc5sY0NXd?=
 =?us-ascii?Q?QlggkSv73i7nkvZ9XGiEmRE3QT6OgfeRPttN6f0R/kb9NT6a0MuSUl2mzRnE?=
 =?us-ascii?Q?IXwf9gijhMEHYsVkJxTqMs/0IPdBVjESSOxfb5DLZ5VnE82G0W8PULg8OYQy?=
 =?us-ascii?Q?kkGzDFmfoNtKDmGyW9KRBFnUDnZmHBefwbwLkNCLu2P3WaXJnqnuH/gRFWl6?=
 =?us-ascii?Q?gSNxbQ/BDvxDRBNaTBwOQ5daID3bwrYdog5I1PvTAf6h2cR9Bb28G5+p9l/m?=
 =?us-ascii?Q?J0RXRUjC7JVoxiJo2H5QPD2qWkQlaBVjB0q1OuQtCIHxnkfWgevzUCvdpqdb?=
 =?us-ascii?Q?9dDcXC6g0Ifi8b73UwFab2jibI/v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CuTCCuN+CBx7Lz14D0W42Hi1XRNkbFyh3cIBBusoE/Hzrq0EsZtHO5adYIvM?=
 =?us-ascii?Q?Wr+bhCO9WNduvGlWgEWFAOwcSodSf+mnLWw2icqLPoUj5+ryuiMSmyvT+Pa8?=
 =?us-ascii?Q?KNdAref25TVKjZtCtgxbd2bEAx0toTX0MQUnTK2wzbvElHjDYy4C4y8A0rfd?=
 =?us-ascii?Q?i7CovxTyrQfLH6MuDE4ltnvCRMk7fwqQJsPdLJbqY6PbNG6EdJzyZM5do+yo?=
 =?us-ascii?Q?cbiL4Ev9AR/PR6S+ApoLQGKatvDaLhSla9VoBxJKp58sHpohXqkfqJm3xh+N?=
 =?us-ascii?Q?fenHpExmhXDwo3zloh2vF5b5RCahe/g8TIYQBU7PuqvRwJirKIXyKchDiUhO?=
 =?us-ascii?Q?aP1A+FT6JHZ6NtJFw+PCor3qsAESvmKbMTA55Pi+tC4hnrL1OxOGsQ/XSU/A?=
 =?us-ascii?Q?ud4YmZ1OfZpNvUq7eeTAKSbU8RRSSVKUteabkdXmwAyLQ1bSj+FQLDt1RyI2?=
 =?us-ascii?Q?exsQPkD+N8i/l/CtRjnxuyDeB6JlciVjepk5hWz5FwEzJmwMMXMxK0qctsSU?=
 =?us-ascii?Q?i/QhZLkxztcDO4NYBE3ghIuf9L/wwkfneW72WgcujUXsexTDeMLhdyV221Bd?=
 =?us-ascii?Q?p4WoE4Mk8PSPxd2x/FexX/nT+iqUeQoR9ngYZKkPta8fuLvGd16IZMENlGZL?=
 =?us-ascii?Q?sjYza94atuxS050A2RamDbZcPAmbC/0aZr2UUX9h8UN69uf0d+ZzgvKziJoo?=
 =?us-ascii?Q?U418wEMyg2lBQa2N/d+C7dvOX+8YQpqVggvKM0smFP5WWZvWH8EMzVkOoBmC?=
 =?us-ascii?Q?ooHjkZS/PkGKRTwAftntXOAy6dmb3O9JssTeGSWX4st8F9vd9bInp7Tsu+xC?=
 =?us-ascii?Q?JNiilKAHGvNMB8cfSW58hNkuEJdsiHklWlkG9mCuCTyVXfiQdo0s5/x9QMM4?=
 =?us-ascii?Q?13LIYB26mD593puLECXSKxuaEQ5/qQjuoN02AZP6wE25R5l3EFx4xJ1kwJJQ?=
 =?us-ascii?Q?ZXZkj7B1UEwjaefYnaUQwKKtItQ1J/iW3ED1nSictwI5qF8ybOaLvVSIHtmj?=
 =?us-ascii?Q?gGiaDc/Gzg2oFlhwi/FZSSjfap/3sb1n7RI4zx3kmBtqd47yxLRg+8378q0u?=
 =?us-ascii?Q?kQp+Tg+SF4A2DbK/toCn9e/C1a3Nrl3ki1O/fLc6MBE0Bm7K8ZhxPs/APpXd?=
 =?us-ascii?Q?52DJNZJjCiD3GoI+uGuYMr4AslxR6QzZnxY7hbS1eSKA5kD4cz9Jg1U8K2PF?=
 =?us-ascii?Q?aJVaRLcohOb3yVvg7lFhvBur4OjWjC1wmI+5Wn+6Ygkwx3Pf5lm+bwtenWdn?=
 =?us-ascii?Q?XgS62y/2DbsKCSUyzYkRoDP2ohfzAhQU2Lcb3uh5XrUhXzoob+XAVEb4ZnVe?=
 =?us-ascii?Q?mCZs6G/CybuMTFzqy10i1hjUsT+V7ysjnxbXK7QKyErUnC+8Pbqk4U+bz7lZ?=
 =?us-ascii?Q?s0VETF2RsqwQhIAzyE4v4UZZ7GtwD0BQSz6r9x2Z1ClEOLRc0BgJnpKGhTeG?=
 =?us-ascii?Q?hBxQmN4mcQ3rNtqZK3jCEA7qnlREE+TGwWXCFwtLKFYP3Y8tlDCzEHSLZbh2?=
 =?us-ascii?Q?LF9XLU8KFCJM1xuoEfOxZDYHDTShha5szDoCMiMvp6fKYjTKsfHu4ImvQnH7?=
 =?us-ascii?Q?G85n1n7FuKSTvAquiIjsFqCfPxbNcbhLWTNvqgAPQ67HhhMhPnxjJ6al5oZp?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b823f043-c601-4a16-87dd-08dd703399fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 09:08:28.7538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db2tzwocdaI3EQwxEsvbq79GZ1Ri1mEhOn/M+lGvtPwhUEn+gd26wwwBzXuFoLAi3cVSmGfO9dL8qx3A2RYtJUdu+gcZeCpMOWB1UNi4GhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
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

On Fri, Mar 28, 2025 at 07:18:18PM +0530, Eldho Paul Mathew wrote:
>    Hi,
>    In the 24.11.1 build, I have specific questions
>    1) I need the DPDK output in static lib format. How can I switch off
>    the shared lib build?

Hi,

Both static and shared libraries are built, you do not need to disable
shared libraries in order to use the static libs. To get the appropriate
linker flags you can use the pkgconfig .pc files output from the DPDK
build, or installed when you do a "ninja install". For static linkage:

"pkg-config --libs --static libdpdk"

For a not-installed build, you can use the same command, just set
PKG_CONFIG_PATH to "<builddir>/meson-private" so the .pc files can be
found.

>    2) I need to build librte_kni. a - Is this module deprecated in DPDK
>    24.11.1

yes. Recommend to use an in-kernel alternative, such as TAP or
virtio-vhost.

>    3) How can I enable librte_pmd_* modules? In the driver/net folder,
>    many pmd are available, but none of them are built in the default ninja
>    build.?
>    How to enable this?

All buildable drivers are built by default. You will find them in the
<builddir>/drivers folder. NOTE: the names may have changed in some cases,
e.g. network drivers are now named with "librte_net_*" rather than
"librte_pmd_*", since all drivers in DPDK are of "pmd" type.

>    I used the build steps listed below
>    cd dpdk
>     meson build
>     ninja -C build
>    Will you please help?

/Bruce

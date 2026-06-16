Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF1CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 479AE40289;
	Tue, 16 Jun 2026 14:37:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7AAB94026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781613468; x=1813149468;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Xvop0w6GUB8LzYyi0IYcJFK+7MWkVWk8+OXh+rqxnPM=;
 b=ZRO8gz3jHEH9QGDq6I4Ta/mnIbdrqT1bajcbFS8OM8FBW6IFbx0tmsPl
 JRJp4Twwsd+EbUIDlQ1sAQlBv66A6Z9Pc1RWl0y+Vyd7uzp86uafty4NN
 BA1BjQpjhaFrkze1rRlrN/wUlnd+ASt7wHWFHTtrlKr5jnw2MGnM1sN1R
 y9CFDWyzZin9IyI5DTnu2krflpu0ISLepaZx5PNqbHscPHwQqAA1y6XNr
 IkJ9fVtS+/HTQGuWB8S7DPhDmox1xG8w3g6St1gdXhzKv5aOPPBDlQgNQ
 Nj0hqGggSjhaN2FiUPftia0yW1KKHbNgOBxZXVVI4Ji37B684TN429uDO w==;
X-CSE-ConnectionGUID: Y5wPglD5TSGJPWy6mwmYng==
X-CSE-MsgGUID: vkJzs7S4RTulcYAs2y1GRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93864629"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="93864629"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 05:37:47 -0700
X-CSE-ConnectionGUID: dcHqXfIzSmOVNhWw2OwEnw==
X-CSE-MsgGUID: lfmo+UPVSy2ezt41OMwdyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="247823860"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 05:37:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 05:37:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 05:37:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 05:37:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/NzQ7u/8+E9aO0rfdOg68N69LYxweeOkhR2TvkV9LAHwKVo+43Vy8OoRtNfzqzmaGBcuyXE1WiuT4zUyQdjmCS5Uub6y0wOuHHMch8BUROrZ7uQAih+kpx4ZrQ6Dh2JuL9ntLpPeG1yYZ3SL4AWUXOjl4ezDkWkBqCbO0DR7yRsKYUkpQITZMNcpmnKCuWdQEd5O2ao4O3qpHVqp9+WQy/Hy2didGMISRo0HFq0gQhwW3RIL2JOH19eAQx0WdZg4y33SgjxB6uYGJiFHS01alj2WxNMTbbeUXS6FfYyZv8NKGNQr+mvKaQQ8AUSZIJ2aB8JOk2I7u3SlE/tsyJpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLNK+OIn7DsYATRq4XVOK50q31qwNdhnM80aXgBmowA=;
 b=jWsKPWS/EJRnUPoTs7bNOFSs0jF0z8ogOKmtPmE04oF6aJ7wkfWK5tAa32FBNk72HIocRyQby84oWVudsr4HzoqPZApmAX87gYyd+0iPzd/SWWvJxN9SfkiBLQALQzvXWhwyZjerqUxwQcWsgVHatN9wFHJCxedeFUFJq3pouS4Fde2B70qdAmEu0oLCJ67WqeR+is3ukDEncLOnmE+JA7EozSLABtGpfeX9a25cGYHoZUtbVRY/biWB0iNJPL8q5gxKsfzTw98npvTG1I3uGRjvm+y6DykCQbMN1tdx6V0Ky0NA/HiSbydJ+4T00AZYEQBVqq8d/Yomv5UpVG1d4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:37:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 12:37:39 +0000
Date: Tue, 16 Jun 2026 13:37:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC 0/4] alternative capture mechanism
Message-ID: <ajFDjhDc5hXhE8km@bricha3-mobl1.ger.corp.intel.com>
References: <20260609210540.768074-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609210540.768074-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0291.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d91c87f-f1fb-41fc-589d-08decba40d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1rpIfWYkSX73WnbtHt9YFKJbdHZirZgQUfmgCA+/mbPdleXVh4CIgoyXsw4sjgJO9F8TrnnnAkbgabP7mkhdZ9/qhXj+Tgp+idNyWH8VFHmOUvvWvNu5eFH8nLsVBcJljrYN2y5eS/wfr1Nq6myQm3jTGzJudpxKRLEUuF/3Dcjvyz2ln2nUTYzaawoa7GGLaCHMnESfUMqg4d8bI8eObX77m8Tkv+LAnLWJOrBKqkHFmZ3OCe/0VaEVTRKNn+XAaHnRzYCwAPGjieawmoXqIFojSS/gY7RHrpyR5wIN+EwiNPY8x3WmuF1BEAuAbB1Fb3KACmFchG5Xm+F3ZZQeCJdtZ68CUbdbe8WzRNfpy3VSyIqnEIaTPtih/rAg5vIy8t7L8t0eYFqswxJhdxc2wYt3TsFtF3B13gWkSlNVH2X3lK5xi4mD2h4nCZS/99Znz9ZRc0jwW3xmmZpG0hCesszK3Y9hQxVJhbXDSjhFwFlqoXOMvHTqP/BSjmIf3ZOic/JNKflULlZDM5Ax2oXcXTaUhfdh4/nV7p+T/ekqWhZtGHoCEMmZC6zvmQjqfpfsNPS0RCHwO54Z896NxNHTPW1xbg+qy9mlFLippMM3hLsSXOVmot+pp3H0TPaovZsG7nAzwoqJV2s8uYo4a6OBoX2V5iv+DmCG9qqmXcjvCKvfX0fU9kTIIP8VvV2OeqNs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CD//bJ8IaVjsgLpacIyyj5DMsUP1PP0tpc0VaP/X2gRYlyOQbeWHaXavp4YN?=
 =?us-ascii?Q?BM8zJ8hfRG0u4RNR/978sOQvBIVUT/sVra0eWYcQfOxmoDVlYHMCz8GilElJ?=
 =?us-ascii?Q?Zwjo4pqUrvHFnPOi9dmRRgFNfLPrdvFvW50Imaj3WTuluye14ukfClYkn9kg?=
 =?us-ascii?Q?3uqc4M518FTWQEAqvi6QHba03a+67Ju2sdrbcx5ejHD/DeTkvAA9ZbXhlsOz?=
 =?us-ascii?Q?6BWqVuPHX8NDZ2f2I/nshglStXiyTqLO2llumYZiCrhZaUJ6CcQ08C3ULv0U?=
 =?us-ascii?Q?GznlNGGMDRYhLGWDvS9UI+6Fv6kEwqplMZmrkDD+P5VmG6pTLC2ri7Z4CtQK?=
 =?us-ascii?Q?kAAtEntxNuK6q7DdIpIuAR9D9+H4MCBnQvIUaQ3+0F6r5GaSiX74fcfMtAjM?=
 =?us-ascii?Q?Nh8mftV4iZIth2iuhnnJLwe/rrZ/ZvPf3j0Xnzm5DNPJvSgakSYb5QxXie9x?=
 =?us-ascii?Q?o0P/0fNh4+mKA/NuKU10eOozqSMFVxZRuahs6LJtIkj0wT3Of9EBl9wIeFYA?=
 =?us-ascii?Q?W7/HsDLiGdiPmFvhea/k6DhI9XCEA2oPSCOP0MNpS8w9yxIHj7/qPgrEfzzR?=
 =?us-ascii?Q?NlgZPht6n6hAp3pgSVjH9oJfj65OMGzWGVRziOKfL/4XKzYfT0enBhNke16B?=
 =?us-ascii?Q?T5eKonidys1B9yEcrhjzjdX4LJljUei1nd48MWwgTJPddL8V7BlqDIHFpA7K?=
 =?us-ascii?Q?ddkLYJy4dshoMjH2Otvyqgm9fm/U334RLuljCvM+ygG1bT2UTUoO3mf+j+ib?=
 =?us-ascii?Q?0QsgJYMrAidSfpK8/MiELT6blg6jfssTag+A+UL37bewhDX0Rgh54McIqQ/d?=
 =?us-ascii?Q?kVbNwC5f3gjW0kw230WvGXicPv88U3r3hO68VpGx5KnUrnvJW69eY41GdNLv?=
 =?us-ascii?Q?6lgbDHPjMcvQ5yQy8zJJQOaShmKa8T5Ql+tzoZ8ksiwoiDY2AlV4q6rBkMmh?=
 =?us-ascii?Q?HT76Ukdsd4KrTjholu+FL4Vb2sY4jF0sfYiYe5QY/gJdNCg9HzzybV7cESQ2?=
 =?us-ascii?Q?oZYpdIoWI1prD1vdVWrtXOFdxyUAJ+eP+/yESbhoEz10/ZIPOy+wT2gLpFWo?=
 =?us-ascii?Q?OJRmpB/vHxX/oE1Dr9lRBuWnUwZWCC8QJoX7sd7V0UL38dcKBmdngwMJjQ5v?=
 =?us-ascii?Q?nDBp/9FGfAqzSU7HsBXExho1mI3KvauHri2Wog+iOlS4b+b5MwObQpC0UOYf?=
 =?us-ascii?Q?dEl7/6qaf97wB/85efzdykVa+87fguqHF2gz9BeAQO/Z9fx8tImKq3LTUtb/?=
 =?us-ascii?Q?RMaExepZYzXKhKIbMUWxhfGjUQaCRghA/zEpRbZ+J8xSw0P53iePrENV2eDs?=
 =?us-ascii?Q?aKybGD4kIrojAMgkSFUrLP9G5HJiA15BUj1y/gu0Sm/LRQdKthOU2uIXfFzO?=
 =?us-ascii?Q?o7wGDwOPKn7ltxY8XngjmoKw7KaHSMbSsO9gzufPWxSQebkC//oXdfvX9Kz5?=
 =?us-ascii?Q?f+kVw1WVBC4i8rCDgXPa7ac83DNpXZcl6UeTzckKQkkdIy/Ddge8/RZ2nD7E?=
 =?us-ascii?Q?6DOtkLkkffPHJUfTlmc9VNay1MHPutKV9/YvPL3YEHNWMSCsTgEXSfLRcERh?=
 =?us-ascii?Q?yuiVpQpJVXnG46m8DpGJ5s8lJd2WM3wG6AlIDEHxU7+RNSaV3zqKkY88Qp2+?=
 =?us-ascii?Q?1Y6r9lPKAet8wgUwRg7KSqH2qEi+8qlU/LjGe3R/Mfm3ld8Yr9M7qZvTSiuu?=
 =?us-ascii?Q?ph0OEp/6g3TtI5cOMwW/wMx3d3hT931pNqW6qtXraDnzN0OUHV4U6LDzR7x0?=
 =?us-ascii?Q?OGuS4t6Rsm2CvfBgjt2gxc7Xo48hGA4=3D?=
X-Exchange-RoutingPolicyChecked: XK1DNeGLtJyKRnvkW8SQID9foKkVI0t5gp6XyFwfP41x5MZ6goPexZ7yAfOovUpM9h2hO/aP/0zB7CNop4lkzJfJHeeFNn8BVTd2tfZPTVfH0ytsogEJEPMyAS1pJcGN0e2tmfQfHmWJOZCb8cw5nSkARgIlgzEdQg2kXC4ymwOZS5/UPUCvYAB0r4TjszfI9xxtz0UeLthwqCvOlTSjT/V6L0wy3k88F0i5JecwO2F/z4etrxZ6rSOxGj1PSFE5PFWRyof22Nnbp+KdHGDwB9ArY7tnVtoJ/SA9YS8vIpfeDlQHlfFfg6yzggoDuxSOziIo3CgiMWKtMDsWGwFpWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d91c87f-f1fb-41fc-589d-08decba40d31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:37:39.1859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5TBhe0jFfLU57OmtGCxN7ZS/88v/KAkeQ+58zEEcbeqFKqUs1F4WWiu11ix3X8B86+7emUoxR6jY8plIpKonhTKCnx4h2MKywSEjHwcBac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
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

On Tue, Jun 09, 2026 at 02:02:01PM -0700, Stephen Hemminger wrote:
> This is an RFC for an alternative way to capture packets from a DPDK
> application. I did brief demo of similar mechanism at DPDK summit but
> this is more complete. Capture runs in the primary process and is driven
> entirely over telemetry; no secondary process is involved.
> 
> A client asks the application to start capturing and passes it a file
> descriptor to write to. The application writes pcapng to that descriptor.
> A Wireshark extcap script is the intended front end, but the control path
> is just telemetry and the output is just a pipe, so other front ends are
> possible.
> 
>   1/4  telemetry: let a command receive file descriptors from the client
>   2/4  capture: the library
>   3/4  test: functional test
>   4/4  app: the Wireshark extcap script and its documentation
> 
> Setup and usage are in doc/guides/tools/wireshark_extcap.rst.
> 
> Primary process only for now; secondary-process capture is possible as
> follow-on. Posting as RFC to get feedback on the approach.
> 
> The extcap script is dual licensed (BSD-3-Clause OR GPL-2.0-or-later) as
> it may be more useful in the Wireshark tree.
> 

One concern I have though - does this cause system-calls to be made in the
fast-path because we are writting to a passed in FD? For performance
reasons, would it not be better to use a memory buffer for this, thereby
avoiding syscalls? For example, rather than passing in an FD to telemetry,
we could pass in a key to be passed to shmget (going old-school!), or
name parameter for shm_open. Thereafter with the memory buffer we can use a
circular ring or similar to pass the data from app to client.

/Bruce

> Stephen Hemminger (4):
>   telemetry: allow commands to receive file descriptors
>   capture: infrastructure wireshark packet capture
>   test: add test for capture hooks
>   usertools/dpdk-wireshark-extcap.py: script for external capture
> 
>  MAINTAINERS                            |   4 +
>  app/test/meson.build                   |   1 +
>  app/test/test_capture.c                | 365 +++++++++++
>  doc/guides/rel_notes/release_26_07.rst |  12 +
>  doc/guides/tools/index.rst             |   1 +
>  doc/guides/tools/wireshark_extcap.rst  | 155 +++++
>  lib/capture/capture.c                  | 821 +++++++++++++++++++++++++
>  lib/capture/capture_impl.h             |  56 ++
>  lib/capture/filter.c                   | 108 ++++
>  lib/capture/meson.build                |  19 +
>  lib/meson.build                        |   1 +
>  lib/telemetry/rte_telemetry.h          |  66 ++
>  lib/telemetry/telemetry.c              | 115 +++-
>  usertools/dpdk-wireshark-extcap.py     | 274 +++++++++
>  14 files changed, 1986 insertions(+), 12 deletions(-)
>  create mode 100644 app/test/test_capture.c
>  create mode 100644 doc/guides/tools/wireshark_extcap.rst
>  create mode 100644 lib/capture/capture.c
>  create mode 100644 lib/capture/capture_impl.h
>  create mode 100644 lib/capture/filter.c
>  create mode 100644 lib/capture/meson.build
>  create mode 100755 usertools/dpdk-wireshark-extcap.py
> 
> -- 
> 2.53.0
> 

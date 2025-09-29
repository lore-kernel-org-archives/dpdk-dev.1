Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34650CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 08:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6969F40664;
	Mon, 29 Sep 2025 10:18:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4E0DC4028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759133888; x=1790669888;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MBe/ChZ/Ga5B25FhJCAKeKn1eE0uQQPXcUB/7ko+x/0=;
 b=OVf1ocopcvDYKvG3bBdoWiX9yC5ibNzo9qwtP7fJ3JN1LAsooTkq6xas
 ovQSF2W/ndDH/6dOa4xiPXIIc4tir7dsQCRSE9JV8MAXicpm3bP4RPQaG
 xG+GGHuNjDFtT4ZXitlQ2awKs3ASqdebIfY534z1melb5YVFBpWAAuGe2
 IyK7lqqD/pBjIJG0+Vk5+8FbRTZczRM1r5ECvkCjt4J1iue8ROjLCl8Qv
 I8TVZ4mQj/YvyXWuysXWfs0FIFkL1H4SVXhE+2N2OifxoMZDpayaA1XtG
 xhdAiqObdgs9Bnyh66ywW/06WWhzzis31E6f69406kwJWaGY2WIW1Lk83 g==;
X-CSE-ConnectionGUID: aGxXZ0qPTlSFYvbzVylSXA==
X-CSE-MsgGUID: 7qC/+1lMTVqg4EnrQUvO8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="65005007"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="65005007"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 01:18:06 -0700
X-CSE-ConnectionGUID: 92nUrm77Rx+E1J5nMMXFpQ==
X-CSE-MsgGUID: vamEjo27Q1O36dNAyOznkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="183442962"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 01:18:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 01:18:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 01:18:05 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 01:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9BHlrbU9Y+Ycf2IwYZQMBfzQ0lM7MNHZlN63zf7oDIdqFgVHPopFBzEPqKDzpHGI1a6GfIN+VOTA8wLPh/+EGsnv5qlwnQmsDKZyJojB57zPe9ubW/m77QUJ9EZ8j/jvwE+NEpRaMUgHRXdc/4er3pwAxoV1gcOWNuWXh4HGPOjt47sLsKm8QxqZ8PHV6P8k6hUhqgYh12rxOCUZ74A2iYPqEo00F9TiZsVvQ4kiagpcM+XVNVH7r/4QfOVCYQRUAIdtkFdEEFmE2E4qlQ7WHoIxlVZtaw6o+8vfJodZz7wkmh7t1cloQ75zaGUXES7BLSOtcURPhPGby+h62NMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiZ/NDIpftXRnId4oelwNFaSfpe2Lh74aAK3CUv+SCs=;
 b=Yz/OhGv+QBla/5G2aeoC82nqe5Y7RL7JvnxcBT2q+T+lL9nax2MzT7bXnCbpxUoFF6bmUNjwcmzPCClxS/lL7cPhCEpZm8l7TQKIZwZXpQHVXQDI3lggZc6VuX/1jeIOVI+YrWyzTi47yj2WWmIxACttRUziR3h7p4nPj/Z9I6uPo46kE2wqQirZe8PubbeTTzaFKVmYU98uXhfXnUSnCGfTI1obUcCdJ/1KfBuTYfT43oab0zLqqa/69rAc/joOee0ZCHCTSsbS00PfcBSesVjmFNbV9BaHuPrcoEx2eCXSAeBXy1homWxch5TAYWLvCBzXhDsGjc4zA4W5BxQgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 08:18:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 08:18:02 +0000
Date: Mon, 29 Sep 2025 09:17:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, David Hunt
 <david.hunt@intel.com>, Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH v5 9/9] power: separate public and driver headers
Message-ID: <aNpAttP3GCG5L_S8@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-10-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250926124103.750844-10-david.marchand@redhat.com>
X-ClientProxiedBy: DB9PR06CA0008.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 519831b4-b44c-4bb4-b211-08ddff30b588
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8nnrpVSNxmbNCQmCB4hnNy/3NDFqNIQP7YvMob1alH4z3V/ZL6mFt7My+yn+?=
 =?us-ascii?Q?g9AeHor1QtzElDQ5Fs2EKpv3if46HAJUrVtCkkl4rQLOLvpFzTxW+VeMtM80?=
 =?us-ascii?Q?uJFc5wy3uLHZ3qqgQeW1vzpGGJQltcZ1VRXxTQQ1YjujPqc5aM34J0mP2JRf?=
 =?us-ascii?Q?K73UdUUc0B+yNezBdS77dYW/GvnKtVZPEpZL8a7UvRQAe4CAXOvt+QIpkpjD?=
 =?us-ascii?Q?Sn1Mfig81Dpa+tHj8J8RS0LCUYjvGrs8yXOhInVnMHIjxfTDREOuL3VoRIsF?=
 =?us-ascii?Q?viUAD57Pg7XTXKNYtRDeUxJXYYroedusE/92hulJdQCBLBoJCqZpWegIen1M?=
 =?us-ascii?Q?CPA1ovK/DGOQlEwUhSXmarFfE7p8RU0p2kuajEIVnyNlvQmzgygBsytPZvKs?=
 =?us-ascii?Q?YNeLSBh5gUUi7LGXEzkvXmiHaCvHDorcqOHWMT1O6XRLoE6wD38SHCQVV+Qy?=
 =?us-ascii?Q?2J7xoNNTVnA+Jvpn7g95sqxpzWiIeL2mkQil9flxoF7E6Y6XlcrQTeeKsEiR?=
 =?us-ascii?Q?EnNMWyyGn1kwXX7MA6rPjoYr5uFPTHVp6nDgz62AOpCBHseAedwjU6gRsm4r?=
 =?us-ascii?Q?BmMXuHivUpmJhNMVHrlFZMZCZcdzB8atfuwf9/9YZGAWMieejsWiajIAQXZq?=
 =?us-ascii?Q?rrFMcrB+mp6iC12OCQksOEgHIU+BKGsdfWRxVSg7iavuFqZa29myf/U2Q5wc?=
 =?us-ascii?Q?a4OHHaPNzNOU7VehHBheZhTlh79a5QCf3DSdrVPvWDv8YRk/5C1mQtLhbuIa?=
 =?us-ascii?Q?OkCdhPxu8seZASX3/idYArjGtavHhcHz/pE3ACepP1v94dZdhDCtrmYkPLz6?=
 =?us-ascii?Q?SeAaIVRJlWeKLF49B7vXRy6V/2CFbst9NR0RK9884nnw7hjW9yoXA2/ueCpj?=
 =?us-ascii?Q?g+tjwf7ChEofFydG/lsuTgfQ+kC3wUHb2GBnxaBqW2oNmRkxrG3Bd+KSfLih?=
 =?us-ascii?Q?pW0rceDFftyxwtQQObUu21p6bbY/zq890jaZXZ4k3QSwgg99RqtZ1d2z+Lp2?=
 =?us-ascii?Q?zubR3WiX+QML3EL9Ut1Hb7Ijj6bMp6WHQ0eVTVlF/aTtjp8Zl8cd1KPkxh63?=
 =?us-ascii?Q?KwNA/JLXK6rFhGo2be9w36/EkjpZisbe0opVGzu+7hLRAJu0oZ6VLMqQEqTv?=
 =?us-ascii?Q?D615OOys35oETO585nsYJJsHUZNPkclnhfS/v8b1DlBztdvCVXHYlDgPnZkZ?=
 =?us-ascii?Q?VYpEEoWUDlMgE3JpfqKTW/n8Uz2XoxtIrcVTS567kztB0Twa0XieY3JwryTw?=
 =?us-ascii?Q?Q/0CRV+oiCe0PDQAR/7/QopBA1sB38qLLlijMjdllbcwTVhFNULkBn261U5E?=
 =?us-ascii?Q?njc40ioxmrWnBtWLnGMJBcO3KaG0sxH55eYAW1xyHemGV6aaeVH5koYFCxZN?=
 =?us-ascii?Q?+TCaQb45ejptKdRJRsE4MC5GRdLxGSu3SOek7SBrPElBh2BqbIvfHv486nlp?=
 =?us-ascii?Q?bx6V55/DtDSvWcA0Xkut2KyC+6Dm+mwu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02DhnKwA2gM9jC5FkLe12wkUvvAa2kTicMT18FvdiAP3v92Esd3NrQZ8IjAu?=
 =?us-ascii?Q?WjXgQ6pCW9MFMLc1oKMnr5b2tFUlTCQ1fj0MbCoxqR0Jr0fhyjb8te1B5K0r?=
 =?us-ascii?Q?IZvoX5KlUJK9WFjakM6Uzw+p9oZmqDyP/+73thf/Srvy3C1tuAiGWMHx3ETQ?=
 =?us-ascii?Q?P7U4v0xI43QWB0fIQAX8nS+5wrbKAokVAmWzO7EzCc8Q9WK90NpSOV/bq+Qd?=
 =?us-ascii?Q?6avlyEXVyIruceZT2rFWWfh50ohB4FbRhD3pM8jHZOx0sVDgedwwN15YWPD1?=
 =?us-ascii?Q?d2+MtDm9Yi9u/CUB4omSTKhV9ivjB1IowZ5kC6qLPQFXkaVB1RdOYJ+NEbjh?=
 =?us-ascii?Q?9CUoxdLASiA0+eTjk4rM14KKbv35tV3CEhlP53JK41gXvAPS8WT9OeI4foL0?=
 =?us-ascii?Q?f5l4hVMzpo4v3EeAiUkSJ1pUCOjJexZQvDiuSs6UCD5YkiLJ17YBF0GoU8RC?=
 =?us-ascii?Q?A4qzNe4CdSwGVunsdTtpIGohXK+Dvdaa6ODCXq/t1P3VRcNUanFVSaL50VDf?=
 =?us-ascii?Q?ny5yWgirG+YmHv8K/OTPNlbXE+ckL54SZNcqsXmybRL67poBaGu5TbH/6oS9?=
 =?us-ascii?Q?tT25eATMQkrF1TuRdUn/L9LGRi4AobAjqs/htaUnrkwzdgYniMDO5mD6E44c?=
 =?us-ascii?Q?K50VN4S4vmKjQbm5XHbl/mhUyzQDlAiUahlnsb52b3cQsnmvfkOfcZoendzT?=
 =?us-ascii?Q?XpLmLt9M3Db3Yf8gXB/iO9pyG8MoJkudSwOu41wvvFqDQX1tnb1kmBPO7Y8+?=
 =?us-ascii?Q?k0Nq4s2bNykAr5gSCZF2vx/B9yuemQoZoZwO/BUeow1QFd2+6cjPyrFfzExv?=
 =?us-ascii?Q?E63vkXnYjkA4EUaMAQbGFHJR7W1ssJhAXihdvzbTj+Jx86lJaqJG+y+gvAn4?=
 =?us-ascii?Q?vGnQGd9N88IVAGsXUAlC3GbR5efc7P9XpykCZjf98i2Jp8dtEkaWqhuzMmdr?=
 =?us-ascii?Q?nNUIb4iDsyx6jcJHnYD6SB3Y3B5jOLQlkr8jZ7JpVKee0W6V60fBCbS3TkWv?=
 =?us-ascii?Q?dOEG6c7ek/4agwsOnDIfoXm7o3pKwt94fO6JM/zIQ3st4WcKXHAOl+sOnXw0?=
 =?us-ascii?Q?RS9aVno67uSWx4fJyU8/x2ysndKxAGdiwhvj6hPxY+cyNW6nA01qxwzHC1yg?=
 =?us-ascii?Q?j3b8zn967tEqRBhk12kdMwjxT3WLv4V/11k3jwMiVkZIf1oEWJ7djEaUfZUU?=
 =?us-ascii?Q?L8mCz8JXvsZyg2BhFqUxkPTb+Qx0U8tgzKVQkKV3kwREuLhJoTK9jKJw71Yt?=
 =?us-ascii?Q?H2SelgUtlCtLfTRCmTzGB14u1LU4+0w4M82dZkM6GlYNQd/7BOmDNiWK+9wA?=
 =?us-ascii?Q?rieGCXJTCjWg1M2Qi+3V2Uck5xYo05Kzxidtdv/XelqQg4fdInfxEkN2/5aQ?=
 =?us-ascii?Q?cBHmFBw6aHe3T7fzDa2ZM53iMoPSsp+QNuIFWirMrsIs7Js23Vt/WCQ6feT2?=
 =?us-ascii?Q?RXlLQbZ4fjG3YSyMc39Av+topyXwDgSEHIe+ggwSI086ZqEXoxQ7A/xLBfXv?=
 =?us-ascii?Q?ZXoa8bf/Y1eRGsrPU1Vuup5iLmj0TSqpACmRQzkmA7pdhgt5h/yinWEslo1r?=
 =?us-ascii?Q?kJNhx3P9Q/oRzpc6cGs0/lYOevUgkqk4YAZWS7NZacmW0FKZ/p+0OgWPm448?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 519831b4-b44c-4bb4-b211-08ddff30b588
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:18:02.6927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDNTbjWY6K4fXn2w8SjrCkTDSA4ZEnJ9fLjERV9jIac9bHQYJUh6BAl1R66x+Fhm9E/DjAiufdhmFpIdMOxgTH7QATd+EUHlB1pIoP9ID+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
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

On Fri, Sep 26, 2025 at 02:41:02PM +0200, David Marchand wrote:
> power_cpufreq.h, power_common.h and power_uncore_ops.h look like driver
> only headers, but were included from public headers.
> Move them to the driver_sdk_headers list.
> 
> There is one complication though for power_cpufreq.h as it was included
> from a public header rte_power_cpufreq.h.
> Move the rte_power_core_capabilities struct definition to the public
> header, since a (stable) public symbol relies on it.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Change looks ok to me.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


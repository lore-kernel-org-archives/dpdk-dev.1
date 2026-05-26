Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90036CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 15:25:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB92A402AC;
	Tue, 26 May 2026 17:25:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6D2AB40290
 for <dev@dpdk.org>; Tue, 26 May 2026 17:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779809122; x=1811345122;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zMP2c2hNLyW+9zZt4nmK90uEHqy7ij/8lptefNz7qrk=;
 b=oIutv6b0GD6my/AnXk1jMokJIxwo96feTBm671xTru9UIIp32810H5kg
 y+RZTxbGKTkfkU/keMHcER1/DLh9HSMgp7Q3cFz5hAdRn9MNkEInkUNUa
 vrHnzXNqkIDvrfrc3b5kshwa74/HRMaV4fA2xyaijtDiJoZ+fpAjfHLu3
 xnowAtM8ADbuyPtpPovCWmYsvoioBWbFT46HEFpH4x6NhpmVKATV5SDaG
 n2R1Up+G3AczmSlP/dqSdvL6Vvnw6CY8P+BxA6GlBPJH2BZtuAtyLrvFU
 oU4afTa2acwz5m/i7Zb5MerBlnHsD6FM5kd3sMNakdZmHm+AxROC6/wZJ w==;
X-CSE-ConnectionGUID: z2CQ82jTROyC9ti6zYPfdg==
X-CSE-MsgGUID: wBCmul+PTwO0pGEcn59KJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84512353"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="84512353"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 08:25:21 -0700
X-CSE-ConnectionGUID: VKLuS1W+Sw6OzbWqRfdJEA==
X-CSE-MsgGUID: QzGpbmAPTH+ea2Ob9PTaZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="242029755"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 08:25:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 08:25:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 08:25:20 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 08:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrss3/SSo2OAwA2d7S/QPOSH8pBhNY3lcN6WRMfL+vKYxCfs0QqnEypO+Z8Uv/Bor407aR0d5upuU0hndEETzbg0Lf9vWDFZ4IeRI7dcTXm3wQVex44qlnJc1hweJb6Lpt7y4KT1brjHD/ap7A6vPmjHsQSYiwZn6ZUqlvpcixFOZDhkSklBnmzqQX1gJl/6G2AgksazzCjyfG4HpCJtjZ1JY/zXiJF7n9FNp3eez5qzv0Xk1sXX9MtTcpVNOoxw8jUSIHw3BegiTAFkRCRLEnYgKsyU+IU9K0TaLoblNeGULyN0Kz/mtTnXQCfpw4RCpwC4nq/qqeU489cqzUlrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SQpp2VriB9gDp/vWw5SEyvccld5O8T1PnhSNH9yc9o=;
 b=OHeyy+xf5t0LO3a1gHsJep1dN9ZrdpBivhGqnc0PIBeGz32X8PuMJ4HAQ+kgHA5D1CMljAL6d7V59dblFhQkqaPs5JBbdPzFNsPK+GVuh5Z2I/cUsYJFcQ7HOcB2w03QYchp2+XHAR9tKE+2Wj4294TCJio2EZtrJjxyovipxeOEkD+aO2dda9rf9pr6iKu91J/VYdyLeRGOOR4ebwM5CKGf1s9NizRTQFi/8n1vhl+mk9uDkE0a8iCSWQy2uxL/TO5ikQyQJ1eLxkEzQg5tjyJLUZ7sgQauGmqrXHB0SD9qyUkfmbmi8ND71CtKJCOKoq6q+TJxgt0kVWPLZe26tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9500.namprd11.prod.outlook.com (2603:10b6:8:258::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 15:25:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 15:25:16 +0000
Date: Tue, 26 May 2026 16:25:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 3/6] eal/memory: allocate all VA space in one go
Message-ID: <ahW7V-8GOb1t_Kjv@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <23100128428096f0179a8c64904449a95311bca6.1773417833.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23100128428096f0179a8c64904449a95311bca6.1773417833.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 24037b9f-faa3-47ae-1b33-08debb3afd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|6133799003|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: rwsoVbbrw+bYY8vmLwMbJ2UjWkvxeNx4XdlDKR/rH49qQjb+Ap2vDsIYVXxre1c0IERIzW4pyId/YjghWLfxKUdA+cxQku2X7CHK7umvPoMHFpgZolrSiqerLbRg1VwKWkg+4+y/soaGdLoRETKBLe4VkVTIVCiaPEcpusyMz1FO3tufKBvisJdTARabtSj/mG7tZae17riSEdRtnheNtasJYioPZ2jZUgZgxGh/oE5RlFI2/ya6x+XkLrSpqacOSxsC6eDPz11+HzFLZoRTPmlgTe9Y5rf4Sp8X8q99y8PyLOeNdgw7Kkla0NTPirNz1KLMOSGXGfvSq+WM77naRt9Nk0zHOlgTrw9qg0ohl8/DJMWJlf6zE2G9wltmbBvdJtnXvUlN8+iFhaE0f4U78qdAyoZylTmHWyTGDSGdDJJGUYiVYsBYA+i39hy8m8YK9v/1VXhrQVf496sMlXS5DW5VcbRiLhmo/l8TOzhnxw8bYCTvfFcOkWCfIiOOY3TXi+3dMKF6JA7ii8nAxxZav4Zv210TIx0ldhPRvAlFQUdW+YDCeil1l0g5wwDB5fSGmuN94aw/dixydrUy7raHABD2pwcdWMxb/GTW7euhXNFguzcbPp4mXu0Y7f+nbls7z5E5ptYEPWjb9tTmOIZluZKvOma6ebf5iQ6+Hycn9J66fEba+uC+CNKOqzLcrdlM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(6133799003)(56012099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QX/2l0FjrlGaeQCRquBYkep5Yt/O4ato+NTCZzwc8fzpPidi54J8Ylb4pc8V?=
 =?us-ascii?Q?WthTn9juQkkK56mvgEHumDp6X+XS3/S+GVeDNoJCRz1cFlAGqNPZR0nlJPFt?=
 =?us-ascii?Q?B/DMofk/5CzBkrbswhVy7FLbJGDYragbjNyZkaSjAYsrMCtjuoB66TFdEcdQ?=
 =?us-ascii?Q?VepTYqrakOD5CtDlfbBC3RbILahRGc8T7bfqzxWpF51atI3UoaPS09G9qUKy?=
 =?us-ascii?Q?zWLXKxobVzo/HE0FFSSov0seoXeyhxegfEFr+FOYsia+7vhBH8ZJreIurCAZ?=
 =?us-ascii?Q?3HosgmZ7U1J8vkt56TzJFe+iF5tiHWf8J+LledtKfhZ7uASZuXqEbNnE086d?=
 =?us-ascii?Q?YSii4ibafeXvhbgZfxXxyFBUEJsnwKNsseq4zlOConiPZW0vCwxc9EUEdN+u?=
 =?us-ascii?Q?JoegM0LbyZy3V90WYKi8eyE+tXZyFLP1UOSlLJAxJvIFCk1IzzCUhsDrr0wN?=
 =?us-ascii?Q?x3uH9ESXjf8ZSr+UNCaAXZL1p4cCf4sqATOzxp8JsBDloSrnsykxMPvJxKU4?=
 =?us-ascii?Q?WOMfSbQ0ZxGf+JDyOlegvajKRTLzGEqo5WG409oUEdoLhI+QqAp+yU6LiKbW?=
 =?us-ascii?Q?UcfS3T7PPsbGh2afzgICiYsAbslD3g2mj0wN5mecBkfg4ijYQfSIKA6xHVvD?=
 =?us-ascii?Q?Xf7UPv5RIfAkiXXkEobIDd15pX2Cqg9lXNzRH2vFqEuLaefHSs5KGeeTgVZo?=
 =?us-ascii?Q?xmLghhuqupbk+ii3IZLe7YPumtUOdp6x93K+GRTLd/D6fCEX2AYmQ6MvBONA?=
 =?us-ascii?Q?F1nuW/dS9KzT6k3BLNXXs4jXwLHBl21fElhjI8sgoE1V1taGE540wl3yZWGe?=
 =?us-ascii?Q?1p0oI97c4b2kZ9x/7MVVAAHFAdtGbVjFRT2yPewmwbwE87UWcKsRxKBf6qOI?=
 =?us-ascii?Q?ikJ9K3taja/rGPDTULgYikOvNRoi3l+ozD2BhZ5peLaWRtqvB9yku7SLIB6e?=
 =?us-ascii?Q?chy3tZpNu7aVVyoEb7WfyHRFwcI/UiL9wugSDTEigYIWDEb35yK06f75jTs3?=
 =?us-ascii?Q?IXOUC2lWtnlH1mO39WKpvF6whpOx5dw9qH5D6Pba5Bnk9L3487kgNM2rX/7C?=
 =?us-ascii?Q?gfv8wAi0zyIzAwHPjTmzObwcrTqtv3kqY64HAtk94Zp5Nt/lldp2CFQey+Ay?=
 =?us-ascii?Q?Xz2mnfjW60X9IwLrZwbK+wV05FNrc/Hj4UqnZJvHwHsww9X22SnlueGJFMGT?=
 =?us-ascii?Q?WpAJip8Nr6RjGah6m8LxSZvyk6xx/tfsPSqyeZMgdvmEOvYP5i1BAVML5RsD?=
 =?us-ascii?Q?595Z0RighVGR46XWEq/a0H/bAfzpEsOfdxZtsh6OfVYnLzn+N1jTp2No+EWU?=
 =?us-ascii?Q?tDsE3Sob/LzqK3zmeYjt1UmF1Dqd7/zX/TDFSuGaVDvn58uMStARtNH0raWc?=
 =?us-ascii?Q?yLbBW5CD5vCQLIqnMx1djS7J4YIt5YVsL5zG3YtP9ogfD+V4vZ+OBSieiyF3?=
 =?us-ascii?Q?jOcHpWVmapsoD/tt+yq3allygBhrCPB2g0sGg8SzuDmxH6ph/dDW3xWPLJOy?=
 =?us-ascii?Q?k5zpNSm6RwQY6Sma08ISnjYDJVllip5S0rQLbdZ3vuPksoS0QDozYAETrquY?=
 =?us-ascii?Q?IZTUxDhk6hQ0J7dnV+ChBMdmVEtm65VKYIXH8gmIS36vGa04kNarw3zMQ+6F?=
 =?us-ascii?Q?ML1jb0RGXqxm/WJopMF7xMEJ/shbcRNxt12j48JCBSYUjl27MHhZiO5x5qPX?=
 =?us-ascii?Q?71X+2+ZakGGrFpowtpl2aAz6hnMfZwhSj8nos1gGYuJN8Ss9Qa5rMdT9YqZt?=
 =?us-ascii?Q?PItlfL4HS/kAk+zE+hkNQn5vbS7+YWU=3D?=
X-Exchange-RoutingPolicyChecked: hBNBKrroOHj0yeKmdL/Jn9+tVDfDm7IhAcFj5Dk/v2Pum65CebQe5AU6oUDgVi8lpj3CwJl6SG3wfU5aWzfRpKlzxzAmQcnNKpWzUi6QyWDWdBfhRR76U6SQOjlPd9MN0IYS1PsGABxtjS2VGzjMISUVE8vVo2VSsDXwxS5brXZvoKJLUaigXjEdk+0+1r8AE/GVOKFqd9yC6GcXS75zmzWdgqU6mq/N55jRRbBfooE5YPw6IC9HnD9Hqm8dezfy/UjIkAK/XSSFcXw7Eb2kxg6AbVqSfaI/jPy5KKo4deUCn4e/NDtNntEABC7AwPu+SJP5vdte2d+HgzYyYLRYTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24037b9f-faa3-47ae-1b33-08debb3afd1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 15:25:16.4340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8znwvVJa94qqDlB0+jKHeHxNW0tASuWNJLKs4Bwc+2SN85FwC/qwblL0YpnRC6Qeo3jbkztDFLO7cczJLHlQF4lpo6k4AsIMgerEgAKFKyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9500
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

On Fri, Mar 13, 2026 at 04:06:34PM +0000, Anatoly Burakov wrote:
> Instead of allocating VA space per memseg list in dynmem mode, allocate it
> all in one go, and then assign memseg lists portions of that space. In a
> similar way, for dynmem initialization in secondary processes, also attach
> all VA space in one go. Legacy/32-bit paths are untouched.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

As with previous patch, stylistically there are a few places where lines
are split unncessarily.

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310FC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 12:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8335240269;
	Tue,  1 Jul 2025 14:44:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5F46E400D7;
 Tue,  1 Jul 2025 14:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751373855; x=1782909855;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5Yc8lmedHSxxQHsl7XpQsaN8EILiEo06g23dTyqm4iw=;
 b=Y93tjflmVkvsWRumGSeI5Mo8LqF70t7w850LZLjAEo3dad8KsqkamsD0
 Q73xAiPJtsuJFp7wKVOIQjayKacgh8Wl2UXsVy6Y93+9phuES4s+mYbSo
 AiZrZav/sK/APhcH9/M93ZJLSB9CUXcI8ItWERwH8yCZnEELSPP3C59Cq
 SiEta0ufTlJ5Awr1/3tsCJWbXxWzAn7lnKesq5no75xWcbPxG7e+5qiz6
 lu5XAIu2KQn95jN2AgqwoTVemZQrdQpxJVKyd4qrdk/XCKwNgwLKxQvmO
 WX4vlz3B98YU5tpIaph7CVj2HoQT8aenWVkGV6YDXLdjw2NtmTvKxo25Z g==;
X-CSE-ConnectionGUID: ud1+PW3WQXmUqaxJmCeR/w==
X-CSE-MsgGUID: afhQYir4TI+LNazwe+mpiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53500737"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="53500737"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 05:44:14 -0700
X-CSE-ConnectionGUID: 9BqOKrpXQE2lazBot4tR5g==
X-CSE-MsgGUID: xh/WJqBFQjGxDODRcitthQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="153534711"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 05:44:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 05:44:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 05:44:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 05:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVaeA6Y0oGi7DnS2gqyjMIxPDzNY0g9TnLu95rRUDfULEwSVqEJ+IG+WTeeuiN/tNogUWEBL0/ej3tv2TNkoeM+UVnbTw2TItdkRLFXv6CUAwLZzbOnZ+5yqWcL8QBQSJcCYictv+/AMGf694IeJVQmG09VD7R+ABDx8nCm8G7rmqSWdtsXohQXqcQZ5kRobKKtbKaEMVs67yjj2vZ05rZs9u4Bz6kZlMIvbBupzlbSEwoRVRlK6mDRb5cr8ZakB1+1mwHnNf49OidXoDexvQ4xoD5riHlFb429fPyuM5rC6WlyBi0djV1MgzImSbur8Q9d9lls36eXtzvTWpFUjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzJWdMBrZ8LblaZ68s3ImAx3lurhFlOsOcE4faQ57Ps=;
 b=i9RktNxaUGW4CCFWYB35Dd/x9fQ2mmeEF14yGrDlH8T834SSujitVZCzCjodfoktH60T3I1Yx/tif432Iq8GQ8BJNT1H7FOv9JXX4HazJ+tI36WiDPC2IF/6QFJatF3VCdUTTr0L9ZnfMZgF9jNhaXrUL+KdU0z8KaUZdSdRcAvzAdJn0us5uvRU3LpqQDsBHQ+Q0GMvbhjWy7RsCEmDz7rys4jaRLAHUnFkCkv1D+M1xO1M4EuyKSNND0/lS0PD6G9nwEw+qyB+wHPzEFADqxKCooCMAL3gHGZllL0sLamWGoH+mWSENgphESkJ8Gadcz0dmx6sBz72sGFantavAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7887.namprd11.prod.outlook.com (2603:10b6:8:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 12:43:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 12:43:40 +0000
Date: Tue, 1 Jul 2025 13:43:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>,
 Mingjin Ye <mingjinx.ye@intel.com>
Subject: Re: [PATCH] net/ice: fix inconsistency in Rx queue VLAN tag placement
Message-ID: <aGPX9jCnKADwSWB6@bricha3-mobl1.ger.corp.intel.com>
References: <20250627135201.1393662-1-bruce.richardson@intel.com>
 <c58479e7-9a2a-4b8f-b9f3-0b69600aaf0b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c58479e7-9a2a-4b8f-b9f3-0b69600aaf0b@intel.com>
X-ClientProxiedBy: DU7P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc63e97-e57f-49b7-ddab-08ddb89ce7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wVsxlPo1zq7+5cFEz/hWBXcEUsAG2wdLxvbqAaEFC+uNO5y0iuZLGQWEHz5h?=
 =?us-ascii?Q?c94o6nbXgkE8z9Ema7gZafxjFiUcjOXzZ20vD9z4FDzZYjVcIXhy53KGyXDR?=
 =?us-ascii?Q?sWYsfJMLmAlK3I5maeIlx5K/9+CYgLAsW8gBdLCtFBdMrwHKmvXhkpsvdsem?=
 =?us-ascii?Q?nartjD1E2bjGhElGRcmme/F/1UJgNJbS/D7h5KbIkwVvq4bbLvz1BM9ley7N?=
 =?us-ascii?Q?2dsTmKT/gj6kAgsnhr9gAsbfXjsaIPCC5gj5yGi6sjnnBxDKhh26Y6n40XUy?=
 =?us-ascii?Q?IAaNH8pPNfHgvECOLXonf1b3wca/JTtRRcDgRz3t+hG7oaqv31jgC0WcnVWk?=
 =?us-ascii?Q?H77+LO2Xto6meCyotVao4Bo0S/t0q3U6KBK7MntS0ssKQ4d0CLS6h9/lpypB?=
 =?us-ascii?Q?FDkRv942RH8n8aAP47z69hE8r+ryGb4/z7/m3Kk/wygylPdD9GgZWjqxA4fo?=
 =?us-ascii?Q?kbJV+u3ht8Y3b/m+BJdpxy+Pb0fFzH21k8oCc8Qx0qg4QO4qq6445Eq86Bt1?=
 =?us-ascii?Q?q7IuoO0jfITd6M65eT9vNFleSTWZSi3cueeAdR4i34SbNnmwbW/M9hLUZsVu?=
 =?us-ascii?Q?jLHdwAn7Bj63JE8TftXMmXnd16qI5u+sqhdqwPklqpP1fBxW3kt0yD+9vhoG?=
 =?us-ascii?Q?HDL12aJUIDvARbLhm3lDOI62BwWvZCdeIFQSOLF3cbXTJeMd/lrixPC5tnru?=
 =?us-ascii?Q?WDoswst9sfiFTOsNgZIRUVkOEAHHPR8Ui2JfMCWBlchWQbTqJk70RWEw92pc?=
 =?us-ascii?Q?14uKFCSGKBwaDF6OLTNX2bcq9S4hkQ+PbK38NUdu6wTnBGab13g/fq0l+Chr?=
 =?us-ascii?Q?Tnx50AzJN7nhpJ+ue2RSs8X2CdzOXjAk3zAX/zFwmLgkc0RqUINfV8myWFFT?=
 =?us-ascii?Q?++apboI9UfhgKTO6LQkzso0JbgLtHAgDTx/ZWg2xZuThGRx6Vhl6kdVttYUu?=
 =?us-ascii?Q?Od9vJBeokq9z8IQahokw8TCNuzWD3Hh+XnlyxUOzQrI7hhcRkhtde1aSV/Uc?=
 =?us-ascii?Q?V70Xuwhkdc4kYAE9IVv818Wv/cRYyNwZTM5iBiuoikjwKM6NK2KWvUm8cl9x?=
 =?us-ascii?Q?vn8ZnS6RHcu9son50ZekWbix27p9YP1UvVN02U2l9o0eE5IO+Q/C6zIQz7jY?=
 =?us-ascii?Q?EdK4+2ug5NnbMwHvcSsuL6yuQDBouQxNr9sDS6SK0FVqRtQkJYHWaVQg1CdI?=
 =?us-ascii?Q?XPauIJ5QLKqBKvCoaHl20z8lip1ZuB11HLy+p2/Woww19hWqkn3n0xRIafN6?=
 =?us-ascii?Q?nMPV793OOUBDocqim2xwcZy5BNBEP5XkHruASx61rifmzK9RZr9wzPVjCiuN?=
 =?us-ascii?Q?VBYlWuPf7Y9p0Ledgaa+o5hmEhbmoLazO2CPfVbU6Tdh5/QjRH5xtNWbtuvH?=
 =?us-ascii?Q?rEGgVuHxIP03Ob0kjnTNd7LygzXtCmliMINkK2gzMqVAayooow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cY6MWtrqGZIdMx4To/1LrMzgMcn2tyAfMY2h9rqUS4O3xvKt7jIHWhhTEkH4?=
 =?us-ascii?Q?ud7kBEh5NadqO+tizLv6eSxAHa0EZaRfP8myGlnpO9taSPXE013CF4lXoIRh?=
 =?us-ascii?Q?sy+bCLXxsR91D9Dj/Rk3EjLls+dqKBEWU0s2/ekpwf/wMnqPsOli5kDT/oy6?=
 =?us-ascii?Q?/JsTov4JIU7ykhYU0wR6W0IySbZkFFa4evKXA56QTjnLsZkM0R8FftCXw+CE?=
 =?us-ascii?Q?cvktKuyGh5xnJKH9SNTTP0ifjL+oKGvJmmhtkM+lj77dhZTZUdhNVN2u46Ff?=
 =?us-ascii?Q?kAGklO2DNRFNDKzZNLU3sK1+X/jIej+He8XIBLWgGoKEP5kqsTyyEIDz+Bs7?=
 =?us-ascii?Q?KfdIuoKnJmaMIoLdj5B41Bgx6Hnt+Ng8AsShgd+qHIriS5oXo9GyDUJK42Sd?=
 =?us-ascii?Q?60X6wTT91x+8QlRT7DXy02SORMM7ksxOmjOxWVOeb2fuCPYBETphDou4x9sy?=
 =?us-ascii?Q?Qy8L6Mo1F0n9veUMk2y2gkXB+ilzIVFlFH/l7Bcdr5rB1qJ7XWtJw/lvmpEA?=
 =?us-ascii?Q?tckkR4oCUz0i++4MC1loMVZ1Hgg7ZZrVZBAEpfiWazPxgQovK2RaSMwjqfUH?=
 =?us-ascii?Q?Tu/FbAgN+jCe6DD3lE/n+Qo369dX/EGdNSIRJSdS/t7BocyRslNaB98Xp9Ko?=
 =?us-ascii?Q?a4LK/nPbW3OcUG/pNJpPizMIpPVSzbIxaCD0o6ysK70GVmcB9V4HZ4U1lS7j?=
 =?us-ascii?Q?yDhEtf2zHV3YI5gtIfodwFb4m1aJW3iBoBmVMjVWcCZSuBHFj1TkKtRVaJPV?=
 =?us-ascii?Q?dWH7jvAMvg6PHZbm6BZs6/rt4pqcTqNoOkTJk366D0d6oJJY/BphjmBlICRi?=
 =?us-ascii?Q?SR6Tv20oo2ON07rrsU/ccterxadZ0Pc3o1RXc1UNaMRanU13BZ0pfVZGNbVF?=
 =?us-ascii?Q?THJmjszW7fsqNZOOMJNUFlRjHGG9ulBKSqe6S1OgjTKlEmyfM1tshaWcUhGE?=
 =?us-ascii?Q?pfwAXs0Aup0FAqVGrvdSZFUPTWxI/VkEr/Ivev2sMNf7kGtdwniNJ1wc0dij?=
 =?us-ascii?Q?akO2IKzvA73qPGe+OL09IslhNr/ver2py3X0AQpS9AN9zT+dID0bPNUivB9V?=
 =?us-ascii?Q?fcW457YT9PCpU7Lq8uLsv9N9BvFcAsmcIiidS66hEKWyLdFs5Xnoic87EeH+?=
 =?us-ascii?Q?6qe1FxZkQw6txCByQtVmITVby8zw8bSCm7oKDsQJzop92PiXg3wjK6HWB9L5?=
 =?us-ascii?Q?OF9h1DfsM5c5LP7gxGdmWwfB1LKGwv2R/XFpd9W4cfTjVz2WAmJO9N/FHUB9?=
 =?us-ascii?Q?msPFrQkn4NDwRXhnmdOnwXtgCTEJnSJ6mv0k7KqOe9qbzi51XYLz6+kajsZb?=
 =?us-ascii?Q?JxHrGBFigaersN8aYowa41nAYf+2zY/3ckVeQvzt2KFQE0lHW2ajvG0OQPCA?=
 =?us-ascii?Q?bie//FJqb5k7AG4/Y34vlvWzH99NdV5nrlJtxX1rZHYFdsSNnbIl4MNoNN4I?=
 =?us-ascii?Q?hCWCbg1bo3ol6Dpf9+67EdPqE2SZuvfNgSOTjYunlDiVyn0nwXGEVBew0Mbb?=
 =?us-ascii?Q?ddpYUcOZEMAUz5SVm002nXhRcwIkaAYOJ5/QdF7P+L4kPYJW9P27oBM11xhm?=
 =?us-ascii?Q?psBsnOa0Esjcl0JTdl4oRz2bJ2eu9swxvHTniglvzfg1mJKVXnAtkWeBEkDX?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc63e97-e57f-49b7-ddab-08ddb89ce7ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:43:40.4701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqx1Be6BUCMCCFOfSscRXPO05ZXyx+Fw+4JXrmMMgSuMbt5cmgah1/oYg5hxZhlh3DP8zaEJv/H70e2ruZN85607oJJWJqsBi3eyFFsCX4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7887
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

On Fri, Jun 27, 2025 at 04:31:20PM +0200, Burakov, Anatoly wrote:
> On 6/27/2025 3:52 PM, Bruce Richardson wrote:
> > When VLAN or QinQ stripping is enabled in the ice driver, an
> > inconsistency was observed between the placement of the VLAN tag in the
> > descriptors of the final Rx queue (irrespective of the number of queues)
> > vs descriptors of all other queues. This inconsistency was due to the
> > fact that the driver - when updating l2tsel (L2 tag selection) field -
> > used the queue id, rather than the register index for the queue. Queue 0
> > is normally HW queue 1, etc., meaning the final queue never had its
> > field updated.
> > 
> > Fixes: de5da9d16430 ("net/ice: support double VLAN")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>
>
Applied to dpdk-next-net-intel

/Bruce 

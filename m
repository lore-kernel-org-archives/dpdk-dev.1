Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DBFC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 17:07:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EA55402CF;
	Tue, 18 Feb 2025 18:07:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1FFCA40264
 for <dev@dpdk.org>; Tue, 18 Feb 2025 18:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739898434; x=1771434434;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dFfFMBZfIzB1SfbtomVLjojcNciGy9sht9ZX+nMOkLk=;
 b=cAwuDCr3TLrBb91Fa2KkICZF0a7KU5+M+z/H1rP7HSdOS9GUhRMS01tl
 n2FDrMBDXHciA6KUwRCyiBF0JYE+TihArT6OePLdJPYWgSgm30ntkpGgD
 XP/YnTwfB6UmahKVLykQOplirrBKQgbFPJJmP2YdCe3XHe+IAq2REr5sK
 XxmJ6nlmSu6OI3NvyyX5z4+glVrIMsqqjpjV7mvihO9rl2NYVgqgj7Czl
 YI3MEOx/xPvAXZpuxoB07ouKJP2fx/1snwA4XAFVcR0L0IcGko/Pdct41
 10iBLbVck3ES33fgNaB1PaxcaIWYxz4z8+pCGT888ylqrY5/8v7TJChP2 Q==;
X-CSE-ConnectionGUID: Al+37VnpTISBUvcItjq/KQ==
X-CSE-MsgGUID: 1+Bm6ikDTJuUJ/miqG+crQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52036155"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="52036155"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 09:07:12 -0800
X-CSE-ConnectionGUID: 81W8MAxoT6eSYiKGVkH1/w==
X-CSE-MsgGUID: h+fcoKSyQG+GOYKhdlAn+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114922003"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 09:07:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 09:07:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 09:07:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 09:07:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqm3zt8E7/xdJDr1ekDws8iJudcY9Hs9eGiKUxfharaOxxr0px2OMCqxSqKtQZqEOmGugHKQrVpQ8Z9Al81QqNPZGwNIbGLXUXckIRPWzglclIS82n5xUKQ2sspkJAYXUWhyiy9QtgEObwAhwr5+Px3pkbzoJEfuBGUjlVHV/m5JWXZPa/qiLi1wQQntUiYpsx1r1XxP3fvnx5l6NO1BhpnyHDUhCbVp6/icgWv/OOpOxTbMnTw96n1fWeQ7haYc6d1BugltQRLoRYlIiWDMGBGaWl4kzlt03vBRXEhtY/ueYLwSQmDUxW3NGzazM/iBt7ZxI5b3Bt8xHAtaCwQVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aLlvxa3bcjVrjw37vyWGYt+g46Pr8LCZsGIFX26JGo=;
 b=OGQTa9LqAYX89G4R+R6m0w0MB1Bv7me/dp7wYcg+kqS+nGgs/2l19yvWBU3YoFmgFzDj5mT1xFxejsgo2+ro8N5rAQ6VeUnCX4Zu3pGKCcyJd+S8OlvIxmTgLC1djqbb/RrI6F6yFgkRMqJYObm4ekLwZIHNQw1WonuUiJI21omPYwXjT7LJJGhLfAQg4T1NZvvLmTXmVlXc7A6RJTe9t09stX0RyJf5Nq/0LevKgK5ZfVFHSu0bV2t4Qn1Q5ycK5EfIWuFWkzPWAaoQ4SeCxF7KTi9hOZxl6qwZmRHTWvJ/o4CyCm81XK4VtTC1aqixxnagrx6FBA9nisHkJ7du+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 17:07:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:07:09 +0000
Date: Tue, 18 Feb 2025 17:07:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 03/10] test-pmd: fix printf format string mismatch
Message-ID: <Z7S-N5qDe1RYlsci@bricha3-mobl1.ger.corp.intel.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-4-git-send-email-andremue@linux.microsoft.com>
 <Z7S5gGEGpNqwoctj@bricha3-mobl1.ger.corp.intel.com>
 <20250218170300.GA6575@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218170300.GA6575@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DUZP191CA0046.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c1f1b3-11b0-4ba3-9f03-08dd503eade6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BftiG+d/wdm31ZSAv5lYcq9Q+KzScVCcGlbLVEjcgN40xus4WMNbbAhPNTZI?=
 =?us-ascii?Q?iKfm37+DVbytmrY+P52y3+hm/FFmAaAXp627d0ee+Wt1RKSd0giE6bb4WeCC?=
 =?us-ascii?Q?Mb6n7Vhc3Z8ausk1q8SsSqz4e/tp+yfc/4wrLUc4Zc4Vj52dMrJqvgDYli4m?=
 =?us-ascii?Q?S9h1OFlyjMYsmUkr3gBo42iT9XA6UQ1C56quFbIFX6bv5lcZ4hyK8nNr/Jky?=
 =?us-ascii?Q?7+aDYhfHToHrtXNUqu88sbNBrei/FsDHQghCqnFbyi9mHA3KyWR+ySJTcoOt?=
 =?us-ascii?Q?+a7xItB5hATvjIeR155Dck+sXEcG9NBc4Yv8jC4Cr/VCkwzyOO+gU+rD9drg?=
 =?us-ascii?Q?3NVlv961A4FUZJEyNAxzKMHYsDmFK1riHxVuR3siHdTy8aBANzE1LKzLENKI?=
 =?us-ascii?Q?P/9nM24qzyasYo7i1m77BTRTdT0up6EanjmcUj4uqZTJOA8Xt+GKjxXcC7dn?=
 =?us-ascii?Q?e//I0e0jlGlUN9CbQjzldTmUfsEprCQWHbaEOLd8FlXbivLmoncBe5GZYB7c?=
 =?us-ascii?Q?ABClFgvvttG01hh+55KJvhOfFB3RaV1oKF/TWX4fh5pHasFbISh7Y4boC8qH?=
 =?us-ascii?Q?xQi+UVIw01IxPelp5hwOS38SdC/3uFUE0PVN458FtWUf9oy3aYbS5Tjtkf3p?=
 =?us-ascii?Q?yd5sVMozcpcDz32gion6fMGdzA5dlHZkQwMlxJDPX4+PaIw/ImTeoM+7Dxso?=
 =?us-ascii?Q?VSLDOOKMx6yBYnqJiRzwrz4HFMOmXedBF27sAKmEUV04niH2Z97+KA1b5u0S?=
 =?us-ascii?Q?sTcOzQNZaBZkZj9aTLSRMQ/Vtk4sbBFROhj0k9SSFVCS4B8hDQS4cXSlaB6x?=
 =?us-ascii?Q?Xj3/sIix46e1HJxncxxPoyLto5YH+NWujTVgCIPnqarVKtb7hTNQ3z5903c/?=
 =?us-ascii?Q?rkChpa13XYDaJdrkfzIfCHh8UHMvvj2i1rjg0IEvNvQ5smHrNp0g2qx4UUv6?=
 =?us-ascii?Q?z6/cpwVxOf/enU06wncBPixm/SMVjkP5AZ+3w8w3Q8BTHQRtG5HFXiCxySF4?=
 =?us-ascii?Q?31s/uG7tpGWzX9DxM4SuiluY4iryT/QktGvyAhRG0BoXIUqGjGq5m9QUoJA6?=
 =?us-ascii?Q?UwxuczYwrEaHtwMJkDQ/BdeHfNgvjJmYygYbQ3KDcZ1cxIGtE6vqpnrOpFl9?=
 =?us-ascii?Q?6qSB1rHnIxnSK+I6PYkwrHmF4B5rsB1YGFvhXIh0Z8aU+d2Z/0LNQMd6CgXx?=
 =?us-ascii?Q?8exLVsTZyeNJ5Xu8g39NM5DIxBVVoPWJII2UoziiRJejXfzKC1MFnGg1Csdb?=
 =?us-ascii?Q?+XU+kvMenxA2ocyZUCEvzqLxaH/xhri7/CcBG2pxtar64jkIgb3SLHas9M5f?=
 =?us-ascii?Q?UMbA5YUqHRQB2RxTivoo3SxbhDdN+3xvFhoeiRtREKfsosTD7PvmoxGl298S?=
 =?us-ascii?Q?Ey3IM2Iim4868H4SMtqN7VkGH07E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uw3eKDvh/txoYxC7mpmGfsZleNTjhau67UvugVCvd4IxkGyHMvq/aF85pECm?=
 =?us-ascii?Q?mRCw5cE4IkNi2pWHal+j8EF+TIPWArs3DBeFZE8lEEjXL8TPIBF4PFxF49hl?=
 =?us-ascii?Q?ENe8etFBW3Um+Khtfre1dtZ9On0ZwKaELFYTFE+wlSWWxua5EmETS9/2mJVp?=
 =?us-ascii?Q?nwAjHcO/6PrGMIyyMlc8npfXoa89uMfxROj7WjFADvX8Verqno2ZsUWj4Cbs?=
 =?us-ascii?Q?VnRphMkP74J6/xlcO60148ZXyaXA0HLSxCJI4NO75lkjGUzUqlM0e+LG90RA?=
 =?us-ascii?Q?GP2QfTYMYVVu9EA0R+mVIfR7QhhhNApGqajLbXBjfVEwaQV6GGjlmjTK6KBl?=
 =?us-ascii?Q?XqDorjWlMK7XBQDRf6IMhkRYG3Ai1ACLppgInZR5uf2UOxmvZXXwkUg5Pdqx?=
 =?us-ascii?Q?jmHB7cdk3LTdm4oXPHFnUoUtNT+NkcZ6KkNyuIeZxZPaxe3N92CpbiREegiG?=
 =?us-ascii?Q?EFMXa3hnBk2s59QyiVNbOzVi33eegnT9X9wfWxLHoQAKJZc/7jed9EJTAAqJ?=
 =?us-ascii?Q?RvVv2ZomEarTP0DnDwi33998V/36BhU/R3m0Yrju5IUF8tejLqe1gPRnMZRs?=
 =?us-ascii?Q?I8SLw18G3R5CkUgYRH/ZSx+IGwze44YEjoevoWlkw6eHhfaW3cooEF/YqRw9?=
 =?us-ascii?Q?Qp54r5eM8iB457CJWL3Ga/O8x7SQ48XxigR0kguQNaz81QY29Z1QBixfgO6U?=
 =?us-ascii?Q?HLCKK5eo3+p4s/a5vxqw/Ow6Oc/KQar1wKUbqpbBBGwDe7r+ipKycA9lMkOF?=
 =?us-ascii?Q?u6X8/+B1iRlqqkAMt7dlNT97o1IgC3GeuLwNVK4zGHCvyiX+UI1NGTZWufA/?=
 =?us-ascii?Q?18C6sRkPKEvE9xQmxQYMs23x1V9eTigHWFsWZZvmGBcvNImcSfyiBRyGj3Ux?=
 =?us-ascii?Q?/nDjh0KetVnsSfCbfx1RuzyicckSIqCEShREJ43Q++0Gg3k/d2ukW0k15DB/?=
 =?us-ascii?Q?8H/E8HEEh4I42TwKdpqGGGXyWv7E1IKXOmpBGoYniyHkbBK0x9e0ECmKSMA1?=
 =?us-ascii?Q?PVSFZg1NUG7KrtudE3MkTeQXXZhH2a8+KxjH6wxCHw/Mdq3WaomZV36/ZdeQ?=
 =?us-ascii?Q?ERRDMx3oIJhpbz4LoByisFQeBwD7YlO/wPdO+2B6P5AzmrQbwW82vksW/hAa?=
 =?us-ascii?Q?KC04JiHUZMYKZ+aRAFCmRRuuufQxY0KyBRng0/ZooGS3/N8tVvINvdvvGq/e?=
 =?us-ascii?Q?pnz1qGDORKat8gJQwH5zl7eGFUmIiveeqkQ0tnQ3wbZO9kOMoINerztlMB1V?=
 =?us-ascii?Q?F+2vJzonF7pS+l2Z7kPrptKanvT4OCwjhj732H9g6aSQPBbEy0wf+CcZw/YH?=
 =?us-ascii?Q?gbPiv41nDvM1wNmCX7Ayw9701cuNffeHzJGoDKWlGCw5kq9j1zIOxaWacjJf?=
 =?us-ascii?Q?41wBE1YKKWYb1f4Lph3/1WQyW3/QDaevPZDjFTozil86wIisOps8WYR1IWQx?=
 =?us-ascii?Q?TKkEQaEJIVC0O62MjKKnP3v1NqQsCF8JvhW8CyQoVErEahgBKLOYEg+MNxPU?=
 =?us-ascii?Q?BFDkJjS5a1VBtkZowWLdO92dYY8JmHR/Cb0pTCIOsqvVVXWDV7EQz3NP2ikO?=
 =?us-ascii?Q?3ftQZ9eiFlegDrlwAc+6Lny74mcLfNhLdrEZoKSgp5lNdIcTpAgnjqR0y7PD?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c1f1b3-11b0-4ba3-9f03-08dd503eade6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:07:09.4272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p32k2YQ9dYz9W7CgJGplpabUlZLIrhjaCYFbX4Q8BGy6f7JygPAuVyqakwCpQV0vXvx0nQCHGRLSm15gQdqKkIckdXEiemS44IQWxvVYKiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
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

On Tue, Feb 18, 2025 at 09:03:01AM -0800, Andre Muezerie wrote:
> On Tue, Feb 18, 2025 at 04:46:56PM +0000, Bruce Richardson wrote:
> > On Tue, Feb 18, 2025 at 08:32:02AM -0800, Andre Muezerie wrote:
> > > Compiling with MSVC results in warnings like the one below:
> > > 
> > > app/test-pmd/csumonly.c(1085): warning C4477: 'printf' : format string
> > >     '%d' requires an argument of type 'int',
> > >     but variadic argument 1 has type 'uint64_t'
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > > ---
> > >  app/test-pmd/csumonly.c | 23 ++++++++++++-----------
> > >  1 file changed, 12 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> > > index d77a140641..8de5ad6ad9 100644
> > > --- a/app/test-pmd/csumonly.c
> > > +++ b/app/test-pmd/csumonly.c
> > > @@ -1070,7 +1070,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
> > >  				info.l2_len, rte_be_to_cpu_16(info.ethertype),
> > >  				info.l3_len, info.l4_proto, info.l4_len, buf);
> > >  			if (rx_ol_flags & RTE_MBUF_F_RX_LRO)
> > > -				printf("rx: m->lro_segsz=%u\n", m->tso_segsz);
> > > +				printf("rx: m->lro_segsz=%" PRIu64 "\n", (uint64_t)m->tso_segsz);
> > 
> > tso_segsz is already uint64_t, so no need for the cast.
> 
> The compilers differ in behavior here. tso_segsz only uses 16 bits of the uint64_t,
> and gcc tries to be smart about it and implicitly converts tso_segsz into an int
> (since it fits into an int). Msvc does not do that, and keeps the type for tso_segsz
> as uint64_t. To support both compilers it seems there's no way to avoid the cast.
> 

Ok. Then can we just keep the %u and cast to either unsigned or uint16_t?
No need to update the format char if we are casting, right?

/Bruce

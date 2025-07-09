Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2915C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 12:49:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E145440662;
	Wed,  9 Jul 2025 14:49:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F0CE440662;
 Wed,  9 Jul 2025 14:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752065388; x=1783601388;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=c8cy+d4wK1vUNwDWpWTZNoH2c28k8xipObldEnhH8Aw=;
 b=Ikj8MFsA5C/PxotLHnAu8VeZW7oq5g8AWg2XjV9rw/62cu0K9+G0W3Ij
 dEMSNuhRoROjlgSXsPDjjFyVV1EMcjsHwrE0VyJH5xVsMCYczEIdGUsYD
 pk+NdQczBuI01+IUp07u1HibtQAXTAtXRTUOEq7TRM525f92gk9CORrtd
 Xy0A5E/NTLkKbEF9KfUwgHhHee3f0VnWRL75r9alt9Gs386r+JP4TswUp
 YBmpxdOVH8laEvemSN6kMyQKRBnPiXDVYkGiR9t2pv5PhA0aYUV0Nd9p7
 jGB3MRuGLFTZEiAn/3EE4ZFFn2qBZu9e+jKBbhQ/jyNPz/k83Isrkla81 g==;
X-CSE-ConnectionGUID: If3bZhbWTvWhR7t508ENxw==
X-CSE-MsgGUID: YUpt2pzhSPmcMvYvs34Yng==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71771620"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="71771620"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 05:49:46 -0700
X-CSE-ConnectionGUID: VHXeo1F4TT+liBNCo/2HrQ==
X-CSE-MsgGUID: wT2t8DtaSH6asw8RoWqU6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="156502032"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 05:49:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 05:49:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 05:49:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 05:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYmvWQgT0GBR+CNRA1Z+CBijN89fyQUZJCjEAGOEqoOOC63rQpHECA0Qoho2g9EZ9EPc+BV+ScdeFdIHeS2k5FIJmiET426xLEkKFF68i4NIJaEgKEuLCKap4/SSlEZJTvBDJ/EUTUZnxtzBWaMMYwhn8w9DRXDeN1XcUv1RhCQ2JXiFvY8FWTtse2f61U6j52/vPMvkHUJNPk1wNDwepVneO8CpnVJFk9JUVqmBOZWtodvWQcijs03u2wRUMiR2kEcjwPIhDvziBOdaA4+kfO5T2YhrJpG9VSMYU0Tt+sqj4/uBdzmzdhh//VllvDFuZoJNA0OFjO/GQwF3VFV9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9riIJpixWQV4ySkhCNjFMvmELxra6MmuNnnorcp/kyo=;
 b=OB9whzdr2sstiNv3UFS8sEE8BHwZepb/vcoYY9dB5OArIfVhUfxGwtHjSUNK1LuqMoQZjDY05ddjqK2D+9sMqErLO8nD4hxcwW3+1tlxqUwkG0JIixP3YLXz0HlKZVaGYGxm7RxdramuzODr8JDg1NyJjJz/4L3BoL39T27M8tBqGZz1XCCOCBxAMD88Ro4ZTVIKB0ACVBlaooE17Gk68SvP7coSwW9HfDfOY+Fkxvb4Qs/85bobJ9OCTRa0k66GQNFSBdSQctk8HG1vO5fJGmMfzIwBzqxqIb7TTKVPffj5n7fdR+qn3t/sXqHxUzNYUx0htPahRgz3z2zCDXrfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 12:49:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 12:49:13 +0000
Date: Wed, 9 Jul 2025 13:49:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <techboard@dpdk.org>
Subject: Re: [PATCH] doc: announce changes in structure alignments for UBSan
Message-ID: <aG5lRP_JL3b5xl3V@bricha3-mobl1.ger.corp.intel.com>
References: <20250709124022.4105481-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709124022.4105481-1-david.marchand@redhat.com>
X-ClientProxiedBy: DB3PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:8:1::26)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: eaea806a-6e4d-45b9-3d84-08ddbee701a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VLwZutQz2HGcwSP7E8oEI6vgWxBCEiAdnH9WaSXGghDEu9m9lvdWXC5wpR6+?=
 =?us-ascii?Q?4sNxiUXeEJ7qsNRCCDhEu7KC9niQwrabr2+djjMvKxUfWdiOT8+Jkrrv+U4y?=
 =?us-ascii?Q?E2QOKIl9TlYQHz5zzme5yxVQRtoc6yXjwpUIJJGf2Uo1lEPmF4fqPKz6k4YA?=
 =?us-ascii?Q?kfbq/PAIsmh0WDD1Kn9Rf8fcZUCFhXEaDPyFTI/xVbEULKyDH04yk6ahxhzR?=
 =?us-ascii?Q?+e8L0PnSWPSFNZIzV5jScHCnrG2yHXKcLEJUprdQeTsPoKW/Ou2GI1lbL7xY?=
 =?us-ascii?Q?NGVbcR51Iz6EJ7vTlY5qb4XuOB759bZjLZNBBiYTeNBmcSyEGuATCWotsh4I?=
 =?us-ascii?Q?rBfmI2cJvmbixBALPOppHnCxE5S7b/gouyEWH6q412v8R4+8LsJw64+wer1W?=
 =?us-ascii?Q?BF72JmKY8hTcyPTeGzx6n6Rpv+T2nv64brCraxIkAufDg1SMeodDkbZ06VQG?=
 =?us-ascii?Q?KzqrylATY47JFXGAXN0qRlcy9P73VVc/+OmCHYJUpM/YOvbivguQeVu2tI0G?=
 =?us-ascii?Q?OF7IdE4H0w7HxHGf1c01s7PTwfE1i3yHySLpvCAQQQNhTbFy11j/qRnSU5Gq?=
 =?us-ascii?Q?tx3h9iyjCaC8HYUVQ5NRzCOy+lyp8i4mBsPbT9xNHQLr2arByo56nQdQS5F4?=
 =?us-ascii?Q?gWUnlB07vzaRRNPywe6d68D7mP03xQFPNFJCIMxvEeXm6VDQTzDJYn/2eUn2?=
 =?us-ascii?Q?UmmyiTxLUhbQdqYHqWJSodu/Vy1pJbg8dDlDTUfTLwy/s9JwPAtq9v4ayFmV?=
 =?us-ascii?Q?HmXld5Jew/tVw4XkrXWszD4xykp7UUwfU1PLU9KSgaKfbMmzOJpXEsFx9gwr?=
 =?us-ascii?Q?4U9sLuiKRVfOdxFdnMDvL8R5O+lX2mCedFatdcy2qSEsaneTI/aD6Yvo7v4m?=
 =?us-ascii?Q?Ofg+uL75K/ztnD7V+6erF/6C5ec5tIMjM19X9gujP15QU2IBhgLG99drhKDA?=
 =?us-ascii?Q?HkAYGGKbdolVb5/htIuXule4gmwfk6aG0cZPYNEVWz9DOZr9aax3eiJ5C/rj?=
 =?us-ascii?Q?Z91VcBM9D3h6V0C6J+oMUt2NwtXFG0CMQPHDCVn2xfK5ckRfjY3AomGAmvQF?=
 =?us-ascii?Q?yMdUcsxKcrKcFITCjD4c/GR9RNZW7C2IxXNJK+lsU9SwOa4s0AEggeI6LpRv?=
 =?us-ascii?Q?XAj9QM+jCrqS8Nqnpat33Xajo5DS7NktTukc7jAjG3oKnNTAyHzdyMsX4eg6?=
 =?us-ascii?Q?GJTJwCmjvS8dAzUOhpOroe3lFoG/5oGg1dUb4npjX0/koRmm23H5bmHqinw+?=
 =?us-ascii?Q?Rxld9HZgG92ueuVUpO4sW4LYsKBl/isO3DJtyfYCfx7wM+pERIGIecu4/Qub?=
 =?us-ascii?Q?C0FbTQyzl5ai5/oclRpNbQtsJncB22XbzTC17pfdHwd/pf2pmbMYxsjbHgTy?=
 =?us-ascii?Q?kG0bYSFFEWot9j5ignO0v2rYe3mV5qrvNtDj281rJy/uQlAuZO4y6GtgY/St?=
 =?us-ascii?Q?TgCQQwESpVg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GPz0X32CIOtIM+GLvkIqNiUfFnUH/duVJ/aUFxTWnCpnIncuS66wWsqCQtxd?=
 =?us-ascii?Q?7DL/tbTcwOzYRRRGJ4GBeHJyZ9qaT2GWIWcXSmgSGZ+X0z7jkSeLmQFWtzlW?=
 =?us-ascii?Q?kFagjCMWurIv1KEG7IbcACIAkjUoAn0ucWABTCwm8K1rP6uGBwtbAmHfaOod?=
 =?us-ascii?Q?9EvUHOLJ+tMRQlJUQcayRR/l8BvRwDhQY4IYbD0MC5LZWSgm/RLbzJA5VwnU?=
 =?us-ascii?Q?UzYFzX090qtq0nqHRxeEnUR1KVjXUn6FIP1YPnoglXyzBvgamScdM/bbyAUq?=
 =?us-ascii?Q?V8LaFt26yQ6kNPAq/SmTQS3VkCxZPdP/LbUz1gPy6tCYIYPNnbJcNFmGI5Le?=
 =?us-ascii?Q?zABgYFEWLioj4J2FWYKrMPjPcFloPrmwc3i5vrfbEQOuXShFfQTp3SxlN0bR?=
 =?us-ascii?Q?byXTY4RCwHQspgswZ1MIdZLnMMh7n4DhTDcbXaCuO0E6FtTHis8FStpTVc81?=
 =?us-ascii?Q?GzbO8EoXNmWyhe1W2+MCEsrojgRz9q4yzTp4HF/y9xHtgbeejUPuUvII9BP8?=
 =?us-ascii?Q?qdPJ5B0/tkZAYtLKJkn6yjwvwn1jip9GeO+7R5WP8ib/68M3l9bTeaaG/qPb?=
 =?us-ascii?Q?21tlUZXiMoyl9X4P9nGoCtOzwsMkgqoMiqGRE1npbaUdoQFI7tK/PFXfikIh?=
 =?us-ascii?Q?3NPArtS3FG6aER0ayEbpZQd7rfxM2cAVFfv2XT6FSF6Q6QQTaPbGh1FIA1vu?=
 =?us-ascii?Q?J9Js8bmrGS/YOPsiSKsAStXK18B7x5Qzd/GJ3onE6oYhqKLZb3d4m4AWiIAh?=
 =?us-ascii?Q?79tvszscb8NtAy9mOhPfFwCdNexfkKAnu6Xyg+PGHrrpN3RKPSxCD1/X+gxa?=
 =?us-ascii?Q?XHiWPfrKPgv4WGeouCOeeyoY7Xlb1w0FrdHnPli9BfQxRbxo6UkdZ6lL5gYk?=
 =?us-ascii?Q?eO53RDhFLpJTmjxeIRoxDCXr1wjgZ+4NUIt4gkw+yVsdQSZ1i8wicA+YLrT4?=
 =?us-ascii?Q?rt9Nvzv0r+6Nz8fCVga3ymQFKOxBuyTB8hx+yeT+N/oV/mvXVykLanCg4eIv?=
 =?us-ascii?Q?FqN6QeVJg1jCBPZrhljNcBcvyF53SEw2IyE6U028vA6+m/kd+htYc51WUB4C?=
 =?us-ascii?Q?Kn0MjrZmp1B0nAhD6eqN+6qEQcvIdL/JsKhCFGMkdH4nOy0K/9YwcV+8siH3?=
 =?us-ascii?Q?wexkKXKnoDFQn3wtvPZbbzy16fLTGGXRzH49bkh0uKN+obr8IWC/3Oasv3nx?=
 =?us-ascii?Q?rk6caNmnTpFe4AeZOqoMCnkYnaghriVRANVWg+QLkjAc6bkQtPY17ytxkF7y?=
 =?us-ascii?Q?slPHKGQrpRBl0fsxx0omf3nd32aOCha6INlgTTty2Ryn+0Eed1kvrhEthHf9?=
 =?us-ascii?Q?lvWO9YftrTx8ywCDtTgQTnE2/T64WjdDdE+jXoDA9eHhATV9hIbT42OrvS12?=
 =?us-ascii?Q?VDKLxGb2oFyvVHPXjjzQAo824sp4V8fsT+2+qhUfOqkiyYz/+DKr8wP/9iSo?=
 =?us-ascii?Q?4XmGIA0wvfKJERNkfyzrsx7LKG/QdFK62rvOPOU5vrKvS/saEF99YM+/YKcw?=
 =?us-ascii?Q?kV0AGpOCSJcqEd0uIrAV/q3ZR858e4tMsNKudxHNpT/MrVvx3WdvdbvhSYgG?=
 =?us-ascii?Q?K4sYMjg+mSxdgLy7S0UWdPuji2QsyZYObiMD6wyM91dw1iw9XX3mm4QrELcg?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaea806a-6e4d-45b9-3d84-08ddbee701a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:49:13.2450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GesrAGo8YCjep5sUfmtVxtsxQjRPz/HE/w5xWOY9bNZFII0Dbv24FhRqel2zWyBU6UQMLCyO/cjHJoIx5pLUrXNodoyK8TFrAniIZgqYfoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
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

On Wed, Jul 09, 2025 at 02:40:22PM +0200, David Marchand wrote:
> As part of the effort to limit undefined behaviors in DPDK code, some
> structure alignments revealed not to be accurate enough.
> At the moment two structures have been identified but others may be
> found while running more parts of DPDK with UBSan.
> 
> Though the calling code can explicitly request alignment,
> we would prefer to put the alignment constraints as part of the
> structure definition itself.
> 
> Such changes are ABI breakages.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


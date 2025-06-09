Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D76C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13C0740E17;
	Mon,  9 Jun 2025 12:51:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 63DF540661
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749466263; x=1781002263;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3bBhAH0io2pir/HJ7bIEZuYtxS1Mna+NlwPSA+FUiBM=;
 b=SvIw+ALy7/zEFXJpUtDck00YFsD8GelJHyvqfvjLz0qXPU+3DcT8WZZu
 ChSUC7nib+nxuSsRcsrXzY5BuTz3hS2r4dwTb0k1skgQFMeUMUdhyrVka
 jMTahJa7Od/lYVZXeVQ+GgoF7pOtZwsypgiyrs2iVOBL3ZAS7mix/XF24
 VntJGSd0KZqBJFrryjdek6tdBV1rDJGPaHqYNRa5OCnTAZKZJRQuyEiS8
 WqxDh2zuDBaTkcxE+jXjltlqxdGI+VVmzHYEyeNBHozq9hMfJYGtH4jJS
 VgxR4rBQuX0DNgAiJ7k0MTl3IG4sSbQ8oDOapM1FL3rXBxD6qffp8ed9B g==;
X-CSE-ConnectionGUID: t80mQtH7Q9aCmmuyXVB8mg==
X-CSE-MsgGUID: iegA7nzvTK6bZK6FRDFNsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="55342242"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="55342242"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:51:02 -0700
X-CSE-ConnectionGUID: +9VCvpe/TDyoxNylVu2PUw==
X-CSE-MsgGUID: ABfsYJdATnSteDskVjpntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146385902"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:51:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:51:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:51:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.64)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 03:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMcJTHI5v4Nbott3Zq+y2KFynJZyCrCpQ0MlcKmKsGhdYpnp9LQN22XNSUDtlAGkVms92GIwPZGFfTY3VVesu3QkkTiAQ5Do0eDD5Z86tKwfcNtLdAclNRubB7tW/GUKo3zDLZThHaX0YslTidJydErXT/NkBZu2HhdtvlQ3WHFSh0aQRz/LYd1bsnrokydprKvCnS/+2esrKDs0QXz9C28RmrVsrqX4qESqVqZbmFimsRHrbpOzhH3L/MjmnHtkE0Y8WbvUXs3wloCGziCsY/Wn5FJG2qKHbfsKj8WexPBfhWag60VP1mGeWcPGZC+etQC5EmYuNkQbCe7HErYI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct6Iuz8gdZRimNHJcfZDqUaJkRVNOa0eRNp6qGAda14=;
 b=g+DZa1DgZ66BjF/VsstP0h4jk1mLA9nqjGGG5VvTXz9CCvTH9eU4yKDyyjCmMD0QIbQYMOfEDFEcI3Oqm1Jk9Gd+OnmzVgxcJLBdx/B/XOUqRlttE/fdtSvUCYVC3h7EVAhNCzLC4RlbiTI46DyRtfGbWblR768PFV4MLb3F3jCDqlSAs8Jwc2yv5VWiIvf9BcKmWkdBEkhjwmiMWMNcxCEa0XKEDG1h2cxKH49o47wOsVwB0/MiUkF5x18B6ZE8mCCtzAysBN14eZQjdqtVcNXnJudtkXNnnCjNHQKZ78joS41mcRhCc/elfe/DOpfHDGSJYSe1XtLkeqDCWsYKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV1PR11MB8819.namprd11.prod.outlook.com (2603:10b6:408:2b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Mon, 9 Jun
 2025 10:50:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:50:58 +0000
Date: Mon, 9 Jun 2025 11:50:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 15/34] net/ixgbe: refactor vector common code
Message-ID: <aEa8jcN2H05_ESJD@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <8c9a324f0773cdfd24af3de3518ac189418294b1.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c9a324f0773cdfd24af3de3518ac189418294b1.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:10:232::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV1PR11MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: ee064e52-8a05-45fc-2103-08dda74384a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tKgp1K8PRhpFEdXuMKe4KwBdEYwCC25QUWE9EhSJvO4+eqIPoRnkE1htV2ok?=
 =?us-ascii?Q?RnvUncTMvxsqUYauJvK7wPyzNe9lcNKPgQ4G5BopJUQ6Bm830VhlAVFIPff7?=
 =?us-ascii?Q?2wkd4uebgP3ods5VRRlB48/Db2ox/d8LB9Y1nxyutfpMODmuFcBvI3phkjpy?=
 =?us-ascii?Q?lJEPhhd83cJnOl5OXr5kK0vQQqNSnzvBmKuVeBFBX2RJVujz4S+c+g2dn9Eb?=
 =?us-ascii?Q?RrHxHL5p0OB2ACdkYkIdcY3D5Kv4C6iqm9tIG0kSKz4qaU+xpxxPSsY3iOdr?=
 =?us-ascii?Q?5ec9fIeO1Fowa7gFam753psRyN8hmKSbWEdBiOvQnfAY7P42/927qIuZR4sJ?=
 =?us-ascii?Q?Nack2tnuebZRaLHnOGgXDAH/dzzuhMPX6jd2MbVRdRBULnreSKZ7rYvzo605?=
 =?us-ascii?Q?3XOlee4G/uDB7j4jnV9jKLqfeg2I3xIxzyEH4STWGZirY3VY5X2W5TnxQtzC?=
 =?us-ascii?Q?mh+oYqeENnx/+tzZqbkkXiW4Un8yhgIwKv5ZkC96JdorcGt//94IeTmtbuvd?=
 =?us-ascii?Q?ZweDS9jX2ss/03Ok+F+Ymlc5e4x7J2xEkc3H7WhCbqfkvV0nvgDn7epl3Qpe?=
 =?us-ascii?Q?7Ief3lh8Iq45N42uqkI/5X+Zqiu3leOFQB3b6siR06Xihp9R8cAQH2lIKtrj?=
 =?us-ascii?Q?Eocffa47bCA0+DtXQx383zqF4GKkXc/KScmsepiHsLZyturx52vvrpcuzj6F?=
 =?us-ascii?Q?7k0aOBA+CA+U9GjH+uK93XN674OdvOVaTQR4bOiNdW3IJUgDyGfJnXSWuGOO?=
 =?us-ascii?Q?IUM7BiVxNiq8jE3xtbBmD6rUDAO2NTeC9O18Gsrl0dVYTjufFK4RMfyC3mOP?=
 =?us-ascii?Q?sedX5BwlPU43omEgJQH23Sh02EAjXp/pZZVzPVcfCreMABZbVvW+VqFy8xzS?=
 =?us-ascii?Q?Ngndbt5hPITJ4o1YqzRZp89HX5jQe5dCvnO1vgzPmHyiCERJDE6flFhxGcvH?=
 =?us-ascii?Q?9K0XIEkwvx9DVhL3f0YHEWELGDFadXqx6MgJNQ8MAlFcMT6el3zC5D3v4gOq?=
 =?us-ascii?Q?q5TGAmWoTGkDEzFp2OPu1EzJgD9NPB193/hmPUqelmpoWmzAUM4CirVpOTBu?=
 =?us-ascii?Q?2Utl3Z29LbS+BaW8pCDE8nKhvez5IKmmBFa6bTbiVmh925LaPPpxZgQ5ZC3a?=
 =?us-ascii?Q?xrBOhMG7uO/qwBwN2EnE8YTnR/72t5H9faIsYlkl7zq+COyD2Z5W5Xe9xd5e?=
 =?us-ascii?Q?SYaAWRp+I+EeI+0TuC+OKnLQ8SMOHSUWnopbvSDsR5goUP8YEMYvo119BAVV?=
 =?us-ascii?Q?h0y39opKD5Q7IR6Z+nDQLiKUZYSH87E/ir9xvKetBDRn/TfVIGsEMzqQEYZz?=
 =?us-ascii?Q?GpfwzXXqZISkZLIhMq4ugqRywYdUoNUB9w43YRWUiZczsalh2qjJt7iX90bI?=
 =?us-ascii?Q?PIrEQgfd1uHgJlJ+Z4KgCZEkpAA6x8KUPnSUWPDqZrIL00K/8uajgc8wkQUX?=
 =?us-ascii?Q?8SqHFPd3OwI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfsX33y6FOGOAGExhFKvA9vXHa4rQdj+dbLbVZCnXuc/mI2kg0n50WCcvnh9?=
 =?us-ascii?Q?n/1LvtqShJ0Pnqcc0sTnVo+gI/pGy9hCDwOvpidQvvMIGV5qpssDXpLVcLUf?=
 =?us-ascii?Q?AxEu87JYi+Ttz7MBFQ/EkxdlYs16NWJRBlhf3H1KXuh88Vkjmr5biQ9hr+97?=
 =?us-ascii?Q?+xvamNX0OIWZjs6qOZbeJbR8QoetdUj7MecBUMZX8jGH5xCDbMCTjno5bNws?=
 =?us-ascii?Q?PmjbVkGJSAUfexrZVnyrq1q7+IZ0Zv0lCUI0KCnSokwHnl/LeY3oTAJcuTpV?=
 =?us-ascii?Q?Fsu+K/lh7YsQr//+aOZgsXjYKMgFSBks7ujeYfnc0Y6MHzxn0k1v0jGkxsRm?=
 =?us-ascii?Q?MSvov1yfjxgKFCI3Qz5qvTTJib8NdfU4GrM+wUo038X9Bk3Eaq8oQDn6ZR1t?=
 =?us-ascii?Q?OmIcXaqHu5VPK9gFLJegDg/mymgRAj8zZGANNGQZIM1nYKkSe/QtiJ7dSJ9k?=
 =?us-ascii?Q?LlCKLWKtRPXUooaSHghfYzFa5fhKUIVmF1UwQvpVnKkcUa0bMjuinUyixPTF?=
 =?us-ascii?Q?qHn3vSvlVtt/0JBZNDdwF7NG6bUAq9qClvDGGipwl/c0CdSNwOL+KDJdNyu2?=
 =?us-ascii?Q?+/tl2FsOwkphvps/1zqmjqIS2VH6r837QUWbvSrkAJKj0VvfP22g5qtSGRAM?=
 =?us-ascii?Q?hjazF0PTLDm0Ei6SDPMUzeTK86dlmsxYbPSdNotGMzRxxjprmd8zQia3aKIs?=
 =?us-ascii?Q?buO0xkgzMr0GJemczmF4IEvzrD4+I8JIpt+KnIXWerjh7Zwd/O3Un7uObmZI?=
 =?us-ascii?Q?9o1SbC/Wwq9ZN25DI+GVXmdIDa0xdUS72LFi+xPpquvla4tuIxe3UzrC7Vfy?=
 =?us-ascii?Q?eKHFYocU+Vy02a7dqC/nQg/X2o88fg/LjgdUxp7Y70/sWIO3sUuz+Itzq2gA?=
 =?us-ascii?Q?kTZ73iuBjerOOvky0ALU1jaS+IopeNJ23r4TiFFQ70nfhQoeMgvWoDDdbq08?=
 =?us-ascii?Q?Uc8mNe9TOmlPJHtO+xR7yJpQ95SF9Y41jQ4hznIWylYiBGQoXUjpcLuw6sA4?=
 =?us-ascii?Q?7OdZ1ZYES7R8UrIMu/xVsIr8DUhapZr8dnch9sfvzMEahvzqGrwkUyEymx1e?=
 =?us-ascii?Q?H5kygTvoHS7QYdo4/mZhJGlyin65DxeE2cP8il9t7Qg1tRE0PzT9Qw87v5ON?=
 =?us-ascii?Q?vEHcA5vrvFa3PnQ7TpUllSYZTnn3mE2Hki7JgU6Z2K5KhJqk/dDEVGBVj5SZ?=
 =?us-ascii?Q?/WUDUXSNJBA1UU7cTyrGeTDrDu0vndR2VGi6qTpcE960SA+6L5tGc6gRo1l2?=
 =?us-ascii?Q?rKUlKIdq/WvJACutD60wFchj09iLm4fPhy7PKZ/LTOLE4Qdx7hqkMrPtDfhl?=
 =?us-ascii?Q?1yn8T30DW/UqZPxGM2/LHy487kD0iWNhwpfow4fCHKMG1XhrhkLT+URhQYb+?=
 =?us-ascii?Q?JovI/10ZCJTHPue8p1lXq09ru4+q8VT1+FfO+6H56SKSQTagzP9vrGdNfHqx?=
 =?us-ascii?Q?0LYz5HKU2//KPe3QHhrLR6CleF5gzHz1Lw/Nr7EQWwE7nEKH4/3s9bB44YE5?=
 =?us-ascii?Q?pQXDulpCFnjznbBQfstv0B3byuTJ09Aw3oCLa/nOZKI6ff0+97WH2pQI4VVZ?=
 =?us-ascii?Q?I/51bhqYAYL7ASUFVH4GovDfoaONyOCQVHOzz2Jw3AOUnsltI2K6zIY3HaNt?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee064e52-8a05-45fc-2103-08dda74384a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:50:58.7536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COTQKLmtxCDQBFkdunz1YBtcdr78+dGZf3oziXQ2E2g9qC3XT9z1eO/eUaSV4ZKv/xirOam/WweuSUIR/Vn/y/km6z7peuIalceOD01F/64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8819
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

On Fri, Jun 06, 2025 at 06:08:54PM +0100, Anatoly Burakov wrote:
> Each vector driver provides its own Rx queue setup etc. functions, but
> actually they're entirely identical, and can be merged. Rename the
> `ixgbe_recycle_mbufs_vec_common.c` to `ixgbe_rxtx_vec_common.c` and move
> all common code there from each respective vector driver.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h          |   8 -
>  ...s_vec_common.c => ixgbe_rxtx_vec_common.c} | 137 +++++++++++++++++-
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   | 127 ++--------------
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  42 ------
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  42 ------
>  drivers/net/intel/ixgbe/meson.build           |   4 +-
>  7 files changed, 148 insertions(+), 214 deletions(-)
>  rename drivers/net/intel/ixgbe/{ixgbe_recycle_mbufs_vec_common.c => ixgbe_rxtx_vec_common.c} (56%)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


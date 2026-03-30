Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A661061B06
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:46:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7BB640650;
	Mon, 30 Mar 2026 16:46:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4A47840616
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:46:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774882003; x=1806418003;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=spCCFcYHD8cZc+jD/Otz71uQjfntAmu1FRl3MadXL3E=;
 b=ficzkgI1gZEAHC+j9/b5/xqUHvCtf4dHPX8/nkprSicwxd2RoWbOmXtd
 rsRLyr3HKp/S7L/VB8ZnVEC6OOckUdGw1hwVGNrmW7gcdLU/PEnhaRLCD
 q3sH8Q1IU2HoULulpkk/2a7ihKDRU20e7NCpJGQKV6y1bSftp6I9+1M8F
 IipDME2Iea70kGQJrCeP93DOs71ROcA9EvfTEPHe/FGfwxHdTXdPPe98j
 76qOonw7aKvIul5aY/HetIoTPID5oKnDzBHFokHTs1esA4I1fzXL4T4Gb
 PMeqCdlWXi7pH8DlIp+3/LnigbTosRsU0tQ/mxWk+73KG8fYE9CaVRFza A==;
X-CSE-ConnectionGUID: rLD3KUsSQ+a9XCtGA3e5sw==
X-CSE-MsgGUID: d4JnLgVzQYy9SRK/Qyw/uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75772106"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75772106"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:46:42 -0700
X-CSE-ConnectionGUID: o8fz1zWrTneMGVkqg1gzvw==
X-CSE-MsgGUID: OhalIfS5Riyqe9XffiKZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="225248120"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:46:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:46:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 07:46:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJQFeotRwHP+eVtyMRBDm/GFcsVb8yprMp/V7ICG4T0i0s+vbanwaqgcwoOCcxRYB5a9bB+6+7M+6rLuG7+FtsBCask8+3l1+2N31uBWx9gVCJBPkC7rxRYfRAVAx7Z0pRpRYo37ESmZR9Uprk9+lmEQksHY6BXXLwqNst8rNtFhwqKTMFqoPBlZy6vOWfp46w+kReycIf26VNXj+/jnOf3PociZGVVBGc0Vwly5uBXiQoX27AL37iVVnZS1UMlaBpYRDuzqbPqUubRvcv8ZQWYJxc+aJgR9xFdq4G9ykoLm1ehsNMuA9aQgF0h8W3Ac6v5fpQ7BT1wrl+Js9YPcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et8+zczaAGVdcQCg+of8J1VigCNqRlYYXzNAHlb0ISU=;
 b=dfPELo2pNXKXeSOlLK7Qv8QYCv8jPparmx3AjarznW03l/xEfx1YJ0bSlsrkF3eYdaV2X5SG2wD3vKN66rDsxjPVSTupsY9mJJVNgAy9Czu/v2Igw9Dx6QvNnyPA2kiXCHYxSTA+dKu5iW471i6d4tfnmHKPZHcZkVtq/SPGN/ZKxS2amiXIRQTgIJKqU9ZzDtXWFaWV0tfo933+njqZSnJ9P2KnNcxWe9L/3qlRthJG5owWbz4ZVqzS1MgsKltYjFUCm2jMpmZPcNn0O3Vdne0dHS+G+XRj0FQEYwYoYKfcGRT02ihiD++4uS6qUhzIDSBVmRj/QKgCWmINGXr18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7576.namprd11.prod.outlook.com (2603:10b6:a03:4c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:46:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:46:36 +0000
Date: Mon, 30 Mar 2026 15:46:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v2 0/6] Consolidate, shrink and update version tables
Message-ID: <acqMyNu6BHgf2gMh@bricha3-mobl1.ger.corp.intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
 <20260330141415.1267233-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260330141415.1267233-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZP191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: b28680b2-cc1d-4ad0-dda7-08de8e6b24da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /UuMn1BMcjQ2SvVfLrM4iIrYo63eNhTUSys3nrNgDuLAp6IYBCB55t7QmzD3eQdpkNnIi88zcFXEmDmVSJdMBpLhfZVH3HgKNhYm6uKh8gb0t5SiDBdCh2rhmTqOXqCqbQAU8klVxrSYt0D1YAMCzRFb5qlOcEWrXnmbpoYquvlgCZCA+GD5B1x1XYJKah8UWoAB7U0eDGtKP5cBi8yacdqga645VIVc9iL7heW5JoK5gfpV6nI7BTDt6IjUavYjgWrtavYFgmcFzRclRPIIwamIOcyMJUk43lTRmOU6rJzaQud9QBrGSs2a3BKv+3gfQza21xsPI8nfVVRxinrXRMyw94AmqTWBokNP70tdnk37AGnvU4z9TPu6YE7tgzJ5a/Xv1+33p99bIhDaCTSRx9KYdQNblMYTsdEZ3Y7fI15C5LwT6A6bpZJZ3NDpqSDKalzzL5+gmP8d0Z9lTE+f7lAWVp2LmY0aeKSNCdycQ8Q3JeJUnHiv61VvKALREanNhDJTDqzYqOxqF23XQuspIq8yd6KdunSzTduYYBod4pluQv99vjUu5DxM4RJSOn2gO1VfZ1e7yBf+3a7YThTyxZcuwJi80FI3bJe/Nvw2mSi5O2h72lNczxNGq3gv1hQ/HwpPhYymSf61sx+mORDMWb3IY/m70fYK/OaJ5TEPlT3mpl1t0ieTeWJ4wnHJ7BtzL8UN5YsR+LvwTt6/QBZpSFxG/koC+kYcz0sk0NRBLnkAGIEiWiuZt2uJNIfUx07k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8iT2BtzTyxqYXsQkViu9XPqfURur+DUOx9srdHLyp2KhR4ahChvPK422AQ+h?=
 =?us-ascii?Q?7A/ucZuynovZ9xJlyL462SD5aeFLpsOerogDLk0JQoY3YCTvHCdnmkvHrSqp?=
 =?us-ascii?Q?DEUmm2F+AQYP7MYIrLMjpdu1kpl19XY7Hbi7u8FPY/hXEnKbap/K6lytRBR+?=
 =?us-ascii?Q?retIF8wRBPPcGQZ+mQq8PJCKGcZcvLGMbfW7eB1F96QsFVrDctaCIESRlkeS?=
 =?us-ascii?Q?iHU95hM84NFT0eFlcxlanq6LMZ+jrhVgyPLqxV0iKZxVMWOmjTpqxRvEFIgd?=
 =?us-ascii?Q?9n5hKl10IhGZvV3qQsBBAqcTv6UJWuKScIwbl42KgMjTQCcQgiXLijwXQgcT?=
 =?us-ascii?Q?33B8v7iv0swWjLm39wL1KwTxY0ipuCZCFPhDTeN2ZGtmpUqu6fVedYTiCMoI?=
 =?us-ascii?Q?13XSQT4OGa+raGkahKyBMUlRainWK4O95D9qmApvsepYasrXI+UEdfxKwFV1?=
 =?us-ascii?Q?w4H4BQSkdbn5w7FRh4aWMLvnyDXHXZGIf2JNWdNEdfjB2kAd0lwfQjQN/ZCd?=
 =?us-ascii?Q?ykgagyUalTAvTzSEA0HbBkFYGZ+jEFOfVpraSqKh3U1hL5P/v3u4bsNXDhFD?=
 =?us-ascii?Q?5LdFyLF71iZdR54OYPSO7rg/nteV3WGxoKPJCAP2plaU2rby8EsGEN+G+VV/?=
 =?us-ascii?Q?XdCfyOM/tBcLpYu5NGR4p0F4UYFqAE9jhXr6p0/QkksFyn53ZlVqvXNwQDrM?=
 =?us-ascii?Q?PEb9NrWtZ7JNN1Ike4Sx+SCleZyQm/SYppKdfIUVOj4cdoN04oSDJ2+pJ2f1?=
 =?us-ascii?Q?eiWIK+6WMShyFzhN5Ho2gpQuWHtx4c4EULYITmpu8aDPz8WFzWRK7aWlTttc?=
 =?us-ascii?Q?GIEMcvkdNKCYWrsiC6236mvLWoUSWMwL9eZhbH47uU/MTpkIoyiTuQQ9X1gy?=
 =?us-ascii?Q?RuMzEK7vORwNBuB8gRGTL62Ej2m8fS737CPhm5KgRBc2XBgxU3XqM1WNl455?=
 =?us-ascii?Q?qno6z5/5oC2SC5+VsDK5SVUPRVoXHw3TYklqy/uZTpnBAf/ijJlun3L1an4G?=
 =?us-ascii?Q?F+C2UmF4+YXsabOc7GQ77xYvsW1DMPAmNP8yS5RD2XKgSOW9QBb2J5ATGn1B?=
 =?us-ascii?Q?lNDNuYV8FqxvmmtPfl5coaTl25zpQNHb0khQD/9tQ0Xe+cEo6BGxTb+K7saD?=
 =?us-ascii?Q?8OJRvCa4v2lp8g5tsYWriizDo/8KChzcQfzoKoBKBfzXQgVbYtUJZpRkLVib?=
 =?us-ascii?Q?iKEm0V5pVHhNxLi3ZC4OYxG344n1jYTm2hU90yc24LqcEoBsiei8gRBbREHh?=
 =?us-ascii?Q?3xQJHejqA0p+c6ACVw3PeRKnmkxhvme2OLphqn+c5UrQvb7EGKGNVT0tBlxD?=
 =?us-ascii?Q?+2B+YDWJ+p3kp9jI12QS3ztMJNhE1Ygu2tMHwSinoMvNNE4/04Ovxity85de?=
 =?us-ascii?Q?OvvqP7sLH3ewJa0iv1bH37vsmQNyBlJJ2tZ/6wXYN9uU7cReMOaNVvcuZaP/?=
 =?us-ascii?Q?0+gGFOtUf1xjCYeDgoJkhM/BkH/kCpj6V3a/xdkQJg5U5aCzmK8UUoKvMJ/G?=
 =?us-ascii?Q?HCf+WAcpdtA7NkFOQpLTsfi2tym+dNeOjHlmpL4qzRi5/561LcyQreZJMbTf?=
 =?us-ascii?Q?BnLqEK05QgQElQKwtRlmFpID0awCTlPNBdDbZLsak/AIG2WP+W6x2BRrCYg+?=
 =?us-ascii?Q?j24Ea+nflUHFkIaf/Z8mYn8ufr9zBhwJWiYuPotx9Ll+hbDk4gQgWMTJe5oi?=
 =?us-ascii?Q?HuWgaDIsd/DIPfI9/Lh/GcbFNV5svh1UVBYz/j9NvUmPU+wH6dnBxHkwl7Kr?=
 =?us-ascii?Q?SbD986+OTuR+3EWFqW/wwycuLe7XKa4=3D?=
X-Exchange-RoutingPolicyChecked: hQITnYO2yE/SUuIbsTgOMwTsYRLEaqaBKlvDnm2xtEmcClQCwlfwC4oOV6PzvQCaN3rQk1K9uW2dc764IsoSBBrCjZa0qKw+TwVrnH1Xnoi4s9o3VNgFPDvTzTc8fW6EveUr+F5nL2Hztbe9ImxrL0Nh0nSQLov2wYhGXUvseg+h4uTV0in0mr20RMqyAMHfedCKR9jtBEbfKstEL4JNIYVmi8+VTGspWWo3Y4y7AtpQMU3lXp59FS83Ku7vui58yBkTNeuLFKM1WzLBqzcs6pndB/jjitGR1sbtF+VE5vtDp/WQ9a1HfaMcxyfvRCFoUNffMnC8aSP9lFBMo4kl6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b28680b2-cc1d-4ad0-dda7-08de8e6b24da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:46:36.6265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD7vTEoxtdtgOVpgHJw2857mp3HAaIakFqjpqfCZpTH7dtW3ykNIrZzBJ/zrOGeNWlMBsifjpbbbnMTtB8pA3F/nfEcRuDPSdJzxrz2eoio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7576
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

On Mon, Mar 30, 2026 at 03:11:01PM +0100, Bruce Richardson wrote:
> The version tables in i40e and ice were overly long, having details
> about long-unsupported releases, as well as containing duplicate info
> in separate tables for different NIC variants. Merge and shrink these
> tables to make them more manageable, then update with latest info for
> 26.03 release
> 
> V2:
> * include reworked copies of patches from [1] into set to make a single
>   update patchset.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?state=*&series=37766
> 
> Bruce Richardson (4):
>   net/ice: merge version tables for E810 and E830
>   net/ice: remove non-LTS releases from version table
>   net/i40e: drop unsupported releases from version table
>   net/i40e: merge version tables
> 
> Hailin Xu (2):
>   net/ice: update version matching table
>   net/i40e: update version matching table
> 
Series pushed to next-net-intel, in order to make the 26.03 release.

/Bruce

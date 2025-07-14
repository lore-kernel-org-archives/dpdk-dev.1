Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC1FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 09:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDC3C4021F;
	Mon, 14 Jul 2025 11:04:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 14379400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 11:04:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752483860; x=1784019860;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=DqPdrrKhK3Z1gmQr4A+7ZfBTfMTSvppVpTYgdDoadvM=;
 b=k97mMrWJMLDnXuQSvWRvfGeczej1n2DwixT/z2UK1CQIapFY0Frctwx6
 oMH9lUHjQ2wZezQFPidr9irTqeemksvC8KiNwmfJk6poZ+siPJi43IOTN
 Dy83wn9WhhmETC4WGg247X0H6sAT7OMkVmSTRatQZqcvvPwEbLY8pGSkD
 k+ZLfJgvWVarlYPBYwd3M4yY3vRKZTPKECb2BWfRscyU7x8CE+4S2ZrFP
 Xtu/NvEm9YJXS8IGZYTDwtyXrWoe8Lro9BvBbbChupgEy1yKtWQ+o+ZuT
 Vqq32N3xwNPyldMuTNYw0pXZ/F0guaWgjdewdzOkstcQYjH6W4vJgBdUL w==;
X-CSE-ConnectionGUID: 256tlApuSUCjalGtI+HCJg==
X-CSE-MsgGUID: uF/Mf3umTEeQLV3bgpdWGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54796585"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="54796585"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:04:03 -0700
X-CSE-ConnectionGUID: GY9RIjrjSkuo2YuoMbHACQ==
X-CSE-MsgGUID: qH/pMSXOQtKKD6/PeaRLCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="160903521"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:03:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 02:03:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 02:03:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 02:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+Z6Lwgxctzv+PsK1dRx9fzxQiBWvX5Ciu75RzmO+YJD8LxIJeQ0NmUa+7NqMYJ19kguvMlWnNsgEaX51VcMiZHIrxOE5gogwwjFFoBxUDBs8t5DqOVuxw5PGzmFJqi0a1iKHe9kUP9VFbAhgllRHO7JBw4fgUClAqgHPgczqNjgBetFaVkEUC2sFfMN8aJYJuh+ht2QElXqJuNADjXg8ayrybIT2airUIatx0swvPTQhWrq9qbQJqVM1HrJvfKteTzU3mQKZ7uAvBOUSyofQ/CCojZ+gD25gyVbKSf6CiWNsFIZJqg8qAf82tXQsFRNh31JxIVSOEdtGn8xsMbFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mhlMa0pcfYAJTI4U1/UgjX1Yy+aYzxUbm+o0yo6ZPM=;
 b=RVGyQXMWvF2jXGdXLAjNCqyC9mreow9YecJ3fBuonOfs7qowrwWFSNhHEBKG58PtX/ejfQhAHajXujKYovGGvx354GmdY27z2NrSx+kT0Zm0DATAK7IN1N7IyRmQIpqiHDoB7vVwn2VciTiEMxTOZojCDJ2nROa3LUIGfzzvfSntBwozgrhXEy+wEdc249WSYqSIwLajJaORLIgWlyPi19zNSQ6GEAPMI4F7KfuK2Kb7GYy3iVQwVgI2zysA3d9AiyAe/MZ4a1tolocrLkrtXD+CuzEyg6pf9HSPjCoBbXvGUbvb5i1geRu/wI6MlzVWLD1y8bMw7VkkxIoaMCGChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 09:03:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 09:03:38 +0000
Date: Mon, 14 Jul 2025 10:03:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: Secondary process access control mechanism
Message-ID: <aHTH5sJvjYO-7QRN@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FDAD@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDAD@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf63d19-f945-4509-a9e1-08ddc2b5529c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uQrcURZAeTzh1vGuIRdHgovOoHKW4MxaT7ajXmQyTalw2tgG45nLvJ2I5g?=
 =?iso-8859-1?Q?m9YGUEBuUh9juei0QHfGLo/G5fZxdmMWyz8N45MA0UNXSmuA/Pv6bUx9Pj?=
 =?iso-8859-1?Q?+rqDYdHE/Zlmm/6viSXwijhi9zQpOW7twZCLIAaANUsD4ad1hT72l1511j?=
 =?iso-8859-1?Q?2w0AC+6EOi0vMRvLjz7D7McUbJ/7HHF3xjjTJKVamnN1IJCqtUrBZUjLIM?=
 =?iso-8859-1?Q?4ygXSrv88qCSHbFyGV+ojtKEgkLLWNTTAqp2hCEeujmo0BaUdHKsXnbQ3P?=
 =?iso-8859-1?Q?9v5aAjc8ef0Nlzu3wXwN3mIEk0MrCf3Y8wiu1OTR9zjkm4s67TXwE71J5x?=
 =?iso-8859-1?Q?ublfWZZCa15CI3R3v9IfkNKtT6DUd/FlkNsY8VX3ZDVIUAglkqEn95JQsh?=
 =?iso-8859-1?Q?bqafzuCB+NuAhlqh8jYTPjH5jDIOt+g/z1KGjLP9rlY1Thcvxa+DKibOB7?=
 =?iso-8859-1?Q?yt4YztLA562/PiTuo7InewHtz23rN8ElwLpxeAYKH+SmCleJjimtQ8h1Hb?=
 =?iso-8859-1?Q?CE8RVPjHIvVmbO21Z8wrBz2iyZJW0NVmPf8uFDrMSxHX4w/f3jQNMNLX2/?=
 =?iso-8859-1?Q?L7i1yUBdvmp5zV01fuH5kPUmOEVzeXFlL+tz7NTvA3XiNCpqYdqVK+lxGE?=
 =?iso-8859-1?Q?RWu4yhi5ItTEQmsS+u9L1ip2F0Q3hnGje+42Ws+/IvfIc9osrTAjd4ZTh4?=
 =?iso-8859-1?Q?H2TkLmYEE0f+FrZ02w8MQe30mc5rWDf5baQEux1YzCzPJ4CQ8ZFd6ina3Y?=
 =?iso-8859-1?Q?kbCHAg9qUjQog2GIxXHZtg/q93Lf88cQjtpP7lY4GETwrh0/XnjwAs8RHm?=
 =?iso-8859-1?Q?9gHsWGRskm4qy8mVRyn75UiwsVOhSlhH+Pl1wo3av8mpVcxR6WYTnhRfmb?=
 =?iso-8859-1?Q?GcEm92MYFBK/qS8+INcwF/Pg09Sly3AXMKpWQkoeC0iaVn9nG4NT1oGaKl?=
 =?iso-8859-1?Q?kBBJPt5kOdu7bT9HGYKGZvKmDhsQB5d7E9tiR3jDyrbhEfRXqxe58jZBdZ?=
 =?iso-8859-1?Q?tKwqb28F4fAR5UYmtT29SCyUFkCaIWFhcLsgptjJTu9I507sUAd1CkVSuw?=
 =?iso-8859-1?Q?n+jP2h2xIt3Z1ymCV7xwQAqyXi6z7L/nO6pcEgH1M3I9ca663Y3MN+gqpi?=
 =?iso-8859-1?Q?6R5dGIc0JMV0BvB1OEYFj7QQyJZJz4+X/sHb8F/m1MuF+IU+hXiMe5Q8qs?=
 =?iso-8859-1?Q?JDArvZfZgJA/FSy5nQziEYuMHXXIJNMN43KjsK2kn+0LuwDNZft20wniAn?=
 =?iso-8859-1?Q?ZLg18EkViLbvUq8W7h8gNsd3awSUIf47RBuISCvxJIcFZvFRNMoJ6NcTzk?=
 =?iso-8859-1?Q?GpVjnNPZXYFQPCsdNpwzWTTGF8C4X5yrgf39bnd0fb4CP/uQVKgn6TzpZr?=
 =?iso-8859-1?Q?KEU62Z9U0k6OItf6Rs8GYtQUaELU7wA9Po4y0/qUvZX9dtF0IKS1FTeZgn?=
 =?iso-8859-1?Q?nH7XdUphKNa7NSfREG7W3p2c+81ypHFon5E75gRCL5E4NeMW5QJtBLXYR5?=
 =?iso-8859-1?Q?c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3hc1iFYZaYT7yM8UMfsCLqXjyuGEc/HlSWsovHrEM6ypNXlrhCG6ebb4d1?=
 =?iso-8859-1?Q?lyq/cgxumO/Quu3rsUChFtjy7pQBrSsP6gCI1IW33VzEEN5ITh4QQm7UvJ?=
 =?iso-8859-1?Q?oxQr/kZHTATRq+ILY455hiupRDVkiCDLBEaUYeCXkf6daEgZP1sDEx4OUA?=
 =?iso-8859-1?Q?0La4nkhsE+Q4kcVjfHB4byYBTemRwreTJ5iEC8M8JDrKpJgScM43eKkMQ/?=
 =?iso-8859-1?Q?rp7hHpEbcgb7REHuXtA1xPFcPWZliy37wkqngB35qD97L+PV3uy5t2Yvs7?=
 =?iso-8859-1?Q?4WRDqsL2q7jkBSI6iyeJZOfYtypnaryQaPj5zW5R/E3tfFIfOGQiBXoXqe?=
 =?iso-8859-1?Q?Vzcc56HOesjbA7d3r7GjTyXCELGOqvWKJ0kiCPpKsDfi8pbFMzgl5Y8TiV?=
 =?iso-8859-1?Q?EERA5VWiR/+Xa9zfUSIZlDsr5hqlbHMmTgEamtvRfOVDoxm5udal4Hd6gU?=
 =?iso-8859-1?Q?L/EZo+yKfvQB7tYgx+5Nblu6j1rWZNiAmsh0TrASdndxSweIqNXtc8JVrx?=
 =?iso-8859-1?Q?feux6m7gmvSt9/xWLuuaBO1n1a/KraA5LqyAQT/n2g+g97yfmeMCMqdn0u?=
 =?iso-8859-1?Q?N9Rlz9RWC3LlRrcM94yct65qH1ISdlxZbgJDC79tSZ/FH+kK1UpHJdoxl9?=
 =?iso-8859-1?Q?zotvd5GUV4DHm/DURGoJ+CoSCfA87ilnV5i99YsiMUH1dgM93Tq4dAFcV1?=
 =?iso-8859-1?Q?e4bf8i3lQlYI4c3AHh2iYH16C/0E0y3qeg42B0uhANoCC9jlbmmloJSVhe?=
 =?iso-8859-1?Q?fB+l6beEVo2/MPyy8h3L9tRg/oVZUaQyteg1NbnzlT2H2w6dGyk34t0CYZ?=
 =?iso-8859-1?Q?w0ve+Zp4tziU7QjdtQ5MBzs9MEDF2/0RYPwQI4QZ0JQW8N+1tQJ4m5Eb0W?=
 =?iso-8859-1?Q?hhD+0njr3hgsggn4Ck8fZu+FlA9fzfDrBURlN4Yk4RJ+tgZsAGtv6PV/Dx?=
 =?iso-8859-1?Q?/Vn3blkGWJAoJyDOxFPS+a/iLEI4acFy1Btrkq2eY7PTRpfzsANyOqZczI?=
 =?iso-8859-1?Q?lgJ8HzpieDQhO+GrdAggmj83ZwiDdpkL+4z7L4I24euv7+fVy+40GNsObe?=
 =?iso-8859-1?Q?vpNfelVAEiV2V2J/zJBtmb/+KC4jtQiJVtd97G8JB1eiBo/uH4BBkXrkt0?=
 =?iso-8859-1?Q?S4vis87Vss0Le5RIWQkfRSSx8zVyuZ/8KRVOVcFmKldRAi9mRQh2ztFAwt?=
 =?iso-8859-1?Q?CLYNsjhCYjvhH4LzI+tzgfy6Zegvqkk2h+XfcguxMDnXjgNesCguVLb1DH?=
 =?iso-8859-1?Q?LAdI8bu0z7ZdulHURhyUkfuAMuaaV/eArnozZfcrlaBSMx6iHTR2ZzDGIM?=
 =?iso-8859-1?Q?jb0zSy1ni2eDzfOr3/6rgxGuvNb8g9qg3igaFaVWolimZeFt4B04iBXwnF?=
 =?iso-8859-1?Q?fvOopEBv5g08GoFHNbz9PXr4A55wEzxcBVMnWbL5iUk9DkNFFRvRsfw5I7?=
 =?iso-8859-1?Q?feJgIxpUMrFwx5j8pDYkE1BUpp32BkGaByTgtWvZiwYpdufNi2+XFgexgI?=
 =?iso-8859-1?Q?iuRgH4CCnJQQCHl2mVoW3Wd7/Hqud8nvNaOwqTRmsh+b0W+wvSXMo/mG9j?=
 =?iso-8859-1?Q?PSfJ9smL92w0rR5Drn6x34WvHnmD6LgGOyao0HcTLqYVe4wt1jTBjvSDIa?=
 =?iso-8859-1?Q?l9QkY/TNimKv2fDfkwb/gPhLPLLhSXiu0UpkItHbTYLzmry96+xJ1SSw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf63d19-f945-4509-a9e1-08ddc2b5529c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:03:38.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsc/puQjA5Hor0DuKoFGWc1fi/yGgUpGlo57MabLC1TY1651xTMmHcjH+EvpygAJkVLf8n6BUJZ1/YwxgN0QzacKQbAm2FLiRBc7e1MHvJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
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

On Wed, Jul 09, 2025 at 08:02:30PM +0200, Morten Brørup wrote:
> Are there any access control mechanisms to govern what a secondary process can do to a primary process?
> 
> Let's say I'm running a primary process, and want to allow only authorized secondary processes to attach to it. No unauthorized secondary processes should be able to attach to it.
> 
> I assume there is no fine grained control over which features various secondary processes can access.
> 
Nope, no fine grained control. The only control that we have is that
governed by the unix access permissions on the process and the runtime
directory. Any secondary process run by the user of the primary process
will have full access to the primary process. AFAIK: other users on the system
should not have any access, unless permissions are set appropriately by the
primary user. [However, I suspect this is not something we ever test!]

/Bruce

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650EFC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4139F40E34;
	Wed,  5 Feb 2025 11:46:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 449F740BA5
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738752394; x=1770288394;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cxM+MGbcTayLKGogjgznfwhJl6DTDK8nHuEjVKRRxy4=;
 b=mB+/spapDwokbkNoOMJIEJUbao72Q+3c3g0KMEfwdBJm7k3SuaDXELHs
 RuTDghE1JGyg2VkN8bYJc0pVd22wk0/NeWTIqzpplDYFjbxyYfT2tkGdx
 yi5OVx9aF3jmQedtW7XPUd+lSUvd9FA2YqmT/BNTI/UE6/DIjuf6Uuich
 wg/nActPFI/B2e/hToqRh8TjQiNeOPnMwa7ll0NiGsKW309MhlzwVCnrL
 qQBgGmv1wXyde7jwOmTLChWKXJEY0EGuTKUEYslgOOaLzCm2biEkNacT9
 nJkJX8sR5pDLxjDBHHYYLP0ADkY8BdfIKUnJIvtsZ71v3rRlpVnj3mUmp g==;
X-CSE-ConnectionGUID: OZdLVtYPRsuwljd5B1KJwA==
X-CSE-MsgGUID: B95RqkCIQ2a4Nix1YEEP/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39422841"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39422841"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:46:33 -0800
X-CSE-ConnectionGUID: IlZQP5BxQaKkjqKfSDBT1g==
X-CSE-MsgGUID: MZ8/kEaqTsGEkGu/fg1T6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141759268"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 02:46:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 02:46:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 02:46:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 02:46:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/NInS8Ae9rkHk6qM0wZIpUIsw7zKScFgCj9kqXe5y7fEcc6UFMzGy9bzbcJlIwSOeNkoOW7MYpZeTuQKsA+yhfP87LejTHhHbMcXpKVZkxC30IGf9yenz12mqc37R0fpyk4zF3IERE3rLLm+GfJ8SxFlGMpRtGRNZBeEXc+Y+0UXMZvHwTCQ+61ts1+TdV12FZE7KCt5EOkTS1MQk+LBDpSltme8suOy6PppYkm+NgMbIpxMD9Rv5XstvvYTW+ZmHBHsPuQglhZ0vTfKq/M6ltWK9PWkviPpGakB7sWZGU+91ILbJzB6u9mVKDgvrz4NzKbmZbU0e/UWFsRKZAxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKFtYjn+XVLMll1O1H+wb4AycAednG73zzrsug+E6F8=;
 b=fU7+v99yHJNEo2i0rZVUnguLXGYVd1xbA6BXg9ARsDVUCiZ8IAZt7G2XA5Kvh9pXrjedUcKU0zBcLVkLUUUxqfiZrtIDYXb72cIWkjv83AKgxSWLbUq5o0fXrpCargRzNojY6/rhSkK+cgNJUhhQK+DlAGtVt7XD+FF0MN0W5XNKylXFvn81iVTDY4YLtVdxpJ8eVnLVrZGpjZMLGNdQ4RcN8HudGSgNfQeAktS3/JI14aUKSziARQYnkbJU1Pirf1k4UdaVCQNZ0LqJiThlXKFGgujjpnS7ycLPd7qH6Hap+39lyIVCkew9tUhu79B75PK1qPJnJHso7hNMqSsbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 10:46:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:46:01 +0000
Date: Wed, 5 Feb 2025 10:45:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 03/54] net/igc: remove the driver
Message-ID: <Z6NBZIcC9Wx1o_nA@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
 <96ac05f1590ccf25f99f57a98961dc7bb6bd1774.1738681726.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <96ac05f1590ccf25f99f57a98961dc7bb6bd1774.1738681726.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: f02a90b9-4cfb-4170-2228-08dd45d2482e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m9taSzkp+EoyF5fe7F+UpXe2Au4tYo9pEaHClTpZpI5N5MfvBfgxd8SJif9k?=
 =?us-ascii?Q?TumLnMAHEJ1g1k8s5/YRo7OtF87BEQIxFqVUerepLyy/yelyu24IB4c3WVbE?=
 =?us-ascii?Q?5YHF0WN6ScpB13roeplekoIGVFOgitITZ9btwQSHlZu9XDFofZfLWCAfqroU?=
 =?us-ascii?Q?Po3aANzSC9IWwJtAa9eKXUknTbw35IRFRnTF8VnKBgOZT2I7BdIgL/ckIv5u?=
 =?us-ascii?Q?kQXRMKillivOedZcuLnALwIIxzmVjT/jrmp6q3Sgt35wnzO4Qd2UBBpFLubg?=
 =?us-ascii?Q?cVXsU1lXNiBe4QjU734uEsrU2gsLPBBTOTKBI1maPK+MY7+qiQ/vrys6WTLq?=
 =?us-ascii?Q?YXIB+zIINBkSJAGHq3epKsNpqSaaI5oHoZB97Hm865fwnb7hDQewQ6GKOMMt?=
 =?us-ascii?Q?wM1G332c3CHUonosOmItmdd5zc+ONymxPp29XBc+8QmAvp4F7JH9xJjIp6s/?=
 =?us-ascii?Q?1u5d/mMCHYzFGfswBQspl+MPxV9d5a9egKUimF9SP/5vi1wi5CSaN3SYX5GU?=
 =?us-ascii?Q?2qj+lphoINvi1WZ3VAlRPk0CQ6wejK1LRFtszloVcV0/ZM57WNElh9bFdQ1Y?=
 =?us-ascii?Q?VvdlL8NsK2KCh/shxV6iOvF1pSngcODJq5e44E+nWVeDbgtMS01H/X4idFes?=
 =?us-ascii?Q?/4qDpY7Jz0FcYm0+om9BZTaa0yBB9WP/TWyGiLwfaQBKqT6delBCg4Q0f1n0?=
 =?us-ascii?Q?bkLag/6Iz6pe2MNS87jSQH6wGDI9gdEtie+KcxmUomhhDoZmIqKKzLZFH6dZ?=
 =?us-ascii?Q?j8u9aL98YrePqtCtr/1tpbdVDHLq7u/Rcob8ywuLLUiY4UsyGDUiMnQlnJOF?=
 =?us-ascii?Q?2BQPDbEjSaGPouK8g/8RC1OZVcG0xhMKkX9ZaIFDrR3Xtlxjd6nzAlTxvyT6?=
 =?us-ascii?Q?5DshIREFwSgXC8iRqopdA4kr1vnGY5rdv3iDmBIFXHPvJDP4NhgOQ2pUuIRT?=
 =?us-ascii?Q?Xt4IdNEyt/vCHertHHA2WYWE2y7PE7F0pEpIAvTdsoU1M65gT7aulKq6MkG6?=
 =?us-ascii?Q?uafJyWTTTAZ8EMmCPhZ5mn8xN3eS9S3El2U5aOaTDWvMwGU2z19e9mUyRqj1?=
 =?us-ascii?Q?SIC9KjZ38ywe/TwgsHgzcGCZFROrjUkfJfr8uL7rl8pdpCZDGbEaEgZMoRxx?=
 =?us-ascii?Q?LrUOg2Jk1SLRpS4BJN57xgT1B4IGm1Oqj2REQGVVp6oWgD4GoxhAZkmAWLXp?=
 =?us-ascii?Q?Gm20+JPGgeLVfyv5a/1EPfjjNMOoIGkN8VTJ8Z8Ez1RoiIPp1gsxKX9dnl5m?=
 =?us-ascii?Q?rJY7B8ANAuP9FCHGIwpVl3UTRhCp2kFqBC33ZERJNMX1CrNqLt3qmBmpsOGz?=
 =?us-ascii?Q?DO5WFBi8akHnvkaULxyBvmV16kRGIBRhqvNaIOI9SbhzFD3Jb0E2AzHPtOIl?=
 =?us-ascii?Q?1S02XcNOF4ALD43JfFuTjTbSlBQb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XkwJCq/Bj0cAQTNAPJhRxeescFZSPcZS/4SkoSblIrYc5yrqe7MPd/IsxQQ?=
 =?us-ascii?Q?QC1znk5p8KfxoA7R16bxwNO0bEhfNsxwqIOXIVoblzdRGltGHC6NjImqCBDJ?=
 =?us-ascii?Q?ifoGjUrMirUmB/8HJBPA/mMDNVn1H8c7lFYMrvqdJalOgApeIEZRcl2Up4C0?=
 =?us-ascii?Q?CpbqkT6HJehC9ekBq7zTsRUxO6dV1+O5kfsqYIzrgdG2F1Rxf7IdojeOQzyF?=
 =?us-ascii?Q?JRyll3ipxk33KduviWSj6c8zFxS9iAvjl5oE2baO1xY6kaUx/nHv5BB5i6wv?=
 =?us-ascii?Q?232RXB3Omlod+qUaBtzFb76LBjYr9oYMFhHBDskzRIblBcidW1c6sNWZxJhL?=
 =?us-ascii?Q?pIdI+1qXJNx+KzvmMimUMfAsvspIoDVRIq6trUomYZKwFM6ckjKWEWW5wXF/?=
 =?us-ascii?Q?+UIJUQ259G6BnLPp0C9FZoeUK09EoHFJZ3e4JOejXKuZHfEFKYRVd4Yo2A3T?=
 =?us-ascii?Q?lc8wVVFHb8OWhk0815hjDswO1UL7Mu1X6/6AKUN+mRwazF8pTq7Y+VQxH+Fl?=
 =?us-ascii?Q?gXSgxqvWT0DMUr0fm6G2ul5JeLiKvQ3Zqkk3WxTojRyDYVmcre6eKYhiDqYh?=
 =?us-ascii?Q?M4N+4dbwAEzPcK2YGDljRGsxILl52dDynjaUgPYaAVon8duzmeC+MI1Nwrtn?=
 =?us-ascii?Q?JAdIoDzspoUGtBc+xYf9yg/1jfZonGemiFOs93msGbFnXfObwEOoGU0bsMno?=
 =?us-ascii?Q?AfNrqeBNJ3LMv0J2nyK4FkUq/5Ide7UQb3Qe1AonBLdk4BirIw8qXi3Z2BFh?=
 =?us-ascii?Q?SBeigdbrw8PXKCqrjXHN3ckW0fZ5wdhDf4AT3gj0riJ7+9IX5xUIO+29Ws5L?=
 =?us-ascii?Q?a/C43qQO2n2bfUBmvQVjV1+Tc5+NY5y4JSCzdXAttPDhnwEs3iwrqwVyFvk7?=
 =?us-ascii?Q?u+od82l41tZv5Gq2X+1jTSv09ipRrUEIV9qbo3GeTL33PuICr3cybUn6CaFw?=
 =?us-ascii?Q?4583shSqfjwcWTqzMLfsLcpkt7FXhgH3Qc9my1aik5BFzVfh/4aBbEu15jBG?=
 =?us-ascii?Q?bkeQf1PxBK6q/1hV95N9w5ZKH3jzsweepYqqJG97HnkOSoHTn2pS7tOY8LdT?=
 =?us-ascii?Q?G4rj/r2NSytKsP8m0TgJGkb3DU+Nv47LeJfmByi9PNK8a4C0jrO57g0AeWFR?=
 =?us-ascii?Q?T1Cgi/wjKVViQmymwfJIx8EALtHUzpgTMn1eZday4B+Fl+lrP3nnROuMXEwB?=
 =?us-ascii?Q?bRpGMLuIWVVuzA0LBfvoEQK9beVaNCUSaKdnPiN/6bsMpBqWkPwp2VC0jgT8?=
 =?us-ascii?Q?2vgAV4SArpoLG+xZ0Qxf38GP52GDDLWgb3R5HK5hcyzM9Tpi1xx/eaRz8d5K?=
 =?us-ascii?Q?IqJCmYXk9kbVKZSO5gXoebE+rbxBPtHextJL/3uaIV4cLMImP6FlQDj7Q+pm?=
 =?us-ascii?Q?H+q6FVkrR3vp3aj6h7ckS6Aiw40T3BeH0436BDZyomxMT7szVjh8fL+qEnEO?=
 =?us-ascii?Q?Mt7Zt7A7Idc1L5zRZlTWxCEBSEtoHFrMcWUi6Z2ACcGUqxmXOTrSwqrtPpWt?=
 =?us-ascii?Q?uP/teGy90Ejl7TG/dc8LHDgpAcx5SFfUjpgjHBvRFwMhcFiDWpUgJmLsOtZ0?=
 =?us-ascii?Q?Nt58XqGwcKS4bc6h0aLQDU14iqd6h/TkvRyJg3QLGNFWfymq1vT7upaVK/5m?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f02a90b9-4cfb-4170-2228-08dd45d2482e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:01.4019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bu5Bm2kjyxil1LpXY1jiXmXCSCVDQbdl6GJOMjJdJ3U2+ToQ76JaX9UamJhh4zXodGr0ZTGollYIzmr33zNNankrcSCIvfER4iV1CqEkek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
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

On Tue, Feb 04, 2025 at 03:10:09PM +0000, Anatoly Burakov wrote:
> Now that e1000 and igc drivers have been merged, remove the igc driver
> directory. This removes:
> 
> - igc base driver directory together with all files in it
> - igc logs header file
> - igc and igc base meson build files
> - igc README file
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

At this point, you should also remove MAINTAINERS file entry and any other
such general references to igc (docs perhaps)?

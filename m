Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B68DCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 17:08:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85FD740A87;
	Fri, 22 Aug 2025 19:08:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 486914029A
 for <dev@dpdk.org>; Fri, 22 Aug 2025 19:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755882513; x=1787418513;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ugb1bjrVOPBMS8OlVip5dgxODGnOxKiXUMvnmnNtYsA=;
 b=oJV6YoacDl/uIKRhr0m+BfEFX7I8Q4clunygFJbHc0gEm5Wsq/TAf/fj
 L0x+KyJ+WyZkHnplJ1RK6e1PuFzfYT5NZjiIWzGCV3tiz3Yyt7a5TMcV8
 UaQgXJFs40RHYOj24rz+xTsad27fr4dCgCKBDMupddNXnSglnHt9JURAM
 963mxSiClbmNS7grxO8otfBqSx02GbDotLt6a60Nodxg1bx3DmCHAPm6+
 3h8yYINaM/+CtCjkBLi5YnrNnnqYRIJYNj2aLZ8LqWJ/ibsi/p4DmP1Ws
 wEyJSRIzf2CKFV5mETaWuSEqqbJM/I/dfSp8AujAFOasG+z2L5w7regyI A==;
X-CSE-ConnectionGUID: ftoVvo6BSRKQuixWaUGNgg==
X-CSE-MsgGUID: dkQ2b0ZvQl6JivY2E2UDAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58340863"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58340863"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 10:08:31 -0700
X-CSE-ConnectionGUID: segl/9yoRLiP2WynYgcMUA==
X-CSE-MsgGUID: FOzgIQ3TSO2vxk98s+gvoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="172948207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 10:08:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 10:08:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 10:08:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.56)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 10:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJ+yYtEUy4Am9RIqL7y3vwHmFFrH+0mj5oVTPwrN5//LKtsALPdO5qnJZr26HV9L5mD91GAnLW2ibr+ZmZvu8TGrON+rFgImhv75PClKSXxEg/+hvtxRis3/mTDWtQ7SgvECs5QdbzyZPi/agzkYUqx3vQ6TQwSM6QFNzZUHzJ8xqWBZpg81Hw52wHTr71XetUTZBMYLTuFJ0xfO2kXBRYEJC6gBu4UXSAMznBFKSeuyCjIR3KFYdcUpoZvImv90OrKDeUZJ7ZUPLPctbUYS4DfLxLrtaz9qsmBmPXiJGQhOWw2BSprLuZNeKKdhqrhmQti1YqymrrgaxsiAHjD+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTcGJWyENTOQryxBYQKHkPwn43owrcPbLd3+ZKHm7xA=;
 b=Vh1EejHo2EYCxrlqRjmtPku1KoSPt6plp6IO+CUWUUq6wvQruGyR8hn3tksIyVH0UePHTDXsnFlp02dgJoNUWYb4hgwvnJi9ILUGExS2B8CMknI44zVOuFO71ypOLbmXbJabJjzqm78JvA56zk9hKdPLaaV2R1nBTcZyDYiLzZUONA45fYHTPYHN3iPc0tUPStz7BBzkyRXeuCoACauTz3wFuWHo3eETDW8Tl5UBtE/bAVxYNoU+8JcDU0BJzxQYaWSl67A7mHBcnnj82TdpGfneEVSwOur8neIpLF7obO1PyQNPvgYWQ8K/wEJPXLg7QQFw7bh+KDIwqMd4qqwuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF399DBF572.namprd11.prod.outlook.com (2603:10b6:f:fc02::1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 17:08:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.017; Fri, 22 Aug 2025
 17:08:27 +0000
Date: Fri, 22 Aug 2025 18:08:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>, "Min Hu (Connor"
 <humin29@huawei.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@oss.nxp.com>, Shai Brandes <shaibran@amazon.com>, Evgeny
 Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>, Amit
 Bernstein <amitbern@amazon.com>, "Wajeeh Atrash" <atrwajee@amazon.com>,
 Gaetan Rivet <grive@u256.net>, Dengdui Huang <huangdengdui@huawei.com>,
 Praveen Shetty <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>, Andrew
 Boyer <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing Zhao"
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Wenbo Cao
 <caowenbo@mucse.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "Jerin Jacob" <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: Ethdev driver request for changes
Message-ID: <aKikAuSUXiI_Al-1@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FDD3@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDD3@smartserver.smartshare.dk>
X-ClientProxiedBy: DB3PR08CA0019.eurprd08.prod.outlook.com (2603:10a6:8::32)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF399DBF572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d293396-bc32-4a3f-6794-08dde19e82dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?SJ9E9mMWtXiMeednaRf22UgYwMAf23j3szIn6Nt11pSuj7yQQecHz7ZYaW?=
 =?iso-8859-1?Q?AnKNQrJoLyqzY1SsdANhMxFdjeQKpdOfwAenUJ838cnt4MUpVNIlnT5LEb?=
 =?iso-8859-1?Q?9KFkPbfCWplpgX/87+0U10pNvQvAigrk7e/ykdM1dgqGfTPDl6PVkPcujU?=
 =?iso-8859-1?Q?HIWSk/sg4UFkWNSSWjRTQCNSYoCEntMBNyddob+irhhOF0DqsStGHl7aAl?=
 =?iso-8859-1?Q?VRKTigLthDkLsC8ck91v1OUNuVRcWji3tJLULWJ9KaeXvAy7SbBX+laDgy?=
 =?iso-8859-1?Q?2iJtjGvBBbsvDK94g7PDVXQtUQ+Y+sd+czQsgMEketPKoUZzPJepAHvEXm?=
 =?iso-8859-1?Q?pE/heQYCXHwn7/PSt1fHR6tPVSl4zvrLwPdrylizok8Zm05yp2cznBc+bl?=
 =?iso-8859-1?Q?H6MGyHQ0OJgUZWORtnNLZxKpusqx+FPv6n6GJp/wG3qWMFfcrsNfkQZDsJ?=
 =?iso-8859-1?Q?rwhJqne5eYLAJZDYF4Eqj0x+3D6/PhLnxL76iNPm8N1w1mDucQ5fbZJcV8?=
 =?iso-8859-1?Q?/YVJyrNaOgl6zAp1N+zzdc8dMLv1LKMgXu5ZB8G4iWahSfQiu7IzuU7Mcd?=
 =?iso-8859-1?Q?+qvNj12z1UmtvTN0nk1h/FG4M7I8X+rsRk7xta3aUNAI8yCp/CmvEXqWOB?=
 =?iso-8859-1?Q?ZwUHSRJxsB3QQYlv33elM/uOM33K/c0SxfaUs1EGG8t7NzUStP6mszbIiK?=
 =?iso-8859-1?Q?tVJ2dfQ4AULeXEO90KG0v94Li6KkgmfsfYApfxYlBvsPprCktfzfONrj3D?=
 =?iso-8859-1?Q?YcoJdSSnnsIweRbgee+FjIbJHNG9JlAXaZ/nNz2SRhsvQgDM+ymkKQUyqZ?=
 =?iso-8859-1?Q?gB+7JGe2gGkL6NrejppvCkADb8h7XcoRBv0XdTCaqZ7O3ZTl7FeUzNDyb2?=
 =?iso-8859-1?Q?62CEo1J97TU48eJkZZcUtvtzUkzaywfOpOn+lmDEPRAD0kLL/kRm5di19Y?=
 =?iso-8859-1?Q?2x89O/2aNLhJHbCdiaLN/RKjzdr4GAdrX3f9FHwoX3IrPPf112/fyeKQyb?=
 =?iso-8859-1?Q?atVWpFheZ4aYZ6U9WYXevAjOOCo/F4iiGBRjNVjMG/DbiVo14TaT67hXaB?=
 =?iso-8859-1?Q?Zy0rTGypq+VLlEw1jais02hFDlAAGhOvMC/mqENLkxF6yQhGYemeiVNvql?=
 =?iso-8859-1?Q?hhwS5W8bM1xjiaNRm/Y93qUEW4pw0Zd/LFmthrKgTvGZOfzKWQbBqI2xkO?=
 =?iso-8859-1?Q?mMjl9eUhF5eX5qsvHWBUU4V1qyWJ8w/khR20CXqyUPM7U1JWSrzNZW60f/?=
 =?iso-8859-1?Q?P4Ip5WPaq35ZUQqxd9X1z7+0j0/yeVZv1N++T7I6RFwXRm6phoZ60IhKOa?=
 =?iso-8859-1?Q?EM9gcIa6wcVvVyJ48dpwaX+fHwFbCRjywKK7wSlD2BO4PQsWDbQIFZc5O6?=
 =?iso-8859-1?Q?2wHP++pYbdBGgamnSDt64vJZgYlWb7U5zQ435msGj/F4n2iUZyqoo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yZUYo+7hNxqKzwa8b3Xve3bqB7nYtLsMpU4Y+H86dBc29U+J+WSSWAZGCV?=
 =?iso-8859-1?Q?VIjx4M/H4HFZLtwho21mnQBpjUlNLtr8V5TqNtQ4CL4NS7ds0HPiUAB7nd?=
 =?iso-8859-1?Q?lmC1PVsUIszbG8XK8ResJPcE4DBql6Id2psqINyduIjiBT8rW/I0iZB70J?=
 =?iso-8859-1?Q?y98aHqpUR9rHQqggsptUjJJmEtVaVLKW6MmKzcvGy6+fLEAaNteXXylHMs?=
 =?iso-8859-1?Q?CQKlDc9iWJWVvX+iCJ3rYK5NvjQ7toBaQVUYfZxMc9ZNzowKKFerXMVmbM?=
 =?iso-8859-1?Q?SetErpneNEA4601m2/NIDAqXMyuq72o3c4YCW6nDEnAdGX31KPqNl+cmKC?=
 =?iso-8859-1?Q?WsSLxd8QTxWm0b+t0vLwucSrsep3J3kfKKer81d4f4s05NUDRTbKbp6gZE?=
 =?iso-8859-1?Q?K1k9u+doOxbK5nq3SWECflhD81g8BBORafxgrFpnLJXR6jSoJrRJnA0wkM?=
 =?iso-8859-1?Q?DPnl7z+8QKh4uQtwFiAPZ5pw9L7FeoPdxjnKKLHn3iXVYBNLgGgRgwwVPK?=
 =?iso-8859-1?Q?+4tXrOjthXZwOGgiUI7v0J2ULjUE1vVJjFDz04CkGmj0ciOmMQZ9z41AEi?=
 =?iso-8859-1?Q?Dr8lGxHWE4LAMjwNSHZxW5uP0YyeO9vmVpEH6Snce57+qXDMELtGyRthj1?=
 =?iso-8859-1?Q?Vb2i4ZNkBSnrkPbaKHk4Jho6f2/gtu4pMLfeHfQn6fC1IOf6v03FsYu9z5?=
 =?iso-8859-1?Q?od/LVM1kt4YdvtJAsP6M++Ye2Np6h0CysIk3/HaD9SpE3AeboDLE03an+Z?=
 =?iso-8859-1?Q?Wqkpguk/t/tdYI/2jlenRpjKck9KCxwKbY/U2qYHOEcMACSAepuZjb+j40?=
 =?iso-8859-1?Q?SEnQTrrXvCzgzG1fZD4Kx5j35rmV6o3ZV35jxMjt5jFLNuIlHp2WO8pTsr?=
 =?iso-8859-1?Q?LW28wWZs6X85GgCBI9C74GimqJm+KteAmi3T7BPq+5ySIH1wWwE9flreAy?=
 =?iso-8859-1?Q?kTWjiUgN5I2L+vkgfnXjXZXxNqlS3AlBJdChAr4rfO1iMTUQ2xSHxQICgB?=
 =?iso-8859-1?Q?LPoQCew4MDKo1AOA+ToqhRLQ2v5/SYSKx+DKCzeq7y6riJq97ejegLwL9q?=
 =?iso-8859-1?Q?XAEH19dz7GwKGzctBB7mZk4UJ7N4Mw4cv7lPx8oTkpxasWIaNzrAq1oNS7?=
 =?iso-8859-1?Q?ZSN/5xUwswGR42AVGcLrVul/9QGr11ff5C16D971ED3C7ALIsCgxSoSM4D?=
 =?iso-8859-1?Q?dD7uIPBRJZRZeffJ61SEUI1gIaEkQhYdrarkIHv8y8PXxZTHQHBxJ0Jteo?=
 =?iso-8859-1?Q?C4h6lAdNmMk3V3BmirGfU3QNdQdrHJGGZ6Lr9SX8MFYOldJWy2vasW9nXn?=
 =?iso-8859-1?Q?6K2Nes+XNJ/cNyUMzo0eN6GSfH/223grfJZx3ps9n7QZTx3GSqgeiTgTqY?=
 =?iso-8859-1?Q?GRp9v5QGjltx8JS1av5RNUXg+oCJezxSIbWpvLE/qxLGA5LilVyqa1X6+A?=
 =?iso-8859-1?Q?gFfjma4iwR9+i+UqZjl63xYkCevOR28TzcGwTdeTaNAbzC0HUm/7rdulWI?=
 =?iso-8859-1?Q?ZaNEUkTRFFqtyAin9c2Y47FrMo4fQlJBwUL6HhFbnd+qOEoODwfVGvMnAK?=
 =?iso-8859-1?Q?mBzQsobuFP/3ziElntL14vbCCSSjAcGfpX1PVBFF1kZOFkbv9HuzTelm8U?=
 =?iso-8859-1?Q?CrPe92eUt/LBSYqKtgl45zmhHjndiNCq5hOHeqkKed3Z3SFhFEGbcTjA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d293396-bc32-4a3f-6794-08dde19e82dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 17:08:27.7987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAPd2im8kzUS6tNdJZg4z/VaDybELy1YQJOO9EKb8d/OO+qJE52O2ZKxxb0i/KPYxOCaXfqnYUNes983ORIVCgd8Y+QEj86XnAxFQ12ds0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF399DBF572
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

On Wed, Jul 30, 2025 at 09:59:52AM +0200, Morten Brørup wrote:
> Ethdev driver maintainers (CC: Ethdev API maintainers),
> 
> Your ethdev drivers support RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE, and probably call rte_mempool_put_bulk() in the mempool lib when FAST_FREE'ing mbufs, thereby bypassing the mbuf lib.
> The appropriate mbuf lib function is rte_mbuf_raw_free_bulk(), which is a relatively new [1] inline function.
> It's a simple wrapper calling rte_mempool_put_bulk(), with the addition of performing mbuf sanity checks when the appropriate defines are enabled.
> 
> In this context, "the appropriate defines" should be RTE_LIBRTE_MBUF_DEBUG (and not also RTE_ENABLE_ASSERT), so I have provided a patch [2] to fix this.
> 
> Similarly, the relatively new [1] inline function rte_mbuf_raw_alloc_bulk() in the mbuf lib is a wrapper for rte_mempool_get_bulk() in the mempool lib, with added sanity checks (when the appropriate defines are enabled).
> 
> Request 1: Please consider changing your driver to call rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk() when FAST_FREE'ing mbufs.
> 
> Request 2: Please consider changing your driver to call rte_mbuf_raw_alloc_bulk() instead of rte_mempool_get_bulk() when allocating mbufs.
> 
For Intel drivers: https://patches.dpdk.org/project/dpdk/list/?series=35995

/Bruce

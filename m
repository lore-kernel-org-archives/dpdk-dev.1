Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD71D37E3A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 14:45:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1D5B40289;
	Wed, 14 Jan 2026 15:45:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D940B400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 15:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768401942; x=1799937942;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/EZ0Aek7Cjzhbyc+n4QLz0SpO+97Q8JfxEC0h+j2PtM=;
 b=SANarzUQKMvCM2nVZzXIHPi8KHJzHvjEiF+78uOoYoGuXp8yzY0sAQBd
 RL7VA7UE+p5DZL5z550Rydzq0/0fYeeWYcmt6XmjglGjD3JLAGPbmAxVM
 tkMgPpXZjswV7TnjufvYupAPLKDpRm1517C1pCmZhPZC0TeP0nO21qbdF
 UCLh5M0y0jN+8DpQxOX6alfBvO4i6IizT/5dA2ckoR+sOQzM6R/ViOKvy
 RWbqKcXDYw9lAah31wtnGyb4uQlhmQMEgGo0+yjAhdgYB0DpQ6VKhgtFe
 5gdSeCrUSbGhGK+4DcrsKN/TRYW60iTVyjRejFZkuMWQTrngn/RiHlfAp w==;
X-CSE-ConnectionGUID: X1RhE6gwRqC8GsE9FMFtOw==
X-CSE-MsgGUID: mW95PNTuSkO8/K1M1yVPqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68908445"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="68908445"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 06:45:40 -0800
X-CSE-ConnectionGUID: CzHRn9bMS2qFKRm0lfh6iA==
X-CSE-MsgGUID: P3u2FnCQT5WGecOjXDuWGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203833356"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 06:45:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 06:45:40 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 06:45:40 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 06:45:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW5CIpqve7Q1v+xisXakaR3JhhIiVppmOzs5si0DRl56OEwlOh4aOa4Cv/xT3okO2FP5577q+GTQ+sSAMEnfKWGTmO5a/AgCcPtpggkbJzsKpLrQ2Mb0EW8DCnHQniR2PJxHO2N9RL3d4EMTnirzYnO8JONB/+lUS9bVIcRpQw6rE5wqqm7ZzJqGvbZsDU9FjP7viClHbApQV2jGwGsISqymKqdHJVUvpLHWslWqIW2Bb50BKjZlq6vQ6L/7VzIRama6mMvLEeiG/sNclSzq7yURA0iTh03u9WF789LawFpAA9SIiPquZiXNzATQWLPxIZ2SC9bbdo21pYCFKD4YEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMWDEfIqxmYd2aQRnuzYoYEV6VtHMYhefrQv1UWYMjM=;
 b=svzjg4s0z/XSmxXk3B3M7n2V1jjKu6GkIooh0HJDa9Mbq4PnbQzoagZ3QLErjNF1exq/d/k7m6hdBdnvlCs38hCNuUmDrxFbqZsDecb3CyEGPVOg5k+V+e/k5ROXWEeY8koA9dcJhxRhUneVfeCl3fAcYs6y3jfga25GJHXUBpOa/t99Wn+I1y7XFxlDvGikPRzAUP01/3SyZTqA3YIOshh8PrkUM9/cwAsytoaOd5OZBmuV2fH2iE4Qx9xCn4x65aHPWvLPoAP8s5gwOh2UFl1pMPLSmTs5BIG/JcvZwLyH0suOdJhuk456cn1+buqOPjHA3T3Gj/hvw9J5u5CMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB4922.namprd11.prod.outlook.com (2603:10b6:806:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 14:45:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 14:45:35 +0000
Date: Wed, 14 Jan 2026 14:45:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: cache mbuf fast release mempool
Message-ID: <aWesClwkYBjDiuwV@bricha3-mobl1.ger.corp.intel.com>
References: <20251212111136.103137-1-mb@smartsharesystems.com>
 <aVv5M8mXjOOIMdKU@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVv5M8mXjOOIMdKU@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: f77120ad-15a9-4894-8c8e-08de537b9398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gn84D0GkKKxYWhA9PyAX+0KcUeqhT10sZPvMf6RLU1hvcXVZIcVicLoQMK?=
 =?iso-8859-1?Q?anzwHLOsNr//J8i63DnEx5nT7zrDRY9q2DXNc9go/V6JJcLLe9DE6Fwg+c?=
 =?iso-8859-1?Q?MVvcME03/0KUx6Qxd/y2+aAcHGfo+JUOPw7d5O/OOhXOdGtmdLkrL9Cpd7?=
 =?iso-8859-1?Q?uhqu8qfHC0ScPFjreAWA5Ocq9mmBB7XvzVdnnyd6qj+0TIDQ8SQHdvk5yB?=
 =?iso-8859-1?Q?PutoU8E6lbB6NZd2YhQwILl03S6YH1JDNA35SVF5Cpkk6e9TE8GDDdSrUb?=
 =?iso-8859-1?Q?tcuNhxsHmER8lsWQ/Tu9tASjC8gSrZbFimipfAQKTRQaj8sf2LPZM0qG4q?=
 =?iso-8859-1?Q?ycU2B7Yuw2JWMPwsoUyIC85LG77RkWCBY7dO62vIUHyyQjgkQGMOR3qtJO?=
 =?iso-8859-1?Q?GZ2xJ1jh1m/L65ON25U3cPJ/dIyBYSUY8k12PzBcXTH8K4/lFZlu7/O0Pp?=
 =?iso-8859-1?Q?19hRUVNHa2KrogLPX/dT1+IN+CARDHzxuBJMqKmAEIs/49auuESuXmYMoW?=
 =?iso-8859-1?Q?UO6itisoAb49J774FT7iQS4uE1AdEuX8QBUZHgqKdSX5pQ7+Moydu21fZ5?=
 =?iso-8859-1?Q?paitq4Tf/rTYkTjxHAefXjOrKShuZWcV+ZCgmiHqvi1DNTsh7StH0F0DZW?=
 =?iso-8859-1?Q?ZOZuGf1M340s/393LhEdcywwgkC/DEHPKqECMVtgJNl9Z2LShBbb6SsOpO?=
 =?iso-8859-1?Q?R6L4dmzaaXWo3nEhcQibEq4GT76hsy4PZAOzE6Q7AupTZFxvt7z8VOutIN?=
 =?iso-8859-1?Q?XlXVK/wdh/2UmbY4HMDijY8rqqj/eeyHSUGzDVN9NgG47CbE/LPbTsGbvY?=
 =?iso-8859-1?Q?NlNXRj0AlNCjuQEg35GLrG8S8bvzge3jMX013MQlEqVdR1jYFegP3i8Q4p?=
 =?iso-8859-1?Q?Rm2oiNKxCyQXo3qjHUYRuxzitxO2xonJQq4OfvK4E06CuPwCwM4NlOic1/?=
 =?iso-8859-1?Q?GiGLEWd3t0nW5ro1F0mshK2Hj4YRUv6+1SW51l74NXgIB+bHkPvuUssUMw?=
 =?iso-8859-1?Q?Mv+bkuDQb67k6HoUlFel6xLK0x+G5GA7/qekxWCEmBef5rl8jZ4/GZGLNl?=
 =?iso-8859-1?Q?ioZmth3gj5R0BKfFAHJv9hwtXT68FRKt9DSZJ4jMK2lILuTRKyY3dMx36c?=
 =?iso-8859-1?Q?dzSvdLGYt2z1FjLAMxPO/LWL4Gd4f27qXJMfhzv7s8HWxUkhhY/t03SIe3?=
 =?iso-8859-1?Q?vzxqqaKK/nX9aVL0QF8Q7FKzl42NR82SuDfYkVZYi/MKtohVRhLCwH6eJE?=
 =?iso-8859-1?Q?QxzRSRbN7OPh7ptdZCGsOk6d4+s9g3/wLWutFDa8/ig9sM6pNB2mh/bscK?=
 =?iso-8859-1?Q?F2yr7XwSWUZmsL4lHWYmL8Qz1MR5+MNQJb0dnUmlDXVHqoqfQN3xWKcdk4?=
 =?iso-8859-1?Q?c4WyJ5fdgU+a7YWYtyxNQy+sFxgo5Af/brVVPl2LhI8HpZhGBDT0mEakWC?=
 =?iso-8859-1?Q?gzPTp9IE+x+A7wJj+rZGkIQv6og03RJOUwq3b1v8zHlPTTK7DpE82weoRy?=
 =?iso-8859-1?Q?ITbTKpYE3dQaBCGkUQILa6gQVmG/HOCVTyVtLnHc3HaqGdfGP71B/7bWe5?=
 =?iso-8859-1?Q?yc3MABrw10yhjZUexdBAfXBRE2ktURS/q20mV3UkT3pTv15zFaEa3385P0?=
 =?iso-8859-1?Q?LeAZe1a2BXkOs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/GV4SzLinqGVRoSfmp4zMk1/hBNUZufiu17tNQ1tZlOkhcEw8MlEYoGB6l?=
 =?iso-8859-1?Q?nFYKNuIPGZQyGTUWYECzwZPK3kQNfUbkC1hHdIcpQnua9xs9NuCpKhOMMS?=
 =?iso-8859-1?Q?kRQ3YOg94DlecVI5fbUq75hwimwRn55aPqtaSObPLKD92P4pm81LV471Dc?=
 =?iso-8859-1?Q?QWZAEWM+4TwDN4CvKIRDUnQcCozRrhwj3bZREyAHILVBgaNV2sUydaYx31?=
 =?iso-8859-1?Q?aqtYou2dbT+5SugGE9IUMMoUKw1y/MoZF6dX0Sq7BUbuk7Ct6QkIi66QlN?=
 =?iso-8859-1?Q?y2LH2CW45QdiihdyW99/FMujUSYerr7p2As1dsSAPySsN3W3n8cbFKkyoF?=
 =?iso-8859-1?Q?CAWZvo0xoUCpO6kmZoHCG6gRq9a2RTdSSlRDcDUQ0uZqLrA2xU0w/uSdRI?=
 =?iso-8859-1?Q?Azjm12XGUH9lAgJjf2WsGTLT+HXo0lO7AuuMQ3fzJVmh/1zD8Flqfcfzwx?=
 =?iso-8859-1?Q?W2WA5tS4tNp8fL0Dc1/AAXjydHnsl45UdmFYq+4t0QTegaIhgwgO0008B4?=
 =?iso-8859-1?Q?WyDi5tGqA4BDb0FXXTu2dfrLSXH467MTJlWuRVgex9C41lpH8lkC7++9zS?=
 =?iso-8859-1?Q?xwP42PYGhZ0ejoA4TjEdsyeL8mhvodMLDy476edsGGmAs9wGf9yaHmbIhZ?=
 =?iso-8859-1?Q?m+gwvfon3eKX4c3yj2VlcaAPBGGzmBeasxHAZSJDDqUFc8/jMkzjlJaRI1?=
 =?iso-8859-1?Q?Sd73HOKLhJzUkbybq+LQtNAeBPr6yVAvnZStNR9v6j1BQA0r2MvVGjHif9?=
 =?iso-8859-1?Q?a/4dreI+AmN2ZjdRdsOp2Rm8Sma5klguX+GmVIVQC/4PpWlmeYs1D1w5pf?=
 =?iso-8859-1?Q?zkgmkfuHq2ZfOQRB0IRandotEu2u/LboH3JyQWCZ+1gUTF/fNDRtoqrsD5?=
 =?iso-8859-1?Q?MM1IZDcVs72EJwpKswZpKOexUu4YOMnsq1Jf/2plYqe+8L9zkdZ94Po5Fa?=
 =?iso-8859-1?Q?j1pnmCi8ZUrnNWLWuS93F0ECqt6ajIY8joyUSm3q2/VYcTzEwkXgKpygPR?=
 =?iso-8859-1?Q?KTP6o96qbpYyxuq0ORWDP1hpdsbesOQzcOyPieLiwsvo7e34oKPJbSNTBa?=
 =?iso-8859-1?Q?s9iQ+Elc4g5a4IXETpNZCfre5q5RWYZv9FFPQ94F0yvNQfb9aVxfprsdFg?=
 =?iso-8859-1?Q?GlGA2OIVoW5tORH5W5+tsRwSgr/stnLX48OW2ZdJaNKSB4xttp4ilDEBYC?=
 =?iso-8859-1?Q?Tcadb+dUH0bpKUgc2W4pQFNRt63aNa0PJFheJ6JToAOyWFuNl05TVmaC7G?=
 =?iso-8859-1?Q?cSCvTRLJCxeYZoeSG1zCHa9uUy3EfzM3wRAxF6tnD0d3XoJttXqvm4jxzZ?=
 =?iso-8859-1?Q?4u4y8Ja+KZTq8SFsjL4y3l2dC0JY7M9OodbDQcPtchnaktcZu3wkDk1YkN?=
 =?iso-8859-1?Q?jQSo9/uZesaQiWcNMrzNMrN7RPBCGryMwT0vTbLBicaIXQ5wo/xa3RH75E?=
 =?iso-8859-1?Q?pNUMZ5nxExsVsIouZ/tWbcxpWUdM8YNzpYI/DrV3u+3WivDAux6mw9a8U8?=
 =?iso-8859-1?Q?65L+eEZhVZQ4R/9yp7KyPfGpKbkuA9bo9p49wxDUmG8AiIW8lzCB4lgdfU?=
 =?iso-8859-1?Q?jeMUGrB9KE8X/Y7lU710fcEvKD51lByBfSlAuCo+HBm7PERtETsYQZILO+?=
 =?iso-8859-1?Q?U8q88GwfLT1decyV05DsMWaUvrcjBCSa75lpGOd6fCYKXgSAARyM4+MK6H?=
 =?iso-8859-1?Q?Rp35d7uvpKvkXlkonKlU5WNJ5BlX7N/HK2WygxBfdc6YtWSTzoOclorNy8?=
 =?iso-8859-1?Q?4HWJYtUn4meYJatcMKoQFnHMrTQ8nQxN5GpF8ADaD0X1GEJgJvQ1XTlF+h?=
 =?iso-8859-1?Q?jfgePdaIK/65DajryQg42PTp2BkOpEE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f77120ad-15a9-4894-8c8e-08de537b9398
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 14:45:35.8003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FzWiTl6y5a8eI/rTfMT/p3LrSGnWNA/APuBqTA6yve95Sh4heT2lwYDgsXMgwzcWb3X9YbqEpOYLL/q2sKCbL7Az7c9go1dcmzo84owSTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4922
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

On Mon, Jan 05, 2026 at 05:47:31PM +0000, Bruce Richardson wrote:
> On Fri, Dec 12, 2025 at 11:11:36AM +0000, Morten Brørup wrote:
> > When fast release of mbufs is enabled, the mempool to free the mbufs to
> > was determined by looking at the pool pointer of the first mbuf in the
> > burst being freed, potentially costing a cache miss.
> > 
> > This patch adds a mbuf fast release mempool pointer to the common transmit
> > queue structure, so reading the mbufs during fast release is avoided.
> > The pointer in located a cache line already being accessed,
> > and is only set once, when the first mbuf ever is released.
> > 
> > The fast release mempool pointer also indicates if fast release is
> > enabled, so this pointer is checked instead of the
> > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE flag in the offloads field in the
> > transmit queue structure.
> > 
> > The same optimizations were applied to mbuf recycle.
> > 
> > For the ice driver, prefetcing the mbufs when fast release of mbufs is
> > enabled became superflouous, and has been moved into the branch for normal
> > mbuf release.
> > 
> > For the i40e driver, prefetcing the mbufs when fast release of mbufs is
> > enabled was already superflouous, and has been moved into the branch for
> > normal mbuf release.
> > 
> > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > ---
> >  drivers/net/intel/common/recycle_mbufs.h | 10 +++++---
> >  drivers/net/intel/common/tx.h            | 14 +++++++++--
> >  drivers/net/intel/cpfl/cpfl_rxtx.c       |  2 ++
> >  drivers/net/intel/i40e/i40e_rxtx.c       | 31 +++++++++++++++---------
> >  drivers/net/intel/iavf/iavf_rxtx.c       |  2 ++
> >  drivers/net/intel/ice/ice_rxtx.c         | 15 +++++++++---
> >  drivers/net/intel/idpf/idpf_rxtx.c       |  2 ++
> >  drivers/net/intel/ixgbe/ixgbe_rxtx.c     |  2 ++
> >  8 files changed, 57 insertions(+), 21 deletions(-)
> > 
> 
> This change seems reasonable to me. Ran a quick test with 2 x 100G ports
> and saw no degradation in performance, and it seems to improve performance
> by maybe 1-2%, in that quick test.
> 
> Therefore:
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to next-net-intel.

Thanks,
/Bruce

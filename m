Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E34CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0532140667;
	Wed, 24 Sep 2025 15:57:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id AC55140611;
 Wed, 24 Sep 2025 15:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758722271; x=1790258271;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SrYezbR0LBLHeysUW/xncs4X1a2BOcMlOffKxKbLQ78=;
 b=YOU0FXko7q5J0UmyufzQ2E8JQI2JzocKPPKrYy2e+GQzUrECD/cjHkmG
 yr5Dr8XQQWck8IaV8/a8Hii7j6LmuroMpHqOwBn3vF9JUdMAdhNRADBMd
 BXfwspRo2gMqRHSAaZwdyTGlGDuSIDWk2puBsqGul05ekMDkKZWRGD1Eq
 JnEgoEFz/57aQ49FM7dmcallWCpCRMStX57uK9ubrl1BSkDefqfS8OmIA
 LZW84oI07V0VjlVDJI99+u1dQGjfnBsHmHSa9QF5Yf4kH9PSYTB2rlQbH
 oYvN4gFBptaFcYrSk1iR8nluPpcGIuQAjEo/42V0O/DLdxgubGrrWFCt6 g==;
X-CSE-ConnectionGUID: /uI8Rv+6QtGWijCGnAXNQg==
X-CSE-MsgGUID: aTuVi+M3SDmr0abxbbXqtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="48585178"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="48585178"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:57:50 -0700
X-CSE-ConnectionGUID: z0M/CR75SYyGyDFGavxEaA==
X-CSE-MsgGUID: gLqKHla4RK6bePn9E37NQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="177436660"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:57:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 06:57:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 06:57:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 06:57:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9nC1R6BbXROrQTrDaS1ZxHutFMeIeHMzTBbuMzOnKh/9WSv53Tui/uOI9xP/McuERXqzMrv7w49bm1KYWix7zNJL8x5LXNvETdy2B4RWkejuOmXV8gBxTvcSFylKrK4N7053+5xtM82lYXRt0dQkfflL6YmwLoRMnvvXvDJ2coT+JLM/d3irajGbGpQC045tqiLor0CmJ1WJirMrxuixBNSPnpgS1StoAhVA6gpTh0AIAE4odSA9mZ/h4jlKbS2iC7yeV1DQbMajZskJLV04mXx7FmQRlInHw60Wu3qG+RfZckKGyjOlYhsAUyNAtWkzVSFoC69aofexzhevkZgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B5Fpe4YKRFPtx9TOJS7S/LFWgxANSgdTEiuPwg1xds=;
 b=PSbpzmNqILct1x2zuO9LZu7z6/Zj81PTOSvRUL0YqFjowGFgPvGGfc1Fawn2Ya1uTUHHAhhluWsG8YKylTxs+uaiinHLcAGQB2+FLctAOVZ2PGnPs5mAFk0lQjV4gPw3qBaXvjWjsPzv6/BRD/NNT6y1UOJTtd7Zin3+EjM0wtVPjP9AAkgeTD4Kw8nzQHOE/y7gR/2kO/tRaIe5/pE7+hzlrWeqKs+1OGOYt4oRLtZXa1Himx/JbTLMAFefE1/nIfpOlp4E4pQN09/Dr9iEQVLNuO4GfA14RSuArQm+tERif4jFF4ZxAaVo5HJh2HBLSDZBh5Jq+f0akyRSGoKDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 13:57:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:57:40 +0000
Date: Wed, 24 Sep 2025 14:57:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 8/8] net/iavf: document support for extended statistics
Message-ID: <aNP40KdD3iLyQ9WT@bricha3-mobl1.ger.corp.intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
 <20250916142113.3485738-9-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916142113.3485738-9-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8701f6-02ff-4e2c-fdcb-08ddfb725396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RogA13mPVScByX4Yh6p0AB0EQ4QbmW7HXJEYmXoqs5fPrn6JnW1XP5y/wbHt?=
 =?us-ascii?Q?ARdQ9UVjzZj4bGtwrhd1xREI2a+j8ur7oHFkRG4bJjPd1174o69G7qu4DQHL?=
 =?us-ascii?Q?mQIKY+1/FtTp1y0vQ7EpjCsbiUcmCs27GiXwOP/6iU9b18Is6JHs2OvZFs9f?=
 =?us-ascii?Q?zUZUjPmP0XObQDAjZtzWhkBXeHAhc4q3eeodYO+RFGu0MPylXa876G0TOoY+?=
 =?us-ascii?Q?lgaYCeWSJjtYqdM+c4TDbFz+ZfE/WiU998WvyrIv5s6+otIGLNZGCpjjKXtN?=
 =?us-ascii?Q?u417hddHtBdx3JkRw//gb9h3fbNgWnmXy/3KiGWbYiW00KqfHAa33zYtXdTS?=
 =?us-ascii?Q?vbjD0m1Udo3DOnmzXiY8stJesMwjR+aHLntN/4BIQo+M5zvDkE5qiAZhLzCJ?=
 =?us-ascii?Q?M3dZC+Utk8sXjV9inx+1HEqGRm2mDHatNUlPAybMylsbkfQ3NstOemWilOuO?=
 =?us-ascii?Q?9kgq8RzK+OZ2PkfqUSZjU7WG8zhqJqjag2e8/MMmH5nHuwqc6Tycos7t3XH8?=
 =?us-ascii?Q?IgmUUvbTi++fSjkqw9Wx9NSPvbakC8nPQYPRlYFdVeYg8iUTRYeCK0No863X?=
 =?us-ascii?Q?Uzd2XAiMaW7GB2Lf8qIqFpHx/Qb/0z7gbryjHMYhDKroPQl+Uteve/1o6gi4?=
 =?us-ascii?Q?14ouou9wgEZJRTposrtJx7pGPeuo6uFIKUrzAMHeeb145LSCt7Zh4K2fiCug?=
 =?us-ascii?Q?1C6zCJBUyVvh0hque46zzBIy04wanaQrOy23jqZOTtkzTOoglCnjo5LA07pP?=
 =?us-ascii?Q?izQu3UTJksfe8qwvkKYa8GOHzsAtAA4x0VgS/HH/OkuzfteA4Y/0h2ZLtgBz?=
 =?us-ascii?Q?lwNrNzbqrECfgxQvtvhMZ59gASkUdBQ4N5qbJgZGZMjmUseG+kiDqvujM7oW?=
 =?us-ascii?Q?uTWfkPb4iCfXsIdM5F1jSeUp37xrCWccjYyS9c3VKEbg/eM8jq3V0QpeRBmc?=
 =?us-ascii?Q?Dh7DOp75P9LRJQYvdSOWrRAtUFz+1Xh/GO2ARVkQeMhtQcxlyZSJWoPuCa8U?=
 =?us-ascii?Q?cLAc3KXcQ01FROUz+o1pYOlC4k6iAbHw0+o4Vcz4uvFqmHPDnLAMENcxrggj?=
 =?us-ascii?Q?/rEdHhaE3tzVkp1EtmrTgvk/rD/fu198C1eUtKKT+io9JoYh+f5rx4ket4Uk?=
 =?us-ascii?Q?DQFsb7homPoKPhaHaM4ANd3cLNvUkqUdz+/v9n9IoRNms0Nk6ZFrM7xLsRMo?=
 =?us-ascii?Q?6PQPPmkc0dVcSfuZsRNJtTqt6qIbms7N6Bm9bXgW5jkduvrMTTphH+HKdVZK?=
 =?us-ascii?Q?QsuAM9Q83xYmIyZbRkeYm15QeG2/qUtaBHqin8lKEXHQxm7amj2zx3/FIrv2?=
 =?us-ascii?Q?mEq3JjDC7fBWuLkb9VxBbswfAOm43grFZsyh+Ue9le6jx+Za2NEblxdXYCgM?=
 =?us-ascii?Q?MWlhfAaOyHNVEOgR6E3Q8w5XtwwSRqXXepxP9sgOfV0srKkfAmvhT9L/O0PC?=
 =?us-ascii?Q?EQMUFHJLi/I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/qFkpE8vxbqUu7RWA8Vx/O7Kp7tsg9Bz2c/GhkXP7Df8lGvMAokk8Hcni//?=
 =?us-ascii?Q?EVLX1rJ0yBJnPtS/i6wpkXVbfijQu69G00+Sa2qPFUfvMTXCaaoHfJ2DmUMo?=
 =?us-ascii?Q?AEi1/i7CO/Ul0TLpVBDQOw/T1KSj1h3fvZpjMyDnECKcNgcKO3oUmRUGQT36?=
 =?us-ascii?Q?Wd+Eg6mAlOLfbGh35kWnLQXPutkuzIqE7frziOtkUCDBGYWN67WhRpCdUOxg?=
 =?us-ascii?Q?Yv7MNKVelR44qJtAy+kJ+18TUNShAa9l0KZ9Ua05aQWO47a/XrwvXMvJpKMk?=
 =?us-ascii?Q?bUdLXdVaagq4ZHvKLunr0P6VqXj1CsQchSHIF3cGBpVvK+OsABq5QxUCsUbV?=
 =?us-ascii?Q?hhqzBLH+KCQRVMPj6ydfbuEfle5o/GaBYmMSmFqpszne6WfgBWL7jzTWOHK2?=
 =?us-ascii?Q?m/IBqksz1VfjS47xlWWpPao3R0m/+7A1fjpqIeh3QjSjFmLyKnd40Ua/layD?=
 =?us-ascii?Q?UG6s1RGma4/S/nOOxHxVjT0Vi1te7PvIa68mVPIYqjzdp2mtfNdC3XbneuAr?=
 =?us-ascii?Q?1hrFLlkPfO8GH3Sgh/dRX9+DOsyHH7Osu4hS/e132/oH3jdlVC8EuhCr9M+2?=
 =?us-ascii?Q?kVSu598CQGCsrOJI+NkOEGOwgiKh0dAkKoanX7Mqme1K9nLXfkCLLb22AQnA?=
 =?us-ascii?Q?Qo4mhaizOrxknD8QpxJmnQoHEI2HPZsFRi4gUM9jnR5KR1/yIi/F99PcNXQA?=
 =?us-ascii?Q?/jPOoyiTM0dwzI6tPPZmg2TUbD3e+8S0qn8Wg3hjM2/GYZpP9bm/3U9Y8HHT?=
 =?us-ascii?Q?Nn8zr5QJBDntervRTFN+5FmiyxeQEylbGlK2DNFnsKWfmlSGP0nxy2rUKo7G?=
 =?us-ascii?Q?lbbjp4RvqABEullNPgQdQPZr7qZGXGWQEmsk9cgPKEPxx0jv+B4yJHtt2q1w?=
 =?us-ascii?Q?x7nFl449rLrnYGvn2TxFOWPz6CQnMTWeeV0orTbuEktLMDCOgkiCRW/bDJrc?=
 =?us-ascii?Q?bDZu0LRecm4kBqC41yIXqHBM77Zg9mb+/J6eaOjseMyqdf2VyyNRcosJEY7o?=
 =?us-ascii?Q?sPu3d0ywlVTK6JAqvLo2jq3heBHDO0aga8UW2+HN2SslA+P+638V1ZyS/xgo?=
 =?us-ascii?Q?oETPjGxyQ4ADkEApl24XtnKjiXJMbjP3FhHOcbvKk/8PAOXDKxSGMVpZklkV?=
 =?us-ascii?Q?CVIy9+sdaXGnaWxiBVXJEyrB9zT2uT6IXWmiScSDYiZIFs/0mAu8ryoUW8jy?=
 =?us-ascii?Q?fgdzjvEv8VtdQzEl8fs2HcIImfLZu9lMdButEFDGfNYHMaM67Q2s5I1O45lO?=
 =?us-ascii?Q?df1RtiPqD8F4iwEY5NBQT/TZvvUuqSExJzTWkWz4VdYjwWLNOcKxOgQOtt8q?=
 =?us-ascii?Q?zidhP92OIQg5wYJ3vnMpSr74TTZwyTOEnGd8Mn2+fZAiXXm6VEnoec/spseG?=
 =?us-ascii?Q?SFaWVsok9B46kj7gYGT8E8/XTHRv898sNbi81KxqxlOUtj6j1DGlDpgSU3cr?=
 =?us-ascii?Q?a/kHNONcA/gBCMeQ4Lul0vkAVnEXKp22TqefTcncvpBa3lPO1CjYpei4yEx2?=
 =?us-ascii?Q?si40VNkw1/Lmb7vK0LYEoHs/ljs/wFGv8hChNhW+DnCTvYGTXYFCFCKW2uMo?=
 =?us-ascii?Q?DgiZfn3pxC8jPHPuwDid8c5mZOYjBL4nuBuKXwfGzLX0pxNpgTB9WGmG0D0r?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8701f6-02ff-4e2c-fdcb-08ddfb725396
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:57:40.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Coy4BVeIdaqMpyLGJbxjHCKyUFidJXiKF9HJLyy4xyhh/JxMgDsUmKSh7ceEyTPF9sglk+jRNUyopiSPQ6Hvu878HdbP4pBvOpadpi+GzHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
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

On Tue, Sep 16, 2025 at 02:21:13PM +0000, Ciara Loftus wrote:
> The extended statistics feature has been implemented since commit
> d38a06bf4367 ("net/iavf: add extended stats"). Update the list of
> supported features to reflect this.
> 
> Fixes: d38a06bf4367 ("net/iavf: add extended stats")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini | 1 +
>  1 file changed, 1 insertion(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

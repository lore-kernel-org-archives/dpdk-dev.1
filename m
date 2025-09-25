Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FDCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:23:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 121E940665;
	Thu, 25 Sep 2025 12:23:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 834FE402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758795778; x=1790331778;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=zsUOAVzoKL1AdAtuRdVAceQShfqIG4VNFTxbz5aLnSE=;
 b=k0M8baiK9AyJedgNCr5TwIHbQsdN1PnMlf8VN4ouLSyWz/AZozZM+z+S
 FC1549ZWKGgKyqUBOXrXuFQ/ATwEbE1wK7vNr0bf6B/wgG2UulM7vN7Lo
 rIwDdxWsDnANUnFaT3SIL2wwwYb7pg8fjDIPuK6Wu+EwVKJEOUtGqVSzo
 WbI+LBHCPVeqPXgk0tb52I6VPUmu11WIQjMCzpReOCxxngY79D+oOezdA
 z3ejOXFqiEe0yu0aOM/5ZRwxZOg1I+g983gjPOmt5+B1X6AAl9J76rXdi
 5/BT3LJuN2hI+t6hken+puzMYSWQtN+LHkajaDAkMYhRyqj8IJfnjUmIB Q==;
X-CSE-ConnectionGUID: GeK+yS2pRouQA8NuktcLyA==
X-CSE-MsgGUID: BHEJVyu7Q4GINK9ieM6+YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61022940"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61022940"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:22:57 -0700
X-CSE-ConnectionGUID: 3T7vF0NDQjG38YJWq/2kNg==
X-CSE-MsgGUID: kv5P8wnxRHGO46EX6a36mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="182453786"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:22:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:22:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 03:22:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLtQdlN+9x/tEI71+cxxFcMmgMeRj4xgtFukNtlBc1Zg0dEHnqT1NcH+LQGyu5YMgy0gALYD570HrxOIQlkTUjsssa8caA/23esiyF5sV8adZjt0rPNtKaqO6LA7OuF9NQEdV+RK/WaLjO5wHUC8hSsyABSBZ9I4wsK3tIyEqGOQTVEfzKhtpRYXnLlTwaALEPl+Pta6FmKJNAYKkiVemMwroPqU3aXW8rfcBUncxJY/E+H35H29KeKew/G1e9vbwMbTBvYR5KzAoMRrCDDbWLMnhYvFCxGs4iNuXMxc4i5h0lGQVPrlb9Kaq0ztfyGrYm74NeCv2LmkJtwm10+jWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGAikTfiaoHmzgyGaHEwc3lycFaTNkv5p4doOadCIv4=;
 b=Z+E5z5vCshIlDKFQuhJ+91mBuETINfYiReMNNccNGwQRP0vkUjIHf2oEhMKo/vOTD4F6PuxbJ42A52bP2c3GFz0o7LLL5jcp2ucM9/VoC5vdbYuLf6NVhFCUbjRCeaBv13nOTNIymSbKMG8ZcZLCY7wW2pEQDr/GEVojCfdFP8ItYkWucY702Dz7PBJZON/vF/QMx/ekslcqpfJom9PYR3HmUrddJJJKC4EdogtHUza/Jid8RFv12/HVpkX9N2MOVtRZUznHOyhXEeW2qWcyGa5ju6iWfFBVwq2KPb0Mq6jdxOMWFXWGGCd+upyZsl++tP4cH2m5rRJyKUxXkU5Tgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 10:22:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 10:22:52 +0000
Date: Thu, 25 Sep 2025 11:22:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNUX97_fwzkGTBLx@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
 <aNUL_Pl6Hf2bmcJJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6546A@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6546A@smartserver.smartshare.dk>
X-ClientProxiedBy: LO4P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8057121b-b54c-4dfa-5bf0-08ddfc1d7bd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uIwQ3liO0iVOvTQx0D/Po42nCJ+qY4vSZ2qwFdIZ88zGcIBLGyfF14Sw2X?=
 =?iso-8859-1?Q?iqk7zD0q2YKWXpt8fka0SktW3HcEedhdI4zmg5y1dl7WTnkeyLB1r3WaqJ?=
 =?iso-8859-1?Q?HOUp6iUC3x7UojlvdEIHk0/1C6V3pR7adPJHPFlfTceEBhPpt1erj5rsXL?=
 =?iso-8859-1?Q?RzjzxuFHbQz1wppgF76LXlBKmKVq8QTEiZ9nVNUMeQi4fP64DZD4DKEnoN?=
 =?iso-8859-1?Q?4MWhcD9AfT9zJLoETcYjxTEHApwNDfQvqPlKZlawKB/4+udq03ozYtht6s?=
 =?iso-8859-1?Q?c2QrsVcMKUcoYkVjuJDm61t1FOX685KhGzSjG7LcIZr0xAqujIfLMYYEoo?=
 =?iso-8859-1?Q?CdhoPGNBCH8Vzfgs80twxbzO1Lmo/vbapyecLwXkAT2ClzYBYRSU0ioN+l?=
 =?iso-8859-1?Q?xaX2mJhJiVlc2ZmFdkEiS5hJyCGbZhtUyrqHnDRZNgfp0tZ/Rm/rBlTDjb?=
 =?iso-8859-1?Q?nwenW7m2PjeCDZhKvbmhdReOKcZ631Pf/1KKJkow3x9CAaFZuF8Iv1VhrI?=
 =?iso-8859-1?Q?5OFrM6+RFG4xD0XW9bDROP+RuYs98IQ+u7AWUf3i0bIGE1PoLKv6LmUEdx?=
 =?iso-8859-1?Q?QQN3+jzXHuWE+IF6vkGOAAfvkXstYPEiT3rnZNWElCZ7K5TZgyZ3MEutxk?=
 =?iso-8859-1?Q?lp7G0ZWYLtJCXd3fMgF2a2f4t5IYw4tDdwDsI49mUnARye0Qt9BFGDBfTV?=
 =?iso-8859-1?Q?kVA9SM7z0cmZNT+3cRabcGJx/mo/K+7vlTm0RuRD4J5m1A8CTFukCt3sm6?=
 =?iso-8859-1?Q?AkWE+xov4n+UtSAujXbTfaD5aLl7LnbOWqH07A3CoUBnA7xRIzjput0E2a?=
 =?iso-8859-1?Q?ZnSJaQ6Nw3khVH1veS1CBTK5M6VXbcP0PihqkwwDFfq4XQ0pPtKM5C0bgg?=
 =?iso-8859-1?Q?gE4gp7PNjocgc7sV8+vUWzdcDTuu2RMTox3wUO8tAd/V5NWnngkFFo1Qf3?=
 =?iso-8859-1?Q?l+maKygjWt87pSTUxABC/ekevE02jB0Re6nmUq4Gea0aP6W8788aCP7Gsf?=
 =?iso-8859-1?Q?iUYZN4+tUf5LFA4Xi4PuI3raeK44Hnf35facqjW/Ao57oocKR9f1m4VjAJ?=
 =?iso-8859-1?Q?2Pbt5bjb87tx84rRj/aG0zNTZ3j9rF4bFu7Ys5MCCk+e4B64pw3dX0sVLN?=
 =?iso-8859-1?Q?of70iDd1rU7fOnQhD2ug2v2sNKoVI8mXBY4zrKGwNHa8N4C5tJmqr+yi56?=
 =?iso-8859-1?Q?aS9HZhdOObY+0rykAQvxiPDtd9qoKHpI5bd6myzZNSEZKBZwpjCUblWE6V?=
 =?iso-8859-1?Q?vpU2++8XNT6/1o+LbYQ9mHMjhJoqX2PAw7a8B6gBW7csS0IduOTTbvAKFy?=
 =?iso-8859-1?Q?orcVgbt/2p7HUYiLm12cONzSgtugjCkiJ3LyiuuBTxTbLMGtKauX5gRn7n?=
 =?iso-8859-1?Q?+PZivEhm9yurP8KnTWTl9IhFVSCkQgUrzr2KniEt0FGcDjrS0ax90G/Mqm?=
 =?iso-8859-1?Q?nZumgEnv51I4Hlyf39cPHUMivTp+rouI0UopYARTuo0AcUYZ1NI0TyI0QW?=
 =?iso-8859-1?Q?s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?K0hOhG2s1irDISizul35TvjxLWf7yGT/qtSb4jwOTsRvTNYtrD744zgtSM?=
 =?iso-8859-1?Q?9rowBM6aLwhvfqMTfJ2ppi5Dh1GfAhyN6W8gG1QOlnuzy0TNxz5HSsjTNN?=
 =?iso-8859-1?Q?r9cAGdpBB6ZWW1JlVe6tGP1F3mqLCE7mYH1Vcw5gfJIvha/vpXMEdqjLP2?=
 =?iso-8859-1?Q?ub7zyK4bd23kcMHRA+vJBsHl7g4pg8SGgKfBKgrW84WQ6DqycxDQOb/I9k?=
 =?iso-8859-1?Q?a6FBO55bcX2sVaKUxcOMlNe2CDcKOIJQEzeMSzoUfYvxarr1mZt6eayg46?=
 =?iso-8859-1?Q?Q/ljBY57N1uYhIhj3m/v6d1RMdz2r7O3qbMAU1NSmDnmBK4MOxjSGtFPsH?=
 =?iso-8859-1?Q?eWcseQI3o5pkEjBiM6Uqepw5LIUP98RiZjDaB1XoGCbRd6Zj5yuwuOPSV9?=
 =?iso-8859-1?Q?N10IwH578Gh0Fs0o/hlTjI9CJQfxxICIvuQp065HJiiIfmvKbAo7t1qc0c?=
 =?iso-8859-1?Q?KkOXMJfn6RVNMWpE4MiwRaVywGqCwxkW6ztdAOPTDTTWXsazkyUw7LG01b?=
 =?iso-8859-1?Q?Pjd9rmMCqenB5FzE6m0+X0kxYfOwSC4TeA8sbq8nx9mkSWDSanm0dWQyMu?=
 =?iso-8859-1?Q?9clLrIHDfMQtLXltvd8nJ9EFM7+P1JGyQhHu+htSWaM6CEQ0Oi3qudtzKR?=
 =?iso-8859-1?Q?hB226P7bqXyoZQv6zlnPhYyO9S7rwDOgoFiKnd7sSlGqmG63bavYuBNN9x?=
 =?iso-8859-1?Q?Fs6svaMg3AviMra5X6N+sGHepqqU/ptLnc9VGPVXjgjcLC1OGiPmLnARl/?=
 =?iso-8859-1?Q?utJmU4CS4JOwuFzNuy7kEOGP3UIwMUgYRoAfsA0a4F2GW9VgTlKzDJWxbx?=
 =?iso-8859-1?Q?+rB4Djzy3mZnCU3PHgSbuDIJreEtWvQjmYaMPzayj0lFBeU5rtY6dSQU9w?=
 =?iso-8859-1?Q?6w06OtcDNmUA9LdKEcP9P5oS54Jx+K8aClz86DMVPe9vtRh6HZWpW4XGl4?=
 =?iso-8859-1?Q?RDDk1BHisIK2PIXVBj9QzNYcnteAr9lw1bao5q7k5EbCY5QAN/uyB8ti6Z?=
 =?iso-8859-1?Q?LqhRW2X3s9sNPsnRD9ZX0+fnPoTkVeob2hRQYVi8kYsZGkmXM7MVhXWlyr?=
 =?iso-8859-1?Q?FkoUmXqbqkrr3RJVmfEh79MbOl8SgikfQ+yzHgefLiuwjQW7a5+z1vs3IY?=
 =?iso-8859-1?Q?TomKMl2fe03v2Dht7jHAjuDToxPN0B+m5aXVKOB7HC9bsBUlIJUvKw7kGW?=
 =?iso-8859-1?Q?DfhRXo9WdXJgkYECxT2hywDDCKciF6SCLByH3CQL2W5jPz8uQCpDQR800c?=
 =?iso-8859-1?Q?zMA+j+vADmvkMwgYFe3umLOq3xGgbkOHc5AQY+VdhqzOFIKRwm+COPF1EC?=
 =?iso-8859-1?Q?ubMTxy1Sfl7Q5/gVurY85P+dbL8bpYpWB+Pr+WqawWzFx6n5vejmtJ2dkL?=
 =?iso-8859-1?Q?CcQq4z5vlfe390xtcU5QYvtosaXIJPPAGO/iENWpV63yoPZGvMly2J/T6j?=
 =?iso-8859-1?Q?BI5eL2qo/yitPbwNcSU9dht91WbV3Lg0qIxQLtpw9kmUFGeO9wAYfWSMR7?=
 =?iso-8859-1?Q?f2yPWH/QK24vizMp+aLtABqe/usXAVzmVwLYpYtuxbL77Krn07imXcec1n?=
 =?iso-8859-1?Q?peYsUstaIf+Z6HENfygBM8pHnY0+UkPZR9fu36l2z6qHIAzss8g6cKK230?=
 =?iso-8859-1?Q?//IwwTDb55C+XkLCBq2hIWUlxVvRM/NsWgsMpQO8q075YqsmYWue8Umw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8057121b-b54c-4dfa-5bf0-08ddfc1d7bd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:22:52.0777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKunQ8fT8tPg6fjwwKm3QsNcsOV0LlFHxsQoHxgwSLpSulT9rr71w9aZBmzG+Icqv+b2Cl5KWj8FWlB0SkT7blKMBB2jw/Naabp9hU2eN7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
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

On Thu, Sep 25, 2025 at 12:17:27PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 25 September 2025 11.32
> > 
> > On Thu, Sep 25, 2025 at 10:42:47AM +0200, David Marchand wrote:
> > > Hello Bruce,
> > >
> > > On Thu, 25 Sept 2025 at 10:00, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
> > > > > A problem with the current headers check is that it relies on
> > > > > meson dependencies objects that come with their
> > include_directories
> > > > > directives, and all of those point at the library / driver
> > sources.
> > > > >
> > > > > This means that we won't detect a public header including a
> > private
> > > > > (as in, not exported) header, or a driver only header.
> > > > >
> > > > > To address this issue, a staging directory is added and every
> > header
> > > > > is copied to it.
> > > > >
> > > > > Drivers and library headers are staged to two different
> > directories
> > > > > and the check is updated accordingly.
> > > > >
> > > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > >
> > > > In general looks ok to me.
> > > > One small comment though - can we not have "staging" as a top-level
> > > > directory, but instead hide it inside the buildtools directory, or
> > even the
> > > > chkincs directory? I dislike having too many subdirectories
> > directly off
> > > > the root of the project, especially ones purely for internal
> > tooling.
> > >
> > > Well, at first I was trying to change the whole build process iow
> > rely
> > > only on the staging directory and remove all the include_directories:
> > > directives from the declare_dependency() objects.
> > > Libraries and apps were ok, but there were a *lot* of complications
> > > with drivers (what a *huge mess*, especially for NXP drivers with
> > > "compat.h" includes, and Marvell drivers to a smaller extent).
> > > I may retry in the future with some AI tool that will brute force
> > this :-).
> > >
> > > For now, I gave up but did not reconsider the location of the staging
> > part.
> > > Moving to buildtools is indeed saner as it is only for the check now,
> > > and I can also make this staging stuff dependent on the
> > check_includes
> > > option now.
> > >
> > 
> > I wonder should we just consider making chkincs an install-time job
> > rather
> > than a build-time one? We could look to build chkincs using a custom
> > install script (meson.add_install_script) after the header copies are
> > already done for us. That should cut down on the complexity within the
> > build system, but it does mean an additional install step to a
> > temporary
> > directory to get it to run. However, for use in our CI I don't see why
> > having an install step with DEST_DIR set to /tmp shouldn't be feasible.
> 
> Such a temporary directory should be local to the developer's working directory.
> (The CI might have different needs; that's not what I'm commenting.)
> 
> Furthermore, test building for upstreaming should remain simple. I use something like:
> meson setup -Dplatform=generic -Dcheck_includes=true build
> ninja -C build
> 
Build testing for upstreaming should really be done using
test-meson-builds.sh to test a variety of scenarios and cross-compilation -
including 32-bit - if possible. That script also does a test install, so
running the check_includes from the install step would be automatically
covered there.

/Bruce

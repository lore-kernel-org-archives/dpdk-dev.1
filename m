Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8EACAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:27:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A411402C1;
	Fri, 19 Sep 2025 10:27:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 971C8402C1
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758270428; x=1789806428;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=wnxyJ2AEE7m/Awh2WKs4wp+7aKyrNfedTR1wHUxFoxk=;
 b=OkIaruJGNIhTdYNQ6Sn1G/vhnV8ShVA8fM/P9p5LnhiecEei2n9Kr1Ii
 mUTkKzUHJ47EzyLUKYFsgBlHP8jQYLODbd4kfYVxb4Jnt4/qHjAGez6Wy
 LOxu4x5f1a10s86NubJqJ2sM2hBee29r85RTgjfz/R5NVKVPV6EyDULU/
 Dg8uXoWAhVERBpBUcO/HZk8/8NYxPECOd5HrFVygXpDx3/xEU/OKGVWD8
 sKoYIERctiD639zcMQacozW4+gpQVkynCplPvBcMuD/00mgWhEzY1pCKd
 TjgsbjcifglmmDGavnG9veiXv3lPP2g3KxcUrGt1XW+7VhMWKRiwVJtDl Q==;
X-CSE-ConnectionGUID: yfX/Z2ZkQt6WHpfuwNwpVA==
X-CSE-MsgGUID: janyA7FQQIOoyFiR9jTGGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64435668"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="64435668"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 01:27:07 -0700
X-CSE-ConnectionGUID: ctdGSpb6RHullbW82AisWQ==
X-CSE-MsgGUID: BcbBfkjlQEy3IJPAN4sXUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="212933207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 01:27:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:27:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 01:27:07 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqKNZ66EfLncNPuoF1HohSmL0vLCnMSyxt6kAj9pKs6tTLD4QBX/DUr6V/4PULkhaxSdNvPHFiN9wUyNBiOCGHRl99Oh1eLWL+aXuJ0mpklkjanN2JkFzFkujahVw1d6akvBJTV52jZgcZFQl2RmqVz9DmsvphbDXH52ygvl2JDIStC/G3vwI0NfKnxYNve9YUZ37m/KWnUJutbwpEvt8zGiDcrC+ihp+5qKWtLFFi8APEr/LvLgjv5hkpuUksaNecBJF+jml3weg7MBdy5xCSYBAMexPvEF9385dk32CXlHso3lyJQvcxG3lFwuAlZTJWCEqHSeNOuSITZETCu+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riUbYkwpGOypZR5O57nWpdtD0wb5Zzrz1All5xBmGLg=;
 b=jCHzeGlkYUd+5C+RvunAcQRDCqzlkwX3hPasMaHaz9r8BYoZDdGJABgsuCAHsy3xlqMNMtGLuSwXrpWmGFE8iS7ygD/aBoRBOy8FBXD+m2Sr2yEu+9MgtO91lk5eq1FX0/V7og+VmcWRUwbaXUvlJkQO9xBDG019oAh6wDo62q2kyavbpvHR9fy1rXsOUDKl7ZZX8KxmKeP16JO4G/fi6mfSjL0ZMoyaWY2RIwuGWK0jRtW2LSGdIU9onrGFuRCpoZNzjNXfISBx3ORW+K76RZWqpdv+PLwkpxKM1SnWuFHCv8ZDVSVplffrPLoxprnyBxlBSrXAYcZJ22Ili9S2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFF8C186950.namprd11.prod.outlook.com (2603:10b6:518:1::d62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 08:26:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:26:59 +0000
Date: Fri, 19 Sep 2025 09:26:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH] build: remove deprecated kmods option
Message-ID: <aM0Tzo_KPN3B43Ql@bricha3-mobl1.ger.corp.intel.com>
References: <20250919075733.221023-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919075733.221023-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFF8C186950:EE_
X-MS-Office365-Filtering-Correlation-Id: 6576eab0-e530-4d4c-7422-08ddf7564d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sC3EhwEMrjdhZlkj+aOBq9QumF0WgGuMyhOEG0mVD+9OKYYHGz8Y+SXkg0ys?=
 =?us-ascii?Q?001VeGEIYBdsspry6ZsWZCNx6KbuFJH8KQawfgALeLlbkUfLCumx9w/fnd8K?=
 =?us-ascii?Q?t+hQAsIJgdm0ERY3eJwFgOeys/VayS50bG3P7r2ZCdGtaiLrp0NgRXIkNMMV?=
 =?us-ascii?Q?oV/QTsZmrtxKOg6yWJA0KE0MT3g7Tw5xikoJ3Xw9CsBon2rAeG2x8JblEO3p?=
 =?us-ascii?Q?2vqoYg9MNVFnA+IXIAt1Bbw6Lvbz/9tz91mAXwRy5t858seotWLs1Ks41IiM?=
 =?us-ascii?Q?jYk/zNuyi0lMiW2sFgOHqpilrC25DyywQnWHJbAD1XVK+NkCmU0w8beC95D0?=
 =?us-ascii?Q?IsyyyaNA8EUnQDkTBWw6iIW/hnJC/+DNdW8LwDjBvdcnE/RoyTmjBxQPmizx?=
 =?us-ascii?Q?rcVurELBmsb4sN3U9xdHZWqXtm37752nVSe8TdVxC8j8PaX+/1iM3tly+VGH?=
 =?us-ascii?Q?jvUIKgxaSsn0r5MSNF/HIqekG9H8lcdy/5t64qRSQG9l5Q/XMMx64LEGKIZp?=
 =?us-ascii?Q?t5i70rjoXWG1Kxzdkhv+U1StpFH7/SQ2EVCUbRvW8r3ZFBxc0H33S2tVWQzA?=
 =?us-ascii?Q?IVOGbXdjEX23yn2rqT5WT6+I00YmjIUdqMNz2IIFtObg8o76d4PPFv0VWO2p?=
 =?us-ascii?Q?CzUIdMg62U/PG/FVkjvnBaLkiQtxBUs+qvtRPUcZXuC42XBjVhSGUesoqWoC?=
 =?us-ascii?Q?pgcQHTXHv4TLEux/9+yd7po0zHkBQ83PPuUqD5bel8yZIMATKlYEZNtc3Hn3?=
 =?us-ascii?Q?wrFbzeuDkALc14jKzrEafqbY9xOxpTb9ZW7fZI1dTYpi0naJlzlRT3k/z1pv?=
 =?us-ascii?Q?ukucMivf2lb79y9v6x84N/5UL5gOaYb1Jo4Y1/2GPCtHtpa1HKZswoxXxGof?=
 =?us-ascii?Q?HJkISUVgLt9uZUuMoxJqgQEiXO7BjVcKoeBmZx24SGP0KTeQ5CDb6C6n8/Ag?=
 =?us-ascii?Q?V5u4LHO7bMmxdylVfx7TaRyKtQbdQHwa3TQ3Y26UmJhdsEzZBBWmFHN4MkYf?=
 =?us-ascii?Q?HwvT+1wDIXqsjKvuf0yQUxeRYGw6UbxAB6+cgsQXVNWrMvtJObI2ce3SB8Cl?=
 =?us-ascii?Q?AH11PN6ZdS9KW2TUHQYQ3okehmo8XkHvdDXHrqo5tPusbEkd3JZ2RDXMJN4C?=
 =?us-ascii?Q?x5KoE+s4nRPUR0V5d+U4P46IhmGJbz1qptiu+uwCaQ1EC7/WeTDGNKL9btov?=
 =?us-ascii?Q?6+oAxm6Ld2P/K4Z8MOGEE57gzYarMwegJXH9DqzVg+GYdVHldAB7sX67ulA3?=
 =?us-ascii?Q?XjxjLMKZNWjo+bl1C362w6XqxSusOAbx8548DqlA3nG55q6sI+PYSfq1svLb?=
 =?us-ascii?Q?e7qR9yx0+BxEPGVVF3seaqgug8JYwRSVgYAQW57VjBquhhfeZbNq3Hiy9WY3?=
 =?us-ascii?Q?x48g5yM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u95OIaB3UQvSg5Pof4cOOFhWh6EY1TPdyiPzysZ4aFRXCN/d09skVW/9Q9zP?=
 =?us-ascii?Q?tCbRQLbWC64bvKpfWwB+zXvqYgFq1TQIop6aqFtgrYLrDviEnWtyQ7WEY/aI?=
 =?us-ascii?Q?//5WFkHVSAMWZdI+wzwIlKgW0LUViwvCf1lJR88JZV/RNnXfXEw+z/5OBPJ2?=
 =?us-ascii?Q?GWzpjb4A2DKVAAMJaYAPY7giTQ9CXJBIHWz1o5py/RKZZfMqZ9EtTZVFxMsu?=
 =?us-ascii?Q?FHdnd1GCMR9TyqXQTsnSUR6yPg6yryWQXGjRuLAocsKWyRNQFAHtgR3qv4pY?=
 =?us-ascii?Q?+/xkaC7bB9h9yj60SbQWyTLKdvxVej+IaNsbyYLKPYpm0wcmBR+F+IHz4rtx?=
 =?us-ascii?Q?EU6fIzqhr6CpDumIcSQdHiKDlGQvCG6H84wCbZ7BPxEAARRYozrblKDK/4CA?=
 =?us-ascii?Q?QQ0l4hhNFyGyq29/k948no1RZVwAVF6aRWCH+/aVAsgXjg2um0IN5fm5/Ibo?=
 =?us-ascii?Q?cy96uWcBaPW/mSTSFJiBULT8XjlPovv1KwZDl6SJBe1R2+ODdS28Iwqxm4ho?=
 =?us-ascii?Q?ctjF2s+0guIVbf+UtfwztPIMQF+8+K8euy/DrW4XTwPqT2/jbIIqa1HEdIhc?=
 =?us-ascii?Q?zksKTfXzkIvpkentmuWig2k3J+0yJejeEp5yUSU9RAL0ldE0+RF0AnyYiNV9?=
 =?us-ascii?Q?PMg4aR5XjrskbH44rL619L2WLMBk3AvPsXmpazhd1/ZdgEhNs9Zm0AYhIkNf?=
 =?us-ascii?Q?5gu0Vu/YUYlXaxDgWemCBR7UchwUqLiuXtlSWcJw7E7NVq4TRGnkPKcPew0j?=
 =?us-ascii?Q?c3iROlqku/mCddeQ+0ztF69ro7OKg6zlRsj6TaIdVGkhq88gzHVlwAws48PH?=
 =?us-ascii?Q?lS3PApCVDWasWr9sSISKrRkzOVKIt1ngWXYel9mZ/ArsvogZb/MkWimzVB9d?=
 =?us-ascii?Q?iKvAeRs6mhLR4+ZWnC+Glaz5KasIqdbsO/kxvNl244DdxJgnu3up0MiZfnkH?=
 =?us-ascii?Q?+qyjpc/Wm7yFqz7C2tO7pk6R+OyztROM0quXzqOAwLL829Aannt0V/7cJ2t1?=
 =?us-ascii?Q?QSyakR79bJQZqxw1mKGJ9n16CymV/4432r4mQHc/q1IsMxfzi1JlmnH/n2Gp?=
 =?us-ascii?Q?RgCOYS8T3b8SEQZPu6lZjocd5Q4CBhItGtNOoAWEaEmZH4LiNsvgw83dizRe?=
 =?us-ascii?Q?+21oxFeD4ViQdD9jtvd7mhldDYQb+qdndlDA+qAYfBdSZXRCVlGpVq+FsBRB?=
 =?us-ascii?Q?BJV9SJ5/H76+ufUL5VSP48ylGwSP/5olW8WGUkm/Rq4XK3nrjQiFW59BZkLx?=
 =?us-ascii?Q?eKxliGCN4UHmiMxaKcA/cvAO18QY7Esoa4/2wlQe+mTfs5LZJgLdWe9KLVmx?=
 =?us-ascii?Q?uYKUrKO/yhex3DmZwHWNR/jqQNtlRFmx+npxb+YN0+MXwkdR5frJzZMAHn2l?=
 =?us-ascii?Q?DXl7rhu1bhgCCslAym+ifDNusxe5mxxeXrrpT0nLhIBD6dvKf91q9Obj/Afp?=
 =?us-ascii?Q?/mDNLMiYzNRjUuIyCXE7XQVbdaBGOxY8R1toP/rPj0QEJsMh3cT8jrwsiU8h?=
 =?us-ascii?Q?TDT7YGepKvWXer0hgXMCBbsNi4u9n+Djmv1R8WObQw34FZaAPcM+x2IgjBe+?=
 =?us-ascii?Q?shLi/GjNOrJF8Q6gj33/ov/1hFr5SM217GBL2LOLDwueb4CMA+OyJy68LnXr?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6576eab0-e530-4d4c-7422-08ddf7564d53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:26:59.4450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nufh4sXHcmGIUHz3zABehxPvvGF/qsBnLYqNzPymV+dDQA2eq8jsBVbBs+pPCEfTRg5L4bZMpilyA9owLvhBEFAzc8C1xf3bG7jGBVOUvWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF8C186950
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

On Fri, Sep 19, 2025 at 08:57:33AM +0100, Bruce Richardson wrote:
> The "enable_kmods" meson option was deprecated back in 2023[1], so can
> now be removed from DPDK.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> [1] https://doc.dpdk.org/guides-23.11/rel_notes/deprecation.html
> ---
>  doc/guides/rel_notes/deprecation.rst | 7 -------
>  meson_options.txt                    | 2 --
>  2 files changed, 9 deletions(-)
> 
Self-NAK. Missed some cleanup on this. Will do a V2.

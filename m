Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D74CE8D4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 15:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FEF44068E;
	Fri, 14 Nov 2025 16:49:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 11C9A40151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 16:49:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763135356; x=1794671356;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5h/ydc30sU44g0i+chhaQgqcGUWCKhh8TEhJpJHtLwo=;
 b=H7zaT/wVqg940TloaXZJ6lHxsqXKkDa8A9zjntkzB1I8mR39uZCVoW0h
 xcLYoswHs7pknpO4hDliKYk006+Ew9lR4PW5ONYsfAiGjsoVAxl/Si6T8
 JKRrhVEDhv178haWy+9KfJrmyeFmuKV7IyW/DerEYJW1YmR+Biy+A1uKH
 QWtJGOEd3OmfUDxS0Cvu1qDZfiIZZADBPbKaYzHhtB4zM0u6ALIJR2WgX
 pW8gqBTi/MtvrFEgUTxbZ5I2zXl+xKn2F2JaESfYHv/BPApx23jb/2Wwr
 TPikOF0ECCWQVqySzRicKYTLuZ+6ijWEQuJeob8F56EWDE13XZDjMlnmV g==;
X-CSE-ConnectionGUID: sbRKhLd9SkeBzbyRk9w5vQ==
X-CSE-MsgGUID: BKfifm5PSE200KgLZwcWmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="65133808"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="65133808"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 07:49:15 -0800
X-CSE-ConnectionGUID: GVITiO1vSl+zFvITtnVKrg==
X-CSE-MsgGUID: GPkpw60FRX2jT0V8T/KyRA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 07:49:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 07:49:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 07:49:14 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 07:49:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN2awaOriD7PH9xicOo5MUNPsIFdkoFJibfqgFz/llLkZoRPSx7Oej+ZlDr0J2TohkWe7tjNSFl1X2A4j7SPmxC8QNT2RcBaJOx/SYYhE0Wu1/BD7e5Lm/8KLEEpJ/GRm9dRWGZV7u+6BWaJbVdqCSsQ57OIcxl4YJubcOvT4sG9gRH41+0PvUrRuqiwQPLEdECdzVrO+p7lhnNVzECXBjg4kiazQvke1v3Ha2+cei7tUJ7I5x0OhsXz1J5Qv1YL7bwsdAYBtm5CIkQAMVBs7/G5n9jgJmFSKR51OBl7jFemukICw2MzXJ5fW9WPJygDMZrDBVtdCBuXCqVeUM0bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p4Z94Y90QByzTYb2uqG6pZZ2fAc1NhyfNU2cKYnFw4=;
 b=FVgwKmt8VRX13PBNQWNZfVtZ7C6y5Zn0aPpA9/h8EK3p0rE4Z0gyi0lJhkZ5aGe4yv4xdnnWwXlfNcGJdC3wn/OGaWEdveO445wWC2Vg4xLyH0w9tn82jLyPkloYQm9K0l4R+Y4gNZRz2I4R+R/dk8Q4Fa7yF9sf1fF3OOZ+h7QFk/SkFS/nTrHBAbVd/BEL0zNB3eFgQ5u1A7QgcV3Tt8SbBd4b+ZWX/G+OAGs0utA6nK2hyJ0u+KLNlgEwRrE9ftY5ngmxYOZdoLMmUDBxEE/MENog2GMvx3p6ztoYt61RzpqDIxqXnFvFzNTrk4fQC0HMsUQwEV1og0Vfp4PzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 15:49:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:49:11 +0000
Date: Fri, 14 Nov 2025 15:49:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Jasvinder Singh
 <jasvinder.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Message-ID: <aRdPcuSLTPah6Zry@bricha3-mobl1.ger.corp.intel.com>
References: <20251011113202.937991-1-16567adigashreesh@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251011113202.937991-1-16567adigashreesh@gmail.com>
X-ClientProxiedBy: DU2PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:10:232::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc7e34f-3806-4351-45f1-08de23955a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+/kvRJMmFIoREbNPAkAeL1cpaWQh6DDJGQPajRLS8V7rXDg1v/rwd/9h+Y2i?=
 =?us-ascii?Q?Po7JTlp3Cgkcav+Lb+F00NJMwDDbtV0BkQq1Pq9pxqo9xp9RZX+HsN5g1AZH?=
 =?us-ascii?Q?Y8PSF7+6j37t7dil35hcpo6zgCWycnKlbRcNrmyWu2OCzi0R8imCx8GkhOeA?=
 =?us-ascii?Q?IXUI/MxhDrWeHj0LaGRlSH4kNrC24jUKi1cKtpJalmqG3dpnfZsg+w+XIoPx?=
 =?us-ascii?Q?jaxIqkdizgV3rdHImVda/B/Jm7FRy1YEBfJz4LDmx8vVRDfkrf+Wi0CVwZ6D?=
 =?us-ascii?Q?JkuoGd+/z8QxE7hiOElpxFupG2giYhZilPJ9ryyHvAL9tZxm6nXcbzgTpn1w?=
 =?us-ascii?Q?YWH3s+g/eyIZS0Mi6MbywKfKKq/g4lzrUZHYaHBtqrIe6diYsw8ID8Y9zp0b?=
 =?us-ascii?Q?xbey6wofH6+yrDnNwbvUZfgBBE1vWWXTGb/bBA4vUcvB43bXmzWufhyYL5Fv?=
 =?us-ascii?Q?PNp8mz82H4su9ByQGf2uQ3sbrDd7gS6DrwrLFo/k2uL5mWgbrxUD7prUP6D4?=
 =?us-ascii?Q?pAkiUuelxRv05GaaBUekTTPEzOQeyh4tpYavbW3OoiMNOMQJAMBIGYWbQgz0?=
 =?us-ascii?Q?YPCB9gXLh/Fl9UFO/33OOPw/RFbxro11vB9kXa4Nd5HxQeN12d54HnUYWtV9?=
 =?us-ascii?Q?Nb5gyIAckR1YyX2LLZmDkUxP5luujsBSvzfI8qg9aDu0bMeUPh6R9LQqiGo+?=
 =?us-ascii?Q?U+wvGnZhu+qzd+cm93bFQPJQP3R5641P5tzfwlC/ofqtXFC8+hDJVa2wxvT2?=
 =?us-ascii?Q?gzeNsD8bEDEiiGN9qbM4bkGNDCLQIhe9LEkV0duDwghaVE9RX0OtWQ+tr6G9?=
 =?us-ascii?Q?co5HUq5E5YxPcHiYvB/qJ/BvdEbXWZZFxa4pRVNt0Biof4PsdAKNsG95+wYS?=
 =?us-ascii?Q?wjxR8moE1Hhg2xvOoIwD4mX99EPOYEeT9uYTaOk1sgO1BXsJPBBBplmFYACl?=
 =?us-ascii?Q?DCc2tcGGls+LY6gBW8GTV0f5cXHNyUZls2JZ1L8k6h89HkPenmzpaYQl8rBT?=
 =?us-ascii?Q?c9ZCv8JtT9p9eVkwprQvKBwo/qRsABnRAkQU9egg+EA7THub8ioL2my6PC9c?=
 =?us-ascii?Q?IRWlwvlWaRrxxC1mZqk65MuVDDKrmG9io5ACsYWKAj1fDCGLqac4Ex7kyyZ8?=
 =?us-ascii?Q?2PqwNEbEQhwqRQ4a4jbcaiM5mBQ2VLDWkycwgbxDJ8TWi/v70WRpwwWztu1s?=
 =?us-ascii?Q?gC9scYY7f9qPvmmnmVyj1tuowoZ6FSeJXXBKupLcIM+eNkJmovn/MPm1IcPJ?=
 =?us-ascii?Q?XmVqjPAen3h38TwGKIM4HPHKSiHh/lL/75T6cYWYBjJrb4zpg9qePl1XmaJb?=
 =?us-ascii?Q?33W7ontwCrcUYWUl7OogRCzXuU9j3goamJ7KsoZr9dJjTSUA0gBYLr4jjx2C?=
 =?us-ascii?Q?x+XkHm8C0sXc/BYOLKHP+TdqLoTCofMz0qmpPF7UxrO9Ocg1/KKCq0tYJ9+X?=
 =?us-ascii?Q?do8H3r1r+yYcb0eJgMkiRELLwMKfhTrI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBaZztgivdGb3mscNaq+6e/hSD0SJzs4WYAkfLff4foE9IFb/YwOVUlwi/hc?=
 =?us-ascii?Q?DYMVMFoQAREu/2M4YdcB/3zYsEXoiAAmIOPNTwqQYTsush2+U2lcQ3lPNFye?=
 =?us-ascii?Q?4zAmmyPjKqJWoZRscPzo7+vHJ4CHXfgQCBPSlJ9Tnz3CwbgmMrLaMh7ceW4v?=
 =?us-ascii?Q?2clIDylL0AqYcoSzetRjm0ju1H9M3FxFOcsJgdMfK04yfSZCTtnmK7+N40XL?=
 =?us-ascii?Q?kOpIfG4GQRqYynfrKKLg/sAovy3B4M/MohiZpxIvvOD/RQJ3sC11LypMMl2i?=
 =?us-ascii?Q?ruX1Cf/ufBVyO+dj0UFx56hnuOcYTka3g4Kp052EPs8ZvgyT0GWMhkHVLlu3?=
 =?us-ascii?Q?DG9fUxxAXAm1Etg0fNYkkPQ3rJgIajQ27uAolFWQiakhHemQ/nMlFxCDBe9T?=
 =?us-ascii?Q?6WtNhPYxf/9+vBW51A6/aiy3UwK/dlH2KNiJSw4AW6FejLbUFRW0llNXM0+w?=
 =?us-ascii?Q?FHAU2XIZiZ7HIDl7v/p0AWp7jzqoo2fWMg0qIfSikJtnxJEGDXzZUApT1Urz?=
 =?us-ascii?Q?AsH5JxD9n+C9orN2B7szJltMraPbXRZpnsuFJ7BxOJjGtWU/zhTLEAzCWUvn?=
 =?us-ascii?Q?YBPFFrcr81C/ccVg8tnud181NS6jLz4E3+f1J9Lr7+v564Pn4D7VcIjMC++Z?=
 =?us-ascii?Q?TeM/XpgTD9KHPkc85/Ok+e7lu6cg9y9nu2a3kVXD1XZmHmplXlBaBPOb/VOY?=
 =?us-ascii?Q?QF8twrFRVB9W0umAAJVGLVjul3DSuK0/6P70BnXLMuzv0EEI/YdHQNqCjBvE?=
 =?us-ascii?Q?exp0mN69vRIr/n/XbYfC9LhBIfHcXue4/UGTu+m3J2/Pw+1ssOZurBEpPgw1?=
 =?us-ascii?Q?TnH83lF/PJLW8ZF2FSILXnyjK/7xqjSe2C1CHg13qB6XPSmaCx3oPxvf3GUG?=
 =?us-ascii?Q?KXd0FBz+9Dio9S1azGtMGJZLQHhGGrwP46nQzzAB1UPA4SjZuX0RPPICp+zN?=
 =?us-ascii?Q?ItxtATxOGq0EUIOzrrgiAXComyIhx+DtRsQiccUTVd6R9YPyaIfHR1HE/ei4?=
 =?us-ascii?Q?Gm3m+2O/BbHQwlJGbZ0UZtU+MxBrJQlzNZqJ/sx7m9Vlre/JW74IBhoTESLD?=
 =?us-ascii?Q?U1zOVyVkJ0twp6mkCFc7SxefeZkmQc+UAK3jKCSFsge02LXKsTFptit9mvK3?=
 =?us-ascii?Q?Yb9tT8DQvakdh0Lk2idZVyUzqF34XYwVW+MDS9frOoii9gnGVdlUNGALUMMn?=
 =?us-ascii?Q?2IorOkqj+abaemS01qvKJ1JeoW8U4aCGCY9rF5R1/ORD572EemBhflr1jGig?=
 =?us-ascii?Q?MgV5u3liWzrlZ/T3ZfAsoKdojhXLyoDwk4S58UziK/P3wnA88wMH05bbIKcM?=
 =?us-ascii?Q?1odOxW/qmppfjPJcGAlB9nZjKrhb46KrUCFtQNSYlG4HbWZQGV/gk+vyPBr+?=
 =?us-ascii?Q?HKq9B4wvKOteSamatX1zoQ+HyVbrKf7VzQG554+vPnKuJTZLYz6h8t3Bv6Et?=
 =?us-ascii?Q?RSuBhn3y9Ok/7kcgEUZZxRghHISksmoYqcjCFc53W3/hEXVP5AcfmN2YngC2?=
 =?us-ascii?Q?KqYFAAaxfwAajMvnxc1ckXh/EYEYhCuI8TVkbGxctZKBENConuswNJEJWHHm?=
 =?us-ascii?Q?d1umKHdbiuT88b/6y5JdiYhMXW3tJFXiXCXBcwKy6DEqXAZ2tynhY9FtAWjy?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc7e34f-3806-4351-45f1-08de23955a5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:49:10.9187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4BYxCNvT/OjyPlEAT5a98vog7D4v4qUCkIEpUc51M7pJf6jc3xXILni/69pUQwPTC2rVoVDQt/YugHXIb9fjuEQo7+pOWYrhEUr+MMmAqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
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

On Sat, Oct 11, 2025 at 04:59:34PM +0530, Shreesh Adiga wrote:
> Replace the clearing of lower 32 bits of XMM register with blend of
> zero register.
> Remove the clearing of upper 64 bits of tmp1 as it is redundant.
> tmp1 after clearing upper bits was being xor with tmp2 before the
> bits 96:65 from tmp2 were returned. The xor operation of bits 96:65
> remains unchanged due to tmp1 having bits 96:64 cleared to 0.
> After removing the xor operation, the clearing of upper 64 bits of tmp1
> becomes redundant and hence can be removed.
> Clang is able to optimize away the AND + memory operand with the
> above sequence, however GCC is still emitting the code for AND with
> memory operands which is being explicitly eliminated here.
> 
> Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> shf_table which is 32 bytes, achieving the same functionality.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---

Sorry for delay in getting back to look at the second version of this. The
explanation, given in reponse to questions of v1, of the second set of
changes in this makes sense.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Ideally, this patch should have been sent in reponse to v1 to keep the
thread together. Also, I think this would be better split into two patches,
one for the reduce64_to_32 change and another for the shift table change.
That way, you could include the fuller explanation of the second change in
the commit log to make easier review.

> Changes since v1:
> Reversed the operands in the blend operation for readability.
> Removed tmp1 operations that are not affecting the result and hence
> avoid clearing the upper 64 bits for tmp1.
> 
>  lib/net/net_crc_sse.c | 30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
> index 112dc94ac1..e590aeb5ac 100644
> --- a/lib/net/net_crc_sse.c
> +++ b/lib/net/net_crc_sse.c
> @@ -96,35 +96,24 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i precomp)
>  static __rte_always_inline uint32_t
>  crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
>  {
> -	static const alignas(16) uint32_t mask1[4] = {
> -		0xffffffff, 0xffffffff, 0x00000000, 0x00000000
> -	};
> -
> -	static const alignas(16) uint32_t mask2[4] = {
> -		0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
> -	};
>  	__m128i tmp0, tmp1, tmp2;
> 
> -	tmp0 = _mm_and_si128(data64, _mm_load_si128((const __m128i *)mask2));
> +	tmp0 = _mm_blend_epi16(data64, _mm_setzero_si128(), 0x3);
> 
>  	tmp1 = _mm_clmulepi64_si128(tmp0, precomp, 0x00);
>  	tmp1 = _mm_xor_si128(tmp1, tmp0);
> -	tmp1 = _mm_and_si128(tmp1, _mm_load_si128((const __m128i *)mask1));
> 
>  	tmp2 = _mm_clmulepi64_si128(tmp1, precomp, 0x10);
> -	tmp2 = _mm_xor_si128(tmp2, tmp1);
>  	tmp2 = _mm_xor_si128(tmp2, tmp0);
> 
>  	return _mm_extract_epi32(tmp2, 2);
>  }
> 
> -static const alignas(16) uint8_t crc_xmm_shift_tab[48] = {
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +static const alignas(16) uint8_t crc_xmm_shift_tab[32] = {
> +	0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
> +	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
>  	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> -	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> -	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
>  };
> 
>  /**
> @@ -216,19 +205,12 @@ crc32_eth_calc_pclmulqdq(
>  			0x80808080, 0x80808080, 0x80808080, 0x80808080
>  		};
> 
> -		const alignas(16) uint8_t shf_table[32] = {
> -			0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
> -			0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
> -			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> -			0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
> -		};
> -
>  		__m128i last16, a, b;
> 
>  		last16 = _mm_loadu_si128((const __m128i *)&data[data_len - 16]);
> 
>  		temp = _mm_loadu_si128((const __m128i *)
> -			&shf_table[data_len & 15]);
> +			&crc_xmm_shift_tab[data_len & 15]);
>  		a = _mm_shuffle_epi8(fold, temp);
> 
>  		temp = _mm_xor_si128(temp,
> --
> 2.49.1
> 

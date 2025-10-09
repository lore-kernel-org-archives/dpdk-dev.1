Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EA8CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 17:15:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C74FC402A0;
	Thu,  9 Oct 2025 19:15:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id CD13340267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 19:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760030123; x=1791566123;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+sKYXHgHdwUTXdjoO+7022oEIjd0jVimKErBLNVMk1s=;
 b=h0TX5hdJ2QiZu8ciuPVQT9OeohHgWHLLn5UFh5g6/+p9+plY1hpZyIZF
 +OMjdyMPJ0Yt26mm2R0GkoTZGM9MiRqKb2fd4LtBIFE6X7VtOTjvnIGCs
 jXm3ziCB2Ezpc6VyvW+rUjUePM5KYRPKey7DLUhuGGNclQbDKU00qF0cM
 k/AMlOesIfOWmo0cYxQY6zxPM6uPj2cOPAmV16bWWRi2ODPaNfog/pXEp
 YKs1aOMSPxAz1i9/ai3R0q2l2MYUZkm3NETzMeqN81QzZLdPwliBHh/lP
 wqdOkq4w5xLscHfpNAwGE9U7dksnpApif/JOxrimKmn6/YggOnEBTwrbj w==;
X-CSE-ConnectionGUID: aMtWfk04TLy+EbhxqzoOlg==
X-CSE-MsgGUID: RymiRN0FSLOIGzIZMVHcTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72860014"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="72860014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 10:15:21 -0700
X-CSE-ConnectionGUID: Msgetls8RYyFzIwuEE89PQ==
X-CSE-MsgGUID: +WN1wjyWTtaHiCSRykjAvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="185016801"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 10:15:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 10:15:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 10:15:21 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 10:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsFzmQPQuvXufdwR4gAwwCznYEm62QYzkJjkGUKSI6QJjkjD4c5bUpT0CGbLbdmlyq/rn2kzHUEJW+V+/4C5PU9dYzhj+opT13jK30WtNM6qGjy7/RNH2ldZ1NoeuirxV4cL+ZIybTRXEWB020ansDjrsN5EuzrIZmSVJ6f2Gs8m0uPR9osHBYVynj9xJ4NsqzDAUm3MYZjq7WnD+yOOrkapvw95usi2PGoj3MzDXlssHiZk15y9ACaXyZSfmi2+3DE2kd/cuKD17u5TvC/tId1oPCc/gIk1KlCYUqGGq4HZhDXz7NKYTnn8IRZ32q4Yuz5znLpz7h0fkEo64eO3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ocqq0QcW9FJE/XIeolm/kxXPa1pB97EIu29CevvDGYU=;
 b=tEK0zdxINwfufWyhWUVdLNSGxI8ZSK7TxvXWHq53/3kC2I/KrkyDu3XMfZq35uiiTyEIONq/7lTEQyUjBCG4WyvpnQEZtp97nEpKI5y9CMSG5+BLNooWgN3GR8ILvgRoQMGWbSJTDHEsXWVOYbBVmL4bSxAmuL9FTOOP429Yrqk9s1H0gH4a0IZ+1yB8z2wMDxkOPpSwSq2rP3A+YpZmmv4aQLsaIYo4vuNtiKgPumkGnY2oV6yEcKNbbXm5tQyG9yABvxrOUWMIAOEKY8B723DSjsX5xwEkOBVm6J3s5281VuIanIAts2SCOfSAyMpRmHsXePaeGUIt3p0FO+OHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 17:15:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 17:15:18 +0000
Date: Thu, 9 Oct 2025 18:15:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Message-ID: <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250823063002.24326-4-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0331.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 19954f1f-fc35-4b47-458b-08de07576b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lQ6TVMchJV7mCntHymJDwn16jUdSDKU5KiOqfr2BBPv3U+UkoVTrxkCCvm?=
 =?iso-8859-1?Q?kpJgarhsJm4XfSn2KxJgEyKiC/ZUa7hjChse5Ez+nn4+kBVvyDzmVP2Ub9?=
 =?iso-8859-1?Q?FJI9un7PzycKQEmbjDuv0oMBNqszNUMs4PpufKhYskktfC3jV6OzwouEPp?=
 =?iso-8859-1?Q?3JRx1XLWXmSP5JbzivA3cBsZYrC63hixNLn5BCiC5iYZhBc5UMDZkrGaQE?=
 =?iso-8859-1?Q?pnVV3H9Y6Z6R9C3GU5YXMF+fW3ioo6+cPzummC6b+evaS07QfC+s7aAj+A?=
 =?iso-8859-1?Q?AfuGJh8aH7HKcTPzVZ+GFkXhHYxUqMO7p8Ng2Q0610ztVGFPm8JSVs024W?=
 =?iso-8859-1?Q?yio9Z5xmsBu4ybwZvo6y1G+OhkNjtlGKEYWUJBTI2AI5UzGAmLT9Lbi1VK?=
 =?iso-8859-1?Q?DIcT641TICH9Hib6OykXuWdYpVm6AnWpLYk1Y2jFYutr/7M0Ag0odL0kNm?=
 =?iso-8859-1?Q?y2oKU+OIIwkO7RJfP9if7WaruDuBdrtJhusMy7BkF6jt4P7dhlPGQ1GNBQ?=
 =?iso-8859-1?Q?G5jHbC9qsE1oxamaxp7VnHB3CUkf8WUcqncmIyJd8DJuWxZpGUfrLM9he9?=
 =?iso-8859-1?Q?lPFZ35ycG0jx5e9NVFsJwV89u/hVPmVPppdCBiiygF9D82dQzpUCbehfad?=
 =?iso-8859-1?Q?fIhqkmQiz8mENah7/qmf3cQopMKd8Qd1E1fkVMOjSCIleRlPm5awFiIaHx?=
 =?iso-8859-1?Q?KZWEKX3WMKJt89qCf6k2dEpzY826da3z4cELW9kU8wCikQtm4aTtIBfO5t?=
 =?iso-8859-1?Q?VZq9o8Z66HQcNReKG49H0sJGUsLM+nkkGu8g/yClzQXYeI9UrTXVVIhpj8?=
 =?iso-8859-1?Q?YQlKC08Ge2sBTNjm+zVW06109hWVkv1iB2kFwDtuhv4qCF0JpRmXl+IqgY?=
 =?iso-8859-1?Q?iIPZdxX+QF7hpgRKgzerirbw4otWK4vH+hv+Eo1otmSwgSdwRwaj35PS4K?=
 =?iso-8859-1?Q?ljiblwDRJXVDApM81T5k6MlSb+XM5YIyPQkd/XBHlNslszgHbo5OolUr0t?=
 =?iso-8859-1?Q?DMrFea9wP9fy6wJalfb++avNgoTqSI4oygMnYdi1HU1QBXns4dgF2I+aRZ?=
 =?iso-8859-1?Q?rfhJnvuLwpCqCtgwgQH+z9OOAZpUOTdqtDP1WluANVHVPbpv4fWhNTdai2?=
 =?iso-8859-1?Q?JdQGpMSPkJoS/YYDSYxBP4/WY3M6VEm0ckh4O+6LvxS9HAgu/ldF+LQZNh?=
 =?iso-8859-1?Q?XXNT5kiCX3BM1/pKNe4PgIKv3kc5d25yPGNyY4tDGqDADNYpfLyYLvur70?=
 =?iso-8859-1?Q?lNW6BXhuYVz6r/9mth1fvKA8SCNUJwkL5lT7tcBV/JhfNdriKYEa1uVNKm?=
 =?iso-8859-1?Q?5aLU3mtx2w58JiL968fCIycJ0vT4305eDlCkRv0LKdKsDjwq9BbPL6mhYc?=
 =?iso-8859-1?Q?lAt2hO3LmHXwm//Y6bHE7dxUX6sbpVYhaqJg3Alvw7GtZed46KaaTpaiW5?=
 =?iso-8859-1?Q?xr8OBGGnbB0PBAijoMfKej2HOQ9gIrYostOpUBqnGKp6kQaWhqn10vS3Ca?=
 =?iso-8859-1?Q?2/VP00Cm49oyM6ffFmQ1BG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o9RG1f/2L0AQDqG3lymNr6wBTFkF/weHLEKfhzTEdBIPLba94w8rKHMXFb?=
 =?iso-8859-1?Q?leK4QpVPVWw0umQKFGMWJRpuxLnbHpFwKgrkpn/iwAByHQVB3SIN1sCiJI?=
 =?iso-8859-1?Q?Q+g3bbWzYr8C5JSw7Pt7J2Irxl29jz3vGSUpcYGEGRJ2shmFVlUkX3kEuB?=
 =?iso-8859-1?Q?2RrHaxAe10aK+VLEPaWn/4gtRqX92x/nqBuIFHKgkQjuX+4FzAQ6nLRb//?=
 =?iso-8859-1?Q?2gZy/TS1VqovCobb6zo7IRNga5ORJVLk/BC+MhI+JaXqAAKNHO+xgLGZ92?=
 =?iso-8859-1?Q?IupeDvRM9wcTBrW2sIDUoQS5Cnuq0vOjBckz+6Pzt/luMYYYbMuz/q9cyt?=
 =?iso-8859-1?Q?Q/O/v9Aez8Wx+0s9A3z3XP3f5PPVu8Rqx1HuKClbAlfxb5A3aqnO2amr7U?=
 =?iso-8859-1?Q?I28n92fbP9ltYir33G/hgeSl3zBFizlsV4kqS9DaPSxARZX2ip3MyLToh5?=
 =?iso-8859-1?Q?d6XU8R8sPI3z/Mx4aOwvsYmwBbAMlZcNKa3LABT8ktUXx9AlkK5C6M8zP/?=
 =?iso-8859-1?Q?CH0qK9iQp4yUv4g1y+Wek17eysG8XCXiqbSdm45ZivJ4iZ6xhy7oD4iCPR?=
 =?iso-8859-1?Q?NUBBEhf/lkodpoHa/9mBYjxZWhajmsff8JkJ3sCp6KKrBrtfb5ktVUySOq?=
 =?iso-8859-1?Q?N0gNoWTPbhw4OUcNxwLPeFV5jKIpAv8pokJVB0eJn5d9hQk97JJ2jQJ2AA?=
 =?iso-8859-1?Q?+GLnJq7LiGwhzHZKjzd8ggClLQFODAQINHECPMvruNax0xvyRFSgA8cRLs?=
 =?iso-8859-1?Q?ID5NSpQfOfuXwXHLWbYWIIr/JS9FDj6obq/K5iTJrytjX1/913rYs9ke3i?=
 =?iso-8859-1?Q?IpdN+ZTGKBcnz8SBcktiQdlsT7pU/9iW40v6crREuAPSlkI7Kb+lpWdH0c?=
 =?iso-8859-1?Q?t/KmZA930OpI+6wkCAEJaN67GauZardvmHpabT4OYFcChUynUI8424M5Sv?=
 =?iso-8859-1?Q?h8GM5OphqQM5vVQUBjGH6PfuXDtotmyEhtVU+noGUtI3xvwKol/9Dq8pug?=
 =?iso-8859-1?Q?jItJpPYN6AMkTc6UohhQd3FnqDa+7VLLwqoMerkcpjO+MFGQKB6NV+0q5Z?=
 =?iso-8859-1?Q?o/DOmYU2wjxOhkarbWNjZ7ET5uWdeI+BTKy2Or7pmmBFmFyTwwWRtC6IOb?=
 =?iso-8859-1?Q?yLK5hB5T5az/9MkdeKdg+z9VtwnrYP7vOApoXFcy7TpBUWepy1gKwxsPsR?=
 =?iso-8859-1?Q?bTa+n8FIireKBLbadRrL5GpqDC8d/lvxRyyyqKI67EQdPncLZdmr7vkkiz?=
 =?iso-8859-1?Q?W1fmiPU3mrjROTKmoB8NtSI+qE3yi+CYch0IBPRNtIcad9SNABy5MPAUjs?=
 =?iso-8859-1?Q?wxDbBjyDYleH/Twh89G8x/m8b88Kr8lr1LnG0/JbnG7ffMzVd0oeBGRTMU?=
 =?iso-8859-1?Q?L3jwPpY4kg2oDXcdkPzP/Aiq0swAGQXSmCAzH440BKA6TRSRAcSmEpgB3w?=
 =?iso-8859-1?Q?R1j+EKOC06mzlaeKpqMeGS+QsufzjYC4ioUaI96yY5Rlct52OGpRrwK8u7?=
 =?iso-8859-1?Q?As5+8b7VCXdGOlyymNIKRpUvWA3S7/2lMxrSO1/+19R0KjbvOu0BjvQ/qe?=
 =?iso-8859-1?Q?BcSX+6JK/LPNEKzyfLJsksTxfygfl7Jk0Ou68/pc9m1N4aRQiD+AwJ1xrh?=
 =?iso-8859-1?Q?BhF0WmHa7AeoB3SpTY5+cDeGJhnVGgYyMXpDsxpk05cxGT3+a9NDEEqw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19954f1f-fc35-4b47-458b-08de07576b75
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:15:18.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EprJG7zgtK7Z2BppFi1VXl0XIG6DqaAsMGU7G/n71WLarjKqUpFanhFicg6iGAv1R+QBqhtEB8BsUbQLn0DTcsYrcyQ+oy26NFz+kPBQsRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
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

On Sat, Aug 23, 2025 at 06:30:02AM +0000, Morten Brørup wrote:
> An optimized function for resetting a bulk of newly allocated
> reinitialized mbufs (a.k.a. raw mbufs) was added.
> 
> Compared to the normal packet mbuf reset function, it takes advantage of
> the following two details:
> 1. The 'next' and 'nb_segs' fields are already reset, so resetting them
> has been omitted.
> 2. When resetting the mbuf, the 'ol_flags' field must indicate whether the
> mbuf uses an external buffer, and the 'data_off' field must not exceed the
> data room size when resetting the data offset to include the default
> headroom.
> Unlike the normal packet mbuf reset function, which reads the mbuf itself
> to get the information required for resetting these two fields, this
> function gets the information from the mempool.
> 
> This makes the function write-only of the mbuf, unlike the normal packet
> mbuf reset function, which is read-modify-write of the mbuf.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/mbuf/rte_mbuf.h | 74 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> index 49c93ab356..6f37a2e91e 100644
> --- a/lib/mbuf/rte_mbuf.h
> +++ b/lib/mbuf/rte_mbuf.h
> @@ -954,6 +954,50 @@ static inline void rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
>  					(uint16_t)m->buf_len);
>  }
>  
> +/**
> + * Reset the fields of a bulk of packet mbufs to their default values.
> + *
> + * The caller must ensure that the mbufs come from the specified mempool,
> + * are direct and properly reinitialized (refcnt=1, next=NULL, nb_segs=1),
> + * as done by rte_pktmbuf_prefree_seg().
> + *
> + * This function should be used with care, when optimization is required.
> + * For standard needs, prefer rte_pktmbuf_reset().
> + *
> + * @param mp
> + *   The mempool to which the mbuf belongs.
> + * @param mbufs
> + *   Array of pointers to packet mbufs.
> + *   The array must not contain NULL pointers.
> + * @param count
> + *   Array size.
> + */
> +static inline void
> +rte_mbuf_raw_reset_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
> +{
> +	uint64_t ol_flags = (rte_pktmbuf_priv_flags(mp) & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ?
> +			RTE_MBUF_F_EXTERNAL : 0;
> +	uint16_t data_off = RTE_MIN_T(RTE_PKTMBUF_HEADROOM, rte_pktmbuf_data_room_size(mp),
> +			uint16_t);
> +
> +	for (unsigned int idx = 0; idx < count; idx++) {
> +		struct rte_mbuf *m = mbufs[idx];
> +
> +		m->pkt_len = 0;
> +		m->tx_offload = 0;
> +		m->vlan_tci = 0;
> +		m->vlan_tci_outer = 0;
> +		m->port = RTE_MBUF_PORT_INVALID;

Have you considered doing all initialization using 64-bit stores? It's
generally cheaper to do a single 64-bit store than e.g. set of 16-bit ones.
This also means that we could remove the restriction on having refcnt and
nb_segs already set. As in PMDs, a single store can init data_off, ref_cnt,
nb_segs and port.

Similarly for packet_type and pkt_len, and data_len/vlan_tci and rss fields
etc. For max performance, the whole of the mbuf cleared here can be done in
40 bytes, or 5 64-bit stores. If we do the stores in order, possibly the
compiler can even opportunistically coalesce more stores, so we could even
end up getting 128-bit or larger stores depending on the ISA compiled for.
[Maybe the compiler will do this even if they are not in order, but I'd
like to maximize my chances here! :-)]

/Bruce

> +
> +		m->ol_flags = ol_flags;
> +		m->packet_type = 0;
> +		m->data_off = data_off;
> +
> +		m->data_len = 0;
> +		__rte_mbuf_sanity_check(m, 1);
> +	}
> +}
> +
<snip>

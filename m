Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDAF4644E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5CD04025E;
	Mon, 16 Mar 2026 12:07:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9AA95400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 12:07:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773659231; x=1805195231;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UgTi1clSK7SH9Scd4jCSe2QxvTqcSAofS/Zj19irpVA=;
 b=YizivtD7Yxyq9NKnLGwFoFZH67krWD9BanPnoJrRePZn+U8d0BoBiFcZ
 5dRUaB/RUaXTWKKo2WRxwRgAb1Jbcb7DRO0OeskLQ+1TuJcPCRZpDPH/0
 Wl97JrxY7/LLTVLWmboyktRjBz4Wa9QtWY/v3SNE0jvugcxIP5bqUxE4Z
 fcCU6owJbEnkE/4mcU66i35Ckgh1W6LouGZoQblf21BgmVvYHjz4uS1VG
 IOWRU8xs8t8JtbekKdFS6nLT95kA+lFQYy+f5NXx2tqvqi8kftwRDkBPl
 vdBPbwOERS9Ub0mRNchKcTG6YpCHJDk5B2gvfInuTaZcw9oiYiv/o4vR0 w==;
X-CSE-ConnectionGUID: FUNPF+RySlCaZiCE51ns6Q==
X-CSE-MsgGUID: vgKdlY73Q+m7iKNxB0b0xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74557639"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74557639"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:07:09 -0700
X-CSE-ConnectionGUID: L9+o2ZwtRVGrKS+S7NKfzw==
X-CSE-MsgGUID: 5/Hiy2DRTJCe10I1GFPDhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="217724727"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:07:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:07:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:07:08 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6ndCELgciTVZLuElNbjYjsobJMPTlEA6R7av12DUDYpDKs94VjEKmbqxtBPvw0XjNFATiN4fxJgB5vv4FoP7ifXJFqYtoM1pEZr4sRHMxKiFRLQumH4XXwOM0YMqEp83XQCyYiNeMit7/ZeWiRAK8eiN5PaDYW69r0LTOtJ1SUTQ0AXdzhT62GhxKhzruD+rbWresrQsZRkFnJFuPVg2rntnM7dz8iizzI4N6Ma+MF3J2XD5OicqqSYpvpZ8qo5EEmC3EbiSU0URgemaG74tJgHZlna4jmiBbLO2azHdBn+F5KL7RTrys/toe0tuW2ONQN/Qsok9HlIK/P3n83YSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgSfDQnHFhzgzhhGbrXqKEiqLSNGpl5uc4Jn5FhinXw=;
 b=XkBr3wTKE19Hakp7kxfAoSL1GWMzpEwJbOb48SeC2NS/wgXUYPz5iL5pNzlu8yCPjjyH6gMYK35QbTDBIKXKom8UaAb3GI5B34HCBCfol2I2p+/tTJLw+pPv9Fd43C3cg7/eRG4XnfOTfYffaHO3nJLfW+yv0IEvb+I5dSXm15MtqQS+K/4xMb7ZkmG3pebfD+sDXQjDc9WgeA29UE+HDYSU+Oehu60Kr1oZXTWHL0OLoocB3cbPfvgeg+fPdW7JintXHbvSjxgXQr/rUuJrjbWGCu5H+pTc5wp5vNd+oeP6g+UlLEuxx9LJp+b06Psiu/cvgCEmLEet2aLmog73cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 11:07:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 11:07:06 +0000
Date: Mon, 16 Mar 2026 11:07:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v20 01/25] maintainers: update for pcap driver
Message-ID: <abfkVQMIZkY5sGA3@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-2-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0057.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5551d356-b586-45a7-03ad-08de834c292d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V95w8FFSy4O1SSVjKU7LmZ/2AV15SLhIJnB5hds6yljUIsYQsT+u5C8ubNQ90snapecmxZWDA3KO0OqnyY8iQSMXuG/MB46d/csQ9xTuv4PBhZc7EcNmphcJQE/r8V4FtCwJ0sx+PwmU103cTiN7YU8XC+vkp2FMBvljlhHMsLeq0jUqxUVpLjoimn60BEShS1zaa6uo+5EWusxKZCZSTiiiuE8baGCd4k4H5p64TsmxFM9ODTSNIYfN9R+PJvDxexA4YrdSlNnJcPr3OdnbVpuEJWC6/BsdBC5b5ptVgfmIDPD8+RoH7kLiGItOulYefpQmYWia7aCLbufdiGj0yG4Obb5QbZeattDba0sJ0oVCBT+Gz4/uhRZoO1s/JxYNMpfuLJmRmpLsOET+FoXJK3perykcsYR9r/VIT0N1hpq7Uh7weHXrpvj3bE1C1xjn8HkUiTXze4Ew1KJOPMGMho2lb5/UIsc7cunqRJdNcYF5sdl87ka8MxkkrlbbTaTSKXpqoUPv+Qx5pQu8EZCNTwi/iVy9uhFu7qAXXZETwD4YLrT7AsYRSqOA8yZSK37gveYe90h3KRTR9Kxnt9qf+x/UVb5nFhC5pYALvsbFDWPGZcKuB7GJf2B4uL1NusYBsp79G8VP5lQ7YoFLwUuYijIOF4bUcyAq3UzFsv1in7SG2On0JpbOzbAdzjTtN+WJ8AAbcCbGYAmF9nSW1E/k5+A9JmPhsU68S9hb3iP3yU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+48uPyZXtOxZoPNPm8PwtyxUTVGi+pMVlEtcJUSHtVf23pw7gn3kPYnoX+w?=
 =?us-ascii?Q?oZ+kgjg8JS4Ortqi7Lz8yzt08jkEMaPpvDWMk7sN0E3T97SI8Ep10L9gWi96?=
 =?us-ascii?Q?4yOqqlumtQv/Z2Grb5Ye91EpMsU5ysWS5P6QoxXtBjqvNr+6yaCu8x/nKYW0?=
 =?us-ascii?Q?03//2wmf6nrXzSR2zuGDoIC+VZjBYr09Qw71DBRa7/bQWBOkL+HwcFsAWlNf?=
 =?us-ascii?Q?kkPS1wv6gIcq23eG2eNSecXJ0BclLaOoLl7KARkMuaLZ44GZvvAD6g7//0GW?=
 =?us-ascii?Q?pcsH/91j5LibVuFZjsmF9aNAYuUUIvXPf5pZwdXeEJpbgKtdtubsNVKuAowj?=
 =?us-ascii?Q?onAEdlUq6mP5s/V5+MAhbBNPLiQ3Gt3XE/1jbmraZjh5BbBURsqO/YnB4Ugh?=
 =?us-ascii?Q?5W0DhGFu/hwzEeB7i76bBNf4GqR/xpD6Dv3LYH+5zNlsU4XxmANcAZ/Oy3Y5?=
 =?us-ascii?Q?FKCCvgzttqvVqOI1frogulIijyK6vzeU5looYnnR4ci3ifv2n/Q6WEfwOnDA?=
 =?us-ascii?Q?iX9jQmjMpSXj3rC0geRfshFoiTb9GM0XXUSeTeSsxitZWtt1wAHzhDiInEnb?=
 =?us-ascii?Q?j0mOQIKLP9sv8XnV7S10+FyY+9pT1ihc477YYbrXa7CENEjoSFn9Nf8IHbxc?=
 =?us-ascii?Q?G7KSbOKGFWvETXi7+azPWWQyQAG4n+Zzmd2FEdvNGblkBOeEhJveZJ7vi7+w?=
 =?us-ascii?Q?akTgjQ4kM/fM6bPxgjoHNmgbx96qoaxMmQ4NR/P35EZEcHCA37IQUOdr1iTC?=
 =?us-ascii?Q?o+0LYXa3AC1w6BK8Mgyk35nUJ96bJVfjzLK0Kq2kyIy7eoJ46nC14qB7ENSp?=
 =?us-ascii?Q?Y5Fbjo84Im57gYgYGK6eMhyy14OkvAUMdaKd6THLTBf2OkIbjS2buMxzTgUd?=
 =?us-ascii?Q?EieSChaZ2bCMJaLmPO67z3p29JUkLqZu36mzcInPmuaoEx8PP70g8jBoiwGk?=
 =?us-ascii?Q?Nj4LfD2A3bWmpi3aSyr50KgPPkAH9LPBvlk+UF/UEqUe5P3Mw31qD9dUOKjP?=
 =?us-ascii?Q?TnlGCLSl/sPFSXH3RfCNHlpaX9fbDULPmGW6JzG9qXjBciQ5UWT1zd24kJBX?=
 =?us-ascii?Q?agvrQgr5JYzpNDP4Aec5ohthul9hIkjW4YWuuOZPb+lhC8t6kwqUEwTUkJ9i?=
 =?us-ascii?Q?iB/NFhlN2dRwTLQ4GEHDp/k2ZTKfuXV/w9mJKjeHi0D+T/jQXx5TcdDA3IWF?=
 =?us-ascii?Q?2mKnl9jPyqFLZPbbaQdcPM2MdqLq6a409HfsC3fentNQC18QyXUNkuDyNJ5C?=
 =?us-ascii?Q?89kabYuWB8Lkugjn9B/3b+N0KcVgKlL3SxpEYS5+g8hNWbrvtSrDpTBo56WG?=
 =?us-ascii?Q?yWTb5bo770+gb7eLVP84+nUbVjN+fP0hkSKAhNzw70pQf3BR2TF3c3aqqKhj?=
 =?us-ascii?Q?jS7yv9DjQmW8N4zVeb9kXma1sq4f/8CNrC21Mlzt1x16oDkdHHGADQ/i1lbV?=
 =?us-ascii?Q?t3jjrCErunQ/0W1LuP94siGVVVSNaXCy2xsuDjFofPr44uYJoK4nnVb6hOUi?=
 =?us-ascii?Q?QMppA2kM29FSH/0t/NOfBVvpSbiHfB4jmOfrW2l+yBPuD1Ix0Ic4dAJ73wpZ?=
 =?us-ascii?Q?GTIT9ZWAZY6ak8CqavD+eKK+wsTQT6C9zMlp3R0D5lo8uWwuMf8uKEeWe/Ma?=
 =?us-ascii?Q?Hsr0IXEkmqiE2eZNuGMgnQHy9/X27YSHo0p0LntHu3dzk1cBYHjaCJ7Shcpy?=
 =?us-ascii?Q?RMxIodXxd+cAuShxa3Nfu0VYJbVyYiG077C9GpfIVnNwx7SzkuvS4FkCVVVy?=
 =?us-ascii?Q?Qgsk+MnB9C6VSqEUAnj0yfNVWxoiv0E=3D?=
X-Exchange-RoutingPolicyChecked: wCO3TNiy/VdG7vo4/cBwKinf0rmR8aExnaUSUmOUg4ueNX2cv3cTulG1QFrUxxuCRS+iAXzLshS11fn6auFSCNQmKzHIHK+4j2vnd79QaR0SeqTeQIl5mTubAtPeLDgy2vYCm+ncPry8asusCVpfUKuAjS5ZMODmJiW8G+9E3kpVF6haow1g5uyJCuPR1gMmFmePpKwewfBTcK0wN47a+lEBkHF4i4cUPD/ZgEdPKLIIgruVZDCVskBw+kv3TZalN7izO673+SRGh8A09vbiwfXqMMA493LBIrre4AXNZs8bdKPFlCuhD8SWZLN+sv9UdA3shP2IpweI78Y6zWcUnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5551d356-b586-45a7-03ad-08de834c292d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:07:06.6045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD+9cgJ1TZSlJ4VehrQHnOpzfcdFhBPcWBatpChMVmxkqRkCLzzCP+TFDzw45Y657u4ISDbZNg7nI9LLfJjlYicJocoLtQciqiPjXXN5Soc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
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

On Tue, Mar 10, 2026 at 09:09:39AM -0700, Stephen Hemminger wrote:
> Nominate myself to take care of this since already doing pcapng
> and pdump code.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Thanks for agreeing to step up here, Stephen.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5eb8e9dc22..a8e375ddab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
>  F: doc/guides/nics/features/zxdh.ini
>  
>  PCAP PMD
> +M: Stephen Hemminger <stephen@networkplumber.org>
>  F: drivers/net/pcap/
>  F: doc/guides/nics/pcap.rst
>  F: doc/guides/nics/features/pcap.ini
> -- 
> 2.51.0
> 

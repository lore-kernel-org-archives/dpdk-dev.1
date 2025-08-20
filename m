Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C508CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B862402DD;
	Wed, 20 Aug 2025 11:51:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 766CD40292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755683501; x=1787219501;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gdyJ/+c2zocO+ofZ3w+MMaXX0TqqxE9qVV0Sp8iHrxc=;
 b=AKvVMh/a7hipT7jlFXoVNv/m/b8ptTQ2HYI9OQnzTrYRszh6Afd1h6LH
 MvDsHlLjltvvQZHgVf6qkN3NfD2zS/D3uqjbhau7hM9hHndZLRDK5Kt4t
 O1xnU+LqICVcoJQK87lLU2tjoe4hPi+rIrZcMzsPg0xmZutS8p89HW2Pi
 h18J+mHwgDUBsUSvyc9WQEuX5lo+JtywNM7gHD7ZbGTE8VGOy1QHzOhZM
 t+xRU1Nzqy3osaxkrHIOUkhn8GSiIZjMYTy2vJ2QiKe8CrsFdFnmhfh9u
 Odrbf47eTOJZU/KveT0qC95gPHSSgXAhLjryhNyH8PlrgHFSRvAv9aTEY w==;
X-CSE-ConnectionGUID: Z8EqUr5cTy279PlbJl9Oug==
X-CSE-MsgGUID: kFbvfIqORO+A2Fv7C6AcAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80538983"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="80538983"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:51:40 -0700
X-CSE-ConnectionGUID: PhXmTZxhSbGZqhjsf4Mpzg==
X-CSE-MsgGUID: /8bzIkmVSdarkNeOHGxl+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="191775802"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:51:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:51:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 02:51:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.75)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfVq39aWxNN+ZH8EhcktlQ27Ca7HbZNe4K5gJnggf+B2zskCkszXIbnji2gzNzarnfVw300btBNdBstdzuj98oXnne/l9l7ylkCLWGx8rpJiqQQRXpEP1pmiFbmFrYLwhlBXwQdokm44H+mJP4ORFSmiwgtcMcRMz58hrlfRak5uVXaBb37SUijT2mOIeBb8NitWun+5bixKlHWupeBR1xSzoNrIB2ccPugvzSbvbDcFNv0tH4kJwI5sDuwGM4SpJ+VPcnZsapgNf9IgGzOee9fNwOpSHclLsBN7IjDomOucbVlT/xRfPevaCJm6sQtINnGRrpAqB3bfDJM4E2ysKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yo1UG6bL+alrWIz0qhBcNxZOWbgvxWh4iuGBm0jYr4=;
 b=VEpqyDHXI1GT2yTadcBOQzxAfdO42m37ogp5n0Ku9yXw9sK00Wmrj44qZOSSS1L1XBqhHbAezZIQ/HqmRs1lwFQr76FS3IsgOrO96ovThzVYyUGXzeoUNdMdx5auI5qfJYxHfjwtRZMLPhssZShOD+DO1tOjaob1OtRjKIKkZ/8vIbg1/eQFZnN8fXcHcY3zgiCE1UyPJX34l9RAYygN7UeN3mHBvKAkHv2SAr9E8V6Y1ioYNWMCaOBIjHiEO6FMcv38nt3oK6Tpz4sKS+wsP8NrS5H6WOOLbYLkn5EMoik2RB2ERSFKCltl2oWOCgyf2e3DXqZEk0wTmcaEOgjfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 09:51:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 09:51:30 +0000
Date: Wed, 20 Aug 2025 10:51:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 15/15] net/i40e: use the common Rx path selection
 infrastructure
Message-ID: <aKWak9Nq1X_rthN1@bricha3-mobl1.ger.corp.intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
 <20250818105914.169732-16-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818105914.169732-16-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0215.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: a313fbd7-be72-4691-7e09-08dddfcf23c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pr8Xe81RKHbmSz1llo5qSsAUu1ovVb7S7obaxm3BGa+mDZqkCGjtY3sMQfsz?=
 =?us-ascii?Q?OuIh8BKp6XUGJL/hCDgLxzYf1QakQ4gO1oqkq9QAIzx+Mdq/haf94eLr0knA?=
 =?us-ascii?Q?jHC9qkeV7GM4EP0t1zFr36P9NEH/JPV9+Q6Sc3WIkmb1CdI3j66SkuScRBt6?=
 =?us-ascii?Q?hHlVXcJvpx5egJR4gUFTdje5w4Jy2lkDxK8SbibS4mvZOgIBmvUYc6aFg0bq?=
 =?us-ascii?Q?HaZUsTOy3O4LXq5NZpHjK/YVd3PUTDH5CLLp5o7B554b9iVM6dHSbM7vEG19?=
 =?us-ascii?Q?KCtqwhhXdsKQBi8HsLElCAOWaHQ5B4g4mHMPzpEwcsHRUHBUl0+Cu4OPiXN2?=
 =?us-ascii?Q?cMwt+ZePKiHFQlw8TiyMvjPiDvyviuA37M3Ozh1kLegiBbnmVoFfr3d1K1vj?=
 =?us-ascii?Q?sSiYZfY09uiN+E/MhOxHIGRoIYvq5kq+arJuPlXsLIi+gMDtJTlUvGQSWlH4?=
 =?us-ascii?Q?inEEp1HHmOZDTq3gSRsPHycp97rJQGXOaVE1vP2+VMnX3ZVcq6HlIUH3R1rK?=
 =?us-ascii?Q?NaQulG3ExOA1JTCJ7J7smAw3VYhRaAhp8j5RoD7Zy2zff4LpT8qQiazhmumg?=
 =?us-ascii?Q?7FP5Fg+KjWNMVmcha+jX6q/qfAqF5LSQJZ5yYES6w76DoieU6LiztDLnwket?=
 =?us-ascii?Q?mR+PfBCT919wS2jemXrjSyCy0ZoLPTpcT6BrjTWPe4Oan8+HSZ3JFbXFEkMZ?=
 =?us-ascii?Q?F4xsOerU2jR4ztGbTntJUBVsd+EBnEmVHUx1tDFydyTHjSaLRtHlEEb8kflx?=
 =?us-ascii?Q?Ld06d8A+eRJ8raAxxWG5/2uSoPtrlDAQdIs75DDYbYu99EzETI/I8VI0Qmv4?=
 =?us-ascii?Q?icDXTWgVUssJ2foTI12xJAyALGlcqy8nF4P041pYgghIJwmHIH7FjX9LqNR/?=
 =?us-ascii?Q?rmeVrTFMJhDT0uPXuPAgyu9hwfm/Sc29x+/9+GCrJngCCZ7SVaNakuGsDQHd?=
 =?us-ascii?Q?9KQcl9UlaQqx7dCPBOHIFvJoQLwdG5UWqUIZNZH/uwXR1J62uT9/1UiZpHZZ?=
 =?us-ascii?Q?OtIMa87TgzXFD8WHmAChc9KTcJf7VhUxUt8J4G1DgtsGxp+Us6R95pUO7UlS?=
 =?us-ascii?Q?hnKRuDus08tD7JXifGSKxVVr5k8M+ZqkNUaRVLuZIvPX+lf2OzXNWCaT+hfg?=
 =?us-ascii?Q?c8P4Hm9bc+ixa0wIpMnvNyFOJQLunAsSY2uVNZ9oM3CpNFWo6HvwiH1g8Len?=
 =?us-ascii?Q?peAlBwG9TcgdngK0wRzFtmqmhLnkXe1DECYRjaFiXo8v4JKEP7SnbeUs0Rq0?=
 =?us-ascii?Q?x091FQm90FJPme8lqCiGruJJShcHO1+seuHU7ez9Rnxxh0A4SNYQh4NzbLHH?=
 =?us-ascii?Q?ejjGIaiKTmxl9ZOwGOWm957O8Q/9oL2GwqM02X+twhVEw0JBx94C3ZqvFBUq?=
 =?us-ascii?Q?VbxfXeMxzGcEy8ilrmDcPXNGq4/DV1aAR0xmpsT22iNIj3rLreesGZbIfr/E?=
 =?us-ascii?Q?g5xRGCHi99s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M5SycHr0X5OuRst/CDEj+SSKI2P6SSyWCtraPdMoIeFKK4jvatvQrYJZhgKO?=
 =?us-ascii?Q?qF7bQXKa8JWswr/givNval0//FQqU2EXoFV09QRJHz3/pkFc2mbspaCZaq7b?=
 =?us-ascii?Q?44eUkYvv0qQ6GpmK7e9AeIBVx58hax36f97CWZHdDO97bGPIDdwydT7qL9ff?=
 =?us-ascii?Q?AUyUQ0DGaEaPTYROE2kpwmeyg0yo3Tsj5NQD8aZG1LXFcdf9c2UkGFB786Hj?=
 =?us-ascii?Q?zZSKaZFq8VuWER9JDpNvD3qChpKSfx78SraZm6yDf35Di03AAf9fIhvVMvkr?=
 =?us-ascii?Q?TqIkSXFKVIHh817dgH+1HjVRz3kI/yqIe3Llyp3NjonirDABwaIZyYUIczWm?=
 =?us-ascii?Q?hiU4WgjdEGmLRjSM/gmT0gvtZb4ss+iXreIiENj6q+BGdRZ84GyBd2OUu3mY?=
 =?us-ascii?Q?CYyeodYVFMclz8hMs73K7/f8GlRjRflUh5FC3WTLjBAR5QiQfWvd1Uz3FnW4?=
 =?us-ascii?Q?hKUsfazExWEuJpjd/F0uOh7UG33eS4UFcrkbx+oLavKzxh7CJ8ZJpCJMMq8r?=
 =?us-ascii?Q?Xx24eKRLpzBsf7i8dGE1HDlrBjHFMuyd3GpV2nwoQ3b8TMGhHKBDm4uPmr6s?=
 =?us-ascii?Q?W/A5fuBHCkuu5huCbXoZSRBTKSX0iPgkR89tb4WPcLzWXPsypT4njxzU89Cx?=
 =?us-ascii?Q?AS6yTprH5syLC48QPPhKTx2mDThjDpF5YR8CqZCZ2+4Xk6uF7wuE5cyxXubN?=
 =?us-ascii?Q?AdZYnaKlySgfzQyPhOCvbWqsTmZcp1OJLimPG2y7/jEhu9VdeAO90WzvNPr5?=
 =?us-ascii?Q?Faj0FWTOsxdoDEnHeTnZz6BFYZcMqJcNZhiyOCKcVQI1KrljsEnqd5uZC8r/?=
 =?us-ascii?Q?6oM92IBRDAGpTVBQ/ivMF9U1Lwzt/+191jwKrzmdjcKhIPTZ8I26am8Zi/Ff?=
 =?us-ascii?Q?OjiEhjKmAvamvf4FCkg8o6QE+evlAq4MrG095xzbbuCACu8RYlpiMhZrEzyU?=
 =?us-ascii?Q?TfjfkKWKBvszZNcgu4OiGgECB052be5cAkWvl7vEl/wpreUcwfB8B2QTUfHX?=
 =?us-ascii?Q?eyVTOlNYw1BXVUX6NyNtQfWlsYE8NlOI9aMU11LX6BDWjd0pssOOmc25CZNF?=
 =?us-ascii?Q?yRRfDUqN+OSrhuCNrPFMIUxdhEMkTqc7lP9n6J5mbhojkmyzn6wbrpz6ll4S?=
 =?us-ascii?Q?KTgPFMPuCpYSiiOe4Y9AYEgoduqYye4vdLHRsViH6cT1y3mwfoHI3pJ3utOF?=
 =?us-ascii?Q?Y1nToZv7sPYN1XgtccivEsXqfR9zuFg6YlaFYCxTxbFPnXrUMGIbM8toL9oh?=
 =?us-ascii?Q?QEzIV0nvLSyB5ulr/aXiYqZPHFgFaiZnKONzbibQXyE7JOhCdFYBDe5I7cfm?=
 =?us-ascii?Q?JijY2zOkQAZmJz/GQ9QAcQlEf5SFxaNHC2pZ6JwIsloH/0ZeZFggBMPgTIN3?=
 =?us-ascii?Q?kF8+HGYO4hipaBhOst4ERSSytB3I1ufLJr4QH3PfA/wWuUuuGn447sJnVlES?=
 =?us-ascii?Q?1R5UdizEMBoDSbKx71023N8vbSuKXAaQnFNVh0RDgKEsyPNP8+XH0sv82dir?=
 =?us-ascii?Q?27HtdYpnNZ9P+malPpbye1NF6yQH4OBCq9bku8tUA5BIfLiVSb9k6t3/+B2N?=
 =?us-ascii?Q?+Y/tw2Df6+oK4aPD+p8aqwAIo32IieUb7ipaGcMavUFChfQ6CeY9vLw2IQLj?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a313fbd7-be72-4691-7e09-08dddfcf23c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:51:30.8336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt1+y07pzrinSjtzeXOXXN7SAGaLKuoZUEfel3XAK3fPX+MGWJXITQ8FFql9bdN4rK3Tb39LF7hbVxrcN4hZgcn4E3AKnu7/2S5CIgdueuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
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

On Mon, Aug 18, 2025 at 10:59:14AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common function.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v3
> * change burst features to true/false instead of using defines
> * Use new extra features structure to define burst features
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c            | 144 +++++++++---------
>  drivers/net/intel/i40e/i40e_rxtx.h            |  15 ++
>  .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 +
>  drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   9 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 +
>  5 files changed, 99 insertions(+), 81 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


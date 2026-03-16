Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3696EF506D2
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:05:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B5984025E;
	Mon, 16 Mar 2026 15:05:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3A843400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:05:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773669917; x=1805205917;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lp43ILbOOCNanh0B1n5w38kLJ9AGpYYOuoNUGHm81y8=;
 b=PNDWBt+YlGjftIBpJwcnbmJj8Onmkzl6dHCNJsiIlt381DIlz9ziQfHg
 XZAKRlx9S5pkJfujRFCEYvtC9rbfJyEVEG/iSiMZpGJtc8NjIcPe3tyL8
 Xg+0CxLLi16ED/9R7ClxTk6i5hyehW6lVp/P31u3S86vlx+WdG5e76J59
 w2V9RV/xbpLVWmM1NVd9RUwoRRukqKD6yG/Up++V5mvtRu0PX1hU201QR
 6UFIGWFRl0CeJ3zH2BtwjHMUDLAEF86r/yuVbu6gYxp7wFcUCtYU/mgZD
 u/+2+RpgyMSxsjsroL1XjtyW+Iz50ygQ/k2Q2MWXdI0gZy9bB86t8EQu7 A==;
X-CSE-ConnectionGUID: H52U6QHkTI+zDRuuqxiCmw==
X-CSE-MsgGUID: 9OUCEA8/SZCvrEYWhQbBlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74763358"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74763358"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:05:15 -0700
X-CSE-ConnectionGUID: CmRjwLHyRtmGx7lckCbWhw==
X-CSE-MsgGUID: kIS+orCgSFOuQP+AuARXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="222139830"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:05:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:05:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:05:14 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9QVMK6BpEvAy/2MX0+0nrhoFnHQeeNLnf72zTMxtpewpiWda7q2bPK7a35wX7OSf+cCnMcWqdqF8uPyf7bRkb2g05poW43N9osu0BkJ7n3ahM8z9BZjl7lpFu+z2LQbJJctwvf87G2DcZ9GlBv/FStcjKeAxCv9sUp9/1HaaGvvR6xS/ASZRBSvzQzwc8nntVPB4kxlbblNqVTQ3uR/3nEJQFuOWB7bDJFsotMVyK4gmT2350E8r4XkOXc4Ne+FmaL9MMc3rgWXaJ0CBT4QpSQD0ZFeWp9+uXM0yDQiz+vvfAzE1WGzDlxx1ZczyHg+2EJ3O13CkYFDRiH7nU+S+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP+40tRGwKmnRDRhbxejYv83AGgHEORrXawQL12rLFY=;
 b=oTjdQqYfwjdY6IWx8myKpppk1b65RABuRNG+AEPN3wFV5fwfquYSNexA33B7oP0m6xTpae1zDpjBLArXnmApNTodgAtkNGSlZBwppk5Tuut7kHreVv7SXTY+DKL4A7TfYKOEUumUtpFEvPbb3jOL4J83CnMs1tis4MFsY6MyWonPbPBMta9W9MgG/ax9BX/CSHpRw5SZSJ9PvLzYqGCwkAJQP8sbaV7IxsgJgvrSi5+ntcpMM8GkA2rk2m2RxTTh5RVKsRREoEqq21aa2SEGKK83VNF7LrO68y02o0wyYIi/l3PT6UzWi/1pDtkGiQzxVBB/g79afVWcQsYX/v05CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:05:05 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:05:05 +0000
Date: Mon, 16 Mar 2026 14:04:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 12/25] net/pcap: support VLAN strip and insert offloads
Message-ID: <abgOCyUiSMKZ9njL@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-13-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-13-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR05CA0001.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ0PR11MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0519fc-1d07-4a84-cae8-08de836505b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 3ECkrx/aXf6NhMuu0o9uB8vpAlTP5LPRF9waMm1FEuaLYdSUQrGU/nGEtJCnK6DBy43CzngR32db0BXQdjhVsoG8mrmO3t0nUNzRC6dZdeyAaMfwKcXnPUzlZOkWoZWuQomStGoMc1uVrx3uv78n7AjahRPX4cwVFbQWQkgwhOIjO7Zc1ZKEYm8P3FYc42clFkz1HBdtwJK7OEkeJiXyD7hvzb7OvoCzRibzQ5/xU9AdR0zaOQB1zNv6Vc7W13AQ8HqyOT/xQOpRfahsgpSI7mXft9YUguRpvg6kO4IrwCvGsEQg4b1QnJ9oCkMjl1hlWLal2WGlCYKNiXsREsMyESbEurU1b3UpwIP1BGWi+RnSHlFjzJESgk18JJ2nneFV8VLPU60xXXTV49+YN0WGnJ7cNospDQB/JSeXTTyTq6FzUHFXwhkuSnaN8wDXEQZhIsT5reWlRkhBAUqiXYIa9WEtTY/aQPqxEdY8ESkwrf4fnxyr3heNupjWeESBtsedtdyVXnxFC5f17UdfvKGWL9LHQstelYhmHj4vhFdAU+spoMRiWYFI5D1lbLcIsBWKbLyIy0MLlnC6r4ZiKbXq2Dk55ldhfAJV/kweGu2HOc0r78wtIcsIsko4mPxUCpQvJuFBIpOmhvS9194WprFftNqcGA+RkFhKbyiI5O6ovp2UWi43HPtLYanGLdXIrkcIen7Z1ClMdMfLh6NNtjB82kjaGPNcHg0Y+gjUwLcOFa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqK1SD4cYbmgYycMIBMqGv+aPGz8EyCN3/91kM+Ky0h9675GkMnLZ7jspxBj?=
 =?us-ascii?Q?jnxEK/3NFmNm4Vl+VGHkFGvhbwlRTp9lgGI6yX3AK/ul8HJTA/9QzRVSev32?=
 =?us-ascii?Q?NzLbab9TDysb+I3msNrUzmt8JGVtY0bBvEVbS0ku3eR0Kk99IENmHnwWonMS?=
 =?us-ascii?Q?qg0uCta1i7KMprqMU0dixmlZa8aMkdkaxd3twHXsZWpNoka5ND6sDKlkFx4k?=
 =?us-ascii?Q?f1FOAFjZ6t2+0eLCwcCOcvRWXEqhO54n8MoCzIpzaHs2zETjKIYRBAI967Fi?=
 =?us-ascii?Q?AQVukm4jRSpaUx2uMK/1eAzlxREvQX9oO1OOK7Dm220jT1fbeY8A17g12N+t?=
 =?us-ascii?Q?AVX7sWKMYUqultLCKOGmrlouFlUe/Eut1pOzleEcu74Pp6ddZljdqy4ZYwZt?=
 =?us-ascii?Q?/2z/jfr35S9o+ElADDhFKgIotIpzcOyfSQ52fSee+M1auH0IFabmV+ebMtVi?=
 =?us-ascii?Q?RI0Y2ijoYvbx/pr10amrZZwDa1Iq6ytUhRLZviufDiG4Qj5CCdA7aLLxJOlQ?=
 =?us-ascii?Q?QOsTeodk7HhSf47puX1CMrU9eCdjCjlfhUwAJz7OM0/vUDksTL23Tx5HAsw2?=
 =?us-ascii?Q?VfFW7LWV9DtyzBpbUl+mNcGI91K0CfHetpeVZ9ZVodeWee8WdW4LzjIdY+51?=
 =?us-ascii?Q?NSOtnBMtuIMztFJDdXlJ/nH7FGDJaXq85wvg6BVjt+enzHD6W9zW0CJF376P?=
 =?us-ascii?Q?w4w946KSTMms0Yv5bGNz2Srz9SZ9RPv2+s4v3P92eH7abPu7wkytWjS/QUjW?=
 =?us-ascii?Q?alR4VKPpvSye+uC3qD7oLkKjlFbLOGZenE9Xu6P7X76IYqdnjewIn2OQlJyk?=
 =?us-ascii?Q?U4B0+C5ruMQBAgbxN/FFoCk86eLodxSh4SYQG53gNZOCnAuDVbRf0GLexZb1?=
 =?us-ascii?Q?TUtNX7OUWG80cHD25IhDIOjx04s8RdAgHu5EfM/ZOaq9lL1cKpGEsASFQm1l?=
 =?us-ascii?Q?Pi6RToZyFsWPRQjaLWpkk5LlX+tptp6X1BldltQGLCTQSCl/hk0+oxkYwcFr?=
 =?us-ascii?Q?wexwuQvBOPe2mA0u+mA27Fsld4MoRtUM7EK3wHccrg5tfCELz6Yr/29Bttei?=
 =?us-ascii?Q?COLwn0zXuL+ZTGsdTbs4u5gqTy7Toy7pGV7NKlmmr7Kx7P3V9Lxq+a6MFkmK?=
 =?us-ascii?Q?FDSzk3eEyMZRBQ3QqXFI+XzLdxEx3V1yMbz19aFOlnakmYqDas4IR76MWKIM?=
 =?us-ascii?Q?SVXx7uhGQTCpf49ebTCPIMHC7Nzv/Xv71xopP81UGup/iRnL9mDA9k0Xcks/?=
 =?us-ascii?Q?oPlFY2F6JnZrtRhhdClnX1A+RRC09Wzissv1N5cbwuRawP19LWAuSoWcI+5p?=
 =?us-ascii?Q?+QclG7KFBjlWkMvSwv80ZVCJpmdTDyMIb5/UnTfzj0HSYEkvbh84hWiexWYa?=
 =?us-ascii?Q?dIz1scMu+65NFqSYxNe3KjhXnXXx4d8zYmQgFkRg5FL84/FVmllHqRZplun+?=
 =?us-ascii?Q?TdRBWpS3IJ9WMqYqGZHu3e+h+1DuQkFsfBC0i+rZ5debrQ9ua9eS4Ds/ko1E?=
 =?us-ascii?Q?eCCOyQKT0PJFV2W8frLRG6szT3z+VmyCsaxUfM2MhhkweTdxKyq4a7+E4tF8?=
 =?us-ascii?Q?3SvoErz4/ij+5yh90+sNMCEEmw5qD8gqPXT7O5BiLFOekiKeGS5nDnqqU7Jw?=
 =?us-ascii?Q?GUBnp4XYqEFthDp8dri+Pz1YeDdkutZ8Ef2d20biR94ciwtbd8XCIqtNrSmK?=
 =?us-ascii?Q?hREmMm458QA/s1dmV/dB1VUgYbX0dmeWWjhhQJrViByU5lzvfbNx7r408NXx?=
 =?us-ascii?Q?WebnGYlKFvmdmGLDg+XP8sj5dbPL52g=3D?=
X-Exchange-RoutingPolicyChecked: PG8Fjvw6cuRyXU5GHBtVMDflPZSRhqbUoju59To4LpimL2e8d/+/wns1OlNXTN3Sg/TM+To3S3pwUtihM9oovC8OyM9YRZAOZ/dWZGowJaW1pB4p4tDcIFA5amWgCJFVjETdMgTgihY0QQkkh2Gun4/GN4vQ7MWnEU+7qMAP2jEpuHUpy/KGE3EVQ9fIG3EC1eJvWFBr2tHtoYfDvG/TESSOXsV74/JIVrIqT1f/62/vDksAJnph3Ch1d8IxMITqK1cVITmlFJ2pqx7duyTsRHAUBltg5pldHgtvAE2KZXUVlsiTNmXRWzJLAC7iJx5Ei08NMbnO60Ykv++R7wAeRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0519fc-1d07-4a84-cae8-08de836505b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:05:04.8506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqlWpZCbhA1TKDJZ25BBHY4QOqKMXEYKp7u1ot2NuiF8JD8CwGyK5XdTa/x609d7a8q/jHvnYn6WXXjDA4aVGKW8MFXnXJ5SSVypi1ehHhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
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

On Tue, Mar 10, 2026 at 09:09:50AM -0700, Stephen Hemminger wrote:
> Add VLAN tag handling to the pcap PMD, consistent with how virtio
> and af_packet drivers implement it. This also gets used for
> capture of VLAN tagged packets when legacy pdump is used.
> 
> RX strip: when RTE_ETH_RX_OFFLOAD_VLAN_STRIP is enabled, the driver
> calls rte_vlan_strip() on received packets in both normal and
> infinite_rx modes. For infinite_rx, offloads are deferred to
> packet delivery rather than applied during ring fill, so the
> stored template packets remain unmodified.
> 
> TX insert: when RTE_MBUF_F_TX_VLAN is set on an mbuf, the driver
> inserts the VLAN tag via rte_vlan_insert() before writing to pcap
> or sending to the interface. Indirect or shared mbufs get a new
> header mbuf to avoid modifying the original.
> 
> Runtime reconfiguration is supported through vlan_offload_set,
> which propagates the strip setting to all active RX queues.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/nics/features/pcap.ini      |  1 +
>  doc/guides/nics/pcap.rst               | 11 +++
>  doc/guides/rel_notes/release_26_03.rst |  5 ++
>  drivers/net/pcap/pcap_ethdev.c         | 96 ++++++++++++++++++++++++--
>  4 files changed, 109 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
> index c4f0360a06..ec7c91c650 100644
> --- a/doc/guides/nics/features/pcap.ini
> +++ b/doc/guides/nics/features/pcap.ini
> @@ -9,6 +9,7 @@ Queue start/stop     = Y
>  Timestamp offload    = Y
>  Basic stats          = Y
>  Stats per queue      = Y
> +VLAN offload         = Y
>  Multiprocess aware   = Y
>  FreeBSD              = Y
>  Linux                = Y
> diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
> index fbfe854bb1..bed5006a42 100644
> --- a/doc/guides/nics/pcap.rst
> +++ b/doc/guides/nics/pcap.rst
> @@ -247,3 +247,14 @@ will be discarded by the Rx flushing operation.
>     The network interface provided to the PMD should be up.
>     The PMD will return an error if the interface is down,
>     and the PMD itself won't change the status of the external network interface.
> +
> +Features and Limitations
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +*  The PMD will re-insert the VLAN tag transparently to the packet if the kernel
> +   strips it, as long as the ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP`` is not enabled by the
> +   application.
> +
> +*  The PMD will transparently insert a VLAN tag to transmitted packets if
> +   ``RTE_ETH_TX_OFFLOAD_VLAN_INSERT`` is enabled and the mbuf has ``RTE_MBUF_F_TX_VLAN``
> +   set.
> diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
> index d121951f5c..6aef623bf8 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -118,6 +118,11 @@ New Features
>    Added handling of the key combination Control+L
>    to clear the screen before redisplaying the prompt.
>  
> +* **Updated PCAP ethernet driver.**
> +
> +  * Added support for VLAN insertion and stripping.
> +
> +
>  Removed Items
>  -------------
>  
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index c3270a676c..c49ca7fa2b 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -76,6 +76,7 @@ struct queue_missed_stat {
>  struct pcap_rx_queue {
>  	uint16_t port_id;
>  	uint16_t queue_id;
> +	bool vlan_strip;
>  	struct rte_mempool *mb_pool;
>  	struct queue_stat rx_stat;
>  	struct queue_missed_stat missed_stat;
> @@ -106,6 +107,7 @@ struct pmd_internals {
>  	bool single_iface;
>  	bool phy_mac;
>  	bool infinite_rx;
> +	bool vlan_strip;
>  };
>  
>  struct pmd_process_private {
> @@ -270,7 +272,11 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		bufs[i]->data_len = pcap_buf->data_len;
>  		bufs[i]->pkt_len = pcap_buf->pkt_len;
>  		bufs[i]->port = pcap_q->port_id;
> -		rx_bytes += pcap_buf->data_len;
> +
> +		if (pcap_q->vlan_strip)
> +			rte_vlan_strip(bufs[i]);
> +
> +		rx_bytes += bufs[i]->data_len;
>  
>  		/* Enqueue packet back on ring to allow infinite rx. */
>  		rte_ring_enqueue(pcap_q->pkts, pcap_buf);
> @@ -336,6 +342,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		}
>  
>  		mbuf->pkt_len = len;
> +
> +		if (pcap_q->vlan_strip)
> +			rte_vlan_strip(mbuf);
> +
>  		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
>  
>  		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
> @@ -382,6 +392,39 @@ calculate_timestamp(struct timeval *ts) {
>  	}
>  }
>  
> +static uint16_t
> +eth_pcap_tx_prepare(void *queue __rte_unused, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
> +{
> +	uint16_t nb_tx;
> +	int error;
> +
> +	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
> +		struct rte_mbuf *m = tx_pkts[nb_tx];
> +
> +#ifdef RTE_LIBRTE_ETHDEV_DEBUG
> +		error = rte_validate_tx_offload(m);
> +		if (unlikely(error)) {
> +			rte_errno = -error;
> +			break;
> +		}
> +#endif
> +		/* Do VLAN tag insertion */
> +		if (unlikely(m->ol_flags & RTE_MBUF_F_TX_VLAN)) {
> +			error = rte_vlan_insert(&m);
> +
> +			/* rte_vlan_insert() could change pointer (currently does not) */
> +			tx_pkts[nb_tx] = m;
> +
> +			if (unlikely(error != 0)) {
> +				PMD_TX_LOG(ERR, "rte_vlan_insert failed: %s", strerror(-error));
> +				rte_errno = -error;
> +				break;
> +			}
> +		}
> +	}
> +	return nb_tx;
> +}
> +

Are we sure this is the correct way to do this? To behave like a normal NIC
the Tx VLAN tag should be inserted in the Tx function, rather than tx
prepare should it not? There is no guarantee apps will call tx_prepare
before Tx.

/Bruce

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0BCF506D7
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:16:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB3F54025E;
	Mon, 16 Mar 2026 15:16:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B1917400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773670614; x=1805206614;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RZEEwGFOHdWI4fu47O4O8DVjCiS9dR9jXoFxYaElMfk=;
 b=er/FOSkYnCkc2G3C1aDjmEubqNXMN5zXeiE+riD52a6veA1XMye9cC7b
 mhWRYZJRvru/ADN6vvDPB/kqINC6230lDY1UxtMdvjV+CEVc3KKzGXqcK
 3vofKsnI6nFiz6DOzwvZvmY2UfBFeTrvy2CUF2UNs7+NfVjY85Zs4DoZ4
 SVLwV48F3y7Xz9dTJDLDIXvChmlFKtAvbV3nO4TlqvGriuyK++UN9/9qO
 yxN7+VjNpq1Ye41XxW0UU/Md2wnL98Mk8CRXLwZ6zPB/lotr4/27GEzuK
 SuNvNTkr47bf+XOyczgtJ3fU8zUSTSjvkoOjQpyCdYrTJa25Px6R7jYM6 Q==;
X-CSE-ConnectionGUID: fsUtUzJxSHqP7HV8IFAhog==
X-CSE-MsgGUID: RaHTissFRbmrwbCEQHj49g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73705478"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="73705478"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:16:53 -0700
X-CSE-ConnectionGUID: JQLleXkrQumDWzYc6f5+qQ==
X-CSE-MsgGUID: XfAW0cltQPaxMOoj8vUIPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226388219"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:16:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:16:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:16:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPb/P73FMofA5NmZju8UAQ6JO+YliuKuV6ZGPt7El8gsg3oCpzB6lsvdVtPswSSM0YIA4B0PIeRuDR+NzCUlfKRQBHCcFXpc2T9NDLy+FZwT7gV3lx1JEi9dD3QIp0Di14iw/Pk5fO6q+Ib1xtvcM3oKysYYWHBM2+pUr9yloQBwusvC3zoiuKRoM4jdRKYAQGE5S8CJoTKVQCc9+hcscM8Flo3vyXPG2n/s5W/tZb1HifIXXeTrjKtdXr3XlXbEKglyLBGZ4mPQ6hjhs02Dw4bHHvndBK6PsZc9eoiIM6reNcseXJMx7swGnCipTq7YTr+simi/d0IRkxQCp+Onrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSfTnJyhQlEBQHHLwE02JDMCCx7dPKv9k30+D83xuUk=;
 b=HDpp5oqyRcTEHm9ihb+wKKwrbfsZHjdUgaK3IXVjXBjgXJ6Vp4j6j1ABzXQmYlHeVAMsH8xdsxjEsbbxwfpb0xBlZrDX+9hRPYqZPhYTZyi4Dg0PARXMA3jUzagsmvI3rawtmxojIsVj6LlGR/oYdKUoFGO0iMCein/mQkWCud88jwECJiFcjCcgPEgVZKbLmGH3pKsAw/EY1tBeCQLdK+M9izu912PZs1A9dkQq/H5R7tkrvVWphQrK8xYq9epqUJUEPXLtb5vj770zTFc4NLHt0C+BVUTc/vdj4JjWzzZ0KWeTZHbx0FDpRPwLjn8bVnj2m1yhOlsxYk8DjaGaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:16:48 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:16:48 +0000
Date: Mon, 16 Mar 2026 14:16:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 14/25] net/pcap: support nanosecond timestamp precision
Message-ID: <abgQygXBCHeOaC_o@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-15-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-15-stephen@networkplumber.org>
X-ClientProxiedBy: DB3PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:8:1::40)
 To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MW4PR11MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 598e47a7-694f-4783-2d1a-08de8366a8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|18092099006|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 4cy5yhoKj7MTPCAg0MUN6typt0K7b82KZAiz/DeXlPeuAFAq/vQOURtekTGVhcSaBwZruKBPmS0yCC2J3B1/+3mhBIlFGGTEzmqThauky29MqHQ4WbGTn4BSZZO1BT7GArzu2WjrjM07GNK987ggKGx8qpOB213TQ8ofmankA/68AYLVTSIJUaSw1DloU0PrO7TRMKisGgINBlC989spukafuFK7FRPEMAjYAy2OVzXVDno8jZ+tg5Z/r36ySLLdsp8nnNvsrYa2/iXFjM4SvcZAdzpkRL2P0SX+KfT81OlxTPClk2wbxA9im3sQ5/ZxoSBoEqk8iKMC7ciPPDpx7k9iVnZF924SiwTL6X5dLjyF3zM1/Ag6N5RHvghKMdLSw6DtYn1DEkSBE8XCxKGMDM0iowDJMR1H4Mf53i/UwLgKFwrCB6VmJejJvuJLcnX6bDwdycIZUTF3OQk6i4LkEP8WVMEoFvO7pcjgBbtCvp/KRGcBYdcLFic4ZffP0W5u8O/vYhNry1DqEymPa2jNgWCme9t3fM9+sj9pQUAW/dSYcX1wbwwVOtkum3/BjtJmfNSbozFNQ+GPyJkdhdZLizjxoqzkrKNdOfGEvp4E3HpiYRadChWm669aq47gGRg2TghGFfY//1y7ITuFLxIvSzuQkwT7BM7Sp/gZYHRv0Sa5l0jivyk9OO/I58jj92q4I/zNOHKPi9BhW+ZuYpmejyfWyQ8W7AXh8PbgE2t721g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(18092099006)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KAEo96yUV5u+laBfWXFXQt7b+joBjy+yGO2Rdn++e5skLS1z1lkHMFBCLmhs?=
 =?us-ascii?Q?6yir/Jm1N8M4mQe9V35ZbIG93R8rzUw4InMgfiC3MGK4wPZ/GEss30oPE047?=
 =?us-ascii?Q?0BBmypUwHMUSJNsTgS61YSDYOWTvDYrLs5Q6Z5gcNwYoj7xKZ552cxd9VrcT?=
 =?us-ascii?Q?HtSsDgSwCMSjvImAEX7a0nn7NA2TOAuLXqHZVkZUhWvNLOZBRnhy3OGTYMXu?=
 =?us-ascii?Q?vQudL0rl4qmpfYc1OHykM4VYARjzON3n6fqkHw6HCRx7bY97UmqYjY7Kswf4?=
 =?us-ascii?Q?Xtw11ciaHzaYPb0lqpn548OABgkaBDy3V3bNQZrF114+IVJByke5w+oR/C1w?=
 =?us-ascii?Q?+XRfPMK8dkC6z83SvRXp/uw0o914HFKAwI+tbGT7ju294Kjpbfo2YzeF76c1?=
 =?us-ascii?Q?s0jleZjlUwcFnIIjGa6p1aU47srg2mrWmnIgkSfzLBn201eYihHhc7EenR+t?=
 =?us-ascii?Q?LkD7RmbdM6Bx31Z0YS4+//D9jvfml5i082/LNI+Ux38G7yLkaT7ZM6s6H3FI?=
 =?us-ascii?Q?MZz9Bbrclz+8OlOv4pnblr6GAfOOmK1AtGMHvrwnY6ANsZhx7/frRPnf7sXv?=
 =?us-ascii?Q?JPBuMzZMfNc9tqyWx28qmVbXgp9gwiNB8100OZeaM9kI40D9m6lkZuKdww5u?=
 =?us-ascii?Q?j0rP98aWXtZwLHjuEhEGvcjnOs4z5sZxb/etJhSxggit8/Cuow/18gHxt0/K?=
 =?us-ascii?Q?Towg+oo4ZV5tIUenxEm3+1xG7nnJH0D+CiMgOweXlO2v0X1+wiyAlt3ttJFI?=
 =?us-ascii?Q?DKiSBU6SLYGarbbqEAkTtNwsV3wYOkkjiDb55JLDj3PrguDPKh+5MtAbjAZV?=
 =?us-ascii?Q?3GtEu9dSfCcnw0c+khPO8nqq8wX3zljWKBD+vXg8c7mCgxiK96xBmkVbo+Fa?=
 =?us-ascii?Q?kqofNW98IRhpASJktXFdFN8CdelWRGvoZL32iAaL7t9A/SE09nBeX58arcgS?=
 =?us-ascii?Q?w9W/IhQm3v/QJSJXgXe1QzcSwefCzLzI/CGKGtBNuai/JMAvIYsrdWWrl09f?=
 =?us-ascii?Q?HfIwWdRHQXZGQUeYfNw0Wd4K8cjrx2UutSL34nOX4kqwSAm7l4U1G9+OBeBd?=
 =?us-ascii?Q?v0Xs9IN9cbxrsQ4yxPIAtArvbYMDezysDSuQYs9QFEvstm+3erSR0OUs/6KT?=
 =?us-ascii?Q?CKAkncAbu7ahj3lcDnzh5tBnrvrEXb95+tpYuKxgCRRVXJYoQ9FedB8bUY2F?=
 =?us-ascii?Q?B3NO9WO0CZoRORyvQzBJuJwTj5BMpMZGrVnkJd9jKvrVaev3mlk7AdJYtz2z?=
 =?us-ascii?Q?p5036zC9gOICNz/zmw20oQzpLug8EdsTQnM5Ci3Z/x/6YQTWiSfPSdFNzlRL?=
 =?us-ascii?Q?syu1InQaHeyQm2KR92rrXtOMxryAjv1bbmvlEVTjVQNlAz7ihCKxZfDLNo1h?=
 =?us-ascii?Q?8KjuusF3OYEugFLmjaAOnaaGDIruId+yfJvE6F/sKC7tccN6kEu4p7XHDkFl?=
 =?us-ascii?Q?cUgQBcCXLBDqha64H7rtd7AKVY7jATjlHsPx1sM44xIYUM3yKNAgB2OGqOUN?=
 =?us-ascii?Q?K+t5d4o9VkgFdRBefKa82x7peLdqydUz3/lNkOiqyDkfmpdhOycfo06KvliI?=
 =?us-ascii?Q?3qL1T06XMzLfFIor6i6lKtTJXfMG2c0cKDOuquVH0BSQN7sBjrSKMmhyHZD3?=
 =?us-ascii?Q?bSbUc6fo9JEfwM03aa1R/I2Dco/qpJqnipE2Mfj8B/SY1086m5mIemt5S0Gq?=
 =?us-ascii?Q?yXyZOLoduOCTVk0X4BngzkuJZJelDvvNBbQ/MHPkvAZh0tpTA2DphJsrOn6H?=
 =?us-ascii?Q?LAl+kgjEN0qgG7lrqJsIhYZ3CSYhJ74=3D?=
X-Exchange-RoutingPolicyChecked: UPjvNflPQaBT3+/abdJoCq5Oz6x1ZqPL/qwz5GssD8IDhsU2Tls3jq43MVeldtHiVqcXEv2sJM/uRHn/XSihQnaPe5trGX9xu7/ZJCpvtEF6kJl+W1f5YPzRd5IVPVFbcq18gjxmdcqwnnUjqAI8LbWhdVFcEBSU7bCSa5rKdi7gugo5TTf8+kP8TkD/FYbzy/byNQocAIaLvAT24l5YpvAsWznxCoqULW82UdqtUB4fpSHJle273tP9IZPxeF/V6RWwBK0Jat/X889JoCWobQ3EUipY6RE2lp/E1RFIknJ4UyRMGOBI1wVtW0XRq29IMicg5g0BcZuLd9O4Yu5PRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 598e47a7-694f-4783-2d1a-08de8366a8fc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:16:48.0401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTBkl13JJ86GNDYCydb2kYVyu+i5FophxKAFYbOH5zWbFPU4pVtgH7MkaQrxiYVqJMh+tVY/Z5AAQlC+uNBHayEKJIzT1uUHbm1WSbC9VbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6909
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

On Tue, Mar 10, 2026 at 09:09:52AM -0700, Stephen Hemminger wrote:
> Enable nanosecond-precision timestamps for both live capture and pcap
> file reading.
> 
> Replace pcap_open_live() with the pcap_create()/pcap_activate() API,
> which allows setting PCAP_TSTAMP_PRECISION_NANO before
> activation. Similarly, use pcap_open_offline_with_tstamp_precision()
> for reading pcap files. The pcap_pkthdr timestamp field, despite being
> declared as struct timeval, actually contains nanoseconds (not
> microseconds) when nanosecond precision is requested.
> 
> Make receive timestamp offloading conditional: timestamps are now only
> written to the mbuf dynamic field when RTE_ETH_RX_OFFLOAD_TIMESTAMP is
> enabled. Previously, timestamps were unconditionally added to every
> received packet.
> 
> Other related changes:
> * Add read_clock dev_op returning current UTC time for timestamp
>   correlation.
> * Move per-burst timestamp calculation outside the packet loop in
>   tx_dumper.
> * Enable immediate mode and improve error reporting
>   in live capture setup.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/nics/pcap.rst               |   3 +
>  doc/guides/rel_notes/release_26_03.rst |   1 +
>  drivers/net/pcap/pcap_ethdev.c         | 156 +++++++++++++++++++------
>  3 files changed, 126 insertions(+), 34 deletions(-)
> 
> diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
> index bed5006a42..2709c6d017 100644
> --- a/doc/guides/nics/pcap.rst
> +++ b/doc/guides/nics/pcap.rst
> @@ -258,3 +258,6 @@ Features and Limitations
>  *  The PMD will transparently insert a VLAN tag to transmitted packets if
>     ``RTE_ETH_TX_OFFLOAD_VLAN_INSERT`` is enabled and the mbuf has ``RTE_MBUF_F_TX_VLAN``
>     set.
> +
> +*  The PMD will insert the pcap header packet timestamp with nanoseconds resolution and
> +   UNIX origin, i.e. time since 1-JAN-1970 UTC, if ``RTE_ETH_RX_OFFLOAD_TIMESTAMP`` is enabled.
> diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
> index 35a191b45f..b06e1e72ee 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -122,6 +122,7 @@ New Features
>  
>    * Added support for VLAN insertion and stripping.
>    * Added support for reporting link state in ``iface`` mode.
> +  * Receive timestamps support nanosecond precision.
>  
>  
>  Removed Items
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 232b8fa4b1..6b728c6009 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -27,13 +27,11 @@
>  #include <rte_mbuf_dyn.h>
>  #include <bus_vdev_driver.h>
>  #include <rte_os_shim.h>
> +#include <rte_time.h>
>  
>  #include "pcap_osdep.h"
>  
>  #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
> -#define RTE_ETH_PCAP_SNAPLEN RTE_ETHER_MAX_JUMBO_FRAME_LEN
> -#define RTE_ETH_PCAP_PROMISC 1
> -#define RTE_ETH_PCAP_TIMEOUT -1
>  
>  #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
>  #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
> @@ -77,6 +75,7 @@ struct pcap_rx_queue {
>  	uint16_t port_id;
>  	uint16_t queue_id;
>  	bool vlan_strip;
> +	bool timestamp_offloading;
>  	struct rte_mempool *mb_pool;
>  	struct queue_stat rx_stat;
>  	struct queue_missed_stat missed_stat;
> @@ -108,6 +107,7 @@ struct pmd_internals {
>  	bool phy_mac;
>  	bool infinite_rx;
>  	bool vlan_strip;
> +	bool timestamp_offloading;
>  };
>  
>  struct pmd_process_private {
> @@ -269,6 +269,15 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		if (pcap_q->vlan_strip)
>  			rte_vlan_strip(bufs[i]);
>  
> +		if (pcap_q->timestamp_offloading) {
> +			struct timespec ts;
> +
> +			timespec_get(&ts, TIME_UTC);
> +			*RTE_MBUF_DYNFIELD(bufs[i], timestamp_dynfield_offset,
> +					   rte_mbuf_timestamp_t *) = rte_timespec_to_ns(&ts);
> +			bufs[i]->ol_flags |= timestamp_rx_dynflag;
> +		}
> +
>  		rx_bytes += bufs[i]->data_len;
>  
>  		/* Enqueue packet back on ring to allow infinite rx. */
> @@ -339,10 +348,21 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		if (pcap_q->vlan_strip)
>  			rte_vlan_strip(mbuf);
>  
> -		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
> +		if (pcap_q->timestamp_offloading) {
> +			/*
> +			 * The use of tv_usec as nanoseconds is not a bug here.
> +			 * Interface is always created with nanosecond precision, and
> +			 * that is how pcap API bodged in nanoseconds support.
> +			 */
> +			uint64_t ns = (uint64_t)header->ts.tv_sec * NSEC_PER_SEC
> +				+  header->ts.tv_usec;
> +
> +			*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,
> +					   rte_mbuf_timestamp_t *) = ns;
> +
> +			mbuf->ol_flags |= timestamp_rx_dynflag;
> +		}
>  
> -		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
> -		mbuf->ol_flags |= timestamp_rx_dynflag;
>  		mbuf->port = pcap_q->port_id;
>  		bufs[num_rx] = mbuf;
>  		num_rx++;
> @@ -362,14 +382,19 @@ eth_null_rx(void *queue __rte_unused,
>  	return 0;
>  }
>  
> -#define NSEC_PER_SEC	1000000000L
> -
>  /*
> - * This function stores nanoseconds in `tv_usec` field of `struct timeval`,
> - * because `ts` goes directly to nanosecond-precision dump.
> + * Calculate current timestamp in nanoseconds by computing
> + * offset from starting time value.
> + *
> + * Note: it is not a bug that this code is putting nanosecond
> + * value into microsecond timeval field. The pcap API is old
> + * and nanoseconds were bodged on as an after thought.
> + * As long as the pcap stream is set to nanosecond precision
> + * it expects nanoseconds here.
>   */
>  static inline void
> -calculate_timestamp(struct timeval *ts) {
> +calculate_timestamp(struct timeval *ts)
> +{
>  	uint64_t cycles;
>  	struct timespec cur_time;
>  
> @@ -440,8 +465,10 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  	if (dumper == NULL || nb_pkts == 0)
>  		return 0;
>  
> -	/* writes the nb_pkts packets to the previously opened pcap file
> -	 * dumper */
> +	/* all packets in burst have same timestamp */
> +	calculate_timestamp(&header.ts);
> +
> +	/* writes the nb_pkts packets to the previously opened pcap file dumper */
>  	for (i = 0; i < nb_pkts; i++) {
>  		struct rte_mbuf *mbuf = bufs[i];
>  		uint32_t len, caplen;
> @@ -450,8 +477,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		len = rte_pktmbuf_pkt_len(mbuf);
>  		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
>  
> -		calculate_timestamp(&header.ts);
> -
>  		header.len = len;
>  		header.caplen = caplen;
>  
> @@ -573,22 +598,62 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>   * pcap_open_live wrapper function
>   */
>  static inline int
> -open_iface_live(const char *iface, pcap_t **pcap) {
> -	*pcap = pcap_open_live(iface, RTE_ETH_PCAP_SNAPLEN,
> -			RTE_ETH_PCAP_PROMISC, RTE_ETH_PCAP_TIMEOUT, errbuf);
> +open_iface_live(const char *iface, pcap_t **pcap)
> +{
> +	pcap_t *pc;
> +	int status;
>  
> -	if (*pcap == NULL) {
> -		PMD_LOG(ERR, "Couldn't open %s: %s", iface, errbuf);
> -		return -1;
> +	pc = pcap_create(iface, errbuf);
> +	if (pc == NULL) {
> +		PMD_LOG(ERR, "Couldn't create %s: %s", iface, errbuf);
> +		goto error;
> +	}
> +
> +	status = pcap_set_tstamp_precision(pc, PCAP_TSTAMP_PRECISION_NANO);
> +	if (status != 0) {
> +		PMD_LOG(ERR, "%s: Could not set to ns precision: %s",
> +			iface, pcap_statustostr(status));
> +		goto error;
> +	}
> +
> +	status = pcap_set_immediate_mode(pc, 1);
> +	if (status != 0)
> +		PMD_LOG(WARNING, "%s: Could not set to immediate mode: %s",
> +			iface, pcap_statustostr(status));
> +
> +	status = pcap_set_promisc(pc, 1);
> +	if (status != 0)
> +		PMD_LOG(WARNING, "%s: Could not set to promiscuous: %s",
> +			iface, pcap_statustostr(status));
> +
> +	status = pcap_set_snaplen(pc, RTE_ETH_PCAP_SNAPSHOT_LEN);
> +	if (status != 0)
> +		PMD_LOG(WARNING, "%s: Could not set snapshot length: %s",
> +			iface, pcap_statustostr(status));
> +
> +	status = pcap_activate(pc);
> +	if (status < 0) {
> +		char *cp = pcap_geterr(pc);
> +
> +		if (status == PCAP_ERROR)
> +			PMD_LOG(ERR, "%s: could not activate: %s", iface, cp);
> +		else
> +			PMD_LOG(ERR, "%s: %s (%s)", iface, pcap_statustostr(status), cp);
> +		goto error;
>  	}
>  
> -	if (pcap_setnonblock(*pcap, 1, errbuf)) {
> +	if (pcap_setnonblock(pc, 1, errbuf)) {
>  		PMD_LOG(ERR, "Couldn't set non-blocking on %s: %s", iface, errbuf);
> -		pcap_close(*pcap);
> -		return -1;
> +		goto error;
>  	}
>  
> +	*pcap = pc;
>  	return 0;
> +
> +error:
> +	if (pc != NULL)
> +		pcap_close(pc);
> +	return -1;
>  }
>  
>  static int
> @@ -635,7 +700,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
>  static int
>  open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
>  {
> -	*pcap = pcap_open_offline(pcap_filename, errbuf);
> +	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
> +							PCAP_TSTAMP_PRECISION_NANO, errbuf);
>  	if (*pcap == NULL) {
>  		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
>  			errbuf);
> @@ -794,6 +860,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
>  	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
>  
>  	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
> +	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
>  	return 0;
>  }
>  
> @@ -811,7 +878,8 @@ eth_dev_info(struct rte_eth_dev *dev,
>  	dev_info->min_rx_bufsize = 0;
>  	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
>  		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
> -	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
> +	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
> +		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
>  
>  	return 0;
>  }
> @@ -978,6 +1046,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
>  	pcap_q->queue_id = rx_queue_id;
>  	pcap_q->vlan_strip = internals->vlan_strip;
>  	dev->data->rx_queues[rx_queue_id] = pcap_q;
> +	pcap_q->timestamp_offloading = internals->timestamp_offloading;
>  
>  	if (internals->infinite_rx) {
>  		struct pmd_process_private *pp;
> @@ -1116,6 +1185,17 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	return 0;
>  }
>  
> +/* Timestamp values in receive packets from libpcap are in nanoseconds */
> +static int
> +eth_dev_read_clock(struct rte_eth_dev *dev __rte_unused, uint64_t *timestamp)
> +{
> +	struct timespec cur_time;
> +
> +	timespec_get(&cur_time, TIME_UTC);
> +	*timestamp = rte_timespec_to_ns(&cur_time);
> +	return 0;
> +}
> +
>  static int
>  eth_vlan_offload_set(struct rte_eth_dev *dev, int mask)
>  {
> @@ -1142,6 +1222,7 @@ static const struct eth_dev_ops ops = {
>  	.dev_close = eth_dev_close,
>  	.dev_configure = eth_dev_configure,
>  	.dev_infos_get = eth_dev_info,
> +	.read_clock = eth_dev_read_clock,
>  	.rx_queue_setup = eth_rx_queue_setup,
>  	.tx_queue_setup = eth_tx_queue_setup,
>  	.tx_queue_release = eth_tx_queue_release,
> @@ -1558,15 +1639,22 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
>  	name = rte_vdev_device_name(dev);
>  	PMD_LOG(INFO, "Initializing pmd_pcap for %s", name);
>  
> -	timespec_get(&start_time, TIME_UTC);
> -	start_cycles = rte_get_timer_cycles();
> -	hz = rte_get_timer_hz();
> +	/* Record info for timestamps on first probe */
> +	if (hz == 0) {
> +		hz = rte_get_timer_hz();
> +		if (hz == 0) {
> +			PMD_LOG(ERR, "Reported hz is zero!");
> +			return -1;
> +		}
>  
> -	ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
> -			&timestamp_rx_dynflag);
> -	if (ret != 0) {
> -		PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
> -		return -1;
> +		ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
> +							 &timestamp_rx_dynflag);

Should we not check if timestamps are requested before registering the
dynamic field?

> +		if (ret != 0) {
> +			PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
> +			return ret;
> +		}
> +		timespec_get(&start_time, TIME_UTC);
> +		start_cycles = rte_get_timer_cycles();
>  	}
>  
>  	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
> -- 
> 2.51.0
> 

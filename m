Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC35C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 08:19:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 597ED402D8;
	Thu,  3 Sep 2026 10:19:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 758044028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 10:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788423592; x=1819959592;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=i9Ym77pEJtGGpgk+vvobfWYxi+vG9nAR8WzkYfSaEyA=;
 b=Hwps5aWr2wJHxRtqr8Ap8NaEDVzkc6SQISsm+fLwhSY1qFluSqF4/VTu
 8zp15k+RPnUK0PU+ZfxAVFJqv2gHpdew2cWHgtessJZYVRXbGzMpn/5c8
 N2nXsV/gk10Fqt8q12G1JJOi98WaXHWuo8loGuuT2I6hLMJelt7To0+lV
 ayP09wyDjFzU7YErWm/cNBk37isB2xy7lxZxii995V9Ib818wtFfi48wo
 /jhwgwpsu/3ArURuBbQiLbXjH5zxAcSQDK5C4wfkqi76bEZjIJFSKbJRR
 NGAjXUqY549o34FkO7SyjiFaJJ5WeA968Au07leADRcsTMKSFiuwHeCmn A==;
X-CSE-ConnectionGUID: iTCkAH9ISWm+7Hm2H/lxAQ==
X-CSE-MsgGUID: /Iw6mG8zTl2ZAaRITT/hpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89016922"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="89016922"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 01:19:47 -0700
X-CSE-ConnectionGUID: 08wBKasIQgOaEvFnwNhPBw==
X-CSE-MsgGUID: 7bdrhhYMQfqq2pmYgrvnTA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 01:19:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 01:19:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 01:19:46 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 01:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8eB0I3DUzzqmFzZumL0j0aYdMe8Ak4q2bsQH5LIhcLNobK1aat1fS4r4lnTbLE9ROLENDEpM9NjKgA6dL+FK+MbAiEY51yzECUoa1jOC6Hf570jnmmMQdOZOyjq+ddqENFp0UNeGwb79eEomXBdB9q+3YT35zHgpwQjkAtLje/G8xJSzTQfMcVx7rOLxU7gYC487qW2kzjRaEeVsAH7J8IMkZqwM7EijDCmoIfbiLqnDBEaC7jCW5kzeyPRsd5B5aGOA080XEcyoc6Tz4uCx6cpSTljXGhjMOGL6R/TkXuZQPtF/UPLQ/TIaiizBAIDNcNWIDtUA62USNgevxDU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZvQikUKgfECo6CGsuGURuCjI26j68bXAXVvFE+jA8o=;
 b=WhrTOLgZyPXSOH3q/axVQaqEXk+n2/xe8Lru3O5O1rW+1vb1VZ0DL47Uq96zV0PM7cYN+oVaWOySjJuQvbX3utBpGHMib2i9pr21GzKZCQ2dt3g8Ppjzll498cUfmPMd4IRZH5Mzq9XczKAb5yzP+ipkHCbPyvq3G3LeHjch+voZJB6iQKHMMrixxI+/PZH46LTRMioIvF0V3K5iJKmcRiRa8RnjZvsB0588EjNJKUPot8aOu8rkCZiyTPJHzxa0Cjl0jwISDj0efeiPQUAHDvLslCJqCI3WPuid/tkNAXo4fHE7/RbFdSyYa0CI5NEDJRZZqlz/QAEccvSIqkMLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:19:44 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:19:44 +0000
Date: Thu, 3 Sep 2026 09:19:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] telemetry: promote experimental API to stable
Message-ID: <apktnD0DgrDqxZTf@bricha3-mobl1.ger.corp.intel.com>
References: <20260902232630.543215-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902232630.543215-1-stephen@networkplumber.org>
X-ClientProxiedBy: DB8PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:10:110::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f27a1d-ca56-4c3a-4424-08df09941bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: LUe/8aV21YSVNRbzRORXcFf7k2gPf4fR/D9myonLoHKliAD4mS6JScW+Kuu4qloUQ/gKsa2No1JR/T7zo6VtXjvkcmDNsT7Wi87/oxyV18P6OWHTc/6c+K3/5Mzx8iWM/rFDvrzcdiJVuoZzViCSaV+5arIMYGm2EHbOJZNoi9x4I8cEMOkYuOLSM0QVyYU1pTQtygLxG2+D/I1B7V0OVlAykymGE1XfaF7egeOwE+RholFzadmJAXthBOwQoObnO2dYqg0O0UPn/9LoW5BpFValDvK8+2W4hxnJBeTe1A3ZizzGXCNUkYXi2X9ygLOIi2fniA6W/iAOt1sxo4GtUBhgmTNVcnWk6lF8V2UxatQw7l7yDW3vsF+GZU9TdHvXGh5UJ/8u/lKuw4O56t9CR6etoQNIq0wQcyhN/HUus9BOgYJKi2/id0jq6PXGonD+oSm7UA+SWhm/hxoC+D9yqMD6Gz2TLTG6OZB99nQgaE1HFsf8TLNPYeJfjhIzHfOKiJxjCez8XfBz46IHUP/zsdwupsbWSIZqaYn8aLj8WKkQ2VeTVcserXsMMpJ4uKN/EePVui/9O7RuquOJTUIAujgqpqPSuX/TlsRRW1kBRODRFbiEbQKZfqzCzlkSvHs2qMx566McbIDRGPUNe4KIHWFLxOVvRsxl8vWUosllezE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ArnElEngynUJbkpXIrCUmnuZUjG9h7kuo0UUFwvgoNpqQ7J8duVPV+Ht2zW?=
 =?us-ascii?Q?xnN5X/7QFRbnRwYNKtvENbd4BUjZ2rWzYgIGRLcXTdCxg9AIeilMVzZ515BV?=
 =?us-ascii?Q?uaVoxIiuSVaWCoqSJCD1rDgTlxD5lfZe8AJngTLW+sW4HP0mzKrX2RRr+zGo?=
 =?us-ascii?Q?ugHwpJE1ggdiF45SsO6EkHUghXc5fe8mqwVrpQR5IEU/YrAdwn+hJ6XBWVGp?=
 =?us-ascii?Q?Qhi+hjUMyStQf5WbVADlL2FeXi0yFxnawjJ/PrxRd5GudieJ7DcpbhUtubl8?=
 =?us-ascii?Q?v0Uv3ArhUW4X3vtC8X4zyx/yx/xDCdl8Vpy0uqxLZRClg0ukbAUWei1adfiJ?=
 =?us-ascii?Q?Nu8dtKbZCT8ZafIv+4TTfGGFo06PP5zzlJqQG/huODAnB2KeLcIL7ohYW2LF?=
 =?us-ascii?Q?ts8+mvmuNnzRB1lPtoJ1+/xAQeMfxLihRtug6QXFnfDwz6y3RnRHxUf2r9F0?=
 =?us-ascii?Q?7/VbybLaz1einmSUNoy+l/3Pu/p5QnVcaERXSoOh9g0dZAQ014enaJ4g3cB9?=
 =?us-ascii?Q?jWz5ODOz19c61NO0Ep9Haj3IOCd1FkdyIwfInC4NNJbtKPbsNbimp0hzagq8?=
 =?us-ascii?Q?W6TDIfhhPU9NzBtbFaTkKgV3DrCNqRw6q3aTieK4wQYDDQoFIkLvqDr7QcsL?=
 =?us-ascii?Q?l99xcP1RueAwEomAxtW4W24HvUobbgt8YVU5b5xevb8CZF0KvbRB0AJLvE4w?=
 =?us-ascii?Q?fDOrIRbkEj91PrKt3f6ppHCk1W08qs4FlnJL6pAQgQI8Z+/iVyvJE03Dumxw?=
 =?us-ascii?Q?Nrh8tfomlMdsj7Pdk9XpFX+vmrfbOHq5v1FdVHPT1LVa1o0Smgm+TT25uXYG?=
 =?us-ascii?Q?qCTB+7s6yLANP2pkLCxX44rM7WrKUnXxWutPF/5mPEHX5k9GZcD/kLQUFKjK?=
 =?us-ascii?Q?H2fl+vBPpLmN7QjIsMF4yhSp2rE69y52VvivrmFuEq+4QVINZPG8gE7nyIt/?=
 =?us-ascii?Q?9oONQtLX7ia0S9wp/mbPPq3CwTXILNAzC57PWny1fzBYt9p87c2VZqDVDvxV?=
 =?us-ascii?Q?0eIqB/+BTziZUiTvlmr7pDlTzTQhsj4HJvsGz5USqKTAYYdBQdHK4T0aubZb?=
 =?us-ascii?Q?HtZjUeuk2u4AUt+9qey2hBQdY9Ho3IRAkpPJa3MTphmd/Vp/ykQXoGyWjcFR?=
 =?us-ascii?Q?myRqrHaJB9NdNN1PBjVmizHej34m/u1yKjuv2aE5xTs6KpPvuoaWs7ltfiEK?=
 =?us-ascii?Q?B0wdvDWsBNc7gL/KgKlP8aawzZOhiXOUnbXpqbkDSlKmrZfrRub8pF04/DOd?=
 =?us-ascii?Q?beKVbm+SUiXnOYl6CISafb8N/UxAGNrh62ij/k4uvjXe7lTkP3fSjk+LctIA?=
 =?us-ascii?Q?C1ERzhtVbij5hfwgEScX22YeSlua5Vh2L4/zvquxXq7FqYzMj4CLPSZQ4v0m?=
 =?us-ascii?Q?bO2H4haNH24CHz3igxo0pGvitno+/PXOvby7/FCiturqyUUYjveP/+zyz4s2?=
 =?us-ascii?Q?ndOQq7zRNYE4O092YpR9eUVd1NeZR5v93hzwXmjpVxt+E/cY6WW/mrHjM5oz?=
 =?us-ascii?Q?dqwQyLCCZ8HrcnFLsp3SUwzRQ4Un8j5jOrim5SBbwlSXjmxbJfcQxat6AXOk?=
 =?us-ascii?Q?r4Rey2gRyXxyQwtrDhcrTNWzrJhcWW7uWHZRxVIyLDnwE7ktjAJGY6lr1bSa?=
 =?us-ascii?Q?JeMCNLNyaHOcdJ4TxqKivOXNxTFF3qoFTpP749xihtJFNIXXLH0STeY9qa9S?=
 =?us-ascii?Q?rI90ZLAFInstf+KIyBaEHKX1Cwc/M/iynP2kgebvrtuqCPxm1gYu3gwWyy51?=
 =?us-ascii?Q?xcUpRjb51U/wL1Tr8nCNM0TkjN/hDRc=3D?=
X-Exchange-RoutingPolicyChecked: wKlkhoqBIU3Xwd0AvE2O5IWqjh1Fcn9oQXRy7tL2wv39ND+G3RrHSesyyZT9jhsF3nWUHecdfZq/+S3O3DOdvPSHcLsCzRVLEEPPIFC1gJ7KbuDmL1RCbssMokUYe601P5MrnB51qMjROaN5IzOu5YX8G2YqVhPwmOSZnkHw2c71hCQb9mtwNPm0sGJpO2de8zlaqCYQo7Na023GPMN1LfrIxYxMGi/RckqECAg9YHPH5yXCtxmm4KIt0sVeXy7t0CtTRqiUqqR7sZOPDQr178UIgeL5BATaJYey02x05jRTf11vxT1/Kup6mY2ZF3T/zlwTTf5Z9O+zk8iZLXoWzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f27a1d-ca56-4c3a-4424-08df09941bf4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:19:44.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4f+LY1YQSSuv+faYqiS3PsnQeW7y52x8TcXjrXJMlIAQ8FxLqAZ5iYCig4FJ46xJ4NFbxzEgx8x0VrxEc376b8dmK416yetL9517VoK1fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
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

On Wed, Sep 02, 2026 at 04:26:30PM -0700, Stephen Hemminger wrote:
> The remaining experimental telemetry functions have been present without
> interface changes for several releases: the hexadecimal helpers
> rte_tel_data_add_array_uint_hex() and rte_tel_data_add_dict_uint_hex()
> since v23.03, and rte_telemetry_register_cmd_arg() since v24.11.
> Promote all three to the stable ABI.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 6 ++++++
>  lib/telemetry/rte_telemetry.h          | 3 ---
>  lib/telemetry/telemetry.c              | 2 +-
>  lib/telemetry/telemetry_data.c         | 4 ++--
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

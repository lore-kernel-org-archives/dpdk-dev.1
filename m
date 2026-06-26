Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52877CDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 09:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DF184025F;
	Fri, 26 Jun 2026 11:49:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B9C63400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 11:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782467395; x=1814003395;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=b6JmCSWXHN/ofEX1zPLvxxrV4p4cyQcm0yuB0gD96s8=;
 b=VNtA45U51wkVrfw3kWgOl7LDCOEqmQRfzSIfwl4izC4mU+S0fbpxmXI4
 kwK/n2fHNhQJ7tom/3F8Lm+rc99E9PYs+AuwcC0jiv5uDRiSgsWMiLQJm
 taKrsHtBv26Eql6OaziUPbZ2obSy2ZbbxbUJfwoodfD6KXxMlYCSuvI3L
 KE3Z/pIu8xz968/48+/dQgEQZFmrDQs6n5gEbG++gmrrbM1KMuaR27Y3t
 hK8VbneKJ3r80I5UMbe0o+GnCc4RNurjjmf9+Cor6PrPgJoC9SaCU5cv3
 Wx8l2n+GZq24mWBX4FRuMh13ric68OhL4dHSqf7v15x9xYyrnnKtylPlA A==;
X-CSE-ConnectionGUID: OPRp0t24R5ehzX4qecJDxg==
X-CSE-MsgGUID: 8o8Jz0wpR3+eLhmyrNa22Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="70780718"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="70780718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 02:49:54 -0700
X-CSE-ConnectionGUID: Q/USGHkfSsKUGTIo5WWMng==
X-CSE-MsgGUID: WiL59hpZQKaIxvIU+rCSew==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 02:49:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 02:49:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 02:49:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 02:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHyFjfW0064VC+ljGNZ1u0EK4HAQmKG7E/GKi2A71y4pX8zwY9+KjlFst5EE6BfSwmuTBvSD4sn+GLOtNIyhsLsdqjqUnYHH/2YH0hWRVmDD28QsGe1PPkBSAtfJGA1MCW9bmFDRXXc0WP7AVsKLCuEP/Gza9TzuijBMqFVupPES8xdZgDBGsMov1RGoORDhNuN6jmNjdhzPKLAdS+ffLyY4ncPobZIO40BTF0qAxijvWKjpWECjXyZlRJGekP28rE1P/j6pQligCB8POL0nHLEOyGFskFcrroGV69xQA/4RDndphFvyi7P+ILxsEov0/84Ib8zOXnAVyTH7RKhJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvF46px09t1HTCCqg8EeIPZGwqCtbgee5ups8cPudUU=;
 b=NEUtCgIMAveNzdOaXMtJfNgxS6t4BGLNbpuTzgetM6xrrGyQMvsdk67PqV2kJLV9e1bwCozta3P9FdC9o6yNKrFUpgf4KOTKy0QafJfJ/CmylYNZj/9Vgqd8IZvJM42YL5UtuiUfpz09X581vssWE2zsVjFNVG0pYYzteS7mdaKJt35pwc9KFanpPNtYwX4QskPJn5B8ONaFhR0E9Yhg4uKTOii99yqhxuQKL0+N5Kp3F5QxTU2DSyEeaktixZT4O6YtcDcNtlYtubthhnD+wLuMKXLVVvFE2catUKbJvWOJ7c2DBjpmWROJ8SGPo+fWRD2SjxQm8KEWATOm6hAFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS4PPF2A0C3F85C.namprd11.prod.outlook.com (2603:10b6:f:fc02::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 09:49:50 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:49:50 +0000
Date: Fri, 26 Jun 2026 10:49:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 1/1] net/ice: fix NULL pointer dereference in DCF
Message-ID: <aj5LOTUlfWrwB1ZL@bricha3-mobl1.ger.corp.intel.com>
References: <5fc2bdc0501a03687b4155cc847f89bb76687c0f.1782402538.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5fc2bdc0501a03687b4155cc847f89bb76687c0f.1782402538.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS4PPF2A0C3F85C:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddafa2f-4dd6-454b-142e-08ded36843fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tKauxKbxhWOPWi0LwASwzhWgq1HHNFfjuh1CD4btuZAL4dgc8zGSirEreQI0PJN1P68X7H9Ejzu5yBiFiUEAPWCEgwSDNTX2wPTlbOtl2+F1Gv5c1XFlzwqulNHt09p2+vM5NgI/Ubhf3EwyyfXMG5xXaPh6n72wB3IhAdMEE8/FgL/u5zVougeikX088EMHX7SrkgKgz0QqkJYw0F2zO2AMUoR7nGXcDWA0l5Qx9LNwT8gNF3Jdeve3SuJS6UBtLF4X+VSSc5vdNbikweSq2oF4z90hOaOO8SiFheeQCSoUu8s/rJZZ0ExvJd6sjQqkc/8spADQVgjIkUotrwsej8jPPiIOZ2mz2HIpdqZjrm/U+Qxxn0B3QyQR86yymOBJDSYJCCP1EMFiFYQLPGdpoS6ux4kyz7HWX2VyIUZJHUzLVkvb7haLjrVmzRJUV/AO2tUbWTGC5n3MmhAzgz5GFkCmYBDt6x+d/cBJcw9Tfct1rxYD4hghG5KpQ6K2uA9jNnEstuCA9CiA5qEg45EZOzEAKSbOqd5bRbeJqqYEE330xccoqsI+9xCBPsKn9Am+qQpRIMeNQcyj04a5tzAUZ+uJRQqLdE/QTB9SaDVJdylqU3CPuB8emlGq07cQmQiUztLL1c4EV+3yl6/nCZg5bu3KEY0kCl1aAwaghOC8GwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5LNwC6xa9DKKAy5n7Mckhss8dbtNl0/tnr89f+1kOQ43OhNyRHcbRpVwrIEt?=
 =?us-ascii?Q?MVtE13Z7YciH2UT64ls5kO4CUBCIJSM1ibS+RndhpwhtFdgEno/Fr16iw2ew?=
 =?us-ascii?Q?amIR9gPvoUTx4Ds88GKjC24udjMmBOkh5RgX2WfimdcjPgrwLnty+T8AoXyP?=
 =?us-ascii?Q?F6hWwC1+eUaU2LIGq1me2gkZblRM1f9CIFPP/GLRfP5Y5TFuH7r9BUjtsOL5?=
 =?us-ascii?Q?z4nX+k4PwaB1IPBRP2ZQGOI5gOWUI8DPp+xvx6gJe/JvMieTwOoFnKj2Mspv?=
 =?us-ascii?Q?JXWgZl8xyYNmrNueoFNrK7Tvhwbh2G502qCViTC0Jb8IhGH8Y3WT9d5U8/2S?=
 =?us-ascii?Q?czNEKMfRud2if9sAXL8Tj1g7GWyHC6HRnss4xR/OjguiHQi5mLXueWhVN3zW?=
 =?us-ascii?Q?qyS0GRtVzaNGW318Fn/brGvyuwPugkxQw6EA0cyvqWdmTbkVhUA09dwccos4?=
 =?us-ascii?Q?SHscg5QCC5Q+QBC3tcykqJ5ibkrrMbq3LvIEFxJLR5xYISE299NDvbvn7gt0?=
 =?us-ascii?Q?6240wDuLPvZQgTxoxLGUzwsa0XanuerDtHJYxSra6ngmWY6Do+hvydTa0Uv/?=
 =?us-ascii?Q?IKFlteAjOVimIwNBgQPUO3pH4u2hyem+cTKtHjNgA+aKdxF6alkJNDWrHEij?=
 =?us-ascii?Q?C+hq7UICqMg8I5LpuGocxyMTFaGJsnTo6Vaox2RYb1G/d6FEd4SZRT1riO/x?=
 =?us-ascii?Q?BDB91RrPexNCx1Eo2C4H1UfD6mvxOd1B9u1S8SyYq02hU5VHB8yGUJ2I+efb?=
 =?us-ascii?Q?pc+dANrHZrDHZNLCqJASx3ubJhXD5kBHvJKHq0f2NpdT7h1AkJCF6GxQdskE?=
 =?us-ascii?Q?LGNFOkmtwZbkR2f+QLvsaOJUSlKDXXxIfk1GjNO1eAc+p+/LoiwGwWxWHk4m?=
 =?us-ascii?Q?kS+C0J+9aS0o+0nfMcTbspbLHrRg0VCA/DDse3OX3vl8rl9nOYKs1QHsG4MR?=
 =?us-ascii?Q?yOH1BbQ4JHlERJUBZALb3ohjW70IPbVesGtagK8abEjNpIPARDNARgU4uMkH?=
 =?us-ascii?Q?+KYrpgWjEeHyX12aUX6BST8Rwu9+NSLrivs6AF1BPP9ljcgR7niJX0d7Htcx?=
 =?us-ascii?Q?hu86Jzzy5mcEMgJTP7QfIWX9tZbW5WXC0eEE2tDJVPiql9U9Qr0NqsbSKioc?=
 =?us-ascii?Q?4oCT47p2VGuj8nW5s6B8D6fIu6LkVMPm9ZL8plaH2MOzpC7nl8IoomE8Snl6?=
 =?us-ascii?Q?XB6JvXpfvmU4WCKMS7dOankxehxywct/PgATJ9/+n9CH94DYfo19gLHen83b?=
 =?us-ascii?Q?7f5q2g6Opi72mWGIIPaEHMj4IgZNz9KrCmqSnyn12Nfg3J/vwHwFOMjzNXeO?=
 =?us-ascii?Q?l3CWZ5DYTVTuKlb+sVOJaWWHXje4aQz5gGYD8cyS6TnyU8ciVyLukqmQV8Yx?=
 =?us-ascii?Q?PjC8m67fEj60j8PMAfv8ORHKbiHc2b5rv0sRdC7VsvEK1kx9kulgGmNQvets?=
 =?us-ascii?Q?cSMy75AYCMfJBagQoXjdxjVSHXX/5RRFH5vNDUQlOF3gOXE3F7CrhDckGncl?=
 =?us-ascii?Q?ADfIHmi7ZN21+2IHl+M/Sn68uxYP0+SHaVUsBC0E8WXbwOQcbdaxCBb095g5?=
 =?us-ascii?Q?J7HPp+yARGHCWH4H0NdCJGE1V+JDBL4oI4IbykgQ0g6lASKP7HUcTxAzTFgV?=
 =?us-ascii?Q?28M1t56hrDZkBkJU4bQ1bS9uEDjbcrfb4tC/zZJ+PPTGSjxkNmAJtmsVQ1IB?=
 =?us-ascii?Q?pUhb/SJsr9BTZKj9hb6h3sS6Jmjn4bty6wPEqFbf/L77gAVS4l+l5U8y5Fh0?=
 =?us-ascii?Q?oELAHCoUTeWoVrNPCSxFF9lbsCJ/maE=3D?=
X-Exchange-RoutingPolicyChecked: gWzlRrEp7tKLqJrTtFCQxzAGA/8w7AS9/tanlX8RwoqjjdY4JKIxxuwurAKzuU7ccWJQILTKjms5vQ2yVdTMhelT1LVOUyznjnNxzJpiTx6ZUKTajZ4VKcwlWkCJnvqbLqRj+us2S5hr3JgCW1Suol5nmeQ+mgiUubAUreTkySc5HfiOiLYwm7ILigU3qKH+Yh/jsimaAP93D9PA46LXxQNpwhRcaFPpe1hFd/PJzfNeTjcgUqH1SboKy29ni1yeuiAm7F48sQ02XbKJQnipt4vNfIz8LnxMj3S6N5QOIs1AAx+24HnioNQLdfjVaKnJUreGQn9BTJOyS9lWnSAV4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddafa2f-4dd6-454b-142e-08ded36843fe
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:49:50.5937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQC0sTC96jza3GcUHzSbOlOwcPBk4QQvtzeA13WKKEL/6bCwQAt/NWIapTB9FcUbJQyMoF6SjeDb/s3bJ+UxKgpbKPAKiOc4PiYsIZxdf8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2A0C3F85C
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

On Thu, Jun 25, 2026 at 04:49:08PM +0100, Anatoly Burakov wrote:
> When calling into common parameter checks and subsequent action check
> callbacks, the DCF path never supplied the `driver_ctx` struct, yet the
> callback itself dereferenced the struct.
> 
> Fix it by supplying the DCF adapter struct as context.
> 
> Fixes: db24a8092854 ("net/ice: use common action checks for switch")
> Cc: vladimir.medvedkin@intel.com
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce

>  drivers/net/intel/ice/ice_switch_filter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
> index 5d9e0062af..6f5af03f6a 100644
> --- a/drivers/net/intel/ice/ice_switch_filter.c
> +++ b/drivers/net/intel/ice/ice_switch_filter.c
> @@ -1773,6 +1773,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
>  		},
>  		.max_actions = 1,
>  		.check = ice_switch_dcf_action_check,
> +		.driver_ctx = container_of(ad, struct ice_dcf_adapter, parent),
>  	};
>  	struct ci_flow_actions_check_param param = {
>  		.allowed_types = (enum rte_flow_action_type[]){
> -- 
> 2.47.3
> 

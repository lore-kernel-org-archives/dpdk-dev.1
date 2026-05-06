Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118EECD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D331D4027E;
	Wed,  6 May 2026 17:11:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 268DE40278
 for <dev@dpdk.org>; Wed,  6 May 2026 17:11:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778080266; x=1809616266;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bCkJ5unOWdC1UKN7FbhmPaSuVOwR5tZvDzpOGRPLKHE=;
 b=hiIxdL6+rFpMVxIFFJQ937nYON+4WQTM8MdNaz9zTmEJR1rdhLFiIegp
 Et93tigcA8hTiVPRRSb4w22fEs4IwLUZV6QZCTv2aPkkIlfIWh+gxPeYM
 nTVggI90hhq4V+e0wtNgfOyOfbcGiaOl0uehObTBTBClBAzwbTSBvlGcP
 eAlg07Lp+WthNQhTp0oXTZ89pwH2l6e1tfLdsynQXja+3inZyT/iVsezR
 ROMCGrVAqr3eg5bXkjP1jg9jI2jwSiYs2D2f+WphepoPTDY1mpD7HZ7b9
 +8+hkKD5KL6z89jcvEM65Irp2JZ7xg/z3vrtX+D9FYMJXa9P/W3DxxS6U w==;
X-CSE-ConnectionGUID: /tD82XBgQ/Kn2+sRxAWsLQ==
X-CSE-MsgGUID: aqQVo906T5SYbmK465g8fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78945527"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="78945527"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:11:05 -0700
X-CSE-ConnectionGUID: WNT26MbsQ3iaWX8M4FlWIA==
X-CSE-MsgGUID: QZUY0qjgSryZpR+U75/wFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="237988754"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:11:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:11:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 08:11:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8y17u4ZSiBvvmFVA8R1yZF5OwMWykQaw3otBRP5vs8rGuDg32oGvWemfeIeuw9iiEb16s7F7aoXLo/MaRqCosrK/dQCAQthxgPwaojyqrV73O3/JJ3mg3XYwYFzZ6pRWfP9IqPqME572i2PwXdyPSaUhELRIYuJ+eQWoT6G2hregVDOSAcgXVBjVv/pLCRTVOqCH3V6rAVazMy/cXc75dA+kB/cVtfZpsFg+MnMADpbWw9p5dEJjkzareCzSUGGRpmMCRB99/AmOUdyLaMB1aCZehc3RfB46sOJbBhAgiVle+9XMDk1CTYBHAfWl9uCAIWpEWa0m+97FUkLKn1PBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nosvEr3jjhNVjcXpYlKu7gFRx6phyVmV+rPqTLTAFAI=;
 b=JikdCch6fG3fq79OPHslTSpeNE8ITAvXZrxkvaHjVpd5EjsOOfNDrutm7alqE2owVOf/RWlPUDPJAQPHb7b2x9qM1SoKDmtQ1yZnMBdGqyS2jvV4drXh0/RzN1M3A6JP5/1hT4kxZ56Y2D2fJIUGayOCbJeRGS1YPTv7a/Wuy+jdgZ2+s6pA7VcKyoRh1GTRc1HPs8OlcQ/Glqrx/YtIoRQ8Argi9v4rvwsAvSAdrQumQHetb1fTI2s7xyc9+/Udarvw9k2cvzxXmZ+RZDHmdflYgBe0s5slA8QZJ4YL2X/rC5jW3fZoqBdEMIWSrAXZ/kNwnyoxqCrhR8gAridfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:11:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 15:11:00 +0000
Date: Wed, 6 May 2026 16:10:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 1/1] net/iavf: remove RAW flow item support from fsub
Message-ID: <aftZ_4yoZWjimNia@bricha3-mobl1.ger.corp.intel.com>
References: <34827309e49eaba498cfe41500ee8de1fd3a2bb5.1777542270.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34827309e49eaba498cfe41500ee8de1fd3a2bb5.1777542270.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0284.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ccc21e-29cf-43a3-7aee-08deab81aed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: VB1CAoo57fzapLvNExhu4Rpl/1evSbYu5CMfh2G43RW6lS7FJiaaLnnTeKGL5BCRp74q52zRtkJ/rg936NmYsJQeCNYdO4mdyPrIKC6aQEOFtiStmOsQlXK7SevxJiIqt1FlabKq2KZSp/pD3OXsAhk3jbKMqsLwf3ox/AvSVUGMJCAHi2zQXPzJT8czk6xqd93a47ezZUouhZGywrUft+PFk5STE2FHyjgq7YmSMPJvb0HjL9+IiCjY+1HZIAIZKDTkHx3D1Mz50QlChqfMvqAnBYzfsuRzJcNjIyUFL3yXObI+iEo5J/Ox0ZsSzaZ3ZasUvEEINHW1fgCJ0NLHtw2ug6dqXnDCr578nH7T8XFYJppvbB0iou+CUVg54hTqAXAETeARaVsbWhu5xNLgIzc1IVJWZ1Qy5mLOIfLxj2jVu1HHAD97WnrHnUmw/ZZ5xzKLHS5NFgXJtYLKUzFdcw5gZJazmE+vluCclBlEfq4MRft92muZKsvJo5WrpZ4JtE8JpCtVNE8gkY43BDfKTszOyrgQsVPEoldFFOb4aX6ftQl6G/eqZvgaeQarakIqtEec1YYeFRMdvT0JX7YT76GOOWWFB4/OA+t3PYmI96YxFf/v32kAcDdu1lg9784AE/jVYYGkRPROdn0r5U+uupuOchDEIb0DqTHrXmIX9QjLRxZnoJImgvkS9zBN5vQg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzUco4WDz5UdismrlQH//RlkjMwz9cR75P7BatRaH94hO1jdL4sGPhJM2S2H?=
 =?us-ascii?Q?2rCT+gjKRmcQeymRn5t1zLao6chBYk3yqrkZMibtZchQqdTPuBRbRiBevbfD?=
 =?us-ascii?Q?XZIqgop0Gud3RRw7TsNw+y4yE0nOSg4d9Zi0w18eeM4GGyzHpDL7nhLuTeiX?=
 =?us-ascii?Q?W7LQ090OMF4R03QfUpldA3PCDtQyJpeaVXyjxAY5Nb1SuVBKIfUAM3ug0vdN?=
 =?us-ascii?Q?XlvTgZOozi1L9tHosmSuBOgMKBQN/T3xQR4OsH5RUZ/OnXDcbi66SxosunYr?=
 =?us-ascii?Q?d8a3iKuzJB1e137KhVY8nYOgTjvmWKThU9tbQNHLbjWY7Ei3cFRDw1JMOLQI?=
 =?us-ascii?Q?TrDNBDpTbOlz1sDZ2wBLHtSUlZ49CESClJTGQINGDipBq7fdG5DCSMbXyXc4?=
 =?us-ascii?Q?XZ0ggds+gLyLpynRYX9VXLwwKRR17sfITEc8mrRiJzWvd3kj5IRY+lTmLLai?=
 =?us-ascii?Q?YAXIg+TV2a/PMk6VFc5+hQ27O2v4B0KwAds3+QGfJMs33JscWrkvT12c+j+x?=
 =?us-ascii?Q?nBOo/za1OFP8/J4arnG1gNGz5FaQ3RGny/jVoc4nwlmSTQcwOurYHqL32n+i?=
 =?us-ascii?Q?QKgFwJSpXzuupL+Nd0YxQvQp0nFWA2/SHF+iukuU2awRgnSOqZsVTZvMm3Ro?=
 =?us-ascii?Q?dbysoNk1sM5FhptGE7UBruxofEPc/u7a1YsYK3PV2BolfOKc+OnG9auQeN9L?=
 =?us-ascii?Q?DXqTgTmu+vDQ0hsIRWPZn19/bplFpdKiLwEDagz100wbdcttfFlugFrMSbJ5?=
 =?us-ascii?Q?w/HslSPJv4VqymY3WjnI47GxWhoZUWORkCPvQkMla6GoCPN3ThX2xgiPFrii?=
 =?us-ascii?Q?IP7ZfWVCp83MsUZ7I23/UxXzkyxdI3rSKJTi5CmNsT3Bve8I5C2+EGO3c6Qo?=
 =?us-ascii?Q?bXoVpNMa+FPU6N9jmRDLSmmEhgVnrQm0er5viyaS8iDqnQ1aMO/v0YmPS59o?=
 =?us-ascii?Q?ERZfhpJm2w4To7Xk+qWACNOAIdhi73dVaH6Pov9YgE/SiaR9NNNh94sgYn4K?=
 =?us-ascii?Q?ZIHfAfPj7OwTO3lFa4ytOV64nUUL1bfpwNBRfIG4N+897/nVmTduNg8E/jcJ?=
 =?us-ascii?Q?PuOXf4pNmma/aa5mZMjK3yvb/k6QynDZ3JmHwcBXKEdP1Wk0AS2j6woQxmM6?=
 =?us-ascii?Q?1H8x4VC2WltH958CTg4paRJn4BVVFLK+tznwXHo4dutdSSiGVOxeih9ksSTM?=
 =?us-ascii?Q?HFlYL6dDYMy27OYRBz00JZBH70Ky4vbtcpSHK6fBI9SkmJ+jlV4QDW3kLlAQ?=
 =?us-ascii?Q?NrnvNWA+LGbO11MRsmCuTy4JabL8CshoafQGojyXFsHVknq9s+WPeW1Flasv?=
 =?us-ascii?Q?UhqN2IgQpvbYbty/or1Jw5Qdye/rwcHs5rbWIHXy1CZX/byZjK8rO7b0atHQ?=
 =?us-ascii?Q?TxVJEeckYcvrTcfl2xj7QVi82FnevLjFgbWDWEu47uLAnDE3r/dyelMmGwYT?=
 =?us-ascii?Q?HwW4fX3FrJ/B5MgU66pat8oKSmXgjpR0L4h3GsWTOWSPYIsfDjsA7OzFizmj?=
 =?us-ascii?Q?eGNm+kKFSaua0KrO7Ol0VBgnxhDUXlYph1l4gT2JsJRbBq0bs3Llcr8ZcUJH?=
 =?us-ascii?Q?4cllQUE22GTzxrsyE8ZqI4E907Cigdr76ZT/LaeY4ofFIzQv+dnnZLk4f0aG?=
 =?us-ascii?Q?nZBzha/fvgGTzPghZ8mZKZ0FFpbCUT10Y42QxayPyI/SWYAi/e3AnPROLsSl?=
 =?us-ascii?Q?qNA46fiHQ8OWIA6UEj1U1zEU8yNIbYN/gJrdQuIQU01KfDOMC3o4DXOF5Ran?=
 =?us-ascii?Q?GPQMfMhDYj2KIcvzxDT58Ec3gJV4WXI=3D?=
X-Exchange-RoutingPolicyChecked: mqW5OghwlSCjrwYR7NDWt7QKPOvSJCgfy51RiezGVHfk0G5x7LEM7rFSyymLu8im8mDsqHscQS/qMC30v/ICt259t3YM7gVl3XB+tfPcSlCLVlOUMawX4LgqfwS9pDnk6xBKuprHiueeo9c0RSEG2UUlP2Rdk7Dvgc8H22YP+gt5s/uz8pgKbY5Kl2kP4Hsv8vY2kLH33zExMzn0qb5Ji0P29Twb4XXdYXkAcdzBPfcbmaKFd3nDRwqi1BAiaUqoD2RdNDhje9NGpDUbFa5TuT/TxSafIW0BO/qsUjSW3IE45oLyxhSOSnZgHd7YJWcCBiOfLprDPl97Fwx4ipZsbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ccc21e-29cf-43a3-7aee-08deab81aed9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:11:00.8852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLd+rcJNx4ntE+6/rZvZzRNJ7Dr8dcbqhhlwsTCwn6gWOhFRN5MUcNrArEGSz591YdZCSxQlS8MO9oIl97B3RKBAUssT1alvfQ5V8V/w/g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
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

On Thu, Apr 30, 2026 at 10:44:38AM +0100, Anatoly Burakov wrote:
> Currently, no kernel driver implements support for RAW items, so having
> this support in our parser is extra work for no value. Remove the support
> for RAW flow items until such time as there is kernel driver support.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_fsub.c | 75 ------------------------------
>  1 file changed, 75 deletions(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Just to clarify, this is removing raw item support from the flow
subscription part of the driver. Raw flow support remains elsewhere.

With patch description reworded to clarify this,
applied to dpdk-next-net-intel.

Thanks,
/Bruce

> diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
> index bfb34695de..a00d02ded5 100644
> --- a/drivers/net/intel/iavf/iavf_fsub.c
> +++ b/drivers/net/intel/iavf/iavf_fsub.c
> @@ -57,7 +57,6 @@ static struct iavf_flow_parser iavf_fsub_parser;
>  
>  static struct
>  iavf_pattern_match_item iavf_fsub_pattern_list[] = {
> -	{iavf_pattern_raw,				IAVF_INSET_NONE,			IAVF_INSET_NONE},
>  	{iavf_pattern_ethertype,			IAVF_SW_INSET_ETHER,			IAVF_INSET_NONE},
>  	{iavf_pattern_eth_ipv4,				IAVF_SW_INSET_MAC_IPV4,			IAVF_INSET_NONE},
>  	{iavf_pattern_eth_vlan_ipv4,			IAVF_SW_INSET_MAC_VLAN_IPV4,		IAVF_INSET_NONE},
> @@ -154,7 +153,6 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
>  {
>  	struct virtchnl_proto_hdrs *hdrs = &filter->sub_fltr.proto_hdrs;
>  	enum rte_flow_item_type item_type;
> -	const struct rte_flow_item_raw *raw_spec, *raw_mask;
>  	const struct rte_flow_item_eth *eth_spec, *eth_mask;
>  	const struct rte_flow_item_ipv4 *ipv4_spec, *ipv4_mask;
>  	const struct rte_flow_item_ipv6 *ipv6_spec, *ipv6_mask;
> @@ -166,7 +164,6 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
>  	uint64_t outer_input_set = IAVF_INSET_NONE;
>  	uint64_t *input = NULL;
>  	uint16_t input_set_byte = 0;
> -	uint8_t item_num = 0;
>  	uint32_t layer = 0;
>  
>  	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
> @@ -178,79 +175,7 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
>  		}
>  
>  		item_type = item->type;
> -		item_num++;
> -
>  		switch (item_type) {
> -		case RTE_FLOW_ITEM_TYPE_RAW: {
> -			raw_spec = item->spec;
> -			raw_mask = item->mask;
> -
> -			if (!raw_spec || !raw_mask) {
> -				PMD_DRV_LOG(ERR, "NULL RAW spec/mask");
> -				rte_flow_error_set(error, EINVAL,
> -						RTE_FLOW_ERROR_TYPE_ITEM,
> -						item, "NULL RAW spec/mask");
> -				return -rte_errno;
> -			}
> -
> -			if (item_num != 1)
> -				return -rte_errno;
> -
> -			if (raw_spec->length != raw_mask->length)
> -				return -rte_errno;
> -
> -			uint16_t pkt_len = 0;
> -			uint16_t tmp_val = 0;
> -			uint8_t tmp = 0;
> -			int i, j;
> -
> -			pkt_len = raw_spec->length;
> -
> -			for (i = 0, j = 0; i < pkt_len; i += 2, j++) {
> -				tmp = raw_spec->pattern[i];
> -				if (tmp >= 'a' && tmp <= 'f')
> -					tmp_val = tmp - 'a' + 10;
> -				if (tmp >= 'A' && tmp <= 'F')
> -					tmp_val = tmp - 'A' + 10;
> -				if (tmp >= '0' && tmp <= '9')
> -					tmp_val = tmp - '0';
> -
> -				tmp_val *= 16;
> -				tmp = raw_spec->pattern[i + 1];
> -				if (tmp >= 'a' && tmp <= 'f')
> -					tmp_val += (tmp - 'a' + 10);
> -				if (tmp >= 'A' && tmp <= 'F')
> -					tmp_val += (tmp - 'A' + 10);
> -				if (tmp >= '0' && tmp <= '9')
> -					tmp_val += (tmp - '0');
> -
> -				hdrs->raw.spec[j] = tmp_val;
> -
> -				tmp = raw_mask->pattern[i];
> -				if (tmp >= 'a' && tmp <= 'f')
> -					tmp_val = tmp - 'a' + 10;
> -				if (tmp >= 'A' && tmp <= 'F')
> -					tmp_val = tmp - 'A' + 10;
> -				if (tmp >= '0' && tmp <= '9')
> -					tmp_val = tmp - '0';
> -
> -				tmp_val *= 16;
> -				tmp = raw_mask->pattern[i + 1];
> -				if (tmp >= 'a' && tmp <= 'f')
> -					tmp_val += (tmp - 'a' + 10);
> -				if (tmp >= 'A' && tmp <= 'F')
> -					tmp_val += (tmp - 'A' + 10);
> -				if (tmp >= '0' && tmp <= '9')
> -					tmp_val += (tmp - '0');
> -
> -				hdrs->raw.mask[j] = tmp_val;
> -			}
> -
> -			hdrs->raw.pkt_len = pkt_len / 2;
> -			hdrs->tunnel_level = 0;
> -			hdrs->count = 0;
> -			return 0;
> -		}
>  		case RTE_FLOW_ITEM_TYPE_ETH:
>  			eth_spec = item->spec;
>  			eth_mask = item->mask;
> -- 
> 2.47.3
> 

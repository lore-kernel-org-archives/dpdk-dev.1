Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE95C5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 14:38:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB726402BE;
	Mon, 24 Aug 2026 16:38:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 55D46400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 16:38:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787582281; x=1819118281;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DS+gQF/+G+7prVpQ5gbyRkJ0o0NADok/AxInT8jdlRM=;
 b=PO6qdQj2kjWEb1wNPnx4L6sxWgF8aQl4Yd4YB65vZ/YQRbvd0Edne4mO
 b7/ztpFnyI7qsQF5Tk45TA/lcNxKa75e89a9PiGse8e3HQYPftkRSDMh6
 Cr1WG/tg4axVsaPiYrVVyiaFTQnwdm1WuZqVwRhpUjEjHTkWAa8sm6dGP
 Q2FlF0cayFTdKG+QzwgHbZACKALKneiN7TFkBYbfacM0O15HWBVCLJz+i
 WHHxq3kCLaGDLXULFLzAsz0ZxCnpmymjmB9mgpqQmWq1mCggv8BC0bM6V
 ygYFrpecMjuS0HB6juKsvL2AZKZ1ucGgy2bNR6nFKToLi8M3/1sgIujsk g==;
X-CSE-ConnectionGUID: JGY6EiwiRjCBFbog0fvSUg==
X-CSE-MsgGUID: sn78p6TFSzisSs6gKj0hgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88236415"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="88236415"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 07:37:59 -0700
X-CSE-ConnectionGUID: 2qozfgM+TPObxmPjFbk4Kw==
X-CSE-MsgGUID: qUGrldXyQQCIZCSc+v+4IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="262726269"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 07:37:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 07:37:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 07:37:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 07:37:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA6VZyytpqji56aLlCVq5kSNj/HCfJMK5KyS8bXEq/x9x2bSUQJAT0AuBNdjglachuhsUaNVv2MI7H1UDsHsZrUMHOewACuEynR2vVEOo2HdzpKV5t36Qepb9tSPTIxiSNKp5OBJELa+2mIvJguSjj79JrlLOtPg24Nb9B3IYGiGqpGHi5i4j/miXrQvau0hJTatVVnybFRGjXsptRaOpQKBDoakQ2jxgCHU2Eabgsq2QsyvcDAWCrYEBlwQcf8j0UnFoq9B9Hlinti3EU/jAuEPjWiTw4XJM/aFLbI1jhxzsUKrDLf6kKz6abxl+1Db2m6q9zahAgFZxxcjYqWMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIvkwklogIiFwAw0zfkFfXvhKntRhVFyPasGPefk6To=;
 b=GeIcrvIxYbcy2x8OBK4YUVb1EoUOuD7OtzF+3ZLq3AkUJmSeos9R0sAPpC4Vs8ASd1wBtSxTqU+h7zoNGwefeyecWrkgEK3FleewoJjR1imcy7BBHpcIv32Q65IWYoh/aejlPlFAC9JzsRvToJZillMpz9Byntdmdge/X5LgxkoEyGaQ6tfTDKE4NkKioU+FeZpKzNqSkbvi4NHZHezR5J6FOj6bAeRj4BT3H1JM+QCaoI9PmgZrX86M7g6MR3daTQGCw17YYZqdIRAs87Z2fW1vnvkmA7ox+X6hg9Bi33v2GM/kZb9QBjyDBC+XN5PlXKBqRb05qHF8eNXvapBYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH8PR11MB9483.namprd11.prod.outlook.com (2603:10b6:610:2b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:37:55 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:37:55 +0000
Date: Mon, 24 Aug 2026 15:37:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 2/4] net/ice: add vector tunnel context encoding
Message-ID: <aoxXPpujO2_oirUM@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787566677.git.anurag.mandal@intel.com>
 <1544dfcdca6e4accac523326948cbe2b4571e76b.1787566677.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544dfcdca6e4accac523326948cbe2b4571e76b.1787566677.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::9) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH8PR11MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: d899b2bf-8d95-4e9d-de93-08df01ed48cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cEDqN7DuvMrOXUUGpf+UvJ4d9/KWUyKYLXT/bPmztF4dU84glGbk/kvPYrDYrWW78r1uyrMYM5emozNZyg2SKjylIXpGKbSI6mI/MYsxl+Z+2twUtHM6UK71VgyuftMrugqAc5HWnfpAk4vcvotQRx7rC0UG7eDxhTdtrWR14yLsJPYR0xEpDhSg2u9kQFsEsra1+dyTfaSQjI6BBV3CV4FDhRTlGzXf38rVX18HUxMvj0mpaQfe6qu0mmGVEKESeHDD7Ei3Q1/Y3zsTLZISno744xv5bs7sw0f1vwAXvwgU4r/1lKCGIabobIXXatU+Jkj8J7Pns+TmxVIXLHWrACBHRhUdjjvP7mYjh0E2ynESll2k+YXAvUNbmQXbBa11TjOnUXTOc/8ybgWEJCaAat2MqMP2Ji9B7/RNXhDB3u+7Jmt1XlqUiPbqhiRQO2vxCo0QbthkG4vdx0D8I8uHnDEobGgTQaF1myNFaqyUe89iw+rysM3AmJdGMpoyZRBLEK3nSKag8LwiT/eyma+DwiWLaRN1Wn3vAVcA0GNDtqmN9+WSg24YgVvOjNXWvyFLFFMzB4hF6/jGKPJIYeYVk6eDZIg8F7jrKFkJzgJojcWxmHGAO2DYwU9pJhj9dcwIjvJ2AZwdOKvpqx3G7pmeFBAg62IKI/BaEQJa3AmBGfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uuL13n3vsfCrSxFSxXw9zXOOCsYJ+sPcTMG7lngZTiTuYGmmh71eXk+pmk3X?=
 =?us-ascii?Q?WwEIL3ieSGimN0y9Khzypp0Q3pbROI2JmWM3O+o4j6Ge8dvAoZrQ8pYLwngA?=
 =?us-ascii?Q?cGEuf9Rkrosc75O2U8R+QO8At33Zygzmht77pwZyVVfo2VATqALuqLg0QgFS?=
 =?us-ascii?Q?vfhiFDAZiMk4n98ECx+GFzH8U7BCqM6iElS115Ii4IZs9g4f6Fin9tqbouQ5?=
 =?us-ascii?Q?im2/Rn++Fyv5bDsjXbs5CFYongzYnVy/cEiWIJJXnUf2RCKG9kYqexyYMaLK?=
 =?us-ascii?Q?cuU105R7GXSVaMcZUhjdbPbNfzpQAtiUoYr4R3MbyVm1yCE2FtWa+JrVpohg?=
 =?us-ascii?Q?QGYB8ls9iZbKIwfNbcSs0ATmpZPbNX49qmQ0XdkXORvtGI+eKkrwZiZ+5hdW?=
 =?us-ascii?Q?aRylSFnyleZevBu4iG+lafxaq1ekXbobhvPlOx3aEUmVJcgBJMC3fyvMhOss?=
 =?us-ascii?Q?8ueNME/Sk6BWqa9Wp5GteELpZLg5l+norXhkdFOLFj4Qwl0UdQ/BIL43tHmi?=
 =?us-ascii?Q?oxi/glgDHIZscwz+lANiNzyijtvsLqJV+u7j2ZDY4PRLOmQ5wHJ6418M1YqN?=
 =?us-ascii?Q?cABc+3Q1rGKVcObYnKgelX+zMPe7oTMwS6+RboVy/2R+m1s45jgr6cj8RjnA?=
 =?us-ascii?Q?e7tLO0sw0kGvP6Rdzp1DJnFn6v/O3knP+ix4zlgqsV2+jmg1Z72bw0kdpMwP?=
 =?us-ascii?Q?YA2PY4/mpIYExP67Ci1kaIi76rNPycVd0HOTLNM6J2xQRLX5YtK1gJ7Q0DyP?=
 =?us-ascii?Q?bT+qfCJbiiU3AqG+Vzxi5VUyRWCQ5Sr2VypXjWvvfwkrcxaNZylSzpvZzIe+?=
 =?us-ascii?Q?/EXuY4pbZsNXqbz5w8xmBwfOj6pF0dO1awjoEwXqG1NVUXbqzlc6RonSiOT4?=
 =?us-ascii?Q?OPCfkmX2a+mejykTNCQoSKAfSIA/IE9Z1wwk0XiFrP5fXWRIlKpD0qSOP6Gr?=
 =?us-ascii?Q?p00GG9f+7g3RUedUU5WVomZgNyZ9fKZ7Fs6LP9imxXThMh7NWnlrNhGPkcXc?=
 =?us-ascii?Q?IM11v4I4dUJBEiheuLgscYy1GB+c7QqEI3Q7ahtBxeC0JYpG1wML/vTvesc0?=
 =?us-ascii?Q?kTUryx88FQKU8OI2S5yPXGnJ6aB8BopPeSp99Q01KppG5x68AaVZOfS9rLYN?=
 =?us-ascii?Q?fllv8X/tcHurIyU1ZcPjClVqQpgyJ6RpmlgB6aQv5CrBrTUguBNZflHrPnxx?=
 =?us-ascii?Q?HH0laHOgAy3yLC3tghslkF5vGM/b8J9E4881DmuXGGglPRNz5u0TqfeENKCP?=
 =?us-ascii?Q?L8VEHoVwuLbcFuzLBtodLcBwDJWEkmDZP1pXVwEITLxd/qhTZfNjJ+YRzIIJ?=
 =?us-ascii?Q?2+mxY1f9AdmxTmiCKKelr/zydARwUR3K3GeBX8+D6EviZMJV7GtZaNT/JOFJ?=
 =?us-ascii?Q?UnPeYYhvXf6CODpTZTbyH2jWKke9Vt9HKzx5grBmherj1ZSsDCofEsx2T8G7?=
 =?us-ascii?Q?9su/+ILVFa7ZW6JW/j3+zOtHt+6M02V44bSRwZEBChZCSwi5UgWELIWugMTI?=
 =?us-ascii?Q?Y9cKW3qM7XZg4PbVDNsqjUeck9O0YLaYotrtS2XUpwVy4wLk2lZKfhUfafPk?=
 =?us-ascii?Q?fXcPGjRTzsL8qpCztwS5ndL5lPqepf3gUQpNKbUK+s0VK/dVP2dzHUIa/o93?=
 =?us-ascii?Q?lrZd9W1/6PW2uOXw6CtHgffPFTfDIifZLV1oxVCjYIaq0CmBPxl9ur8jiR5l?=
 =?us-ascii?Q?jN9y0wEvpvaNZIJRErrad0tBC9Cj4uWggWqJNucHQzkkiRBLELyf60sVo6rA?=
 =?us-ascii?Q?G7eYNQfb5YqQxuUWW3M0i4VieYVwi+Y=3D?=
X-Exchange-RoutingPolicyChecked: 2zOj8nygGBwmTriFMNcgLaFPibS4HztZchfOGl4bljX4KBVFQkrye3jIdYt6cDsTKGywWn52YORFHgdZOeV6rhaP3imVh57XuHmkPsfFiXZMFflmrYc6ohpu6O2IadCMIfc2ViG0uh0HDSJgOeHK0C8oiORTvDHiZAIWu1hSyWdW/FIo9kV7A4Et7SaqUUEHguB8NBJKUqwjvFoDCk+w8Jjq5txNZnrItOnm9XhDPRcllc1RdNf0aLrD6juVYToT3UrlYMpFkcPSN0XNtxQtnbw50VhRwYr51mnQ2NBmJhzzCMf93j2cwiM20Uk8PbKpr9kqKHD5Q4dDrott0jopYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d899b2bf-8d95-4e9d-de93-08df01ed48cf
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:37:55.3646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bB7VwQEOIKQNwna0+7Ly7xa4p2hXBQhXB8zdpC6h12H8v30b9EDk50BsU/+tJHRrpilRJZ0guvy7k52HxOEaG8Sp2WLAU8UI0cuqyik0Mu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9483
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

On Mon, Aug 24, 2026 at 10:21:52AM +0000, Anurag Mandal wrote:
> Added helpers to encode tunnel context descriptors,
> and checksum offsets.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

Some comments inline below.

/Bruce

>  drivers/net/intel/ice/ice_rxtx_vec_common.h | 53 ++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> index 1d83a087cc..b84456357f 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> @@ -123,8 +123,12 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
>  
>  	/* Tx Checksum Offload */
>  	/* SET MACLEN */
> -	td_offset |= (tx_pkt->l2_len >> 1) <<
> -		CI_TX_DESC_LEN_MACLEN_S;
> +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> +		td_offset |= (tx_pkt->outer_l2_len >> 1) <<
> +			CI_TX_DESC_LEN_MACLEN_S;
> +	else
> +		td_offset |= (tx_pkt->l2_len >> 1) <<
> +			CI_TX_DESC_LEN_MACLEN_S;

I don't think these lines need to be split. It's copy-paste from iavf, but I'd
still adjust to be single-line.

>  
>  	/* Enable L3 checksum offload */
>  	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
> @@ -172,4 +176,49 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
>  
>  	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
>  }
> +
> +static inline uint64_t
> +ice_txd_tunneling_ctx(const struct rte_mbuf *tx_pkt)
> +{
> +	const uint64_t ol_flags = tx_pkt->ol_flags;
> +	uint64_t ctx = 0;
> +
> +	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
> +		return 0;
> +
> +	if (ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM)
> +		ctx |= ICE_TX_CTX_EIPT_IPV4;
> +	else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV4)
> +		ctx |= ICE_TX_CTX_EIPT_IPV4_NO_CSUM;
> +	else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV6)
> +		ctx |= ICE_TX_CTX_EIPT_IPV6;
> +
> +	ctx |= (uint64_t)(tx_pkt->outer_l3_len >> 2) << ICE_TXD_CTX_QW0_EIPLEN_S;

Is this meant to be unconditionally encoded in the context?
Same with the l2_len below? Are we relying on the HW to ignore these values
if the flags for them are not set? Comparing against iavf, these are set in
the switch block per protocol.

> +
> +	switch (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
> +	case RTE_MBUF_F_TX_TUNNEL_IPIP:
> +		break;
> +	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
> +	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
> +	case RTE_MBUF_F_TX_TUNNEL_GTP:
> +	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
> +		ctx |= ICE_TXD_CTX_UDP_TUNNELING;
> +		break;
> +	case RTE_MBUF_F_TX_TUNNEL_GRE:
> +		ctx |= ICE_TXD_CTX_GRE_TUNNELING;
> +		break;
> +	default:
> +		PMD_TX_LOG(ERR, "Tunnel type not supported");
> +		return ctx;

Should this not return 0, rather than a half-completed ctx?

> +	}
> +
> +	ctx |= (uint64_t)(tx_pkt->l2_len >> 1) << ICE_TXD_CTX_QW0_NATLEN_S;
> +
> +	if ((ctx & ICE_TXD_CTX_QW0_EIPT_M) &&
> +			(ctx & ICE_TXD_CTX_UDP_TUNNELING) &&
> +			(ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
> +		ctx |= ICE_TXD_CTX_QW0_L4T_CS_M;
> +
> +	return ctx;
> +}
>  #endif
> -- 
> 2.34.1
> 

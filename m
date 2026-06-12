Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD1CD98CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A56B434DD;
	Fri, 12 Jun 2026 17:43:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9AB0040279;
 Fri, 12 Jun 2026 17:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781278986; x=1812814986;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+/9Dc8QBRv6WfAzfFNBxJNknf/qkMNz3Nu7lrSUBbtw=;
 b=Tw5hDFrdMkyRfdNByB1tIAdgCGO9tQTWYMFwO3/dCT96Ip+F6Mf5Nqx4
 qU9WNf7CmyR7KLO5XjFLzOfjEO0NPPutYxqhUXGTGMcX0Hl6PlfJBI/Ay
 /GSno03UVU5itpPvcpCB/QIG9aZSgg6bNV/AJrrEublkSaJymFtvic21P
 yegNJpTyRTfIGOBarSmJrfeuWsXkkseD44VeffHc3ScGLgSRbE7KAAHT6
 YadCdgGcmBSzG4V2pePUdvZxBd9ijwiL+8GDiyNkRczpWSljF2xiNBwLy
 tUngATfxdfyTKhDTSgN4PEwk7JJcN0UeHRgC1SXT/0VbB/b8s6UUQIO4+ A==;
X-CSE-ConnectionGUID: SR4zVt8cT8unrUp0A2um+A==
X-CSE-MsgGUID: yM9ogeXBSI+2MJ/AqmA3QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="99528659"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="99528659"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 08:43:05 -0700
X-CSE-ConnectionGUID: c2q3GXo4R5qIvXHBxOobWg==
X-CSE-MsgGUID: y7CxF+eQSsmEchGbpgHbZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="270897838"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 08:43:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 08:43:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 08:43:03 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 08:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBdbYO+vVjwX6HgPXG2yiygRF6QSHPrTD+4IzSXbOICVQelZA6vvQvalDX7XAaO6XOHCfmMZD35St2/ngHMR9gxAeEx7+HuSG5pFw9tF+rwS7olaqQrjrrmEB/C3kaywD5/oroE3oCnIiFT51Q42i0MMreXVeWc7wSRdQJudjv0kT0PEl5g70JYd2mBLLlp8/sJvifegFC8uEJN5NH/B3PK9As0FaT4s4tQ9B7msC+6H+ksbFbWld4PXk485r1nftvzW+PRw4HskhHJ/OvzFjpq+GmldiKtRVvAeH0DPEMShq9dMRxWmcuLgkGk4+aACRcbNZQq2jQOGbMLT7qNVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o68MsHlyJDT5RCH39mjOnexUAuPKRp8r0fwgJQ0yDtA=;
 b=t1kxaIkIp48uReIQxY8zP38naSRfBfWtK8qD8ndJ+l+8Y+MaMOJLRojHAtvYIIHeJnJsU5FDetfWxH53k7k3tg2gIbW6PqbBt4J5HOmRvdUNPMFpPRL8v0DT5vG/gJk8ONdiuYC0JnwS7keyNP0vH+4r2yj1RhaJHyANQhIgrsKyX8Bd0vkjvrWpA2BHboFJ+fo25LpRPb7FLSXan+1I3/0q6fsT+Cd6zAypRJDAzaaYjeGBde0iKVBz6bYPfkn18no6tl5/hEbnWoNdJdB86ypi5Q2Us2a6Uub3TDESo9kczmilvI/Vl0rRhSod5l41JBeBbMVee4hDmJB897mVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF814058951.namprd11.prod.outlook.com (2603:10b6:f:fc02::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 15:43:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 15:42:59 +0000
Date: Fri, 12 Jun 2026 16:42:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Declan Doherty
 <declan.doherty@intel.com>
Subject: Re: [PATCH] net/iavf: fix scalar Rx path zero-length segment
Message-ID: <aiwo_4aTWi8kBIkG@bricha3-mobl1.ger.corp.intel.com>
References: <20260612143531.2265914-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260612143531.2265914-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P194CA0029.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF814058951:EE_
X-MS-Office365-Filtering-Correlation-Id: dee9d1d8-9b81-4879-e3d9-08dec89947f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BtJpRnXjp/VkLMGzVimtUj/WftZpXx5C+jxDwUlBxP6rjjPAV4feue2NJuqGxja3RkpXmrrBvaUP2JrVbuJiQ3by1+7GyW5lWEb1Vbi/u6GHJZB6bScUIPGUJqrNkE37P4gdbjBHp4B7uahoOO9kvr+zj2lDXol1yYvs/EPRXfNiP2ulrt+fLz5Htlj/jnzCSYmTS+PmgUdkriEHpdt58derh3iFe8eNWmcx/VmKexYVlYLY6kx4vYcP1A9gGLZmb9nAW4rTsDnZDIkf5Aw49LJ3cVSkNNGkYigGU/HVO6vz5V0X7AQQzFDjRSp+E8auuSWrOMhkfzs9sK2pSk7GcGwejTdRFXfRSaCfJvRwKfitEOXAE2CJ8LBMi4HhnBh+mlCT4Yz8r7HIejMuImdUdvHe5pKDoT/Nutn7uKEDfYWGkh7a4x41rUOYfA9Wf0e35+nb2vv5FS4FTIE3/qvgqUK1U+rGD12VQXIl00Mp78ISOefYRGPLgY2orMRXaFh0oUrCKOPajTJzGKIEU+DakuxgkiborXUBWcOiFrwELutY7OkLwWSFQNoqF8EnNot1rDPopSTfSI/87xIa9e8Y+zqrKybRyFoVd13j9fVlaQNvIHFuTUIgIJU+/+9E84+6383xGgYEJYXJyb7KrrssZWmv11xMGUaKLpC29fSZCVkUeJ61tdp96BVEZlWW0EwS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBxHqFYwjdkbl9mUJ7PQNMgXtxnrScM3/DTCrShjBj4XK1cGRBM2nHT78gMx?=
 =?us-ascii?Q?iKcNygKR88jU2xhludN0lj1oth57EUt0yMPvTJJ6+2100SQgc19MmMy7GBEU?=
 =?us-ascii?Q?SGHl/qRqIF9nwgDSboKIynYDSlJG8Cr92pfe94VZn78JuWIen6Z3pW5JCyuo?=
 =?us-ascii?Q?T+66+/nK62WY699zTMKvhBU+zP8+M19y4b/OXfxTu4WNhrkaXSgAE1Uakb+A?=
 =?us-ascii?Q?7Qt+cYjxH0G//Lt9xQ1H4IWAJKM1J9RXXfF54QGxFUM4+lFu4j87xqKYQ8EX?=
 =?us-ascii?Q?qQYEtPcR2BK17D37zC35XIDW/zgsonL0/duI8c1Wupra/4RZnpDSih4Vf2Cc?=
 =?us-ascii?Q?yL5a++rjEw82xUV7NO+yXO0jfwrAIMFAhrpL7DapVpgTwfYNAi7X3TbiHC4+?=
 =?us-ascii?Q?8LCxylqGB6p6TnqVd8RMX4JFo4ix9ZkaUTtOCr3HYYnVA95zBQmQfQTe57QZ?=
 =?us-ascii?Q?0B4q/HWgw6TNkA6DX8rMMgKLjwezXAqLioIOVBaynBsVjb0yFHFEhHwX0AJo?=
 =?us-ascii?Q?3jlKcYBUTc52BPd0LQ2+qCJBZYVwj/wYAIZeO2DAXozy4YnF2pcyeAlZo72o?=
 =?us-ascii?Q?WthsWWSOiEOVo68Ncclt0uEqQdhzhUqRsCqWFx7usOpEuhZrW6ND8kUdC1Zq?=
 =?us-ascii?Q?7y+XUm5uyX7bpPxDedOWL+CQhCT0uzqST2VXtU1j/Hp4iHpEJnTwG7am8y6F?=
 =?us-ascii?Q?AFOdZDeF151AJjHRxgta1+iVu8+ruS+tVZt/NvyZAncpu5iECXGkATLxPTnK?=
 =?us-ascii?Q?W/He92/GBTFKjKCP/l4Sdhku+fshOVXt2cjjZWHuzPj8XKmwZnvUAJE2PBf1?=
 =?us-ascii?Q?yOGYvEkDL5pPNsevqXIggmMLo6BISUBLLMrpf4n8raPg9DZ8hGC1HeZY9HFI?=
 =?us-ascii?Q?HX1s0mVfSfmYpaTdZ9PskSnSKAiwr9WBYMQnppHO5gmF0tPEc4aUpUTm6ftb?=
 =?us-ascii?Q?Pff7HEOenJQXyocb+Y405IcECX46Ca6aj8IAlaeAhPZqOFy4XQPx3CMIZebA?=
 =?us-ascii?Q?uGk9bwvIwD0HoKLNhRKTKueVJHlsY7IJePRF7im+KjqM7oedZP/BlaoAktJO?=
 =?us-ascii?Q?2qvWwj02RpKjU5qwExil1JIIUm+oR2cLsZZq0Br/jawPh09P47eOFIUqq+CC?=
 =?us-ascii?Q?UOR9k9llXUvZEa4EU0g2sxV8i/sLh0PHakf709EORvaz2fqyCadaWXc8TSpK?=
 =?us-ascii?Q?JcL+iIPI7AokEGsXfrgO4uVMq4896+sTS/e0e50X0XhSUMOK21JY160IkL68?=
 =?us-ascii?Q?ZMhJIClLNq1ZPlbM3DTdva/ox5kovdIIZf3UnSZYTdqZ2vv8blB41VYYDO12?=
 =?us-ascii?Q?srljuFJeg8DiE/J7GYBBxWOE2OzhHvX12VeN0xMXh4xsBqKFoZ/0wIKaQ49k?=
 =?us-ascii?Q?i87WcYom0jEd10GfDkivC6bOnzwG7j3w0XcdIjQtpUtk0V1Z1D8FPjXa0abP?=
 =?us-ascii?Q?8P9rNa5rlMRszis1fciSPndw3Q06WdnMKsrAvN5Bp6BPDf6FQ8V2x/UsL1+X?=
 =?us-ascii?Q?wpt9Dke6a9a0dJM18e4Jm61njmMkuEr9ftgycyomzUSE9ZJIDNmDQ9daoFAY?=
 =?us-ascii?Q?fwE1rzwczFRYgVk/lXb3xYfjryM5nupU1+mWlpuylNuWQKNXYDisZoEbEIXj?=
 =?us-ascii?Q?r3/TGGojc6aPX9Cx63XKKiRM6djEJosoBBiPLHp6aAdYi/u+E5E3oUuY3AJu?=
 =?us-ascii?Q?y24/3WUm51TGEbM829EVOj27epxJ59NoJOYQfsiBPCn5RKx2XLEEJyBK/AOu?=
 =?us-ascii?Q?ebqqlHVrU3afQe0/Fhod93V5zAYs7b0=3D?=
X-Exchange-RoutingPolicyChecked: OAAfBasmhjTqe1mC6fKTJtoQpj1x2Iv9/yeUzky+KbG0L6yfCtoqjrfQ/T4XmdDlPJY/P4qg0+1rhdzxrT709ye+raZD0wBt4o103HfAWd7bmJKQBPxbScre4DelYXXB1nLoqmpcn3/m925fKs0ygftp2SUrdERF8QYFTTowKdAUSeAWwQ3doBye+Gm6o+l9cEXX4sE+tVLvcxvyqLzctcIJdtcRpeWufMeOcBJ+eqot6Mzn69HjwACPE2+2JYR8d/f6c4Tv9nyc3Dh+l763An39xrIfx4NrwFCvjPNtuqeXM+w9dTIH9/scbW1fpoDAJqbuvCxAbQ9mGA19nWeWxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dee9d1d8-9b81-4879-e3d9-08dec89947f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 15:42:59.8178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV1Kxq/80IYmcYubLWf0y8wxPwDPviHNcSzG/zsvZIWFsmKZNdbJPzh7hfPwpzqDh1X1+7ikOsXFeCl+HEjCloFiSuRvBrtCSm2Jd/TYFYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF814058951
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

On Fri, Jun 12, 2026 at 02:35:31PM +0000, Ciara Loftus wrote:
> When hardware CRC stripping is active, a frame whose on-wire size is an
> exact multiple of the Rx buffer size can cause the NIC to fill the final
> data descriptor and place the four CRC bytes into a separate trailing
> descriptor. After hardware stripping, that descriptor carries zero bytes
> of payload.
> 
> The existing CRC cleanup code only handles a zero-length trailing segment
> when software CRC stripping is enabled. When hardware stripping is
> active, the zero-length mbuf is silently chained to the reassembled
> packet. Forwarding such a packet causes a zero-length Tx descriptor,
> triggering a Malicious Driver Detection event on the PF and resetting
> the VF.
> 
> Fix by adding logic to detect a zero-length final segment when hardware
> CRC stripping is active, and freeing it.
> 
> Fixes: a2b29a7733ef ("net/avf: enable basic Rx Tx")
> Fixes: b8b4c54ef9b0 ("net/iavf: support flexible Rx descriptor in normal path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Declan Doherty <declan.doherty@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index a57af7faed..86ebb2618d 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -1716,6 +1716,14 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
>  				rxm->data_len = (uint16_t)(rx_packet_len -
>  							RTE_ETHER_CRC_LEN);
>  			}
> +		} else if (unlikely(rx_packet_len == 0)) {
> +			/*
> +			 * NIC split CRC bytes into a trailing segment which is
> +			 * now empty after hardware CRC stripping. Free it.
> +			 */
> +			rte_pktmbuf_free_seg(rxm);
> +			first_seg->nb_segs--;
> +			last_seg->next = NULL;
>  		}
>  

The vector paths also handle scattered packets (via reassembly). Do they
need a fix for this? What about the other drivers that work on the PF, such
as ice/i40e?

/Bruce

>  		first_seg->port = rxq->port_id;
> @@ -1884,6 +1892,14 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			} else
>  				rxm->data_len = (uint16_t)(rx_packet_len -
>  							RTE_ETHER_CRC_LEN);
> +		} else if (unlikely(rx_packet_len == 0)) {
> +			/*
> +			 * NIC split CRC bytes into a trailing segment which is
> +			 * now empty after hardware CRC stripping. Free it.
> +			 */
> +			rte_pktmbuf_free_seg(rxm);
> +			first_seg->nb_segs--;
> +			last_seg->next = NULL;
>  		}
>  
>  		first_seg->port = rxq->port_id;
> -- 
> 2.43.0
> 

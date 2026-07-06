Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A69BC44500
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:19:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E7E402C3;
	Mon,  6 Jul 2026 12:19:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F34FA4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783333152; x=1814869152;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HWHjFYTU+bxXdxkIaBhKKmNhr4z+6Zo/X0kNd4vLrec=;
 b=gAt2xW7IJXit6XwCPbbnr500pk6D8F/DM2rdfbYkgEan+7hwuk09/Gv8
 9YA93rh4VMS5M39kh6zubRPMXYCC+eb4m7Genz9DozKfH5d5ZJlWWzNTn
 Q4TAlpRMtgMhLXs31dCBSr4wfQ9JWifovgL0Mmg9BcrV6/9lkuIyPMfj2
 Q4NAuqWMNG/3rWelQSH+6D97MTvtdkksJe4X391DDirnh5CY1Ntbv+MxB
 qzAptpdclGgZue74A5JvsWfTo4kJwBTv+bpZbjtCRC3VJeAD2r60LTtNw
 HhzV5B19SY0KCevmX3S/Cgs1MOAPACZ1/jDchxSEgLInIMNHdhqpZTXDM g==;
X-CSE-ConnectionGUID: i24v0sErQSyzHKSk+xDylA==
X-CSE-MsgGUID: 9xktndRXTAWyTFh/FH9fYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="109507532"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="109507532"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 03:19:11 -0700
X-CSE-ConnectionGUID: JD2EwuI9RLOxt/sMQxN05Q==
X-CSE-MsgGUID: +jJmQ03NQxa+t89UqQdiGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="278026530"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 03:19:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 03:19:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 03:19:10 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 03:19:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyiz2lujFN+yA4yYggDpFqZ+/XKFSFw5XkHRro18kqJvu5+CIg0fjsyo3wFf9ADoiEsDKM0rQo1hTnQWaP1tbnyYBEBG2mDJ52sJNZnl8mAMCDL7ASSwkMta0S8hxgSMBGQ4FQFDDw45D11PgwyiIhY83nB+gkkhsWYNXBHbFgfJxYmVwy9Zm4jUSjUwbHXx4x7dfN4QTGonr3Gwv5fDM6nBuctCUQVnjpeou1+nm7dY6IW/Ty8tgpEFN0cPaisgfQRpYObSpj7mu5uh2WdimVgmtzXgTv5nRgUDK0pyat3GesVBEUrK6o3FyBhJBHCgUPYkp6U/8cfS+oq3XNeC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2FRCiRvndDZh9/+AtB8MxySMox7iGyFLy6DG1h11kM=;
 b=fM+rq1BzoEglony/vkE8qGkuJPE2aXerGCnkKOoIx2WMU/wYyL0EwRO4rkZ1G88ezCR+OWCtyVPUXNeQq0tou4tKbd3tqYQfaJzTbXCNgsMthlkqYP8oMmY9335iIiGm1Jv3dc49rh4Ug0Q0NlJrjiwKLzIFDoImgKu8SKqz8fH1JPSjykkbMr3y4zsM5R3Imrx3rpGWYKFBYpwZZsgI1CrbURBxnfz5PKEOexFG9wBmIwBLuTSvoNC3lEBulQAPl0ybbnDgqwVhQupQWgtV7FFuCQq5614MHafj2iSgJCnFfqT65Q4s0s2kYCxeUcXuds7Mc77S23J1SAxbr5MC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 10:19:04 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 10:19:04 +0000
Date: Mon, 6 Jul 2026 11:18:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH] net/ice: gate send on timestamp offload to E830
Message-ID: <akuBE39_s4Xo3RL-@bricha3-mobl1.ger.corp.intel.com>
References: <20260704115806.372175-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260704115806.372175-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:10:232::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM6PR11MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: aa75c152-9700-4b3b-6d38-08dedb48014b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: p7D9sK2KsDDAAdzsQZprmlg94ZgyOUeE6wQ4BABndtHnoqJstYyuCNGh4ECqJqi3m2hvp8DdA8Mo1LBMX4HKzfTIIAgKOIS6R2p4e35472W5hdeKRC+qE8D7MXN+lx1oouOzqBdNMmpcvov9y1BaynYdtaZr5wYjL9FvI4oS9wl5rLe8ewIMQhT/B6WgrDhE8h1fH4HynJRSBqEobN9NVQNy6q5ETCGYiU3L9+XMAJqh0ymjlzV+D+x/XLssJ6xU7slwHbQp8RdolWiEa3G2fmP3ZM17zA+gFFTyDtQ5tNnq/Cdf/IjpzWY27yf3jFipuNfsNM6N0F1CSfDPjhWvpTv6nKdvZOwlZfCGzt7uLqHEvQ0mLEQ8y1aZTZWEcPY/MCTOhxZsIGxEY/N3PyIWLthU2lIp0oE/jyvIkNiqHllU5qUPdyCgaLXyBXglyL1vLvNWrG8MwbyY846ksPNHKDNjn6XldfqP9XrjPHK+nbVDnmNXP80rnVWYHFP7APYJx3sZLEwa3taTDntGZVqjPm2JKZmTaMm/OWdkAt+xuMN7RYSTN2DzaW/C9W+T1+Zkdgxj0+HZ47UIqB7BRLnLi9weT9TyZZ7vTz5/HIaZF2wRVeHLEs0IwZqMaVHSUx2NmpFahLyZjf3OFmCvotkzIm9fJhSnhIS7mOKg1E190Fo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VBLmSua82k0I3OLHa5LA3UqmDZ9HmQK1koi9m5l5VNYG0SFkeu2A2ke5OBhm?=
 =?us-ascii?Q?+KlxH8I/vvxssOjVKyuVarIfTm/MIRIoWDgFD+XYeVN1/px1WsdypkHq+TRC?=
 =?us-ascii?Q?JijCrWcX1WkTmOEFbqRk6Zc/RpgA3s74juF2lBcFKyW22tCd69KsZ/1Ci1H/?=
 =?us-ascii?Q?iEfzowdrRWNFTNRCUqm6IHkg4I/iaaZlEBNhHMNrf+NWaXTXuc5lJpAAEMEF?=
 =?us-ascii?Q?VqbbeBSN+LVY+SdprL5KEoSMq6NctTyNCBbXHJlxu6L+vxvQ79xpa3UbvcIj?=
 =?us-ascii?Q?RXrS1+eJGkxxwnDTwpQ790Dmb2QCsWCuAE7tBMslv+Vrs3lbMPCJjYWSShH3?=
 =?us-ascii?Q?BmxskfF1D26NXX/vvtxB/ZfeMBOhPQsxVx8oUP36RQWbBt/97K+nYdNI3CFk?=
 =?us-ascii?Q?HPoxTX4Juq+tzqyYEjaYrV373PEC5sRVo9YVitWTPfS/DkPxBrLjFZxZGOmp?=
 =?us-ascii?Q?w8AzIkEQNXdu3ArPrvD2Ml9TXNraSXa9wgO4BwfLEBU6U9EeyFf9V9E0tmr0?=
 =?us-ascii?Q?Bx3UJKPQoXzdQh2dZo1xXmE2mGmdJ1WMnNlmN5YJ8D/rykRNqVo1u2AwI8K3?=
 =?us-ascii?Q?6E1yKQz/IrrmnlBljst73V1WdZHRXD/7yLWr3yHK6vDM0GL/ikGRRrYn9kyd?=
 =?us-ascii?Q?BbHLruisxIEKveEIyLE+A1d8/Etu6UdQNpomVmXFnaCQfjQ6kOaSfTfNo0cr?=
 =?us-ascii?Q?8h0CqOSroicWys6RgSbApEykTD+N2V8YlclViVAGyCSXbxw8eWKJkzvGDsAc?=
 =?us-ascii?Q?myrLTGEu6SEVRV3tXutKjoozsbNzV+2nvf5BWR0kAC/phRQuX/lIDAxIgBRO?=
 =?us-ascii?Q?Rx01Xc7p0EHrOKylJjjXl9i6AVNbeo575GUo1e6n4hJOjdYSSeAxotH9Hm+l?=
 =?us-ascii?Q?Viz9ca/ORti9x1P1tXzYa4AYG/BNJROkMru2O+zoFlFv+eNnoA43pHY27t2q?=
 =?us-ascii?Q?QWFe5I3HhNRouT9+AiDfQ8drahqxUxfwF4zBRRyK34cqm+GhIvVhaD91xV4Y?=
 =?us-ascii?Q?H37tIQ1F/dS+xF4ODd54KUFOh7JAGeDwuy4j2o5/VyMW2zBUEOD+KTIe9lMV?=
 =?us-ascii?Q?qzYB81d4JGuKMB5WQo1iZotVxSoS99B0+C6dHEIrrvuz2JMOZS7i/jTiHHQC?=
 =?us-ascii?Q?157dV+K0PxcvOhpXr3bYY8D+8z91Y4UN10NmFNEQ0IvNAuJq0CVhEwNWkBVo?=
 =?us-ascii?Q?CIugfdErd+RtcKmTnIG4NmDqyg6uCJtYBh6t5sA4IHuYwMAjQKzkSi/RfvJ4?=
 =?us-ascii?Q?Ac3j9jc5G2CY8XKBXlQBBHmqK2dcCtqJlRpPyr4Pkp/HRKLAVJxbvCBTIKSi?=
 =?us-ascii?Q?wYGIhNhmj79p2P0viuKypKySMD22+mpF4/X2vMj4uCvD0sCR5cIdHHdC+lPj?=
 =?us-ascii?Q?2vP/PBGh5/uokbKnfEISKaOZt1/yMyQ9/00q5B2bhUWH06BqjXFmWjwPqeK5?=
 =?us-ascii?Q?f4pUanAhFnbgAQclKELnc6XP/6WBpfGUtxTm1KFljy0Yn5ejLKJ/VIVHC6f+?=
 =?us-ascii?Q?EBAVOYFDfzxrTf/8t9kmirtrDRPqaJXnpSMQBgXfRhGge11z8yJoc5b5XNFt?=
 =?us-ascii?Q?j+0KbLJiHZhOyA803FzK5zBre9RKHCeWbSyT+JXpTOsmHfVgV/MbyF0BsmGM?=
 =?us-ascii?Q?dJbGuz06XXdxiJuS0b83cP7cVGWG7smo6haDm2pIIuKk24pyij6/g7sm3uSu?=
 =?us-ascii?Q?QsK9CCEKrGcFbLa4B+STOTy9JG3lcRrXj3rPMqf0kluLmKML3kfP0oMiI6CW?=
 =?us-ascii?Q?nAwWE2olvmwe7QS/EHnsXQk3aMLmxdk=3D?=
X-Exchange-RoutingPolicyChecked: CKCuo4UlTFV59hcCdHt36N9QiZvmQWKYlsl4F4LXnETSdGNlmEQm8lEXqnG3KQrQprlzTyJgZ4EEOL02TVcy1bhyonivdwLAcgTyhzZ+544PJAMUS/7Wgotrdf+vbccAkY4noxKQub2HglPTdnkW3s/nwYT2oBJ0wJ7P+NexCsr8FgsM5+LocgP4W+cBpK5oe/L+2xDZbGsVUzTjZIdeHRUoExenEKEAghyz5GiVIv5Ntxbp/Gq6pihQSx4UPgWCECWnmlKor0MKQyP+3l1Su/ZFJIYfultMsXOVqVidFOaAKsWia1iXALiJ7pV1zOqJHMpMf+t369lbhQkIR3K0rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa75c152-9700-4b3b-6d38-08dedb48014b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 10:19:04.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K53XXthSkgubt4Uj7bx600rxAF7V+hoN6X638i9ZnJHlR5lai4bK7itl79XcU77z0el0nEmCI0B9cNml6CAAMPjWcO5C5l4GSssmfSTi3Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
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

On Sat, Jul 04, 2026 at 05:28:06PM +0530, Soumyadeep Hore wrote:
> The SEND_ON_TIMESTAMP TX offload capability was unconditionally
> advertised for all ice devices in non-safe mode. However, only E830
> hardware supports TxPP (Tx Packet Pacing) via the TXTIME queue
> mechanism. E810 and other ice devices correctly reject the offload
> at queue setup time (ice_tx_queue_setup checks hw->phy_model), but
> advertising the capability misleads applications into thinking the
> feature is available.
> 
> Gate the SEND_ON_TIMESTAMP capability advertisement on
> hw->phy_model == ICE_PHY_E830 so that only devices which actually
> support TxPP report the capability.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce


>  drivers/net/intel/ice/ice_ethdev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 0f2e7aee14..030d53aded 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4568,8 +4568,10 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
> +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +		if (hw->phy_model == ICE_PHY_E830)
> +			dev_info->tx_offload_capa |=
> +				RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
>  		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
>  	}
>  
> -- 
> 2.34.1
> 

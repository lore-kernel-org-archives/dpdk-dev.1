Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C80606EEA6
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HgnPPCDk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B95DC406B6;
	Mon,  9 Nov 2026 17:55:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 1B40140A6F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:55:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794243308; x=1825779308;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HP49Qv5PwyJE8X2Xesu9N4KnS5GLVy5uuzIacjWNZcc=;
 b=HgnPPCDkf2JacPeMw6DbVOwCKd95tPLH/Fz4AxOZZ1acEwt7pWfNJE9j
 1ObnPpfiq8jZJ0Vxl6X3jEbX2/i27/7sgjxGJ9kulYXPadotcV8PsZdCo
 /JA1f6xNgbcQK8+XicCFIYsnbxe6lPkopAqzukuXlzrmCgvysmFwY6rR+
 orslXJlj6NPM3/YZkHoJW7toBaHaLA0DsFTi0etPlXdgPdeHF0jZog6hr
 xi+WmIB/jbgMK7UWQvnIhXA8rYhtnMNYBoEnvNKIbdiwc5ONVDaRr/CfX
 GJ8Vz0IAzrF5oSIw6N/E1gTbt6bU4E8qaxMyimhOFPs/ea9a5YY+c+FHG Q==;
X-CSE-ConnectionGUID: tqB4EuIZQF2fqKwIFShU3Q==
X-CSE-MsgGUID: bjBkW1ZyTh+gSvoOgYtX+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2840531"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2840531"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 08:55:06 -0800
X-CSE-ConnectionGUID: hUD5dVyLTIiHdjtikwz2gQ==
X-CSE-MsgGUID: uuz2Wdx9RwmUSyhWncmgqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7939217"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 08:55:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 08:55:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 08:55:05 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 08:55:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deVuxGWBrMIJO6PhHON3kBc5a2m5DQXYpiRxL6Q1yEv2RcHFYnnEe9jqPg8SKVqikkoiiNnQdid82CnefodoAruxrFeT4fHQhUq18fMs9H3e5lxN4qd8RBcTsRw2IFWGIj71cCF0sxqkf3VvyCSLpB5G67ArzvANlW0tDaCbBOOA1i7MjC2qlcjKJhemAVIR1PXbgMxzXhfHw2rG00TeDb+nOT+tBFE7liSr9klvhy53e5G10dMPaQv1Kh4HZGaaMEfeHNvyLwAZWW1nVQZ4n7owjUB4UMC76mz6EQg91F1chgycLAgSHumjUuG03lXdeIhHgmK4g54oM1rpeyOetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zARlyISVbVRpv2olS3XFBkkGxp4NWEjNQCf+WiWrsU8=;
 b=vWy/T/3adx8ZferrrEzoArKrTa6UhZ/L7CaXRYTLMT41SPilR4Bi24GOHAH5OY2L+lrpu821isZVJoCqeOWUai0L+W/IQGH8S9Sglqu6pM2+OtEoEpnlDM0RWs00oNYYKtbFaVefG48TGhNJHMsglDYdOfhIp3++pLBYhwPNJ3fwbAgEmcFWcFZzpztpg3LmjiA5K/XsfoHp/RQpomj9bQEcdqOuNtGOMsZUgW5Q1AE/RokyrWohNZzy91uzSZsX3gW3+O6TzXisvP50P34PiUJEnjrOFlaUcshAiZ8eAk1QemC2rPNz8EZYuENYl6RtPPcLD3jQ+5HWAyxC4+A8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB733940.namprd11.prod.outlook.com (2603:10b6:8:46a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:55:04 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 16:55:03 +0000
Date: Mon, 9 Nov 2026 16:54:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jerome Tollet <jtollet@cisco.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel/common: track all RS buckets used by a Tx packet
Message-ID: <avH640eh50oIW3ev@bricha3-mobl1.ger.corp.intel.com>
References: <20261106092514.76289-1-jtollet@cisco.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106092514.76289-1-jtollet@cisco.com>
X-ClientProxiedBy: DB9PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB733940:EE_
X-MS-Office365-Filtering-Correlation-Id: f128963c-458e-411d-31d2-08df3e823338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003|261026121527099003|261102123227099003|261022075727099003|261022113327099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: EN7pTvWjzZid9kkHy2NhA2nlo+C22zkRkcrxZUz2GqIKXj3yOM8toXwkQ8mvGPVBvVHN/ytD0cX6zgx4gdRsh2hYlSTrpMT0iX8dNo4aJhi3G+/Tcjaf+YctqfsY3wHZ990I6GkWcXZU/o5Y8zM6rS1ZGnBVzRiqXc5peCNmnCh7xCB0zdKFaawvN2ttQBbQNBVeIBf7BWICJqIP4ivto3riw/FtTtvCTrCrmbAM1Z1G0d/fjFLmFAo+KL5iWysmjFa7rtIOqYKxP5h3D21NuudgXlL3+ElvhG9QDlu86T6NjvriAHM6nz8FwvXSh6ktiRfjQnWEBhSc1zrDsM2cpuQYn2gT/N5H1hx0eXdjjNn1TiCl3y8sPFF9KgtlX1qx1Zcg/q5IMFN4lPuJLqtCg8lYs3VKbOWqmUTGJ78eOFVUzoMeaGJPxP1LZWWjGk/jIh6KiQBR0xxqttiZUqqen7GPmSIfFHARRb3WBMUiXXOHxsjPEQKtMFkCLf1ujptW5qppbXG5cnCkgZQdQZ0Irs4+4VuklL9DADR9FiIlM3MUp9uKM1t/aHtqdBQJY+jR116mjVU5GALoUVrJcQHBglLbqVGEaEFyxr3NwHLX6Ol4fuZ/S2MVj/JMZV980vFVbtm3t9JL2TQvzNGZv7AW/GvWO5p6vj6yg7luD7GcU2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022113327099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LXhXb6tVcxfyM7c+oD8V6LLMZKQoCwtjrqad/9fOfdbEXLTuvlw/B00Se/mJ?=
 =?us-ascii?Q?TK/Vt670A4Ja5SN5pPORHho7cL9IjeBk3QK26MmP3xl7xBFKEFqoJI1KYHvb?=
 =?us-ascii?Q?DmIhbw+KiHRvltBJRGzw6VsGioJIhOrw8B5ewFkGQH7uvmTSFIcKNh7QWh7a?=
 =?us-ascii?Q?/RT7oXzeMahp3TfK/lBx0mieRWc/CXjhY5KIoXfOQ3Ex8D7NnZvBvhQRt8iT?=
 =?us-ascii?Q?dDiWZcW+9GuyDeiv2lLJOmOuqx/LTRz5F6VtNVB2C2/PfwDb6qkM2A4Kb9wO?=
 =?us-ascii?Q?m2TfWiCcEG4KxvgMkDnC/OHvLoS0/mQ1HBtS2LA6Jgjzc5/U8rUQBGGbO52k?=
 =?us-ascii?Q?B6CMMdCCpqAsMcHZPYu8++hrKO1jEXdTs22CotnIa0cFU8/8gE/8y1/lX4IS?=
 =?us-ascii?Q?J4IaAMgDwuhJQS1V28Y0q+aXTGqUZl9nfh01VuJt9aGT3vqqPJ5DGPeETbYN?=
 =?us-ascii?Q?2g2K7WpMuDpCOHyv+Wll5Aibgf8eCwv04ga7L2ZcpOpbNPwyuTMlUAdSyAC+?=
 =?us-ascii?Q?u5EAPY5JnjU2mBT8PUWL5yzXf7W7EJAiGtGJEo/R0itFBo+IuG1NsoUTIeAl?=
 =?us-ascii?Q?lTH5+a5GXsU6mqQHPIqQpllHS/lchbDPQhr6OTUMKv4D0YSk2hfG7cFN+izQ?=
 =?us-ascii?Q?pg8tGuTqNkfXOh9HrBwpDNmcJgb5oD4Ur9I68xSpujZ6KEwGAdjPJb4A7SX8?=
 =?us-ascii?Q?AyxF2pZdDWv1Y2VTVvmyS+V7/v17lSS33P3Z09Sey+aNZv3/hnqZ56SvWa1X?=
 =?us-ascii?Q?xDK7AKVfCZjfpvILpPFEAoPPbL4ur9xPx0N3JctxxlFt63VEFJ7beqKUReaN?=
 =?us-ascii?Q?bZLR6W1iumXRiykkMgka2lsXJdlhraayvLdnENTWVpjChPLxj4zfa0UEJCx6?=
 =?us-ascii?Q?iQGZhmheyQyk7hz3fPENsXPuwJhCJ96/BhWEYMhwSKZKtc+Lq82OdfY+Y0Ts?=
 =?us-ascii?Q?+9uO2uxaB30T6rnhaMrTYEGHgYn+kn2ZO4l4w/XDK/8cM/v1PT2rqd7qsfMf?=
 =?us-ascii?Q?PPKaPGY542wohNo/hzPuyxrZN+0lRs7YWTfRezfqIbRogKTDLKJHm6AJs/Cp?=
 =?us-ascii?Q?O30U+aEohYAZFkzoN7vFY/ErKWUSuA1+o5T7z8uYbIcQp7yMruCs4iNqjMdB?=
 =?us-ascii?Q?BjuQKblWdY3LSLhZVS6sb0+2HuDi4Sd4tzrQ7h4apM3t8ppYhYchkykz4Llw?=
 =?us-ascii?Q?xd+v69iBUaI4kqmX+XOAhtXxbtlYC+gR8NzzwiKePJBZqBzsdylACTu7S8I5?=
 =?us-ascii?Q?I65bUkUdFRD1uE2wN1kdsHpalKu43q2OHkJ3wue0G5LjVct2mmUhhN24KQ89?=
 =?us-ascii?Q?6RndtBOoLTe0Ly7/7GRqA2S8HgIe3Pq+M678dtJfPXwbPLJbtPVOyECTt4Tv?=
 =?us-ascii?Q?OQEbNxG5ApAR7Cfe+4zvYJa6T6vedS3bPZ59h7gR0jMTHtDqSVZiG3Bz8Gu4?=
 =?us-ascii?Q?Suj3+EkG63m8dyEQKI3/IcU8NvshN9ocPVfNehxStRGwwiGxeXJdNAp8cZZv?=
 =?us-ascii?Q?0VEyE+pdfZf2ymfavPutPy5Z08TMiPUP+JanLpR+rXMEQbIPRHoEapanQroX?=
 =?us-ascii?Q?gnln4uoiYWSGQzxOA61ZHuU9bRIvw1/vSfh11HLnGLr/Phg0XlLyZm/HOydO?=
 =?us-ascii?Q?iQeoItCu/TFNPTDKchcm841dZoqz7o/qKaiyenmjyeo0iPWDbB0G5vPLD9Ov?=
 =?us-ascii?Q?jWnNfqQMJtPktvaKcewscOkTrKj70ZWGBZrA9JRdZ/F/sbgNqiCI6w/uG9aM?=
 =?us-ascii?Q?k+InhV6KDeU9I4bnS62hHQNwJN0UGBY=3D?=
X-Exchange-RoutingPolicyChecked: eJ5MEOO0JgffdtkqKkeDeYejtHJPl/c2sF/y2rxyNJ3dWpKwg7dRTSrt2NMtQNZlAwxhzKQbFNSPEN7EfhyyxkuV0Q8fuIACcjPzw5v8pPAccjH8EJSrkdVmDuJjGV/x7o0QiwNhFx34wI4H0J1gA+O3k2fAF/Bi7UuNJOI3KEI0MGr/LCZPCxlovMSyot9HhZP5ie1ulYo722b/aAmhf8eQW12vxfESorUjXZrCR0de0aqBZrnabc3teAQeaYnDdnmWWKJYZfaJbMWoJWJQigsuZlTSEzOdKpeOcUMThloJ50f8ViB5Qb5Gqs3hgjFoBsQmWaXGRkzdBxG2pPEHtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f128963c-458e-411d-31d2-08df3e823338
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:55:03.8524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/p2Q3H/BaGlBwGdnOEJufnAxTrRELCbkp9zUarr8YtxQw2OudgunRPWQV4Q6IPbSabh8xuRz27KRCDo0fXbJ68JO/MZseSxdFgKa89N6zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB733940
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 10:25:14AM +0100, Jerome Tollet wrote:
> A TSO packet can use more descriptors than tx_rs_thresh. The scalar Tx
> path records the completion descriptor only for the bucket containing
> the packet's first descriptor. If the packet fills the next bucket,
> that bucket has no completion entry. Cleanup then stops reclaiming
> descriptors and the Tx ring stalls.
> 
> Record the packet's last descriptor for every bucket it crosses, and
> wrap the bucket index at the end of the ring.
> 
> On E810 PF (ice) and VF (iavf) with 2K buffers and tx_rs_thresh=32,
> 65K GSO NVMe/TCP traffic reproduced the stall. With this change,
> 4K and 128K CRC tests passed with TSO enabled on both.
> 
> A standalone DPDK iavf reproducer, with no VPP, sends a 31-descriptor
> TSO packet followed by a 33-descriptor TSO packet. Both pass
> rte_eth_tx_prepare(). The original PMD leaves rs_last_id[1] pointing
> to descriptor 0 and stalls after 991 further packets. With this fix,
> it records descriptor 63 and transmits all 2048 further packets.
> 
> Fixes: 8f4396b9f63c ("net/intel: use separate array for desc status tracking")
> Cc: stable@dpdk.org
> Signed-off-by: Jerome Tollet <jtollet@cisco.com>
> ---
>  .mailmap                             |  1 +
>  drivers/net/intel/common/tx_scalar.h | 23 +++++++++++++----------
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 

Thanks, fix looks correct to me, and AI agrees. However, I have a few
stylistic comments inline below. If you're ok with it, I can make the
couple of suggested changes on apply. (Otherwise, please send a v2)

/Bruce

> diff --git a/.mailmap b/.mailmap
> index 754dd9e760..ff75ec12a2 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -752,6 +752,7 @@ Jerin Jacob <jerinj@marvell.com> <jerin.jacob@caviumnetworks.com>
>  Jerin Jacob <jerinj@marvell.com> <jerinjacobk@gmail.com>
>  Jeroen de Borst <jeroendb@google.com>
>  Jerome Jutteau <jerome.jutteau@outscale.com>
> +Jerome Tollet <jtollet@cisco.com>
>  Jerry Hao OS <jerryhao@os.amperecomputing.com>
>  Jerry Lilijun <jerry.lilijun@huawei.com>
>  Jerry Zhang <jerry.zhang@intel.com>
> diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
> index 7368d3abc9..c328f8d56b 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -614,22 +614,25 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  end_pkt:
>  		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
>  
> -		/* Check if packet crosses into a new RS threshold bucket.
> -		 * The RS bit is set on the last descriptor when we move from one bucket to another.
> -		 * For example, with tx_rs_thresh=32 and a 5-descriptor packet using slots 30-34:
> -		 *   - pkt_rs_idx = 30 >> 5 = 0 (started in bucket 0)
> -		 *   - tx_last = 34, so 35 >> 5 = 1 (next packet is in bucket 1)
> -		 *   - Since 0 != 1, set RS bit on descriptor 34, and record rs_last_id[0] = 34
> +		/* A packet may consume more than one RS threshold bucket. The
> +		 * last descriptor reports completion for every bucket crossed by
> +		 * that packet, including buckets with no packet start.
>  		 */

I'm not happy with deleting the old comment here, I think it was useful to
have. Therefore I'd suggest keeping it and moving the new comment down to
be just before the loop which actually does the rs_last_id assignment. That
keeps things more comprehensible for future readers, I feel.

> -		uint16_t next_rs_idx = ((tx_last + 1) >> txq->log2_rs_thresh);
> +		const uint16_t nb_rs_buckets = txq->nb_tx_desc >> txq->log2_rs_thresh;
> +		uint16_t next_rs_idx = (tx_last + 1) >> txq->log2_rs_thresh;
> +		uint16_t rs_idx = pkt_rs_idx;

rs_idx is the loop counter only used there, so I'd suggest moving it to be
defined inside the if to reduce its scope. (To minimise the diff I'd also
tend to keep the braces on the nex_rs_idx assignment, when reviewing I was
scanning it trying to see how the calculation had changed.)

>  
> +		if (next_rs_idx == nb_rs_buckets)
> +			next_rs_idx = 0;
>  		if (next_rs_idx != pkt_rs_idx) {
> -			/* Packet crossed into a new bucket - set RS bit on last descriptor */

Again, no need to remove the comment.

>  			txd->cmd_type_offset_bsz |=
>  					rte_cpu_to_le_64(CI_TX_DESC_CMD_RS << CI_TXD_QW1_CMD_S);
>  
> -			/* Record the last descriptor ID for the bucket we're leaving */
> -			txq->rs_last_id[pkt_rs_idx] = tx_last;
> +			do {
> +				txq->rs_last_id[rs_idx] = tx_last;
> +				if (++rs_idx == nb_rs_buckets)
> +					rs_idx = 0;
> +			} while (rs_idx != next_rs_idx);
>  		}
>  
>  		if (ts_fns != NULL)
> -- 
> 2.56.0
> 

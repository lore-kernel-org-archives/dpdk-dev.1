Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CB9E87842
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 15:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37C644029D;
	Tue,  3 Feb 2026 16:37:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 79DCF4013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 16:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770133067; x=1801669067;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=togO1/8eDB+aqnFuAEX00aeGJm71N9j0SPnFn/ZLHAs=;
 b=ZhxuywgMc21ZgJ+4Y8cNZRIbfhMdEp1XSiPPBsTCT0M30Z+ZcES+PgSx
 zSAuOcD8R/+RtokPjNjYecQ2kZev6UqN878ODnofMLXU2HRDqiFfsWxoR
 c0i62jag7nwa+8Zki/DM/ExyaGNGrKZz1ulmptc+Cn9gm2uGWOL3/n5Vs
 1xjgXjSCAS+rfS2mte3TXdldbiO5vH+fB4NnEbCBIboGc7/I5sr7LwubZ
 dKOAmI+JlmHTXPeYpN7STe+XrR9KPSkwtc1tW2VDtNfcNmEuCiODqxh4U
 WMIlPeB1M8HjUeF6rIPBUSV8LiQo60lo5vxRg29kW0yf8WA7u6JD7n/96 g==;
X-CSE-ConnectionGUID: aoFLUuViQ2ujuQ+AcZDqow==
X-CSE-MsgGUID: 5lcCSRWwSzKI42maJe6pcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82044448"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82044448"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 07:37:45 -0800
X-CSE-ConnectionGUID: pvNGLLZzSSG4tMGC8Wx5zQ==
X-CSE-MsgGUID: JW5weI5wTwCZZ/4GFooRvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="214839527"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 07:37:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 07:37:44 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 07:37:44 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 07:37:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOS8CGSV3/PKgmq9zuWDfaMV+PWbMDkoYcD7OSVXOUjSWBa1asKS2OVT+X2g0iau3LNihxbgvlPBPEMAISc/Ej6qWAhl3Apn6ZHc65/Qiq/B4wy9q6MFG19RTFFjUQIxIi1drVI48xjja+4KLcUpeSQwF5bfSWxDJX4GQP4lkqYcMTS8cbmz9QX0ipNXtkIREkFhJOyczbSssF8NHM2PDjjCzTrO6Sa0ttOXhi/ekLuNChhUeUuDElEThZTSaWqYBDUAYa9qghHllQrIztvgwheZT5cnFnu9kmyuL/m1LiMjWCI7x/w6s5PEIFGg7IwdOZRv2dJ2kvBPDhz2/1ZsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfrnzLAbLM26dk7maRYHYnRURWdmsjEtJ/Ac9MKvmAA=;
 b=SwJoss4TX5rA7UoZyVc6YYywQUMCkFoMZreY0lzBtUg6nu2fGBMRWWLNA1vWoSIx+xjmNB1PXFuL4F7mQVH1o/H2QH6akwKSrXD1VGJLLSKO/XbjaTD8AAOHyeRBn5KaS4wA9xVvUlC6dBUV5IAkCDlSltzDypGBD3zCFbyjd+DB0+/jq6BWbCDjf/QLbTYQnWsWNiy76lLrPin4ipkneXqWD3kT1UPjCBW90s7CR5dHGC0xJHho+o6VF5uIUcOeCJiqm4IOU+N8OFiOpfYWxrZxakmalPkdLQGHriX2j4K/QrOg3wsO3dCICE8InGuKJ3VW/f6E4h+4/nDYqvo7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:37:41 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:37:41 +0000
Date: Tue, 3 Feb 2026 15:37:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v5 3/4] net/intel: add support for PTP
Message-ID: <aYIWPoiaSiN7Y7bp@bricha3-mobl1.ger.corp.intel.com>
References: <20260120191120.137078-4-soumyadeep.hore@intel.com>
 <20260123000449.188008-1-soumyadeep.hore@intel.com>
 <20260123000449.188008-4-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260123000449.188008-4-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB8PR06CA0054.eurprd06.prod.outlook.com
 (2603:10a6:10:120::28) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA1PR11MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: db855ed9-99df-46d1-67ac-08de633a2ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M2WnnOkO2HfxG3iIm9vh5OmMR5XLF6o2UHv/uGPhjDScF9uq8ScnuRd1Vx26?=
 =?us-ascii?Q?7VhSR4K/HqhbeT4m8SXQbDpRDq0/hfujcasg52xEfXHc6itMo1fW3AN0IDnx?=
 =?us-ascii?Q?r7Fn0QoT+RYjeCsPucEEeQoJynBTcWoCqKo3hFv3A6zc52FZcrBCGrkZkKuA?=
 =?us-ascii?Q?tco/RwQ6apqv8Mtv1/LGvbPkdByUvYLy4tOmWsUomgkeQpfXYAxt86eNc842?=
 =?us-ascii?Q?HtbTrICH9WBW7vxjC+fsZVRu89epwIhUgSSKKpkJW6Xv2kpi/LIPPLaeSawg?=
 =?us-ascii?Q?Zazq/kyL3OVB8IgVcjNgfr+339P/TnGH8H9wAHqypTsTYXdiVK6Hap7f35+F?=
 =?us-ascii?Q?jF03zPEEPcjc93YYhHs+D0eWDj2YepO/kDuV3YsfcbI9Smd+tUjZr9syySbU?=
 =?us-ascii?Q?oSkwHt5wibmrA/rr3FQklduXQ6NNOGwZOVVVAEbbocqyrHBiJxmsE4BLfpGB?=
 =?us-ascii?Q?Mt+8/Nsv6Qbaoeq2WAFjJliWnX88godMauTXEup6U8bEObdHLDoaeK5rhIwe?=
 =?us-ascii?Q?iClE6x+zDARIgsOlLE9FFQcJjY+/r8SkDoFU7kLU4as4PI47udpaLkUtSqET?=
 =?us-ascii?Q?4BJbUj7bAGS/luC6MR3aPN0Lbe59LIKtWk4O8eYD4QHamhXNouxpiOsxNRuD?=
 =?us-ascii?Q?9xRkvUub/txdtAPvpjn8id+dzyGhthtLVRlmA1Yas2PCJVqOl6v4RyJeg151?=
 =?us-ascii?Q?Uz32m65175K9LZrS6/14Gjp8ZBYxI5no6QPPU1D013Q88y/QjIhAy5t8cMxW?=
 =?us-ascii?Q?xg3p6EbQRe9pdgjSGMMbWjwKoTWhDPuu5Jl+QInY4ZxXoW9bcNKyWNWD9tTW?=
 =?us-ascii?Q?NMB2GqQEZaA1n3pbsjKUE0oeKg5T5pwDttmPxduS13gB3n7ul2GkBlcnv/6e?=
 =?us-ascii?Q?rspnerACa2Di49yIcnbgUyl5LCFKWIumHWT6F4S37sqIYv+p0ts8aAQKi65w?=
 =?us-ascii?Q?e5HSiuhPO5sUQZpkKfkkGwaR26YKmKnfwJpNgLirzKIL/cXydNeAKTGzprTs?=
 =?us-ascii?Q?SPsIZfKRaT5ijY+HLC4EKfwTIeMuoS8zuGdXuSm8RtE+mH/oM9+VUOtLYtaq?=
 =?us-ascii?Q?UAxfA50J8z1VgKGyr0nC2n7X22K3/5SEnkiali9l581RFSIjPIutkC3REyD7?=
 =?us-ascii?Q?iowkEmWbe48OT2BSSzGazeG7NIm5jOsm4nUKHr2+d58J1NXuLHTMYy4yr+5e?=
 =?us-ascii?Q?lDJm7mXtGiCKy+Y4QL0Czfn/Ul9K4Agu9R/QcUZQ45i6FXAKfqzMTcie4iOJ?=
 =?us-ascii?Q?R7SCO2wcJJK2oCF03tWrlytHOFjvM+OVOQi/47Ygcx9mMAzbb1zbo3x6LS6i?=
 =?us-ascii?Q?aHAGetX+lwNhl2jugX5Y1jxR+qX2AilkOf2BEwMwykWgpn66ILQV3XfVTodC?=
 =?us-ascii?Q?TLaqpDs5lECjvxBLrD4gXSNL/Y7BK/4MXQCfa+MlSp4w+PxygEjAmULMH7ov?=
 =?us-ascii?Q?MVw0O49OmkX6WbzdZI82nfs4ypNqTJJtcjw1w6WoutAlp2iuSpxajJiRksnP?=
 =?us-ascii?Q?M95kp710jk7HaMQCF0pQ2IFGE/H4dTeQITS+xlshHcShUA9nvFXLmi+Pgolj?=
 =?us-ascii?Q?Uv853l8j360vPi5XBP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G6IIzg5WUqWIOzkPPJ3j4/a6HU1iFLwmzFhsBCVyLAjhcP2YUC1ne9paiLWP?=
 =?us-ascii?Q?85NauiwAVUTWDwBxzoITFxx4q7xU0yVDggYSvKH6QiGbA0P2iZaJpIc4xVj+?=
 =?us-ascii?Q?XkOFpgCavSizhpGOXq1IkGlf9lDFCCoLxgbvh6ziNUVe8rnfqUo1tFxIv3JF?=
 =?us-ascii?Q?/L4lAbgpTmxP8hgo0CEWDhmM1PfF/uqeZgT50AzZWwg8LM7RPQFwmYjtaeGL?=
 =?us-ascii?Q?9Q5Q0LwDr84iH5b8e4J58pFAlbaP9CE/Rbz7/toVJuFpHjv+whxqAhYO2Jg6?=
 =?us-ascii?Q?PPOEC0ddgN1WVVTQLPkqgWdgNeFXV8s0e+ME3D807CPvrbaxtZdiA0yILn81?=
 =?us-ascii?Q?9S31wor/l3lUKRJEEQTZU3UImcpacwAwFAgSe/GomvmffA92x4EBCh/7CG6Y?=
 =?us-ascii?Q?xuNGDboGVaQvs5qO8/VrCVruM2cg4oq4JXqIczrTb63mhj/8XUWe6UF7XJsI?=
 =?us-ascii?Q?FGWYv+288C/5OP8Dh4hPkUT+7JRlKBRAO2GljdBWvXKjO0VKenUi7TWLTnWJ?=
 =?us-ascii?Q?ZxIZ78orpViq6E7fRrdoSU1yOcQWn/1MkGPV7+lZu6RwTYh4UREh4fI6+be+?=
 =?us-ascii?Q?/QsCnSkCssfLcV+VRvD2UjmkiXfZIwoBS0s6N1xyNTPB0iOePykZYCF2iMlV?=
 =?us-ascii?Q?POnA91Cl4WmK8CGlcAac+zcdL6bYydKtC6npZUCytY4I9mmY08gCNopke9nC?=
 =?us-ascii?Q?M9D4xKNoYc7pt1/Atv0vSRzu4b8yGaswZomgyBxFnp+TLEz5z/zMIf8di0wj?=
 =?us-ascii?Q?QE0Id5gcgyHlc2jeBpOe1aQkfL6ycveI3O/ITzDnE0h7gekXu5d9lpCPSbAg?=
 =?us-ascii?Q?ILjU2qKn9QFfwW3UpQraslVDZDdnmipwzaT6Hd/o5zmJ9BOf3/VUDwvTh6nz?=
 =?us-ascii?Q?qZAMBRurDpsW1qOTmWM0G9S5sjRkMS3nU8shYSTbSOMRe3BUppdIOC3xJ4s/?=
 =?us-ascii?Q?CbrKNc2dSxLVl1GhhTnzfdBbNAtlLs2N07Kl92f4eUn9GXNjh8EnK6Aw5jpH?=
 =?us-ascii?Q?1G00lXrpPuQ7pcYxNyJMBRejNoI4bTO7MfI6FFBwJodWtJmjyRe51ZJm8zgQ?=
 =?us-ascii?Q?ERxgi3esiw8HpTxijfc/65JPoHeJgiw5yu09dpQJXDLPcMvcfUUDJXLgdO50?=
 =?us-ascii?Q?TpIxEir5ukNmPJUx1qq9Q8zKCtzxA8EDCipsfRc1VptYIsQ3po4SCB/aZJWU?=
 =?us-ascii?Q?VTPreS9ivd4LYG/JCb0Th2BeLJZUk/WVduXoy+AGNJWS8e2PjcPPUN2hZ2U1?=
 =?us-ascii?Q?9GomDJbnTSkNHXe0Qndw5bfKQPF/PfohNZIo4Sbf+dsT4aOW7QlluCc5lGP6?=
 =?us-ascii?Q?nExzpgNG34Se+NcjPeuwgI+OpqeVuckKQpEvLHOrVGhbjFHCGZNvqvrzyE95?=
 =?us-ascii?Q?PnrkDdFg5ZADIY1gp9MUv7ETQoTPmV/5taFxv+w78swIU76IoKuyVmONQ1UR?=
 =?us-ascii?Q?z2QduRhsDabWGEcXV19RoWN8w6xWBHYPh1/oYAjRwuSEEA1ZoXdpaS07TrWr?=
 =?us-ascii?Q?tENX4rTwEZWlvObUeYBPeHF8h4NDcv0k2EO1qAAb2Xub1Jae9akRS3TL3MoM?=
 =?us-ascii?Q?rPmj5DZEWcRr2bq7Wwxx7NPNOSZEM259sjeFla/PXLx0BHh7f+0e4qUuvHqW?=
 =?us-ascii?Q?oXgzGrl5mNkNkk0Zjt8TqrsluvwoxdRZz/JRipvLnEYawxUo1303wqVzdRU+?=
 =?us-ascii?Q?4PTCjKFFSSlGZ49+Tw6eyFdo+hXEI+trfogwh7nMO69NoVGYhO4boqRge53T?=
 =?us-ascii?Q?yoX1uzJOVV5IM/pFYvkIY/kvBDyaZFU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db855ed9-99df-46d1-67ac-08de633a2ab8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:37:41.2699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiZ7U/fR5uyLCVczKo+Z8UvdaiouOMbscgAHTYCc/fDh4QLwd3zUMsYxbFQ9ufDip5j3f5H4JPDLotw946C15711oZ0QgFVdIgLZwMaeLaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
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

I know that checkpatch will complain that this affects common intel files
and suggest that "net/intel" is the prefix to use, but in this case, it's a
one-line change to common headers, everything else is in idpf so I think
net/idpf is a better reflection on the patch contents.

On Thu, Jan 22, 2026 at 07:04:48PM -0500, Soumyadeep Hore wrote:
> Add support for PTP that contains negotiation with CP to receive a
> set of supported functionalities through capabilities,

Consider rewording please - it's not PTP that contains the negotiation, for
example - it's the patch! :-)

Some other comments inline below.

/Bruce

> get/set/adjust the time of the main timer and Tx timestamping
> through secondary mailbox dedicated to PTP.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/common/tx.h             |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 186 +++++++++------
>  drivers/net/intel/idpf/idpf_common_rxtx.h |  10 +
>  drivers/net/intel/idpf/idpf_ethdev.c      | 270 ++++++++++++++++++++++
>  4 files changed, 396 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 5af64a4cfe..617e184976 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -109,6 +109,7 @@ struct ci_tx_queue {
>  				struct ci_tx_queue *complq;
>  				void **txqs;   /*only valid for split queue mode*/
>  				uint32_t tx_start_qid;
> +				uint32_t latch_idx; /* Tx timestamp latch index */
>  				uint16_t sw_nb_desc;
>  				uint16_t sw_tail;
>  				uint16_t rs_compl_count;
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a5d0795057..c8cd5b9d5b 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -9,6 +9,7 @@
>  #include "idpf_common_rxtx.h"
>  #include "idpf_common_device.h"
>  #include "../common/rx.h"
> +#include "idpf_ptp.h"
>  
>  int idpf_timestamp_dynfield_offset = -1;
>  uint64_t idpf_timestamp_dynflag;
> @@ -435,58 +436,6 @@ idpf_qc_split_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
>  	return 0;
>  }
>  
> -#define IDPF_TIMESYNC_REG_WRAP_GUARD_BAND  10000
> -/* Helper function to convert a 32b nanoseconds timestamp to 64b. */
> -static inline uint64_t
> -idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,
> -			    uint32_t in_timestamp)
> -{
> -#ifdef RTE_ARCH_X86_64
> -	struct idpf_hw *hw = &ad->hw;
> -	const uint64_t mask = 0xFFFFFFFF;
> -	uint32_t hi, lo, lo2, delta;
> -	uint64_t ns;
> -
> -	if (flag != 0) {
> -		IDPF_WRITE_REG(hw, GLTSYN_CMD_SYNC_0_0, PF_GLTSYN_CMD_SYNC_SHTIME_EN_M);
> -		IDPF_WRITE_REG(hw, GLTSYN_CMD_SYNC_0_0, PF_GLTSYN_CMD_SYNC_EXEC_CMD_M |
> -			       PF_GLTSYN_CMD_SYNC_SHTIME_EN_M);
> -		lo = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
> -		hi = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_H_0);
> -		/*
> -		 * On typical system, the delta between lo and lo2 is ~1000ns,
> -		 * so 10000 seems a large-enough but not overly-big guard band.
> -		 */
> -		if (lo > (UINT32_MAX - IDPF_TIMESYNC_REG_WRAP_GUARD_BAND))
> -			lo2 = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
> -		else
> -			lo2 = lo;
> -
> -		if (lo2 < lo) {
> -			lo = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
> -			hi = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_H_0);
> -		}
> -
> -		ad->time_hw = ((uint64_t)hi << 32) | lo;
> -	}
> -
> -	delta = (in_timestamp - (uint32_t)(ad->time_hw & mask));
> -	if (delta > (mask / 2)) {
> -		delta = ((uint32_t)(ad->time_hw & mask) - in_timestamp);
> -		ns = ad->time_hw - delta;
> -	} else {
> -		ns = ad->time_hw + delta;
> -	}
> -
> -	return ns;
> -#else /* !RTE_ARCH_X86_64 */
> -	RTE_SET_USED(ad);
> -	RTE_SET_USED(flag);
> -	RTE_SET_USED(in_timestamp);
> -	return 0;
> -#endif /* RTE_ARCH_X86_64 */
> -}
> -
>  #define IDPF_RX_FLEX_DESC_ADV_STATUS0_XSUM_S				\
>  	(RTE_BIT32(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_XSUM_IPE_S) |     \
>  	 RTE_BIT32(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_XSUM_L4E_S) |     \
> @@ -655,8 +604,12 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  	rx_desc_ring = rxq->rx_ring;
>  	ptype_tbl = rxq->adapter->ptype_tbl;
>  
> -	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0)
> -		rxq->hw_register_set = 1;
> +	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
> +		uint64_t sw_cur_time = rte_get_timer_cycles() /
> +							(rte_get_timer_hz() / 1000);

Reading the timer can be a slow operation. Therefore I suggest that you
also check if hw_register_set == 1 as part of the condition, and skip the
read in that case as unnecessary. Not sure if there are other global
conditions that also can be checked here too, e.g. the
idpf_timestamp_dynflag?

> +		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
> +			rxq->hw_register_set = 1;
> +	}
>  
>  	while (nb_rx < nb_pkts) {
>  		rx_desc = &rx_desc_ring[rx_id];
> @@ -732,20 +685,38 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			ptype_tbl[(rte_le_to_cpu_16(rx_desc->ptype_err_fflags0) &
>  				   VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M) >>
>  				  VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_S];
> +
> +		if ((rxm->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
> +			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
> +
>  		status_err0_qw1 = rte_le_to_cpu_16(rx_desc->status_err0_qw1);
>  		pkt_flags = idpf_splitq_rx_csum_offload(status_err0_qw1);
>  		pkt_flags |= idpf_splitq_rx_rss_offload(rxm, rx_desc);
>  		if (idpf_timestamp_dynflag > 0 &&
>  		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP)) {
>  			/* timestamp */
> -			ts_ns = idpf_tstamp_convert_32b_64b(ad,
> -							    rxq->hw_register_set,
> -							    rte_le_to_cpu_32(rx_desc->ts_high));
> -			rxq->hw_register_set = 0;
> +			rxq->time_high = rte_le_to_cpu_32(rx_desc->ts_high);
> +			if (unlikely(rxq->hw_register_set)) {
> +				ts_ns = idpf_tstamp_convert_32b_64b(ad,
> +							    rxq->hw_register_set, true,
> +							    rxq->time_high);
> +				rxq->hw_time_low = (uint32_t)ts_ns;
> +				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
> +				rxq->hw_register_set = 0;
> +			} else {
> +				if (rxq->time_high < rxq->hw_time_low)
> +					rxq->hw_time_high += 1;
> +				ts_ns = (uint64_t)rxq->hw_time_high << 32 | rxq->time_high;
> +				rxq->hw_time_low = rxq->time_high;
> +			}
> +			rxq->hw_time_update = rte_get_timer_cycles() /
> +						     (rte_get_timer_hz() / 1000);
>  			*RTE_MBUF_DYNFIELD(rxm,
>  					   idpf_timestamp_dynfield_offset,
>  					   rte_mbuf_timestamp_t *) = ts_ns;
>  			first_seg->ol_flags |= idpf_timestamp_dynflag;
> +			if (rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID)
> +				rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
>  		}
>  
>  		first_seg->ol_flags |= pkt_flags;
> @@ -839,10 +810,34 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
>  static inline uint16_t
>  idpf_calc_context_desc(uint64_t flags)
>  {
> -	if ((flags & RTE_MBUF_F_TX_TCP_SEG) != 0)
> -		return 1;
> +	static uint64_t mask = RTE_MBUF_F_TX_TCP_SEG |
> +		RTE_MBUF_F_TX_IEEE1588_TMST;
>  
> -	return 0;
> +	return (flags & mask) ? 1 : 0;
> +}
> +
> +/**
> + * idpf_tx_set_tstamp_desc - Set the Tx descriptor fields needed to generate
> + *			     PHY Tx timestamp
> + * @ctx_desc: Context descriptor
> + * @idx: Index of the Tx timestamp latch
> + */
> +static inline void
> +idpf_tx_set_tstamp_desc(volatile union idpf_flex_tx_ctx_desc *ctx_desc,
> +				uint32_t idx)
> +{
> +	ctx_desc->tsyn.qw1.cmd_dtype =
> +		rte_cpu_to_le_16(FIELD_PREP(IDPF_TXD_QW1_CMD_M,
> +				       IDPF_TX_CTX_DESC_TSYN));
> +	ctx_desc->tsyn.qw1.cmd_dtype |=
> +		rte_cpu_to_le_16(FIELD_PREP(IDPF_TXD_QW1_DTYPE_M,
> +				       IDPF_TX_DESC_DTYPE_CTX));
> +	ctx_desc->tsyn.qw1.tsyn_reg_l =
> +		rte_cpu_to_le_16(FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_L_M,
> +				       idx));
> +	ctx_desc->tsyn.qw1.tsyn_reg_h =
> +		rte_cpu_to_le_16(FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_H_M,
> +				       idx >> 2));
>  }
>  
>  /* set TSO context descriptor
> @@ -948,6 +943,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
>  							ctx_desc);
>  
> +			if ((ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) != 0)
> +				idpf_tx_set_tstamp_desc(ctx_desc, txq->latch_idx);
> +
>  			tx_id++;
>  			if (tx_id == txq->nb_tx_desc)
>  				tx_id = 0;
> @@ -1104,8 +1102,12 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  	rx_ring = rxq->rx_ring;
>  	ptype_tbl = rxq->adapter->ptype_tbl;
>  
> -	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0)
> -		rxq->hw_register_set = 1;
> +	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
> +		uint64_t sw_cur_time = rte_get_timer_cycles() /
> +							(rte_get_timer_hz() / 1000);
> +		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
> +			rxq->hw_register_set = 1;
> +	}
>  
>  	while (nb_rx < nb_pkts) {
>  		rxdp = &rx_ring[rx_id];
> @@ -1167,17 +1169,33 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  
>  		rxm->ol_flags |= pkt_flags;
>  
> +		if ((rxm->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
> +			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
> +
>  		if (idpf_timestamp_dynflag > 0 &&
>  		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
>  			/* timestamp */
> -			ts_ns = idpf_tstamp_convert_32b_64b(ad,
> -					    rxq->hw_register_set,
> -					    rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
> -			rxq->hw_register_set = 0;
> +			rxq->time_high = rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
> +			if (unlikely(rxq->hw_register_set)) {
> +				ts_ns = idpf_tstamp_convert_32b_64b(ad,
> +							    rxq->hw_register_set, true,
> +							    rxq->time_high);
> +				rxq->hw_time_low = (uint32_t)ts_ns;
> +				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
> +				rxq->hw_register_set = 0;
> +			} else {
> +				if (rxq->time_high < rxq->hw_time_low)
> +					rxq->hw_time_high += 1;
> +				ts_ns = (uint64_t)rxq->hw_time_high << 32 | rxq->time_high;
> +				rxq->hw_time_low = rxq->time_high;
> +			}
> +			rxq->hw_time_update = rte_get_timer_cycles() /
> +						     (rte_get_timer_hz() / 1000);
>  			*RTE_MBUF_DYNFIELD(rxm,
>  					   idpf_timestamp_dynfield_offset,
>  					   rte_mbuf_timestamp_t *) = ts_ns;
>  			rxm->ol_flags |= idpf_timestamp_dynflag;
> +			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
>  		}
>  
>  		rx_pkts[nb_rx++] = rxm;
> @@ -1218,6 +1236,13 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  	if (unlikely(!rxq) || unlikely(!rxq->q_started))
>  		return nb_rx;
>  
> +	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
> +		uint64_t sw_cur_time = rte_get_timer_cycles() /
> +							(rte_get_timer_hz() / 1000);
> +		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
> +			rxq->hw_register_set = 1;
> +	}
> +
>  	while (nb_rx < nb_pkts) {
>  		rxdp = &rx_ring[rx_id];
>  		rx_status0 = rte_le_to_cpu_16(rxdp->flex_nic_wb.status_error0);
> @@ -1298,17 +1323,33 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			ptype_tbl[(uint8_t)(rte_cpu_to_le_16(rxd.flex_nic_wb.ptype_flex_flags0) &
>  				VIRTCHNL2_RX_FLEX_DESC_PTYPE_M)];
>  
> +		if ((first_seg->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
> +			first_seg->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
> +
>  		if (idpf_timestamp_dynflag > 0 &&
>  		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
>  			/* timestamp */
> -			ts_ns = idpf_tstamp_convert_32b_64b(ad,
> -				rxq->hw_register_set,
> -				rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
> -			rxq->hw_register_set = 0;
> +			rxq->time_high = rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
> +			if (unlikely(rxq->hw_register_set)) {
> +				ts_ns = idpf_tstamp_convert_32b_64b(ad,
> +							    rxq->hw_register_set, true,
> +							    rxq->time_high);
> +				rxq->hw_time_low = (uint32_t)ts_ns;
> +				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
> +				rxq->hw_register_set = 0;
> +			} else {
> +				if (rxq->time_high < rxq->hw_time_low)
> +					rxq->hw_time_high += 1;
> +				ts_ns = (uint64_t)rxq->hw_time_high << 32 | rxq->time_high;
> +				rxq->hw_time_low = rxq->time_high;
> +			}
> +			rxq->hw_time_update = rte_get_timer_cycles() /
> +						     (rte_get_timer_hz() / 1000);

Is this line in the correct place? Should it not be the block where the
hw_register_set = 0 assignment is?

Is it documented in the code comments somewhere how this scheme for
updating timestamps and converting 32bit to 64bit values works?

>  			*RTE_MBUF_DYNFIELD(rxm,
>  					   idpf_timestamp_dynfield_offset,
>  					   rte_mbuf_timestamp_t *) = ts_ns;
>  			first_seg->ol_flags |= idpf_timestamp_dynflag;
> +			first_seg->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
>  		}
>  
>  		first_seg->ol_flags |= pkt_flags;
> @@ -1474,6 +1515,9 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
>  							ctx_txd);
>  
> +			if ((ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) != 0)
> +				idpf_tx_set_tstamp_desc(ctx_txd, txq->latch_idx);
> +
>  			txe->last_id = tx_last;
>  			tx_id = txe->next_id;
>  			txe = txn;
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 3bc3323af4..6098d336a4 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -13,6 +13,12 @@
>  #include "../common/tx.h"
>  #include "../common/rx.h"
>  
> +#define FIELD_PREP(_mask, _val) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x = (_mask); \
> +		((typeof(_x))(_val) << rte_bsf32(_x)) & (_x); \
> +	}))
> +
>  #define IDPF_RX_MAX_BURST		32
>  
>  #define IDPF_RX_OFFLOAD_IPV4_CKSUM		RTE_BIT64(1)
> @@ -155,7 +161,11 @@ struct idpf_rx_queue {
>  	struct idpf_rx_queue *bufq2;
>  
>  	uint64_t offloads;
> +	uint64_t hw_time_update; /* Last time HW timestamp was updated */
>  	uint32_t hw_register_set;
> +	uint32_t time_high; /* high 32 bits of hardware timestamp register */
> +	uint32_t hw_time_high; /* high 32 bits of timestamp */
> +	uint32_t hw_time_low; /* low 32 bits of timestamp */
>  };
>  
>  /* Offload features */
> diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
> index 5d786fbba6..5e57a45775 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -14,6 +14,7 @@
>  #include "idpf_ethdev.h"
>  #include "idpf_rxtx.h"
>  #include "../common/tx.h"
> +#include "idpf_ptp.h"
>  
>  #define IDPF_TX_SINGLE_Q	"tx_single"
>  #define IDPF_RX_SINGLE_Q	"rx_single"
> @@ -841,6 +842,267 @@ idpf_dev_close(struct rte_eth_dev *dev)
>  	return 0;
>  }
>  
> +static int
> +idpf_timesync_enable(struct rte_eth_dev *dev)
> +{
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	struct idpf_adapter *adapter = vport->adapter;
> +	struct timespec sys_ts;
> +	uint64_t ns;
> +	int ret, q_id;
> +	if (dev->data->dev_started && !(dev->data->dev_conf.rxmode.offloads &
> +		RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
> +		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
> +		return -1;
> +	}
> +
> +	adapter->ptp = rte_zmalloc(NULL, sizeof(struct idpf_ptp), 0);
> +	if (adapter->ptp == NULL) {
> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for PTP");
> +		return -ENOMEM;
> +	}
> +
> +	ret = idpf_ptp_get_caps(adapter);
> +	if (ret) {
> +		PMD_DRV_LOG(ERR, "Failed to get PTP capabilities, err=%d", ret);
> +		goto fail_ptp;
> +	}
> +
> +	/* Write the default increment time value if the clock adjustments are enabled. */
> +	if (adapter->ptp->adj_dev_clk_time_access != IDPF_PTP_NONE) {
> +		ret = idpf_ptp_adj_dev_clk_fine(adapter, adapter->ptp->base_incval);
> +		if (ret) {
> +			PMD_DRV_LOG(ERR, "PTP set incval failed, err=%d", ret);
> +			goto fail_ptp;
> +		}
> +	}
> +
> +	/* Do not initialize the PTP if the device clock time cannot be read. */
> +	if (adapter->ptp->get_dev_clk_time_access == IDPF_PTP_NONE) {
> +		PMD_DRV_LOG(ERR, "Getting device clock time is not supported");
> +		ret = -EIO;
> +		goto fail_ptp;
> +	}
> +
> +	/* Set the device clock time to system time. */
> +	if (adapter->ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
> +		clock_gettime(CLOCK_REALTIME, &sys_ts);
> +		ns = rte_timespec_to_ns(&sys_ts);
> +		ret = idpf_ptp_set_dev_clk_time(adapter, ns);
> +		if (ret) {
> +			PMD_DRV_LOG(ERR, "PTP set clock time failed, err=%d", ret);
> +			goto fail_ptp;
> +		}
> +	}
> +
> +	ret = idpf_ptp_get_vport_tstamps_caps(vport);
> +	if (ret) {
> +		PMD_DRV_LOG(ERR, "Failed to get vport timestamp capabilities, err=%d", ret);
> +		goto fail_ptp;
> +	}
> +
> +	for (q_id = 0; q_id < dev->data->nb_tx_queues; q_id++) {
> +		struct ci_tx_queue *txq = dev->data->tx_queues[q_id];
> +		txq->latch_idx = vport->tx_tstamp_caps->tx_tstamp[q_id].idx;
> +	}
> +
> +	adapter->ptp->cmd.shtime_enable_mask = PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
> +	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
> +
> +	return 0;
> +
> +fail_ptp:
> +	rte_free(adapter->ptp);
> +	adapter->ptp = NULL;
> +	return ret;
> +}
> +
> +static int
> +idpf_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
> +						struct timespec *timestamp,
> +						uint32_t flags)
> +{
> +	struct idpf_rx_queue *rxq;
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	struct idpf_adapter *adapter = vport->adapter;
> +	uint64_t ts_ns;
> +
> +	rxq = dev->data->rx_queues[flags];
> +
> +	ts_ns = idpf_tstamp_convert_32b_64b(adapter, 1, true, rxq->time_high);
> +	*timestamp = rte_ns_to_timespec(ts_ns);
> +
> +	return 0;
> +}
> +
> +static int
> +idpf_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
> +						struct timespec *timestamp)
> +{
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	uint16_t latch_idx;
> +	uint64_t ts_ns, tstamp;
> +	int ret;
> +
> +	ret = idpf_ptp_get_tx_tstamp(vport);
> +	if (ret) {
> +		PMD_DRV_LOG(ERR, "Failed to get TX timestamp");
> +		return ret;
> +	}
> +
> +	latch_idx = vport->tx_tstamp_caps->latched_idx;
> +	tstamp = vport->tx_tstamp_caps->tx_tstamp[latch_idx].tstamp;
> +	ts_ns = idpf_tstamp_convert_32b_64b(vport->adapter, 0, false, tstamp);
> +
> +	/* Convert to timespec */
> +	*timestamp = rte_ns_to_timespec(ts_ns);
> +
> +	vport->tx_tstamp_caps->latched_idx = -1;
> +
> +	return 0;
> +}
> +
> +static int
> +idpf_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
> +{
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	struct idpf_adapter *adapter = vport->adapter;
> +	struct idpf_ptp *ptp = adapter->ptp;
> +	uint64_t time, ns;
> +	int ret;
> +
> +	if (ptp->adj_dev_clk_time_access != IDPF_PTP_MAILBOX) {
> +		PMD_DRV_LOG(ERR, "Adjusting device clock time is not supported");
> +		return -ENOTSUP;
> +	}
> +
> +	if (delta > INT32_MAX || delta < INT32_MIN) {
> +		ret = idpf_ptp_read_src_clk_reg(adapter, &time);
> +		if (ret) {
> +			PMD_DRV_LOG(ERR, "PTP read clock time failed, err %d", ret);
> +			return ret;
> +		}
> +
> +		ns = time + delta;
> +
> +		ret = idpf_ptp_set_dev_clk_time(adapter, ns);
> +		if (ret)
> +			PMD_DRV_LOG(ERR, "PTP set clock time failed, err %d", ret);
> +
> +		return ret;
> +	}
> +
> +	ret = idpf_ptp_adj_dev_clk_time(adapter, delta);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "PTP adjusting clock failed, err %d", ret);
> +
> +	return ret;
> +}
> +
> +static int
> +idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
> +{
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	struct idpf_adapter *adapter = vport->adapter;
> +	struct idpf_ptp *ptp = adapter->ptp;
> +	int64_t incval, diff = 0;
> +	bool negative = false;
> +	uint64_t div, rem;
> +	uint64_t divisor = 1000000ULL << 16;
> +	int shift;
> +	int ret;
> +
> +	incval = ptp->base_incval;
> +
> +	if (ppm < 0) {
> +		negative = true;
> +		ppm = -ppm;
> +	}
> +
> +	/* can incval * ppm overflow ? */
> +	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
> +		rem = ppm % divisor;
> +		div = ppm / divisor;
> +		diff = div * incval;
> +		ppm = rem;
> +
> +		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
> +		if (shift > 0) {
> +			/* drop precision */
> +			ppm >>= shift;
> +			divisor >>= shift;
> +		}
> +	}
> +
> +	if (divisor)
> +		diff = diff + incval * ppm / divisor;
> +
> +	if (negative)
> +		incval -= diff;
> +	else
> +		incval += diff;
> +
> +	ret = idpf_ptp_adj_dev_clk_fine(adapter, incval);
> +	if (ret) {
> +		PMD_DRV_LOG(ERR, "PTP failed to set incval, err %d", ret);
> +		return ret;
> +	}
> +	return ret;
> +}
> +
> +static int
> +idpf_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
> +{
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	struct idpf_adapter *adapter = vport->adapter;
> +	uint64_t ns;
> +	int ret;
> +
> +	ns = rte_timespec_to_ns(ts);
> +	ret = idpf_ptp_set_dev_clk_time(adapter, ns);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "PTP write time failed, err %d", ret);
> +
> +	return ret;
> +}
> +
> +static int
> +idpf_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
> +{
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	struct idpf_adapter *adapter = vport->adapter;
> +	uint64_t time;
> +	int ret;
> +
> +	ret = idpf_ptp_read_src_clk_reg(adapter, &time);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "PTP read time failed, err %d", ret);
> +	else
> +		*ts = rte_ns_to_timespec(time);
> +
> +	return ret;
> +}
> +
> +static int
> +idpf_timesync_disable(struct rte_eth_dev *dev)
> +{
> +	struct idpf_vport *vport = dev->data->dev_private;
> +	struct idpf_adapter *adapter = vport->adapter;
> +
> +	if (vport->tx_tstamp_caps) {
> +		rte_free(vport->tx_tstamp_caps);
> +		vport->tx_tstamp_caps = NULL;
> +	}
> +
> +	if (adapter->ptp) {
> +		rte_free(adapter->ptp);
> +		adapter->ptp = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static const struct eth_dev_ops idpf_eth_dev_ops = {
>  	.dev_configure			= idpf_dev_configure,
>  	.dev_close			= idpf_dev_close,
> @@ -867,6 +1129,14 @@ static const struct eth_dev_ops idpf_eth_dev_ops = {
>  	.xstats_get			= idpf_dev_xstats_get,
>  	.xstats_get_names		= idpf_dev_xstats_get_names,
>  	.xstats_reset			= idpf_dev_xstats_reset,
> +	.timesync_enable              = idpf_timesync_enable,
> +	.timesync_read_rx_timestamp   = idpf_timesync_read_rx_timestamp,
> +	.timesync_read_tx_timestamp   = idpf_timesync_read_tx_timestamp,
> +	.timesync_adjust_time         = idpf_timesync_adjust_time,
> +	.timesync_adjust_freq         = idpf_timesync_adjust_freq,
> +	.timesync_read_time           = idpf_timesync_read_time,
> +	.timesync_write_time          = idpf_timesync_write_time,
> +	.timesync_disable             = idpf_timesync_disable,
>  };
>  
>  static int
> -- 
> 2.47.1
> 

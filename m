Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F74606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VTgcgi2E;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Z7OfB/ts
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEE7E402E3;
	Fri, 20 Nov 2026 11:37:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id F01FB40151;
 Fri, 20 Nov 2026 11:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795171039; x=1826707039;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wJEGizA/z1+8cOY6VhijpzbcY+vV5/Tvn332w5rfOdk=;
 b=VTgcgi2Ex0bLZ8RsqfXRqwpVTrbeijiVmVTvTsSEXur9i6BZF6dgrUt8
 0uwcoschqAjaoU75s3IYc03uWKJetJ4XM8WbH+9zW8BvxgFR9wg0dp3h4
 1ZCgAA7REOZSMDmS4utUvkoFS69GnqN+URLyC3pWBRmjbaNcWRz05PV68
 VrnkXuGi5DAUFqbGySncIpwb0P4lGX8AdaQKLsld69r3uuf2V7j/wCJ0R
 kLuDldG5WhZLK2IMuyA0YjPemMk14ShMgjN25qgf5rXDnnQwlI2Zc5lWA
 a6aThzPBbxMwRwkSvCXqVbD+/ypLxaKNWztLXWYqY8qE6FEqZ/+nOcTm8 w==;
X-CSE-ConnectionGUID: MtZ/Mjz8RIGQD00vVH1tNQ==
X-CSE-MsgGUID: cZSKC1B1S5WArxTvCZcTGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4062950"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4062950"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:37:17 -0800
X-CSE-ConnectionGUID: ficPByHXQFCU/+MeH8tw4Q==
X-CSE-MsgGUID: jKjnIXjuTQu+lssJzqT07A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10744364"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:37:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 02:37:17 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 02:37:17 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.30)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 02:37:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZelnNGz/mfzljbivCBB32gJ5aboh2/evPjyYdJaoRR1xRGLxeGO2aIBI65GBNZBOjG2SqcLU5wFMLQCQqaayo+//s0Ivy0xVkmGU2uoVUiPKn54X5G3opvrVpNwSyAPF+IaoeQBEdlptOQyehMqv1z22AqVFCaloAl2OlMV/L/9YsGXwIoAFBL5B+hgU9gal1FXrUTdBbLMBW2Vd7xtaraisDOhf+7J9rb5hIewMDNvDFeMU7w7e7sDkbximRTrJy2edc6nW/2mlUiB6lNx9o4UBnlb/PoaV5zYQvX1rhOFoQwU0fGBV1xZ3/PJgJmaUx0nCstAgIUVIlZ6Fq4w66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPtb/PU3EaOKzo4xrrt+bw/Wk4pa0GUDqHLspcGzX1k=;
 b=Qruc9J5d3WqdMyc/Q01lMCdJTQKj/ySKOmwm5rwmZk3k2gziHP3JmQHlb8L2geTq4IA/+sCVulwSb2B+e5i93262qcuUt8wc1M/dorziq4O5CblSHidoy0WEuxXRO9dMamIJWZ6llfodtxKcLtbmu0bnk12uD6OQe/J5kow2uN4kzCN1I3FAPANu9lNtqls9G+rbxgwSB1GZAWr3TYTIk0XbFPgmn25SX89xDLrxyI8fqwiah0XjCObxPQx0ib4YXYHKOpDjFXFWyM17lIo50hz84euXc/PDjqSORMBP4deB7HbnXQLJsjgsYdxnDkvqyJGbK3tO6InHD2hf+xZvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPtb/PU3EaOKzo4xrrt+bw/Wk4pa0GUDqHLspcGzX1k=;
 b=Z7OfB/tslRbO6FJHxCLWzri0X2eDpEKptLXi+chEnpVYX8FjYmNcB4YK6G7+4bjkV5UqBUeR5F7ttxoGnyqcX81++qb7S9m+y2HZ3G5bbfzIrxdsKRaX7uoq4cBZl2ZMO/nxV8RC/CFiZhvG+4F84Sr3o7DV9XV/Z0lHbe3+EJY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 10:37:08 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 10:37:08 +0000
Date: Fri, 20 Nov 2026 10:37:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix DCF probe failure when ACL is unavailable
Message-ID: <awAizt_EPRnb93ER@bricha3-mobl1.ger.corp.intel.com>
References: <20261110151539.125810-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110151539.125810-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 669956ab-2fc1-4e52-0844-08df46f239a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|261009223027099003|10067099003|261021121427099003|261102123227099003|261102124527099003|261022105027099003|56012099006|261028144727099003|261022075727099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ul6yIeXSzCgNzXpehxOsS5m/ZlJI0pZQzajhveIN6sZPOHd4XqiDDuzadN4lXvr/tgEasrN9gRQZK28VKM1aSvKKlbnJQDRFmZE2PMxOzr0/pOElIh98LdMM84QqRNjIbB3PJdy3Hiia8SV3loAe7wC2jFa2difbYNOttDSytSbaztinTQeo84m9x2XquKwk6cyUxb/zyhYPHd9EllnXmW1fn8BiyXFtGeToBcZ2M0vyxzQtOLlmK+NcA3yBiOw6wzueb9iAmj5dlMgfc1nY5pvTOHw6QP80QIfll3ElgKDbgQx86hCZC+lnHQg/Y2uhrBdSgj2UhQEDhxeinlrLi6kC5/I+cHBHUleFzxVXLbnTp4wxwibohrr3tJRFPqe6OHc2Lmjh6YBKmGyEgLRXXQBsxHfLY92U+nMFz4SGZdw/LMoKSO5LtUq2rbUdEN88VChtnFSLZAkWam6Dkh9GS4cH93z5NcGtVLhNi6+P7nLSJO5w9vBB78IHvj5cYURXvjLlJMFtQ+wATYXVUcGZBrvS2tfZngcHtMpiRMr1oVN6NjmENe72OKuE206NtbptdD139/wVYyH98XTtf6hLIhRHoWOS30r7W/9azlunivr+vg8ucgvfNjLrqLM8fx3dRSimU4IfWKRC7PnHRCWC/8aJZ4X5+xNhjrYLyiabq+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(261009223027099003)(10067099003)(261021121427099003)(261102123227099003)(261102124527099003)(261022105027099003)(56012099006)(261028144727099003)(261022075727099003)(261026140227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6FogbjdvF4fnya79Fdulunghp7rZFPgJZbWMmrMQpBHl8r+shQ2R8BywyjP?=
 =?us-ascii?Q?N3IZzntnKPve2epjBusbMf+944vZJz8dwnV5nwIn3vMihTLQwtHjocwuW0P7?=
 =?us-ascii?Q?onQ0grPTZLHmMZ0AcaMXbFQj6iDO5/RSb23e9avMXkWTQtp73LezBcgP/ou+?=
 =?us-ascii?Q?pm79MhE4cRxDYSv/Fdda6wQkxfCRLrWYU7yXqUTktZGf9ftSO4lNYhT1NL/l?=
 =?us-ascii?Q?LK2eOVsVfd07ur97ID61LL++tGGHRyDBngCdSILrqpLw7Kf6rDM6PjhJ9QiM?=
 =?us-ascii?Q?/lqQSLE/aDI8NTQtZXMCEah/qxT5C5JKaKKnWyUcTuU/wVbFkNB5vdFPAiWY?=
 =?us-ascii?Q?SN1bJ2O/ZF9/CBbkUMAus61lPwOFOyJrCRMwHNSli0CcfS843ootEMnLOeMy?=
 =?us-ascii?Q?fRJQ+oexhVU3ajmpmA7E92lBcIBC9oe6TLJX2qBlic5aWiQtOQCeX0qU87w1?=
 =?us-ascii?Q?Xi7rxYqFRqHi9T74ouz3zBG2ooMhnxgNpjRkl4ihxJ7K8w07IxDKpyxkKiKl?=
 =?us-ascii?Q?nbq9W0XzrPpoeMmJ3bLVHU0PA0DKi8lCTDeF0atBgHfc7AfW8UYYt45fsiwD?=
 =?us-ascii?Q?T2J10djwPgEOIDrY1m924b4B5C301OMs+Xwix2dbkOIHAHAPhvE3LeIaElmN?=
 =?us-ascii?Q?2nK34Y5dX9TKblD8bnV9OfaZLhUp44y7qqmaWgwpSCQmRDE5et1wQycKyM0G?=
 =?us-ascii?Q?zT9P7thq6Y54SMdcpfv48n4WQkNddHBQ16gYppCOQCyJYgeY/MwlWBu00vbD?=
 =?us-ascii?Q?mTbCtxnsIRU9VKKNkXLN5Htzng4r+q98u1mE3mOQeW3FoScZqdzrKSqsYYNM?=
 =?us-ascii?Q?tdbVPQ1ESwgujhqFd1TmEr7jmUgz31b/nmQT7mDK6va2OFdz5zfTdzM2RX4v?=
 =?us-ascii?Q?GUQWFYnCO77SjpdEs0gODhBg3g6qxUfU1j100vcdZbwSl14SIXXgFVZfkZyN?=
 =?us-ascii?Q?U/f7iFg+iXA7ZrjIoxQC9Q6Hl1ggbWC95CGRESIfBBHWlZCbS6wsSzdRpTUv?=
 =?us-ascii?Q?xJ7cNv9vyRVL/FnIKhMgrgE2m9i59f7gyn8dXNbX7ATtqEfV+lNLX+Z8qrbs?=
 =?us-ascii?Q?2iyKJ/hQj1s46KaHPPKTt/rn1Yqt+6/P5iGd9zRyM8Ff2Q17Lyxy0S/U8j6U?=
 =?us-ascii?Q?3oBxi6pBDoit/8VJcVF1IjvopDRjs1HwSlx8jcqDoWr4Dcc/YmZFLxRhEKtE?=
 =?us-ascii?Q?HWBiPHb1WaU6EzWWLqLyJ/A7i759C8WyC2AvhSLY+DJ7zrI3gSFLN8kVpj0F?=
 =?us-ascii?Q?lyupkLhn1pzskMTHHbP1a46DutAqlc6PnK1jAJlm6JTrO6HDoM3OTfUydZs+?=
 =?us-ascii?Q?oyMPpC9n4YsrPuG1e84fbGr4Djwstg9psonhc5YH48BW2tJtJJQl1an+Hjke?=
 =?us-ascii?Q?c+jJMIv3cdcD28EAOPnwi776+HsAdYQQ/znEGu0VIjXgyNoUK9TTdNA0r5kM?=
 =?us-ascii?Q?8MkQkTHsplMCvqoafxtDX+3v9d9v6Gr7PBn5lMvLHj6TERsL3kaFnSMTsDua?=
 =?us-ascii?Q?a/LTKmQdjAVAvBGpbFtu+L2mGobcxQIDsOAtBvkugB5+7MBZ3DZdjnXT8j83?=
 =?us-ascii?Q?Hoyuvd9j5EUJZ1NzUVJ9nDAY661YqchQe3kNnJh/7pHSbMxmpfsepu4306cr?=
 =?us-ascii?Q?g5jm00g2XGbse93c6p2YMi9KVuX6ML7rudcV1RkDvCjRhS5l6fJhSVg+Xmhf?=
 =?us-ascii?Q?2BLRAgz3LcMSe7qC9f+i/TLyS092waWu9TrSIBCUXwmL7dqJ7UkYY4nXOzzN?=
 =?us-ascii?Q?r0/g+2SIyMje4BfnkQVtmOmp0yKIBr8=3D?=
X-Exchange-RoutingPolicyChecked: c1a7vVFiuwPwcqpPfdHppvQW8Fpy9hmTnqjj46c+kSuKVqx9cX6o0vkJxoWMmWRYBGzWx7PD34SxLKE/Hyou264gBp6NG9uQoFZnvey/eapaJC+KqepdgdgdpkAXg2vQL4wiiwuLJBLALoIz3DpqH8BtFEhv/rqbPTwUtEbUgEyyJmyvGnVRMn1NPGDbfcLcifmyf7oPNm9ussEm0a9Dn3KMea090dTs4kDqheBu/E9tu2+Pnpm8Uf+oyRHkNHYryjtUC3Kmzi+EFdWDBf7+1rSIAsePCZsFo4jMuao76TEIXflPzATOFHu/kVG0UKtJMvv4z/tXDTagElprWQCquw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 669956ab-2fc1-4e52-0844-08df46f239a9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:37:07.6861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxzpUBI6rgmPJFMMsgOR3G0iN0tvNNittIxYH2+zOaAu/nPD2OL5wuWz0Pce9WtW+hdjLm+7Nn/qdVCSLtuhEFc8awgTPlStPpSOoHjrehg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
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

On Tue, Nov 10, 2026 at 03:15:39PM +0000, Ciara Loftus wrote:
> Currently, the DCF requests the ACL flow engine unconditionally and
> fails the whole probe if its initialisation fails. The PF driver can
> legitimately refuse the ACL capability to a DCF and in that case it
> silently drops every ACL AdminQ command instead of returning an error.
> The DCF then times out on the ACL table allocation and probe fails,
> even though the switch and RSS engines would have worked.
> 
> Fix it by treating an ACL engine initialisation failure as non-fatal
> when running as DCF. Log a warning, mark the engine disabled and continue
> initialising the remaining engines.
> 
> Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf_parent.c   | 2 ++
>  drivers/net/intel/ice/ice_generic_flow.c | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

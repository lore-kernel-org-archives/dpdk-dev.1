Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC4606D80A
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TwNGxtvb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AEBD402D1;
	Fri,  6 Nov 2026 12:43:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C0BE402B8;
 Fri,  6 Nov 2026 12:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793965388; x=1825501388;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rAYknUE/cuFpkpQPJ4KCHfnBP7UQxmdKK4A2/DHz4/M=;
 b=TwNGxtvbFL8UfFr0cLOqrYUwWL8DK8U9AGdGkGvpF8+QDz/Ua8y9dBAu
 fuzkUntj+tH+q8CrvmcUe1uoiLSjxk1dzR7gbwfSZcZB73sHqCTWPPr3T
 0LzEJgvMv5W67oXWwc6mOkm2opdxv4PTz9tSyJhENA4uFQuWCqmeJw+Xs
 XwcjG4fXmmg2g77v1d4J5LTYyciG5JCDVq6fr8DGbSFV8OPpTlSd8G9XQ
 jFb8LeOklEjuk82KlMWLSdy0A6rfKeBr/m93mrIVwyZGTnpbKFS3XLoPR
 0me/VOOTpAasCq5le10MSzFXt/Yh/KEG4UXIIATl8s6VX6GrsKZSqhymo w==;
X-CSE-ConnectionGUID: d6WBnQHdTfOpLyobyuBMxw==
X-CSE-MsgGUID: kzoMuyeIQJOr5m242SkyIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2807851"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2807851"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:43:06 -0800
X-CSE-ConnectionGUID: 3OWLf6POR9KVBi8vBpq7UA==
X-CSE-MsgGUID: YeMzHMXzQlGf9JuJxUtHjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7377375"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:43:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 03:43:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 03:43:05 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 03:43:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjMcl5C8bnqGhIAOfWs1zd6h3Rv5BQheq50fmkKLf5Hwx6cxAYmtF2XAMO160ledJd+q9+vxoFt+cU8TsmuD71mqBnXNd492qrK1S3ufng2M9D+zPRtsiYPRl/ElfPcmfFeUPwdpGuB4HtQtGSHHZXsjNOsIlm8ZD7FedztIDMpPd/Xjuqi2fUCLlwJJ468zbOsNT2vNdMq10KN6VG3RwJGF+gVTdu2JDCk4ODQ4eEjyHLPJQ7CgMKfgp4sGhwP8nBNvc6jIp9Varcm+aBMSN9xtou0Tot61Miizix5//mclvCLAZiibAIexYV0KrmBEblNsXV454YkZ515umlfhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpgwxN7JLfPggF46BrOVKt1lkXwNloMlCj8LuSPHGqs=;
 b=U26g+NGvnGXE07wYP8LdqF0kCma4z+MqWAKK10ZLGZmaLW3C99xIkJt44pByhAG8YXAYjXz7LAXVQxIk5sprk1qaFKUJrQQEviLmJXW6GIR9lk7Ftr/ebDX4xK1U7o5joI6KC1D9MNM9ZWJNaNusdsJHN/YsLBLSfDsA8cAy+GofAJUoERLAj7Yv8JOkX3c2UgPcCaY0eMZRgKsuLirppZcIRzTAOhDXT+oycqFZ8dzJGlcCCT0DyGpIvJhcAD9gMO/SFMDMYnHgwn+c9tqyS6j83JBdRnohM7btkBF672BuEkN6XrKXrEMTiotLN+mr8QaeMyvS9L+xiVOQjz5K9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB864032.namprd11.prod.outlook.com (2603:10b6:408:3a9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:43:02 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:43:02 +0000
Date: Fri, 6 Nov 2026 11:42:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 1/8] net/ice: fix DCF hardware init error path
Message-ID: <au29QZplzBw-OSzF@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <a248ef94491e9ae863ece11f316d400989c8880c.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a248ef94491e9ae863ece11f316d400989c8880c.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DB9PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB864032:EE_
X-MS-Office365-Filtering-Correlation-Id: 8470952c-6a25-479e-ded5-08df3bfb1d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261021121427099003|261022113327099003|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: oriFUqaUJEv4Lb0YuguCBMmAkrc3hHQGmZ0qgmT2NdbpvvfTpqJwzppEqtyOU4uV/dg+tUoz7lFNSHzE5WBcY8hrrOvO0xN/iC4ZtGa1bh0/s3eGGU+QfI7mqZ3R9Alv9YviK0EBUYwwmfBNp1P0kn6C8S0ihgszqlo0ibX/LZSzOhBFVJy+rOyp3W+CtcemggaQI3tqDRpfl4qRhX0dNCoZUKb6a6xY7XN2RpqIdD0VNr4HXkYuQvx1TSAtiGbxIit69P5KpMxBETSTjp7uqz8lLN1J7XfIztB9tarUOAjFP5t33ek+Jj+m8efzYvlccr76rrlAnTw18gB4odmh8MVIQUkB2w6J2p/xXNYPV4mRB0aEn9NM6mCgtxnrtX03u9kAvzqvFbzBq20/I9n+EgrRkfa2JNinAfsA2u+QpgI9rZfjbXbQN4YuUnv4AZTNeMHfgr47N9pxPD6MOaYqJoLMPFNMlAlHuun1EPca6/UFlQkuRqoOAP6oT1eQ4zrOqlxoUesjG3dLlmDy6GTMk/6N38IqCUSz/M5rLU+mkudcoIEIJCLo5mHLtzXbualJYwyAxEf4i8GqECgPFZwMqCgoRe1kEBpsA4m+0rlZh0JSmg7dgRrjHOcXgEB8wDLWkJe55F+45COAK4VylAT+w7z8g+94T6qZI5W1X5oi1TE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8uk61vS6on1alWhmsBdGBhlx+rsPWu6yuC9zXWJWUZ0BpQaAHRwYSqRUCuT?=
 =?us-ascii?Q?cHL0rnFqQ1KBT+3AKgmp1zlm983PDnbmYM0kQrJfrpWjpUXSQXn5Sh9jpHQ5?=
 =?us-ascii?Q?gnqg4as8Ug1mQ6HEmR6d+5IWNs0O/uYiIOoPSYTmq+b8MPotEWWve92/qXf/?=
 =?us-ascii?Q?fkSNDXXvjm7FgDcEvLK8XfHIjFRGXm6KY0lbiMOBA6GrgG2rko2SbDpQlCl1?=
 =?us-ascii?Q?wN8c7nXEgr3IbsQuCmOd7eQIpAOYbnsRByyDjGjCsX0qHU0uLPyqRCGt6mxX?=
 =?us-ascii?Q?txF0LN1AI/LvBNoyt9FI6TP+hQGMSiRMMiy/QTrS4iE1syWj2oPMCAmSJFM/?=
 =?us-ascii?Q?t5BMnBS7ffDjaAS3C4iDb1EnpgHJigOaj586JlK4a2bGHgxhzkn7uB0w9HhN?=
 =?us-ascii?Q?tRGY9CuQq7dOhDugIXW2F58N8VgczdcSlA5UWtzD0vGN6pV0RJfwcFzYQ0xJ?=
 =?us-ascii?Q?NVDubHABWdADvnmMEoGjoc8vAFw85PTgJDC3+1UzhruUHv4nyX9xIFHVm7+B?=
 =?us-ascii?Q?K6zESYoXn1+R+b9/0rVqIkMN4VdkIeHaL/pgnKzWfjjIESQ1G6NEWeR78H7Q?=
 =?us-ascii?Q?XA/MQXGP17nXrXjIDVzwqIbDol6QVaDziYy1t6+GwV2FpSs6icW1MV+Xs9PU?=
 =?us-ascii?Q?DRqvrdMt54kN1lmbZisJ2YrhvL69bHvpHCgyXZtGRR2e3WVm3pbGPLcKN4kf?=
 =?us-ascii?Q?Cb3TnsiXFLGrcYtp76XMdkJ9tmJNRLWS42YS1U4Hn427PvFfQM6mBNLML0dL?=
 =?us-ascii?Q?cLUgEjr7LFQo9Mwwmx+MPQ78w3J9BgRHrHIX6CQm7DrfLkJMJ6DmL05OHE7z?=
 =?us-ascii?Q?iYq8SO3Igj/IcGs+9D+d3lbsWCQCn4UFmcyjSa6hjgUbR8X5a4AfmXrwKVhA?=
 =?us-ascii?Q?svxINu1dk4lC+IhSTyJm6BeyxoMcmeImC2DVzq3b1anPfubpLaixOrms05Jw?=
 =?us-ascii?Q?RoPyWIkTZdc8WXhGG7DOHuDDgOPrYkvS8beuN+r2ygzl6/3NZT+26ZDiXZ4T?=
 =?us-ascii?Q?/nBENLCygvoDGt+urXkaI9run39xycSiAlOjyCy4d2WiasVsckk0MIj2h4Jb?=
 =?us-ascii?Q?zqWPbYj0q8j+0QO0YfJTz1FcpjX5wijKjiXwgPbFGIyfSP7T9xipr+9+hqpV?=
 =?us-ascii?Q?090hd8dNAfwclBQ6Mut8+cIUfwQEayCzzMDLpjgmxng+28B98czOYlOTdxcu?=
 =?us-ascii?Q?d3sSGbUhB3yOhy944qHqTEqCD6FFYrqu6WIvGdoKJaIyZeoLXxScFRCG3S1+?=
 =?us-ascii?Q?lNhRbP9+tPxTd5zohuZPrWla7RnqjMlA6N/IKnfmQbsPufxycvwkWouKRqyp?=
 =?us-ascii?Q?1CmQ7o8aiSCS0NAAn5mrc2KDJoIAHPQoT7dpqNzEPrMkPfPW/03+pmjg7jUw?=
 =?us-ascii?Q?EWMLhAHed5++OG6Kzg8TPMiliAZ7ka3c+WAdwILCL6bb3+vPo2FD0+DyXSYU?=
 =?us-ascii?Q?FYJ0O+EbHJTJyb3eV2l3wzA5L+sFjcwmqO15favxoz32Mla5RqXRAt8xZRr0?=
 =?us-ascii?Q?UbwTbyj8gHLetSTrl+UW9tnoU/T1puTVgOWiQvKoWq648uvIsZJgeWZV+RSg?=
 =?us-ascii?Q?3QCf6E1qOXd6LS7d1tK3RjdKp8sxTncOJP6bm+Gt8NXFol5ePMnnPNT3M+Jx?=
 =?us-ascii?Q?kk9/UPBn3Xhdeq9TDoqbiTqCzm/LJ0QTm2pnko3botE38t9J7ipyxO8FE8TT?=
 =?us-ascii?Q?3HXF7ta7n4u9++3dSIaFxHjCp7u2EBiaVNVcHdY3s5ga7V2MwSmpAl4Hh8VA?=
 =?us-ascii?Q?wn8ntWZap20qLmiJXksBI6TNga7/Ek0=3D?=
X-Exchange-RoutingPolicyChecked: kvNI8MfvlTnRi3ePBI5dGj7XwX3xXXbOOgc9HAUYLOiqBycXkvfq+KWrwL7cNTjMHiPopqfdM0rnh6exsd4gyuVLJJ0i1sJYbBbzXdf7xMYtft1gP5n/Vr0tZG536aoEfwjMj3Xt+DRDdqL9HKQfCnKjBcRSvMANf1ji1htE939p2l7cJiY5Yox8U0rs7g/wgpYT6Pp7O13isBf/cTYXDtu1P7faGZ4mUH3p6PBLFfztCDtf+4XDyBNIZtTukrufhzNNPwIbSdHF5HF4bPknewjljmuMqRdy6pRTSOec9HkQsvXmtDcYJpTLEKYeoxb0i3x/o6smww17+P9O4CKuaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8470952c-6a25-479e-ded5-08df3bfb1d1c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:43:02.3527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp9Zro/MdexN6MlWJz+6iDyWrkEugPJ5DhIYkSB64dSgDEZDiUKN2Qwm64241DVQfGdTA2zYOJvUcHOtawFi1HahPAaeYeV6XZdS+tNM8nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB864032
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

On Thu, Nov 05, 2026 at 09:47:18AM +0000, Anurag Mandal wrote:
> ice_dcf_init_hw() never frees the VF VSI map on its error paths,
> so it leaks when any step after getting the map fails.
> 
> Similarly, when getting the VLAN offload V2 capabilities fails,
> the error path leaves the interrupt callback registered and
> enabled, and leaks the QoS bandwidth config array.
> As the DCF hardware structure passed to the callback is freed
> with the port when probe fails, a later interrupt would use
> freed memory.
> 
> Free the VSI map, and add an error label that disables the
> interrupt, unregisters the callback and frees the QoS array.
> 
> Fixes: 9a7980cfdf67 ("net/ice: complete VLAN offload capability for DCF")
> Fixes: 8e1cf1823191 ("net/ice: init RSS and supported RXDID in DCF")
> Fixes: 7564d5509611 ("net/ice: add DCF hardware initialization")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One comment inline below. [I can fix on apply if no other issues with the
set]

> diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
> index 976f2ed260..d87655c11d 100644
> --- a/drivers/net/intel/ice/ice_dcf.c
> +++ b/drivers/net/intel/ice/ice_dcf.c
> @@ -853,14 +853,23 @@ ice_dcf_init_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
>  
>  	if ((hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2) &&
>  	    dcf_get_vlan_offload_caps_v2(hw))
> -		goto err_rss;
> +		goto err_intr;
>  
>  	return 0;
>  
> +err_intr:
> +	ice_dcf_disable_irq0(hw);
> +	rte_intr_disable(pci_dev->intr_handle);
> +	rte_intr_callback_unregister(pci_dev->intr_handle,
> +				     ice_dcf_dev_interrupt_handler, hw);

AI review points out that this would be better using unregister_sync rather
than just unregister.

> +	rte_free(hw->qos_bw_cfg);
> +	hw->qos_bw_cfg = NULL;
>  err_rss:
>  	rte_free(hw->rss_key);
>  	rte_free(hw->rss_lut);
>  err_alloc:
> +	rte_free(hw->vf_vsi_map);
> +	hw->vf_vsi_map = NULL;
>  	rte_free(hw->vf_res);
>  err_api:
>  	iavf_shutdown_adminq(&hw->avf);
> -- 
> 2.25.1
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F05CF4368F
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:57:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BE3B402B0;
	Fri, 17 Apr 2026 12:57:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE93402A7
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776423467; x=1807959467;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GdRRbUVzP/nFSJiSgN5c4d9hxEdPabkBAYCicv+BokA=;
 b=k93lEs4cZC9EjgLvbIqPFutaS5PJBjb/oY8UVgQUjsDqEMOknYcFjR7U
 sraEwemWul4YIQd6WHKsl6rwXNEy3759C0WrpCHv5rzQhWy0KWjQiEf31
 C82L4QvEEJ1oHeMQOkfB5J54idhCeq/9dHZzwJyrNlglKVLFUSrfx3b+d
 OVW92r+yZ85IuKDXm+m8S1osdCD5Bk9Qlsz1g+kY1aTozZI74dIunhWM7
 6fZp7IJG62IOEm3xX1pFcTBoFBAcwwLAU6lKEcxBgXhWVZj38zNvdtPnR
 iC2VrcKWgQz2d1vjn3USVOOK8+WuzWL7/2Twdz+VFajREHPerpS3K6JMn Q==;
X-CSE-ConnectionGUID: fdH8YadqRTagvUikYkxcLA==
X-CSE-MsgGUID: 2dQeL++VQRy6Zv11izC0Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77312658"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77312658"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:57:46 -0700
X-CSE-ConnectionGUID: 5yAUjcM0QrutYv1Ni0ldfQ==
X-CSE-MsgGUID: 74OsCqldTg+ZPvI2dhUdzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="232755677"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:57:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 03:57:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 03:57:45 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 03:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og//tyHMiSonDozqyiVwRt3PpZP+QnJS34izEFiUfhihDnifKI1ViE/rk/gq1mf47ZNcDFwIoGg3ReFOORAUd14iFHMuzZG9iuwIokfamjxahUv0/5TKGl5E85Qw1c7ESu5y5BLerU0Mc9WhoLFovrG55FrmV5eWnQqTW71aPNUQt8kZJOtK1+tcqYeNsjEVNfDJofog3BlA1jgAHLHOZl76DROouNPt6Mo0Nk468rw0BA7k70GbHqur+kwylfpWOBLri4bY0wMhKkq9Wjn4DRORwNcRJfyPudlc2ZjlmxdBnaf1La6zMYvG2dBzXYOW8sHxhZNT9b9DiIA43O/L8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q10X3yIB3XPUGtpTh/A3z5GPUehb10+aBW/RP7Ed25E=;
 b=SweEa1JtDsPrYMS4717DP6TrMcNNTc4+tdLyyQbcIc9fmLkz8CJPQFHuILzeq5wgMoo+gKa8DXT2F27uXyEVEeHFcIdkF8tAHNI9pjs6mQv/DXpyCWuUWN/RKgHPXDSDAPXEbGZ8ilYdnGhWHMopYgrIsr2q2CWx9sabS5lMhiZ1VbWpIdkv3Op4Ei8ETM/wEqy1NMIZ0yv2mMsK8kSJkwIQx2pyyPnyLssZ/X7tixPw06GEIAQIKnrk8NpxB1L0SoiRrNtIJc90tPgx7OsBFnANNAsjlPnfDHlcmywwdbzQ6HECSiJV1/EuqfsrTqcyle/eBIMvoE38UJLmxBtw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8223.namprd11.prod.outlook.com (2603:10b6:208:450::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:57:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:57:38 +0000
Date: Fri, 17 Apr 2026 11:57:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 1/3] net/iavf: support LLDP Tx via mbuf ptype or
 dynfield
Message-ID: <aeISHrR7qdHJSNh0@bricha3-mobl1.ger.corp.intel.com>
References: <20260306115214.467033-1-ciara.loftus@intel.com>
 <20260417100804.1143121-1-ciara.loftus@intel.com>
 <20260417100804.1143121-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260417100804.1143121-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0017.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0f6472-1fe4-43e4-42a4-08de9c7023e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: AA2LCseL6ca/PtQhKxNKo+7CO2PNV+Ta8sjlzsE70sQ4sPjAdRsKIP76os9ml8mmv+AnnkAkYA69aun/nEsbX0ukpJXCbv/To0+2DP/5h20D+R7hJgUaG5ozLaAxMh/Q+trAkfvzsXknSX1cf3L4bHRrSPaXbTOqj6yR1jG1ICpGQJhUeirAI30ddrqDhxvjXvtjdRPL4ffokS4aC6E4zYyM2T5pIZg640hrYWycG7Ya9nhMhwkRi973VktDFUhSNjgZWZRwMgHZprurzIm+R4cPp00N4OD42qpvGNbRTBZfkauRzUBH0b8Da+8sFzQtZzfg5zm/W7WGDJCaT2rzv6Kp2iA/UUC3AaOCRaw3p44mXrIJvB4JJYiqqzXUMou5JgFXPUe20Upy2GUbROccXLWasSjRxe+zzabNX8wopjRwPrEbtU9jG1WwnT0TI6uoFCxNm2A5HX8Teblca04e//qFgtrueyoQl1eqB6xFWjeds2WFemirjPU6bJVqjtDnjOYeEr/8DGDk5QRDRdz71f4WRP1EgUMF3A6w3Fi5ZO7FmcbOgIlS7701hnFKdhE2xQatkGMflXpZ9VsoUKfZ7NjNWIt6aJqlAn6tufhoSlC5NxGlrcCQTJ5Emu3RxRFdyPEUVl1jj1OFcDdLHKBHfl699yEm3LYw+/AgqAAhWi7MPaHfEZ+00WjdXn45sIuFP6rZu+IeGfgkxqkC50r1dyOiQHQgnUgFbkQVfAOOdrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZA/DMt+L+2eh9MJCV2vvctjTyHrIWXuCboain4Pc6kItPghdr6ox7BizldA?=
 =?us-ascii?Q?ATyUhVmeRvftmZIynvZ1na9KVokhgsux1w/wYOk/N9CcOTnRqLVwxt3EYuUd?=
 =?us-ascii?Q?cfhEHjxJzHOZWkJBl4nff6HlShAbtCUVNsEpPPttXEzRoSDlRlqelCkAzAgH?=
 =?us-ascii?Q?fKiRq4jKvxkeqZLNrUwS3QJF12nC2Rp3EoxxITIVKSsMmtGcp/Ill8Cbxq0x?=
 =?us-ascii?Q?D5sAFawEZ7svsoNykZFeXnRjnFvfOwsZ17+y025leWDTgU+hjEborOG55YAf?=
 =?us-ascii?Q?9UHIywUjwfiap9T/zk1U7pGvE0+B+Nh4zC2BCDvKWxcsqnZEEEngh3MUmUEK?=
 =?us-ascii?Q?FXOfp7kr+YUTqYV+r5jH5yIp+E8vph7o1oyq7ozLSCNaX1K1ftAUUynzh0j5?=
 =?us-ascii?Q?d4A/7xk3rJKXAuIO1Kg6lSTQX9+HQp52LugD1eSeQ7BJC7nhm+4+jC2KO7JB?=
 =?us-ascii?Q?70i9o9f9A9h/y/aRn1qsckDV4zXXTYZkxqFMVDF9LyJagNtBuphQU1rYTb6U?=
 =?us-ascii?Q?GRJLvFtK/emTAYPW4L+t56KhoAYPL4PywtK4069b2NTFIE2hg3gv82nci2vZ?=
 =?us-ascii?Q?rZZEJ8ZzOsI+qpKtTMTXzMabVL/lXqUt4bMtqpk/mdg+6H+rHjqADVP9TBl+?=
 =?us-ascii?Q?hz0dNzDQZJCo/ibKx4WXOPbeJd4TeotfRsOUC3efqsagOH62mTshy1/jFiQ4?=
 =?us-ascii?Q?Qlh9u63SH/noBhBQAzfO0d9oVyRUP02ZySLGOBB9iMMsxUlFH47+nVhpHTU1?=
 =?us-ascii?Q?q18A9aRnAssWlXR/FZsrtKsU62Fq+BFi1ihqTIEbUq3HztacBVolAZYf7Sli?=
 =?us-ascii?Q?gTRrJRly8QPtDxarsycE81ntRaTar6LXPWtR/FjFvcpa/s2OXy8r8rxrCdr4?=
 =?us-ascii?Q?D1gSxMblLei9PSyCNRmqJJ33fBWK/dLZdjUyDBNeDM7JbOcYbml2rd8rylHf?=
 =?us-ascii?Q?btyqMPMoj5HE1S7qagEdhxAfEdWK6cKZXt7kT3ZDES9ceP67kW4EJRxNJMqg?=
 =?us-ascii?Q?DjL+RHj+JozXSgNXoze31HACWtUMCc1QBAjQXjjPd+rDuos/0CyF0+zrYQte?=
 =?us-ascii?Q?phNxCFFAVcgXlbWH8APmT8zD0GWJs7eGRVjdn7qkw8CiX6SZyQvO2rrivwt7?=
 =?us-ascii?Q?3iidqfbvVO/wSiw7qdZrigV6gZY+Ka6jB+2ythGxqf2Nr+yGQw1f9BvQuivc?=
 =?us-ascii?Q?lKEBFyhYwb5y8UE35mDIkvxYSxiJGqZBOxe/6vPDmecp7VbqlXWT9gt0p1vH?=
 =?us-ascii?Q?aBdY4Ljt0y5glm6qEwYgBwndAFGAhYgjq9t3KcsxTRdUAAvYC9rqk5+DMmam?=
 =?us-ascii?Q?foOSVcFgSDLYatP21xlbGnioYjsovsJr9IWdEo8T1xJOBdw+FCRdnt3+2QEk?=
 =?us-ascii?Q?dHZb230dg94Bv/hnt3QqzpL2hUZaZF5ulmZIvMvsFAevr6ZltoCLWOZsanfi?=
 =?us-ascii?Q?soAxt3W2zixut98xEfXPI9ekKHZ93WgfSfNNZBj6UDsCbN6AxFJ0K+u7PU0Q?=
 =?us-ascii?Q?TfCKmpwo39qdMVEKnwXNG5Y92p4M/nS7FQIjfePuRjrseF8paKbchLJsXmpV?=
 =?us-ascii?Q?AV07MHCJB+y/3cp2VV+23lkHrFUSCn6357G89ZNjglp8oFE3ZENXyBO2WdWL?=
 =?us-ascii?Q?mPDOtz/yBjAknZ3eE/YYZBdurnUOaF/Cyh/bHR1rWhR/so3PwniXF/1wmGOX?=
 =?us-ascii?Q?4NQE4WG3Mrwd/1VJ9JuQqzDmu8obidPV45QULwZoTZMkIxHKD/TeF+7E/ThS?=
 =?us-ascii?Q?7Iu4m+Tvrw=3D=3D?=
X-Exchange-RoutingPolicyChecked: fXmnaUiVsKyZE5fa0THHtyWJYY6bTH4PPYsd1h00OfxVjI/dqWujcl4BIGcCrCgzVJmqh20P9Gb3dD3l5LuddaZMDzsmtFZi1GnbJ8NDg0MtgWTvoBD1/HlWzMINaL6CNQLmGS3Vl5+Ps4e2lHaHdksmtJrYDfjCYpxblgR5pUGmC2Gm6ALGZIk6scNqchTBpqC/TxkLO0pjih5to7k8rH3kNzecAkXodswUYJdLhJN/uZY5ocV3qse0f8wmJqH3rQ4T3XuXA6F7Eovo/gV8ndnP4FSlW/T1dLjNzym92Ykk/UVfYbnKKkpGQ72PuNw+JDRJD0CSjpGxSOXSFYv+yQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0f6472-1fe4-43e4-42a4-08de9c7023e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 10:57:38.7538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgm5NgrvIF9MnbzPTNhgOjeJwZaIpKOAQ2HZYyvS7WFUs4PX58eoIi9e8GwviDXpT1voMS6XTfbJshFnvgCpVC5LcPEC2NLdgDLw6uspIes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8223
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

On Fri, Apr 17, 2026 at 10:08:02AM +0000, Ciara Loftus wrote:
> Previously, the only way to transmit LLDP packets via the iavf PMD
> was to register the IAVF_TX_LLDP_DYNFIELD dynamic mbuf field and set
> it to a non-zero value on each LLDP mbuf before Tx.
> 
> This patch adds an alternative. If the new devarg `enable_ptype_lldp` is
> set to 1, and if the mbuf packet type is set to RTE_PTYPE_L2_ETHER_LLDP
> then a Tx path with context descriptor support will be selected and any
> packets with the LLDP ptype will be transmitted.
> 
> The dynamic mbuf field support is still present however it is intended
> that it will be removed in a future release, at which point only the
> packet type approach will be supported.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v3:
> * Enable ptype LLDP via new devarg
> ---

Some feedback around documentation inline below.

/Bruce

>  doc/guides/nics/intel_vf.rst           | 21 ++++++++++++++++-----
>  doc/guides/rel_notes/release_26_07.rst |  5 +++++
>  drivers/net/intel/iavf/iavf.h          |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c   | 15 +++++++++++++++
>  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx.h     |  9 +++++----
>  6 files changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index 5fa2ddc9ea..4b65fa50cc 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -675,12 +675,14 @@ Inline IPsec Support
>  Diagnostic Utilities
>  --------------------
>  
> -Register mbuf dynfield to test Tx LLDP
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Tx LLDP Testing
> +~~~~~~~~~~~~~~~
>  
> -Register an mbuf dynfield ``IAVF_TX_LLDP_DYNFIELD`` on ``dev_start``
> -to indicate the need to send LLDP packet.
> -This dynfield needs to be set to 1 when preparing packet.
> +There are two methods to trigger LLDP packet transmission from the VF.
> +
> +The first method is to register an mbuf dynfield ``IAVF_TX_LLDP_DYNFIELD`` before
> +``dev_start``. This dynfield needs to be set to 1 when preparing an LLDP packet
> +intended for transmission.
>  

Switch the order of the methods in the docs. We should always start with
the best/recommended method first, so the user doesn't have to read through
the less-recommended methods in order to get to the best one.

Also not when describing the dyn-field method that it is deprecated and
will be removed in future.

>  For ``dpdk-testpmd`` application, it needs to stop and restart Tx port to take effect.
>  
> @@ -688,6 +690,15 @@ Usage::
>  
>      testpmd> set tx lldp on
>  
> +An alternative method for transmitting LLDP packets is to set the ``packet_type`` of
> +the mbuf to ``RTE_PTYPE_L2_ETHER_LLDP``. This, in conjunction with enabling the
> +``enable_ptype_lldp`` devarg will cause such packets to be transmitted::
> +
> +    -a 0000:xx:xx.x,enable_ptype_lldp=1
> +
> +When ``enable_ptype_lldp`` is not set (default), ptype-based LLDP detection is
> +disabled, but LLDP transmission via the dynamic mbuf field remains available.
> +

The previous method describes testpmd use. Do we need such a description
here too?

>  
>  Limitations or Knowing issues
>  -----------------------------
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index 060b26ff61..e0b27a554a 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -56,6 +56,11 @@ New Features
>       =======================================================
>  
>  
> +* **Updated Intel iavf driver.**
> +
> +  * Added support for transmitting LLDP packets based on mbuf packet type.
> +
> +
>  Removed Items
>  -------------
>  
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index f8008d0fda..ef503a1b64 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -323,6 +323,7 @@ struct iavf_devargs {
>  	int auto_reconfig;
>  	int no_poll_on_link_down;
>  	uint64_t mbuf_check;
> +	int enable_ptype_lldp;
>  };
>  
>  struct iavf_security_ctx;
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 3126d9b644..77e8c6b54b 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -44,9 +44,11 @@
>  #define IAVF_ENABLE_AUTO_RECONFIG_ARG "auto_reconfig"
>  #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
>  #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
> +#define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
>  uint64_t iavf_timestamp_dynflag;
>  int iavf_timestamp_dynfield_offset = -1;
>  int rte_pmd_iavf_tx_lldp_dynfield_offset = -1;
> +bool iavf_ptype_lldp_enabled;
>  
>  static const char * const iavf_valid_args[] = {
>  	IAVF_PROTO_XTR_ARG,
> @@ -56,6 +58,7 @@ static const char * const iavf_valid_args[] = {
>  	IAVF_ENABLE_AUTO_RECONFIG_ARG,
>  	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
>  	IAVF_MBUF_CHECK_ARG,
> +	IAVF_ENABLE_PTYPE_LLDP_ARG,
>  	NULL
>  };
>  
> @@ -1016,6 +1019,11 @@ iavf_dev_start(struct rte_eth_dev *dev)
>  	/* Check Tx LLDP dynfield */
>  	rte_pmd_iavf_tx_lldp_dynfield_offset =
>  		rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
> +	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
> +		PMD_DRV_LOG(WARNING,
> +			"The LLDP Tx dynamic mbuf field will be removed in a future release.");

I think this message could do with being expanded and clarified, even if it
is longer. For example: "Using a dynamic mbuf field to identify LLDP
packets is deprecated. Set the 'enable_ptype_lldp' driver option and mbuf
LLDP ptypes instead"

> +	iavf_ptype_lldp_enabled = adapter->devargs.enable_ptype_lldp ||
> +					rte_pmd_iavf_tx_lldp_dynfield_offset > 0;
>  
>  	if (iavf_init_queues(dev) != 0) {
>  		PMD_DRV_LOG(ERR, "failed to do Queue init");
> @@ -2445,6 +2453,11 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
>  	if (ret)
>  		goto bail;
>  
> +	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
> +				 &parse_bool, &ad->devargs.enable_ptype_lldp);
> +	if (ret)
> +		goto bail;
> +
>  bail:
>  	rte_kvargs_free(kvlist);
>  	return ret;
> @@ -2795,6 +2808,8 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  		 */
>  		rte_pmd_iavf_tx_lldp_dynfield_offset =
>  			rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
> +		iavf_ptype_lldp_enabled = adapter->devargs.enable_ptype_lldp ||
> +						rte_pmd_iavf_tx_lldp_dynfield_offset > 0;
>  		iavf_set_tx_function(eth_dev);
>  		return 0;
>  	}
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4ff6c18dc4..bb62ab07de 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3886,7 +3886,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
>  	if (iavf_tx_vec_dev_check(dev) != -1)
>  		req_features.simd_width = iavf_get_max_simd_bitwidth();
>  
> -	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
> +	if (iavf_ptype_lldp_enabled)
>  		req_features.ctx_desc = true;
>  
>  	for (i = 0; i < dev->data->nb_tx_queues; i++) {
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
> index 80b06518b0..0157c4c37e 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx.h
> @@ -157,14 +157,15 @@
>  
>  #define IAVF_TX_LLDP_DYNFIELD "intel_pmd_dynfield_tx_lldp"
>  #define IAVF_CHECK_TX_LLDP(m) \
> -	((rte_pmd_iavf_tx_lldp_dynfield_offset > 0) && \
> -	(*RTE_MBUF_DYNFIELD((m), \
> -			rte_pmd_iavf_tx_lldp_dynfield_offset, \
> -			uint8_t *)))
> +	(iavf_ptype_lldp_enabled && \
> +	(((m)->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_LLDP || \
> +	(rte_pmd_iavf_tx_lldp_dynfield_offset > 0 && \
> +	*RTE_MBUF_DYNFIELD((m), rte_pmd_iavf_tx_lldp_dynfield_offset, uint8_t *))))
>  
>  extern uint64_t iavf_timestamp_dynflag;
>  extern int iavf_timestamp_dynfield_offset;
>  extern int rte_pmd_iavf_tx_lldp_dynfield_offset;
> +extern bool iavf_ptype_lldp_enabled;
>  
>  typedef void (*iavf_rxd_to_pkt_fields_t)(struct ci_rx_queue *rxq,
>  				struct rte_mbuf *mb,
> -- 
> 2.43.0
> 

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D2F506D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:01:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 097D04025E;
	Mon, 16 Mar 2026 15:01:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id A5778400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:01:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773669675; x=1805205675;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IYmqM1eMsK8Y7HA3Z+MU9IH9D/TYolwypFROGIyP1BI=;
 b=mH8nudFSZDbnKsrQMi31roofYb0ekbmoGMtP7ai+fy/zuZweTipeuyHh
 yAUMbEqQKmHHc4nQnHtX6MQXNRkdxdSfJeKfjVLsCAERgEIb2+YNY5eTt
 Wx6GOwUgURttl0VwqJ2dgiI6DKQIH9tJOByBtPU3jpIzv2Ukue3DdssnQ
 o5abBPfcQcAMP3gXS3sZrfj43HDEa32gGWta8sah504e42Bp0ljtvMTuS
 7IiO81BdpdF29IH4hQ+RoK9Hj6dYXtjhZFybTLwJg23FQx/jEXPPOYKyO
 b8lgzK0jXier7Bwc5bVNBeZiDAyfWtr26a/0M+MsESxPFyb7cJTdVRKNA w==;
X-CSE-ConnectionGUID: 7SdgtrDgSsunPhCI+pCozw==
X-CSE-MsgGUID: 4QW2MuPbSvmgdtmKScovrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62252405"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62252405"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:01:14 -0700
X-CSE-ConnectionGUID: O2lcCovOT4WKa99/yOo52A==
X-CSE-MsgGUID: guYTUgxuQ7irSzqrNZJVtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="219499647"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:01:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:01:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:01:12 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG4Za7pe7ybc6Nd9gY3y5JD9qu25lMYgFxFNiVW0QqaUFmQFsJniWrsvCbhGZ354J3Gh1+NlhVBf+xR7kFzOaE1PiiwrD/6WR5q3XNYvmDaybyAJra9VDZaufWVGhSTn52gd2KxirXv/30PXw4kTMnOnUEb01+oo+4txLRLC4YYVusRpnvERNbZE+Gi3o7Rr0VM4dqaZjcipCddOuMkR6c598SqfecDJNZNo9uapWrHc2Doe/ocz4Sb5MadYW+OPEzAJ7ef5gL22Jwys8CjWdO8uEBRbTbQzMWH/1X9t+pZx1LVw50ks7+c1e+6F2CJgxaIr6Pzg2B8OSvyblSA/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpxX7Pl5rwtXW2Kba4Hrow8YzAdrZzap5+ggqG8cPVw=;
 b=KQI75qrfiLu+KyLO6hZf3oRccMQa6ToAfl33l5J0fDSJwYw+rqp3D79+dilEFLf3Db3W9sInjv1H1k9llQNqQQhUVirbpYBgaZksvxbGVrkyqdUlLNEXnGNLyP8g4jwjmqp/jm81826+G4XGqJZqT/J2VZ7rl3IDIW2/6s3RAG9DmhO3j8yzj94bw/KK7EE2VhqdTBA7mpbxDL5VTddEMI/S0d0vAvR3Tl6reGvn0tnIgEsBcnph1SdK7JuSL5nJrc+iDB/sPU7kQIMIXth1bhMxEjQQoYcT7MTISXXePfRBUkQ+sPjFP516nF4ymquffiftzuV5ot1B6ZN83R9HJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:01:02 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:01:02 +0000
Date: Mon, 16 Mar 2026 14:00:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 11/25] net/pcap: consolidate boolean flag handling
Message-ID: <abgNCJkwM6lRvbYS@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-12-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-12-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0290.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA1PR11MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 428fc83a-120f-4673-74a9-08de83646d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: z8zqlq6a1ViqGyLHD7jeENi0+qzRB4t6lK24WOjiYe/YdByOnCnVR5Db6MCdA6cLQX6oRWPokp/2remBvFOZ6/GgxecIKgBkh1CT8xeV1OeQOokhAgPSi5cWwdzBC4gIB2runLyBWnAukmGECOMRJOnhsEf4HotIkSVJjH1DdODoQ2LQSnbyDs96/zE13D2c+uhcX/St/ctanKmUJMpkgU2WB5DkTeLyvW5jBFb+V91IIFE/slt53kNx56bPTWoQEFHEd8mbaSCS4Y5nAKHlCnZ7Zy7HRocwN0ZXmXvLjmQGO+SF9qGD8HNknhmCj2k+GTps/z0Z2Hb6wc/ooWh52Sf5lJYk0jeebtc97UdfwApPt2Gl75KFa0kGCEbt7VaLkjVpUDDsu0zz7i9P68axQMkl0gX+ZKUmc09RWIfR52OcNU3+cjL0VOD//ExwCd+OUkab/ESts6rTUFe2j9c34VSDt7oc2oWty2TFKzGH3+4aC6zryVPdMaKMosnD/xQOKrFJp/TTF2pn4oQWfgTq3rlOZmwwvVWrWAHL7qmUrPVPiIDYQNb5NGfkL96CsBorq+gJuJPdWRsKCtPk9jb3JouoRpNjfZM2pei3eQdjc9dgrCM4Q4PC08LDoYzmlPOtc/mb28yBCgnvh0fKZDjZY7nYF70RO5Yd2D22aKHtMfrHTGPmTD9b9JxufkhuoP8/lKwMCMbJMqOnVowi3emeRF5q9eagoDgeJD2Z9OuzhQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NjrhCElpj3yVEyKCDlGyEKkvbpTiipTb02wPV1/EbvfBrEjK+cyF8nT3p+V5?=
 =?us-ascii?Q?tfKibnG8d4f1oOPNoDCapVXvo3PxY+CW2rQYIyOClYKUEArueTHHzsNqBuRd?=
 =?us-ascii?Q?jYS5RhjQVBbzHoePbWP2R4q6sNapzGfQMETLt91S2u6ERv7Mhf/zgyFl/9VW?=
 =?us-ascii?Q?8HUvD5+EHB3nl6eMvwBbHadGkD1yBmXtHbGdWpEhlC+iyGMi+NxrRDEXogcg?=
 =?us-ascii?Q?3ibl7ju51+bAGmEbSBkSzIp3vr/F0+G0ViFFiako4Z13anF8QhoKWMoQRo+h?=
 =?us-ascii?Q?OlJt9QkWNSAi2tsz26vpqfdCih0r13EB8pBKdQcT10H8UUE1/g1w1P/dt81p?=
 =?us-ascii?Q?3Dw9KHOgbeVdlW76Rl2MxrRb1rnmgudoGwoaDSkB2EVPpW4HLbLtoSN+wEzz?=
 =?us-ascii?Q?CFfxZSlh8fFCyG8wYwzNkwpnN9Np6Ot+8tvRp+p5sI5bGpA8UAURtV22P5Ul?=
 =?us-ascii?Q?9dihBd8FNwFZ2+WW9d7nb3t1P9vaEMUMlAyFaiuxQWLfxzxvSxN0MrgcAskx?=
 =?us-ascii?Q?zKXQAFmP3pDNgGCTBDaJ5+No3O8tSJbg1CltUmp/B/IGdNz/6Ux3WCQ4yKR/?=
 =?us-ascii?Q?QItCDDPTKBOumXNknDKPkJbZR+HXWnACcVvgHKVART4F418PuuA/Oqd80NWk?=
 =?us-ascii?Q?eN2wksfruuI8kySJNQTaGUx5tUQusmvWEGIKDn2cEDQ9oOZJw+TOTxkWWzgq?=
 =?us-ascii?Q?xvaZfO3MFi/vYLeKRU7ak7pNK70t2Rz8CqmjP/IqpMDgBHfMcCfpZN5f1Tzq?=
 =?us-ascii?Q?jrqjNhc75INRa2VVI9n4BdBaJzrD8UvvV2WRO453Xv3Fni1KunIDk6f1aRy2?=
 =?us-ascii?Q?YfCab4P2yA1VqPVZh5oEA4WFnuTbJlLNovO2tusNXCHnJsJnDjsL700M/tSF?=
 =?us-ascii?Q?gi22tUhJRmfVKIl72g/H0sE20CznvWf1GAUV92iVII8ikzyligsdlFu5vrCn?=
 =?us-ascii?Q?xSdVAJAzi/VT81oh8Sb4svPcuN1//3zJBs8MtIYKuuyOuV6yURUpiJyLRM/2?=
 =?us-ascii?Q?63RBjbAv64ym3oN/vFQ36AERQUCCeiWIIRIELLEBdo16KAm7dfMvDE60h8Iw?=
 =?us-ascii?Q?aFH1GbE+VZMqPRDwgaDxoUrxCrkX4fJ+p7F27mOWtIREiy+iSjza7WrVDXxl?=
 =?us-ascii?Q?5n+rCNfhX+cvgw3m5/qLzpsrC691g451sChfZEyMv9h5VhjWJtbwtU9LE5nf?=
 =?us-ascii?Q?htS+AGhBJiPjrwaP8gRDwnpKdtgn8/YHfIEkX0rcegqHucDqcqLcZoZXGeZY?=
 =?us-ascii?Q?c9o4/Yuwyk2Y1U3xsamZB8SwaaL/JV6LXga+wy6gJwaA/PlvxhSI6llpOpIu?=
 =?us-ascii?Q?9gnoLG0BFoBqh7tVGCDW51zIN21UMY23xvsV/gORnwQlsVe1l0EWmhnDxY6K?=
 =?us-ascii?Q?hvzZcIb8yReReoTHD/WBH2W5q6jhN/hTwSA3ZEeD+7TvnuYRaL+RqCWMYprI?=
 =?us-ascii?Q?5pScHUtSZm1FdX0mIeu2wacDEzeP9acXNc5goSR9bRYMaabW1vWuW+fq1HAG?=
 =?us-ascii?Q?eFRjwtiGGcm6ROK4FNIKyu2JwUP78xb4NG8MVKu9mmiGllQ6P5D5LuETQmdO?=
 =?us-ascii?Q?HSPqS3bb54rYLWplm0LCl5nyhltGQE1MP3aYl3t3UvteWZRrom86MyQtwkeb?=
 =?us-ascii?Q?dyzlUIJt76enHRVlDWR8EKo2qXP5N8u0IYd1Lnqokn08LdIlPslOSL1izoXe?=
 =?us-ascii?Q?0bb+eRPPljg3C+JGxIqHjiYnwhXOUKeQBFsqEhBy5gJX56TImTKfC90HaN9O?=
 =?us-ascii?Q?2MNVaU2me2JqBEDCYdOvSGW8nGxbCVo=3D?=
X-Exchange-RoutingPolicyChecked: oANZ8WbL3M5om2p6TSsSOResgpc/FJiS/9wO4w9desM4M9l12Ppp4wOoEGzDqXVg5b3tx43M4o+IHYqdY6DVlV9k9NAs2GjUV4dlHZG6FtNdiQCKkiBvqfRI728ojnuENWqAwZIG/FlhjsjxnL8oMp5IM1go2aFCSL5WPFuXkBl4j1GE1vdz0MgRl2n4jV+rQUClUnttENE7Mm1zcL68fhsmFIKq7Smr9ZbPwdLv5cqdaIC5M/Ay4TBMaZrZ46GEOf7u+FNj5eEAkjoy6A891sFLXaKWfTxDDonCLAQ4TOv/B3OD/8e5Q7DBzQHtWFLldUciZYHHGrjT3VAUh7I5zA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 428fc83a-120f-4673-74a9-08de83646d06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:01:02.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEJRwDGVdZnJGUrhlmGydlCGfyufAmKta3/MqTnvkPWEAilbw6BywqLx7gqzltIUIIZr9nUntNBdKUjcZ/RE4m0P2Ws/rhl1QWE3XcWi7nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9495
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

On Tue, Mar 10, 2026 at 09:09:49AM -0700, Stephen Hemminger wrote:
> Convert internal flag fields from int/unsigned int to bool for clarity
> and reduced structure size.
> 
> Merge the separate select_phy_mac() and get_infinite_rx_arg() functions
> into a single process_bool_flag() handler. The new function also adds
> proper validation, rejecting values other than "0", "1", or empty (which
> defaults to true).
> 
> Also change num_of_queue from unsigned int to uint16_t since it cannot
> exceed RTE_PMD_PCAP_MAX_QUEUES.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One minor comment inline below.

> ---
>  drivers/net/pcap/pcap_ethdev.c | 69 +++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 258cffb813..c3270a676c 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -7,6 +7,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <stdbool.h>
>  #include <time.h>
>  #include <inttypes.h>
>  #include <errno.h>
> @@ -102,9 +103,9 @@ struct pmd_internals {
>  	char devargs[ETH_PCAP_ARG_MAXLEN];
>  	struct rte_ether_addr eth_addr;
>  	int if_index;
> -	int single_iface;
> -	int phy_mac;
> -	unsigned int infinite_rx;
> +	bool single_iface;
> +	bool phy_mac;
> +	bool infinite_rx;
>  };
>  
>  struct pmd_process_private {
> @@ -114,25 +115,25 @@ struct pmd_process_private {
>  };
>  
>  struct pmd_devargs {
> -	unsigned int num_of_queue;
> +	uint16_t num_of_queue;
> +	bool phy_mac;
>  	struct devargs_queue {
>  		pcap_dumper_t *dumper;
>  		pcap_t *pcap;
>  		const char *name;
>  		const char *type;
>  	} queue[RTE_PMD_PCAP_MAX_QUEUES];
> -	int phy_mac;
>  };
>  
>  struct pmd_devargs_all {
>  	struct pmd_devargs rx_queues;
>  	struct pmd_devargs tx_queues;
> -	int single_iface;
> -	unsigned int is_tx_pcap;
> -	unsigned int is_tx_iface;
> -	unsigned int is_rx_pcap;
> -	unsigned int is_rx_iface;
> -	unsigned int infinite_rx;
> +	bool single_iface;
> +	bool is_tx_pcap;
> +	bool is_tx_iface;
> +	bool is_rx_pcap;
> +	bool is_rx_iface;
> +	bool infinite_rx;
>  };
>  
>  static const char *valid_arguments[] = {
> @@ -884,7 +885,7 @@ eth_dev_close(struct rte_eth_dev *dev)
>  		}
>  	}
>  
> -	if (internals->phy_mac == 0)
> +	if (!internals->phy_mac)
>  		/* not dynamically allocated, must not be freed */
>  		dev->data->mac_addrs = NULL;
>  
> @@ -1209,29 +1210,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
>  }
>  
>  static int
> -select_phy_mac(const char *key __rte_unused, const char *value,
> -		void *extra_args)
> +process_bool_flag(const char *key, const char *value, void *extra_args)
>  {
> -	if (extra_args) {
> -		const int phy_mac = atoi(value);
> -		int *enable_phy_mac = extra_args;
> -
> -		if (phy_mac)
> -			*enable_phy_mac = 1;
> -	}
> -	return 0;
> -}
> -
> -static int
> -get_infinite_rx_arg(const char *key __rte_unused,
> -		const char *value, void *extra_args)
> -{
> -	if (extra_args) {
> -		const int infinite_rx = atoi(value);
> -		int *enable_infinite_rx = extra_args;
> -
> -		if (infinite_rx > 0)
> -			*enable_infinite_rx = 1;
> +	bool *flag = extra_args;
> +
> +	if (value == NULL || *value == '\0') {
> +		*flag = true; /* default with no additional argument */
> +	} else if (strcmp(value, "0") == 0) {
> +		*flag = false;
> +	} else if (strcmp(value, "1") == 0) {
> +		*flag = true;
> +	} else {
> +		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
> +		return -1;
>  	}
>  	return 0;
>  }
> @@ -1507,7 +1498,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
>  		dumpers.queue[0] = pcaps.queue[0];
>  
>  		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
> -				&select_phy_mac, &pcaps.phy_mac);
> +					 &process_bool_flag, &pcaps.phy_mac);
>  		if (ret < 0)
>  			goto free_kvlist;
>  
> @@ -1546,9 +1537,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
>  
>  		if (infinite_rx_arg_cnt == 1) {
>  			ret = rte_kvargs_process(kvlist,
> -					ETH_PCAP_INFINITE_RX_ARG,
> -					&get_infinite_rx_arg,
> -					&devargs_all.infinite_rx);
> +						 ETH_PCAP_INFINITE_RX_ARG,
> +						 &process_bool_flag,
> +						 &devargs_all.infinite_rx);

You can shrink the diff by leaving the indentation alone, there is nothing
wrong with it! :-)

>  			if (ret < 0)
>  				goto free_kvlist;
>  			PMD_LOG(INFO, "infinite_rx has been %s for %s",
> @@ -1698,5 +1689,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
>  	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
>  	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
>  	ETH_PCAP_IFACE_ARG "=<ifc> "
> -	ETH_PCAP_PHY_MAC_ARG "=<int>"
> +	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
>  	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
> -- 
> 2.51.0
> 

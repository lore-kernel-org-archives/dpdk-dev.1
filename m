Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87708FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 15:55:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D42A240664;
	Tue,  5 May 2026 17:55:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 208A74027F
 for <dev@dpdk.org>; Tue,  5 May 2026 17:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777996551; x=1809532551;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lpjmTIrDGmYp1ptIvIjIzIU2xLeg8Fjk6bv7Qab+k/8=;
 b=jK45b7pSRmXjI0PdDC9o0/WqgTvdIq4MwQFClmpY+PIE8CUapvARVOjc
 vPdykb9uV4HfdLH4LdE95tRz4OXxszmvxjL0nj3GpxBUhX4RPb0zX/AFf
 uyG+qJf4LmuEBTtM0NkDgCWik4vn8jRD1KWcCihmHwHNn93n3M6XlYh2q
 +YxQpBftALRyIEsGP1svBlAnlgAvgruPo39r8ZA3hcdH5Zd4GPvWWQOwG
 xM//DTcMg1fvVUtz98YM1gG721rH8NPpgJAdbkPN4ATC4NJ6kLbgUB5/M
 rDvsAslRnqP8ZTDTRkTZxbVgBBBa/HujbbeA7FNbRDyjGp2eoOVyXMtQO g==;
X-CSE-ConnectionGUID: y5GkgK6tSRyU/8a3UujS0g==
X-CSE-MsgGUID: XhJbTLUWRkCRqH9V0p0mXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78776886"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="78776886"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 08:55:50 -0700
X-CSE-ConnectionGUID: eZshZgn4QfaTFTQAaa2nXw==
X-CSE-MsgGUID: 8hFYtnzmTKWKhbQLXyr0nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="234976663"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 08:55:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:55:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 08:55:49 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/ifZJ2ni/0mGZfummm9JCit/vt5LSUWc5LheiOf0Niu1FMM4YJ7KV2p80OXUfq+XJ9SNA1tySFLSqu3olySbAq16317qYEPm1+t6WGTC83cD9weLs7jeeRZRiju61JA23p4FN3I54yzg7h1/Xmn6xYOoaccWqNHUyXRHwTzxqmwXkNAFNwxK72H220hr4NBKunBD6E0yQ3hciRZYMCsXgnCfv/oq6SRCVE+U3HkCuP5oVF0226yqc1zVOqllY7J7lc2l9eoQQqpHEo5Jv2MtUu8uXhPXF50TtPSG1X8NzEDrrQ48cdvIojM1/doSUzWZHTECFKR0Yfc9IWqxzjcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PtqK8JboGW0tFlby/gh7FMC73K0dEXqB8S1PA2bkgE=;
 b=BLJd1Vz5YyQUBq9xftAwFkJlhsToRqvnupYYuWvtCeyhxwhKXXGutQ0pOGOMvPZCIRVwDBvV0LcYwitolDkfkW7bAxHhx9ctSS8FT1SMA0991hQ9xWuJaWQI2gQ+SPu+KghiyE+07sSiXOA5U0wIOv+OllWhdbj4vNleGVulzwEprY1LNZSI3VEg0SuHFVmVJ9xVDCa1lb8qwmBAjHrs/44IO8S9e4L0EB/L5Y8FvI1HBzberBIrgOoj0eI+jYSUWdeOhE7gCl7uNxJQmsYB0QfCIbx3Ltwp7jC2FT45g6vCgkE7mHuRERj4Nog0BmEMv7aaVCdjAk6oW2bccn7ERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF4C690C788.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 15:55:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:55:46 +0000
Date: Tue, 5 May 2026 16:55:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/iavf: add support for QinQ insertion
Message-ID: <afoS_fPQcRO87406@bricha3-mobl1.ger.corp.intel.com>
References: <20260430085813.230798-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260430085813.230798-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0258.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF4C690C788:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9d906d-0ebf-44f7-946b-08deaabec54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: CuQWKHPz8IpmT3UGu36laD5IYRCBIMPpv93BsBGMuFrTnjqeaZZKYQzP2IYi7IttIaF8QBccdX1lyrH4eXawcuxxaVoGsAQtZL/y/hICSQapFXkTnNkuleSz0FRHW5WXlNeiVzy2FIsm5AlsneF3nJESNBR0INCQPd1MqIHBLbw+VX6F0uPp1P0VxIiJ4MdhRe9dBjBLWds5njcWVLJqj0d0Qf1gqfurPX3A585pLUNFHzcrttBzVmBfyWFbySR8Wy/+wCuc46qxGK8csv5mVAACpAytN90WULS8n7dwLvvbDHzps1/VfqDyXd5LACIgRvhnZhYeZQLPMRyznJiNgNxE3qh0KH0CvUDfdR8QyGh10pC3duV30BOcCRXy/n7Fc0CksQVbUBGaStQiO9cFVhDFE8hzOd54PY0zzeT7nx35g/SblTYkHfS6ZJ2QEpyKtIZz8/ybbNRNugcLvabQVXVz/0tVJIdtmWdll9+0Dzld5NaLlI0ht+2nJboQ0Sctyb3/0Ip8kvCWPVbQsYbQWZZ3QuHjK/yZM0gfSqd0v+E2r7McFRTRAZJVpz2S3g1fLh3FrFXuO5JABvVSXNGQMVCaixX1q0ofKQ/F4JOmA7RqGNp18LqyI++6hcezrtS03A+33js7uChRn6MBJhUFoWmGUumNoicPV0lSdX7pOpXyOE/3nt4QLu3DibkDku59
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxjcR7Mf/kasFewOa6q627TOWJuVdkMAHiwecvZJJhbsRU+j5Vpf4h6lGvw+?=
 =?us-ascii?Q?cK+qxjBeUckDuMUpQcamFYMktb49AbaVV6HOZySotz/5MeDJ5DaIg+Fx3vE0?=
 =?us-ascii?Q?LmBWggG4fIrfsaP6p9hZReraXkpevX6jRLeFBxAArWmO1hArTJyL3oGTYFu7?=
 =?us-ascii?Q?5kKGnmiGF4brfSXlTvVhwv4YpxZXu4I0Q8okT9u/YvvLjXknxIDXHnd4YS9D?=
 =?us-ascii?Q?JCCc2QDtcR3onv9n+h01yq41gIwbBpo1jFM8Y6VqVzioRC5IGoQMss0Ht5GJ?=
 =?us-ascii?Q?AFYLRk9Nkj9KhtlSKwqbKaM/xEdXTMNLaeJHGNOP/B3IVrUBSQp7WXxJGZ5S?=
 =?us-ascii?Q?wrq/Z1wPhHJVl8tWh7j87YYx3T6TiCkeMFraszAXnSsOGovcWt3bgAd0sf8x?=
 =?us-ascii?Q?utOLcZxIGTOlYG8pNRUcleQOYwt6ZMl72463ht9LNVemo3IljYOB0w78aXYZ?=
 =?us-ascii?Q?VPJZriyZgSwwkMHXaKd7+7YZHJUmuarT7XNxh6PYgxpatimx40WmOdnM0ZUy?=
 =?us-ascii?Q?fHX+xl4DDdGQ/2FeEOZz//ZMGXG0mD4fwLO8zDjUADBKndkA28P5iIQb92x8?=
 =?us-ascii?Q?ESA/P41H1q9VSf40eZGe19ukIDVVxNWOtRGfjViEJzJpOnFKDCBMNT8RDos5?=
 =?us-ascii?Q?C6c2yZN+hWjcXudCcweY6yoMgY1z2O2FBfE0e0++KgoMBjvm/hQecpRBmZgl?=
 =?us-ascii?Q?ZVdL1es97C+fRQ2hBial7DTqTYbaUi0meC3cl1rG0+h0SdwI7Kv0fzepbWWQ?=
 =?us-ascii?Q?wtOPde37V2barVf09PeMr8JwwVijnIo2SF/Oz2FS9EvFnXaRLw4F0Ewe8S+g?=
 =?us-ascii?Q?6ymv1MHffwZy3ffFNL40oLsbf/Oadk3XfjawHbK0lhDbFBUYrcgx006CTrr3?=
 =?us-ascii?Q?aKXtdlnFl/cJ88WpSIhV+c3O/4kmoRlZaSbz4fF1RkTETaf11PAEhBKv27pz?=
 =?us-ascii?Q?5eUzjSliCEsZ0ThWDxY0++89/gQ3fMjKQ7O22WB19udlMeVYZK08SD4P6Ztk?=
 =?us-ascii?Q?jtyoCqhP6yJwePYQTBdJq+1H0gkojkJjSCtYXmuw9mdjVCAEwCjNCkESMtqe?=
 =?us-ascii?Q?16oG2iNhe7LBl/5v/OSDzgYegMpYeMvEUAAf6t3bEm62cQ/GYKN2Sfg/QSkb?=
 =?us-ascii?Q?qSBoQ/alslrlLskDc2RhOJN13qgo8SdT4SVbq0Lm3qxNXHOIToX9U91QU0p3?=
 =?us-ascii?Q?5c9h5GiB9maFtlktmir0wPbPZz3wrgD3dwYNTJGYcGJpDYADjXpN6cIwrk2Z?=
 =?us-ascii?Q?crFZtJnfg0eC7B2Maor5kwTIBmftC/CzZnrcgqiRQs7UHtSL6dX1fZSnXle0?=
 =?us-ascii?Q?ZAG7I+I3b81ykfT2UJYe6LwLl+nSITpPwaLqxJI4cryoN7rHb90AU2k6dt4S?=
 =?us-ascii?Q?CqSx7f0dRAcIQg11mUY0ZmVzwKdvM8ak34k/QKMw9ivcKvaoqnOXT+ehxUYr?=
 =?us-ascii?Q?NMAcq/em8SKN3vYAWfZ5i5Bf1beJa/tgPbeVTe2C3oOSMauwxgbYt6dFOAUD?=
 =?us-ascii?Q?B9t2GjVkH4Ywc52sofLvoeTqWCiylhhzrZ6bqd24X2oVbfZ4u6xdIPbLx3k/?=
 =?us-ascii?Q?8JmxN+y9aa9aJdNMh72lhBI/Fdn245LUa3bbZ3Iwdq262gvWPQ/6EbeSHqvL?=
 =?us-ascii?Q?uq+wwIKHhL604zMRY1o/T4pfRHVycSqRqTb0kXDLYMdCjMqYMq0Urd9jNGKJ?=
 =?us-ascii?Q?P+0A/wD+522xyE37bH0Ke5NAX0oDQyS8qfzkP5oSacAJSpoFEmJCr7NBdRRf?=
 =?us-ascii?Q?ppofi8E20n7XncS1enGjycFyWoRb5CQ=3D?=
X-Exchange-RoutingPolicyChecked: doCef4UQRdXJi7UKJfjGyoj16u9xkrcmAjOFxO/LA5plPkbh9j5W4CdCMGGjBkbV9GAQ4EfO6FHKYks9ceFltvwyssU6fB0ZAUS5e0prOxHuGABJLrMGaylcOr0KeRTULDEcDDd8v9EccBSbzJTGbHph5z6IMJLtwOIDAZYGxEPDAJc6X/nOns0V5o3x5PVdEX5nRWdA4/Hfb8qYt/UOECyq1FU5FSES0i7L4gpddpwqHHW7xuF2TRFruWxtmt6VIyb6LVPdvnJL6DCjqAVQYpcWY2hh1lkcKibMABVWOETER/8Q1Tt5l08dq5DD99LLAmDSFZMN45YiO/Ok12FADA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9d906d-0ebf-44f7-946b-08deaabec54f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:55:46.6371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nub/jXCUL/4r2Fs9ybeDpOsMhqMuc4iBg0qghSu8gHNyTBnwNe4Mxf+w/sX8Fm1kMHI+/jCNMcQvhY4d+FF4ibB/HW7mjMoNM7ZJeoU8OnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C690C788
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

On Thu, Apr 30, 2026 at 08:58:13AM +0000, Anurag Mandal wrote:
> QinQ insertion with VLAN TPID 0x88a8 support is absent.
> 
> This patch adds support for QinQ insertion for both
> Outer VLAN TPIDs 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> VLAN Extend should be enabled for the same and Outer
> VLAN TPID should be set properly for TPID 0x88a8.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

In general, looks good. One query below.

> ---
>  doc/guides/nics/intel_vf.rst        | 19 ++++++++++
>  drivers/net/intel/iavf/iavf.h       |  1 +
>  drivers/net/intel/iavf/iavf_vchnl.c | 56 +++++++++++++++++++++++++++--
>  3 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index dfff69b982..ce11ea6363 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -802,3 +802,22 @@ To start ``testpmd``, and enable QinQ strip for default TPID on port 0:
>  
>     testpmd> vlan set extend on 0
>     testpmd> vlan set qinq_strip on 0
> +
> +QinQ Configuration
> +~~~~~~~~~~~~~~~~~~
> +
> +When using QinQ Tx offload (``RTE_ETH_TX_OFFLOAD_QINQ_INSERT``),
> +you must also enable ``RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``
> +to configure the hardware for double VLAN mode.
> +Without this, only the inner VLAN tag will be inserted.
> +
> +Example::
> +
> +  struct rte_eth_conf port_conf = {
> +      .rxmode = {
> +          .offloads = RTE_ETH_RX_OFFLOAD_VLAN_EXTEND,
> +      },
> +      .txmode = {
> +          .offloads = RTE_ETH_TX_OFFLOAD_QINQ_INSERT,
> +      },
> +  };
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index 6a77dacf59..0b6ed221d0 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -459,6 +459,7 @@ int iavf_get_supported_rxdid(struct iavf_adapter *adapter);
>  int iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
>  int iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
>  int iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
> +int iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
>  int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
>  			 bool add);
>  int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter);
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index c2f340db81..6dd7d455ba 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -920,6 +920,51 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
>  	return ret;
>  }
>  
> +int
> +iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
> +{
> +	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> +	struct virtchnl_vlan_supported_caps *insertion_caps;
> +	struct virtchnl_vlan_setting vlan_insert;
> +	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
> +	struct iavf_cmd_info args;
> +	uint32_t *ethertype;
> +	int ret;
> +
> +	memset(&vlan_insert, 0, sizeof(vlan_insert));
> +	insertion_caps = &vf->vlan_v2_caps.offloads.insertion_support;
> +
> +	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
> +	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> +	    adapter->tpid == RTE_ETHER_TYPE_QINQ) {
> +		ethertype = &vlan_insert.outer_ethertype_setting;
> +		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_88A8;
> +	} else if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> +		   (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> +		   adapter->tpid == RTE_ETHER_TYPE_VLAN) {
> +		ethertype = &vlan_insert.outer_ethertype_setting;
> +		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_8100;
> +	} else {
> +		return -ENOTSUP;
> +	}
> +
> +	vlan_insert.vport_id = vf->vsi_res->vsi_id;
> +
> +	args.ops = enable ? VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 :
> +			    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2;
> +	args.in_args = (uint8_t *)&vlan_insert;
> +	args.in_args_size = sizeof(vlan_insert);
> +	args.out_buffer = msg_buf;
> +	args.out_size = IAVF_AQ_BUF_SZ;
> +	ret = iavf_execute_vf_cmd_safe(adapter, &args);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "fail to execute command %s",
> +			    enable ? "VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2" :
> +				     "VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2");
> +
> +	return ret;
> +}
> +
>  int
>  iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
>  {
> @@ -929,14 +974,21 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
>  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>  	struct iavf_cmd_info args;
>  	uint32_t *ethertype;
> +	bool qinq = adapter->dev_data->dev_conf.rxmode.offloads &
> +		    RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
> +	bool insert_qinq = adapter->dev_data->dev_conf.txmode.offloads &
> +			   RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
>  	int ret;
>  
> +	if (qinq && insert_qinq)
> +		iavf_config_outer_vlan_insert_v2(adapter, enable);
> +
>  	insertion_caps = &vf->vlan_v2_caps.offloads.insertion_support;
>  
> -	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> +	if (!qinq && (insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
>  	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype = &vlan_insert.outer_ethertype_setting;
> -	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> +	else if (qinq && (insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
>  		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype = &vlan_insert.inner_ethertype_setting;

Is this not a functional change for existing code/apps? Is it possible that
there are apps which are depending on the current behaviour with no QinQ
support?

/Bruce

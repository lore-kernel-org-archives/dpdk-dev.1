Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23361C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:40:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7759D40144;
	Fri, 25 Jul 2025 15:40:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6B316400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753450818; x=1784986818;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KTFcxykwHTZmhDQelGk/UDbx8ehBqBGa/uy0x2nype0=;
 b=es7pyVp6yCigeze8b2GDkn0Iuqhq072mAfC+m/8glu9ztj5LUeAQVGdv
 nbwKwX77ypNii9OXIObIpQeeiXChtkHH44RWrfgZL8/61+reb1QrHYdKO
 JRbaikzw5Cv4PgOneAnA5B1pUt1Aq/zwit+sQLnqA0h7d2LckzybgTjdq
 i6QGbEL77TYjAexsEbhjP0RpXEyOTI5M18hjlHgpFIB2GGpptXI9Pgm5P
 sqLELG6Z+z/Bc56cz6ukGZaxbTtajG8awEez3qrTF8C+7uOIvo5OhIVI4
 hb4B3A5Dn4HH84TYHU4qjvIKnVSD581MAWwwPXWPzwl7IH8a7ENyMMt8a A==;
X-CSE-ConnectionGUID: Ifax4Sz1QMGXass3ndgFqA==
X-CSE-MsgGUID: rlfbll6ARvSA7WoxUZm9hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55724775"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="55724775"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:40:16 -0700
X-CSE-ConnectionGUID: Ir6r8TWNSI2NJoX3ze+eYQ==
X-CSE-MsgGUID: WT+Z4q6pQzW3wSJVytiM5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="198056344"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:40:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:40:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 06:40:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Artc83KiAUkWXsatZQifURDZqBUOMC4InW3bZBfdzPq+iDKnMbMcjr8TYE/nFmvHNqH8cbqv4UTyMpDZhkbaEA39jGRA8m0JXg/SIWCMLZvClSEZ0pdbNwjQf0A9FGH5XrfFzBQhE4kq8NgTJN8Mgf3DWpOlA0v387gxsxGSNLC/QXic2v6xLMZYvnETDW0sYVFuzOaa6rVr0vxMX8tQBy69thD9aFeWu4Rm4/1sE7B/2lu+16ndXrHUBNE3/ijDgDLzvfZX+3nsQnxdBh2OrsAgr6CKMGM2jqMH3/Hny4XnxiA2fL5Yvuih59wE/kWHai2L3yJkhKNttHgtPc7Ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52cReR0YJ+tei1mTn1Oy8y09eCZDzNMjIDpTazowSPE=;
 b=Kd0OzDHBpx1iBF9vVKkSYW1XuNYdfnLIxvT3cPqtW8uORMfUy8PBrzNvGf3Lt9nlaP8PqplE+KZV3fsLYmDWqnt7oo0JGXTh1lG6ipI3gLfyKIuoUtssljbYpKnz5LPQ81pdttBahufe0QpgLVVB0Bjs+/pGkpdVNZiGrRZLXXEvBuMdwQb5yeOlRmw79ZWHBnszbfjhxDWGrprwCHPecgovLPzHt784L4QIWKANfA1bCouQXTDOMh+xg3hwhU4HdPGpsPzPHd+fXOmlqzcNAoMePEKJifdRft9vbzQKqfkTqba10o+SvCa3SQyNTKvNmhnuA8cdR7LV4Pw6XP8zvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 13:40:13 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:40:13 +0000
Date: Fri, 25 Jul 2025 14:40:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 01/14] net/ice: use the same Rx path across process
 types
Message-ID: <aIOJNE9LCgb5QBDe@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::7) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f7219e-07e5-4740-d704-08ddcb80c80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JZw2tkSF5UJdVKEyDhV2MyhGJJ9mqT2nLTCuJ+pbwH/D/3DMLKo1QZoCT22P?=
 =?us-ascii?Q?LCTffXn1bjv0OOmNg5rNuxMp4Fq/dM6HZ7raGUSFo4YOu3mkSQCPyWonnbl8?=
 =?us-ascii?Q?+X8mBMLcLL1Mv5MImxLA892trMsIytiT6YQ+lM6M0BGY9EtIszVQFmCKtVXR?=
 =?us-ascii?Q?WBn5Zc6riWrYFdkpkWte5PT0pMTaX7OJ1sjdvNNImacbyQ+HlFnhfyEIr8Mr?=
 =?us-ascii?Q?ttIFD2BmQGd7PNjutwu+hBP0mQW7du7W59RuqhR2nk5TZeSemkf17V0S/9kA?=
 =?us-ascii?Q?lvnqD7vCf7i/LMRWH/hhZEBFhPSVtpJDc9nNMoltucGJlhIJpSQ6r+pYaghI?=
 =?us-ascii?Q?J6wv91E+7R3S7j3w38qN4yrjzbzunD9BWc810y2EPc8YTnP7a4IiiEEbFxYD?=
 =?us-ascii?Q?2Iv3HcDv3QcJBqjqPODTvjppONJaz+4nVlCOKys4ETR1hT5OQqFnvf+dDHBf?=
 =?us-ascii?Q?KqwB9wC9rhkf+6llu/GAQq2LYsx9ahmkUH5QuzXKb9kcbxTCT+Dul1iz5Ju6?=
 =?us-ascii?Q?1C4NRGMnOmaRTYHWkdde+PXArJzui6kFjFGzDFfbzjftjMfPZYIBkBI0bB5D?=
 =?us-ascii?Q?cXFEW02dj5rgD7g2QPeP0kaPcvCYZ2OVtcFQrlKiOFC2OiBvdzSZHCXH7yT4?=
 =?us-ascii?Q?sbljsbyylWoiEZmt9Q60YLhYxvgHfnhau3qr4t972TIGeLoc20SSN3+K/MKe?=
 =?us-ascii?Q?78tbIWIgbxqRlNOYQ11PDjigP6sru5wMivID6WEych8QnoVcopB9GWGdTKM/?=
 =?us-ascii?Q?AmPWBnCai8kFMY2nJdAYdp/37+HNAB2pOHxo9tOAObhnty2Iar9QREKLN7o6?=
 =?us-ascii?Q?pfPik8NPDvt7mEm2wel6859tpP42KmCoqVKM6k6TidNkeL/pNv0KxL31Mn0W?=
 =?us-ascii?Q?Nr9CjlCOrTeX3olGm8kaD1W6TCh/9oKfOPqKONib9HQ3hJ98AIAODlkmbZBI?=
 =?us-ascii?Q?ufWWnYh79vdBgW9KEk7JZa1HtszO+W9V7tPkrknjyWv3T2mCpu5j+oaa4gob?=
 =?us-ascii?Q?HcFOjVi9MD1Vw3fL3hT3oPQHmGz+3QcyhcMyZwAC1Ci2YgTnczwwG1a/Bp6R?=
 =?us-ascii?Q?CQHgTXYymS//CgjmjpKhilNbtodDT+PYjXASxnQKnD7Rp6+EVI2PBrywjbcz?=
 =?us-ascii?Q?9aeU6YGvfSWt/ap+SUDU4tjouYK/7PX2M5sHeYXpKoIZG0yLXduhzhq/ImvA?=
 =?us-ascii?Q?Ssxw5fhPeF+CAkUfqodRdlcNZJlzYTLhooWy+uxAvbjBIG/HNDWQZyRrf4Ag?=
 =?us-ascii?Q?kzffDyjs6fm5BPvjnTK9b5o/fKDHyUlDvDOR/XG1lX97jtS8sLdNz5h6CRJA?=
 =?us-ascii?Q?xHqrtbEErHivrX5cBdBXgpvHX+kgcckDN+fJ3yg/wH2dg8nHIrhyMQGyJTL7?=
 =?us-ascii?Q?UhivFTX/upmO8qXiuYXzTLICx1NkzC/MbDnx392Y7slzkDlaJgJlRyPicVaA?=
 =?us-ascii?Q?nJpuxcGiIXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0LhN2qnK3egXgR/b8ultYE4J7FVe7Fz507flA3c7ynJXEN8YaocKZ10PJZ5d?=
 =?us-ascii?Q?+sdAo/J0/OVYXKHlPjLt+CEXf5av86b5Eniq7TCBNYbr2qkm/l3/Gkb5vQvn?=
 =?us-ascii?Q?UZ07Qm1OqWeHknWdPbCZPVfH7B/l5kk95YKhb+QXeycArH0uq8jy7TU46rB0?=
 =?us-ascii?Q?pKyLYE/mTlCksmwcoeSqzn8JlWumZxtn86C8r2cBwnbsmVDFA4Drc24JObjr?=
 =?us-ascii?Q?8/SjbeyEcA06zveKhyPXP5y/mW/CpYBlsIEDjgK0HStDNeKATKam/+yI19Sl?=
 =?us-ascii?Q?hF5h9Xi8f9CAHK7k0kkP/zEvoGmUy65umWkRPGxAE0Mea1SMrJrkBrThnVLq?=
 =?us-ascii?Q?ASMdnklP5ZE+IXZTFXzxS2cElRq+TNPZbjDHQN1ZMIjkrc53x5O+hakMoAg7?=
 =?us-ascii?Q?DyeDBOQvIoLls3HmonxU0e/8/0ZiyjRcak9NWYM/RnvHBHUFV0kkUu2j70Ev?=
 =?us-ascii?Q?JP/SH3nz4m3VG4+2ZBb6qw/39Qs+pU2jCbp2vIQv+3bOKBQrFkQ42hitj82K?=
 =?us-ascii?Q?80ine8LYf9ux6VWD0yYQrWYJSZwCUU9mQWcQbKGbVYEZG050x02WSEk2wPSr?=
 =?us-ascii?Q?Vu8ogpYW3uAuKRDnIffPTpom8RSG2TuHGRZnAFwMRouIoFALr5cTTwBrXmiM?=
 =?us-ascii?Q?K4HSwtmwikKJQA8F4ZyxFS17/jsxrtyEAZl9F1qijTK8aIUvEKF7QIKF6nEP?=
 =?us-ascii?Q?RJO2SPlfHUYvJkkJcZ4t0VCOPSL1E3+Feg0Gg8b/dOlOPt3Bu6ZNURXrbWsI?=
 =?us-ascii?Q?gsCFJxcxvSxC5d4T18Wl2BkunDKWjhfDjt8tMAJc5ZijO6YBRYHR0r65RDpx?=
 =?us-ascii?Q?O+eW+0hJOZvH55a4jzEgsNRvwNW2LpiolzdMOlMIxx3RjSOOA67ty4YXBMKC?=
 =?us-ascii?Q?6RpUC10MQPk8zTwWzmnGINjCPd/N4yH2p9tH94hCx6aztSMck2+kBmtm85rV?=
 =?us-ascii?Q?qQjCvo/5XGthjLGyow/l5KkNNzjtuhkbpN+8MAz5svw948SYbQ7slchyYB7z?=
 =?us-ascii?Q?Dflu3w0E5+INyF3zLfpnJ5pgU0jnACLSkXV09/hylqFz+OLwW5YpGtxJgogN?=
 =?us-ascii?Q?aq3BqZ600UNOcFZ7r8ajnDiNJNBJiVbmU+E2G4PEMSzPZzi6eI8cx5LmNQDH?=
 =?us-ascii?Q?gss+q3I6G9zGZ8WhjP8qoRPF+OdKknTiZMXaSwFXgeULmz2W1g4uSYTtn/jv?=
 =?us-ascii?Q?PMzLQzOJ+UCOBDvktSWFJPbwhBqwTQlqBDWJvCX2W0u+nC5hSo8nnVPzOyL+?=
 =?us-ascii?Q?2h+J67geeTUmwNweMM5b9RWZ1Qf9ALZ+sQ+KGXP257loRHk2u3FCV6n+j8NL?=
 =?us-ascii?Q?dp5I4CK3K7KOCU+jzpOX8s6uwVGtT/53m0eazM6viDGNVITCvD9l+Hyjf7cK?=
 =?us-ascii?Q?W9QF3lgLtU6hYkAYmsFm1MzSeQBpYi982JmP7pIFqxsHBPKydWmQhTqtr0gZ?=
 =?us-ascii?Q?K90/ffyhiY925WY4VawH9NbBdJzK/kvy66X1Ilib1ONdUIp8tTg6Z45DJ18b?=
 =?us-ascii?Q?t78ZqD2ItC5doWP1KFQ6EXGO5A/k2E0h6Eu267a3RHlK9Vl8N8/3COA3ywqv?=
 =?us-ascii?Q?8T1Y1x9pkaUArL7T8X2om48x1A+5zWz0I3lflNcKVV1XXbBIYswvLkllC4ao?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f7219e-07e5-4740-d704-08ddcb80c80a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:40:13.0662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJIEoUbXhkx1ARfH5QeG2Qhf2Cj+9SwDNVshGHSLUBo4rdvszWaeroSR7ViG1vrDxN4cfSb9d/B2kkwe7WHOtwC5Hcw7yNbpgme9ojGecFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
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

On Fri, Jul 25, 2025 at 12:49:06PM +0000, Ciara Loftus wrote:
> In the interest of simplicity, let the primary process select the Rx
> path to be used by all processes using the given device.
> 
> The many logs which report individual Rx path selections have been
> consolidated into one single log.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com

Couple of small comments inline below. In general LGTM,

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/ice/ice_ethdev.c |   2 +
>  drivers/net/intel/ice/ice_ethdev.h |  19 ++-
>  drivers/net/intel/ice/ice_rxtx.c   | 234 ++++++++++++-----------------
>  3 files changed, 113 insertions(+), 142 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 513777e372..a8c570026a 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3684,6 +3684,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
>  	ad->rx_bulk_alloc_allowed = true;
>  	ad->tx_simple_allowed = true;
>  
> +	ad->rx_func_type = ICE_RX_DEFAULT;
> +
>  	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
>  		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 8e5799f8b4..5fda814f06 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -191,6 +191,22 @@ enum pps_type {
>  	PPS_MAX,
>  };
>  
> +enum ice_rx_func_type {
> +	ICE_RX_DEFAULT,
> +	ICE_RX_BULK_ALLOC,
> +	ICE_RX_SCATTERED,
> +	ICE_RX_SSE,
> +	ICE_RX_AVX2,
> +	ICE_RX_AVX2_OFFLOAD,
> +	ICE_RX_SSE_SCATTERED,

SSE_SCATTERED should be immediately after SSE, I think.

> +	ICE_RX_AVX2_SCATTERED,
> +	ICE_RX_AVX2_SCATTERED_OFFLOAD,
> +	ICE_RX_AVX512,
> +	ICE_RX_AVX512_OFFLOAD,
> +	ICE_RX_AVX512_SCATTERED,
> +	ICE_RX_AVX512_SCATTERED_OFFLOAD,
> +};
> +
>  struct ice_adapter;
>  
>  /**
> @@ -637,6 +653,7 @@ struct ice_adapter {
>  	bool rx_vec_allowed;
>  	bool tx_vec_allowed;
>  	bool tx_simple_allowed;
> +	enum ice_rx_func_type rx_func_type;
>  	/* ptype mapping table */
>  	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[ICE_MAX_PKT_TYPE];
>  	bool is_safe_mode;
> @@ -658,8 +675,6 @@ struct ice_adapter {
>  	unsigned long disabled_engine_mask;
>  	struct ice_parser *psr;
>  	/* used only on X86, zero on other Archs */
> -	bool rx_use_avx2;
> -	bool rx_use_avx512;
>  	bool tx_use_avx2;
>  	bool tx_use_avx512;
>  	bool rx_vec_offload_support;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index da508592aa..85832d95a3 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3662,181 +3662,135 @@ ice_xmit_pkts_simple(void *tx_queue,
>  	return nb_tx;
>  }
>  
> +static const struct {
> +	eth_rx_burst_t pkt_burst;
> +	const char *info;
> +} ice_rx_burst_infos[] = {
> +	[ICE_RX_SCATTERED] = { ice_recv_scattered_pkts, "Scalar Scattered" },
> +	[ICE_RX_BULK_ALLOC] = { ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
> +	[ICE_RX_DEFAULT] = { ice_recv_pkts, "Scalar" },
> +#ifdef RTE_ARCH_X86
> +#ifdef CC_AVX512_SUPPORT
> +	[ICE_RX_AVX512_SCATTERED] = {
> +		ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
> +	[ICE_RX_AVX512_SCATTERED_OFFLOAD] = {
> +		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered" },
> +	[ICE_RX_AVX512] = { ice_recv_pkts_vec_avx512, "Vector AVX512" },
> +	[ICE_RX_AVX512_OFFLOAD] = { ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512" },
> +#endif
> +	[ICE_RX_AVX2_SCATTERED] = { ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
> +	[ICE_RX_AVX2_SCATTERED_OFFLOAD] = {
> +		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered" },
> +	[ICE_RX_AVX2] = { ice_recv_pkts_vec_avx2, "Vector AVX2" },
> +	[ICE_RX_AVX2_OFFLOAD] = { ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2" },
> +	[ICE_RX_SSE_SCATTERED] = { ice_recv_scattered_pkts_vec, "Vector SSE Scattered" },
> +	[ICE_RX_SSE] = { ice_recv_pkts_vec, "Vector SSE" },
> +#endif
> +};

Minor nit, but can we have the entries here in a defined order? Probably
best to use the order of the enum, which seems pretty logically arranged
from simplest to most complex (more or less).

> +
>  void __rte_cold
>  ice_set_rx_function(struct rte_eth_dev *dev)
>  {
>  	PMD_INIT_FUNC_TRACE();
>  	struct ice_adapter *ad =
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +
> +	/* The primary process selects the rx path for all processes. */
> +	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
> +		goto out;
> +
>  #ifdef RTE_ARCH_X86
>  	struct ci_rx_queue *rxq;
>  	int i;
>  	int rx_check_ret = -1;
> -
> -	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> -		ad->rx_use_avx512 = false;
> -		ad->rx_use_avx2 = false;
> -		rx_check_ret = ice_rx_vec_dev_check(dev);
> -		if (ad->ptp_ena)
> -			rx_check_ret = -1;
> -		ad->rx_vec_offload_support =
> -				(rx_check_ret == ICE_VECTOR_OFFLOAD_PATH);
> -		if (rx_check_ret >= 0 && ad->rx_bulk_alloc_allowed &&
> -		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
> -			ad->rx_vec_allowed = true;
> -			for (i = 0; i < dev->data->nb_rx_queues; i++) {
> -				rxq = dev->data->rx_queues[i];
> -				if (rxq && ice_rxq_vec_setup(rxq)) {
> -					ad->rx_vec_allowed = false;
> -					break;
> -				}
> +	bool rx_use_avx512 = false, rx_use_avx2 = false;
> +
> +	rx_check_ret = ice_rx_vec_dev_check(dev);
> +	if (ad->ptp_ena)
> +		rx_check_ret = -1;
> +	ad->rx_vec_offload_support =
> +			(rx_check_ret == ICE_VECTOR_OFFLOAD_PATH);
> +	if (rx_check_ret >= 0 && ad->rx_bulk_alloc_allowed &&
> +			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
> +		ad->rx_vec_allowed = true;
> +		for (i = 0; i < dev->data->nb_rx_queues; i++) {
> +			rxq = dev->data->rx_queues[i];
> +			if (rxq && ice_rxq_vec_setup(rxq)) {
> +				ad->rx_vec_allowed = false;
> +				break;
>  			}
> +		}
>  
> -			if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
> -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
> +		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
> +				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> +				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
>  #ifdef CC_AVX512_SUPPORT
> -				ad->rx_use_avx512 = true;
> +			rx_use_avx512 = true;
>  #else
> -			PMD_DRV_LOG(NOTICE,
> -				"AVX512 is not supported in build env");
> +		PMD_DRV_LOG(NOTICE,
> +			"AVX512 is not supported in build env");
>  #endif
> -			if (!ad->rx_use_avx512 &&
> -			(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
> -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
> -			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> -				ad->rx_use_avx2 = true;
> -
> -		} else {
> -			ad->rx_vec_allowed = false;
> -		}
> +		if (!rx_use_avx512 &&
> +				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
> +				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&

Not sure if this is fixed later in the series, but should not need to check
for AVX512 when deciding whether or not to choose an AVX2 path. If AVX512
is present, AVX2 will be also, so the AVX2 check is sufficient.

> +				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
> +			rx_use_avx2 = true;
> +	} else {
> +		ad->rx_vec_allowed = false;
>  	}
>  
>  	if (ad->rx_vec_allowed) {
>  		if (dev->data->scattered_rx) {
> -			if (ad->rx_use_avx512) {
> +			if (rx_use_avx512) {
>  #ifdef CC_AVX512_SUPPORT
> -				if (ad->rx_vec_offload_support) {
> -					PMD_DRV_LOG(NOTICE,
> -						"Using AVX512 OFFLOAD Vector Scattered Rx (port %d).",
> -						dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_scattered_pkts_vec_avx512_offload;
> -				} else {
> -					PMD_DRV_LOG(NOTICE,
> -						"Using AVX512 Vector Scattered Rx (port %d).",
> -						dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_scattered_pkts_vec_avx512;
> -				}
> +				if (ad->rx_vec_offload_support)
> +					ad->rx_func_type = ICE_RX_AVX512_SCATTERED_OFFLOAD;
> +				else
> +					ad->rx_func_type = ICE_RX_AVX512_SCATTERED;
>  #endif
> -			} else if (ad->rx_use_avx2) {
> -				if (ad->rx_vec_offload_support) {
> -					PMD_DRV_LOG(NOTICE,
> -						    "Using AVX2 OFFLOAD Vector Scattered Rx (port %d).",
> -						    dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_scattered_pkts_vec_avx2_offload;
> -				} else {
> -					PMD_DRV_LOG(NOTICE,
> -						    "Using AVX2 Vector Scattered Rx (port %d).",
> -						    dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_scattered_pkts_vec_avx2;
> -				}
> +			} else if (rx_use_avx2) {
> +				if (ad->rx_vec_offload_support)
> +					ad->rx_func_type = ICE_RX_AVX2_SCATTERED_OFFLOAD;
> +				else
> +					ad->rx_func_type = ICE_RX_AVX2_SCATTERED;
>  			} else {
> -				PMD_DRV_LOG(DEBUG,
> -					"Using Vector Scattered Rx (port %d).",
> -					dev->data->port_id);
> -				dev->rx_pkt_burst = ice_recv_scattered_pkts_vec;
> +				ad->rx_func_type = ICE_RX_SSE_SCATTERED;
>  			}
>  		} else {
> -			if (ad->rx_use_avx512) {
> +			if (rx_use_avx512) {
>  #ifdef CC_AVX512_SUPPORT
> -				if (ad->rx_vec_offload_support) {
> -					PMD_DRV_LOG(NOTICE,
> -						"Using AVX512 OFFLOAD Vector Rx (port %d).",
> -						dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_pkts_vec_avx512_offload;
> -				} else {
> -					PMD_DRV_LOG(NOTICE,
> -						"Using AVX512 Vector Rx (port %d).",
> -						dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_pkts_vec_avx512;
> -				}
> +				if (ad->rx_vec_offload_support)
> +					ad->rx_func_type = ICE_RX_AVX512_OFFLOAD;
> +				else
> +					ad->rx_func_type = ICE_RX_AVX512;
>  #endif
> -			} else if (ad->rx_use_avx2) {
> -				if (ad->rx_vec_offload_support) {
> -					PMD_DRV_LOG(NOTICE,
> -						    "Using AVX2 OFFLOAD Vector Rx (port %d).",
> -						    dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_pkts_vec_avx2_offload;
> -				} else {
> -					PMD_DRV_LOG(NOTICE,
> -						    "Using AVX2 Vector Rx (port %d).",
> -						    dev->data->port_id);
> -					dev->rx_pkt_burst =
> -						ice_recv_pkts_vec_avx2;
> -				}
> +			} else if (rx_use_avx2) {
> +				if (ad->rx_vec_offload_support)
> +					ad->rx_func_type = ICE_RX_AVX2_OFFLOAD;
> +				else
> +					ad->rx_func_type = ICE_RX_AVX2;
>  			} else {
> -				PMD_DRV_LOG(DEBUG,
> -					"Using Vector Rx (port %d).",
> -					dev->data->port_id);
> -				dev->rx_pkt_burst = ice_recv_pkts_vec;
> +				ad->rx_func_type = ICE_RX_SSE;
>  			}
>  		}
> -		return;
> +		goto out;
>  	}
>  
>  #endif
>  
> -	if (dev->data->scattered_rx) {
> +	if (dev->data->scattered_rx)
>  		/* Set the non-LRO scattered function */
> -		PMD_INIT_LOG(DEBUG,
> -			     "Using a Scattered function on port %d.",
> -			     dev->data->port_id);
> -		dev->rx_pkt_burst = ice_recv_scattered_pkts;
> -	} else if (ad->rx_bulk_alloc_allowed) {
> -		PMD_INIT_LOG(DEBUG,
> -			     "Rx Burst Bulk Alloc Preconditions are "
> -			     "satisfied. Rx Burst Bulk Alloc function "
> -			     "will be used on port %d.",
> -			     dev->data->port_id);
> -		dev->rx_pkt_burst = ice_recv_pkts_bulk_alloc;
> -	} else {
> -		PMD_INIT_LOG(DEBUG,
> -			     "Rx Burst Bulk Alloc Preconditions are not "
> -			     "satisfied, Normal Rx will be used on port %d.",
> -			     dev->data->port_id);
> -		dev->rx_pkt_burst = ice_recv_pkts;
> -	}
> -}
> +		ad->rx_func_type = ICE_RX_SCATTERED;
> +	else if (ad->rx_bulk_alloc_allowed)
> +		ad->rx_func_type = ICE_RX_BULK_ALLOC;
> +	else
> +		ad->rx_func_type = ICE_RX_DEFAULT;
>  
> -static const struct {
> -	eth_rx_burst_t pkt_burst;
> -	const char *info;
> -} ice_rx_burst_infos[] = {
> -	{ ice_recv_scattered_pkts,          "Scalar Scattered" },
> -	{ ice_recv_pkts_bulk_alloc,         "Scalar Bulk Alloc" },
> -	{ ice_recv_pkts,                    "Scalar" },
> -#ifdef RTE_ARCH_X86
> -#ifdef CC_AVX512_SUPPORT
> -	{ ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
> -	{ ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered" },
> -	{ ice_recv_pkts_vec_avx512,           "Vector AVX512" },
> -	{ ice_recv_pkts_vec_avx512_offload,   "Offload Vector AVX512" },
> -#endif
> -	{ ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
> -	{ ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered" },
> -	{ ice_recv_pkts_vec_avx2,           "Vector AVX2" },
> -	{ ice_recv_pkts_vec_avx2_offload,   "Offload Vector AVX2" },
> -	{ ice_recv_scattered_pkts_vec,      "Vector SSE Scattered" },
> -	{ ice_recv_pkts_vec,                "Vector SSE" },
> -#endif
> -};
> +out:
> +	dev->rx_pkt_burst = ice_rx_burst_infos[ad->rx_func_type].pkt_burst;
> +	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
> +		ice_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
> +}
>  
>  int
>  ice_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
> -- 
> 2.34.1
> 

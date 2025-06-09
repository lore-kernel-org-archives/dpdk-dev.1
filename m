Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E05C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 13:39:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 748AE40EE7;
	Mon,  9 Jun 2025 15:39:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id B1D4840EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 15:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749476351; x=1781012351;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uIUmAl3Inmylv+mp1sAqZsAdnkdsNxHypghfw1+GvZ4=;
 b=YwnRR0U86d+WGCVrTralEnsr6yPVcYHRWXYc9+8a1HuvGiNiDw1oWdpT
 eIZ0Trwy9H0i0zoVLRxuebzlvu8V4VdezuWeqMT6o6sB+0P8GVJuSuwWb
 7w74Deg++f70SEi3bzV583r7B2IVDF9u0F8e/DYi1y641kf6LspfT9hoY
 nJbj9Ywf6pyJJHxX9jiLlK6dXoBla7WcZSMQzwZp0bX/dUyJ2lN5Y1ZDm
 x/3e7aRIz5RQBG45xvtO2adt5WWStIvEdbti3F0g3RcJ4RRqDT7+CSbu1
 lYfQUuqbL2YRo3ufH+LWHfAEBamUh/dseah0oxk4wz6VHKqoyNT7ewHdi A==;
X-CSE-ConnectionGUID: l+tytdO1Qk+574Qg67jjdg==
X-CSE-MsgGUID: +t0ZTbVvSa+zLAmK/D+Jjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="74085824"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="74085824"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 06:39:10 -0700
X-CSE-ConnectionGUID: WpX8BpbgQES70DhK/KpFTA==
X-CSE-MsgGUID: oLidsfr2STCFrVuq35rGDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="150345281"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 06:39:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 06:39:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 06:39:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 06:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiUxmCRlq3VIBOoLSIgdAGQYREsdh30kgiMjjF22tnjLy710TWwlaUPBpvFDdlePhcRz4B8Bri52CgQl8uBSMFHAIJgDwirRUILrKyWIrjeM2NO8h2rATlGgekVUhluVyNiKhr9dURp82QRs8BXw9pRH/0dUcZhCx1OqRPdarH6MEHOV3hkzXxKBrcUXNMW+WvyXGOiRyDALvAtWNw48c4BQjJ+z4dQhX4RTDOA3HMvWJvWspi3ONdje3Td9vrbEAQ9wU1ijr9jB3N9nA2bM7rEEojll8nfEHQkRDJ0wfyeKPgu7Z/v2zYlLoVHdujtIaSbroNNqroUXCCro6+0PBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY2fcTOfh22HJgp/K8jYgAsqo6Sntcit5DADsus8oW8=;
 b=FLwjl/rGNPmHj39aXj7Ln05sYZNOAbj7hAUoOUCV/0Ma2Rr3AJj+Bu2PzOAZ2q2u8TYvy/iJFbHLRuKumCbDCwKrD+M5xP6Z9bxp6ubag6hQRHxqBc6a868HYMUoSr+0n94/3vaMexxd0/gzIf41ykhkdG6diOzh2UK2NQHJZBs3NW3zcayp3wFNRJFEy1QRwD2pi/WiQQxl2j2PA2DetWmKNKX6/IPIinUo1IL86FSAZxM0jGdFny9BfNWYdkOZIIm7rkco87tHONZdStoeCH4ugtkYXKd+2mD0XGr3Gu0URFqI9yhhzyCRtNHJaYdv6/GkIY9Gk8VqruiVziWMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9063.namprd11.prod.outlook.com (2603:10b6:208:57d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.24; Mon, 9 Jun
 2025 13:38:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 13:38:52 +0000
Date: Mon, 9 Jun 2025 14:38:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 6/6] doc: announce TxPP support for E830 adapters
Message-ID: <aEbj57r4yvh8RWjQ@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-7-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250608113223.487043-7-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2PR04CA0338.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: e7581f57-d3d6-4c5f-590f-08dda75af8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M7tW59OueKLKaR1BihSJ0M6rvHrsbRyoVINX/1Dq/1Vww32HboOMgTWH0Puv?=
 =?us-ascii?Q?1lOA6t18lYxRV/+lOG4yk6UxEJfX+u6F5fHJN+h8JtSosfPHXmAyBIOKrvH1?=
 =?us-ascii?Q?ZEe8tIMXgH++KF6jd+cyVG5GrHDBK90jYcxByOOGLB45N8/3oMdNqKlIoIIL?=
 =?us-ascii?Q?wNIJkbPWuPFqzTUyGknv2QZ0OSkd5gcAP/lKuprI7TCLm+UVMmPyYjRa0U3h?=
 =?us-ascii?Q?cGqo2zHh1jGQavbRBi+lOE7tpDcVvxpZ8VbJDlAdVUwiMaeZeYxg2JpFIdg0?=
 =?us-ascii?Q?9pkStdw9F2OxRL2R48JtrtvrYArwiRK7tv3L51MCNzZND1qe//wWuC0V7kkW?=
 =?us-ascii?Q?IJfpaCVagTeW+gXEfrF+ECL5Zk9zLpt7XvzphLHz4AM1G9p6S/f8nkJtPd1n?=
 =?us-ascii?Q?ZZFEomhFAuU+7NgtQCw4tUC27uKlitydipiieTlsjFyVL06YFFn9VNT6sD5p?=
 =?us-ascii?Q?A465c0JjUdGfEjMNSjqMq+4W3LcyAJc5EX5EC4b41CO3yBtmBaNfQYqVBrIW?=
 =?us-ascii?Q?T9GqGeU6/JYNTLMkTx7PdCmESW8P+hxnB5bWOs5S/oMG2cnMUMb/lRB9w5dQ?=
 =?us-ascii?Q?lTXQnzhzsm+PxRiN4HnixD2bkaIN5gwfmw3X1u/2fzzF4XNsjPKx3OJHXGuM?=
 =?us-ascii?Q?o2nfKgwyRwba2G4NOEDBbz77V1xal+FVnXijW245QviPCZFWxn5fmHaFuV7W?=
 =?us-ascii?Q?Sptn/YzfGtJaEx20H6lRcHCLuVDdNjU2u82gtmfeoQVHa/jIcBxGDij4krwh?=
 =?us-ascii?Q?ALxq4CpAJ1++XtlrQ1MaMENLtF6MK5d+dGzBEZm3h5FPyb2vtC7qIqPv6kmR?=
 =?us-ascii?Q?/n5vSWZn6XtwrEP01EESLZe264SfFVP+XyKpLelEf1G3N96kKX44hDlvTzAe?=
 =?us-ascii?Q?zMByW2bOUPWBngcrqDYPK6HU+sEqEEyzGaxz68bHlVvGI8cjYua+mEzQ4FJC?=
 =?us-ascii?Q?WmTxMF/A5DF2yhbNpcPJ6pcjlzRkI5R1kGJbcyn4Q22Q9yJaO1PSgFIl7FTL?=
 =?us-ascii?Q?60SVJxwKERLLclMQ1rTZEu3/KbL/lXy+D4H4RBleOw+ITt903Vidg7w1xPGr?=
 =?us-ascii?Q?X2UeJAjBA/Sl44k4uAMM4ChR6DoZb1AtnkH85WbPYFi5xJpSCCTHPEJ/Rgl8?=
 =?us-ascii?Q?HgPfJWZbnt1eygbhoXJifNZuxbs4Zr1C2FiE6hr12KHNuAtNcPcRDmETC2o+?=
 =?us-ascii?Q?e2YMZecbxFL1z5Um5LFCuSpT+WtghJh28liZPn3TDxoQ16R4NbRCqizItOT7?=
 =?us-ascii?Q?nbZ7PRiygOuPS6QiCGzewPZkGhHncYKvBZBUjKCvi+ttvG6ClGVisDYG2cu3?=
 =?us-ascii?Q?cMCP7dqhokZSsTPS+U37TRRTfqBoRpYyV2C8IyrrLUfXZx0fR3tOb6JPGGt8?=
 =?us-ascii?Q?2R+T/3twBqc/Gmc+weMxIl9RtK3HumMfye9Hem2O0VjbphQdsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mWhz2GJ5JKAdh3lyZIhNz48z1+3BCJQ0gAW7fBFk2ggOvGlbWUN/G8gwKXPE?=
 =?us-ascii?Q?aUmJlSQSIFamhDZUHdSAgIE4B+/MpRZPQpQpdeYE8dPAii+EV3C8eq1E7syq?=
 =?us-ascii?Q?toqH8uZT7649ls0vUrpjceea2m9INko5mmlOjM5NZDGmLk0ixpDB8URiG65s?=
 =?us-ascii?Q?XHt/CWSz+H1zF7NzQ+Aweu+o8xpoKs/V31VikjOOymXAOnQJCAbdx3TX/Ede?=
 =?us-ascii?Q?ck+4EDdPV5GyXuMLzF8AQ56AQmW0H0U073toHbzOvfveWCubF63tg3T/DcJ+?=
 =?us-ascii?Q?/4FKlPVc8LZuOh6njwuGQm0EwDjxmrxKh9bfdOVs08foaOOmr17XjRkvJ736?=
 =?us-ascii?Q?Wc30C3l4sJnZalYW+kcjYVPGeLOaGkocgUeExScEVeBTW1kTnt/xEXkAXZDn?=
 =?us-ascii?Q?SdgESkg2v4IQCro7nxxz6zVnqPAWa+dMGT6bpZ6HPzXiIOyqTIpPPxxb4ApQ?=
 =?us-ascii?Q?ulBUmtGsHk/7AgMgRflxhYWLzSMBUQ5oOIB2v9xXnoR4KFQosnbjsBz1JygO?=
 =?us-ascii?Q?AnDL7MWPt/ICTctAYXykYUdExGKrZKDZbHbhjrDBdv33hSoNiiy6Xree4bIU?=
 =?us-ascii?Q?ySlrnJ73cBXzGDDX757cM9iMFcka4eOwt/30YdwyJy0aJlif1LiY4dcwQsA4?=
 =?us-ascii?Q?wuwyS6Xj2Jiu0JprWKHho5x15SWEfyIYDVqFyE5gmnMOiRu1NOYCsZIOxs1U?=
 =?us-ascii?Q?udfL7QWIuy9fsNWovM9y9lBDWC0guM86V8tri9QVdJdzEOzG+4F27A8E9En2?=
 =?us-ascii?Q?a3FD91TdNH5qOh9Cl3xzd+LaaEv4k/d6gfN/jXzrOggYe6++dm2CbgalUiby?=
 =?us-ascii?Q?v6YpeLNBPEPsqivq6M/k0kWTFdFHuJNDWEqxT/CmaDL0x8+CO/K6IPih5nO5?=
 =?us-ascii?Q?rpDo+HenkrEqp7QPBHcU826O1z2fAa0wPrMFpPZSxTOcIrMk41huOqXKv2Hl?=
 =?us-ascii?Q?6PMCnfcoj6tYRqCszMwk/EPvDx/fyNqrygv5UNeZ5VqIvQpXmkDaQH537mJ+?=
 =?us-ascii?Q?IwYB+KAkUVf4gs640mPGk/PU/PdninYJaTDnNNjePgcazcRqMHctbkzyy+Ge?=
 =?us-ascii?Q?M4I+LH4mfEdgq6gZB9Ks9IGx1gjk+WYHk+jchj4mLpj/yPERak6tJKtVUOI6?=
 =?us-ascii?Q?Hkn5v6uMF7+jvKl1yGFY2QenpXhRVCyQGnaphMbutsFyW4+vvCnleMVicoLq?=
 =?us-ascii?Q?M+kNg3WLENrLIgu/hmTFUrKrWDLFQGDnccLttO+LAbDJaMcRgh5nhUfWq7d8?=
 =?us-ascii?Q?OHh3mqRQA94I/x+ZKtSVabPcmiI9n+AvnjcBODgLzW04FzUix+KwfV+4tu03?=
 =?us-ascii?Q?ZCD3eWtWAfHBzcDDVg2p5vA3+JsBMKVrrEarXwSZIz9JC46W7kCKJ/2+1Jc+?=
 =?us-ascii?Q?bKSV3WTu4vIrIougIf/YEO/tpTH/0JMzWg/vvNiq25I77jOXrlPz35jlcv8Z?=
 =?us-ascii?Q?qqwzUPJNIT8DebiNoFMqFUqrb9DGviP/B6sODLbBqzULoCKBZjXMZmZ+hlXK?=
 =?us-ascii?Q?v6vxF/i3mq2P/sYbYkgBvJueg80Dd/PS2iC1acO3CTsw60+ffCprH3fwdsk/?=
 =?us-ascii?Q?6QxZtmUQJLFzh8OnsL3hMxo8hf9SOMcgSNSdjurCSihGLKnjqUAh6x/AdFjy?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7581f57-d3d6-4c5f-590f-08dda75af8da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 13:38:52.3171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYplT2JcFiDnlaluS+FQxDudaSPaZjjOvscS8sKElqUdYmNE2HO2OlahHo8oROj8iqkIKkZ7/Tg/fUFf/7u3vgwSjtejAyYwaplgEuti2jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9063
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

On Sun, Jun 08, 2025 at 11:32:23AM +0000, Soumyadeep Hore wrote:
> E830 adapters currently support Tx Time based queues.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  doc/guides/nics/ice.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 77985ae5a2..73c5477946 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -415,6 +415,22 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
>  
>     examples/dpdk-ptpclient -c f -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
>  
> +Tx Packet Pacing
> +~~~~~~~~~~~~~~~~
> +
> +In order to deliver the timestamp with every packet, a special type of Tx Host Queue is
> +used, the TS Queue. This feature is currently supported only in E830 adapters.
> +
> +The tx_offload ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
> +For example:
> +
> +.. code-block:: console
> +
> +   dpdk-testpmd -a 0000:31:00.0 -c f -n 4 -- -i --tx-offloads=0x200000
> +   set fwd txonly
> +   set txtimes 30000000,1000000
> +   start
> +

These commands need more explanation. Particularly the "set txtimes" one.
What do the values given as parameters actually mean?

>  Generic Flow Support
>  ~~~~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.43.0
> 

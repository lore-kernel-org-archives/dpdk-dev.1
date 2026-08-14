Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C3C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 11:26:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D991D4013F;
	Fri, 14 Aug 2026 13:26:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C9E97400D5;
 Fri, 14 Aug 2026 13:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786706800; x=1818242800;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J0eN6DGaIDuktOUr1k6qCgQJJQE/Ydz0pPL3ngjDpp0=;
 b=WLBTQww7neDUEa0lZn4aR2XGFGQPwWJeqs8VwOVxwYKHJeSFeQVBSlON
 6qQLgVWVMnCq24/kyhdIm2ciYRxoOJ/v+YzScg543BskncpnBY10cBqTe
 4H5Po51Hygikr8/x3e9sApnYU3jxFWV9r2u1l2SJQsqZRX6xthyXxBzbe
 GmN6Cmz+2qcnLzBnPMj8Y50k4+j8ul4JxpNNAVuRQANA85nx4Q6DF7UxO
 fIHfOCWKOjpZWqCEKNOY9Tp16kwG5fWuMDJMQ56s/v4STjatFY3VBo6Vc
 jYrBGTwuWdtAQr2BOdiMkDHOovDsxrrFOJgwizdZGNZAIQ9loI5tmXDHT A==;
X-CSE-ConnectionGUID: JqJStu6bQYC3kf0qW+qzGA==
X-CSE-MsgGUID: sM4/RfMNTtOoWwPw4siCOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87307606"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87307606"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:26:39 -0700
X-CSE-ConnectionGUID: qfLQjZg1T9S0z9UcPLUVbg==
X-CSE-MsgGUID: R4x83ftFQEChOCZsgiriig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="294136343"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:26:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:26:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 04:26:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:26:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6Spt4O6HH5DTMzhqbNy7ruFMoxvlsJn9MiSWXP9TfFQOzwt2ZiSJAxaEbcJukedFy6YOkWnwjYS2NHrhZusKlNlHZ+u2V50HDRUQD3xhUGQbsshnp3Ugqv7GWKuSR9F1Cb9zYl3O32XNks1+FTRtaIJSDc8ULeK0RKt3fRMEpApaD2UGg+3ZO8K5HznbMOhB+bcy1pwicHaKSathhZEDGSVXW2CaVZwgukuUdGN1R9yydVhUevkDagVv9MMXjoO2xib1E5GF6zgPS15NFvq0CY/f+5vn4OE3FevmKJYq2+eBMhXtSCJNUj1S+leZ0KnrGKD/ym6vVe/OzRSp283Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecgxg0QqBuoLN2rOZFYGtQYWbNe5V/ZfZrUH9ZtL3jI=;
 b=Xuhnxg8O6wMSCXgY9fJWjU5EA8YI7tX+RkaluXVkP5FbNH6eKYlPuIN1W0QntTnWWm4NlXUgGG+Zz1RQmQOtzQwC53u0xu23o9Fa/HPW4SwZH5Dl4Dfe0cSx76m1Mvhi/ojPvQtwOpcXwrOi1h1z+vrPHWx5mrQINnEQE0cRh6j9sOJmOyJJTBg4P7zlwJ3209DJXpzwsESEMvPFO7VbVkqVKduM8Lc5xXOoG6I8Hh+BvGPiX6d8Ll3nSuVF7zYAm5IuKST0s0VdCIV9AaqOT4hYdX7B6f/iuK0gQmvJ1wT6AqIc9fu+snv6aS0XrgjEQbJU8TwLWTK3B4EqqmpzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ5PPF8A49C4DF4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 11:26:34 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:26:34 +0000
Date: Fri, 14 Aug 2026 12:26:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 2/2] net/i40e: program default RSS RETA at port configure
Message-ID: <an77ZirXbg7LUp9i@bricha3-mobl1.ger.corp.intel.com>
References: <20260812143844.71339-1-ciara.loftus@intel.com>
 <20260812143844.71339-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812143844.71339-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8PR06CA0045.eurprd06.prod.outlook.com
 (2603:10a6:10:120::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ5PPF8A49C4DF4:EE_
X-MS-Office365-Filtering-Correlation-Id: 97244263-1068-4ad6-3dec-08def9f6e5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mvrm6waX5I7zu8ELJAcHAONOdVEpIDaM6FKkQmraFC/AUxjS2pODpkKxsDPY7dOWmtPPdhsLm2arId+N1Pd0aJ788VElcwlvLgfFs1ThTS9nxRLUtmn3sFHCtQnqShJlR5Cg53W6iBwfb3z68ULEY/cnm/Ey458/4TjhVQFXVBLOvw/l9wvPE53/jC55lmNEPO/Xa56kbZ6Yl9KEaSOUU3MeInNhL+hSV6zIj75TV4kcTJN1gfYu9tYpNWj8HFh1cluBqN9cRdbKg4bvRYOJ1BLemsrOgnEgMdLq1NwXxm7feywi/EDdNgceE5Xj7R2BDNxws/lkoQIsKr2L5XD54LPMIHf2UAcqLGtMZEfmBansqLMeECvSXqOeZzbhY2vOw07ICw01Q7aMZg7vlouhPA/PUyeX0TN+A/rK/HKehQCTB1MrUddiYZop8JjXz3q53P8BRSHmxi7V+AkaX9hWS/cAycojTD+i7PMmpCwSwSeRWWf+XxcRbMN9f1CNUsHW3wVPBZSe+GlHseWMCDEIR9u9JbJ0rwM1RPT5QjhFsetbCfQVNYUz/5LTuNcWFITuaQ9BHKgBU9MdcERz/iXQYJz/Ayqifcb+b3eoq0o7Dts82qVT8iUdjhovPeHqz5yX30+G4G94iB+vyFWI8dJuQfWsUmnLL69Eib4prTSA7Rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhfFSxiacsAGqduWsUYipmw7wdQc5FS0JwidIr3ldzRsP6TzKcEgJqtnzrJI?=
 =?us-ascii?Q?i5WF12b00YOgVzX+bXuH4kCowdR+J2wdKsJDcSYe//zRQJMA7nX8ohQeA6BU?=
 =?us-ascii?Q?FXAkm68GcauBujJ5lbWoK7sJRJN7e55gTT3NpwEZROnPhOhsposAUY2hNmxX?=
 =?us-ascii?Q?ME80byo1b27Jt5NLasIkfuOHD3Rs9oOo4RtMjOSyPfprejo7PyGcLq+rAgwz?=
 =?us-ascii?Q?yI8GRmxmuM3RMxuH7GENUusqw+qu51mYcc5yXVHe2NSRVunJm+lrRZzmB8Tq?=
 =?us-ascii?Q?H3Mv7MXL4n+aDaVOt6B09hry8yIQ5uRGL1dR3ZM2ZiWxqQYT2PTz3g/uNzp3?=
 =?us-ascii?Q?/yxjNo9kmBTvP+SCYoEPYgJJRXfCjlUSWR03m0mV9Tmv/MMlPlnd9vyAyFi1?=
 =?us-ascii?Q?StzzkWJP+W+srSopnKrC7SN3oXOPoKtjf4sxBLL1kPMrLhTz+2m3/aeKTjjg?=
 =?us-ascii?Q?IvzFQB+nk7WqIp/hfz7iZrVc4uK25kVoIiZHaAXyVixvvDQqV9aDIcseuF+a?=
 =?us-ascii?Q?4qG/tZ4Vj0XN60myDst68W8JW74ycFq32orMvBVqupYcfJzcDW7HuCIPltdo?=
 =?us-ascii?Q?fQo9upOb9HelIsQuLGuZAfMWwsXbqRAY2EKIFOPoIODqXvHRGRSAqxNziWJh?=
 =?us-ascii?Q?xcftDCIHBPEzRfQs+lCb7sKZAGTDYb5cxWwnZsSFp6JtD/8XCQSBm7/E101Z?=
 =?us-ascii?Q?0SR198aAgSezM0BjRvQCWXcpPHVmE3Ir9gtFX94AtVuvpDXjl8Z8f+Lb6RoZ?=
 =?us-ascii?Q?/SlU8Aok8CW4Ui15PcaogLbJq8+LOAKOFt5kpbWtSzmXz3aB2ehOSwQRMN4f?=
 =?us-ascii?Q?CPmreOtibyYA4y+tykTzEciG5yHKAlyLpz1PFviZH2hjuYBJ7dYgqn5kdf31?=
 =?us-ascii?Q?xwweM+maZ2LWaPZ6MlXmfv1IlSxnmmnrqwXzLPBubQrgjkK+xdWJ4gCrjQaP?=
 =?us-ascii?Q?vg98gcfhm8K1qLlpekIZNXI2f/HdZTTNmsnXLmVF4fVOdpLaAXyqc58ZN628?=
 =?us-ascii?Q?uNiYQ+B8y67zVTkLCRQYRclByB6EivbfTdzoHYf978EG4ZCwbiH/MS8kbpqT?=
 =?us-ascii?Q?biNEEu8YwuQGHJciPjglIS8v1Jh3NDLjVvytcp6xtjAPhiOQA5Pf1n4oEoY8?=
 =?us-ascii?Q?osW0E/RtpIwqZwQLMwCGrEDl0bnn1wJ3aLR8O6pfUx+7IHO52dydue4Kvjgq?=
 =?us-ascii?Q?jgWwBtkheD0d8/MqnkHDYy6/vVGJSRWu+/D7ddieRmqtN5Td8Wl1SMg4zw4f?=
 =?us-ascii?Q?2m6R3FnTv7+xCpTwuwAMWG3NkObowk5kzEEXpXasPDpICeWNAuuQw+TQ4/jr?=
 =?us-ascii?Q?jeG2Ht44hh+GNYZl5X8wd4+zOqMvn9c9Kakrtpmt4UKQFBex83ksYj1LITo8?=
 =?us-ascii?Q?sKxIOpBNd7mYI2V+YTZV0Zzcbu23w9cYECD9RKz2LHuarQReejnmtK6ZYsz2?=
 =?us-ascii?Q?siW69xSdGcSpC8De9FrvZHWbl0NBb7ja5PLzwXGmCHXeAG/9jCgs+iP6NaGi?=
 =?us-ascii?Q?6ebJcACxwL/gSYiusi1YGsTcojeRI9LoWzgQtB++aklO2ecfR/q4AU84b4+I?=
 =?us-ascii?Q?Vy+0TdsvkFTFGlZ19TELVNJxXONqk1REV7Vyw1cLbayonLv8hGyAky7geC43?=
 =?us-ascii?Q?pz1c671wRyIigYrHtOSmW6o5p+MvdBim33/QMbrrUElIq9eum6zwc/dZlut8?=
 =?us-ascii?Q?TO4D/gwnZBcHZEwTvsdeg96nqZT1MmlJ0O8sdS9SAW6a1LDY8DbD3wYLTkqk?=
 =?us-ascii?Q?0DMMO0UTbm+HhMxuEL8rG/es51VjAfo=3D?=
X-Exchange-RoutingPolicyChecked: qjoX47i3GmzXGtsOy/IMJcLOa5atvk20Z1l4NocEcD90SP5Y/TWD0+OjuJ/whO5Y4+ZhIMLQSYou5GsCVxRATweKNSd6lnhn5d6HSJ3isuRnVfbiA/YvxMjR0MyUzWHmmIY/wlqypmGIyt4CBwaBRDCggAIrtIG798zu45YfLApSHhGIkjlG3srBCASjD41w1jL0ae5y239Z9Q88YXwa0W0OpxxsVBZ+XuNQwwa3DEw6rfVeczrVjZIbrkJwm14erVwHNUoeF5G0uIede/DX6o5QaY28hOHWQDZZ2MsVFYuQk7EbwnMNBqU2etU4sFJHXn3UCer5jvK6PYE3mfJO5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97244263-1068-4ad6-3dec-08def9f6e5b4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:26:34.6032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5DnWYdc8ADtD4+fIeMN5lw4bnphBaD9ZIpBbWFlNT/20LvCIJEef5ZeDo0wRTo7VeCBPexkDgkchjCGvTV3HRi+1VzBEAZoVhTnIqJ/d8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A49C4DF4
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

On Wed, Aug 12, 2026 at 02:38:44PM +0000, Ciara Loftus wrote:
> Currently the default RSS redirection table is only programmed
> when the port is started, in `i40e_dev_rx_init()`. Between
> `rte_eth_dev_configure()` and `rte_eth_dev_start()` the table holds a
> stale value, so querying it with `rte_eth_dev_rss_reta_query()` reports
> entries spread over the hardware default queue count instead of the
> number of Rx queues the port was just configured with.
> 
> Program the default table in `i40e_dev_configure()`, where the Rx queue
> count is already known, so a query before start reflects the configured
> queues. VMDQ queue counts aren't known until queue setup, so that case is
> still handled at start.
> 
> Fixes: 4861cde46116 ("i40e: new poll mode driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

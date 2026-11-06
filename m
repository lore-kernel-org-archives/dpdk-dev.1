Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76102606A332
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OP8uzw9f
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB6C942D72;
	Fri,  6 Nov 2026 12:54:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 9A70D402B8;
 Fri,  6 Nov 2026 12:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793966057; x=1825502057;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0zTeqQ+p1rEXJvuD/uf/BJDTk2mRMXdVSzSjad4BMxg=;
 b=OP8uzw9fXgDcsNRVcxfCWjM6ZTAfR05hHACUsZKfwqtVQwGrczrENO9G
 yMSNlEnE46wN4Q8mvrylX4hTk1gx9GLvizgeOCP3qJm4Hud9EQQzo+yRC
 eb6JwMLf6iQwQyoNIkQshdlqlv0XW+JB/uXZbnhsTTZjs2FUpMnWgFU6Y
 nm2od0BBjNFhTXxllOexNw7JnL83aGiz+9fUQs/uDrBWQen8CRuoaa61J
 BOMvLoWkNSixGX4PlbFvWB7qQ1owL7iqhyQmBxJkcljMi9qMxHR9SIv1S
 q3HgrX/zQ3/kpYvUO5Cf9vUjc+nCYtcNm7g2S3x0bUJXn3tLdXLbHj58F w==;
X-CSE-ConnectionGUID: seGYC18MT+y0k27VqwbPpQ==
X-CSE-MsgGUID: x01sRTB7TpqMKlPA4HVhrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2768372"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2768372"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:54:15 -0800
X-CSE-ConnectionGUID: kY3POGjqTNy0FZc7j+CvZQ==
X-CSE-MsgGUID: P0Ct/IhuRS+En2U50wrhjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7310595"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:54:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 03:54:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 03:54:14 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 03:54:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+wBhMCAeclwhUjmZ4bSt6YLGNAY8+PKg64nIhA+RoJ+o8VJF18SFTh/TdrQHzr0m46gqmDyygHj1pcR8qzpDFzz1GgqBxuNOjxAgdacX73FTAkKFmkAR/VIEjcAdmovpbTZjeyM5nk0wRCNPSEGVpNZT5rQR6Q8o8Df9QGc4AInEgam3pNc3ZxP9y/S6kdq3uzEvIPhTo6BVS8IqG70HejCTJbwgn4DSks32Mt15AwrAu5Vb1LSG9UwJykg7+EnhWxlgFcHqN5PZva87j8NARar4EpmdSzJpyvayRfvG6aLnCr3vHmk2Z90oFO4fuOXSNBb1CiQoAEWm7BscQiDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3hxfvj2txWnNxLR86DMeEW6r0IfO6NeYsSQffwFyS0=;
 b=U7K7WgZhO6RD7aJlhU2Cq+y5jZqNt9na/YZS/T4izYnR0e/GyGtdF4tMfEvNPtdQF7MqAZxQ4LChJqzEBfuId+S5AE4c6LUCzCVJVHk8mxIFeMb4Eq3rkJ1URxyUAsESTMNvc1Es7XumpO/qlo86lPY2XMwJk0luGrja02KI+t3yvgVKrZYNFMCeSwmXdFii2fkB5BdWOsDsqICpdnAh+AyTJ928YlQgjzPyM/Gnjgt0RSKZY4rwUQynv8rBWZ1Y3QwGrqMDar6+68qQM4Gup/OaIGsOipXIohBEZYGg9Bm/KDJ/3qUE9ZQtB636CW2+eTXSCA1XRMoZi9E0PHNiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPF691668CDD.namprd11.prod.outlook.com (2603:10b6:f:fc02::2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 11:54:12 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:54:12 +0000
Date: Fri, 6 Nov 2026 11:54:07 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 2/8] net/ice: fix DCF parent adapter init error path
Message-ID: <au2_37vxKg4IqdU7@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <dda5504f21585b9c6f4461323c6e11358703c47a.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dda5504f21585b9c6f4461323c6e11358703c47a.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0211.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPF691668CDD:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa3cc86-2e32-4779-8157-08df3bfcac4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022113327099003|56012099006|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: T3E/s9r2xcLB6d0eFCfIT+Q85XtUbOe0MewvK3SOQDU4XyIXChZsplrdvK41xyn7p27lN5+ySfYxOA+getnZyHDhrUhQFW9Q8+F5+ujgSJDBde2ohW/xEZB35IFvKSQl8nl2J/Tqh9i7YcFDMWy+vZzFZAqaVg6Ub4S+IoJ3Z4t8BhLUoPVQomBYXyLP8iY8XIa0N7YgxgjyKE97ykFVN31L54rlzxgYlKz23bRXdRQEAVe9YxTE1WiYo1/eCMkOO8taU9yHb5n1PDsfXSMNfQVfoFtuWEnLDDdoXdmYf1Urs84UloV99k+A6WSgIro94ARmwAvjD8O1hb8QvBA3YvGBhzuu2miyN5dlL3mpAr3SZCZz9HyENsxzOpa6x26OC6FFRcZQkmKh9A4OHCkrZHKBrUb5QQm3OChhxSByv9v/8gwJV/yWmHFDwERiNX2JsEffF2KNyyf2UyJSt8NW0lV8nkRePjaARV+gAOtz55IfPe5sXuAqf9Hz7tVgRjVu/Bps0hh6V/ADGZnrJQ/tfUS2TXdoFInLyP/JTEzx6nWhzAu7Xza87NhT/4jJLQUabXtMXMvqLK7bdQiXtennbAqx+xSrcPnZvgYXgm/MzAqKFuRk9j6pfiYc7aX5jTQHeEY+J7LrtdulROVmjDQY0oXOM+jyQOp9KEaVG7a7l4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022113327099003)(56012099006)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jt+wZutKnxKqqDBJ11b5LyBpd1rt7S/hIiERMlUr3WCOIohZDBK6R8ohIsWc?=
 =?us-ascii?Q?Jq/GZUyxXWLYcP6c4vGG/MddvQASIfcsXVnP+lTmyOy7WlXCtNGSS+JoZZVy?=
 =?us-ascii?Q?GiSZ8hjHeVAbzupNevHXQJyKCU4LDmOLh+BmRubcfOJyWxUJexj4Kz0TfwRZ?=
 =?us-ascii?Q?zP78zSeM7tc14dEOrXdCZjcsLA6S2wOWLjKjhMvx/+K83Kcdt1KV/4V+5I1Q?=
 =?us-ascii?Q?pmmhxnAftZFy2fEvRkF3nY4xQijjoi9NHqbk7ECEZeeK2+N2Xq+7Ep4lMqVD?=
 =?us-ascii?Q?ahfs2PhNIGAFMtjYi/vuLQcGN8Gx2pfX/rGX1WMVCaOCjlwX3u93AZ1kPc1/?=
 =?us-ascii?Q?YObtB6RcllGqkWnXVwjt5SdSb4+zC23Gi6e/gKlV6/WU5PAx7Ts8jd5m4IhF?=
 =?us-ascii?Q?kaqNyk3Qs+zqIPZZLY9wnvMnr+D+uNG+AE/VPrv2WRfXdkex8ph2DoN9Iv6w?=
 =?us-ascii?Q?YCT94r/2uJbIYEZRUGvmABaKQk/sBOdrWo48OvhR2WxJt2ff8YhBipSimU+5?=
 =?us-ascii?Q?91L9bzjpvuNA2yahMJU883N3XbgZtr6nnWNhCPGwpbi310r9H2X2u6OFWcMv?=
 =?us-ascii?Q?QBQSzKIYZuH8Xx/bm9UmXVKCgI1oRFYgXi/j8aS2ov4QJfp+nt/O0K9NHKBV?=
 =?us-ascii?Q?Ur1NdOCamgz0ecz5cTjflXuMaD8HIDe7RyzukGKM/jU34xjlrsA4g4I1esxA?=
 =?us-ascii?Q?UJytomhgYQus0OP0iuc0GUYZzr92jfNBJc2D86ZW11ut/+n55JVcbDhQDQQR?=
 =?us-ascii?Q?2CCZc0RHm0hqeQH2hueWZDOvttFTY93w0InRiUKRUq8PDsB+oMZO2ispl1R0?=
 =?us-ascii?Q?HxUiZHMhNSj2orBOyTXz4cpW3mO9v9Y48HhE4aRM2jxrebTDGoomdZxnDu+O?=
 =?us-ascii?Q?ue5b7pGfgFpNJyWP9uJu/jvOwpGXAT3ABUAAtZmMChOB4b9E0QObi/WAmEU2?=
 =?us-ascii?Q?LVV9zSeeDr1D+TicLyJEdLduWCvTNtBZTkIvzgoHxuJfRSYSbQZQm5thgNOp?=
 =?us-ascii?Q?+umIlCvPjlekD5Onz77XTzwY3pHIJYAKsRTmJyzY3/7QDU8vlZS/hT6pCtzv?=
 =?us-ascii?Q?63U5LSkjtRpg9Q8EE/l6qLbR3DEUSoeqWQ/hFEWhyZmu1ICuqpZaUzspFy1v?=
 =?us-ascii?Q?LtE+p2nbeWFe1psamgUP3oSyry8qfSHe+eDA2T1rF1lS/8pd6/RVzR3uHkip?=
 =?us-ascii?Q?qD0ymwMJahR5HGcPzyKZta3m8vK5J+Gcv3c2urjRInIszfMaFmlPStQvkjTO?=
 =?us-ascii?Q?c3ZBD7K+ugQjrF+iE/x4P38WbBDFGpPqkJ8kqmxHjPoX7THtfj8jqIzN15qN?=
 =?us-ascii?Q?HrzuApRKmLZBDtPHjhtQz+voQlactxfDLE0YJdslvuhdTUS0rJuFJOBHkkip?=
 =?us-ascii?Q?c7vbbiP92nFJCYgb2CO9outlAvb9OWVgX7af8ymshw6Hjc91e3pVLNF/Qf7b?=
 =?us-ascii?Q?Z41VNs+IGi4FvUxHH2AG8vsNCMgoNtJYjd7IeszVfyGvU6b/eTyJ+b10UNAV?=
 =?us-ascii?Q?i9LBU4/C5jc9nDFeJd1db/Jo33c2ljXKbWgkyvISlMhRq9zip48SF6DvRsC2?=
 =?us-ascii?Q?4A/5u/gdxesrnJ0mDgWu4TCxKo6hm4lfjYOMjucm1nplyjev8efHSIrROo+C?=
 =?us-ascii?Q?AejYs/YNJSkw4Y2+EWH2waOLx3OU7v9WsK9M5Un0qCWaT+BLJJSWtg3El9lD?=
 =?us-ascii?Q?OasrfkO6PuNXjExOJzyOTE1tSHsi50K4xSo/oZojQZ7Vvgbgcf7nSe5efzGd?=
 =?us-ascii?Q?xr3BUTGrgw=3D=3D?=
X-Exchange-RoutingPolicyChecked: zKoabwhkiWV1kkmXrHsJCEBNrvoA0NNtTk51x13bTcPmLPSJ1fPFZIzbRB8wqkuQvVlkrJcs8e1ZicNIqT790hSYDKoPeLdbj2xDyxgUER/f0YKEzXq4nYGeg1QwllL3YrYOcQAAGYUlRrfoNGfRmJAkD0H6mumlfdjqCeG9mQv3fi2SnUrxCLOf170fPJ2wulmSfP1Z/6DlBK9Gp/h3x1IOwkGwbbG/pUFW6LR5nxkYpLdzKtGmgp/AkZfIdtE0vxMgQhbVK2wndHvveDSq2vIwDj/wQQvkKlJoFisGC55x0dZhqDY0NzH0ycOfZgvxrbuDxa+8KvyBCI7+R/E1cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa3cc86-2e32-4779-8157-08df3bfcac4c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:54:11.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajhUxdIk84o0rPOFe1TS/aGc+2FshgJF0d1GkD+6kx9QrfJ7O1gwamdNwcYVLzmk2xE/9VJ5m8v2MqyyV006V9iWbW6muXMTtO3Jhh42f/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF691668CDD
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

On Thu, Nov 05, 2026 at 09:47:19AM +0000, Anurag Mandal wrote:
> ice_dcf_init_parent_adapter() allocates a dummy main VSI
> first, but none of its error paths free it.
> 
> When ice_flow_init() fails, the error path also skips
> ice_flow_uninit(), so the DDP parser and any flow engine
> state set up before the failure are not released.
> 
> Free the main VSI on all error paths, and call
> ice_flow_uninit() when flow init fails.
> 
> Fixes: 0b02c9519432 ("net/ice: handle PF initialization by DCF")
> Fixes: 829c3106812d ("net/ice: enable switch flow on DCF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf_parent.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
